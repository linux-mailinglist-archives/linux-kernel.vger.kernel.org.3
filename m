Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5178A4EE786
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbiDAFIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiDAFH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:07:59 -0400
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Mar 2022 22:06:09 PDT
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 2616D25F678
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:06:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1648789568; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender:
 Sender; bh=l+7Y194RkHEDvlBRUE9dOX8hqW2hHbFhgCzQfGAyZwQ=; b=gRoRH1cLY05CwIS9RZg5qf2Ex3BIQ2c33jMdGISh7sEuJ1UvZzP8LYjPUHvjR9axgsG2UILy
 T+aNt66L+rnMmWH0SGxJvy1DZDhfKPcIlPwvIR6B1+O4X/zyzNKNHBfZqn/gqHLbdtX/KLRG
 97nGNqlKHdGhjwc6n4OjXF9MZ9wYWxUVEcs4xt7K/NiTD4O3QcalqXJ3oylghvixb9s3Xa+q
 vKr7kOKDBIRBy/lDPjkTUEl/ePnunTYMatmDLq0uynsP5UiKfP7pqgIszbvfrzpev5QY/coI
 Gm6g+TIsiy8p2UF5Lov+9tjH1oHyAXfZutHy+KptetvUiavcOYo11w==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from localhost.localdomain (dynamic-user.170.84.58.28.mhnet.com.br
 [170.84.58.28]) by smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 624687077afabd0707a01256 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Fri, 01 Apr 2022 05:00:55 GMT
Sender: codeagain@codeagain.dev
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     reg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Subject: [PATCH] staging: vme: Adjusted VME_USER in Kconfig
Date:   Fri,  1 Apr 2022 02:00:45 -0300
Message-Id: <20220401050045.3686663-1-codeagain@codeagain.dev>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the VME_USER driver is in the staging tree Kconfig, unlike
other VME drivers already moved to the main portions of the kernel tree.
Its configuration is, however, nested into the VME_BUS config option,
which might be misleading.

Since the staging tree "[...] is used to hold stand-alone[1] drivers and
filesystem that are not ready to be merged into the main portion of the
Linux kernel tree [...]"[1], IMHO all staging drivers should appear
nested into the Main Menu -> Device Drivers -> Staging Drivers to make
sure the user don't pick it without being fully aware of its staging
status as it could be the case in Menu -> Device Drivers -> VME bridge
support (the current location).

With this change menuconfig users will clearly know this is not a driver
in the main portion of the kernel tree and decide whether to build it or
not with that clearly in mind.

This change goes into the same direction of commit 4b4cdf3979c3
("STAGING: Move staging drivers back to staging-specific menu")

[1] https://lkml.org/lkml/2009/3/18/314

Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
---
 drivers/staging/Kconfig | 2 ++
 drivers/vme/Kconfig     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 932acb4e8cbc..0545850eb2ff 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -88,4 +88,6 @@ source "drivers/staging/qlge/Kconfig"
 
 source "drivers/staging/wfx/Kconfig"
 
+source "drivers/staging/vme/devices/Kconfig"
+
 endif # STAGING
diff --git a/drivers/vme/Kconfig b/drivers/vme/Kconfig
index 936392ca3c8c..c13dd9d2a604 100644
--- a/drivers/vme/Kconfig
+++ b/drivers/vme/Kconfig
@@ -15,6 +15,4 @@ source "drivers/vme/bridges/Kconfig"
 
 source "drivers/vme/boards/Kconfig"
 
-source "drivers/staging/vme/devices/Kconfig"
-
 endif # VME
-- 
2.35.1

