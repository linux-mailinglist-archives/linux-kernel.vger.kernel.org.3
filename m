Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975A2570C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiGKVML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiGKVMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:12:02 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BC480526
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:11:59 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s128so8183094oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdZMxq9teW/ciKdL4QEeNQpROyhqmipkWHr+gWlgS6A=;
        b=GaV4iujd2/CrRe0qzyvgqkBxvbgvSW1A/XGMohTKkjsGm5MaDXQjhwpFJY68VNHVC8
         0W4/3eTNXIiP0yr0yk1zn9jVdK8yjLQ1SEWXQ2j4eNMUqlM9xTvy9R+4JECLBNGRU5jv
         X+kvJv+PvL5Gu49Eyjod3qMPXorHQva68hJ05rlvOQvQAEey1W9jVVvO+dFqVU1fuk06
         yJp510pHfwCfJ2Z6CSfi12SzSA5TpPfU8+SjDDy+SBfLcStvz9q04+octlfF96RvtcT9
         h7n5EJ7OATi4PB264m+X387KJ5y2Gc9Hpe86VLexz0VGpbxhIvOM03d/0hFlEVbhK/lj
         V4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdZMxq9teW/ciKdL4QEeNQpROyhqmipkWHr+gWlgS6A=;
        b=c6Azh1C3qXaQIgxgLkn4pgVBieB8gJgXVXrur94yTc/Ljni68jtDtkN6GyFoUG1/Fz
         v7C4FJ7KbEFHLdTRmhrMFIX86eOeZ3YYJPSRpCi5etzHfFyFJuX0odt786hvyCELRl6e
         Thpj/UVXxKIaqMftlMaRnJ6DBPzk5SL5SKgVxDBRWu+KOFDz0ZdbbSAu1Uwb8YbDKaLm
         BOSPJMKjbu6/D85T8sqHrBzO7brVJk6pL4mavm/+zs43Dp6hD5pgNw5c3y2/Il58Iji6
         qo3SvWVJmpNugrQCu4ouM1lFd/v7PWMdotmXsx7Sq5ayQiwb0xqlFvwlfP40aCSsR5sR
         bXvw==
X-Gm-Message-State: AJIora9nV8HXSphJuHG0Lo4sqJKTh1KOI3D6y9dYiY/00qUPz0pDIkEe
        DqZfXujcJ36yZc4fd+3bsfcVzQ==
X-Google-Smtp-Source: AGRyM1t86dPpMrWW4AD4sTKOgSAlld2F0HoRsm7zOKOCxo+kAwCnWnRsJILey4wO6ZWbweTtdx1Heg==
X-Received: by 2002:a05:6808:1a2a:b0:33a:381:c5 with SMTP id bk42-20020a0568081a2a00b0033a038100c5mr196317oib.9.1657573918269;
        Mon, 11 Jul 2022 14:11:58 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id c128-20020aca3586000000b00338869042fdsm3198817oia.32.2022.07.11.14.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:11:57 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH v2 4/8] vicodec: Use vb2_find_buffer
Date:   Mon, 11 Jul 2022 18:11:37 -0300
Message-Id: <20220711211141.349902-5-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
References: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newly introduced vb2_find_buffer API to get a vb2_buffer
given a buffer timestamp.

Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Acked-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/test-drivers/vicodec/vicodec-core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index be43f7d32df9..1d1bee111732 100644
--- a/drivers/media/test-drivers/vicodec/vicodec-core.c
+++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
@@ -280,17 +280,13 @@ static int device_process(struct vicodec_ctx *ctx,
 		 */
 		if (!(ntohl(ctx->state.header.flags) & V4L2_FWHT_FL_I_FRAME)) {
 			struct vb2_buffer *ref_vb2_buf;
-			int ref_buf_idx;
 			struct vb2_queue *vq_cap =
 				v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
 						V4L2_BUF_TYPE_VIDEO_CAPTURE);
 
-			ref_buf_idx = vb2_find_timestamp(vq_cap,
-							 ctx->state.ref_frame_ts, 0);
-			if (ref_buf_idx < 0)
+			ref_vb2_buf = vb2_find_buffer(vq_cap, ctx->state.ref_frame_ts);
+			if (!ref_vb2_buf)
 				return -EINVAL;
-
-			ref_vb2_buf = vq_cap->bufs[ref_buf_idx];
 			if (ref_vb2_buf->state == VB2_BUF_STATE_ERROR)
 				ret = -EINVAL;
 			ctx->state.ref_frame.buf =
-- 
2.34.3

