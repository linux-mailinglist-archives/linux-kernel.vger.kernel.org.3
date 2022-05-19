Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589D452E0B2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343702AbiESXo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343688AbiESXoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:44:15 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5087A11991D;
        Thu, 19 May 2022 16:44:14 -0700 (PDT)
Date:   Thu, 19 May 2022 23:44:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1653003852; x=1653263052;
        bh=Av8VhGGy9fDa2YnaJT7DzXlV8BZZT5+/mxjWeny6Lho=;
        h=Date:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=CK3dwueKjMcY70MIKC+y5gKyabyovoqZKW2vhdR63yqMSrFIsVbUAajct1R+05shf
         VoGq/QXe5DV8PLDTnlJMgeb9282TDxQsEhmyVi4NkoBXyQfieWQdn4gN41SlFjV/A+
         zVEKrTvU1aaB/c3lhijkAtCePVnBqbHN7am+43bztN6qwWKa64zZ4+fxBrCqqpY93h
         k7zBgQejlejSwBz3NwyuTTL0FZ7BPSlgbC7/IfJLQVHhvyQfyMsJv5jqNAKv0WyEug
         Z/oaU4hLi6yZb508YRniFebUBwlGSSofB0PyKvW5SrgKvUvZhyNmQGTcSjhYd6avED
         +OF1jTlD3LFog==
From:   Adam Wujek <dev_public@wujek.eu>
Cc:     Adam Wujek <dev_public@wujek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Adam Wujek <dev_public@wujek.eu>
Subject: [PATCH 3/3] hwmon: (pmbus) support mfr registers specific for page in debugfs
Message-ID: <20220519234346.440398-3-dev_public@wujek.eu>
In-Reply-To: <20220519234346.440398-1-dev_public@wujek.eu>
References: <20220519234346.440398-1-dev_public@wujek.eu>
Feedback-ID: 23425257:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before, it was assumed that all debugfs mfr entries are the same for all
pages. Now mfr registers can be present only on some pages or contain
different values in different pages.

Signed-off-by: Adam Wujek <dev_public@wujek.eu>
---
 drivers/hwmon/pmbus/pmbus_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index 597cbe85df07..26fa927dac26 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2664,7 +2664,8 @@ static ssize_t pmbus_debugfs_mfr_read(struct file *fi=
le, char __user *buf,
 =09struct pmbus_debugfs_entry *entry =3D file->private_data;
 =09char data[I2C_SMBUS_BLOCK_MAX + 2] =3D { 0 };

-=09rc =3D i2c_smbus_read_block_data(entry->client, entry->reg, data);
+=09rc =3D pmbus_read_block_data(entry->client, entry->page, entry->reg,
+=09=09=09=09   data);
 =09if (rc < 0)
 =09=09return rc;

--
2.17.1


