Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A69508955
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379062AbiDTNa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379110AbiDTNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:30:54 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70BD4339B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+CoeG1wGEI8/gfMyxtQ5JH5NSEVqNFUDQuUEB1szdvM=;
  b=AEhXO2mE1hpaKTTPfhCAJm2kDZDm+IKMhPsQCDZfeqrnUOkvF3XHJSft
   0uWekxsBgStNaOhDaWn4f9+SepJ845Q0i8JhNvEvztlACkGEvBkg8DZoe
   C2rKv55OG3gHEVEv077nOIw/KnN63OT80cFE6q4+X6CqIIdcGj2M3SCl5
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,275,1643670000"; 
   d="scan'208";a="32524915"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 15:28:03 +0200
Date:   Wed, 20 Apr 2022 15:28:03 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Julia Lawall <julia.lawall@inria.fr>, ira.weiny@intel.com,
        Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
        outreachy@lists.linux.dev, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xen:  Convert kmap() to kmap_local_page()
In-Reply-To: <2940450.687JKscXgg@leap>
Message-ID: <alpine.DEB.2.22.394.2204201525080.2937@hadrien>
References: <20220419234328.10346-1-eng.alaamohamedsoliman.am@gmail.com> <alpine.DEB.2.22.394.2204200759080.2937@hadrien> <2940450.687JKscXgg@leap>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-65486685-1650461283=:2937"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-65486685-1650461283=:2937
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 20 Apr 2022, Fabio M. De Francesco wrote:

> On mercoledì 20 aprile 2022 08:03:05 CEST Julia Lawall wrote:
> >
> > On Wed, 20 Apr 2022, Alaa Mohamed wrote:
> >
> > > kmap() is being deprecated and these usages are all local to the thread
> > > so there is no reason kmap_local_page() can't be used.
> > >
> > > Replace kmap() calls with kmap_local_page().
> >
> > OK, so from a Coccinelle point of view, could we do
> >
> > @@
> > expression e1,e2,x,f;
> > @@
> >
> > e1 =
> > - kmap
> > + kmap_local_page
> >     (e2)
> > ... when != x = e1 // not stored in any location and not passed to
> another function
> >     when != f(...,e1,...)
> >     when != x = e2
> >     when != f(...,e2,...)
> > -kunmap(e2)
> > +kunmap_local(e1)
> >
> > julia
> >
>
> I've never spent sufficient time to understand properly the syntax and
> semantics of expressions of Coccinelle. However, thanks Julia, this code
> looks good and can be very helpful.
>
> Only a minor objection... it doesn't tell when 'e2' has been allocated
> within the same function where the kmap() call is.

OK, thanks for pointing that out.  That seems like a key point that should
be mentioned in log messages.  It's not even visible in the context lines
around the patch.

>
> In the particular case that I cite above, I'd prefer to remove the
> allocation of the page (say with alloc_page()) and convert kmap() /kunmap()
> to use kmalloc() / kfree().
>
> Fox example, this is done in the following patch:
>
> commit 633b0616cfe0 ("x86/sgx: Remove unnecessary kmap() from
> sgx_ioc_enclave_init()") from Ira Weiny.
>
> Can Coccinelle catch also those special cases where a page that is passed
> to kmap() is allocated within that same function (vs. being passed as
> argument to this function) and, if so, propose a replacement with
> kmalloc()?

Sure.  I'll take a look at the precise example Alaa started with and see
if I can come up with something.

thanks,
julia
--8323329-65486685-1650461283=:2937--
