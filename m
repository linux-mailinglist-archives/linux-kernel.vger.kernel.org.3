Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE0F58D443
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbiHIHMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiHIHMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:12:47 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CF41F617;
        Tue,  9 Aug 2022 00:12:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1660029159; bh=cDApK5hmdG5/n12lVn89OuKR5PmgY/qsf/gyfBRzWuo=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=QtUiVtrSeVGFlOCcxuaC4OAl/+jssyZYOmznmpaVVGB9lXDf7lSTqjyVpaRhWT9Jg
         9Rb79S3wkhZUnmTg9MctQmNkwB0P+FmsAARSKZXAG1KSbMga0CeFRucrwh9UYNOGnN
         aVCoXCc/KGfGY64/nni984A1WnO8cQMz6Z9DdgV4=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 3/3] ASoC: apple: mca: Add locks on foreign cluster access
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20220808224153.3634-4-povik+lin@cutebit.org>
Date:   Tue, 9 Aug 2022 09:12:37 +0200
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D63678FD-92EB-42E1-B04F-CCA563F4596A@cutebit.org>
References: <20220808224153.3634-1-povik+lin@cutebit.org>
 <20220808224153.3634-4-povik+lin@cutebit.org>
To:     =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -331,8 +339,10 @@ static int mca_be_prepare(struct =
snd_pcm_substream *substream,
> 	 */
> 	if (!mca_fe_clocks_in_use(fe_cl)) {
> 		ret =3D mca_fe_enable_clocks(fe_cl);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			mutex_unlock(&mca->port_mutex);
> 			return ret;
> +		}
> 	}

Stray unlock here

--
Martin

