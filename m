Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75940534A09
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 06:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245275AbiEZEzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 00:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiEZEzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 00:55:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB49BA563;
        Wed, 25 May 2022 21:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AB33B81F52;
        Thu, 26 May 2022 04:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD327C385A9;
        Thu, 26 May 2022 04:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653540948;
        bh=oZ+I6TDmQs9q1v5bWWln6OxdEcIwohbwhkD9F724NiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOUrYenLVDJ+DgKGJwX+ZWcUw1VMOEBMCENn5Iu3Iezo1lPWMWk8muUU8XSwVMVIN
         nAuAN/9VQUxIvOnlXiIxg0/jZ6s+r0K50XuRUAsskleRRLIPhxPdEkdUexV/KOAoKE
         ww92/aJOYdeAjbulbl/3vXZPNq4zeONFnXn+9Pz/ZAtxR6lM9DAgyE9MgOe05CYnNu
         hdlFaRYGAukK+s3GbxGv9XS8WpbYm7GE7/gsE5aDS1AfLNxAEYM26cupMsz8AW5WMO
         wXkUIMs9nM+P5RihDOIqz+1a3C1w+hh8tuakZqSkKHEby1/bXyMs04AIMJZ8YoCnjF
         qah+Gm+rvgnmw==
Date:   Thu, 26 May 2022 07:54:03 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v7 01/25] kallsyms: avoid hardcoding the buffer size
Message-ID: <Yo8H6/CgjmvtC3Qz@iki.fi>
References: <20220523020209.11810-1-ojeda@kernel.org>
 <20220523020209.11810-2-ojeda@kernel.org>
 <YovkR56ZYsPhDW4q@kernel.org>
 <CANiq72=K4eC5EX9M8YRzL5Uy9onoTzha9rki-XZ3enSPy0p+UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=K4eC5EX9M8YRzL5Uy9onoTzha9rki-XZ3enSPy0p+UQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 06:21:14PM +0200, Miguel Ojeda wrote:
> On Mon, May 23, 2022 at 9:46 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > "Declare KSY_NAME_LEN, which describes the maximum length for a kernel
> > symbol read by kallsyms from the input.  In read_symbol(), define the
> > buffer to be of length "KSY_NAME_LEN + 1", which includes the terminator
> > character."
> >
> > would be better.
> 
> Note that the patch is not declaring `KSYM_NAME_LEN`, but a new
> constant for a fairly arbitrarily sized for an input buffer.
> 
> I am all for detailed commit messages, and I agree this can be
> expanded. However, I think the first sentence of what you wrote should
> be part of the docs of the constant, and the second one sounds like it
> could be a comment on the code. Something like "Introduce
> KSYM_NAME_LEN_BUFFER in place of the previously hardcoded size of the
> input buffer (...)" would be better for a reviewer.

Inline comment would be sufficient a remainder, and actually a better
idea.

> > You must split this then into two patches:
> 
> Note that the size is not really being increased in a meaningful way
> -- the important bit is the introduction of the relationship between
> constants. The changes are all meant as a replacement for the
> previously hardcoded constant, so I don't think the split is a "must",
> but we can do it.
> 
> We can even split this into 3 patches: clean up the unneeded `sizeof`,
> replace (and, importantly, document) the hardcoded constant, and
> finally introduce the relationship.
> 
> Thanks for taking a look!
> 
> Cheers,
> Miguel

BR, Jarkko
