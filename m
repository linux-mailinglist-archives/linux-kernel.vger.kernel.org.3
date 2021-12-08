Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A39346D0B6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhLHKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhLHKRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:17:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE105C061746;
        Wed,  8 Dec 2021 02:13:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 45E09CE20CD;
        Wed,  8 Dec 2021 10:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73874C00446;
        Wed,  8 Dec 2021 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638958410;
        bh=kWQ40vfL3wH4zPxl49suszkjwCKdZFC5bs+JG/CuIw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYXfvlOqkRCprdL6cg/7TZ/YO6Pv0yzwtUtDj/HjgXGo8O3i5UZk41ELs7+9LJ+y2
         LQtRFIeYmPVXcT6a+sP4Kang+B+Abt8Hlk//NH4L2NykBLDC4Eddha23KrVvBt6jNU
         R9PxYGHUx2hBHj3W6K/rY6WhvXTPaxKs6+ptD5c5lbRjMoR4KyCZNybhSFf04GYfgo
         J4BNQNO0EQ47trmdj+qRurUw1dPSDKPtgeyOCM2MW4gXv5JBOU78IE8Cn83KnIxG1w
         ZnALB3r7Im81c5dGddxw4o88kYDEeChR+f2ijWWqOGbkks4V/ny3Hqzx0NiRn31lXV
         Pa+bA9/Hv4yhQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mutx2-00BgVD-C2; Wed, 08 Dec 2021 11:13:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 0/3] media: si2157: rework firmware load logic
Date:   Wed,  8 Dec 2021 11:13:23 +0100
Message-Id: <cover.1638958050.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211206150055.43043b53@coco.lan>
References: <20211206150055.43043b53@coco.lan>
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

Robert,

This was compile-tested only. Could you please test it on your device?

Mauro Carvalho Chehab (2):
  media: si2157: move firmware load to a separate function
  media: si2157: rework the firmware load logic

Robert Schlabbach (1):
  media: si2157: Add optional firmware download

 drivers/media/tuners/si2157.c | 120 +++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 45 deletions(-)

-- 
2.33.1


