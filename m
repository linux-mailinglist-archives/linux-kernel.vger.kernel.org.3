Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABE64E6E26
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358437AbiCYGUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244783AbiCYGUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:20:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C549681;
        Thu, 24 Mar 2022 23:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63CD8B82702;
        Fri, 25 Mar 2022 06:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580BFC340F0;
        Fri, 25 Mar 2022 06:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648189108;
        bh=/em523wPrHrMXy1ns5RLZ2JK7crpJDpBf91JK6/TohE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NbpbHIQYgOCJdR0VP0f/kDZT4h6k1EVMWPAjmWnt9nO8yasVLQxhE1pNrrQs8D277
         7WugdecT/3cexjiNLjAKhNmRZfcvBXpyU2cS6MYxKlSZU4jJzfT3Wv8C9VbD62jnp4
         X5Ncj2Kr3AkM/ajuSij56U09B9bmPNExQBxWHQ0NEQFFBXW5H/l284rNKsoBW+t1sO
         +dVNomuEDIgHgz2KkPd3ez+Fjv+oECO1vlf1Ia9vdJMkz03FLqlTZrVEVsBxN0Z/BB
         7bh+OblFXb9uCpKx/+yzL6DBBjFCk+3wmBpKNNJUhUFYU98Her/O/2ER+Kdm/SrhPt
         JlRpxkWtEDwuw==
Date:   Fri, 25 Mar 2022 07:18:22 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
Message-ID: <20220325071822.42917fcc@coco.lan>
In-Reply-To: <20220325062735.0567775b@coco.lan>
References: <20220301201659.45ac94cd@canb.auug.org.au>
        <20220324183329.22c97ea1@canb.auug.org.au>
        <2f33bdce-a002-708a-dd65-7bfb6ebc4cd9@redhat.com>
        <20220324222241.42896e9e@canb.auug.org.au>
        <d1399c72-d729-58f8-ac63-1966f18c028d@redhat.com>
        <20220325085522.731aee73@canb.auug.org.au>
        <20220325062735.0567775b@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 25 Mar 2022 06:27:35 +0100
Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:

> Em Fri, 25 Mar 2022 08:55:22 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> escreveu:
> 
> > Hi Hans,
> > 
> > On Thu, 24 Mar 2022 14:04:28 +0100 Hans de Goede <hdegoede@redhat.com> wrote:  
> > >
> > > So I did some digging and the trick for reproducing any ABI
> > > related warnings is to touch the .rst file which has the
> > > "kernel-abi" reST directive (1) for the ABI subdir you want
> > > to regenerate the ABI docs for.
> > > 
> > > So in this case I did:
> > > 
> > > touch Documentation/admin-guide/abi-testing.rst
> > > make htmldocs &> log    
> > 
> > Looks like missing dependencies :-(  
> 
> Not sure if are there a way to fix this. See, Sphinx doesn't use Makefile 
> dependencies, but, instead, it checks if the .rst file has changed or not.
> So, those tags that include contents from non-rst files, like the ABI ones
> and kernel-doc tags, are not considered by Sphinx when detecting the need
> to re-parse the .rst files that contain such tags.

It sounds that dependencies could added inside an extension using:

	env.note_dependency()

kerneldoc.py already uses it. I'll try to add it also to the other
extensions there.

Thanks,
Mauro
