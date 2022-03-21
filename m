Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA084E2565
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346833AbiCULot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241385AbiCULoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:44:44 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 338E21D325
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:43:17 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22LBh5Vw006242;
        Mon, 21 Mar 2022 12:43:05 +0100
Date:   Mon, 21 Mar 2022 12:43:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 6/6] tools/include/string: Implement `strdup()`
 and `strndup()`
Message-ID: <20220321114305.GA6222@1wt.eu>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-7-ammarfaizi2@gnuweeb.org>
 <20220321075308.GD29580@1wt.eu>
 <bdc75a04-6807-290b-72c0-dc44ddeea0a1@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc75a04-6807-290b-72c0-dc44ddeea0a1@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 06:36:37PM +0700, Ammar Faizi wrote:
> On 3/21/22 2:53 PM, Willy Tarreau wrote:
> > Hi Ammar,
> [...]
> > > +static void free(void *ptr);
> > > +static void *malloc(size_t len);
> > > +static void *realloc(void *old_ptr, size_t new_size);
> > 
> > Better include the required h files here.
> 
> I can't do that, in nolibc.h, we have something like this:
> 
> ```
>   #include "stdlib.h" <--- We inlcude string.h from here
>   #include "string.h" <--- This is a no-op.
> ```
> 
> Note, stdlib.h is included first before string.h, next, in stdlib.h, we
> have this:
> 
> ```
>   #include "string.h"
> 
>   // malloc, calloc, free here
> ```
> 
> If I include "stdlib.h" in "string.h", it will just be a no-op, and the
> declarations will not be taken, because the declarations happen after
> #include "string.h". So it doesn't work. It's somewhat circular dependency.
> 
>   stdlib.h needs string.h
>   string.h needs stdlib.h
> 
> One of them must fully see the other before they can use the defined functions
> in another header.

OK, usual stuff indeed.

> Suggestion welcome...

Then just leave it as-is.

> I am thinking of creating a new header just for the forward declarations
> where all function declarations live there, we just split off the real
> functions' body.

That's why I'm doing in my projects for the exact reason above. But
here we only have static functions so this will increase the burden to
contribute. Better wait for the situation to reach a point where we're
certain there will be some benefit in doing that.

Thanks,
Willy
