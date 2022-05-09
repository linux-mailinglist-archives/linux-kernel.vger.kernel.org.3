Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0DE51F9A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiEIKVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiEIKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6810A18430F
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652091438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8rAG+hhLyyADjfWKc/qIMa3fRClDqyFw6+rAc7ZUweE=;
        b=TBY0qSgrMGaSblfpeABrbY52GYWqUpAD6/5ERWkmHINoqzkTfYmNY854ethXRQjzU3uNIm
        IA2egAh9lQVLHeyi/z7ejkUHwzpJ6ZNLSDkA/79Ch6/3vBUlWaOcz0kltJGz2iTN4KPcwE
        EIwojyGUMPiaVFIJ/Zkk/b2ad2FqFpg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-L_zjo35DOUi2bLfkt6TIZQ-1; Mon, 09 May 2022 06:17:17 -0400
X-MC-Unique: L_zjo35DOUi2bLfkt6TIZQ-1
Received: by mail-ej1-f70.google.com with SMTP id qa15-20020a170907868f00b006f4c89bf2e3so6305402ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 03:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rAG+hhLyyADjfWKc/qIMa3fRClDqyFw6+rAc7ZUweE=;
        b=1ZQ6nr07egpGvR4wynCeqpQdxePXsfrWGXLtcXsTQeaFbNariLYTSbyDPZTV+5aaGC
         zTf2OsoqHuQa/q1sC/e2IjN80lbl0fKB/Lr+CtE5oAL2CRmSD2ARea2ksOkVzibFKfZ6
         Ke69OUa22P6R/vTsWSCJ72byAxs1isc3GQL5IobecZpFKShWPGTG2PP1vJfdQtSirgSK
         rB4bco8c1+tjrHCrhGKU2DEoLZtuvFM8mkdjxzT0hYPeoHOPNrc1XLl0KTvEZCSgTrcU
         RVKiY+P1onQNtLEGj/6vgFt2M+aLgpohMnNWRjTXxVRmNZ4PHb7q4sikZH+t54aacg3g
         bPAQ==
X-Gm-Message-State: AOAM530yYakNAI5FdQXE5nk3zM9D/+dIiIuQK5ehf02LaRZqjwgJQZ2G
        IFJBSPjJ25hotgRkMwp3u/JKRpKDXOEHFCw8DMH4e7azQn8HJA2e6jaqsSXmlQf6bgA29Xjk6gH
        4fJyZaMvNl5iAM/sczUmy5CHNMzgALavmaPxwIOkz
X-Received: by 2002:a50:d08b:0:b0:425:eb86:f36d with SMTP id v11-20020a50d08b000000b00425eb86f36dmr16301831edd.235.1652091436040;
        Mon, 09 May 2022 03:17:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWF5i0r1wWzRnyta1jc1Xzs8fjC2bR2GTrVWYAaiAIuMqphiWE9pkwqenZGV0+CFmZVoPSFTydmMUJBGOVC04=
X-Received: by 2002:a50:d08b:0:b0:425:eb86:f36d with SMTP id
 v11-20020a50d08b000000b00425eb86f36dmr16301818edd.235.1652091435909; Mon, 09
 May 2022 03:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220508130944.17860-1-vdronoff@gmail.com> <3f16033ef08063ef9fcb707010e78bd0@linux.ibm.com>
In-Reply-To: <3f16033ef08063ef9fcb707010e78bd0@linux.ibm.com>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Mon, 9 May 2022 12:17:04 +0200
Message-ID: <CAMusb+Q11JMyOXV0iy4VLJ8yST7L0QrmDUJWOpnvsBxfBzjrdA@mail.gmail.com>
Subject: Re: [PATCH] s390/crypto: add crypto library interface for ChaCha20
To:     freude@linux.ibm.com
Cc:     Patrick Steuer <patrick.steuer@de.ibm.com>,
        Harald Freudenberger <freude@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Harald,

Thank you for your response, review and an ACK. Let me ask Herbert if
he would agree
to add your Reviewed-by and submit (so I do not send v2 just for this).

Best regards,
Vladis


On Mon, May 9, 2022 at 12:10 PM Harald Freudenberger
<freude@linux.ibm.com> wrote:
>
> On 2022-05-08 15:09, Vladis Dronov wrote:
> > From: Vladis Dronov <vdronov@redhat.com>
> >
> > Implement a crypto library interface for the s390-native ChaCha20
> > cipher
> > algorithm. This allows us to stop to select CRYPTO_CHACHA20 and instead
> > select CRYPTO_ARCH_HAVE_LIB_CHACHA. This allows BIG_KEYS=y not to build
> > a whole ChaCha20 crypto infrastructure as a built-in, but build a
> > smaller
> > CRYPTO_LIB_CHACHA instead.
> >
> > Make CRYPTO_CHACHA_S390 config entry to look like similar ones on other
> > architectures. Remove CRYPTO_ALGAPI select as anyway it is selected by
> > CRYPTO_SKCIPHER.
> >
> > Add a new test module and a test script for ChaCha20 cipher and its
> > interfaces. Here are test results on an idle z15 machine:
> >
> > ...skip...
>
> Hello Vladis
> Thanks for your work. Please add my
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
>
> however, always the question who will pick and forward this patch ?
> To me this looks like most parts are common so I would suggest that
> Herbert Xu  will pick this patch.
>

