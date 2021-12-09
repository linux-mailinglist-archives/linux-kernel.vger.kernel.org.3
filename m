Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE47546E7B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhLILow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbhLILor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:44:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55CAC0617A1;
        Thu,  9 Dec 2021 03:41:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D5DADCE2559;
        Thu,  9 Dec 2021 11:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23E8C004DD;
        Thu,  9 Dec 2021 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639050070;
        bh=Gw8hul315R38gDsO++4VgMLsyKnrpVDHF370/aVv1kw=;
        h=From:To:Cc:Subject:Date:From;
        b=ei0o5SjxXizfHbKeMmul2BFN0Hn9s1UvTJYjK4xMtVVDABBGyTdLaJ4IDAH5NT04M
         Gm4rDtZV1QWazz+aj0C3JHC+UNv7yt8TMQX6Zuoh2p3njBZgPjH5HQ6mkID7Mdfh0b
         LU46/jpc9MzSwfQrrM1wHEpmMtEuyPoGn+u7jCVBQ5yfULno3tqCR/P+HpuDzppmn9
         Kmv1Apr7yO/Lk7cFt0WovXuqa7vZN3sDbm6kNtxa7fHmEwhqpuSfn6IAXjKWeZTzRI
         VZ6p+lw8OQG7KSbYB4kxOp2BKobb/g7lbx9kLN926s3AujogOfV96q+0i76YrhBFh2
         0iB18f88P7aJg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvHnP-00BuP3-QH; Thu, 09 Dec 2021 12:41:07 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Robert Schlabbach <robert_s@gmx.net>
Subject: [PATCH v2 0/4] media: si2157: rework firmware load logic
Date:   Thu,  9 Dec 2021 12:41:03 +0100
Message-Id: <cover.1639049865.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed bt Robert, if there's already a firmware for si2157 at
/lib/firmware, it is preferred to use it, instead of the default firmware.

Yet, when this is missed, the driver may still work. That's the case,
for instance, of the devices explicitly flagged with dont_load_firmware
(currently, Terratec Cinergy TC2).

So, rework the firmware logic in a way that it will emit a warning for
devices that are using the eeprom firmware and may not work well
with it.

Compile-tested only.

Robert,

Could you please test it on your devices?

--

v2:
 - added a patch to allow supporting different firmwares depending on
   the device's reported ROM ID.
   
Mauro Carvalho Chehab (3):
  media: si2157: move firmware load to a separate function
  media: si2157: rework the firmware load logic
  media: si2157: use a different namespace for firmware

Robert Schlabbach (1):
  media: si2157: Add optional firmware download

 drivers/media/tuners/si2157.c      | 248 +++++++++++++++++------------
 drivers/media/tuners/si2157_priv.h |  14 ++
 2 files changed, 163 insertions(+), 99 deletions(-)

-- 
2.33.1


