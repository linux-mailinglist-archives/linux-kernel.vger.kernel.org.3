Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252835B0A07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiIGQ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIGQ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F7E74BBB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662568034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iUG7ipBQJG4ElP9WSHKRtIVI/ADILdvncswgytp05ik=;
        b=QJ8jFabncusVNauYh118088wNksooNKdMvTpoACBWi/ya9IGCQ8s21YyTyzsLcnBEHe/m8
        a43PIZ5kNSuAgSFyKMQk7T2F5Ryf/KECoTeAz2C5BJfr9kMD3dIDOzk4L6MplX2BcaHp4z
        DTs/9hS6lEe51LWfVgQNa4jMnYtqYc8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-463-S_wa12I9MHmZiKYGF7VXhQ-1; Wed, 07 Sep 2022 12:27:13 -0400
X-MC-Unique: S_wa12I9MHmZiKYGF7VXhQ-1
Received: by mail-wm1-f72.google.com with SMTP id j19-20020a05600c1c1300b003ab73e4c45dso8091350wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 09:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=iUG7ipBQJG4ElP9WSHKRtIVI/ADILdvncswgytp05ik=;
        b=aGKxNlemauL/WcHzMIO7ozfvN+hbnxX4qi2ffWS6DzEpUcsPKcIm6Q2eoRdoPv3GtX
         Yf4VYoexoJHGsRi9bi4EaLMmY9ZT7SrYIOqfqPuc3YjoHHvVi6W7LVQJ9TG9hLjRpBHv
         tAMkUZQaUP/KeJ3wXhR/t3f3yxQxnBhWMWqYEOrx7AQJDnNMaT8QA332RD9fAir5mWgA
         N/j/TD1FwOFigBYV7UDA265Di9qDCVx+yqrIzIIuvqt6IZsFHOslSvv9wJ2HnJ7uczRc
         57FdTi3NYF4pVYIEzfk3eFn9m/QpLfzgyd/LWnXyGsCFNJ3SUgQU58N1Ehijko8sgACf
         z/Gw==
X-Gm-Message-State: ACgBeo1F4diwXlD7rKOApTQiLpjDFIUlmgu6cWVi9JH5vksquxJOc1YE
        ncsty7uuIe4SloLugJ5GMoiQ0JD2iYkkiIupyfzY8i1hl5BfMElzfCFt5tGdfiTKGfYMfXyG09D
        jN4BpesMmYQnbj3peABdZwg2V
X-Received: by 2002:a05:6000:15ce:b0:226:f2ab:516d with SMTP id y14-20020a05600015ce00b00226f2ab516dmr2670896wry.264.1662568029548;
        Wed, 07 Sep 2022 09:27:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6ZYMR/UhmI3sgudI816PoCH/S1miVEIlebjV/iV5juSTnvZHaWPtk1L8mi7mTElMFYF940/Q==
X-Received: by 2002:a05:6000:15ce:b0:226:f2ab:516d with SMTP id y14-20020a05600015ce00b00226f2ab516dmr2670880wry.264.1662568029403;
        Wed, 07 Sep 2022 09:27:09 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600003c100b00226332f9275sm17312579wrg.22.2022.09.07.09.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:27:08 -0700 (PDT)
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
Subject: Re: [PATCH v3 3/4] lib/find_bit: optimize find_next_bit() functions
In-Reply-To: <20220827175807.4017673-4-yury.norov@gmail.com>
References: <20220827175807.4017673-1-yury.norov@gmail.com>
 <20220827175807.4017673-4-yury.norov@gmail.com>
Date:   Wed, 07 Sep 2022 17:27:08 +0100
Message-ID: <xhsmhfsh3b15v.mognet@vschneid.remote.csb>
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
> +#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)				\
> +({										\
> +	unsigned long mask, idx, tmp, sz = (size), __start = (start);		\
> +										\
> +	if (unlikely(__start >= sz))						\
> +		goto out;							\
> +										\
> +	mask = MUNGE(BITMAP_FIRST_WORD_MASK(__start));				\
> +	idx = __start / BITS_PER_LONG;						\
> +										\
> +	for (tmp = (FETCH) & mask; !tmp; tmp = (FETCH)) {			\
> +		if (idx > sz / BITS_PER_LONG)					\

Does that want to be

                if (idx + 1 >= sz / BITS_PER_LONG)

?

Consider this as used in _find_next_bit() for an all-zero 128-bit wide
bitmap (two ULL's), providing the memory contiguous to the bitmap is also
zero then this will only stop at idx=3, so that's fetching two ULLs too
far.

> +			goto out;						\
> +		idx++;								\
> +	}									\
> +										\
> +	sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(tmp)), sz);			\
> +out:										\
> +	sz;									\
> +})

