Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AA9589BD1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbiHDMl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbiHDMlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:41:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E972B188;
        Thu,  4 Aug 2022 05:41:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b4so9247937pji.4;
        Thu, 04 Aug 2022 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CCsyUyjtcxiqdAio61EdLoryAiVvM5FMmKPvH5Lk+7M=;
        b=p5VexO3soXHRkRquHKXZkC8JYq5rp2/+hH5cdP/9ybw6xveovaMm7vq9DULzixLiIm
         2zQcITt0lDLza3JpyfTFtjiOf0ZjmkAYHl4dKyTmQHDnE5c264USvOJ3qUjPd8re+1o7
         zMBGJm0vtdWGJhS35PJZI4FYub9oNCtlU5UqZpszGvlk3jzNvYf6EHshWdYWHXhjPxW/
         hLb7yHDT1MRtKEEJgwiC1xcwkMDg6y7w4BivcoGWlgniNUlUueoeqLrT4pMYt0A0z4+G
         UnV3o+nvdprd6/CrmPtNzyvie7pw4bPdGQYISWpnMsWAxhHFAoD+J5qGzNQVecUS11rp
         fYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CCsyUyjtcxiqdAio61EdLoryAiVvM5FMmKPvH5Lk+7M=;
        b=eDHr/FFsIxqaf/DjBTtQDZvLT01o3pP2SEJ/ReZHSavgBH/B9dM/7a6L5O/XriSq2K
         5XRV1JzfRtvBEmpXeUpP1T85yF93vaJVW1NoKAP1rbW3LuwhFa+plzgLPRvBKUiVPYcs
         /vSu/i4diOBw03dxPhpWESdhsRVtjtaEFmeMtiOI8XKtPio/bo+tiT+GKhN767wIkAj7
         HrGx8iya/Xldf0DE00ARMcjirPA++FT4JwIcZOXEg3sV7+j5AwU07eobVddUh+rSedqs
         OGjYW2NEXL4zluiZyxocL1xl1+mDBMUJehMhzO2Lco+wvHXvfdp8nIbcqKWR8B9E2r6H
         pYng==
X-Gm-Message-State: ACgBeo11c+6WLoLY9RcTje3W9O1qSuU6sbP63cUP5Y+yfMxEkGmd8Xxy
        v+S2tll+EtuQstNnJAbrbA==
X-Google-Smtp-Source: AA6agR4X8s+bYDtMYD6EK98FWif6GTdlWCPPlzexQu4yKAsAh28bchh+1VCurElhJCelSbWYzUEB1g==
X-Received: by 2002:a17:90a:fc91:b0:1f3:1f3a:54d5 with SMTP id ci17-20020a17090afc9100b001f31f3a54d5mr2006808pjb.74.1659616907801;
        Thu, 04 Aug 2022 05:41:47 -0700 (PDT)
Received: from localhost.localdomain ([166.111.133.51])
        by smtp.gmail.com with ESMTPSA id i8-20020a63bf48000000b0041b672e93c2sm1070769pgo.17.2022.08.04.05.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 05:41:47 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     deller@gmx.de, adaplas@gmail.com, santiago@crfreenet.org,
        akpm@linux-foundation.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 2/3] video: fbdev: arkfb: Check the size of screen before memset_io()
Date:   Thu,  4 Aug 2022 20:41:24 +0800
Message-Id: <20220804124125.3506755-3-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804124125.3506755-1-zheyuma97@gmail.com>
References: <20220804124125.3506755-1-zheyuma97@gmail.com>
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

In the function arkfb_set_par(), the value of 'screen_size' is
calculated by the user input. If the user provides the improper value,
the value of 'screen_size' may larger than 'info->screen_size', which
may cause the following bug:

[  659.399066] BUG: unable to handle page fault for address: ffffc90003000000
[  659.399077] #PF: supervisor write access in kernel mode
[  659.399079] #PF: error_code(0x0002) - not-present page
[  659.399094] RIP: 0010:memset_orig+0x33/0xb0
[  659.399116] Call Trace:
[  659.399122]  arkfb_set_par+0x143f/0x24c0
[  659.399130]  fb_set_var+0x604/0xeb0
[  659.399161]  do_fb_ioctl+0x234/0x670
[  659.399189]  fb_ioctl+0xdd/0x130

Fix the this by checking the value of 'screen_size' before memset_io().

Fixes: 681e14730c73 ("arkfb: new framebuffer driver for ARK Logic cards")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/arkfb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index eb3e47c58c5f..de4002914f9e 100644
--- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -792,6 +792,8 @@ static int arkfb_set_par(struct fb_info *info)
 	value = ((value * hmul / hdiv) / 8) - 5;
 	vga_wcrt(par->state.vgabase, 0x42, (value + 1) / 2);
 
+	if (screen_size > info->screen_size)
+		screen_size = info->screen_size;
 	memset_io(info->screen_base, 0x00, screen_size);
 	/* Device and screen back on */
 	svga_wcrt_mask(par->state.vgabase, 0x17, 0x80, 0x80);
-- 
2.25.1

