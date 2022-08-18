Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340AD5980CC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 11:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbiHRJ01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiHRJ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:26:08 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20083B0B37
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1660814717; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ecp+b6q9LKlC+2Tp45CO/kCN49M5kVOiRygPDX41MpmcwikQX6nAIfw2WcTqDsosaCBFMqyKvlJ1CzpE+qzRYNAhtXJKr5uXrQNAhfVFq3SFLi6rh/Cu7dTRRvh2LFuc62G4ltcyh16IIhZH8oUxlTOcIAVo20bTCZgs0DlRejE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1660814717; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=n/YmpnnI3jusujPQQ0H9VdujOiT8un6Nr19J1PBA+/o=; 
        b=XnnInuT+ymHQpZb+cpb3rXDGpnLIQ3VfOZrgawaSHRFCxXc3u/etCa6YlZhy6WivsCbVmCuM3o39IoJN6eg1BRt46+HZc5rSOgdUmzppHjg+/HU9pVX1RqvRJrdjJwRCovSzwzMyW/YXDlxweR1RIyFOq74KpdL8ral2uiH3T8Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1660814717;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=n/YmpnnI3jusujPQQ0H9VdujOiT8un6Nr19J1PBA+/o=;
        b=YtYiL2JDifjW/6x7jRqIpLsGi9447JDxwCN1PQJ0W2nO9e0fNfCxHEswjoaSZe76
        tOCdfSNG9rddc6Zw7OuU8b08OSWW2wVXpVIaltQTHj1qyPe5DtUE78g0tXd63Gog7MM
        SZN3pLWNeHbzoKfiPBKidsVXFEZsdI6A/oe/AbEE=
Received: from edelgard.icenowy.me (112.94.101.156 [112.94.101.156]) by mx.zohomail.com
        with SMTPS id 1660814714900671.9352722842973; Thu, 18 Aug 2022 02:25:14 -0700 (PDT)
Message-ID: <24882ec3fed5c9772e1b04088cecece1b2477b23.camel@icenowy.me>
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
Date:   Thu, 18 Aug 2022 17:25:09 +0800
In-Reply-To: <c3386d45-b643-b4aa-c868-5c113cd2955f@intel.com>
References: <20220725111002.143765-1-uwu@icenowy.me>
         <20220725111002.143765-2-uwu@icenowy.me>
         <4208aece-0aea-ba86-9a00-9e217546e1dd@intel.com>
         <3346b62c3cd7e07766457c9140849a31d6d8775c.camel@icenowy.me>
         <85648922-27df-051d-8ae8-d0e4e810198a@intel.com>
         <1891bc72834cb6e25d479c3968c04bcef94c3ad5.camel@icenowy.me>
         <c3386d45-b643-b4aa-c868-5c113cd2955f@intel.com>
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

=E5=9C=A8 2022-08-17=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 15:19 +0200=EF=BC=
=8CCezary Rojewski=E5=86=99=E9=81=93=EF=BC=9A
> On 2022-08-17 2:48 PM, Icenowy Zheng wrote:
> > =E5=9C=A8 2022-08-16=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 21:08 +0200=EF=
=BC=8CCezary Rojewski=E5=86=99=E9=81=93=EF=BC=9A
>=20
> ...
>=20
> >=20
> > Yes, it's Chell.
> >=20
> > BTW do you need other ACPI tables?
>=20
> At this point, no. Thanks for confirming the platform's name.
>=20
> > >=20
> > > ..and at this point I probably know more than enough. We have
> > > tested
> > > basically all of the KBL and AML configurations when fixing
> > > regressions
> > > during recent skylake-driver up-revs. But Chell (and Lars for
> > > that
> > > matter) families were not among them as these are based on SKL.
> > > I'll
> > > follow up on this with our partners and come back here. I'm
> > > almost
> > > certain topology files for the two families mentioned were not
> > > updated
> > > along the way.
> >=20
> > Could this be an issue of Coreboot, which generates the NHLT table?
>=20
> NHLT was left alone across all the updates. Updating it is one way of
> fixing problems but I don't believe it's necessary in your case.=20
> Topology update is more desirable approach.

BTW how could I fix the topology?

I now use topology files from GalliumOS (which, I assume, is extracted
from ChromeOS).

>=20
> > BTW I think Google pinned the official OS of this hardware to a
> > much
> > lower kernel version (but I don't want to use the official OS
> > because
> > of limited storage of Chell and lack of VM ability of the OS on
> > Chell).
>=20
> That clarifies things out. Guess the kernel version used there is
> v4.4=20
> (plus a ton of un-upstreamed patches). Again, will propagate the=20
> information up the chain. Perhaps one of the solutions for end-users=20
> would be providing working UCM files to alsa-topology-conf repo so
> users=20
> are not powerless in situations such as this one.
>=20
>=20
> Regards,
> Czarek


