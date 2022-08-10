Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4071158EC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiHJM7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiHJM7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:59:04 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADDC78231
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 05:59:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 12so14293002pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc;
        bh=G+L32sQ6yPUQhFNYRyxuuIrjAypmobcY2aa8l8iblIo=;
        b=o3UQSB8HNEQYpZ0kguNGRWVKvK+ph92UGFW0WsMEDamEQlc0Jtzh9P1cH3IEt2FVGJ
         x4DZcExWqOzlRsxNLvfPgBTuS5B65Oip1zf+FAyl78gD2n9M7UO5D94gv7c4JQupmDAc
         8xb4zkVxJATHIpwKUXHTolvFGvSVyyr7eP1yFotrLi+5SNkeMydzdoQXpxgI+/DAurcY
         FneyxZpArECjJy+itWLWIYZWgPCTWuVwB36zQ6oJ0CjbjY/biIe6ZKJkcrxZgMxawnVq
         v9XRJwcdK37jBvmZPGxVZ3X92wkN6mOYQ9xvMdgTzl+AvC10Esx4wCtxAfaafWztxp5H
         sKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc;
        bh=G+L32sQ6yPUQhFNYRyxuuIrjAypmobcY2aa8l8iblIo=;
        b=nfWoZ0FnaQYOcx1LaxrGewUSh9fCDTHKSZe33SjORJPSqrcKWhRQcCA7kRvGvUNiRk
         YSvFHy+wC+ddESsQ4WqoiESFxBJigLPxiXHUAGlOuCf7nVnx9gATmuaaK81hMaeJth8f
         dUeeQ22TxVWJCqY0cap2yiFII0lt/fEWoTwtaXsFocIDOoAGlnLCW+z3Ey4CUZ1FXVqI
         MnO68qD9umSrGdaDyTuDfBgPLi2T7x6Y5ROZSPqWhboV42lUTTPxoYWqcGRxHcSUm7wV
         yy/Aqe0w8P508raNFbGlgMkbCdhijVQBjWp+777I5g+amJWmsAAINw0/JvXe5ht0sPJ6
         UPxg==
X-Gm-Message-State: ACgBeo2GEpzH50mMU4KEsREUIJqOWw7M0XPErAi2XTx9A7yqyh5C6CwI
        ONWwjYIeSRjewjKqO7pbkEo=
X-Google-Smtp-Source: AA6agR6OtVsr0Y6zpHd8mkIHb/gkL+lEcLCKQ7AOEB6Xobv8Qs1n/WNUaAepNcLIE55e9s9kM0qM6A==
X-Received: by 2002:a62:3884:0:b0:52b:ead1:7bc8 with SMTP id f126-20020a623884000000b0052bead17bc8mr27648518pfa.78.1660136341459;
        Wed, 10 Aug 2022 05:59:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h2-20020a17090a054200b001f30b5bb378sm1591107pjf.15.2022.08.10.05.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 05:59:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1196e002-c07d-44fd-b07a-aa5ae446ea0b@roeck-us.net>
Date:   Wed, 10 Aug 2022 05:58:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
References: <20220727181936.3250466-1-saravanak@google.com>
 <20220809103052.GA1778649@roeck-us.net>
 <CAGETcx_ATE6vy9YhygHnBA2P1GDVi54np-=E+50F+cwnj6Wg4A@mail.gmail.com>
 <0c6ef9a3-bbb1-9f1c-7f00-ceb05589594e@roeck-us.net>
 <CAGETcx8yKqEthtyd8Zb=mqMBNp1TPRXbQOoFp+OxeCoXnTs2kw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6] amba: Remove deferred device addition
In-Reply-To: <CAGETcx8yKqEthtyd8Zb=mqMBNp1TPRXbQOoFp+OxeCoXnTs2kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 20:33, Saravana Kannan wrote:
[ ... ]

> 
> Can you give me more details on the qemu configuration so I could try
> to reproduce it?

qemu-system-arm -M vexpress-a9 -kernel arch/arm/boot/zImage -no-reboot \
     -initrd rootfs-armv5.cpio -m 128 \
     --append "rdinit=/sbin/init console=ttyAMA0,115200" \
     -dtb arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
     -nographic -monitor null -serial stdio

using multi_v7_defconfig will hang nicely with your patch applied,
and boot as expected without. This was with qemu v7.0, but I am
sure older qemu versions will show the same behavior. The initrd
used should not matter, but you'll find it at
https://github.com/groeck/linux-build-test/blob/master/rootfs/arm-v7/rootfs-armv5.cpio.gz

Guenter
