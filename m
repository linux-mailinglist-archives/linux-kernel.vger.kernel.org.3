Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F615276A1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 11:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbiEOJkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 05:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiEOJka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 05:40:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E754017069
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:40:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j24so1626154wrb.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WBDSSQQFbDeDzTSvos/rDRYh/dMFCsExRy8YhKQEPrs=;
        b=cdq8/UNyDrtZCg/WMP/XkoamOwwvEIWHcXKi/+obNTKzdWykroV9zHGR3IpEOzOYpt
         sJT09YZ2PBMFLAsYAWQToJfk8MF5VcloxVTEg3JRlm9MaA9E+0dcOylnW9fCXzyB7xOp
         NEatr0eiovkfyIEQ7WQI/tELCMQ0aayPFqQNlibhBeMZKRU6PsbhSc1u8OpSkbiQK43G
         uRLK6gVDzKOm42ucvZt/7cL+tGq7c28Gd+Gw1h7LLTlfkAdsgho68JmzGdSibyrd+g0I
         5Cj4QdTW2HK+6armlMMSFeVU06Eq10PpUga6DCDldUev1DqKXkF4cathHA/hR9S51g+g
         +VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WBDSSQQFbDeDzTSvos/rDRYh/dMFCsExRy8YhKQEPrs=;
        b=1scrqfp1aSncUvG4siQIwd5piuStfXIt9EOvkcpYuESdxiQ4Ln1WWKL7rMZgeGRLaT
         zm/Oo6IUVJIwzBOCvGOV4uj7CyB0WNcftvxJ/shd2e5HKj5IflNqP9Fmn1GenfqjB64I
         uD6oMeRD4WqKBBBClIwEQfR/kiU9AH75IF9dzanZaD0ado8xJ6T/I3pF0apADxIOTNZf
         lTGj1yx4hMFaXvj0HiI347OmBWWwxLAxc8mldyeX05PhATaspFD185Pg0VmtBXVSBsbs
         3kR2K0Cup8YQsnsj4ISO5cPua0dha6n5zarzQ645lP4nx5y3KEqdirrbdRlUSlkOrfAp
         DSRA==
X-Gm-Message-State: AOAM531ixpIvlsd+EjGKj8GHIL9I4H/GOtWQdTbuuWNc2vFJMKBdo/7C
        OGVgv0XA7KvU/snoluPAFsQjPg==
X-Google-Smtp-Source: ABdhPJzvN277srGRw3S3NzyBg1+aEBUHRXtTIDItBg2OkiuIHetjFs5+009tyBgGiyIvoX7RTWWhrQ==
X-Received: by 2002:a05:6000:2aa:b0:20c:5a12:20dc with SMTP id l10-20020a05600002aa00b0020c5a1220dcmr10584952wry.316.1652607627497;
        Sun, 15 May 2022 02:40:27 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id d9-20020adfc089000000b0020cf071a168sm6071552wrf.29.2022.05.15.02.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 02:40:26 -0700 (PDT)
Date:   Sun, 15 May 2022 10:40:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Adam Langley <agl@google.com>,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 1/1] sign-file: Do not attempt to use the ENGINE_* API
 if it's not available
Message-ID: <YoDKiAfcFiyFRyQT@google.com>
References: <20211005161833.1522737-1-lee.jones@linaro.org>
 <Yicwb+Ceiu8JjVIS@google.com>
 <202203100851.C00D9AB73@keescook>
 <YoCoySEUSzu9zthg@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YoCoySEUSzu9zthg@eldamar.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 May 2022, Salvatore Bonaccorso wrote:

> Hi,
> 
> On Thu, Mar 10, 2022 at 08:51:56AM -0800, Kees Cook wrote:
> > On Tue, Mar 08, 2022 at 10:31:11AM +0000, Lee Jones wrote:
> > > OpenSSL's ENGINE API is deprecated in OpenSSL v3.0.
> > >
> > > Use OPENSSL_NO_ENGINE to ensure the ENGINE API is only used if it is
> > > present.  This will safeguard against compile errors when using SSL
> > > implementations which lack support for this deprecated API.
> > 
> > On Fedora rawhide, I'm still seeing a bunch of warnings:
> > 
> > scripts/sign-file.c: In function 'display_openssl_errors':
> > scripts/sign-file.c:89:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecat
> > ed-declarations]
> >    89 |         while ((e = ERR_get_error_line(&file, &line))) {
> >       |         ^~~~~
> > In file included from scripts/sign-file.c:29:
> > /usr/include/openssl/err.h:411:15: note: declared here
> >   411 | unsigned long ERR_get_error_line(const char **file, int *line);
> >       |               ^~~~~~~~~~~~~~~~~~
> > scripts/sign-file.c: In function 'drain_openssl_errors':
> > scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdepreca
> > ted-declarations]
> >   102 |         while (ERR_get_error_line(&file, &line)) {}
> >       |         ^~~~~
> > /usr/include/openssl/err.h:411:15: note: declared here
> >   411 | unsigned long ERR_get_error_line(const char **file, int *line);
> >       |               ^~~~~~~~~~~~~~~~~~
> 
> FWIW, we are seeing the same now on Debian as Debian unstable is
> moving to OpenSSL 3.0.
> 
> https://lists.debian.org/debian-release/2022/05/msg00070.html

Did this patch help?

We've had a few confirmed reports now.

My guess is the maintainers are not currently monitoring.

With some more {Reviewed,Tested}-bys I'd be prepared to submit this
via other means.  Either via my own repository or via Greg's.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
