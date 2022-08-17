Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698B3596EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbiHQMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiHQMsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:48:42 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAA141999
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1660740495; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=hNgcxbC1/bH1oWuXhIXcl1s36PpQ/+iJSRA1FOb/PW1ll/zw5JQEolfo70UIleJzJteF3DfI5T27jluWfzetFwBHZOteFv7lLkXbpE8A7TPYMRMAOs9mWNDs/EJ/JKE4fZbH2LOd5J1MKV6qEZyMu7E6A4IC2eW56/uqtLkr4Ek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1660740495; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=BF4U6/LWpjt7pK/imXhEM329xpOz0KaUMUC6uWcFgVo=; 
        b=VxCKGTNt7Ub/hFmHqH5FoS7LrU5s6h2LEhTGzLyjBoQ1gvvmraRNU5NWkE2kWhA5EnnjrrA857r2W0JDKACoAci0BHcik5rvzhJ9X26GCH6SfIwjFl4XrFvKNZeK2Rxudft73w2krLaYYZUMn3IZwjWbfhx7oLPveXfVqajbowc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1660740495;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=BF4U6/LWpjt7pK/imXhEM329xpOz0KaUMUC6uWcFgVo=;
        b=FtFr9J6RiZF/yZ4ZbevcXfTy2p/M+yqxIwSZhMqmrJAT5qnFkfqLqsZdpNXiVLFB
        RLWuhuNYU9sWoIeXtEZqTGSs0H1i0gdTgf0DVCUqyftparod+PfRjyMSUqYh2AwhaTy
        DvfmWeZGpNN3GFeScX4wbBcMmKNLxSG+c14yda7Q=
Received: from edelgard.icenowy.me (112.94.101.156 [112.94.101.156]) by mx.zohomail.com
        with SMTPS id 1660740492819274.56274292920773; Wed, 17 Aug 2022 05:48:12 -0700 (PDT)
Message-ID: <1891bc72834cb6e25d479c3968c04bcef94c3ad5.camel@icenowy.me>
Subject: Re: [PATCH 2/2] ASoC: Intel: Skylake: try to get NHLT blob with PCM
 params as fallback
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date:   Wed, 17 Aug 2022 20:48:04 +0800
In-Reply-To: <85648922-27df-051d-8ae8-d0e4e810198a@intel.com>
References: <20220725111002.143765-1-uwu@icenowy.me>
         <20220725111002.143765-2-uwu@icenowy.me>
         <4208aece-0aea-ba86-9a00-9e217546e1dd@intel.com>
         <3346b62c3cd7e07766457c9140849a31d6d8775c.camel@icenowy.me>
         <85648922-27df-051d-8ae8-d0e4e810198a@intel.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-08-16=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 21:08 +0200=EF=BC=
=8CCezary Rojewski=E5=86=99=E9=81=93=EF=BC=9A
> On 2022-08-07 7:26 PM, Icenowy Zheng wrote:
> > =E5=9C=A8 2022-08-02=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 12:30 +0200=EF=
=BC=8CCezary Rojewski=E5=86=99=E9=81=93=EF=BC=9A
> > > On 2022-07-25 1:10 PM, Icenowy Zheng wrote:
> > > > Switching to use pipeline parameters to get NHLT blob breaks
> > > > audio
> > > > on
> > > > HP Chromebook 13 G1 (at least with MrChromeBox firmware).
>=20
> ...
>=20
> > > Could you share the NHLT file from your platform plus the format
> > > used
> > > by
> > > the cras/userspace tool? Did you try playing over simple aplay
> > > tool
> > > instead?
> >=20
> > I tried 48000Hz 2ch 32bit with speaker-test.
> >=20
> > Attached is /sys/firmware/acpi/tables/NHLT.
>=20
>=20
> Thanks for the NHLT dump. Total of five endpoints are part of the=20
> description:
>=20
> id 0, DMIC capture, formats:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[0] 2/16/16/48000
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[1] 2/32/32/48000
> id 1, I2S SSP0 playback, formats:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[0] 2/24/32/48000
> id 2, I2S SSP0 capture, formats:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[0] 4/32/32/48000
> id 3, I2S SSP1 playback, formats:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[0] 2/24/32/48000
> id 4, I2S SSP1 capture, formats:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[0] 2/24/32/48000
>=20
> I know not what "speaker-test" means. Could you specify which
> endpoint=20

Well to be honest I know nearly nothing about Intel ASoC. (In fact I
have only a little experience dealing with ASoC on DT-based platforms
with asoc-simple-card)

I assume it uses the first playback stream, because I didn't explicitly
choose any streams; and speaker-test is only a playback test program.

> you are speaking of? Providing either alsa info or at least output of
> 'lsmod | grep snd' would help. I'd like to be aware of which machine=20
> board are we talking about.
>=20
> What could be guessed with the current info (and some google query),
> is=20
> that we are dealing with SKL-Y m5-6Y57, codenamed 'Chell' and the=20
> speaker-test is playing through an I2S codec connected to SSP0 port.=20
> It's probably max98357a. The skylake-driver version you have gets=20
> confused with 24/32 format (userspace is probably attempting 32/32).=20
> That or topology file is incorrect..

Yes, it's Chell.

BTW do you need other ACPI tables?

>=20
> ..and at this point I probably know more than enough. We have tested=20
> basically all of the KBL and AML configurations when fixing
> regressions=20
> during recent skylake-driver up-revs. But Chell (and Lars for that=20
> matter) families were not among them as these are based on SKL. I'll=20
> follow up on this with our partners and come back here. I'm almost=20
> certain topology files for the two families mentioned were not
> updated=20
> along the way.

Could this be an issue of Coreboot, which generates the NHLT table?

BTW I think Google pinned the official OS of this hardware to a much
lower kernel version (but I don't want to use the official OS because
of limited storage of Chell and lack of VM ability of the OS on Chell).

>=20
>=20
> Regards,
> Czarek


