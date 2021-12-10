Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC86470116
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbhLJNC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:02:56 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55996 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241385AbhLJNCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:02:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E7B7CE2AD3;
        Fri, 10 Dec 2021 12:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B617C341CA;
        Fri, 10 Dec 2021 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639141154;
        bh=cKoBkhWMvxXH4gLP0isqGKjiBOXQTax0b2GGuxzKRHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rqpHiJjzk7H3PCTAsWi3NJZI7zadvWa0YuFCYINiRaPQQz+NphzSWPRjbQAUptnLO
         kf2TSxtvDyA5c3O4QhhiZxB/3CAUJdpiczhFKn7Bq6xtZah/xqirCjbT43OY25fK1b
         8Zt+/H+QmQ5DfK14dFVeXVraDw+tV9CKbqYdZJypTE6UOXipQ6HVZskPNFqhgSjoNJ
         hl/TRVIH86k6sYWbFW5cAkulxa5klnpmW7rd1harymHdh02V1pUQUPWZ3AMHQEi7ft
         5xMIAOP8MiH3fHN7GXDTRD1yXe1rzKb/twPw6ChJmFOSB9XxYOLehCaiWmo0XXM0L5
         nqUKWUK//FQ9w==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvfUV-000GDc-Uu; Fri, 10 Dec 2021 13:59:11 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 2/3] media: si2157: add support for 1.7MHz and 6.1 MHz
Date:   Fri, 10 Dec 2021 13:59:09 +0100
Message-Id: <76c2ea87882c87bd35066a85cb48292a36a79fce.1639140967.git.mchehab+huawei@kernel.org>
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

Some tuners allow setting the bandwidth filter to 1.7MHz and
6.1 MHz. Add support for it upstream, as the narrower is the
bandwidth filter, the better.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/3] at: https://lore.kernel.org/all/cover.1639140967.git.mchehab+huawei@kernel.org/

 drivers/media/tuners/si2157.c      | 4 ++++
 drivers/media/tuners/si2157_priv.h | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index aeecb38b147f..2d3937af4f5f 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -458,8 +458,12 @@ static int si2157_set_params(struct dvb_frontend *fe)
 		goto err;
 	}
 
+	if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <= 1700000)
+		bandwidth = 0x09;
 	if (c->bandwidth_hz <= 6000000)
 		bandwidth = 0x06;
+	if (SUPPORTS_1700KHz(dev) && c->bandwidth_hz <= 6100000)
+		bandwidth = 0x10;
 	else if (c->bandwidth_hz <= 7000000)
 		bandwidth = 0x07;
 	else if (c->bandwidth_hz <= 8000000)
diff --git a/drivers/media/tuners/si2157_priv.h b/drivers/media/tuners/si2157_priv.h
index df17a5f03561..24849c8ed398 100644
--- a/drivers/media/tuners/si2157_priv.h
+++ b/drivers/media/tuners/si2157_priv.h
@@ -66,6 +66,11 @@ struct si2157_cmd {
 	unsigned rlen;
 };
 
+#define SUPPORTS_1700KHz(dev) (((dev)->part_id == SI2141) || \
+			       ((dev)->part_id == SI2147) || \
+			       ((dev)->part_id == SI2157) || \
+			       ((dev)->part_id == SI2177))
+
 /* Old firmware namespace */
 #define SI2158_A20_FIRMWARE "dvb-tuner-si2158-a20-01.fw"
 #define SI2141_A10_FIRMWARE "dvb-tuner-si2141-a10-01.fw"
-- 
2.33.1

