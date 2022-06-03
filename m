Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326C353D190
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347653AbiFCSfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345278AbiFCSff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:35:35 -0400
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Jun 2022 11:23:39 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8723A9CC86;
        Fri,  3 Jun 2022 11:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1654280429;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=jRzE700Iwk6JPnFC1XF3JnNELKmhJQ9Ut8G4hkkDJF0=;
    b=p7RNxjyiSayvHYPh3pHVP+T7P4Hcsn75gGJxiD5ywUMsVEPqBfsrMCiR1C47cvRHPG
    nCbifbauhHQMWv0vrZkk64YAzDa03TPeK2zI1an99Cd6KVmM/Cwh3yx+l5wlGoFPB+lz
    JbiBdHH/mpVYGdbK2X+pXmeZ7ppmt1PpMOwCSuLRj4L2foo2vDkQeuR4nBDvczVknpiH
    AYkEkOrGQ5yGk/JBTbx1GPRF89BaoAAqffAxeBBjPB1r3TGn9B/gVXvtqqy4P8X6gMPH
    4/lRQ2MNTugVRSf8sTtvJtdeAkOVKpSVSbKKHkQk+2s8mclCSZ+3hjx0ZdP0EAMuvw8b
    zUFw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrKw7/aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id 9056edy53IKTwlV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 3 Jun 2022 20:20:29 +0200 (CEST)
Date:   Fri, 3 Jun 2022 20:20:28 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Alexander Martinz <amartinz@shiftphones.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: Re: [PATCH 1/2] ASoC: codecs: tfa989x: Add support for tfa9890
Message-ID: <YppQ7BiqlBDMNsuc@gerhold.net>
References: <20220602164504.261361-1-amartinz@shiftphones.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602164504.261361-1-amartinz@shiftphones.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 06:45:03PM +0200, Alexander Martinz wrote:
> The initialization sequence is taken from the version provided
> by the supplier [1].
> 
> This allows speakers using the TFA9890 amplifier to work, which are
> used by various mobile phones such as the SHIFT6mq.
> 
> [1]: https://source.codeaurora.org/external/mas/tfa98xx/tree/src/tfa_init.c?id=d2cd12931fbc48df988b62931fb9960d4e9dc05d#n1827
> 
> Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
> ---
>  sound/soc/codecs/tfa989x.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/sound/soc/codecs/tfa989x.c b/sound/soc/codecs/tfa989x.c
> index dc86852752c5..8ab2656de750 100644
> --- a/sound/soc/codecs/tfa989x.c
> +++ b/sound/soc/codecs/tfa989x.c
...
> @@ -188,6 +190,33 @@ static struct snd_soc_dai_driver tfa989x_dai = {
>  	.ops = &tfa989x_dai_ops,
>  };
>  
> +static int tfa9890_init(struct regmap *regmap)
> +{
> +	int ret;
> +
> +	/* unhide keys to allow updating them */

Nitpick: I think the magic number is the "key" to hide/unhide certain
*registers*. This comment implies that you are hiding *keys*.

Maybe just write something like

	/* temporarily allow access to hidden registers */
	...
	/* hide registers again */

With that fixed, feel free to add my

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Thanks!
Stephan

> +	ret = regmap_write(regmap, TFA989X_HIDE_UNHIDE_KEY, 0x5a6b);
> +	if (ret)
> +		return ret;
> +
> +	/* update PLL registers */
> +	ret = regmap_set_bits(regmap, 0x59, 0x3);
> +	if (ret)
> +		return ret;
> +
> +	/* hide keys again */
> +	ret = regmap_write(regmap, TFA989X_HIDE_UNHIDE_KEY, 0x0000);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(regmap, TFA989X_CURRENTSENSE2, 0x7BE1);
> +}
> +
> +static const struct tfa989x_rev tfa9890_rev = {
> +	.rev	= TFA9890_REVISION,
> +	.init	= tfa9890_init,
> +};
> +
k
