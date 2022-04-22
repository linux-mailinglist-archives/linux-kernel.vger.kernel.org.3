Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06C650B7A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiDVM5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbiDVM4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:56:52 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D72B52B00;
        Fri, 22 Apr 2022 05:53:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1650632035; bh=Rr2b05NP3wGMyQRhBvV1IUry/zX4H2Dk7P7NRyvj4Tc=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=S2seNKR6yDu5lByMYBXtbttAJdb1b0jPUip8DgWFAkRfkxD3ictQ41YsHmflWx7Jt
         ZD8Gqu1wZkLj4wbBUECqLWYLgwPXkly6M/+vFY+k4B81Erg0Fdt7CREtFGbIoACJlI
         LHvoYzn8dmLlHQFq0Wf1Gr97+ZrFIpCXzoHBcxCs=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YmKjL9bOtOmsFWTs@sirena.org.uk>
Date:   Fri, 22 Apr 2022 14:53:54 +0200
Cc:     =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3CD969AD-7316-4D83-AD92-CC85ED817125@cutebit.org>
References: <YkW4MPh8VWc8eSGg@sirena.org.uk>
 <6D199EAB-FE14-4030-96A7-2E0E89D25FAB@cutebit.org>
 <YkXKmxJ0R3qpUoH4@sirena.org.uk>
 <DB0255C3-C9EC-4EFA-A377-C4BB1073D9B3@cutebit.org>
 <YmKPQ6kLCPz+2XTJ@sirena.org.uk>
 <B68302F2-3D77-4065-8A16-A9CC690AE10B@cutebit.org>
 <YmKSgHrbb/7koM36@sirena.org.uk>
 <A1574F30-62D2-467D-A40B-8FD7C6B8BCFA@cutebit.org>
 <YmKeEKa0w2xLM9cL@sirena.org.uk>
 <6F6130F3-381C-4AB7-B618-CDC4C4A37C9B@cutebit.org>
 <YmKjL9bOtOmsFWTs@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 22. 4. 2022, at 14:44, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Fri, Apr 22, 2022 at 02:36:03PM +0200, Martin Povi=C5=A1er wrote:
>=20
>>> Ah, I think the confusion here is that I'm using slot and channel
>>> interchangably whereas you're saying that previously the driver =
would
>>> allocate two channels to each speaker with duplicate data?
>=20
>> I guess you could say that. Not that there=E2=80=99s duplicate data =
on the I2S
>> bus, but the speaker amp would previously be configured to look for =
the
>> left and right channel in the same TDM slot (see e.g. set_tdm_slot of
>> tas2770 [0]).  (Each speaker amp drives a single speaker, but it =
still
>> has a notion of left and right channel.)
>=20
> Oh, I see - the speaker actually allows configuration of the slots
> independently.  Usually the left/right thing on mono devices only does
> something for I2S where the bus clocking enforces that there be both
> left and right channels.  Either configuration is fine by me TBH, if =
you
> can do that then you could just keep them mapped to the same channel
> then mark the control as disabled since it should have no effect.

Well but is there some established way to mark a control as disabled?

Another issue here is that if I disable it I can=E2=80=99t leave the =
routing
control in it=E2=80=99s default value, which is =E2=80=98I2C Offset=E2=80=99=
 and makes the speaker
amp ignore the slot mapping.

