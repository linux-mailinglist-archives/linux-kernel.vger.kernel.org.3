Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD5B5280B8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbiEPJVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiEPJVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:21:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1E726107;
        Mon, 16 May 2022 02:20:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m1so19615130wrb.8;
        Mon, 16 May 2022 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2TczeHyUCAhehbHrGoveNks21qc/tTNmqgsMN+aZWG4=;
        b=Qjz1eE1KFzUh9W6px5cIXQbJoqPPvCAp9uDpVBqSCswj4RhfvGneySnDgjvcwJTW7i
         CH4fdFAtMZJizD2xZs4XVUefKfKUp4uwQYndg1se6xALCAXaAo8/VQqQk3qN0sPt0nu0
         MQIkkcY3JbruyLrL5OeBeZTdUn+Z4xpMriaeWnTlDdX9ko2fl0o0QDpmefkljNBIRN/T
         1jwqlz0xGs+2sEu50Y/uYmFrUPwKaSJAF11D2Bos1z95n2UfLuHBvjMsH+YGuBKMywg+
         7xa51Jspop5WC2gq+E3cN7PlUs2B9rU1h6S4lD6RDuhq09qF+eQ/chC2BikHyX+gKIFx
         dhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2TczeHyUCAhehbHrGoveNks21qc/tTNmqgsMN+aZWG4=;
        b=WNLSAxRtxdktU+Wd7br6pMv4fzqE5SzYMn1sQ2/tELEtz800+25bKIH3J/Nkre1VUB
         F0ng6uH04cQ1sUl/gXA+p2RpjtOy5jGmhO4xaurH4AOtoDjynKvXPYjMTao6QDFBgOww
         uLSqVnzOFPx5AgmZ7jXduxw/sb1W+bgF/p+1wTBEItx/Jx5ZytmWMxP+tz4e7qLIl9UM
         jMR2aC20xpOPwBHYtWENXwm+VWpfARjexwFKXfjLinGUu5wD2MkqKMGSORHeVIsVb6tB
         uSD+knpAzGToe3YUUgm0ob+JtN9ZYFRI6/adKYOW9uBOXJwuUp5mNv4zkiMc2ellisam
         tarA==
X-Gm-Message-State: AOAM5329rTXExjIM4z8znUAsz6hKuut58OxxjFLZer9/oCziNDDLuDX+
        +hqMQKISss4TfL7lAz4+WzU1btoR2UE=
X-Google-Smtp-Source: ABdhPJxxQuxBgrM/yM5YgvZaqXBz1UeUoUQt0t32Kdiox/VQ+Nl9pMKZfmdRj8DUNwaBXEiSLTsmTw==
X-Received: by 2002:adf:d1ef:0:b0:20c:7595:4d68 with SMTP id g15-20020adfd1ef000000b0020c75954d68mr13075955wrd.155.1652692854735;
        Mon, 16 May 2022 02:20:54 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id s20-20020adf9794000000b0020c5253d902sm8950335wrb.78.2022.05.16.02.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 02:20:54 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: i2c: isl7998x: make const array isl7998x_video_in_chan_map static
Date:   Mon, 16 May 2022 10:20:53 +0100
Message-Id: <20220516092053.27619-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Don't populate the read-only array isl7998x_video_in_chan_map on the
stack but instead make it static. Also makes the object code a little
smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/i2c/isl7998x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/isl7998x.c b/drivers/media/i2c/isl7998x.c
index dc3068549dfa..94e60aa2786a 100644
--- a/drivers/media/i2c/isl7998x.c
+++ b/drivers/media/i2c/isl7998x.c
@@ -665,7 +665,7 @@ static int isl7998x_set_standard(struct isl7998x *isl7998x, v4l2_std_id norm)
 static int isl7998x_init(struct isl7998x *isl7998x)
 {
 	const unsigned int lanes = isl7998x->nr_mipi_lanes;
-	const u32 isl7998x_video_in_chan_map[] = { 0x00, 0x11, 0x02, 0x02 };
+	static const u32 isl7998x_video_in_chan_map[] = { 0x00, 0x11, 0x02, 0x02 };
 	const struct reg_sequence isl7998x_init_seq_custom[] = {
 		{ ISL7998X_REG_P0_VIDEO_IN_CHAN_CTL,
 		  isl7998x_video_in_chan_map[isl7998x->nr_inputs - 1] },
-- 
2.35.1

