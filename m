Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D1F559AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiFXNpY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Jun 2022 09:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiFXNpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:45:20 -0400
Received: from relay5.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AD72619
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:45:18 -0700 (PDT)
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 8FBE0348F7;
        Fri, 24 Jun 2022 13:45:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 4145220015;
        Fri, 24 Jun 2022 13:45:15 +0000 (UTC)
Message-ID: <ca26910886a765dd7edc4815ef90bedbd0f99a95.camel@perches.com>
Subject: Re: [PATCH v2 01/12] regmap-irq: Convert bool bitfields to unsigned
 int
From:   Joe Perches <joe@perches.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 24 Jun 2022 06:45:14 -0700
In-Reply-To: <Z2ggoG49naOiT1BMxPbsMc2zOjAUEnha@localhost>
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
         <20220623211420.918875-2-aidanmacdonald.0x0@gmail.com>
         <CAHp75VfTqTfMsrdqyqRj61JAAJ4a_h3rrFriY2d+rrqpVviy=w@mail.gmail.com>
         <YrWqAqGUuy8Z0F3x@sirena.org.uk>
         <4937c0cc9dbc9d06cb626465bd37cbcf76c80a0b.camel@perches.com>
         <Z2ggoG49naOiT1BMxPbsMc2zOjAUEnha@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: oj1mfyszgctb9y5x9ca7yk88ouwo3wmz
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4145220015
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX199JvKTOf4Uzq/iWnRzovqBECkde32PCfU=
X-HE-Tag: 1656078315-170775
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-24 at 14:05 +0100, Aidan MacDonald wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > On Fri, 2022-06-24 at 13:11 +0100, Mark Brown wrote:
> > > On Thu, Jun 23, 2022 at 11:26:10PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Jun 23, 2022 at 11:13 PM Aidan MacDonald
> > > 
> > > > > Use 'unsigned int' for bitfields for consistency with most other
> > > > > kernel code.
> > > 
> > > > There is no point to convert the fields you are about to remove.
> > > 
> > > > So, either don't touch them or make this patch closer to the end of the series.
> > > 
> > > It costs us nothing to convert them, this isn't a difficult or hard to
> > > understand refactoring - the patch is fine the way it is.
> > 
> > Modulo the defects that might be introduced if an overflow occurs.
> > 
> > struct foo {
> > 	unsigned int a:1;
> > 	bool b:1;
> > }
> > 
> > Assign a non-zero int without bit 0 set to each and see if
> > a and b differ.
> 
> Bool permits implicit pointer-to-bool conversions, so it isn't free
> of pitfalls either.

Care to describe some of those pitfalls?
I can't think of any off the top of my head.

> Overflow is probably more dangerous in general,
> but here there's little chance of pointers or overflow getting involved.

I don't know _this_ code at all, nor have I read it.

If all the conversions are just deleted later, then of course
it should not be converted at all.

I'm just commenting on the proposed refactoring.

I'm trying to show that conversions of bool:1->unsigned int:1
as being trivial are not so trivial after all.

It's fairly common to have code like:

	[bool] foo.bar = some_value & SETTING;

where some value is tested for a mask/bit and a non-zero is true.

So conversions of foo.bar from bool:1 to unsigned int:1 are not
wise unless all possible side effects are known.

