Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7984B27D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350838AbiBKO2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:28:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350792AbiBKO2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:28:08 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1523BCF;
        Fri, 11 Feb 2022 06:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644589687; x=1676125687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aoiu4X1Os6dkBo5T/cU9kfbetuAKCwJrerGoWnhH00M=;
  b=MtdgmUYSkedNwOXeCmB3EOhZgZsgUK4TpnoQHYhDMdu89moTljRfBhe3
   HMrDbwEa8QvcTVJW/m/zyoPycXlIiWlk7NDPFnypgh/aQJ891kEKqCOpV
   9n3LwE4UqUX5Zqz3ocmkP9Fy2p0zt+DLQXyjQfKKYIcyP5ga/LDqpVHmN
   h4Mcrpwbc60d4vxlfhIMHLX46eeQB2OKytyJKv6VyLPhn7ac/vfxbcsIy
   ptEIQNWcNGxowRKhg5biCKmbKEzixofVGKZg1zcwFEiMj2PIB9P7bJMdg
   zx28k3OazYpRQYHHNj6LOOGOmdR3qgRpbCjTj1FFrzRgzQYzNVaStXTC7
   g==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635199200"; 
   d="scan'208";a="22042285"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 Feb 2022 15:28:01 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 11 Feb 2022 15:28:01 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 11 Feb 2022 15:28:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644589681; x=1676125681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aoiu4X1Os6dkBo5T/cU9kfbetuAKCwJrerGoWnhH00M=;
  b=i2yWXg8UJiXLjDb99uLa/91rNPSi+Gm7ZsYtDqqYq/LZgZGo23FYT+R2
   rcZzirY6zgFXgFIetiOKH7w+E3uZ3Bw3Ap+dDkP++oe7uEhaKXmqgluQz
   blsmoGk46BFMqunveeolAPfL1vSW4gCL18K/Zpgn1gxXCsItUsLEQlF1K
   0BhlrLAxej4Z+vkU5dFESKsDhSD0k7jZBAZtL90pEhzV9mhlAb34hdLCW
   9EtHRSLsTW+8iznKQfaOTg3r8IsEtskX6Hrf9iiQstj0vwDn06JkNe6KQ
   XdsECeCIHPiBw81G34zD7trBsJ2Iu6GoQS4WxbdWIco1k7ooQLHwDDHg9
   g==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635199200"; 
   d="scan'208";a="22042284"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Feb 2022 15:28:01 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 646D7280075;
        Fri, 11 Feb 2022 15:28:01 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 4/9] media: imx: Fail conversion if pixel format not supported
Date:   Fri, 11 Feb 2022 15:27:47 +0100
Message-Id: <20220211142752.779952-5-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211142752.779952-1-alexander.stein@ew.tq-group.com>
References: <20220211142752.779952-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>

imx_media_find_mbus_format has NULL as a valid return value,
therefore the caller should take it into account.

Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/staging/media/imx/imx-media-utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index 02a4cb124d37..e59aaa77172a 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -544,6 +544,9 @@ static int imx56_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
 		cc = imx_media_find_mbus_format(code, PIXFMT_SEL_YUV);
 	}
 
+	if (!cc)
+		return -EINVAL;
+
 	/* Round up width for minimum burst size */
 	width = round_up(mbus->width, 8);
 
-- 
2.25.1

