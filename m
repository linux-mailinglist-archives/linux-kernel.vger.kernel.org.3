Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA05D50E1F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242134AbiDYNgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiDYNgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32BA85F72
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650893625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UqJWCWFq0Pii1oTW8QXvQWCpib7W/X1OWwkM6+ni6Dk=;
        b=XMgHUlQ4rcS6Obhbfc6plfEV+W4D/5AYSP56AeTndPyjolb+FMy3kwn0tXZq5e3LjsS8qQ
        P+dr5Gwve/zPjADxkMAMW8eS2hwjd7Nuv3fz6kaxQYiKkYleMkkNmCPK0lK4IHKmLd5X8a
        2GcdmUMhNMguNjwZJig/wmF7JA5dR0c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-pStr-jH9N5qRAaDNAazn6Q-1; Mon, 25 Apr 2022 09:33:38 -0400
X-MC-Unique: pStr-jH9N5qRAaDNAazn6Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5079B3834C16;
        Mon, 25 Apr 2022 13:33:38 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07E0654C75A;
        Mon, 25 Apr 2022 13:33:38 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 23PDXbKt006460;
        Mon, 25 Apr 2022 09:33:37 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 23PDXaJZ006456;
        Mon, 25 Apr 2022 09:33:37 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 25 Apr 2022 09:33:36 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     David Laight <David.Laight@ACULAB.COM>
cc:     "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: RE: [PATCH] hex2bin: make the function hex_to_bin constant-time
In-Reply-To: <e8de034196df450cb352fa60a570acca@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.2204250912350.5163@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com> <CAHk-=wibmkFz6dybsdpW_3kUnV20FhJazerWDcbm7yCp_Xv+CA@mail.gmail.com> <789f0463ce974e90a93f4dbf8c471156@AcuMS.aculab.com>
 <alpine.LRH.2.02.2204250701410.10912@file01.intranet.prod.int.rdu2.redhat.com> <e8de034196df450cb352fa60a570acca@AcuMS.aculab.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Apr 2022, David Laight wrote:

> From: Mikulas Patocka
> > Sent: 25 April 2022 12:04
> > 
> > On Mon, 25 Apr 2022, David Laight wrote:
> > 
> > > From: Linus Torvalds
> > > > Sent: 24 April 2022 22:42
> > > >
> > > > On Sun, Apr 24, 2022 at 2:37 PM Linus Torvalds
> > > > <torvalds@linux-foundation.org> wrote:
> > > > >
> > > > > Finally, for the same reason - please don't use ">> 8".  Because I do
> > > > > not believe that bit 8 is well-defined in your arithmetic. The *sign*
> > > > > bit will be, but I'm not convinced bit 8 is.
> > > >
> > > > Hmm.. I think it's ok. It can indeed overflow in 'char' and change the
> > > > sign in bit #7, but I suspect bit #8 is always fine.
> > > >
> > > > Still, If you want to just extend the sign bit, ">> 31" _is_ the
> > > > obvious thing to use (yeah, yeah, properly "sizeof(int)*8-1" or
> > > > whatever, you get my drift).
> > >
> > > Except that right shifts of signed values are UB.
> > > In particular it has always been valid to do an unsigned
> > > shift right on a 2's compliment negative number.
> > >
> > > 	David
> > 
> > Yes. All the standard versions (C89, C99, C11, C2X) say that right shift
> > of a negative value is implementation-defined.
> > 
> > So, we should cast it to "unsigned" before shifting it.
> 
> Except that the intent appears to be to replicate the sign bit.
> 
> If it is 'implementation defined' (rather than suddenly being UB)

The standard says "If E1 has a signed type and a negative value, the 
resulting value is implementation-defined."

So, it's not undefined behavior.

> it might be that the linux kernel requires sign propagating
> right shifts of negative values.

It may be that some code in the Linux kernel already assumes that right 
shifts keep the sign. It's hard to say if such code exists.

BTW. ubsan warns about left shift of negative values, but it doesn't warn 
about right shift of negative values.

> This is typically what happens on 2's compliment systems.
> But not all small cpu have the required shift instruction.
> OTOH all the ones bit enough to run Linux probably do.
> (And gcc doesn't support '1's compliment' or 'sign overpunch' cpus.)
> 
> The problem is that the compiler writers seem to be entering
> a mindset where they are optimising code based on UB behaviour.
> So given:
> void foo(int x)
> {
> 	if (x >> 1 < 0)
> 		return;
> 	do_something();
> }
> they decide the test is UB, so can always be assumed to be true
> and thus do_something() is compiled away.
> 
> 	David

If it's implementation-defined (rather than undefined), the compiler 
shouldn't do such optimization.

The linux kernel uses "-fno-strict-overflow" which disables some of these 
UB optimizations.

Mikulas

