Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14BF58D5C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241280AbiHIIyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241178AbiHIIyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:54:32 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7ED22508;
        Tue,  9 Aug 2022 01:54:30 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1660035268; bh=HTSQxyjdTff+5nKPgMwzEpelY+3eet5R/sdeOOVWrTc=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=GV5wgq6SeyFBiWZhXtg2xXQJhx94BbQOIGfNwWbOq1g9j4sHeM/lKE9/e+uWJ3clQ
         kyFU/VV8EyPOcEzGetL87wmnbeVd9fefTVslcKypKvn8kLkx8i8OhBhqeyWep+5HfN
         tGcmJXUKaS6JggqfY9Xo9ZZWoU+vbWUmSaoI8O0k=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 2/3] ASoC: apple: mca: Start new platform driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <53c8f062-a760-c65f-479e-53e7991b3f66@linaro.org>
Date:   Tue, 9 Aug 2022 10:54:27 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <82B580B4-85BF-4ABA-B098-98E3CA9EE247@cutebit.org>
References: <20220808224153.3634-1-povik+lin@cutebit.org>
 <20220808224153.3634-3-povik+lin@cutebit.org>
 <53c8f062-a760-c65f-479e-53e7991b3f66@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 9. 8. 2022, at 10:47, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 09/08/2022 01:41, Martin Povi=C5=A1er wrote:

>> +	mca->switch_base =3D
>> +		devm_platform_ioremap_resource_byname(pdev, "switch");
>> +	if (IS_ERR(mca->switch_base))
>> +		return PTR_ERR(mca->switch_base);
>=20
> How does it work exactly? There is no such property... Can you submit
> also DTS using the bindings so we can validate they are real/correct?

Ah, I thought I fixed that. There=E2=80=99s supposed to be

	mca->switch_base =3D devm_platform_ioremap_resource(pdev, 1);

of course. My bad, I guess didn=E2=80=99t reexport the patches after =
these last
minute changes.

>> +
>> +	mca->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL);
>> +	if (IS_ERR(mca->rstc)) {
>> +		dev_dbg(&pdev->dev, "couldn't obtain reset control: =
%pe\n", mca->rstc);
>> +		mca->rstc =3D NULL;
>> +	}
>=20
> Similar question.

Same as above, there=E2=80=99s supposed to be

  resets:
    maxItems: 1

in the schema.


> Best regards,
> Krzysztof
>=20

Martin

