Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C3752FD4C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348256AbiEUO3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiEUO3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:29:48 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51360986F9;
        Sat, 21 May 2022 07:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653143316; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=H0WwP6DT5FRxWXZZoHBb2zu15fj5oVAkZWaY7krYxuFPoH33cKff/0pa+Ov3DrNbNDsbM6ija6+FzUjg9B5eqQt/1Ph9cKi7Rlk/2iDANH6BOEHc3H9G7i2GALBDwHbJlhkgU14lvQ/ZB7fifVaFzXNap0sriuREbt80yyM5Ja4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653143316; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=fvKlICVNUUrLCUJvTxodNTr2NlUW+NUhpKNpJF53DY0=; 
        b=alaes17ZDjTkex7WiZ/M17Ha7ufsc4onDumzuGLrlPPmeeCwwok8X8qxJ2sR1Zw3RVMU5sOS25pYehkTKepPFdc8LaFD7+1mFxEh8dnUzBe/C4wcAIoKZIQxpadmkFEpUl4kwSHL1pDTfSrYBiOI/5FU7BglhUIeVcig0cPg+4Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653143316;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=fvKlICVNUUrLCUJvTxodNTr2NlUW+NUhpKNpJF53DY0=;
        b=PbDLyZIIPk5iiT9nClJsNtMFERjCdQJViOFBT+CPRmv4DfSzmM4cTZCTMyHmaYqd
        Ohkt8O5ixFtXPszO6dwRx6RHlXTDQc38CkmD9baSxbKv7+Cb5tySB9AMRe6W67g94rd
        Z4eX6S29mkmGtc+gnMdSxAes6iECbdzbIqRQVvnM=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653143315853446.0560187060004; Sat, 21 May 2022 07:28:35 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sat, 21 May 2022 07:28:35 -0700 (PDT)
Date:   Sat, 21 May 2022 07:28:35 -0700
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Mark Brown" <broonie@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-gpio" <linux-gpio@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "Patrice Chotard" <patrice.chotard@foss.st.com>,
        "linux-sunxi" <linux-sunxi@lists.linux.dev>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
Message-ID: <180e7052574.1144f2ff745882.256639936280011408@zohomail.com>
In-Reply-To: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
Subject: [PATCH 3/4] pinctrl: bcm: Use regmap_field_{set/clear}_bits helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011226cce64127a18241e0b697cc370000a880a5bcfbb0056f95fd6a6c9044b7692dad714f4d52b49d:zu080112271849dd534324e028c72397fc0000e49e3d3ef24f687a23260274b906d374f69042e7b13707974e:rf0801122c246438a076f98930abc3b8280000a6b432ce715950e8973f8024087e02d36c4a8c3b14ef69ca6f86194cca7f:ZohoMail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

Appropriately change calls to regmap_field_update_bits()
with regmap_field_clear_bits() for improved readability.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm6358.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm6358.c b/drivers/pinctrl/bcm/pinctrl-bcm6358.c
index 9f6cd7447887..b03dfcb171d1 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm6358.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm6358.c
@@ -300,7 +300,7 @@ static int bcm6358_gpio_request_enable(struct pinctrl_dev *pctldev,
 		return 0;
 
 	/* disable all functions using this pin */
-	return regmap_field_update_bits(priv->overlays, mask, 0);
+	return regmap_field_clear_bits(priv->overlays, mask);
 }
 
 static const struct pinctrl_ops bcm6358_pctl_ops = {
-- 
2.36.1


