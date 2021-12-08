Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBB246D0F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhLHK3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhLHK3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:29:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13159C061746;
        Wed,  8 Dec 2021 02:25:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB65AB82065;
        Wed,  8 Dec 2021 10:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC06C00446;
        Wed,  8 Dec 2021 10:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638959134;
        bh=krLshz+Vf+kgOgtf0v22/8JxsfRk09xsC6UpIpNnP2E=;
        h=From:To:Cc:Subject:Date:From;
        b=sZ7x3jLF0q2h11KTNmngGq/ozM4LiizrdE/czC3c8SPxu6I5akB80VbDLs3LgCOl1
         wuOY9v6wHKa+HkkvGOIGazCObdVV0gn671a1yDihaXM5CzFD0JWSMup1rW7FIBezge
         MtB5GileRj7JL0txp5ZulL+86u4LvdOGLDKsT6KKr+uxEqbPCM1SsVKOtem2Xt1lud
         BMQLke/oiNTGMg0lS1E2vk+CXeeihSi7ekXemHDkO9iQgl2qNu2b9e/abw/KMrvJqN
         tD8eovwJm2V309O6aYh8hUwTbQK3Ffekoq/ZgLiAbexPlmzWZZ33qNz+Ytu6qIO1Jv
         xqNYwSAU3usmA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1muu8i-00Bgd3-95; Wed, 08 Dec 2021 11:25:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Schlabbach <robert_s@gmx.net>,
        Olli Salonen <olli.salonen@iki.fi>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH RFC] media: si2157: optionally load firmare for SI2146_A10 and
Date:   Wed,  8 Dec 2021 11:25:30 +0100
Message-Id: <cd3a382dc39e72229a73149cb91e80cf69e2b07d.1638958947.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Antti Palosaari <crope@iki.fi>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Schlabbach <robert_s@gmx.net>
Cc: Olli Salonen <olli.salonen@iki.fi>
Cc: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org

While the eeprom firmware files for such devices are know to work,
if there is a firmware file, use it instead, as a newer version
could have solved some tuning issues.

Compile-tested only.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

At least on my eyes, it makes sense to also allow to optionally load A10
and A30 firmware files for SI2146_A10 and SI147_A30.

Yet, before applying this one, someone needs to report that those devices
will keep working with the loaded firmware files.

 drivers/media/tuners/si2157.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index 5f4ae8593864..f970bedfb179 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -205,19 +205,19 @@ static int si2157_init(struct dvb_frontend *fe)
 	case SI2148_A20:
 		fw_name = SI2158_A20_FIRMWARE;
 		break;
+	case SI2146_A10:
+		fw_required = false;
+		fallthrough;
 	case SI2141_A10:
 		fw_name = SI2141_A10_FIRMWARE;
 		break;
+	case SI2147_A30:
 	case SI2157_A30:
 		fw_required = false;
 		fallthrough;
 	case SI2177_A30:
 		fw_name = SI2157_A30_FIRMWARE;
 		break;
-	case SI2147_A30:
-	case SI2146_A10:
-		fw_name = NULL;
-		break;
 	default:
 		dev_err(&client->dev, "unknown chip version Si21%d-%c%c%c\n",
 				cmd.args[2], cmd.args[1],
-- 
2.33.1


