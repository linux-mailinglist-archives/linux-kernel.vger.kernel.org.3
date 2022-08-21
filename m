Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A66959B623
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 21:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiHUTZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 15:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiHUTZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 15:25:31 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783C31FCE2;
        Sun, 21 Aug 2022 12:25:28 -0700 (PDT)
Date:   Sun, 21 Aug 2022 19:25:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1661109926; x=1661369126;
        bh=PpJua1al93V3uzq5+TFc9GwHmULwcgRDaPB9VW74u5c=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=HCtv7T5nP/SSAd7adMUESTk2YHhR2Y4dFurdtFS/DLZKQ/vIyOmy5Cs6ce7l/OF+P
         JaffAlBtSSB237qJ7lQu5oz4K9rQc3JJY1METkynGFgecifannX4OPRb+9Z2NJqpm1
         hiJmuIvagbv814CPHSFLgY0h5Ny2Sf/iVaVvPxKw=
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Molly Sophia <mollysophia379@gmail.com>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH] [RFC] arm64: dts: qcom: sdm845-xiaomi-polaris: Fix sde_dsi_active pinctrl
Message-ID: <bc8380fc-faed-9f99-6d96-3c7c9afc66a1@connolly.tech>
In-Reply-To: <629afd26008c2b1ba5822799ea7ea5b5271895e8.1660903997.git.geert+renesas@glider.be>
References: <629afd26008c2b1ba5822799ea7ea5b5271895e8.1660903997.git.geert+renesas@glider.be>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/08/2022 11:14, Geert Uytterhoeven wrote:
> "make dtbs_check" says:
>
>      bias-disable: boolean property with value b'\x00\x00\x00\x00'
>
> Fix this by dropping the offending value.
>
> Fixes: be497abe19bf08fb ("arm64: dts: qcom: Add support for Xiaomi Mi Mix=
2s")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> ---
> Marked RFC as I do not have the hardware or documentation.
> Perhaps the "bias-disable" property should be dropped instead?

This is correct, the ` =3D <0>` is a downstream style, but it does actually=
 mean to disable the bias
afaik, from downstream docs:

- bias-disable:
=09Usage: optional
=09Value type: <none>
=09Definition: The specified pins should be configued as no pull.


> ---
>   arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/ar=
m64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> index 7747081b98875aad..dba7c2693ff50073 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> @@ -617,7 +617,7 @@ sde_dsi_active: sde-dsi-active {
>   =09=09pins =3D "gpio6", "gpio10";
>   =09=09function =3D "gpio";
>   =09=09drive-strength =3D <8>;
> -=09=09bias-disable =3D <0>;
> +=09=09bias-disable;
>   =09};
>
>   =09sde_dsi_suspend: sde-dsi-suspend {
> --
> 2.25.1
>

--
Kind Regards,
Caleb

