Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA04E5F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348356AbiCXHLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241560AbiCXHLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:11:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069DB97BB8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:10:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id qa43so7224612ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IN45MgxtWaRfpFlpfKUe4+VRGIjivM/4DTp3sJLsU/4=;
        b=ZGWRPQjImZea5J4l1+miHMp2VkmI8bMon5blENgAEZtH59PeX1lrclVTlN9ey45hTG
         nvCBZtoi2vurUaOLO9tON8ae9KCDaaPTumvj3/2eBFHH2CHYH9mqVwqxbRMbf7/HQfUa
         S7cXgvP1NOJBMvjdTKB0dm75CMTlBCxMoQJSe7mDk/RiOAYZWbToziU7EEIEtEhppGHI
         iN+cHgDK8X8VnuudYNulzVWdAAe/i0BGODqq0FH9xxiYFWV8MaLvwerkKxWjURTfrNDm
         d3Gb/KpUiwEZ2SKMF6NCu/bz8dyszxt/OnnQSXPOh7b1+RnQk/LICZ5H0J3aKi0I5piG
         B7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IN45MgxtWaRfpFlpfKUe4+VRGIjivM/4DTp3sJLsU/4=;
        b=nTRfsk7Ks+qfbu/UxKD8shV1MUoC1PW1I63w47TaOZtvY9V2IqO8tkXd+TcOKZPFyM
         gLrtRwvD+/b3GQi3i13mLiINC1yR52ejaeV+pnpVahUDkgp690weImrSVks+CIjPhPD+
         V3mdizHGl32WxN1sNXEh4zbBfEtuE/LYqAf8AelI7gx84iRJpBGUWNjp8PapyIZI2Zmf
         XcsESG5gzV1ljf+2DhFB0pJvV+yg5B/LMagUJCqWz4v/I6TMfHdzg0czEwue+7AQnlRx
         oOucjfHcyyh8ECvwh39toQcdfEnuCO3fRuNJmxLHQYE3lAq2RaRGrkwSftPHOwT0ORcA
         ZHHQ==
X-Gm-Message-State: AOAM532ePgxQ/kwRLN8qcJuuDkLPGNtisIUC/xPI7qEvxM8eJsfBRIft
        6k9heP5AjfHRrMIYkrMDee7D2+XCezfW4g==
X-Google-Smtp-Source: ABdhPJxqL1XOMNYqbzWPWVkaylmarCxByO5dsHWi2Hikj9Q9L6wpOkei4fY9CS4CNY+aTnxg5leEjA==
X-Received: by 2002:a17:907:a0c8:b0:6e0:7d03:3067 with SMTP id hw8-20020a170907a0c800b006e07d033067mr1646110ejc.609.1648105805766;
        Thu, 24 Mar 2022 00:10:05 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id c11-20020a056402120b00b004196059efd1sm971020edw.75.2022.03.24.00.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:10:05 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] char: xillybus: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:09:39 +0100
Message-Id: <20220324070939.59297-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/char/xillybus/xillybus_class.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
index 5046486011c8..0f238648dcfe 100644
--- a/drivers/char/xillybus/xillybus_class.c
+++ b/drivers/char/xillybus/xillybus_class.c
@@ -174,18 +174,17 @@ void xillybus_cleanup_chrdev(void *private_data,
 			     struct device *dev)
 {
 	int minor;
-	struct xilly_unit *unit;
-	bool found = false;
+	struct xilly_unit *unit = NULL, *iter;
 
 	mutex_lock(&unit_mutex);
 
-	list_for_each_entry(unit, &unit_list, list_entry)
-		if (unit->private_data == private_data) {
-			found = true;
+	list_for_each_entry(iter, &unit_list, list_entry)
+		if (iter->private_data == private_data) {
+			unit = iter;
 			break;
 		}
 
-	if (!found) {
+	if (!unit) {
 		dev_err(dev, "Weird bug: Failed to find unit\n");
 		mutex_unlock(&unit_mutex);
 		return;
@@ -216,22 +215,21 @@ int xillybus_find_inode(struct inode *inode,
 {
 	int minor = iminor(inode);
 	int major = imajor(inode);
-	struct xilly_unit *unit;
-	bool found = false;
+	struct xilly_unit *unit = NULL, *iter;
 
 	mutex_lock(&unit_mutex);
 
-	list_for_each_entry(unit, &unit_list, list_entry)
-		if (unit->major == major &&
-		    minor >= unit->lowest_minor &&
-		    minor < (unit->lowest_minor + unit->num_nodes)) {
-			found = true;
+	list_for_each_entry(iter, &unit_list, list_entry)
+		if (iter->major == major &&
+		    minor >= iter->lowest_minor &&
+		    minor < (iter->lowest_minor + iter->num_nodes)) {
+			unit = iter;
 			break;
 		}
 
 	mutex_unlock(&unit_mutex);
 
-	if (!found)
+	if (!unit)
 		return -ENODEV;
 
 	*private_data = unit->private_data;

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

