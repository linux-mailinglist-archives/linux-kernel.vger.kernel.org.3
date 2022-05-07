Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE551E57D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 10:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383605AbiEGIRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 04:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbiEGIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A8950047;
        Sat,  7 May 2022 01:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFF1E6100E;
        Sat,  7 May 2022 08:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E1AC385A5;
        Sat,  7 May 2022 08:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651911203;
        bh=Sv7oxkCdps+EHbk5WzXCMLJ8G7Y0Yju5oRc79HWO/HA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xOQHnKUDAtvowMXL1NmNn2gNToABnA7ff+rKTV6j5GfGFP0krjaGvvQ33KCRY7A1d
         EF7XLXeyqSMPWR6CVlOfb36TV6paWLrnwkW78ZrZ1NiGgO3lGGCx67uDM8zOmDqiKD
         J+0bhF8jvWTsL53I7SSN2M4L/UkOrdAgw0APMpeo=
Date:   Sat, 7 May 2022 10:13:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Wayne Campbell <wcampbell1995@gmail.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 23/23] [RFC] drivers: android: Binder IPC in Rust
Message-ID: <YnYqHSVakm1EAo5a@kroah.com>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <20220507052451.12890-24-ojeda@kernel.org>
 <202205070050.A870AEAC6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205070050.A870AEAC6@keescook>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 12:55:17AM -0700, Kees Cook wrote:
> On Sat, May 07, 2022 at 07:24:21AM +0200, Miguel Ojeda wrote:
> > From: Wedson Almeida Filho <wedsonaf@google.com>
> > 
> > A port to Rust of the Android Binder IPC mechanism.
> > 
> > This module is a work in progress and will be sent for review later
> > on, as well as separately from the Rust support.
> 
> Is any functionality missing for this driver compared to the C driver?

There is no binderfs support, which would be a major regression if it
were to be added.

And odds are the new binder additions in the past few months are
probably not included here either.

There is a binder regression test in Android that can be run to test all
of this to see what is missing.  That should be a good test of
compatibility.

thanks,

greg k-h
