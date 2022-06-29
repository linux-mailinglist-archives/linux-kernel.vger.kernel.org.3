Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B6755FD59
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiF2K2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiF2K2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:28:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65FB3DDE4;
        Wed, 29 Jun 2022 03:27:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so9281211wml.2;
        Wed, 29 Jun 2022 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hg8Agbq4mVHkuTg7yeofSNYUTSRLwIyIHLfG6qwLBeg=;
        b=Gbsb5zJuVLRm7Da9Jr8RdNRb4c18Dy5l/Envmga0FP8skRJl9vegZvr6zWcv3ho0eD
         OcazvVvO86d9o7aqVpR6fRQZzdQbbgT56o8lqr/Mz6sLVhOumuK+6+S59ITxmWB5uAK1
         CiAnrf/APbNafVXL0dXfi75d8nd3jo4PTk5O4XipYLtyR0+E6QxbS1IB2VGPbRcLz/aF
         0FA0+v6PTERW99mIdv6ITvN6iQQCMK5zcW9yaA+dAmEdXC+ubZ3sLzvF5S6K7E62/tsH
         CCCx6fM+zTpSxS5wyQFzwnbu74aihqAAX5oYK5nkgXnGcgOdxBMs/szaXUOvSH7L0qEK
         IHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hg8Agbq4mVHkuTg7yeofSNYUTSRLwIyIHLfG6qwLBeg=;
        b=FzNWXq1wwW5ZzLPlcKSRxlR5fliyl/+R4BLP2+2wkS/IE2skfsZRl9iPFOAeziykSa
         OzabIanLRtx+0fdDAiCZV63u/kPMAam21lXUvpBRzfNlZ0WDTGKLErbyU10h0MCyc5sJ
         HeADObc63ud1WY2roW9NyKupeiDMPVYmEsAgmu1Wsn/lI3nRbJ8SSXseiJlSokXkfVxt
         HrrcMyI2Sa2IIlNj4i4EQEdrj673FWmLsND3GwzSfX/+K5/OcHI9YiRoAhFrbJui62Kc
         PfdaCn5as+XCdaHBIE3l5tQAOVl++TjOLKwYlcrkpHEvv4GKzUttKnRvImEzMVOQqr3E
         qPKw==
X-Gm-Message-State: AJIora+OIrSvZN8mriq6PJYoQ40n31XmIqun08K985tiG4cFB26gwAkp
        NKZZeXV7UR66rl3bH9OUd1M=
X-Google-Smtp-Source: AGRyM1soYIu0yqbLqBPz5blI3gO9sqPT4fLgv1ey2BFKUtMpLfhggg4dGfA55XA5R19+t43NuTDDBg==
X-Received: by 2002:a05:600c:1d85:b0:3a0:3d28:bdd9 with SMTP id p5-20020a05600c1d8500b003a03d28bdd9mr2962462wms.114.1656498469396;
        Wed, 29 Jun 2022 03:27:49 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c35d000b003a0375c4f73sm2765494wmq.44.2022.06.29.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 03:27:48 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: wavefront: remove redundant assignment to pointer end
Date:   Wed, 29 Jun 2022 11:27:44 +0100
Message-Id: <20220629102744.139673-2-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220629102744.139673-1-colin.i.king@gmail.com>
References: <20220629102744.139673-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Pointer end is being re-assigned the same value as it was initialized
with in the previous statement. The re-assignment is redundant and
can be removed.

Cleans up clang scan-build warning:
sound/isa/wavefront/wavefront_synth.c:582:17: warning: Value stored
to 'end' during its initialization is never read

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/isa/wavefront/wavefront_synth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index 2aaaa6807174..13ce96148fa3 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -581,8 +581,6 @@ demunge_buf (unsigned char *src, unsigned char *dst, unsigned int src_bytes)
 	int i;
 	unsigned char *end = src + src_bytes;
     
-	end = src + src_bytes;
-
 	/* NOTE: src and dst *CAN* point to the same address */
 
 	for (i = 0; src != end; i++) {
-- 
2.35.3

