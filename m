Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7293F584F73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiG2LTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiG2LTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:19:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B5086C03
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:19:31 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r14so4830969ljp.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bh/CEcIftmSrIW2GaToQmbXoa6n4IYUuUScyol0fs4Q=;
        b=U+RlMEFKQsQY7/BKW5LFtpT6fuhSCpUxh05B4UD5/DTv9ZTavjQnR6ydaKoiCeNYHz
         mmkzfKuxhh9Lh7R1WNqluQwiYlVN86WAzReQljl4z6bEvwhZFZmJRyjfFQT/QvNII9LL
         kgnUlMlE+6N6Oz/F826TBgh0B7qbJ9EtcdSEExRfnlFdz66gxejQjzLvSvz6mSVc43jh
         Y/kYmrFly9+6MQ3w1lKMCFF+ioGoFuzuZUUm4Kx0It/u5zn7lH28pX8i/6bG8DaHQMMC
         IBP2y9LEtYztpZNhm2jhuBoZqzJpNbZxJkMcO41Zv2mGjZRntQ7Kq8Kx+Tumc8lYFmV8
         dzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bh/CEcIftmSrIW2GaToQmbXoa6n4IYUuUScyol0fs4Q=;
        b=SdFqzQd06z22d7ERQek3jSOc6LNrkzsFmX1TWXzwf57Nru8+YDetePW44Luq0oIRRf
         8JRKwmbpaGJvrheS4cQLsAmRIP5vjy+BjTHDNXaoyF7vi7BwwH9G49iZpq1P5n8TapIb
         8wKbrkTe+hyjEJqs5HCMCXpvh2umXWSew5qrzFEBtkTWBNr64g1HTnrp9dRASwi6yBIA
         Ijd7NJ7Mf2DbwEox0y5c6FhHKVn2lv51J2G80af03jmw/+1zHCz/cUXGPG9m6S3Nmfoj
         4vCAX4ny/64zRAS2Mw1H95sEi4L+CDg6MgK0qb2Zsm/Pmv+yHd8+WZweS3nU7qIySy0w
         Xg8w==
X-Gm-Message-State: AJIora8fVEcwAAevB2cvjfLtZPkg4YfefnG+Z0RM1zKBg5YGCEsemYex
        sQO8P6P50wgl9II3GSh7CVBjlg==
X-Google-Smtp-Source: AGRyM1tPqpP8jEpOz2ysUR8bxRF6JUOONEukO1NDa+lKcaKZbJRi8itU1IzZ9lwIihvx5ziEMGXUuw==
X-Received: by 2002:a05:651c:2208:b0:25d:9ab8:b368 with SMTP id y8-20020a05651c220800b0025d9ab8b368mr1015760ljq.359.1659093569300;
        Fri, 29 Jul 2022 04:19:29 -0700 (PDT)
Received: from [10.43.1.253] ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id q13-20020a2eb4ad000000b0025e33bd156bsm441423ljm.19.2022.07.29.04.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 04:19:28 -0700 (PDT)
Message-ID: <f7c9943a-6818-beed-5623-21689bf1d159@semihalf.com>
Date:   Fri, 29 Jul 2022 13:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] KVM: irqfd: Postpone resamplefd notify for oneshot
 interrupts
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rong L Liu <rong.l.liu@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Dmitry Torokhov <dtor@google.com>
References: <20220715155928.26362-1-dmy@semihalf.com>
 <20220715155928.26362-4-dmy@semihalf.com> <YuLbvl7BBuLTBXO7@google.com>
From:   Dmytro Maluka <dmy@semihalf.com>
In-Reply-To: <YuLbvl7BBuLTBXO7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 20:55, Sean Christopherson wrote:
> On Fri, Jul 15, 2022, Dmytro Maluka wrote:
>> +static void
>> +irqfd_resampler_mask(struct kvm_irq_mask_notifier *kimn, bool masked)
> 
> Ugh, I see you're just following the existing "style" in this file.  Linus provided
> a lengthy explanation of why this style is unwanted[*].  And this file is straight up
> obnoxious, e.g. a large number of functions put the return type on a separate line
> even though it would fit without any wrap.
> 
> My vote is to break from this file's style for this patch, and then do a follow-up
> patch to fix all the existing funky wraps.

Ok, I can do that.

Would you also like if I rename resampler->notifier to
resampler->ack_notifier and irqfd_resampler_mask() to
irqfd_resampler_mask_notify() for more clarity?

Thanks,
Dmytro

> [*] https://lore.kernel.org/all/CAHk-=wjoLAYG446ZNHfg=GhjSY6nFmuB_wA8fYd5iLBNXjo9Bw@mail.gmail.com
