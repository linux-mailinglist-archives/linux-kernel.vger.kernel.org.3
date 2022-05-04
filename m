Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6829C51AED5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377930AbiEDUP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377927AbiEDUP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:15:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194574F470;
        Wed,  4 May 2022 13:12:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so2051516pji.3;
        Wed, 04 May 2022 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qRWAIQw/IQGnxhtZ+qeDmVqe+g63JTPwUddID9hVwPc=;
        b=HsTg9eY80xoBzua87OWPfgLBMWs7DAv4sFiQ/NmfrLFELHdPbgHvH4VD8HXlXdG1k9
         UtPWzM0CzBSY6Gm//ZROtTDY1A+Iic1UPbfntLMmDMUm9iJbrPnp51q4b3LEQu4XygzG
         ZyVHUyTykEeN0+GxAxqTGRrHNlY3S3Du59/nxud6x8sKx0yPOtVooc32/g8MCwGgvXG6
         vsFdkIci3LA+UbZFy2Exkvw8yX3g/9rVy4wM0kX0X4NfTXcc0ouJ5+zrGi3rmFiTU1i0
         h436xL2b4o16wIFrHTrA2LOqfZ9HlnHZcP9+JOTwiud3UKhhTELl4J98yT2wE2kZpfV9
         cghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qRWAIQw/IQGnxhtZ+qeDmVqe+g63JTPwUddID9hVwPc=;
        b=IBMsxAWtu0dOUbWp1J4FGe1yAIgSoxPR+kk0nmuI4JNGw8rP3U3qTsi6ihkk/xXiOo
         RnyD2HG+x9zqI6a29tc2bRRub25osaIZnoIZQRMSbK1E2tSAjaXthYGyUE66GlM0awm8
         7LoGKemplRNtndFfWHfJNpS5VKnGyUYNAHkryeck0X5A6yeBrepqVzNOwnhTblwUnACQ
         S0Yqybam1VwX7fzIZd1PWJwd14jgj04tT5MQBzUdUjVNzHLylNf8w8w325LUQYrJCeSy
         KH1bogvC7cOfn1RuY1HpV3KqgiOj1kYeDvKLNjRbPqis9KPD/XhTp147dl9NwV2N2DjF
         XSXA==
X-Gm-Message-State: AOAM5326MT3fXuTUKZ0mexEGd4Y1dPwLDAXMXclEvO3OAVFKdnYJ/WWj
        Br8gl/kOQv/LFsxtSzFh+28=
X-Google-Smtp-Source: ABdhPJw0eygHe7YDsvldepG8YCfg1Ft4sqoT4+TIh/1Abp3rkY+dD00P8oCCOu/eRtbyjmdTUMzUug==
X-Received: by 2002:a17:902:ec8c:b0:15e:a371:ad7d with SMTP id x12-20020a170902ec8c00b0015ea371ad7dmr16837828plg.12.1651695137514;
        Wed, 04 May 2022 13:12:17 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id kz2-20020a17090b210200b001cd4989febasm3668308pjb.6.2022.05.04.13.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:12:16 -0700 (PDT)
Date:   Thu, 5 May 2022 05:12:15 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
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
Message-ID: <YnLeH7kBImX5XLNn@antec>
References: <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec>
 <YnJI4Ru0AlUgrr9C@zx2c4.com>
 <YnJOCbLtdATzC+jn@zx2c4.com>
 <YnJQXr3igEMTqY3+@smile.fi.intel.com>
 <YnJSQ3jJyvhmIstD@zx2c4.com>
 <CAHk-=wgb_eBdjM_mzEvXfRG2EhrSK5MHNGyAj7=4vxvN4U9Rug@mail.gmail.com>
 <CAHmME9q_-nfGxp8_VCqaritm4N8v8g67AzRjXs9du846JhhpoQ@mail.gmail.com>
 <CAHk-=wiaj8SMSQTWAx2cUFqzRWRqBspO5YV=qA8M+QOC2vDorw@mail.gmail.com>
 <CAHk-=witNAEG7rRsbxD0-4mxhtijRT8fwSc3QCi5HN1sR=0YcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=witNAEG7rRsbxD0-4mxhtijRT8fwSc3QCi5HN1sR=0YcA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:00:36PM -0700, Linus Torvalds wrote:
> On Wed, May 4, 2022 at 12:51 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But I don't think that it's the browser, actually. Even 'nslookup'
> > refuses to touch it with
> >
> >    ** server can't find א.cc: SERVFAIL
> >
> > and it seems it's literally the local dns caching (dnsmasq?)
> 
> Looks like Fedora builds dnsmasq with 'no-i18n', although "dnsmasq -v"
> also shows "IDN2", so who knows.. Maybe it's some default config issue
> rather than the build configuration.
> 
>                   Linus

Which version of Fedora? I use a pretty vanilla Fedora 34 install and it seems to
be working ok for me.

    shorne@antec $ dig +short א.cc
    147.75.79.213
    shorne@antec $ nslookup א.cc
    Server:         127.0.0.53
    Address:        127.0.0.53#53

    Non-authoritative answer:
    Name:   א.cc
    Address: 147.75.79.213
    Name:   א.cc
    Address: 2604:1380:1:4d00::5

    shorne@antec $ /lib64/ld-linux-x86-64.so.2 --version
    ld.so (GNU libc) release release version 2.33.
    Copyright (C) 2021 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.
    There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
    PARTICULAR PURPOSE.

    shorne@antec $ cat /etc/redhat-release
    Fedora release 34 (Thirty Four)

-Stafford
