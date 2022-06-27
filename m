Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE4255C9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240732AbiF0TuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbiF0TuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1931F1BE8B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656359418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aY3BGsAPWXJIRlV7BW/+M56z3wTEg8cyWf2FbY9hbGQ=;
        b=Gsw3Yx4aZRmv6mgFZxLmAvVQgieSVVsxeCrqqG5Q1LiE/GwnCNedZDnmgDkS2EaCLZjrPt
        5UKxMHs08lpxrzZ5qwvw3k9K9MkgVIIx3HXkScGY14ZBsXFbIAzIj7cA/zOiqQwu5Na4HO
        wt7QJe97iUxl8ICJYfS2Np1GU5gE6To=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-JvCL5t6VMPCYYZI83CU9EA-1; Mon, 27 Jun 2022 15:50:16 -0400
X-MC-Unique: JvCL5t6VMPCYYZI83CU9EA-1
Received: by mail-ed1-f69.google.com with SMTP id y5-20020a056402358500b0043592ac3961so7800791edc.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aY3BGsAPWXJIRlV7BW/+M56z3wTEg8cyWf2FbY9hbGQ=;
        b=x8NBW319pXUXzkqywe0lZyWdcROxwvvGZnNnsB040GiVSwUmAwsBrpJjHFA3Qg0eyV
         Fze2gFS0pWSQI5yDC9qXR5f51tEJmsrCVMvIf7LHFVDxdfiwgDu20ZbjLL1Z58uj48Yf
         sBLMnlUSIBTK7NVJko8DWgqgM077k6EfCGjKJcgH6khrTlzQx5/ZN5/5mbAbGqpYRsGu
         kM8UDKMFedM3f9aJCffPnC/2FwBx/GZaK0Vi2W4/moQ4A5h0vXJQyDKZTYbkXS+kJqjA
         7Axq2MCzimc3Czyq9xTaEuvYuHDFK942Pfk68YOtKiYjUXI6tlxKQ2oWdSs9wVXBXS6+
         z9AQ==
X-Gm-Message-State: AJIora+/vFc2L5wAt/+L3+fhdDUpjYdmUsLLi9uWsA1h+J8n+Zr7+LVv
        WLzcHEO4JKnjysfsR16dO1s+K6AVRlAY8OKVuNtAK/f0ELhzdNqun6SGaaq5Ac57FzIjF1q2A7V
        1u1Lds/yUqKvHHRL7CwuUfBxZhkG9eZsatDWZFRZW
X-Received: by 2002:aa7:c7cc:0:b0:435:81f5:2021 with SMTP id o12-20020aa7c7cc000000b0043581f52021mr18734037eds.62.1656359415716;
        Mon, 27 Jun 2022 12:50:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tEuFxoP8I8/hLDGv9l/Zdwg7W+hqUq1QVeylsUNVGisYwFrgcDJGy6PJPqeWWvuRE1Uig29ILMJgLnusfRYfg=
X-Received: by 2002:aa7:c7cc:0:b0:435:81f5:2021 with SMTP id
 o12-20020aa7c7cc000000b0043581f52021mr18734023eds.62.1656359415585; Mon, 27
 Jun 2022 12:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220620131618.952133-1-vdronov@redhat.com> <20220621150832.1710738-1-vdronov@redhat.com>
 <YrkFiM+Y2G7a50z5@gondor.apana.org.au>
In-Reply-To: <YrkFiM+Y2G7a50z5@gondor.apana.org.au>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Mon, 27 Jun 2022 21:50:04 +0200
Message-ID: <CAMusb+SOk3TW5q6q6-QNjimupaX+V-DMS==RdQinZ+jLRrADOQ@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: fips - make proc files report fips module name
 and version
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Simo Sorce <simo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Herbert,

On Mon, Jun 27, 2022 at 3:19 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Tue, Jun 21, 2022 at 05:08:32PM +0200, Vladis Dronov wrote:
> >
> >  #ifdef CONFIG_CRYPTO_FIPS
> >  extern int fips_enabled;
> >  extern struct atomic_notifier_head fips_fail_notif_chain;
> >
> > +#define FIPS_MODULE_NAME CONFIG_CRYPTO_FIPS_NAME
> > +#ifdef CONFIG_CRYPTO_FIPS_CUSTOM_VERSION
> > +#define FIPS_MODULE_VERSION CONFIG_CRYPTO_FIPS_VERSION
> > +#else
> > +#define FIPS_MODULE_VERSION UTS_RELEASE
> > +#endif
>
> Why does this need to be in fips.h? If it's only used by one file
> then it should be moved to the place where it's used.

Indeed, you are right, these defines are used only once, thank you. I'll move
them to fips.c. Let me post v3 to this same thread below.

Just a heads-up, a kernel with this patch builds, boots and a FIPS output is
correct.

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

