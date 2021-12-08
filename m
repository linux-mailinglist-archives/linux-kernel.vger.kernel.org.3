Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE82746D2F9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhLHMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhLHMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:11:40 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C7BC061746;
        Wed,  8 Dec 2021 04:08:09 -0800 (PST)
Received: from localhost.localdomain (unknown [IPv6:2a00:c281:1230:3700:51d0:7039:5913:64d3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9EC681F45C7B;
        Wed,  8 Dec 2021 12:08:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638965287; bh=L9d2/HDk7J7gj/gXjduUDMoRjsqJJjeSwDd7JPhOG9k=;
        h=From:To:Subject:Date:From;
        b=oBCBNfBpdFOfovUIiOFd2rS4JUzm/my5mfPfGW1At667YUHorYABd8psyv6pnFD7a
         cLP0FK+r4UZdQQUb6zi5p8/3TuVTpcnqsOuK7diMwO+zugLcxk99zRUWqwD+OLb5ro
         YFZBTw4Pxiay2V+kZdiUM9vUcF+kIQydtqtFzKROttPBmxb1UYGcZIg5sqXZgjNi2W
         EguiMMYdgfqF93sybRg/2X0YjFtFVZb/mcuy4T0y7M1wtP9H4N0QH1L2WJr6XqD7+r
         1k+HFC3//Oxdu2A0cOpIn+yw3Px4obMiw28qSROhcGyex/46Ee3yKUGAECDt4LW/zR
         /JnFyRLE+b6mQ==
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     iommu@lists.linux-foundation.org, Yong Wu <yong.wu@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org (moderated list:MEDIATEK IOMMU
        DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        dafna.hirschfeld@collabora.com, kernel@collabora.com,
        linux-media@vger.kernel.org, sebastian.reichel@collabora.com
Subject: [PATCH v2 0/5] iommu/mediatek: Fix tlb flush logic
Date:   Wed,  8 Dec 2021 14:07:39 +0200
Message-Id: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Often devices allocate DMA buffers before they do
runtime pm resume. This is the case for example with v4l2
devices where buffers are allocated during 'VIDIOC_REQBUFS`
and runtime resume happens later usually during 'VIDIOC_STREAMON'.
In such cases the partial tlb flush when allocating will fail
since the iommu is runtime suspended. This will print a warning
and try to do full flush. But there is actually no need to flush
the tlb before the consumer device is turned on.

Fix the warning by skipping partial flush when allocating and instead
do full flash in runtime resume.

In order to do full flush from the resume cb, the test:

if (pm_runtime_get_if_in_use(data->dev) <= 0)
	    continue;

needs to be removed from the flush all func since pm_runtime_get_if_in_use
returns 0 while resuming and will skip the flush


This patchset is a combination of 4 patches already sent in a different
patchset: [1] and a warning fix from Sebastian Reichel

[1] https://lore.kernel.org/linux-devicetree/20210923115840.17813-1-yong.wu@mediatek.com/

changes since v1:
-----------------

* Added preparation patches to remove the unneeded 'for_each_m4u' usage
and add a spinlock to protect access to tlb control registers.
* remove the pm runtime status check as explained above.
* refactor commit logs and inline doc
* move the call to full flush to the bottom of the resume cb after all registers are updated.


Sebastian Reichel (1):
  iommu/mediatek: Always check runtime PM status in tlb flush range
    callback

Yong Wu (4):
  iommu/mediatek: Remove for_each_m4u in tlb_sync_all
  iommu/mediatek: Remove the power status checking in tlb flush all
  iommu/mediatek: Add tlb_lock in tlb_flush_all
  iommu/mediatek: Always tlb_flush_all when each PM resume

 drivers/iommu/mtk_iommu.c | 42 ++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

-- 
2.17.1

