Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDAE5ABD2D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 07:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiICFL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 01:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiICFLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 01:11:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD58769F77;
        Fri,  2 Sep 2022 22:11:23 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h188so3606408pgc.12;
        Fri, 02 Sep 2022 22:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=mokK5Rr1KUt2vurzyDRQ+VKzKOENPW5x08AOXPXhhpo=;
        b=omygZnV2IE1nt8vp1ZM48uqVo5EEgyjXtEkQ8cZV3+RcFrzTLZKigMjGG1FBLeV+xc
         BMleZUr2C5X9F2m6XQgN8pIj1LWFzyPQ4lwxF6SGjm9qTZr0/jcTqHi8Gam5qc/DVPxW
         xUehlCaK1fqwRGYLwfGHXABDTJHbEj1ACBZ28ZvOn/cXwGRv4+/7ZjYa3Bm4Z+P0vHnX
         i0F5HmGgnsw0ABxPacUa9829zuejQ8Gl8ZK8KNcdC/JUzsXyITJ0UcptUENnfGTceflj
         ZCFX3UhUGBo91J7gpFmQvx7KFupcvXNWK3QpCiFTLAAMa7ehlmd8t0V9EYG2ZNVjeoB/
         mfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=mokK5Rr1KUt2vurzyDRQ+VKzKOENPW5x08AOXPXhhpo=;
        b=m5qhY49b5jzSvnSDNxCbeRPHB9aqmlNYvfg3+1IlAnZVxU5vecxK5yJiNxA3BOxBb5
         1ER6DFssF9om2iq8WuE/uz/Aqq3llPZbCM9ohyHNAwnrHDCwiYPQhqfj2knTS5FwsWtg
         9PWEIllmsk6qKpEDCGAOunQH8Lnntarhz5fNrn+x2quprZ9YiEAC5tDFJzOdHuJVHy20
         nenvOat4JHly2NSoJz4L4YZpSuXDtyqRdlhgKBB5SSXZP8plBJ64oCC+2CTRu6ruOqGO
         NYnV9IC1BKaYbwhKnUzQYm2MFdN7VbiNxPXa8i0/9JjmvoAqdaeQ5babO2814BJZgKno
         hMKw==
X-Gm-Message-State: ACgBeo2ttCkx/18UBH2WYEAY2nVWjOjqx6UvCCznyY5mvPzbqSlVFwJI
        +fk4Tw899Ffiu5p27UuYFuMNOQQ6KIk=
X-Google-Smtp-Source: AA6agR7i79NcTqYMdpPqG4vaKBiajtvObqm9/WCqk/mWiWi5FzLglbOdscM0Rr3BK/8eqKLMwos9zw==
X-Received: by 2002:a63:6cc4:0:b0:41a:ff04:661f with SMTP id h187-20020a636cc4000000b0041aff04661fmr33231045pgc.600.1662181882937;
        Fri, 02 Sep 2022 22:11:22 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:ea21:afd4:e65e:539c])
        by smtp.gmail.com with ESMTPSA id u1-20020a632341000000b0042a6dde1d66sm719571pgm.43.2022.09.02.22.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 22:11:22 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Input: atkbd - switch to using dev_groups for driver-specific attributes
Date:   Fri,  2 Sep 2022 22:11:17 -0700
Message-Id: <20220903051119.1332808-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core now has the ability to handle the creation and removal
of device-specific sysfs files, let's use it instead of registering and
unregistering attributes by hand.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/atkbd.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index d4131236d18c..246958795f60 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -323,11 +323,13 @@ static umode_t atkbd_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
-static struct attribute_group atkbd_attribute_group = {
+static const struct attribute_group atkbd_attribute_group = {
 	.attrs	= atkbd_attributes,
 	.is_visible = atkbd_attr_is_visible,
 };
 
+__ATTRIBUTE_GROUPS(atkbd_attribute);
+
 static const unsigned int xl_table[] = {
 	ATKBD_RET_BAT, ATKBD_RET_ERR, ATKBD_RET_ACK,
 	ATKBD_RET_NAK, ATKBD_RET_HANJA, ATKBD_RET_HANGEUL,
@@ -922,8 +924,6 @@ static void atkbd_disconnect(struct serio *serio)
 {
 	struct atkbd *atkbd = serio_get_drvdata(serio);
 
-	sysfs_remove_group(&serio->dev.kobj, &atkbd_attribute_group);
-
 	atkbd_disable(atkbd);
 
 	input_unregister_device(atkbd->dev);
@@ -1271,21 +1271,16 @@ static int atkbd_connect(struct serio *serio, struct serio_driver *drv)
 	atkbd_set_keycode_table(atkbd);
 	atkbd_set_device_attrs(atkbd);
 
-	err = sysfs_create_group(&serio->dev.kobj, &atkbd_attribute_group);
-	if (err)
-		goto fail3;
-
 	atkbd_enable(atkbd);
 	if (serio->write)
 		atkbd_activate(atkbd);
 
 	err = input_register_device(atkbd->dev);
 	if (err)
-		goto fail4;
+		goto fail3;
 
 	return 0;
 
- fail4: sysfs_remove_group(&serio->dev.kobj, &atkbd_attribute_group);
  fail3:	serio_close(serio);
  fail2:	serio_set_drvdata(serio, NULL);
  fail1:	input_free_device(dev);
@@ -1378,7 +1373,8 @@ MODULE_DEVICE_TABLE(serio, atkbd_serio_ids);
 
 static struct serio_driver atkbd_drv = {
 	.driver		= {
-		.name	= "atkbd",
+		.name		= "atkbd",
+		.dev_groups	= atkbd_attribute_groups,
 	},
 	.description	= DRIVER_DESC,
 	.id_table	= atkbd_serio_ids,
-- 
2.37.2.789.g6183377224-goog

