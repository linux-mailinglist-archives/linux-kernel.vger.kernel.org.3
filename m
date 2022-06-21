Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907BC553498
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351399AbiFUOgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349502AbiFUOgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 329B61C93F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655822162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RSGBimivEze+n4dtbXJkxFNriZUPEE36wmWbROM+6Dg=;
        b=FLBQ8Sw/gJBz/iLRCkOrlLaloCBrjuJd/6sXYKqjeVTDYeGK5nRwPeSJumRD1mYt7wsaxT
        o3HxonE0tCRzcYXfLRbBJNCBEaW1cTLhVFGhwZaGSTDCzlk8seSNLikqy5Vsv249WN9YvO
        aY/lAuPO2ukG9A1m6Wsc4MdVEP3JuDE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-q3rKiIGcNxW4UwhIeW6YSg-1; Tue, 21 Jun 2022 10:36:00 -0400
X-MC-Unique: q3rKiIGcNxW4UwhIeW6YSg-1
Received: by mail-ed1-f69.google.com with SMTP id g8-20020a056402090800b00433940d207eso11154598edz.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSGBimivEze+n4dtbXJkxFNriZUPEE36wmWbROM+6Dg=;
        b=1Hr5c7nWYGY7GbHV3APfXrwfPTlmihCcI6dt1MwPJcXEFpLLwQIDbOUqnBoeRJnZAg
         sTVs7gMn4nRwFJW6P8pLJDLuzT3xxwhwbmSwYbLGAbL21DomID+gkPJyyn3c8dFJgoiX
         OeQqECmlkZmOE+Shr1tbB6RfExHfmSxZGqE3zBqpCoK9NCSWKpLuIr5YhQL4+jyO6NNG
         Yu5U1SG6LVQ/+xVwhYs5tCvOSbzd02ff/54RnYl4GN6l8xTOpBrE+DEJzt5Ylq+Ktek7
         V5mM98VyD22ejbLqsVTypOoxfX1PpiQTcfD4xLFawWwMXMT4hyk9wtXpJYUQkGppow/o
         y2Ig==
X-Gm-Message-State: AJIora80Zg9pk1bjEjnhvNbxLBIqySnminfDYvFAHdKI3neftifHO/R7
        xEJeOpXZSkyKkRafOhqmmvBNIBZkzSrudBaRtEZB3IhIDL0cq8O+3cYn/bj6xxIlbcZzE8vohyE
        sKpaJYlP9zsjBYji8FjVeRo3/1HmSZf5T2cu+aCpk
X-Received: by 2002:a05:6402:2694:b0:42d:e05d:3984 with SMTP id w20-20020a056402269400b0042de05d3984mr35354887edd.419.1655822159528;
        Tue, 21 Jun 2022 07:35:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uccH1oXNG8W/n8lbN+i3vqJggxl37Nh59lCOkVkXH4xWIJYiQHe8SQW9WE7sOdkib7dRLLvyzpRWt0vZP3Vfk=
X-Received: by 2002:a05:6402:2694:b0:42d:e05d:3984 with SMTP id
 w20-20020a056402269400b0042de05d3984mr35354874edd.419.1655822159382; Tue, 21
 Jun 2022 07:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220620131618.952133-1-vdronov@redhat.com> <23bc9020-4519-65ba-725e-e7efd226c192@infradead.org>
In-Reply-To: <23bc9020-4519-65ba-725e-e7efd226c192@infradead.org>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Tue, 21 Jun 2022 16:35:47 +0200
Message-ID: <CAMusb+SaCeFe9maPZEE3JuaF1Q18=zj_Ljb0+HeNABKQwAa+mg@mail.gmail.com>
Subject: Re: [PATCH] crypto: fips - make proc files report fips module name
 and version
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simo Sorce <simo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 20, 2022 at 11:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 6/20/22 06:16, Vladis Dronov wrote:
> > diff --git a/crypto/Kconfig b/crypto/Kconfig
> > index 1d44893a997b..082ff03d9f6c 100644
> > --- a/crypto/Kconfig
> > +++ b/crypto/Kconfig
> > @@ -33,6 +33,27 @@ config CRYPTO_FIPS
> >         certification.  You should say no unless you know what
> >         this is.
> >
> > +config CRYPTO_FIPS_NAME
> > +     string "FIPS Module Name"
> > +     default "Linux Kernel Cryptographic API"
> > +     depends on (CRYPTO_FIPS)
>
> No parentheses.
>
> > +     help
> > +       This option sets the FIPS Module name reported by the Crypto API via
> > +       the /proc/sys/crypto/fips_name file.
> > +
> > +config CRYPTO_FIPS_CUSTOM_VERSION
> > +     bool "Use Custom FIPS Module Version"
> > +     depends on (CRYPTO_FIPS)
>
> Ditto.
>
> > +     default n
> > +
> > +config CRYPTO_FIPS_VERSION
> > +     string "FIPS Module Version"
> > +     default "(none)"
> > +     depends on (CRYPTO_FIPS_CUSTOM_VERSION)
>
> Ditto.
>
> > +     help
> > +       This option provides the ability to override the FIPS Module Version.
> > +       By default the KERNELRELEASE value is used.
>
> --
> ~Randy

Oh dang, indeed. Thanks, Randy.

Let me post v2 to this same thread to reduce separate threads.

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

