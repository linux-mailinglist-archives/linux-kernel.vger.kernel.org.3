Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EC950E277
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbiDYN6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiDYN6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:58:42 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2EB2018A;
        Mon, 25 Apr 2022 06:55:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1650894932; bh=Mp3nuT0PzmWhzqqEzvPIZpiHN6vPDTUyd5pO9HIeeQE=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=ZhKh5Zpv/e7gcY9lFUXrmj4qBfrN5wGHNLlS0qLvcK7ucxitGfOZj2+edVgt61Qkv
         QtJC2BWkOb6nJy2iL8Bg5jwW1Nx9Xvawuw8/NMFuVNbeSuANWERn39FQoX1v4xTRTv
         PQGWAj7ofOlRGmNiePsij2NrYN+2qIs5TGD91Vgg=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC PATCH 3/5] HACK: ASoC: Tolerate N-cpus-to-M-codecs links
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <YmamSZKNtNai7KyM@sirena.org.uk>
Date:   Mon, 25 Apr 2022 15:55:32 +0200
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
Message-Id: <5C42BB2F-EED6-4F6E-A29E-B43768760244@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-4-povik+lin@cutebit.org>
 <YkrkbBNYULLgeS5w@sirena.org.uk>
 <904EB8A1-5561-4555-8030-B85703E24F2E@cutebit.org>
 <YmaTHTKWAfM7FCcY@sirena.org.uk>
 <9F8BCBA8-5EE3-4F87-9518-91CB7AB4E077@cutebit.org>
 <YmaaPa8A03rWV7HE@sirena.org.uk>
 <4CF6B0A7-F218-4798-BB21-18D563309D5C@cutebit.org>
 <YmamSZKNtNai7KyM@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 25. 4. 2022, at 15:46, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Mon, Apr 25, 2022 at 03:11:14PM +0200, Martin Povi=C5=A1er wrote:
>>> On 25. 4. 2022, at 14:55, Mark Brown <broonie@kernel.org> wrote:
>=20
>>> I am surprised that doesn't otherwise explode TBH - at the very =
least
>>> I'd expect it to show two PCMs to userspace which if I'm =
understanding
>>> your description correctly isn't really what's going on.
>=20
>> I fill in a single snd_soc_dai_link, it exposes a single PCM and =
works
>> like a charm. That is as long as I patch the playback/capture check =
in
>> question.
>=20
>> I read that to be the clear intention of ASoC code: a DAI link =
becomes
>> one snd_soc_pcm_runtime.
>=20
> Yes, so long as you boil it down to a single link it works fine but =
the
> bit on top of the binding where you tie the two CPU DAIs to what is
> actually exposed is all in code.  The reason this stuff isn't filled =
in
> is that connecting the thing that applications see to the physical =
links
> isn't at all obvious and needs at least some driver sitting in the
> middle to make the links - I'd imagine there's a DSP sitting there =
which
> probably has quite a bit of flexability about how the various hardware
> components available are actually related.  This makes figuring out =
what
> to do with the relationship between the multiple CPU DAIs hard.

I get the gist. Anyway unless you tell me otherwise I will assume I need
to move to DPCM with the platform/machine driver.

