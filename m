Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D7553A5A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353115AbiFANIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245269AbiFANIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:08:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2391580F;
        Wed,  1 Jun 2022 06:08:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h23so2659025lfe.4;
        Wed, 01 Jun 2022 06:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ysIJYl13aRlLMw9IPUXDzBeV3KCUBiCmG2+wGOlmHo=;
        b=XxTcLqnXWxtfzufWQrrtcmf2KI1UVqAdPX9YAicWmeyYnf3pIFibSAyGax4hflFFzx
         UTUxf6VqqNp7pj6YSMRh+bj1o3XK0iWcr/bDdMHCnk2yHLtZjHxlq7NLWaRc+T0wucj7
         FZ7CQxDlLccUps2bq/UWuBVRZwb/6sEKmkOwWSmjC/EIAuOe8kb4PumBSOBBmn2pgLrv
         YVGULob2g5+8GQNCSNUiconc8YvzjYkVvpRqEXak1QmUQkGAiTguiTeuQTDph6RZiqUH
         q532kzTF0onEAtqgP20XBMuJhqjQBm7FJfSriVnyjK2f5YS1oa6qizHLPn0H6eddkLF4
         33gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ysIJYl13aRlLMw9IPUXDzBeV3KCUBiCmG2+wGOlmHo=;
        b=WArxBftEXQXYbpxHEKoyNPlDMkPkcD0Kx5zaiwOiw4ZaK4gDlj4C+AE1QMSkp5+h8Q
         XU3PP38stnok6k6lMWbzO0BFCM2g4yXxue6Sjjy7oggNeA3nkUvWylpia7bv2WKZcAg4
         x/2jJrnavUlsF6GiYYIAnZGui5BkjrkJYh3RVC0IWNOs1oNSAHZz2c1Rivuk46epbSJB
         VSDS9i1WBlJhCGzt4YI11M31k1bWz35Pt4BN7Q3OdCEED7Fb6RV8LdK8PN/j57oc0QlQ
         AD/pxxFdQtC4nknSmb1xReODX/KM9FnoVfrykVvYehKL0YajoVIzZjy2ca2/Q6qkyQs/
         RL7A==
X-Gm-Message-State: AOAM5313V2iuM3+QFC65tqUqsnzjZilEVJqSFoQI86FwTLOAY/Ewj1/E
        61Mndt74gwlTpFJH14S5nD43KVWaFLOGFA==
X-Google-Smtp-Source: ABdhPJz0bbUbPS/qEfNkuoBVAWK+BWb64uElH7mN424dfb4NVpAHOQnii4oNpTWZ5Wnnj5HUUDIyzQ==
X-Received: by 2002:a05:6512:31d6:b0:478:84d8:5844 with SMTP id j22-20020a05651231d600b0047884d85844mr32381773lfe.382.1654088909250;
        Wed, 01 Jun 2022 06:08:29 -0700 (PDT)
Received: from localhost.localdomain (81-231-252-146-no39.tbcn.telia.com. [81.231.252.146])
        by smtp.gmail.com with ESMTPSA id a27-20020a056512201b00b00478641f62c0sm366956lfb.28.2022.06.01.06.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 06:08:28 -0700 (PDT)
From:   Isak Ellmer <isak01@gmail.com>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Isak Ellmer <isak01@gmail.com>
Subject: [PATCH] scripts: kconfig: nconf: make nconfig accept jk keybindings
Date:   Wed,  1 Jun 2022 15:08:19 +0200
Message-Id: <20220601130819.11171-1-isak01@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make nconfig accept jk keybindings for movement in addition to arrow
keys.

Signed-off-by: Isak Ellmer <isak01@gmail.com>
---
 scripts/kconfig/nconf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 7b371bd7fb36..3ba8b1af390f 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -52,8 +52,8 @@ static const char nconf_global_help[] =
 "\n"
 "Menu navigation keys\n"
 "----------------------------------------------------------------------\n"
-"Linewise up                 <Up>\n"
-"Linewise down               <Down>\n"
+"Linewise up                 <Up>    <k>\n"
+"Linewise down               <Down>  <j>\n"
 "Pagewise up                 <Page Up>\n"
 "Pagewise down               <Page Down>\n"
 "First entry                 <Home>\n"
@@ -1105,9 +1105,11 @@ static void conf(struct menu *menu)
 				break;
 			switch (res) {
 			case KEY_DOWN:
+			case 'j':
 				menu_driver(curses_menu, REQ_DOWN_ITEM);
 				break;
 			case KEY_UP:
+			case 'k':
 				menu_driver(curses_menu, REQ_UP_ITEM);
 				break;
 			case KEY_NPAGE:
@@ -1287,9 +1289,11 @@ static void conf_choice(struct menu *menu)
 				break;
 			switch (res) {
 			case KEY_DOWN:
+			case 'j':
 				menu_driver(curses_menu, REQ_DOWN_ITEM);
 				break;
 			case KEY_UP:
+			case 'k':
 				menu_driver(curses_menu, REQ_UP_ITEM);
 				break;
 			case KEY_NPAGE:
-- 
2.35.1

