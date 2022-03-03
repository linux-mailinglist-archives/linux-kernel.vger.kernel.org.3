Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414BD4CC49A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 19:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiCCSGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbiCCSGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:06:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189C91A361C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 10:06:01 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so4487943pju.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ytDVomIxpjGb2qjgXEq93PyaRHm5ANEGEJZH8glaas4=;
        b=CUAbix9MtjcqpRdtyhtGovqmylJLViqR5FtwAP5KKHGga3evvU2Ez85M1aY7CA56W8
         Y7I4vuZJQU5kQOBDbDi6kSq1bWDpn+IbS/Q2WjY7dI2zZLLKsSLd5g4c91/xgUxULnBi
         cmA6IICSF8Z+YtJH7D/7jrXItN6yRbDERVonY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ytDVomIxpjGb2qjgXEq93PyaRHm5ANEGEJZH8glaas4=;
        b=n8NVkHNv4BiFX6zSO+ht5ItaTQQSuwWuc3D9tTNbGCkFNs5YIlI1MnBwFi4sHQXDlT
         38pfwV9nbBUGyjteFNAJ/gcbZYz69mvWiM0Ymwcn6k6pXP9f3c7nlFSR+Jz64IGckzQX
         40LIt8X0o4TpE0gl0hkO/WcEbj5qg9mhCrtjSiWsFUFE3UimdN4RzG2R2jP0Sq7ieV67
         PEcctsTwDRzO2WTlT9UZb/1NUf8Ahajo/f4gJG4J37r6Pc2/4sha9mkyTCCbFiqAQQx/
         1Wzz1d3LmU9QeG6pdF88YwcKS06LSMoT5ZM7heCKBkihWF5jYtyvoUUUSi8NDAX2VHr7
         65sQ==
X-Gm-Message-State: AOAM531d2qY/ZVGAcZXOBsdTDEaC4Bze1EyncjIvTziFAogWbVsPu+uD
        NHu5PVG+r/NC/4kBRIo4Rfb6VQ==
X-Google-Smtp-Source: ABdhPJyimIYUd16cvHRM0gj9aFETprJoM2fd5tAldgzlYqZlMMDbFaBq2Zf+4bMVaNjKn+F2wJ8FRw==
X-Received: by 2002:a17:902:cf0e:b0:14f:8a60:475c with SMTP id i14-20020a170902cf0e00b0014f8a60475cmr37080905plg.146.1646330760447;
        Thu, 03 Mar 2022 10:06:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nn15-20020a17090b38cf00b001b90c745188sm2726192pjb.25.2022.03.03.10.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 10:05:59 -0800 (PST)
Date:   Thu, 3 Mar 2022 10:05:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, Adam Langley <agl@google.com>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH 1/1] sign-file: Use OpenSSL provided define to compile
 out deprecated APIs
Message-ID: <202203031005.5CEDBD659@keescook>
References: <20211005161833.1522737-1-lee.jones@linaro.org>
 <YVyE3Ax1PRtiBwf+@gmail.com>
 <CAL9PXLws4DjvPB=1KNpom3W52pXNauXQ4V==MprDx73YQ1-sgg@mail.gmail.com>
 <YVyKc51r2tfMmQuO@gmail.com>
 <YVyVNkijABL7CxnM@google.com>
 <202203021251.1DB0383C@keescook>
 <YiCJuPTfea5nf1G+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiCJuPTfea5nf1G+@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 09:26:16AM +0000, Lee Jones wrote:
> On Wed, 02 Mar 2022, Kees Cook wrote:
> 
> > On Tue, Oct 05, 2021 at 07:11:02PM +0100, Lee Jones wrote:
> > > On Tue, 05 Oct 2021, Eric Biggers wrote:
> > > 
> > > > On Tue, Oct 05, 2021 at 10:14:58AM -0700, Adam Langley wrote:
> > > > > On Tue, Oct 5, 2021 at 10:01 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > > > > > I ran into these same -Wdeprecated-declarations compiler warnings on another
> > > > > > project that uses the ENGINE API to access OpenSSL's support for PKCS#11 tokens.
> > > > > > The conclusion was that in OpenSSL 3.0, the new API for PKCS#11 support isn't
> > > > > > actually ready yet, so we had to keep using the ENGINE API and just add
> > > > > > -Wno-deprecated-declarations to the compiler flags.
> > > > > >
> > > > > > Your patch just removes support for PKCS#11 in that case, which seems
> > > > > > undesirable.  (Unless no one is actually using it?)
> > > > > 
> > > > > The patch removes support when OPENSSL_NO_ENGINE is defined, but
> > > > > that's not defined by default in OpenSSL 3.0. (Unless something
> > > > > changed recently.)
> > > > > 
> > > > > When OPENSSL_NO_ENGINE is defined, ENGINE support is not compiled into
> > > > > OpenSSL and the headers don't include the functions:
> > > > > https://github.com/openssl/openssl/blob/master/include/openssl/engine.h
> > > > > .
> > > > 
> > > > Okay so this patch is actually a build fix for when OpenSSL doesn't include
> > > > ENGINE support?
> > > 
> > > Correct.
> > > 
> > > > Currently this patch claims that it's removing the use of a
> > > > "deprecated" API, which is something entirely different.
> > > 
> > > I see your point.
> > > 
> > > Happy to rejig the commit message if that would help.
> > 
> > *thread necromancy*
> > 
> > Hi,
> > 
> > These warnings are quite noisy on Fedora rawhide and other distros that
> > have moved to OpenSSL 3.0. It's not clear to me from this thread if this
> > patch is actually the correct fix?
> 
> I believe it is the correct fix.
> 
> However the commit message seemed to cause Eric some confusion.
> 
> Would you like me to resubmit?

Yes, please. :)

> It would be nice to get some input from the maintainers at one point.

David, do you have an opinion on this? I'd like to see this fixed so
that rawhide builds stop spewing warnings.

Thanks!

-Kees

-- 
Kees Cook
