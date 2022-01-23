Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273DB4974A8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbiAWSmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbiAWSlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:44 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4EEC0613DE;
        Sun, 23 Jan 2022 10:41:38 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id c3so13490602pls.5;
        Sun, 23 Jan 2022 10:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IkNrFbXH9gY1KIOKy+h9o3LQcC7Su75w6LGwm4LKjaA=;
        b=EaNO/dASy+lPZWlcOtxF1hC9GdUeB2iS8umkWOWTX4v3h315YhPaRibVAi7vXbbHWe
         dZQi44B8tyxUoVsiF1ho0iJZOHCw92Invp1s1Jngv0T8L+0c7uqMPEEfpdlpf7wsR2hX
         def6pyngVUbofEtQ0onarODYce0lr6EcewlHKAkg7wW7/E/IkNjJ29EwgZ9JC95dqfwt
         HyYjjJh6C7hZd1XozPUerv73BbBwkDAQaBq4LR4A9muS5E19XN+FHJn+gDMMIIQ3OCVG
         BFULBqru13piNITxvIlEYH3XteGH1vToU8U0ADIfL8v4GWj0g5Y1FVAMkzSf8zEQusxa
         sUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IkNrFbXH9gY1KIOKy+h9o3LQcC7Su75w6LGwm4LKjaA=;
        b=RY59NwHFm1GkcqcSz+WxYiTzOYYpKs+o8EVUByY0h5MJM5wYx/6NXMO0C3l/O7iM47
         zy7TIyf6BD90C/Gx3RYoGJN0FF+ttqgIpLAEcTglK5xMG6p/r3Wld1zHt1UQTMdg9/B5
         ZcdJQU7NqMYXzUInH6Hb0Okv6Ga2ZXrmewlIePNR+W8s7zKaeOe3Ac1pY8RtrjkHhzLW
         Wff7QzpHnVxJt2ZZnPsiAUh8Lllkj6mX9zoYQBY/u0yXlToUZKrY0KfgyceF6XowEoJB
         0ZCZtc7Fl/encwiEBiwxmdzweEEETg5f72uKev0mWl8EvuiwKNNbeaZa8H9ICoRw4U7w
         TWHA==
X-Gm-Message-State: AOAM533iw7yIgHU+dKabTx8o/cKkFQjbqjvwHdZ1mdw6MG7nYzRnwfOb
        tkutO2Rvl22V5fOZIfPOo2Y=
X-Google-Smtp-Source: ABdhPJzWjGjT87hpyuJ8zxGhbFECmd1/Zcro15HLI2qS1pA/4gjZkUJUdMuLJwg9rhA75s0Tv2Dbgg==
X-Received: by 2002:a17:902:c40d:b0:14a:96a4:1044 with SMTP id k13-20020a170902c40d00b0014a96a41044mr11869369plk.50.1642963297601;
        Sun, 23 Jan 2022 10:41:37 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id ms14sm11163509pjb.15.2022.01.23.10.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:37 -0800 (PST)
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
Subject: [PATCH 35/54] drivers/staging: replace bitmap_weight with bitmap_weight_le for tegra-video
Date:   Sun, 23 Jan 2022 10:39:06 -0800
Message-Id: <20220123183925.1052919-36-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tegra_channel_enum_format() calls bitmap_weight() to compare the weight
of bitmap with a given number. We can do it more efficiently with
bitmap_weight_le() because conditional bitmap_weight may stop traversing
the bitmap earlier, as soon as condition is met.

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
2.30.2

