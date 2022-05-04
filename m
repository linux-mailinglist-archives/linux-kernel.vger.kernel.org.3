Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5809519CB3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347976AbiEDKTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348057AbiEDKTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:19:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047511C129;
        Wed,  4 May 2022 03:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 952BA61ACF;
        Wed,  4 May 2022 10:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97614C385A4;
        Wed,  4 May 2022 10:15:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZXttSzmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651659334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0NDvnCek1kbw8v3M1u2ks8T9tYgYwuJSuSlmeWt9wN4=;
        b=ZXttSzmZ40auAREQDE82/7bmboma7RQf04mBPFZe+rWGuQOTcK+aebW02DlqRb2c9GGHUr
        5TNV+OrdpQ/Q8w85dgDXh3mDwdY0j5/ymG/Fb8wxDTLO082CrtIyox2MsGnHiuixjeP2ZJ
        UmpoHzECaHVOGW3ShZV3kEj91gz9ph4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5c3caf4c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 4 May 2022 10:15:33 +0000 (UTC)
Date:   Wed, 4 May 2022 12:15:31 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Stafford Horne <shorne@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
Message-ID: <YnJSQ3jJyvhmIstD@zx2c4.com>
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
 <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec>
 <YnJI4Ru0AlUgrr9C@zx2c4.com>
 <YnJOCbLtdATzC+jn@zx2c4.com>
 <YnJQXr3igEMTqY3+@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnJQXr3igEMTqY3+@smile.fi.intel.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:07:26PM +0300, Andy Shevchenko wrote:
> On Wed, May 04, 2022 at 11:57:29AM +0200, Jason A. Donenfeld wrote:
> > On Wed, May 04, 2022 at 11:42:27AM +0200, Jason A. Donenfeld wrote:
> > > So more likely is that this patch just helps unmask a real issue
> > > elsewhere -- linker, compiler, or register restoration after preemption.
> > > I don't think there's anything to do with regards to the patch of this
> > > thread, as it's clearly fine. 
> > 
> > The problem even goes away if I just add a nop...
> 
> Alignment? Compiler bug? HW issue?

Probably one of those, yea. Removing the instruction addresses, the only
difference between the two compiles is: https://xn--4db.cc/Rrn8usaX/diff#line-440

So either there's some alignment going on here, a compiler thing I
haven't spotted yet, or some very fragile interrupt/preemption behavior
that's interacting with this, either on the kernel side or the QEMU
side.

(I've never touched real HW for this; I just got nerd sniped when
wondering why my wireguard CI was failing...)
 
Jason
