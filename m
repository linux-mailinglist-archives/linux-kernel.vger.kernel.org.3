Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3290E5B0A06
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiIGQ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIGQ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:27:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8946EF19
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662568027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vBzsv5MucxF7fpQumcXaCPDS2to+ai1JGTJ4XuvQScg=;
        b=ZNtQ5qkGoiWDBpFTMrSKNEIQCGOzZXZMItAk5YZ9zlxI0++4Ie69HYZdfeHDDr6BmGLMM3
        kw8frqFKnat92QubVcUaSe/dyjGSe+9ajei8TJzCu8+WL9345Gj56qRUS6rxwOeESTPrIp
        xhmD+fb8u8OZJpTxAlrxq3tMHZh4j7E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-448-EG8pfIBaPrmsf_dMFhFhGA-1; Wed, 07 Sep 2022 12:27:05 -0400
X-MC-Unique: EG8pfIBaPrmsf_dMFhFhGA-1
Received: by mail-wr1-f69.google.com with SMTP id k17-20020adfb351000000b00228853e5d71so3084817wrd.17
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 09:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=vBzsv5MucxF7fpQumcXaCPDS2to+ai1JGTJ4XuvQScg=;
        b=tjI6Qjg0/H0yHOkznEl5Ohywz+9ULEIpq4iutREmM7LJIE9WmVBzCS0XCUSgY+1Fsy
         i+tV+Zsuuv1HOXM/serSDQJ5Qk0kjUVBU/t7bZ6Uj7mXobWOJ4DXnaH/nQMjMuNYR9VD
         PfstFRQ0lB1+Ra0Vh+yibFp9n8t2rovgyCNjQ0HMCNYmA70kEHtL1s3XCOuXBOPAui8y
         /H5T1u1VoEjHeqHYl6xS0YvAWwkZQlNURJKBu7YWSFkbdjN/x2TdH3wmqx3639tuI8aE
         5JozXu+dUMOK3y7BpceTGPqUf+vKAXnhbBy7liToR/T4Rfnzkxgvabcf6FjicheMoTFL
         qWqg==
X-Gm-Message-State: ACgBeo1CR8OzeUsbDrkN4oGIARVE+W02t4EV1p4nnN536CMHUO1H2xXY
        cDOYNpt8Z0ousDCPHk5RrbtlDiYljUA16xVWzG8G6ocOmCXRkHKoTxHqq6wJjRB8zXWvZYmuqyj
        3embnXbQa5QaxFfNK+3T5dEkp
X-Received: by 2002:a05:6000:1685:b0:225:309f:72a with SMTP id y5-20020a056000168500b00225309f072amr2581174wrd.644.1662568024776;
        Wed, 07 Sep 2022 09:27:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4gDw6a7c/9hn4eac3DD365aIhFTrFHITe7NqhcknWkU4XxudtynHARuWVrqMZJ+JVqeomlGw==
X-Received: by 2002:a05:6000:1685:b0:225:309f:72a with SMTP id y5-20020a056000168500b00225309f072amr2581157wrd.644.1662568024590;
        Wed, 07 Sep 2022 09:27:04 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b003a8418ee646sm29367686wmq.12.2022.09.07.09.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:27:04 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 1/4] lib/find_bit: introduce FIND_FIRST_BIT() macro
In-Reply-To: <20220827175807.4017673-2-yury.norov@gmail.com>
References: <20220827175807.4017673-1-yury.norov@gmail.com>
 <20220827175807.4017673-2-yury.norov@gmail.com>
Date:   Wed, 07 Sep 2022 17:27:03 +0100
Message-ID: <xhsmhh71jb160.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/22 10:58, Yury Norov wrote:
> Now that we have many flavors of find_first_bit(), and expect even more,
> it's better to have one macro that generates optimal code for all and makes
> maintaining of slightly different functions simpler.
>
> The logic common to all versions is moved to the new macro, and all the
> flavors are generated by providing an FETCH macro-parameter, like
> in this example:
>
>   #define FIND_FIRST_BIT(FETCH, MUNGE, size) ...
>
>   find_first_ornot_and_bit(addr1, addr2, addr3, size)
>   {
>         return FIND_NEXT_BIT(addr1[idx] | ~addr2[idx] & addr3[idx], /* nop */, size);
>   }
>
> The FETCH may be of any complexity, as soon as it only refers
> the bitmap(s) and an iterator idx.
>
> MUNGE is here to support _le code generation for BE builds. May be
> empty.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Just one small comment below about the /* nop */, regardless:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

>  unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
>  {
> -	unsigned long idx;
> -
> -	for (idx = 0; idx * BITS_PER_LONG < size; idx++) {
> -		if (addr[idx])
> -			return min(idx * BITS_PER_LONG + __ffs(addr[idx]), size);
> -	}
> -
> -	return size;
> +	return FIND_FIRST_BIT(addr[idx], /* nop */, size);

FWIW I thought passing an explicit identity-mapping macro would make things
a bit clearer, but not really since you have to hunt for where that macro
is defined (an inline "lambda x : x" would have been perfect :-)), so I
think what you've gone for is the lesser evil.

>  }
>  EXPORT_SYMBOL(_find_first_bit);

