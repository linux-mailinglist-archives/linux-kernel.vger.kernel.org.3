Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07F35787EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiGRQ5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiGRQ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:57:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88252B1A4;
        Mon, 18 Jul 2022 09:56:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m13so5998253edc.5;
        Mon, 18 Jul 2022 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3DicpiZDzzyLvsd6Ksc1jxotvvS3SoBDIYH96KWNtg=;
        b=KUKKHyYWEJQbW9ke9Rw1YIZJaiFxXnCj4yr4QmqifDHu6S1SMb6SIZE5A21R2HhbZ0
         2gPuEGxA3VkBSG5aEF5bDSx00RMurXvxMRSIv8MEiFxhF0iKD9YHGVkYTvOinpxKmIQ+
         Nv6jaPHBJ2gJx22z5fzAzcVI6X2PESSspw5ui+uRmlCMGo16JQBEwjVaN0EXtibBKJDG
         qQ6JwWEKnDD8o/tnyaEEfWawuHJt09qBUeH2a4+mzdGmT51ClBuZsDhppFJv3ORp4DCp
         EFq8lWr0u2wLMuFZCx59OaP/eI9XSdqO/djQobEM//RngBYiGpHJQU8zUIildGJ9GWR4
         7iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3DicpiZDzzyLvsd6Ksc1jxotvvS3SoBDIYH96KWNtg=;
        b=A3genINUGjDC5fm+lqNnKmgmhaxsDJr/p6KMEPiU6Lv7DV4rrWEI5t4sbbg16Ffu06
         IjMuyimc4jT4Hma5vGZ4C8HZriQ8RXGBxaqSkG0YdxWIVykhBu5W58Xi+rk0bvbesSYd
         aBOJSFGRlbX29WoxNKzhN/aIxJNQn2lq6Rx4faayi/BxHIU6/7nA86NrZczGer0CXHzM
         11PLyu55MSTOwyX5h+QVzNLtd4uWR5teqqsk5JXlTBUSNa77fviZgfifGqV7KUep4zzf
         qBzzBNjToH0qywR5G+2we63KiMWEoMUE68g6xymWiljvYsVCr5f8YgFP68A4zsJ/BpKR
         hxUg==
X-Gm-Message-State: AJIora9QiwI3tXKqw23mPV1FGvE/wJSaf6l2PpnOhkZzJ1stP0q9ZB6Q
        D+HKDc2op2v+44QdgQlPqEM=
X-Google-Smtp-Source: AGRyM1syIdVOZlV95OE9SRKoINorbj9ZvFSagj4n4pG8X5leSXmfWy+OX9VV0dqUJVDUD4hGdnhwtw==
X-Received: by 2002:a05:6402:46:b0:43a:f611:5992 with SMTP id f6-20020a056402004600b0043af6115992mr38917400edu.18.1658163418196;
        Mon, 18 Jul 2022 09:56:58 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id gr19-20020a170906e2d300b0070abf371274sm5661292ejb.136.2022.07.18.09.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 09:56:57 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] media: cedrus: hevc: Add check for invalid timestamp
Date:   Mon, 18 Jul 2022 18:56:49 +0200
Message-Id: <20220718165649.16407-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all DPB entries will be used most of the time. Unused entries will
thus have invalid timestamps. They will produce negative buffer index
which is not specifically handled. This works just by chance in current
code. It will even produce bogus pointer, but since it's not used, it
won't do any harm.

Let's fix that brittle design by skipping writing DPB entry altogether
if timestamp is invalid.

Fixes: 86caab29da78 ("media: cedrus: Add HEVC/H.265 decoding support")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 1afc6797d806..687f87598f78 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -147,6 +147,9 @@ static void cedrus_h265_frame_info_write_dpb(struct cedrus_ctx *ctx,
 			dpb[i].pic_order_cnt_val
 		};
 
+		if (buffer_index < 0)
+			continue;
+
 		cedrus_h265_frame_info_write_single(ctx, i, dpb[i].field_pic,
 						    pic_order_cnt,
 						    buffer_index);
-- 
2.37.1

