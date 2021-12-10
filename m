Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6BB470110
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241399AbhLJNCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbhLJNCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:02:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8E4C061746;
        Fri, 10 Dec 2021 04:59:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62825B827F8;
        Fri, 10 Dec 2021 12:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF43C00446;
        Fri, 10 Dec 2021 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639141154;
        bh=1dvmXl8pyYQ0tyABD9NsTZ8C2vZB9e7Jfo4+R07uHwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3CPClMp+3Dt5zHJGN22jIJ8uR7a7ntRS3AB0hBo+xHvZP0oYn5P4Jbd2Q5GeuhCe
         1GXMXbJDehgV6GI5zF1Cgen+Ed4XZjmwSBllN8XTplKbMVfkX5oTh1LEbxzn6M3Z+M
         zZ2ChYkqui/wyUoNknSMMDRsStZbTKf8xhKJNLGj104iBo32PRlZI5/3bU49OeXjeU
         +mjNNpaEVIIE24Xv4WS96FlQ3fB64RvgSe/zJqQ9qPQBMGkYsKv1TV9k//PHgndMjX
         N5e/c4+nLghfgrwU3euUAndTyIv78HKHAWObd8i9I0qWpEz8BItbnUuC5rMfCPLxQz
         JDTIR/3BE/5Mg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvfUV-000GDZ-Tl; Fri, 10 Dec 2021 13:59:11 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 1/3] media: si2157: add support for ISDB-T and DTMB
Date:   Fri, 10 Dec 2021 13:59:08 +0100
Message-Id: <be50d86be1d4bbeba5663c814c281c7ccb8a06db.1639140967.git.mchehab+huawei@kernel.org>
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

Those two delivery systems are supported by some of the si2146
tuners, but the current code is missing the setup for those.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/3] at: https://lore.kernel.org/all/cover.1639140967.git.mchehab+huawei@kernel.org/

 drivers/media/tuners/si2157.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index 7e44cba67c38..aeecb38b147f 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -483,6 +483,12 @@ static int si2157_set_params(struct dvb_frontend *fe)
 	case SYS_DVBC_ANNEX_A:
 			delivery_system = 0x30;
 			break;
+	case SYS_ISDBT:
+			delivery_system = 0x40;
+			break;
+	case SYS_DTMB:
+			delivery_system = 0x60;
+			break;
 	default:
 			ret = -EINVAL;
 			goto err;
-- 
2.33.1

