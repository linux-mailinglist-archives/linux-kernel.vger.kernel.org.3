Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD60A47BD28
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhLUJre convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Dec 2021 04:47:34 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:49637 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbhLUJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:47:33 -0500
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4A9DCFF810;
        Tue, 21 Dec 2021 09:47:31 +0000 (UTC)
Date:   Tue, 21 Dec 2021 10:46:59 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] software node: fix wrong node passed to find nargs_prop
Message-ID: <20211221104659.2f8af03a@fixe.home>
In-Reply-To: <d9f5b201-2a00-799d-3a0f-7c9709d77102@gmail.com>
References: <20211220210533.3578678-1-clement.leger@bootlin.com>
 <CAHp75Vf+F2L4EFmokRYD+-M9hSuz+SbiiWnqHvFZttRyfKS-mg@mail.gmail.com>
 <d9f5b201-2a00-799d-3a0f-7c9709d77102@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, 20 Dec 2021 23:37:07 +0000,
Daniel Scally <djrscally@gmail.com> a écrit :

> Thanks Andy
> 
> On 20/12/2021 22:13, Andy Shevchenko wrote:
>  [...]  
> 
> I think this is right (it's not used in the ACPI version, and the OF
> version is quite convoluted so a bit hard to follow)...but also I note
> that none of the users of fwnode_property_get_reference_args() pass
> anything to nargs_prop anyway...do we even need this?

Indeed, this is currently not used anywhere, nargs is always used
instead of nargs_prop. The usage is meant to be (almost) the same as
of_parse_phandle_with_args().

ie:

 ret = of_parse_phandle_with_args(node, "resets", "#reset-cells",
				  index, &args);

can be replaced by:

 ret = fwnode_property_get_reference_args(node, "resets",
					  "#reset-cells", 0 index,
					  &args);

I have some patches that uses that with software nodes and that will
need this support.

> 
> Use the correct reference node in call to
> >     property_entry_read_int_array() to retrieve the correct nargs value.
> > 
> >     Fixes: b06184acf751 ("software node: Add
> >     software_node_get_reference_args()")  
> 
> I think this might have been introduced later...maybe 996b0830f95d1,
> maybe e933bedd45099

From what I saw, it was already in the original commit adding this but
I can be wrong.

> 
> >     Signed-off-by: Clément Léger <clement.leger@bootlin.com
> >     <mailto:clement.leger@bootlin.com>>
> >     ---
> >      drivers/base/swnode.c | 2 +-
> >      1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> >     diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> >     index 4debcea4fb12..0a482212c7e8 100644
> >     --- a/drivers/base/swnode.c
> >     +++ b/drivers/base/swnode.c
> >     @@ -529,7 +529,7 @@ software_node_get_reference_args(const struct
> >     fwnode_handle *fwnode,
> >                     return -ENOENT;
> > 
> >             if (nargs_prop) {
> >     -               error =
> >     property_entry_read_int_array(swnode->node->properties,
> >     +               error =
> >     property_entry_read_int_array(ref->node->properties,
> >                                                           nargs_prop,
> >     sizeof(u32),
> >                                                          
> >     &nargs_prop_val, 1);
> >                     if (error)
> >     -- 
> >     2.34.1
> > 
> > 
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> >   



-- 
Clément Léger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
