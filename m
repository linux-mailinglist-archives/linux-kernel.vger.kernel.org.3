Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF859E52E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbiHWOfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242911AbiHWOfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:35:31 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2F1D4189;
        Tue, 23 Aug 2022 04:52:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661255496; bh=1rsZJQ1VmiWE9kL+OMOZlmNFGDJshxOgSVa2Lkgjnz4=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=NUvbhkSTvH3mMPFYSiLTyp6jyjipuiXIbU0oMA5LLBkVIjI5tW2WKpNojLQhpr9sE
         dgXuK6qHhmBhET3WTml+SYlaFcxGwKWOoJPs8VqNvXSIftLn3iUYE/AZ7dLgZTBGan
         I6zz0Nf5FfC4k2c8Ury2q+89W/hqQJ1HpBLMMsQk=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2 3/4] ASoC: apple: mca: Start new platform driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <YwS6lHeGH0BZKHeB@sirena.org.uk>
Date:   Tue, 23 Aug 2022 13:51:35 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C89CA60-D0E2-4869-B21C-17AD4AA1974C@cutebit.org>
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-4-povik+lin@cutebit.org>
 <YwO/aqs7eqZx07kS@sirena.org.uk>
 <24C0ABFA-BF71-4492-8A6A-E9BE1462B403@cutebit.org>
 <YwS6lHeGH0BZKHeB@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 23. 8. 2022, at 13:31, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Tue, Aug 23, 2022 at 09:33:36AM +0200, Martin Povi=C5=A1er wrote:
>>> On 22. 8. 2022, at 19:39, Mark Brown <broonie@kernel.org> wrote:
>>> On Fri, Aug 19, 2022 at 02:54:29PM +0200, Martin Povi=C5=A1er wrote:

>>>> +	/*
>>>> +	 * We can't power up the device earlier than this because
>>>> +	 * the power state driver would error out on seeing the device
>>>> +	 * as clock-gated.
>>>> +	 */
>>>> +	cl->pd_link =3D device_link_add(mca->dev, cl->pd_dev,
>>>> +				      DL_FLAG_STATELESS | =
DL_FLAG_PM_RUNTIME |
>>>> +					      DL_FLAG_RPM_ACTIVE);
>=20
>>> I'm not clear on this dynamically adding and removing device links =
stuff
>>> - it looks like the main (only?) purpose is to take a runtime PM
>>> reference to the target device which is fine but it's not clear why
>>> device links are involved given that the links are created and =
destroyed
>>> every time the DAI is used, AFAICT always in the same fixed
>>> relationship.  It's not a problem, it's just unclear.
>=20
>> Indeed the only purpose is powering up the cluster=E2=80=99s power =
domain (there=E2=80=99s
>> one domain for each cluster). Adding the links is the only way I know =
to
>> do it. They need to be added dynamically (as opposed to statically =
linking,
>> say, the DAI=E2=80=99s ->dev to the cluster=E2=80=99s ->pd_dev, which =
I guess may do
>> something similar), because we need to sequence the =
power-up/power-down
>> with the enablement of the clocks.
>=20
> You could also just do the underlying runtime power management
> operations directly couldn't you?  It's not clear what the device link
> stuff is adding.

This seems to be the way to do it. Quoting from documentation of
dev_pm_domain_attach_by_id, by which we obtain the mca->dev and =
cl->pd_dev
the link is between:

 * This function should typically be invoked by a driver during the =
probe phase,
 * in case its device requires power management through multiple PM =
domains. The
 * driver may benefit from using the received device, to configure =
device-links
 * towards its original device. Depending on the use-case and if needed, =
the
 * links may be dynamically changed by the driver, which allows it to =
control
 * the power to the PM domains independently from each other.

--
Martin=
