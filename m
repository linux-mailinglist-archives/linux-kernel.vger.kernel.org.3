Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660A35089E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379254AbiDTOAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243224AbiDTOAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:00:03 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6F943496
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3SSJXbjOy1qLhNGe/bTpSNKpfz9W3niG2+rjeL4z3oQ=;
  b=F1RqfgRYhqbxqwAW8IPNwtEdU9s3utkiBmSyM33s/tK87vtA39lDLms7
   ZYZ1ezEJuAYnR7oCrzO9U2fn2sOe7CQHEfHoxmc1XaA3p7stMQNcIVlNU
   ZPlmIehfFMfeB/H7ieZwqZ4Igw0nJ/8AwzOggEnXp1UXOMI0mm3dC1ZAC
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,275,1643670000"; 
   d="scan'208";a="32531422"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 15:57:15 +0200
Date:   Wed, 20 Apr 2022 15:57:14 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Julia Lawall <julia.lawall@inria.fr>, ira.weiny@intel.com,
        Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
        outreachy@lists.linux.dev, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xen:  Convert kmap() to kmap_local_page()
In-Reply-To: <3990312.6PsWsQAL7t@leap>
Message-ID: <alpine.DEB.2.22.394.2204201556330.2937@hadrien>
References: <20220419234328.10346-1-eng.alaamohamedsoliman.am@gmail.com> <2940450.687JKscXgg@leap> <alpine.DEB.2.22.394.2204201538560.2937@hadrien> <3990312.6PsWsQAL7t@leap>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-915472296-1650463034=:2937"
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

--8323329-915472296-1650463034=:2937
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 20 Apr 2022, Fabio M. De Francesco wrote:

> On mercoledì 20 aprile 2022 15:40:10 CEST Julia Lawall wrote:
> >
> > On Wed, 20 Apr 2022, Fabio M. De Francesco wrote:
> >
> > > On mercoledì 20 aprile 2022 08:03:05 CEST Julia Lawall wrote:
> > > >
> > > > On Wed, 20 Apr 2022, Alaa Mohamed wrote:
> > > >
> > > > > kmap() is being deprecated and these usages are all local to the
> thread
> > > > > so there is no reason kmap_local_page() can't be used.
> > > > >
> > > > > Replace kmap() calls with kmap_local_page().
> > > >
> > > > OK, so from a Coccinelle point of view, could we do
> > > >
> > > > @@
> > > > expression e1,e2,x,f;
> > > > @@
> > > >
> > > > e1 =
> > > > - kmap
> > > > + kmap_local_page
> > > >     (e2)
> > > > ... when != x = e1 // not stored in any location and not passed to
> > > another function
> > > >     when != f(...,e1,...)
> > > >     when != x = e2
> > > >     when != f(...,e2,...)
> > > > -kunmap(e2)
> > > > +kunmap_local(e1)
> > > >
> > > > julia
> > > >
> > >
> > > I've never spent sufficient time to understand properly the syntax and
> > > semantics of expressions of Coccinelle. However, thanks Julia, this
> code
> > > looks good and can be very helpful.
> > >
> > > Only a minor objection... it doesn't tell when 'e2' has been allocated
> > > within the same function where the kmap() call is.
> > >
> > > In the particular case that I cite above, I'd prefer to remove the
> > > allocation of the page (say with alloc_page()) and convert kmap() /
> kunmap()
> > > to use kmalloc() / kfree().
> > >
> > > Fox example, this is done in the following patch:
> > >
> > > commit 633b0616cfe0 ("x86/sgx: Remove unnecessary kmap() from
> > > sgx_ioc_enclave_init()") from Ira Weiny.
> > >
> > > Can Coccinelle catch also those special cases where a page that is
> passed
> > > to kmap() is allocated within that same function (vs. being passed as
> > > argument to this function) and, if so, propose a replacement with
> > > kmalloc()?
> >
> > It looks complex in this case, because the allocation is in another
> > function, and it is passed to another function.
>
> This is not the special case I was talking about. In this case your code
> for Coccinelle tells the right proposal and it is exactly what Alaa did in
> her patch (which is good!).
>
> I'm talking about other special cases like the one I pointed to with the
> link I provided. I'm sorry if my bad English made you think that Alaa's
> patch was one of those cases where the page is allocated within the same
> function where kmap() is.
>
> I hope that now I've been clearer :)

Ah, sorry for the misunderstanding.  If you have an example, I can take a
look and propose something for this special case.

julia
--8323329-915472296-1650463034=:2937--
