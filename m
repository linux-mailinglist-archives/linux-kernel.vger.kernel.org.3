Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71F3497648
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 00:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbiAWXHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 18:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiAWXH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 18:07:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446D4C06173B;
        Sun, 23 Jan 2022 15:07:29 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e8so8584066wrc.0;
        Sun, 23 Jan 2022 15:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iKTUc4lC3inK31jjLMnTcVlmXA5iwDg+pz9vdq0u5yk=;
        b=DEHjdKY7erLFP1SYCp/Q+eDWHGTgDqPxeEr+sU31oOb6UE2Jd40k6HfbZ7rilOPRap
         JuosPfjX0qT+cnzCZPeojJ67AAcdhfIqWhEP+Ip+V6GRjlWiKcKgEvGPVf5DcaYaMiA0
         d4Y59yRoeR2I6Qjx9V/7IsmtBSTZnfGqP+IjqWz+5ku8yR3BPbnBcQCtVUpzaUKriy/j
         inR/58W3RPmvp5epmoimzYg2838d4CdJDDCR4LBvoYdZ7nEWqSlBWOa1pgTvVoXZTZJx
         70MLbKoQDkZEZoCfJDVCamUKjovaQVKOAtmiJpMO78c6G4w44XqEAzq7UlrHPBpz9yeT
         CaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iKTUc4lC3inK31jjLMnTcVlmXA5iwDg+pz9vdq0u5yk=;
        b=bXtj11okRsq/G6rBykJfvH/ORhHP5haIZF5TmwV6DNmmwvHOnQ6ct2XKdzxcd0gQCM
         rg6QgZ7ipwaI9hCqsKWmU5v4UZp5O0bBAP5QC4qEs4m15fsdnIYsAPvfHNXp+tQPRArf
         u9NvMAOKgyx8TKn1zrVJefkVJcuk3C7GZsAMwP1HfBVr6TMBxMEd4zjy/fSzg94ZyvrU
         fdRUp0lSh2gRv0VqvecXk5V7EAW7RVOWmaRFzPjCuI5JzHnF3OTU2r0xRPn2gAn4IKTI
         oMfteoP/g1S6UlnnvGOSrPBNpOtBwNOiJ2wU2mxvdIy8XV4hmpTfv3s7Teorwsp67GAs
         YHBQ==
X-Gm-Message-State: AOAM532VKozU8ccnfNFXTtKj60jmUK6sLzl26Wf85WPddtvQjhmyKl6F
        Lh+bDXumPNfP47axzzJFlI9nXN1KkKhImQ==
X-Google-Smtp-Source: ABdhPJwxC5vr8cUIqUGMMgmw298ahYszOKuc88y4+q2JzhMaKNu25YLowqNitykbvnT9bTXtoRio0w==
X-Received: by 2002:adf:f408:: with SMTP id g8mr12449555wro.381.1642979247878;
        Sun, 23 Jan 2022 15:07:27 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t18sm2277006wmq.43.2022.01.23.15.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 15:07:27 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: saa7115: make static read-only array lcr2vbi const
Date:   Sun, 23 Jan 2022 23:07:26 +0000
Message-Id: <20220123230726.7773-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static array lcr2vbi is read-only so it make sense to make
it const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/i2c/saa7115.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/saa7115.c b/drivers/media/i2c/saa7115.c
index a958bbc2c33d..15ff80e6301e 100644
--- a/drivers/media/i2c/saa7115.c
+++ b/drivers/media/i2c/saa7115.c
@@ -1129,7 +1129,7 @@ static void saa711x_set_lcr(struct v4l2_subdev *sd, struct v4l2_sliced_vbi_forma
 
 static int saa711x_g_sliced_fmt(struct v4l2_subdev *sd, struct v4l2_sliced_vbi_format *sliced)
 {
-	static u16 lcr2vbi[] = {
+	static const u16 lcr2vbi[] = {
 		0, V4L2_SLICED_TELETEXT_B, 0,	/* 1 */
 		0, V4L2_SLICED_CAPTION_525,	/* 4 */
 		V4L2_SLICED_WSS_625, 0,		/* 5 */
-- 
2.33.1

