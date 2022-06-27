Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99F555C875
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiF0JMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiF0JMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:12:33 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFD62664;
        Mon, 27 Jun 2022 02:12:31 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3E49FE0004;
        Mon, 27 Jun 2022 09:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656321148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/aeWWjcU0pgTxSwnjFANZsIuEo0pdJ58U5EC/Hg9ws=;
        b=pjj1BJqlH41VjgpxpUnUPjFak7CZHgFA73fITnzpLF2aujUnxSv5YBybx35HmLB/1u8afq
        UhQ2zBx3y6bMSHU2THvZeaHhvJREii3B1WyfhfM/oiKxtdqiz7c9JC3IPOPp/3G8fRse1n
        KJ8YSiMFayq0TQqu7ZES9J6Zyq8/JhOaVmqkTiUHcc8ythxd2K08zQozS2B3rPt+5ayr5x
        IKUZOcVqmeZQ0z7CLyQx1ZcWd8JZaf2V4BHErcfXvamtxpBfGrjdrA//enBhMI8+V7NQEa
        kBpHbEQl0+NSZRlGq6K1TiA0hB3rYDjFKlJ61vlk8z7WLzCVtdXbMbRA1fAGTw==
Date:   Mon, 27 Jun 2022 11:11:39 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] of: create of_root if no dtb provided
Message-ID: <20220627111139.22ea1abd@fixe.home>
In-Reply-To: <6d40876c-2751-01bb-94ab-7c9ab90e636f@gmail.com>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
        <20220624034327.2542112-2-frowand.list@gmail.com>
        <20220624141320.3c473605@fixe.home>
        <6d40876c-2751-01bb-94ab-7c9ab90e636f@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, 24 Jun 2022 11:44:07 -0500,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> On 6/24/22 08:13, Cl=C3=A9ment L=C3=A9ger wrote:
> > Le Thu, 23 Jun 2022 22:43:26 -0500,
> > frowand.list@gmail.com a =C3=A9crit :
> >  =20
> >> =20
> >> +/*
> >> + * __dtb_empty_root_begin[] magically created by cmd_dt_S_dtb in
> >> + * scripts/Makefile.lib
> >> + */
> >> +extern void *__dtb_empty_root_begin;
> >> +
> >>  /*
> >>   * of_fdt_limit_memory - limit the number of regions in the /memory n=
ode
> >>   * @limit: maximum entries
> >> @@ -1332,8 +1338,13 @@ bool __init early_init_dt_scan(void *params)
> >>   */
> >>  void __init unflatten_device_tree(void)
> >>  { =20
> >=20
> > Hi Frank,
> >=20
> > This function is only defined when CONFIG_OF_EARLY_FLATTREE is enabled.=
 =20
>=20
> More precisely, only if CONFIG_OF_FLATTREE is enabled.  But that would
> most likely be seleved by CONFIG_OF_EARLY_FLATTREE, so in practice the
> issue you raise is valid.
>=20
> > Which means that on platforms that do not select this, the default
> > empty device-tree creation will not be done. =20
>=20
> Yes, so platforms that need this functionality need to select this
> option.

Yes, but this seems a bit odd because this is not really a early
flattree that is provided by the firmware. This simply allows to have a
working support for overlays (As a "side effect" I agree).

>=20
> >=20
> > This configuration option is selected by the platform and not by the
> > user. On x86, only one config enables this (X86_INTEL_CE) which means
> > this won't work on all the other platforms even if CONFIG_OF is
> > selected. I would need this to work by only selected CONFIG_OF. =20
>=20
> Maybe this means that CONFIG_OF should be changed to select
> CONFIG_OF_FLATTREE.  Any opinions on this Rob?
>=20
> > That's why I decided to add the of_root creation in of_core_init()
> > using a function (of_fdt_unflatten()) that is provided if CONFIG_OF is
> > defined. =20
>=20
> I mentioned this in response to the previous patch series, but will
> repeat here for those who might not have read that email thread.
>=20
> I do not want the root live tree to be created buy different code in
> different places; I want one central place where this occurs.  When
> the tree can be created in multiple places by different code blocks,
> it becomes more difficult to understand the code and more likely that
> one of the tree creation code blocks is not updated when another is.

Understood, my point was more about the fact that I did not wanted to
select CONFIG_OF_FLATTREE to be able to use that support which does not
seems entirely tied to having a "early flattree".

Thanks,

Cl=C3=A9ment

>=20
> >  =20
> >> -	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
> >> +	if (!initial_boot_params) {
> >> +		initial_boot_params =3D (void *) __dtb_empty_root_begin;
> >> +		unflatten_and_copy_device_tree();
> >> +	} else {
> >> +		__unflatten_device_tree(initial_boot_params, NULL, &of_root,
> >>  				early_init_dt_alloc_memory_arch, false);
> >> +	}
> >> =20
> >>  	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere =
*/
> >>  	of_alias_scan(early_init_dt_alloc_memory_arch);
> >> @@ -1373,6 +1384,12 @@ void __init unflatten_and_copy_device_tree(void)
> >>  	unflatten_device_tree();
> >>  }
> >> =20
> >> +void __init setup_of(void)
> >> +{
> >> +	if (!of_root)
> >> +		unflatten_device_tree();
> >> +}
> >> +
> >>  #ifdef CONFIG_SYSFS
> >>  static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kob=
j,
> >>  			       struct bin_attribute *bin_attr,
> >> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> >> index d69ad5bb1eb1..4566876db351 100644
> >> --- a/include/linux/of_fdt.h
> >> +++ b/include/linux/of_fdt.h
> >> @@ -81,6 +81,7 @@ extern const void *of_flat_dt_match_machine(const vo=
id *default_match,
> >>  /* Other Prototypes */
> >>  extern void unflatten_device_tree(void);
> >>  extern void unflatten_and_copy_device_tree(void);
> >> +extern void setup_of(void);
> >>  extern void early_init_devtree(void *);
> >>  extern void early_get_first_memblock_info(void *, phys_addr_t *);
> >>  #else /* CONFIG_OF_EARLY_FLATTREE */
> >> @@ -91,6 +92,7 @@ static inline void early_init_fdt_reserve_self(void)=
 {}
> >>  static inline const char *of_flat_dt_get_machine_name(void) { return =
NULL; }
> >>  static inline void unflatten_device_tree(void) {}
> >>  static inline void unflatten_and_copy_device_tree(void) {}
> >> +static inline void of_setup(void) {} =20
> >  =20
>=20
> > Shouldn't this be setup_of(void) ? =20
>=20
> Yes, thanks!  Will fix.
>=20
> One other thing I need to do is test this patch on a user mode linux
> kernel.
>=20
> -Frank
>=20



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
