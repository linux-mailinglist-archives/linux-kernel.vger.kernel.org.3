Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C64B589378
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiHCUsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbiHCUss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:48:48 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4525C955
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:48:47 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10bd4812c29so22094798fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybP/ElRLkO+EJL+/j9uG30N2lLShN588ns/EY1gUwXs=;
        b=Ciy86lX6LuQK0c5yd6gR52m67WVfapJjjyJqpBfkLvfZMQ/fOScolJAYm98o1FWitT
         b3bG/cJFhkjGnNpxEEwnGbCqGT/Uu9JHWs/h5krFWqmVLMiBzgt4xOX2Y03TVeB4e4Zu
         p8bCkmMuI4XQ6sMTiw+nKNv4elcQtAk7R76f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybP/ElRLkO+EJL+/j9uG30N2lLShN588ns/EY1gUwXs=;
        b=O5xkpTgSz2opezfLOTqOGcz5QCPG/zKzvb2zuCRYVlVKHbf3jq+Xz7adT6+Qcf20jq
         LtjyZg2eXvWmW4R6Gsxn6m2E3FqC8Xa3uSA/BV9j/Xaa7/YYpLK+pUbrxfb5bQWT/lst
         BgebEKYvxEhITt0WSzwFJnvpeWtMd5b0wEhNlnbJiW0WXCpTTQGNMHY2/d030QPPD+cP
         4C3bP2J8n57RLKdKYaTmuZ0TtYTkNVFE2d24Y7gIhvMlpheDs9LbLwYswWHvbUB5ZS9o
         i4qd5SaDPdb/yuxm/OG1Lm0HT2KvtbwPeABaTgNZ8hItBW8OV4bNdzYoIFfNddUQRSLO
         itbg==
X-Gm-Message-State: ACgBeo03Ff4UVmW9sEFCurioe49gT/pwkBcebKGjsB/hBxpZd3dChrFZ
        gHMnSPAdXooi5mlS9M3XCVvYz4CzEEfgcw==
X-Google-Smtp-Source: AA6agR6Pi6FJyT/0rThlppHZ3u5XC/wT5mEGRyhrTrkleoRFd4BLNbyvyy1u+g+0PgWkaln05ppbUA==
X-Received: by 2002:a05:6870:3326:b0:10e:d664:d225 with SMTP id x38-20020a056870332600b0010ed664d225mr2702717oae.139.1659559725940;
        Wed, 03 Aug 2022 13:48:45 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id j7-20020a056808034700b00335713cd3f8sm3619729oie.17.2022.08.03.13.48.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 13:48:45 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id k29-20020a9d701d000000b0061c99652493so12495774otj.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 13:48:44 -0700 (PDT)
X-Received: by 2002:a05:6830:290a:b0:618:b519:53f5 with SMTP id
 z10-20020a056830290a00b00618b51953f5mr9795274otu.237.1659559724240; Wed, 03
 Aug 2022 13:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220504161439.8.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
 <YumpwkIz+S+zDfol@sol.localdomain>
In-Reply-To: <YumpwkIz+S+zDfol@sol.localdomain>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 3 Aug 2022 13:48:08 -0700
X-Gmail-Original-Message-ID: <CAE=gft4_M=9TsbHFEVQO-3BRrQsDia0Mwt0C9OpA6fMcnaDsrw@mail.gmail.com>
Message-ID: <CAE=gft4_M=9TsbHFEVQO-3BRrQsDia0Mwt0C9OpA6fMcnaDsrw@mail.gmail.com>
Subject: Re: [PATCH 08/10] PM: hibernate: Mix user key in encrypted hibernate
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 3:48 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, May 04, 2022 at 04:21:00PM -0700, Evan Green wrote:
> > +/*
> > + * Allow user mode to fold in key material for the data portion of the hibernate
> > + * image.
> > + */
> > +struct uswsusp_user_key {
> > +     /* Kernel returns the metadata size. */
> > +     __kernel_loff_t meta_size;
> > +     __u32 key_len;
> > +     __u8 key[16];
> > +     __u32 pad;
> > +};
>
> Shouldn't the key field be 32 bytes?
>

Short answer: yes, it should, will fix. Long answer: I had used a
hardcoded AEAD algorithm of "gcm(aes)", and was envisioning it being
AES128. But making it accommodate 32 bytes now before this gets set in
stone is a better idea.

> > +/* Derive a key from the kernel and user keys for data encryption. */
> > +static int snapshot_use_user_key(struct snapshot_data *data)
> > +{
> > +     struct shash_desc *desc;
> > +     u8 digest[SHA256_DIGEST_SIZE];
> > +     struct trusted_key_payload *payload;
> > +     struct crypto_shash *tfm;
> > +     int ret;
> > +
> > +     tfm = crypto_alloc_shash("sha256", 0, 0);
> > +     if (IS_ERR(tfm)) {
> > +             ret = -EINVAL;
> > +             goto err_rel;
> > +     }
> > +
> > +     desc = kmalloc(sizeof(struct shash_desc) +
> > +                    crypto_shash_descsize(tfm), GFP_KERNEL);
> > +     if (!desc) {
> > +             ret = -ENOMEM;
> > +             goto err_rel;
> > +     }
> > +
> > +     desc->tfm = tfm;
> > +     ret = crypto_shash_init(desc);
> > +     if (ret != 0)
> > +             goto err_free;
> > +
> > +     /*
> > +      * Hash the kernel key and the user key together. This folds in the user
> > +      * key, but not in a way that gives the user mode predictable control
> > +      * over the key bits. Hash in all 32 bytes of the key even though only 16
> > +      * are in active use as extra salt.
> > +      */
> > +     payload = data->key->payload.data[0];
> > +     crypto_shash_update(desc, payload->key, MIN_KEY_SIZE);
> > +     crypto_shash_update(desc, data->user_key, sizeof(data->user_key));
> > +     crypto_shash_final(desc, digest);
> > +     ret = crypto_aead_setkey(data->aead_tfm,
> > +                              digest,
> > +                              SNAPSHOT_ENCRYPTION_KEY_SIZE);
> > +
> > +err_free:
> > +     kfree(desc);
> > +
> > +err_rel:
> > +     crypto_free_shash(tfm);
> > +     return ret;
> > +}
>
> Just select CRYPTO_LIB_SHA256, and you can use sha256_init/update/final which
> would be much simpler.  Similarly with sha256_data() that is added by the next
> patch; you could just call sha256().

Good idea, will do. Thanks!

>
> - Eric
