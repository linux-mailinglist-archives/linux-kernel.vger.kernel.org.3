Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787CC54FF16
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381576AbiFQVCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiFQVCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:02:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D72711811;
        Fri, 17 Jun 2022 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655499768;
        bh=aMm72pcYD4B6skjo8RlmafJnq13ND5XBcNX4Keostng=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=jezYV9rc+qAcpsUKgwFVChukRhTqAr1rsvgGFn++wYs/5q9pVp0qjX6V6T1X/r4i6
         1kVMGq1xIClm6jmg6PZk7vCc3je+AnfiBE1/vIkYVKmiwGozHQ3Z/nxy1GzL+jAg9u
         OxHhr+abczlcUZwQn4ic1mIby7j4BchqI+BhovMk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([87.79.145.145]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqaxO-1nOYR61Tsm-00mdoZ; Fri, 17
 Jun 2022 23:02:48 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] pinctrl: nuvoton: wpcm450: Convert irqchip to IRQCHIP_IMMUTABLE
Date:   Fri, 17 Jun 2022 23:01:22 +0200
Message-Id: <20220617210123.2584225-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z1cCcEkQZoEWDCofz5k+t6xfSNFbvk9Pn3kfzl9s8+I1Pi/hGP0
 64XdOkvvvn6UhC/U5n+9i8sTqucFYcjJBIoP8zBYUExvMBVNtLZT7/oaseQTd6pXsTcj9Ty
 RVmtOUTmyIKXXNfNWYl14lC/thqy35dNGM+oyHnIWfwkPoATPcsvv/TdmvihffNBpKBMQP/
 cykzIbKpemoRuCbXfUPCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y/SMYkFD+nk=:gwmJ8zN7wLDLQ80UuWZ76O
 GvfNAcobQxWaI7D7TSd8Bu096FTa6v7WKhDpf4ypvubPfJWaycg9xknu5RI8aq2VNKuDqOyAV
 rAqZfnJjs5LJUwzpfH3YW9/9tMtM8ekoCR+/un2iB4eLvTXpRYzrQXJxijZDbCh1fGuF2Xq01
 XK1JCT917CxJMHK4nM+JOWZuyMYt+6N6AFY4zocen/Z9/9Z+Wj9lAHIb2cNWvrCBqHeW7giFD
 pVUl37CBAUWwZYKpWXYaYmD8sv/UKQ1yjKSXhPciQEgaYVvFCgOB8grmZClVVle5hjpi5Im61
 GtNHPWlEsbJdNV1gMyThMq49GLGkZrb/QJCw2T3lZo0UIzly+6SQvoySRyLjGr8VoJZ2PATE7
 KgdSIr0/hWpb4Hq1an+CI/gxy46Sl9oCSQjaB4yOFDywn0EjCeOX/YvkAWrJc1Rh8RPXD26CL
 aonGGkJYrj/TPQ08FAin6bgDcOLnipvoC/4BO3H629WmSRV8MgmrjJtC8iEJYAdI+pdylec4C
 RRdw6H7AVWQqD+7WIQnhmOTjVeoBIj9POBd8prwWNLLceXO6gCQlyNnhSGycLp8VgPOGCbuu8
 IvgDd/a1swRWFxz5q9ERE53HtGXZx6u/FUmUmT3aU4k2LR0Wo1acLysutxlL9iYBTCp/M6eTQ
 Gynoj1pBcbZjgEveGaOSoXYlz2Yb4KpOmETRvXERByKpEXHr3659K9zScNOIPRhkIBGjI9dwe
 RWF+gV1NtfiDVveIK+cKyjIIaZFfAcstqtqbmMLgxK2od1Ssfgu88rvamK2WgQzbL1KTJYmHh
 e8W8Wu1Rm+FTbX1eNmFyE+CVkiOMu2ejvESHWhbRbHbScHL12x2nfm7IGjXU8Cq6JKTrF+4TZ
 llribhazq0zyglpEd7pWQcy64jMEuLosmEzbpUHIKyigi/KYMX6c6ODrc/Ae4RJdcvciToi5R
 0uV5BgSVq6skMhAROi/5QOOXVVORMQd6Q+BoR1rLWo5H4ihixeqmfzy9RrNJatG4UOduoKE1t
 O2z1ErEA55yXSjuvuxu7B7MSNmkZ5G0TzRFQ79nuWgUGyznqr2BoUor0tFN5wv7S1PG3mmdnY
 O+7xoXcy67p9cS3I6qfpw7VVsIriEAePvNmzySqsm9Ac+6z+clCSDUpzw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6c846d026d490 ("gpio: Don't fiddle with irqchips marked as
immutable") added a warning for irqchips that are not marked with
IRQCHIP_IMMUTABLE.

Convert the pinctrl-wpcm450 driver to an immutable irqchip.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v3:
- Switch from raw d->hwirq to irqd_to_hwirq(d)

v2:
- Add missing gpiochip_*able_irq calls in mask/unmask methods
- Remove unused instance of struct irq_chip in struct struct wpcm450_bank

v1:
- https://lore.kernel.org/lkml/20220606214301.2061467-1-j.neuschaefer@gmx.=
net/
=2D--
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/n=
uvoton/pinctrl-wpcm450.c
index 0dbeb91f0bf27..528259496da5b 100644
=2D-- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
@@ -49,7 +49,6 @@ struct wpcm450_bank;
 struct wpcm450_gpio {
 	struct gpio_chip	gc;
 	struct wpcm450_pinctrl	*pctrl;
-	struct irq_chip		irqc;
 	const struct wpcm450_bank *bank;
 };

@@ -142,7 +141,8 @@ static void wpcm450_gpio_irq_ack(struct irq_data *d)

 static void wpcm450_gpio_irq_mask(struct irq_data *d)
 {
-	struct wpcm450_gpio *gpio =3D gpiochip_get_data(irq_data_get_irq_chip_da=
ta(d));
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
+	struct wpcm450_gpio *gpio =3D gpiochip_get_data(gc);
 	struct wpcm450_pinctrl *pctrl =3D gpio->pctrl;
 	unsigned long flags;
 	unsigned long even;
@@ -157,11 +157,14 @@ static void wpcm450_gpio_irq_mask(struct irq_data *d=
)
 	__assign_bit(bit, &even, 0);
 	iowrite32(even, pctrl->gpio_base + WPCM450_GPEVEN);
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
 }

 static void wpcm450_gpio_irq_unmask(struct irq_data *d)
 {
-	struct wpcm450_gpio *gpio =3D gpiochip_get_data(irq_data_get_irq_chip_da=
ta(d));
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
+	struct wpcm450_gpio *gpio =3D gpiochip_get_data(gc);
 	struct wpcm450_pinctrl *pctrl =3D gpio->pctrl;
 	unsigned long flags;
 	unsigned long even;
@@ -171,6 +174,8 @@ static void wpcm450_gpio_irq_unmask(struct irq_data *d=
)
 	if (bit < 0)
 		return;

+	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
+
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 	even =3D ioread32(pctrl->gpio_base + WPCM450_GPEVEN);
 	__assign_bit(bit, &even, 1);
@@ -293,6 +298,8 @@ static const struct irq_chip wpcm450_gpio_irqchip =3D =
{
 	.irq_unmask =3D wpcm450_gpio_irq_unmask,
 	.irq_mask =3D wpcm450_gpio_irq_mask,
 	.irq_set_type =3D wpcm450_gpio_set_irq_type,
+	.flags =3D IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };

 static void wpcm450_gpio_irqhandler(struct irq_desc *desc)
@@ -1068,9 +1075,8 @@ static int wpcm450_gpio_register(struct platform_dev=
ice *pdev,
 		gpio->gc.fwnode =3D child;
 		gpio->gc.add_pin_ranges =3D wpcm450_gpio_add_pin_ranges;

-		gpio->irqc =3D wpcm450_gpio_irqchip;
 		girq =3D &gpio->gc.irq;
-		girq->chip =3D &gpio->irqc;
+		gpio_irq_chip_set_chip(girq, &wpcm450_gpio_irqchip);
 		girq->parent_handler =3D wpcm450_gpio_irqhandler;
 		girq->parents =3D devm_kcalloc(dev, WPCM450_NUM_GPIO_IRQS,
 					     sizeof(*girq->parents), GFP_KERNEL);
=2D-
2.35.1

