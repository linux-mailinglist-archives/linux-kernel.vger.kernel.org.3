Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C52949655D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiAUTBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:01:02 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:40457 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiAUTBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:01:00 -0500
Received: by mail-qt1-f177.google.com with SMTP id k2so1908955qtm.7;
        Fri, 21 Jan 2022 11:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qcTWtImjSv/IKa8U1ZDMasjCJ9CJxcj4OoduIWlDcq4=;
        b=r8Fkw+6VZF5dqczKzD2/VW/6mNTo0d5w+TieMs9hCNS0v/MWtW46bzETpXe8a2WjdN
         AaZkfKrrlVQpwzA3WRi8KnVJIYVaiAxpxLsAk17sFSKr2OOf5hG1hXRo/a1yfoxqdt5r
         6Cd3nQS+sn2EYyU81sP/6OEb6jq8wb8a7x6KtihNy1jZPFGZEy1QjmpaMcmkhQKJs1Ta
         ZPyb5q66/KHO41fCGxZw2dcfnNP/+vRAN/hGPnkenVjAeGIji9tmnByAL1UZ/dHyNda8
         DhPh+l2iY7lNM3XM0aoMwgoN958YSXsBHMIESQxgh0UWrQDgUadrvAMxN/kxZNEM55e3
         zJVw==
X-Gm-Message-State: AOAM530Zlo5ggIbcVipxt/4Xd8Mc/0FDy59yqiS1gaes0ipyOMVRP27c
        VwIQhHTiCcoJ0tapZeUdaE3jL091Nxbem+Or+Sk=
X-Google-Smtp-Source: ABdhPJyuCR+SmirJdSiW2AywJ+r5kBb0SMVoSkmDQY+lIDivISAXiLXa1FRk8dJkdQNCEpV3MKOA4Ik2GJyMfvyLmAk=
X-Received: by 2002:a05:622a:293:: with SMTP id z19mr4389219qtw.302.1642791660062;
 Fri, 21 Jan 2022 11:01:00 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Jan 2022 20:00:49 +0100
Message-ID: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
Subject: [Bug] nvme blocks PC10 since v5.15 - bisected
To:     Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        m.heingbecker@googlemail.com,
        linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

It is reported that the following commit

commit e5ad96f388b765fe6b52f64f37e910c0ba4f3de7
Author: Keith Busch <kbusch@kernel.org>
Date:   Tue Jul 27 09:40:44 2021 -0700

   nvme-pci: disable hmb on idle suspend

   An idle suspend may or may not disable host memory access from devices
   placed in low power mode. Either way, it should always be safe to
   disable the host memory buffer prior to entering the low power mode, and
   this should also always be faster than a full device shutdown.

   Signed-off-by: Keith Busch <kbusch@kernel.org>
   Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
   Signed-off-by: Christoph Hellwig <hch@lst.de>

is the source of a serious power regression occurring since 5.15
(please see https://bugzilla.kernel.org/show_bug.cgi?id=215467).

After this commit, the SoC on the affected system cannot enter
C-states deeper than PC2 while suspended to idle which basically
defeats the purpose of suspending.

What may be happening is that nvme_disable_prepare_reset() that is not
called any more in the ndev->nr_host_mem_descs case somehow causes the
LTR of the device to change to "no requirement" which allows deeper
C-states to be entered.

Can you have a look at this, please?

Cheers,
Rafael
