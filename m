Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6F0505C77
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346233AbiDRQcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346302AbiDRQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301F53122A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:29:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s137so19766848pgs.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnfylWN7MavTPT553g+jrwdoRsttSRF9ea+q5wroK2g=;
        b=FmFMoYGTefW+n/xauP+X3a81pJmhujkSpoC6XDS2NTi1wBUImQdjOqEfN6Nay2pmVa
         Q5fQR2dg3WNuUjHX539UdqZUfSlMEAJNGEhTU9UETcjtbMynbN+EqOJaQ6ENpO9S9hvM
         9EeFHRcnfd+Q2kjD+POOiV8QX1j+qQZQ0kBMl8FeNh+YuQTqWQ7rL4fi986KE2zwcAnG
         cJTGUoKsXGVGybL0pnBBKuY+dJknC+2iDSTgixvXEVwb11dHlmP55ra87TkKVbohLZY8
         CpvSQsgBn1lU/Q7PP91uJCscANYgHSy1AXQpJqUMMXF1I4i0ek6+Vvi5DGDRWh8m2AfF
         P+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnfylWN7MavTPT553g+jrwdoRsttSRF9ea+q5wroK2g=;
        b=5ibKL9mc9XsNPmr3G3MxcCW0AwKzV97X59/sVIPEPse0rw3soYaU7SOt/RdetBbdUG
         66nBVjMaCukR0O4KpB/gncX0AnrpdokakMZP8Wh/MHMPr8g1uzGCrAgo8f91pGJbYog5
         GzZMMFyYfixtOWGRLcp4PTuT/Xn4pGObM+gwji2xw1P+fUiQDIqYGw15etcCs+hKlQlJ
         1lsSzOxyStwVkBQ/a6CXicXMT5iZdDHZ3IEIWEVT2VoU/rOrJAQVp7NtCSq7mSqEhmyy
         f5ZQJkadRXvvTrWzQABUZzCOcpcnrHaAqFVvIIBhuShHM0s40a5hkE2Hi6LPhZOcwJwU
         QCWA==
X-Gm-Message-State: AOAM530fiU+SCY+KVCpC8Kci3k9wZokumx2lKCHN0nUjHygsVvEdouVy
        07Aoe0engEJETQiIPBC4MlI=
X-Google-Smtp-Source: ABdhPJxA2Go+r6mKW0OHbmQH7KoacX0ohuNjA2Mpy67TbAnVASS2Blt8F6TRSKoAqkCYwryj0oWRMg==
X-Received: by 2002:a05:6a00:218d:b0:4fd:f7a4:d4ad with SMTP id h13-20020a056a00218d00b004fdf7a4d4admr12930534pfi.83.1650299381585;
        Mon, 18 Apr 2022 09:29:41 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id h18-20020a63c012000000b0039cc3c323f7sm13295602pgg.33.2022.04.18.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:41 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH v2 2/3] staging: media: zoran: else is not generally useful after a break or return
Date:   Mon, 18 Apr 2022 21:52:46 +0530
Message-Id: <20220418162244.15346-3-aliyarahmani786@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418162244.15346-1-aliyarahmani786@gmail.com>
References: <20220418162244.15346-1-aliyarahmani786@gmail.com>
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

Remove the else without affecting the logic. Fixes the checkpatch warning: else is not generally useful after a break or return

Signed-off-by: Aliya Rahmani <aliyarahmani786@gmail.com>
---
 drivers/staging/media/zoran/videocodec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
index 16a1f23a7f19..19732a47c8bd 100644
--- a/drivers/staging/media/zoran/videocodec.c
+++ b/drivers/staging/media/zoran/videocodec.c
@@ -98,9 +98,8 @@ struct videocodec *videocodec_attach(struct videocodec_master *master)
 
 				h->attached += 1;
 				return codec;
-			} else {
-				kfree(codec);
 			}
+			kfree(codec);
 		}
 		h = h->next;
 	}
-- 
2.25.1

