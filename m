Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1770589BCC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbiHDMlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiHDMlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:41:47 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFCB3205A;
        Thu,  4 Aug 2022 05:41:45 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 12so17863333pga.1;
        Thu, 04 Aug 2022 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=w0Xxsd10rxzXzo6/5gdWcIy61xCxC4G1bz1u1E9fXCo=;
        b=qD8j7MqqhHWzCEXuJN+GpeSzUdlAxRyaiur92DU6at98u5tgv2exchm9KnIJRPGGwS
         4RgMLhbFh/yr8Q5O4ECnkUGj9S8gVPjiXPm2LAFsx62EZjdxCo/OrIO5X5UEUWZsK5PU
         UJFOkziuTiJVtruzn+BZy2AXNBM9tOueP9AeUKB8Os84d2OHraomImWx0uk3mxj4ocS9
         yt97Dn5UzB1sUM9GM90TBP/DX0MFg4Jas3MDnu477/0yYH7Q8QAuxZGpZ0l1JAg0BiAr
         f1sP+x3t5jzGDNAbbDywp0l0mt82aC4dm5lR37ou1KVyg69+j4Q+f6p4AxwrxFDJ3bHw
         8OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=w0Xxsd10rxzXzo6/5gdWcIy61xCxC4G1bz1u1E9fXCo=;
        b=WDF3klEnKUm4HXOPV8XktOXTkjLHfohs84MJffvV75wcTfElTMfDSMzmr6lvoaMads
         2zO7QWfg/r3e8wldVIrffJO+yq9pnL6ogrKneRll71mbliS2i/ydeJRW4YVdvzZtzNQl
         oyiKSZDTf7hzwNk4oWJpQwvYnzJSwVVKzfGFgYZCz/u7lKlLRAGhACV4Q+0/r8gGODsR
         Eu0aQDd8QQfa+97uReqZ3c26iLVTNJLsTXc2+O+9TQYCnJYZR/47XknSzHDUQIWREmCS
         Vl1pJsng5ccsF2LHKrsXkblWVH8p6NnCxjHN1BXBU8dRyd4x0j9NmvvTGvB6SfoPqtZC
         Yo7A==
X-Gm-Message-State: ACgBeo0V4BJvoK5TdxcVQcKOAN6Vj5dQqL57wn49Lo6fJMFrU874QFp3
        R86L1JCA0wLVjL58u1Srpw==
X-Google-Smtp-Source: AA6agR5DWlGw0W1xZXujx2KGDv9sHfvTIt+iTdErPfZLMXgRlBBtcYlNDb72wX2TK2CqsJhy7Jwogw==
X-Received: by 2002:a63:1658:0:b0:41a:4118:f4b9 with SMTP id 24-20020a631658000000b0041a4118f4b9mr1497090pgw.153.1659616904598;
        Thu, 04 Aug 2022 05:41:44 -0700 (PDT)
Received: from localhost.localdomain ([166.111.133.51])
        by smtp.gmail.com with ESMTPSA id i8-20020a63bf48000000b0041b672e93c2sm1070769pgo.17.2022.08.04.05.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 05:41:44 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     deller@gmx.de, adaplas@gmail.com, santiago@crfreenet.org,
        akpm@linux-foundation.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 1/3] video: fbdev: vt8623fb: Check the size of screen before memset_io()
Date:   Thu,  4 Aug 2022 20:41:23 +0800
Message-Id: <20220804124125.3506755-2-zheyuma97@gmail.com>
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

In the function vt8623fb_set_par(), the value of 'screen_size' is
calculated by the user input. If the user provides the improper value,
the value of 'screen_size' may larger than 'info->screen_size', which
may cause the following bug:

[  583.339036] BUG: unable to handle page fault for address: ffffc90005000000
[  583.339049] #PF: supervisor write access in kernel mode
[  583.339052] #PF: error_code(0x0002) - not-present page
[  583.339074] RIP: 0010:memset_orig+0x33/0xb0
[  583.339110] Call Trace:
[  583.339118]  vt8623fb_set_par+0x11cd/0x21e0
[  583.339146]  fb_set_var+0x604/0xeb0
[  583.339181]  do_fb_ioctl+0x234/0x670
[  583.339209]  fb_ioctl+0xdd/0x130

Fix the this by checking the value of 'screen_size' before memset_io().

Fixes: 558b7bd86c32 ("vt8623fb: new framebuffer driver for VIA VT8623")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/vt8623fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8623fb.c
index a92a8c670cf0..4274c6efb249 100644
--- a/drivers/video/fbdev/vt8623fb.c
+++ b/drivers/video/fbdev/vt8623fb.c
@@ -507,6 +507,8 @@ static int vt8623fb_set_par(struct fb_info *info)
 			 (info->var.vmode & FB_VMODE_DOUBLE) ? 2 : 1, 1,
 			 1, info->node);
 
+	if (screen_size > info->screen_size)
+		screen_size = info->screen_size;
 	memset_io(info->screen_base, 0x00, screen_size);
 
 	/* Device and screen back on */
-- 
2.25.1

