Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA27A5280D2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiEPJYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiEPJYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:24:45 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAB7286E9;
        Mon, 16 May 2022 02:24:43 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m23so17382501ljc.0;
        Mon, 16 May 2022 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z7SVVP/oC8iSudRPuuLzmqr3tHRZCL2jrSL6ZB0fSOU=;
        b=lJue4HZt/225QfsuUkRTSvHYS5Cbg3mp+Lpr9wUcZw7loJcdma/LoRNWTuYqIl1GbL
         PCEFtvcIfGi1zIDzClS9SlFOnTPbno0eL4lPtB+WSG2FcdAIWqqJHAcVNWpTfShSC2r5
         iKbFrRtscXD8b0XuKDb+TlCueomIWLfj9bvlummAjUJs90IJ/Hd1e+YpN1MES50jUipz
         c/Sni45fE53n5BQtCLxEh1Sdw2M+kOhGY710ghZRkRIU1CuVDeFeTxOzNXDrSLMONVnH
         ANcVAzhPPU032K+CZAHtg5RHB+P78ZyjVDNpIb81RtqcePbRZQltRCzrWqptCynWdRv3
         ddog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z7SVVP/oC8iSudRPuuLzmqr3tHRZCL2jrSL6ZB0fSOU=;
        b=AhtcAgtJbZU/keMFCxq9J9uGlPXss+dLvdELSStCd2ti1hc08pqbzuOnTU+WjtrHag
         o4Za4TwQFBPEgcTf8G04NjrWtL5WN4Tx5SKwidaFac3nNCo0KVh+SA8Bq3RpmZ7MAJrX
         VWLAGy0jLjYPNGQ2JDViHwrF6jZ+e72e7bndlBJbQ4U5vouBdXslP6EDFYI6iwylBaQc
         cWUqumUvDugQ58No2Dn5J8MXB4xkxxHA9OZHO5s7O+4IAmzERIpzdApyc2CVrwZROXEb
         ICVzMfU5K3FE2HqyvuZxOm29ytHGFdYH2qoxwdmunrQ/W3tGkOkYYMtKfnFJJpx1O3uQ
         3CPA==
X-Gm-Message-State: AOAM530FysvN+gtxlzsM216m2sckva5csd5pfbCaL66RghOotr+E7GLQ
        5bEvC2/Bbmsib59Xka6JsvIomrPSvV6YgoQH
X-Google-Smtp-Source: ABdhPJzoYNjvZDXsDHxWNAIeb11uNTP0eP24NR050plG37dSFPwxbVnz75RZ7RT0JGIZIO0LUtD+sQ==
X-Received: by 2002:a2e:878d:0:b0:24f:2bf2:5a79 with SMTP id n13-20020a2e878d000000b0024f2bf25a79mr10947871lji.497.1652693081939;
        Mon, 16 May 2022 02:24:41 -0700 (PDT)
Received: from localhost.localdomain (81-231-252-146-no39.tbcn.telia.com. [81.231.252.146])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24e97000000b0047255d2118asm1251739lfr.185.2022.05.16.02.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 02:24:41 -0700 (PDT)
From:   Isak Ellmer <isak01@gmail.com>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Isak Ellmer <isak01@gmail.com>
Subject: [PATCH] scripts: kconfig: nconf: make nconfig accept jk keybindings
Date:   Mon, 16 May 2022 11:24:23 +0200
Message-Id: <20220516092423.14327-1-isak01@gmail.com>
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

Make nconfig accept jk keybindings for movement in addition to arrow keys.

Signed-off-by: Isak Ellmer <isak01@gmail.com>
---
 scripts/kconfig/nconf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 7b371bd7fb36..ded40e5aabf8 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
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

