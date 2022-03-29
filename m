Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A452A4EA61C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiC2Dfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiC2Dfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:35:52 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A57DF8F;
        Mon, 28 Mar 2022 20:34:10 -0700 (PDT)
Date:   Tue, 29 Mar 2022 03:34:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1648524846;
        bh=UuQYYywHtzbTL2f8IIBpjdXpXMyKr4yJnpIvrB8xVDA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=OybZeeO/kJvu/ahTUk6IimFjCywmIoaNeALQgknkRkkewPJfZ8d92wwJK9QVKsQ3X
         4JczcFYiZr9XYbOAowUezDgDhN1+dJlNSIWaSVkJBgzNrgkMGA+kxDsiSY00nbljZj
         ZJSXKWktSqDM3dzjUcfBJ3aWNC7wHa0sji//XsdW8vmiBlsYgPwtnYPFtCqpE+RdW1
         eunPxwWM47dDy3kqbeDy7tuSjuoomJWoTfJiZqJVRP9Ad6IWRmj0xQXZq0bwMGHWir
         1ijcH9ChuF1s8BHd5m18gf1foepthrZ0DZALZntnp7uYQCFL2LNiJniJXSGNdLSU8D
         Mc9x8mVk9pWZw==
To:     Sebastian Reichel <sre@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH] power: supply: Reset err after not finding static battery
Message-ID: <20220329033226.535475-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise power_supply_get_battery_info always returns -ENODEV
on devices that do not have a static battery, even when a simple
battery is found.

Fixes: c8aee3f41cb8 ("power: supply: Static data for Samsung batteries")
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/power/supply/power_supply_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/suppl=
y/power_supply_core.c
index ea02c8dcd748..d925cb137e12 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -604,6 +604,12 @@ int power_supply_get_battery_info(struct power_supply =
*psy,
 =09err =3D samsung_sdi_battery_get_info(&psy->dev, value, &info);
 =09if (!err)
 =09=09goto out_ret_pointer;
+=09else if (err =3D=3D -ENODEV)
+=09=09/*
+=09=09 * Device does not have a static battery.
+=09=09 * Proceed to look for a simple battery.
+=09=09 */
+=09=09err =3D 0;
=20
 =09if (strcmp("simple-battery", value)) {
 =09=09err =3D -ENODEV;
--=20
2.35.1


