Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE1556ACA8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbiGGUZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbiGGUZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0D42409E;
        Thu,  7 Jul 2022 13:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A12B62392;
        Thu,  7 Jul 2022 20:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C967C3411E;
        Thu,  7 Jul 2022 20:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657225543;
        bh=Awv2Q/kTS4EIeMRM5w7rfLsEcGuf97xy2lh+bykwg30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KLNwmustVN5eGr5ZkI+/HO4bQ+3cufL/liGr5otutC/f9mnzhj25zYdshB8Z+txeo
         woO+s5lCXSoqMHk20Z3mWugmutv/9OMlFJ7GeepZ+4uA8juaBwAtRHmxrlRMwKGt8P
         2VAA+BgzaVeC57BG0lVpRYUSYMXNg3TWjBUN+P+M6Q6VDcVDFmeK1XFHKDVcoJNwYj
         eU3cZg1/03G3zU37nNwus8nym9rbrLAH5J7Wjmq3zn9m6lpYuusG2sYTzDn8Iru2Ex
         x2el7+KAEGrBXflV2Yd4BMTzt9N3/odyQwFZ7kVzcVd0El0+g1O0iJ27DI0Abfq22D
         0STQ8ZmwQj6OA==
Date:   Thu, 7 Jul 2022 21:25:36 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+huawei@kernel.org
Subject: Re: [PATCH v2 0/5] Address some issues with sphinx detection
Message-ID: <20220707212536.58026d99@sal.lan>
In-Reply-To: <87ilo8bw3p.fsf@meer.lwn.net>
References: <cover.1656756450.git.mchehab@kernel.org>
        <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
        <87ilo8bw3p.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 07 Jul 2022 12:45:14 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Akira Yokosawa <akiyks@gmail.com> writes:
> 
> > TL;DR, my suggestion of options and defaults to sphinx-pre-install:
> >
> >     --no-pdf (default): for htmldocs only
> >     --no-virtualenv (default): distro Sphinx package
> >          (mention --virtualenv if distro Sphinx package is too young)
> >     --virtualenv: Sphinx by venv/virtualenv
> >     --pdf: for pdfdocs
> >         --no-cjk (default): don't bother with CJK pdfdocs
> >         --cjk: for CJK pdfdocs
> >                (print warning if user's distro doesn't support CJK)
> > Thoughts?  
> 
> I think this makes sense.  As far as I can tell, PDF builds are a
> relative rarity these days, and most people would rather not have to
> deal with virtualenv if they can avoid it.  We should definitely
> emphasize native installs whenever that can work.
> 
> I'm planning to go ahead and apply Mauro's sphinx-pre-install patches
> since they make things better, but then we should look at these tweaks.

IMO it makes sense to apply them, as they address some existing issues
on it. 

We can improve the script later on with Akira's comments and after having 
some discussions about what would be the default behavior that would fit
better.

Regards,
Mauro
