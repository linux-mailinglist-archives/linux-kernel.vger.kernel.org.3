Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536914E5236
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiCWMdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCWMdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:33:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940B57B54D;
        Wed, 23 Mar 2022 05:32:16 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22NCVt8l013239
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 08:31:55 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E977015C0038; Wed, 23 Mar 2022 08:31:54 -0400 (EDT)
Date:   Wed, 23 Mar 2022 08:31:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Message-ID: <YjsTOsqiNaURZQLM@mit.edu>
References: <20220322191436.110963-1-Jason@zx2c4.com>
 <YjqVemCkZCU1pOzj@mit.edu>
 <YjqbcQbYHCOpgqGg@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YjqbcQbYHCOpgqGg@zx2c4.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:00:49PM -0600, Jason A. Donenfeld wrote:
> 
> Another variation on that would be to do what this current patch does,
> but only crng_pre_init_inject() on CAP_SYS_ADMIN. But this has the same
> pitfall of only working as intended at cnrg_init=0 but not crng_init=1.
> That's better than nothing, but it's not perfect, and it introduces that
> problem with RNDADDTOENTCNT.

Well, one could argue that "RNDADDTOENTCNT" is a problem that has
always been there, and it already requires CAP_SYS_ADMIN.  So I'm not
sure it makes it any worse.

> > > And perhaps we might consider attempting to deprecate RNDADDTOENTCNT at
> > > some point in the future.
> >
> > That would be a good idea.  :-)
> 
> Oh cool, I'm glad you agree. Let's do that then. Have a preferred path?
> Maybe just a pr_once() saying not to use it?

Probably.  We could get more aggressive (e.g., WARN), but the first
Google search on RNDADDTOENTCNT returned:

	https://github.com/jumpnow/rndaddtoentcnt

So I'm now regretting not silently making it vanish a decade or more ago...

       	   	      	  	   	     - Ted
