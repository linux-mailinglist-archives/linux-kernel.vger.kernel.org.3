Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C20A46F8BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhLJBt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhLJBtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:49:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67344C061746;
        Thu,  9 Dec 2021 17:45:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B2BC9CE2994;
        Fri, 10 Dec 2021 01:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE24C004DD;
        Fri, 10 Dec 2021 01:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639100747;
        bh=e5iag6oxRvsbajNyLuY5BOF7cshdNJ5/JbbgYMMr8eQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Z5RRVhKtQ85QuE+Rn21KTVMMN85Y4zkILn0Cohmj8XaRMkkZk+EHFlomSMvX1bZfz
         cf8Q+vf/o6qHL9ofi/yOQ7CgwFGIsxBUinaGRLQFn8ab7FlDsXFHhCjH7TGkvK+Hyd
         7uDwT2nXy9dLzRJkHImKzWRDGhT6NuyP/u2LdkKqiDB8aucyVXCUzJ91gkcRIMZtk7
         c0G8pbTR2nH2dEo3jt0MEAqw9Ii5S6IFOdrysTLbD1sPRWTQbY7qtU68o5ZWDVhXWV
         XOpM5XMIaKoXTzUxsl9LnOHxQYkY025fYLZCg7qzz5KTlvN2Gj/jVrHefa79DpwZR8
         RPIEykuWlsiPA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a7b9fbfc-c7e6-983e-1f79-189ce6dc983a@amd.com>
References: <20211125110447.1188073-1-AjitKumar.Pandey@amd.com> <20211125110447.1188073-2-AjitKumar.Pandey@amd.com> <a7b9fbfc-c7e6-983e-1f79-189ce6dc983a@amd.com>
Subject: Re: [PATCH v4 1/7] x86: clk: clk-fch: Add support for newer family of AMD's SOC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        linux-clk@vger.kernel.org, rafael@kernel.org
Date:   Thu, 09 Dec 2021 17:45:46 -0800
User-Agent: alot/0.9.1
Message-Id: <20211210014547.CAE24C004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Limonciello, Mario (2021-11-30 11:41:30)
> On 11/25/2021 05:04, Ajit Kumar Pandey wrote:
> > @@ -26,22 +27,37 @@
> >   #define ST_CLK_GATE 3
> >   #define ST_MAX_CLKS 4
> >  =20
> > -#define RV_CLK_48M   0
> > -#define RV_CLK_GATE  1
> > -#define RV_MAX_CLKS  2
> > +#define CLK_48M_FIXED        0
> > +#define CLK_GATE_FIXED       1
> > +#define CLK_MAX_FIXED        2
> > +
> > +/* List of supported CPU ids for fixed clk */
> > +#define AMD_CPU_ID_RV                        0x15D0
> >  =20
> >   static const char * const clk_oscout1_parents[] =3D { "clk48MHz", "cl=
k25MHz" };
> >   static struct clk_hw *hws[ST_MAX_CLKS];
> >  =20
> > +static const struct pci_device_id soc_pci_ids[] =3D {
> > +     { PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
> > +     { }
> > +};
> > +
>=20
> Have you considered inverting it?  The number of ASICs using the "older" =

> design with the mux and multiple clock sources is a fixed value, but=20
> we'll keep adding new ASICs in the "new" design of just 48Mhz.
>=20
> Notably; I see that this series is missing the Yellow Carp ID for=20
> example.  We'll keep having more designs with the 48Mhz that need to be=20
> added to this list.

+1 Let's not keep adding to a list.
