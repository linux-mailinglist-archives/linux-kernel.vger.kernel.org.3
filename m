Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9AA55C80D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbiF0K43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbiF0K41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:56:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2D83646E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656327385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Xl9vF88I0l1x6iRqZKVwdiDRgTIUrmB9c17Iw2oT98=;
        b=Re70g5A8hsOsMyB1a+dMTZpOlf1LTxPoNPC7ThYiiHNJfGb8FMCrxvpNDzLde+/ghiP0MA
        oIsjfNu13JW2SwdOp4sVezqBCpcQfn8fbIrwL/YPkW1dwcE+zB32FYTdtkcmeRLfWZb2Hr
        LIVdV8hCHULRCj7+y5K2CglVQ5d7EwM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-OwrQutDhOdyI0KujDsCHpQ-1; Mon, 27 Jun 2022 06:56:24 -0400
X-MC-Unique: OwrQutDhOdyI0KujDsCHpQ-1
Received: by mail-ed1-f69.google.com with SMTP id x21-20020a05640226d500b00435bd7f9367so6893672edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Xl9vF88I0l1x6iRqZKVwdiDRgTIUrmB9c17Iw2oT98=;
        b=WiZu8tVtbyWZkYkTyDZCewyK2lwgzlBsnUtKt4qtHJKULmy5ZTU44/bIMzlVuEXca8
         swPdXLCLfzpOtCRiUxTJnastnwjE1sCpQpadwFkMgaolmRIfXpIZuXEfzxVWr4OtMDP2
         vDe8bsg5DRkYkz8BTDn4YKYxFrB0v/ETqeZMwAB/lixaS2ClXO9SxNIqAr6B43YwYTCL
         lzHBjw+kWtDipiVx3BEQc5dsM78L9Xy1wQw8XECl2ecS0ycOBVFu69NDP1FZdOb5+Drr
         uDpwibpalBScp65U4OsCeFxEcYmxLu3FfQoYTFCSbe+0E4lqPKN+R03w0sGG/5hOMYNx
         WqpA==
X-Gm-Message-State: AJIora9uvC8kn/UqN+KQeRv+5EoGorDhxMIQTeJxmCtlfHt7kLYcJqwW
        YV6Qji8qLXZSIwmLF4cqSyncUXGATPFqhiMmHYaOsD+1ST5djkitDKKAly3yioxsMhKJc9mrDQ6
        TB/okD0IXeohdMuxEAXHSi3f9a4R2YK9UZMsse7+i
X-Received: by 2002:a17:907:72cf:b0:726:9f86:7262 with SMTP id du15-20020a17090772cf00b007269f867262mr5449222ejc.258.1656327383190;
        Mon, 27 Jun 2022 03:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tvaQplfzkWzHWBT8heErdio8gvOFJTnWPbZkehgU/LtNxsGE0usQwC6s3/mUTr9NQxbOIfyc+I6gF16ltz6kE=
X-Received: by 2002:a17:907:72cf:b0:726:9f86:7262 with SMTP id
 du15-20020a17090772cf00b007269f867262mr5449209ejc.258.1656327383024; Mon, 27
 Jun 2022 03:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220627075148.140705-1-code@siddh.me> <9f79f8edfa8f7c5099b842f020782ac2@linux.ibm.com>
In-Reply-To: <9f79f8edfa8f7c5099b842f020782ac2@linux.ibm.com>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Mon, 27 Jun 2022 12:56:12 +0200
Message-ID: <CAMusb+RDvUG9ZmSH0cxqJAXzniDDihsuaWhKu7M8bchatcuUSQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools/testing/crypto: Use vzalloc instead of vmalloc+memset
To:     freude@linux.ibm.com, Siddh Raman Pant <code@siddh.me>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
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

Thanks, Siddh,

This change makes perfect sense.

Thanks, Harald, for helping with this!

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

On Mon, Jun 27, 2022 at 11:54 AM Harald Freudenberger
<freude@linux.ibm.com> wrote:
>
> On 2022-06-27 09:51, Siddh Raman Pant wrote:
> > This fixes the corresponding coccinelle warning.
> >
> > Signed-off-by: Siddh Raman Pant <code@siddh.me>
> > ---
> >  tools/testing/crypto/chacha20-s390/test-cipher.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/crypto/chacha20-s390/test-cipher.c
> > b/tools/testing/crypto/chacha20-s390/test-cipher.c
> > index 34e8b855266f..8141d45df51a 100644
> > --- a/tools/testing/crypto/chacha20-s390/test-cipher.c
> > +++ b/tools/testing/crypto/chacha20-s390/test-cipher.c
> > @@ -252,29 +252,26 @@ static int __init chacha_s390_test_init(void)
> >       memset(plain, 'a', data_size);
> >       get_random_bytes(plain, (data_size > 256 ? 256 : data_size));
> >
> > -     cipher_generic = vmalloc(data_size);
> > +     cipher_generic = vzalloc(data_size);
> >       if (!cipher_generic) {
> >               pr_info("could not allocate cipher_generic buffer\n");
> >               ret = -2;
> >               goto out;
> >       }
> > -     memset(cipher_generic, 0, data_size);
> >
> > -     cipher_s390 = vmalloc(data_size);
> > +     cipher_s390 = vzalloc(data_size);
> >       if (!cipher_s390) {
> >               pr_info("could not allocate cipher_s390 buffer\n");
> >               ret = -2;
> >               goto out;
> >       }
> > -     memset(cipher_s390, 0, data_size);
> >
> > -     revert = vmalloc(data_size);
> > +     revert = vzalloc(data_size);
> >       if (!revert) {
> >               pr_info("could not allocate revert buffer\n");
> >               ret = -2;
> >               goto out;
> >       }
> > -     memset(revert, 0, data_size);
> >
> >       if (debug)
> >               print_hex_dump(KERN_INFO, "src: ", DUMP_PREFIX_OFFSET,
>
> Thanks Siddh
> I'll forward this patch into the s390 subsystem and on the next merge
> window for the 5.20 kernel then it will appear in the upstream kernel.

