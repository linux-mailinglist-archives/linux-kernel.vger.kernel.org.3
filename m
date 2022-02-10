Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1DB4B1A11
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346049AbiBKAG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:06:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiBKAGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:06:55 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DAE26DF;
        Thu, 10 Feb 2022 16:06:55 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id bs32so6716113qkb.1;
        Thu, 10 Feb 2022 16:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kIxNsx5t66aCekxGiYnzItzLDmvgCurjGzLHlKM8kmo=;
        b=kUPI1caTAiBqAVK3q8DnKRacUz2Uib6Hme9P7gr7i8kQ+e8TDEJqGlFb9zgPToD7X4
         N+9XO0XYP2mYbZz74uZ8ryyWvq1dnX9hrT17tCXcrSr4PANCJ/G0mRpk/gSmP6hwaIA4
         tSW8lv3cVv4eh0Fc3r/J6QFoUcItqKb2tIQyxE/nf7iYijX6DS2RQXFJKqGgFPMhUCS9
         Dqf5xuMhdzQRvnaBkiEGdwqac4utkIFoMdIFFiXveNwGxaUBDmRdbQNyiyVPpzaVTcFz
         igRbWOfbP9PGIw7H/TiCmFN2ibo8AOWyYEUvfZNJ2d6hoCz97qFC1FNpcapXfbvgCC0D
         Dc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIxNsx5t66aCekxGiYnzItzLDmvgCurjGzLHlKM8kmo=;
        b=dZFBvUyx6I6yu5x9KI7cykgRPP61BtCZRsR3c72lrQqqd+vAXXKoPSXWqH2eRXrwxF
         bZZYjQQk1Fe1jxukTgyoWiPlBNvdVijIzhiCro4Wl5AHAbhxvaHsRYUv1ljd1w+DAJ4O
         HgWCTyYLBp+AlQZkfUpA4pHSJI/XXHi9RGWeXqkkGsBKdP4GCgqw4wkowqqO+H3SSiii
         kEqxsTKBnfR8MokBcSQaY5/Akp5xc80KFbhWmVcMiH/wF8v6ZRQ16pgVtgZGuC2YWdTq
         MYXSLXND5qqDrrJKGKibQPD2qqOMweDCvDtMmBDJFZJW0EczRbjJRrhdM7xQHss8zjuj
         T8Dg==
X-Gm-Message-State: AOAM531HrHekkONxkoVwTEqPrMDcw05AbZB0UDkV+KncAouDGc/dWoWc
        1yOxuJwSIH+Ypqd7fBB8DSY=
X-Google-Smtp-Source: ABdhPJwXNB8AH9WzcydC3nOV4kHShzA6P4syYry2xqBz+Iro1F4pn0IXPMbEY20Ct9c0HLCgx/xhIg==
X-Received: by 2002:a37:851:: with SMTP id 78mr5100598qki.617.1644538014344;
        Thu, 10 Feb 2022 16:06:54 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id v5sm11133965qkp.70.2022.02.10.16.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:06:53 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 34/49] media: tegra-video: replace bitmap_weight with bitmap_weight_le
Date:   Thu, 10 Feb 2022 14:49:18 -0800
Message-Id: <20220210224933.379149-35-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
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

tegra_channel_enum_format() calls bitmap_weight() to compare the weight
of bitmap with a given number. We can do it more efficiently with
bitmap_weight_le() because conditional bitmap_weight may stop traversing
the bitmap earlier, as soon as condition is (or can't be) met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/staging/media/tegra-video/vi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index d1f43f465c22..4e79a80e9307 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -436,7 +436,7 @@ static int tegra_channel_enum_format(struct file *file, void *fh,
 	if (!IS_ENABLED(CONFIG_VIDEO_TEGRA_TPG))
 		fmts_bitmap = chan->fmts_bitmap;
 
-	if (f->index >= bitmap_weight(fmts_bitmap, MAX_FORMAT_NUM))
+	if (bitmap_weight_le(fmts_bitmap, MAX_FORMAT_NUM, f->index))
 		return -EINVAL;
 
 	for (i = 0; i < f->index + 1; i++, index++)
-- 
2.32.0

