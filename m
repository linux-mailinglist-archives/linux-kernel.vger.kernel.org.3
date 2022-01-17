Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CBE49028C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbiAQHGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:06:41 -0500
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64]:49763 "EHLO
        out162-62-57-64.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237310AbiAQHGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:06:39 -0500
X-Greylist: delayed 81946 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 02:06:38 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1642403195;
        bh=FNEpumVdR0V042HQu4zqL7oQurwNLap94AMGiqd5IpE=;
        h=From:To:Cc:Subject:Date;
        b=vBUxB9WO8/vHnqZrp5HTqGgZA8nw+ZQJvKFjMd1Z/j6vy9pyr/pTgkJ0O0BxnzUUP
         OeMC6lY25gyYVOTx8ffjJq6/pWT1Y4BLegAiWbiCqtYIpWCAglX+K3aagDzsZ6JLgk
         DLvttTM/SsGaGj6PA92Q0PmnXnA2gJzX/LXDSqNQ=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id 1A08A296; Mon, 17 Jan 2022 15:06:32 +0800
X-QQ-mid: xmsmtpt1642403192tfdsxvpxm
Message-ID: <tencent_A3850F2901FD5B80E831ABE7C27144509C0A@qq.com>
X-QQ-XMAILINFO: OAHLEV5KK0oz88TejDCCjtxc1/NDx0qMqz5+bhh+SN7UqDz7QcIBHoAgThmCVG
         xfRCclSwS5/RIGjiZpijD2udeR23s/j/B1ajJ9uYkT0WO7cFnZA5bMGBgk4cooCz3i04aDYZAtQ8
         NALm1pxIcm+UM4sZ/p0TMNn28kf+eWgEPlM8pas+pWjHobgVxq4qUriJlHRLzyOTgmhu8Ly0er7M
         sFyLKow1gqLkEQtewUKLCHoULLdGClp6l2j12aPkikBMUFMHQUdvdwcRYBEL571UgWKUJRIRLYN6
         +uUWjxGDXDrTqEoQw9FmU/S+SKt//EHj1cEGO25u14mTULG+HfGIdz9xTQ0hh1DnSoM6SFUf4o2m
         +6hxpaBK5eW90hUHTEnpjocBNK03RTVXtTyo2K/MIJvIyGVcCkQmJKsOOPH6BB6xb861oZgIbhUk
         mQN0omePJ9xN9yEKiz+8/CAWfaL3hj2CN2lOxDGNCEmOWJp/RQ4M4JD9htWfK9O4yZeQyrYab/Ws
         sg9pAjVd6IGDXFXqAfXPf5sFEn0eb24+r6rVzDHiYbgFnMzf8ivrhBP6Ky7tueTKG3MOxjqyDxG6
         1SP6nD6Bpb42JYFJye/afrzePd5xyrBgN6lG4piUnBSv2FoT2OIvSH7kx+kUniOe/39KundlTYhG
         hSLaJJUwZpYvhMhE63iS70DCHZAfar/HpiZPwBzpAfoWFMMywViLdWDIS3hqvai+nK6kQhuzirl0
         kKGvtMfmjZ/ynMau7nM6iDSy/04HzzH8F4bVvN3P2WCjtG+7VJDDdfIuOGkD6OV46O4Aot+r78rC
         9tGMwAD5MU5Gyl9j1Mva4MfJHg5LR5L7Cw0XaZ6OPNoprTsOqPmz9Qjy8oBPkzpZAmWmccgumgmA
         5S1OovJdyVGZHdwxcByH0qOTeeIt82CwKEhTO1F/LCppUdtF8Uc9c=
From:   xkernel.wang@foxmail.com
To:     andy@kernel.org
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] gpio: merrifield: check the return value of devm_kstrdup()
Date:   Mon, 17 Jan 2022 15:06:06 +0800
X-OQ-MSGID: <20220117070606.3475-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

devm_kstrdup() returns pointer to allocated string on success, NULL on
failure. So it is better to check the return value of it.

Before, if devm_kstrdup() fails, pinctrl_dev_name will be NULL, then the
retval below will be a negative error-code(inside gpiochip_add_pin_range(),
pinctrl_find_and_add_gpio_range()->get_pinctrl_dev_from_devname() will
finally check pinctrl_dev_name and return error), so the failure of
devm_kstrdup() can be only implicitly caught after a long call chain.
While this patch is to explicitly catch the failure in time.
> retval = gpiochip_add_pin_range(&priv->chip, pinctrl_dev_name,
>				  range->gpio_base,
>				  range->pin_base,
>				  range->npins);
> if (retval) {
> 	dev_err(priv->dev, "failed to add GPIO pin range\n");
> 	return retval;
> }

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
Changelogs:
v1 -> v2: update the commit message.
 drivers/gpio/gpio-merrifield.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 42c4d9d..f3d1bae 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -409,6 +409,9 @@ static int mrfld_gpio_add_pin_ranges(struct gpio_chip *chip)
 	int retval;
 
 	pinctrl_dev_name = mrfld_gpio_get_pinctrl_dev_name(priv);
+	if (!pinctrl_dev_name)
+		return -ENOMEM;
+
 	for (i = 0; i < ARRAY_SIZE(mrfld_gpio_ranges); i++) {
 		range = &mrfld_gpio_ranges[i];
 		retval = gpiochip_add_pin_range(&priv->chip, pinctrl_dev_name,
-- 
