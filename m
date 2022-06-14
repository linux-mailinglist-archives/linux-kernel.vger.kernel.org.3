Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3728054AB09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355364AbiFNHvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355003AbiFNHuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:50:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADAA3EF04;
        Tue, 14 Jun 2022 00:50:05 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4a7b:8d3a:acaa:ec46])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2595D66016ED;
        Tue, 14 Jun 2022 08:50:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655193004;
        bh=i4pIB3wtTE3UKgF4OYr5mvLHbEmiDbEUxKOWdftiRKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOPVihPr+5cKe9Rp6AsgTBlgNTQOjYLl24bRlzE3uVb8aZQJVXE7mNlTHZtc7Ti/u
         qLKgsgBXekfD+H15Cp1BRZZyUzIutpswvJunEQj8C8CA5Z5+tZSJoPe+AA0fvMmHaw
         2/N6/oCSicUh8H1J1qTsh1+2dFpxerkvjGtzO+uwf9U8nz0Pm/fdonezJsBxBPsHee
         Q6gfwQ8uwt5pToBpA25O05Pm/az00TiOHsSPGBe2IFNSp9PByLWu07TSRnpxO9BWEd
         0V6VHFhUL8AvdTaaocPaNC/I1tAs1ARQrMKiXL1wmVcHY8BHIO/ps1plmD2w+xZpDA
         9vZv9gMrPSlnQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 13/17] media: controls: Log HEVC stateless control in .std_log
Date:   Tue, 14 Jun 2022 09:49:43 +0200
Message-Id: <20220614074947.160316-14-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220614074947.160316-1-benjamin.gaignard@collabora.com>
References: <20220614074947.160316-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply print the type of the control.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index ff8a61f24d0a..c5c5407584ff 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -307,6 +307,21 @@ static void std_log(const struct v4l2_ctrl *ctrl)
 	case V4L2_CTRL_TYPE_VP9_FRAME:
 		pr_cont("VP9_FRAME");
 		break;
+	case V4L2_CTRL_TYPE_HEVC_SPS:
+		pr_cont("HEVC_SPS");
+		break;
+	case V4L2_CTRL_TYPE_HEVC_PPS:
+		pr_cont("HEVC_PPS");
+		break;
+	case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
+		pr_cont("HEVC_SLICE_PARAMS");
+		break;
+	case V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX:
+		pr_cont("HEVC_SCALING_MATRIX");
+		break;
+	case V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS:
+		pr_cont("HEVC_DECODE_PARAMS");
+		break;
 	default:
 		pr_cont("unknown type %d", ctrl->type);
 		break;
-- 
2.32.0

