Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC024D799F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 04:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiCNDW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 23:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiCNDW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 23:22:27 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DDE13E27
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 20:21:18 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 82AAD120584;
        Mon, 14 Mar 2022 03:21:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 229F51E;
        Mon, 14 Mar 2022 03:21:16 +0000 (UTC)
Message-ID: <793b7cd9b229bc9427539c683524572259f2893b.camel@perches.com>
Subject: Re: [PATCH 1/5] x86/alternative: simplify DUMP_BYTES macro
From:   Joe Perches <joe@perches.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sun, 13 Mar 2022 20:21:15 -0700
In-Reply-To: <Yi4zdkj4Ye4iVj7J@localhost.localdomain>
References: <20220311144312.88466-1-adobriyan@gmail.com>
         <e9c77d12092a4f048992f67d3fa0cf363b8614d4.camel@perches.com>
         <Yi4zdkj4Ye4iVj7J@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 229F51E
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: j66q5da877pse6jg7anjz8zm3wwm4ne4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+5DboVlC8isNLi0dGZxHg+oOZHzgAlldI=
X-HE-Tag: 1647228076-344272
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-03-13 at 21:09 +0300, Alexey Dobriyan wrote:
> On Sat, Mar 12, 2022 at 08:36:11AM -0800, Joe Perches wrote:
> > On Fri, 2022-03-11 at 17:43 +0300, Alexey Dobriyan wrote:
> > > Avoid zero length check with clever whitespace placement in the format
> > > string.
> > []
> > > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > []
> > > @@ -66,13 +66,10 @@ do {									\
> > >  	if (unlikely(debug_alternative)) {				\
> > >  		int j;							\
> > >  									\
> > > -		if (!(len))						\
> > > -			break;						\
> > > -									\
> > >  		printk(KERN_DEBUG pr_fmt(fmt), ##args);			\
> > > -		for (j = 0; j < (len) - 1; j++)				\
> > > -			printk(KERN_CONT "%02hhx ", buf[j]);		\
> > > -		printk(KERN_CONT "%02hhx\n", buf[j]);			\
> > > +		for (j = 0; j < (len); j++)				\
> > > +			printk(KERN_CONT " %02hhx", buf[j]);		\
> > > +		printk(KERN_CONT "\n");					\
> > >  	}								\
> > 
> > This could also use %02x and not %02hhx
> 
> I doubt as there is funky stuff possible with 255 and such values.

'"%02hhx", u8' and '"%02x", u8' have the same output as the
u8 is converted anyway given the integer promotions.

https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/

> Format specifiers aren't the purpose of the patch anyway.

IMO: If you are already touching the lines,
     you might as well fix it at the same time.

cheers, Joe

