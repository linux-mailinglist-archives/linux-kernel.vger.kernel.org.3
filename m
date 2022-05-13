Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACACD526B96
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384544AbiEMUcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384466AbiEMUas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:30:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A4379806;
        Fri, 13 May 2022 13:30:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 7A9CA1F4648D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652473797;
        bh=LjTJxs5qEzAa3nkEOUZdNzT48i0a0uaCnC2plhBS5zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MB455OrcIQrH7tKLVa186WBFXhoBTk3j9/bJ1hrcjrvcHSQHqA6EwiPs6GGOEeZob
         V+DfjddNdMqFmU6rmQcEchWJby9cDdPUJw5SO5SK7U4MPMqB+ogTgml+zkvfr5MA5k
         YnXZZ8gBqlpFsIqS7qI00Pjf6/uxa6dumwVNRymz3MbwhW5lbd2g+gYi/vx+Am9+MK
         uN5lrYQF8qQZh6VtfcvqpDya5hiUzDHoZIzXamNFkDTW0nPZKejdEG68SzWa41nhOu
         AiY0YAfkmVcARIYspGSBjLbIBXFNP6GvdnTMOtLOX5aF19SAu4hVk8oXtgvkSzKF0j
         dGav5ndnQobcQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     nicolas@ndufresne.ca, Jonas Karlman <jonas@kwiboo.se>,
        linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/20] media: rkvdec: Ensure decoded resolution fit coded resolution
Date:   Fri, 13 May 2022 16:29:16 -0400
Message-Id: <20220513202922.13846-15-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220513202922.13846-1-nicolas.dufresne@collabora.com>
References: <20220513202922.13846-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

Ensure decoded CAPTURE buffer resolution is larger or equal to the coded
OUTPUT buffer resolution.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/staging/media/rkvdec/rkvdec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index e3d44d5b35f3..2bc4b1a40989 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -257,6 +257,8 @@ static int rkvdec_try_capture_fmt(struct file *file, void *priv,
 		pix_mp->pixelformat = coded_desc->decoded_fmts[0];
 
 	/* Always apply the frmsize constraint of the coded end. */
+	pix_mp->width = max(pix_mp->width, ctx->coded_fmt.fmt.pix_mp.width);
+	pix_mp->height = max(pix_mp->height, ctx->coded_fmt.fmt.pix_mp.height);
 	v4l2_apply_frmsize_constraints(&pix_mp->width,
 				       &pix_mp->height,
 				       &coded_desc->frmsize);
-- 
2.34.3

