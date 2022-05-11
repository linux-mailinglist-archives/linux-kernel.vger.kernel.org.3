Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAAE523F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348125AbiEKVZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiEKVZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:25:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC74A6899A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:25:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j6so3023694pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HIWfXQz7kRZQ85ksmcAfNGtsJ5AkaWLd2ccGoBYRMog=;
        b=UcIeEmvNoPh4PVI5f7d37R7zCIYVNm23OYOPAtzxps2DCiixyPPBZiEkYXDS2QX2Db
         c9Urri+NPtwefoFAjOKxkaiYWXY+MjrXy9NdNLiDIp7xToFtFJ/tWRgwgtmoR4v3qFfq
         xnIIQ/vP5DlTTeMETD2WH6zt5IEkxumn6Hu2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HIWfXQz7kRZQ85ksmcAfNGtsJ5AkaWLd2ccGoBYRMog=;
        b=R/Giq4XmPtiDOfBATE4raEVBc4irdut1qx+qsH0K+eB73davbg3lF7jlxJBABMfmjb
         FU4ohmkkVlQyYpNQP5mp3ismB5zxm/SqE77KV/V1hDhVW85RkKZDC1DI/mC5Fk7tE8Le
         gqsOHhVBON6smkqhDIZyDYGH0SamcQsbRZ2lF8r6tI31O5RFAwgbI8myW8LOrGTxHIkK
         6oiD3Xpcw/ck+ybSw6FhHUaPVEsuyk8Fsb/h8QcvqCzRSjXquckFv01rye7B8nnNL+zX
         GzPmUp96KqRfP8SVzNoYKLyeAfouFkKS0i8CWvVf1hnvpXDwOlsDYVN0msLxfNUSvz8U
         c+ug==
X-Gm-Message-State: AOAM532GCUrYLInSFLm9YsL4rTLOI6aPBJR2IvnTkDW3YnHQczPt0beC
        eHEYF7irlCVeIiPo2bM5dUyldxqPC2s9aw==
X-Google-Smtp-Source: ABdhPJzOSvJ7qQ/usfWdppzoDQ4Fg4ElPTDZYeZG0FTS0KGzry4GUEaG9GtO1d5nu+p06X9BjfI91g==
X-Received: by 2002:a05:6a00:1145:b0:4f6:3ebc:a79b with SMTP id b5-20020a056a00114500b004f63ebca79bmr26952276pfm.41.1652304328166;
        Wed, 11 May 2022 14:25:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i64-20020a628743000000b0051008603b66sm2196832pfe.219.2022.05.11.14.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:25:27 -0700 (PDT)
Date:   Wed, 11 May 2022 14:25:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/vsyscall: Remove CONFIG_LEGACY_VSYSCALL_EMULATE
Message-ID: <202205111424.DEB0E3418@keescook>
References: <898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org>
 <202205111104.464A6619@keescook>
 <87k0ardigv.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0ardigv.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 08:36:48PM +0200, Florian Weimer wrote:
> * Kees Cook:
> 
> > On Wed, May 11, 2022 at 10:38:53AM -0700, Andy Lutomirski wrote:
> >> CONFIG_LEGACY_VSYSCALL_EMULATE is, as far as I know, only needed for the
> >> combined use of exotic and outdated debugging mechanisms with outdated
> >> binaries.  At this point, no one should be using it.  We would like to
> >> implement dynamic switching of vsyscalls, but this is much more
> >> complicated to support in EMULATE mode than XONLY mode.
> >> 
> >> So let's force all the distros off of EMULATE mode.  If anyone actually
> >> needs it, they can set vsyscall=emulate, and we can then get away with
> >> refusing to support newer security models if that option is set.
> >> 
> >> Cc: x86@kernel.org
> >> Cc: Kees Cook <keescook@chromium.org>
> >> Cc: Florian Weimer <fweimer@redhat.com>
> >> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> >
> > Sounds legit! Can we switch the default to "none" while we're at it?
> 
> I think that's a userspace ABI break?
> 
> I do not have a *very* strong opinion about this.  For one thing, it
> would be handy example to have that such deliberate  do actually
> happen. 8-)

Right, I'm just suggesting switch the Kconfig default, so systems that
don't care will get that setting, and systems that do care can still
pick what they need.

(But yes, a separate patch, etc)

-- 
Kees Cook
