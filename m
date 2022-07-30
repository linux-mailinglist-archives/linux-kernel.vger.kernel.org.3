Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AAF585910
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 10:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiG3ING (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 04:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiG3IND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 04:13:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BE812D0B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 01:13:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y15so6411847plp.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 01:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jECHXeMew+vOg/w/7O3VXreVeRz+V2YGpSb4DCzDaqo=;
        b=fFoCMyLAcCgTgVrqsyURmjeCVzHAjdAaM1LflSR64Y3r4MVUbK3PsDzDMZD4otoYHs
         aX5XF2yXOHQtZxMAtUCfo02COetuBjoaCPCrlRcspir9eX8azJAN9Pfp1AwqAwpUtQT9
         gqQ+5sT3V/vF1K/hWpkLbB8pN+QmQDOlTRBjBaBi6JB0nMWSmwwezwTOSEDK15zVJcvj
         arWVpCBQa3OPm3/rpj9KwtoZe/PnlvsHbkxZrUgyPZb/JgNotNXnNdXevdGi0bO8FjmL
         tjEHHf5p/4IUz8NNsrfnXBrXKJmpXRheF809mXJYtuKysRI72LTIir+jb1HxzKhHjH4P
         zlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jECHXeMew+vOg/w/7O3VXreVeRz+V2YGpSb4DCzDaqo=;
        b=ahGNNgxNupLwe6I2C4IkLMalujsemucb9HWTxwk7oSEGQ0xdjYE3636+5aVy2l4ONa
         XBCtjHEskdEwXJ5noKpi8riDTa6DhOlV0xoARwHXL6g9Hjeob6vDcvZvR1q81k8QsrFB
         FCAbBRt94XHykyGaj3brxGl4aPXCo8YB5KwlRbXluH0zc8npxJZsVY7Wind0jHoP1Zh9
         r6shsFOZF4DEOEcMM6NS7SX0cPHV7lht/kxuwbbpBanrAe7hhbDSumzxLlrMOjfOpbdw
         drht00oIdPsFFEoYMUVU24qWR94O9nC7YYHUcta8Nw3iXfIHnwbtDAO2Kpj8aiOyA4So
         dRrA==
X-Gm-Message-State: ACgBeo3vHKWHSQFjc5KSH4iOsGynp8FeBIo4Js9MBHQ9lrZsa30GRFZG
        FoZXWwVtLmrrJusfIqbZo2HzrKx543M=
X-Google-Smtp-Source: AA6agR7AueL3IjF+YpbdpZU+/VwMFkt/HDQI92m4W/r9qVdfqYI8HG9lx+5SE5O97iQku9sbT/penw==
X-Received: by 2002:a17:902:b58e:b0:16c:489e:7a0b with SMTP id a14-20020a170902b58e00b0016c489e7a0bmr7343888pls.145.1659168782079;
        Sat, 30 Jul 2022 01:13:02 -0700 (PDT)
Received: from fedora.. ([103.230.107.59])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902d54100b0016bf4428586sm4947944plf.208.2022.07.30.01.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 01:13:01 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com
Cc:     khalid.masum.92@gmail.com, khalid.masum@aol.com
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in imageblit (2)
Date:   Sat, 30 Jul 2022 14:12:46 +0600
Message-Id: <20220730081246.4567-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <000000000000bbdd0405d120c155@google.com>
References: <000000000000bbdd0405d120c155@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the if block's condition has an unhandled case, where the
result of ret might get greater than vc->vc_scr_end, and therefore
the corresponding handler in else block never gets executed. Which
eventually causes panic in fast_imageblit.

Add this extra check in the conditions to fix this breakage.

#syz-test: https://github.com/torvalds/linux.git e0dccc3b76fb 

---
 drivers/video/fbdev/core/fbcon.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 1a9aa12cf886..d026f3845b60 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2591,14 +2591,13 @@ static unsigned long fbcon_getxy(struct vc_data *vc, unsigned long pos,
 {
 	unsigned long ret;
 	int x, y;
+	unsigned long offset = (pos - vc->vc_origin) / 2;
+	x = offset % vc->vc_cols;
+	y = offset / vc->vc_cols;
+	ret = pos + (vc->vc_cols - x) * 2;
 
-	if (pos >= vc->vc_origin && pos < vc->vc_scr_end) {
-		unsigned long offset = (pos - vc->vc_origin) / 2;
-
-		x = offset % vc->vc_cols;
-		y = offset / vc->vc_cols;
-		ret = pos + (vc->vc_cols - x) * 2;
-	} else {
+	if (!pos >= vc->vc_origin || !pos < vc->vc_scr_end ||
+	                             !ret < vc->vc_scr_end) {
 		/* Should not happen */
 		x = y = 0;
 		ret = vc->vc_origin;
-- 
2.36.1

