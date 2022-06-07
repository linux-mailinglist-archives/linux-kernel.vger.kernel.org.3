Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C70540103
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245200AbiFGON6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiFGONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:13:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3940381
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:13:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k16so24378573wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=PMMOc1GLcfcdM1iK8PSOo17yG4c306XasMZduCxOcn0=;
        b=nQOuOcwZH2PAh9xbXAPTfYhhSdMW7q1m/uLuH6VSBh6IRjnNoa2qrNEaX3pyswoBsx
         E/UATB2Id9WMUkF9UOzZU5DN2BITuSmnLMT+6zsEpH2YNc3ZwAdN60eWzov5R8uPR53T
         bHMGDQVY2MN+rev1oC1/09WlsD7NmEcuUgwAdaYVFWllJ0TXf7f1TH8BO+nG4N40jYP8
         8X5oEyVKcsX/78WQ/zhSMDGbvtVlQ9br0wuXjOqgQGnjHKYa4J81Rjk1BZzbViKzCk1s
         isY8DrtwUAUuddsRexA5uB2RhCzCgkCOYc1n9tawXmTZu168dKD4Zc/Rys7q4IplMJyJ
         loEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PMMOc1GLcfcdM1iK8PSOo17yG4c306XasMZduCxOcn0=;
        b=m7mSuOgsp8+evS4Qi7VOCt8CVOvnUkdsimiuk2C3LntTiKnE/BLkMtPIGVytH7CU78
         WeBiyRhKldJ30s5GvHzAnCkaCmOLUhwBoTZVArTp8ldD944JRIpUDkOdFfK2vaJFS2E8
         b876Xu9Tqx/b80Nr1D8Lneu3FDifSsOd3hKcXuMTE+UzoTVD0sCLp6ssstiHEzwlkt21
         ec7dqqc2C7qRx88RopIlJM9E1i/SwCd5WqhX91q3cdneiqSt7Eb/nGfZmTibPK7yQ8EB
         FTsnfE19JjC81xoOBp+ASBOtTyiWjFEerLh6aTLM5fWjDQZDFydtDC4rLbI18znmRWLc
         foiQ==
X-Gm-Message-State: AOAM532GiNEzmkQaZTjlUvqBodP0vTTHdpcK4OcjX+/nBBWBs1VBR+i4
        XiwGtsdyACNDZ+/0Pxo+Uiz5OA==
X-Google-Smtp-Source: ABdhPJyixQhz+aPznWDqS7/u9tnFl9odZj+pZ7kuQPzihlqMhOFE7hcE6ZWUAE13mDEfhv9YUZGC6w==
X-Received: by 2002:a5d:47c1:0:b0:217:1959:3bf5 with SMTP id o1-20020a5d47c1000000b0021719593bf5mr15233692wrc.319.1654611232468;
        Tue, 07 Jun 2022 07:13:52 -0700 (PDT)
Received: from ?IPV6:2a00:1098:3142:14:901f:dbcb:c1e4:e4b8? ([2a00:1098:3142:14:901f:dbcb:c1e4:e4b8])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c35d300b0039c2e2d0502sm18009733wmq.4.2022.06.07.07.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 07:13:52 -0700 (PDT)
Message-ID: <a696e6fe-7337-2f16-9349-13130bc7805e@raspberrypi.com>
Date:   Tue, 7 Jun 2022 15:13:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] random: defer crediting bootloader randomness to
 random_init()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
References: <Yp9DWT3RttJGZhvu@zx2c4.com>
 <20220607124450.794347-1-Jason@zx2c4.com>
 <9a5d23ee-06d2-82e3-1e32-00367125990d@raspberrypi.com>
 <CAHmME9owv1Cj8=XVV+i-4uC9Tc1TsKDUMeFcO-ziGv88GRk8Ow@mail.gmail.com>
From:   Phil Elwell <phil@raspberrypi.com>
In-Reply-To: <CAHmME9owv1Cj8=XVV+i-4uC9Tc1TsKDUMeFcO-ziGv88GRk8Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason,

On 07/06/2022 14:51, Jason A. Donenfeld wrote:
> Hi Phil,
> 
> And this one also works, I assume?
> 
> https://lore.kernel.org/lkml/20220607100210.683136-1-Jason@zx2c4.com/

Using the metrics "earlier is better2 and "shorter is better", that patch wins 
on both counts:

With 5.15.45 + CONFIG_RANDOM_TRUST_BOOTLOADER=y:
[    0.000000] random: crng init done
[    1.985290] bcm2835-rng 3f104000.rng: hwrng registered

With rpi-5.15.y:
[    0.000000] random: crng init done
[    1.969552] bcm2835-rng 3f104000.rng: hwrng registered

No splats in either, of course.

Phil
