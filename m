Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEA052EE51
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350395AbiETOip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345502AbiETOij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:38:39 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB60170663
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:38:38 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y199so7924953pfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IbkmnGlcN/XcFPtYcz0cIGeL3AyDjITw0dhmfbvoZuI=;
        b=HtOl4YtWSIGRx/5+p9qcBzI6jHbYgZ99afRZitk1whsRZqHM0aT90+dKbIJ8ynS6FP
         426GXioQ/JGq/VqMtuacLloUDulszRUBirKkfWJq4za3vQ9ij+/UHc8RE0wq04PRQqdw
         LYVYIGW+mFxuk16aCuQigob9YgYzBRUnIwKKQX02X7miaMea25rXyWl2Kgp8JuRZsf82
         CXzBZD0i1UzayJyteJuBt+jYfmD1BKEHB7jK+2Qo1qEgfbMSvuABvwapyxEIn/DaRd+G
         YA2X1QK9PXVNxG6s/cRdMUt/Qdy3m2t1KyXsYC5qSkARAlvBo0DDQSn0a9NTtgSoiMZr
         L+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IbkmnGlcN/XcFPtYcz0cIGeL3AyDjITw0dhmfbvoZuI=;
        b=R1zVVgO6Ouo7TBS+pEQwQGrSOu4lK6VP/N7NN3cip233ndL+BI6QVzyYnvSE8yjgj0
         6ej3/++8G6EQpJw4JTcAFojafTOSMdQAvD5JQfNfo8FHYiUrs+ufboPypdZ6we3oruvx
         lccOYlS20vMw9OXLAObASoLVeo6BALAHsF7RTEPw3ttJ33tIQRJAM+movMvorPR8JOxW
         nBmWpt4vW4Vr9m1YB+AeX+FK+fZLZDhyn8HJ+KxFPNuRE3taYvisR5Ni/mJiu3QMZWT4
         5J4fWZJPrwHvBWD3sa4/jSAblI1WN3dIHPPMTKFB/5drVGyl9siQw8Zn1HJweylv4O54
         IHow==
X-Gm-Message-State: AOAM5320fMiPMmQnmzociwanKyqYnMnXg6Q+TfHnioHRhOIKjeJQli/L
        Smnye0bxF6G5DppLqOydODw6OQ==
X-Google-Smtp-Source: ABdhPJwoiuRwAD7cP+uyJZK80O6cvq3J5MFmxqh85krr8Z0tJmdsBUXyr9+sLjs3fN10fil3Nr3jCQ==
X-Received: by 2002:a05:6a00:2444:b0:4fd:db81:cbdd with SMTP id d4-20020a056a00244400b004fddb81cbddmr10594109pfj.32.1653057517977;
        Fri, 20 May 2022 07:38:37 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jz10-20020a17090b14ca00b001df54afccb3sm1992213pjb.6.2022.05.20.07.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:38:37 -0700 (PDT)
Message-ID: <b1e7991f-b01e-b29c-954a-0d55e971840e@kernel.dk>
Date:   Fri, 20 May 2022 08:38:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] char/mem: only use {read,write}_iter, not the old
 {read,write} functions
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>
References: <20220520135030.166831-1-Jason@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220520135030.166831-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 7:50 AM, Jason A. Donenfeld wrote:
> Currently mem.c implements both the {read,write}_iter functions and the
> {read,write} functions. But with {read,write} going away at some point
> in the future, and most kernel code made to prefer {read,write}_iter,
> there's no point in keeping around the old code. Actually, this comment
> in __kernel_read() indicates that having both might be plain wrong:
> 
>         /*
>          * Also fail if ->read_iter and ->read are both wired up as that
>          * implies very convoluted semantics.
>          */
>         if (unlikely(!file->f_op->read_iter || file->f_op->read))
>                 return warn_unsupported(file, "read");

Nice, just another bit of wasted space due to not having clearly
defined iter vs non-iter.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

