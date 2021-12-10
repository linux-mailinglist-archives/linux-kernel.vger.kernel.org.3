Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9996470117
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbhLJNC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:02:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55988 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241382AbhLJNCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:02:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EEF5FCE2AD7;
        Fri, 10 Dec 2021 12:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EC2C341C8;
        Fri, 10 Dec 2021 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639141154;
        bh=M8WxNVshpmA5W3dxj8iqnNb+gaiIC0TSGmo6H30/9u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpHEot4Kswd7nC3GdIEo92fEe2wX9V9vrhe0HIaAQr0DCzEp52iqhCKRW0xnwyUSV
         6ukbjzlkl7m80uvXiqlW6Nnlzys+5+8f0LqTveFdLTDBJR3YD+Q7CR15BRsKFSmH1M
         OzPElm9OytfClU1TzscaZjeqGSEuXJPTeDPll+lEZYAwk9MSyYvH3BUl/3RzkFXkY8
         m2Vs1wik/gDUp2RCcUe5nqbHx38wAuUHsebJPNpv7/hKTXMNqd1/12MjuDax7ijMZX
         eoPw/op03DqQDUVOLYurkcENL+/nGquBeQ7x9Ke2afP+d9gMSov9ZLV1DJvJqWoAV7
         2rFuFMLOeEsfw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvfUW-000GDf-0O; Fri, 10 Dec 2021 13:59:12 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 3/3] media: si2157: add ATV support for si2158
Date:   Fri, 10 Dec 2021 13:59:10 +0100
Message-Id: <9470024c30330d37399aabba31777d134e6c52b0.1639140967.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639140967.git.mchehab+huawei@kernel.org>
References: <cover.1639140967.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device also supports ATV, as it has the same API for
setting analog TV tuning parameters.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/3] at: https://lore.kernel.org/all/cover.1639140967.git.mchehab+huawei@kernel.org/

 drivers/media/tuners/si2157.c      | 2 +-
 drivers/media/tuners/si2157_priv.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index 2d3937af4f5f..481c5c3b577d 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -576,7 +576,7 @@ static int si2157_set_analog_params(struct dvb_frontend *fe,
 	u8 color = 0;    /* 0=NTSC/PAL, 0x10=SECAM */
 	u8 invert_analog = 1; /* analog tuner spectrum; 0=normal, 1=inverted */
 
-	if (dev->part_id != SI2157) {
+	if (!SUPPORTS_ATV_IF(dev)) {
 		dev_info(&client->dev, "Analog tuning not supported yet for Si21%d\n",
 			 dev->part_id);
 		ret = -EINVAL;
diff --git a/drivers/media/tuners/si2157_priv.h b/drivers/media/tuners/si2157_priv.h
index 24849c8ed398..8579e80f7af7 100644
--- a/drivers/media/tuners/si2157_priv.h
+++ b/drivers/media/tuners/si2157_priv.h
@@ -71,6 +71,9 @@ struct si2157_cmd {
 			       ((dev)->part_id == SI2157) || \
 			       ((dev)->part_id == SI2177))
 
+#define SUPPORTS_ATV_IF(dev) (((dev)->part_id == SI2157) || \
+			      ((dev)->part_id == SI2158))
+
 /* Old firmware namespace */
 #define SI2158_A20_FIRMWARE "dvb-tuner-si2158-a20-01.fw"
 #define SI2141_A10_FIRMWARE "dvb-tuner-si2141-a10-01.fw"
-- 
2.33.1

