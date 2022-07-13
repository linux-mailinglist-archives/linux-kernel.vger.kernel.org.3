Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9DE573AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbiGMP7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbiGMP7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:59:04 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F67FDF66
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:59:03 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id u20so11241343iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7p5JU4lydqd4Y/jdtYtsRMxa2AtHRlASMeJQgSw4uFA=;
        b=nlFsFpJ/5ByhY7GqbajtwzPBcePeWyXmlZETqCPluix5Q+3xD/ue7sOjpiN3m5vTS2
         LDPxDjSNcvM1AmqBdmU954AKHjN81EeSlZK7hSOW3qLi2oUYejAQ5rQYrZ/m1dAJvyj5
         bSJrgugG7MVSPX6+NI9uxhRTQQtiOZGAXhJjmUbMaAG0EKpCHN/sSXOHt8JDFAaXoNA0
         HrS390TvuSJ8w1QMvNpbLDCCm0ERgVOxT9iEeildYhjlLImClGL7R0KY6WTXrlyPSc9m
         jxLgn0Jfodpt6hLuOrcq5brH5k48uCa7rtsXMghm10BjptpmZkwz07SgJsZaGLVf86aF
         /gTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7p5JU4lydqd4Y/jdtYtsRMxa2AtHRlASMeJQgSw4uFA=;
        b=mxQ7PEVTZR2oJVzbT2D65uKnRwOqUywST7OpX/BLjxzHbOwyqvbhTW202iyzgQN+e5
         8JQlHxrS/C2jPp6gxo3rptPqYI10CKtbao+SrUiQajxcyqxcT1r8LhZnfnOlWQwoQpFg
         HwqrRxouE/CD/qXR9W+RG+XtAtMPW5h6YiNkCG1f6yhlC6ARukWpyJtl0nnHeUa1vaXS
         I/ckSrdCAnF685NGK1fQ88J9ofG8cqC5bgMsILerBSDR3UWaQyevXhrJmyr2z9x/PPav
         s1FtLxycesqJ2bck8V/X7rrQCZebhBFtKI9GRxavABfKdg+adzKeJokjfiRVufPDMOUZ
         oeLA==
X-Gm-Message-State: AJIora9BM1xw6/KI7tU0cLcEEsR+TwbSZLz9L4ypTEkc/Pdtq8HruaKh
        Agu9RtDtqPMwuOy3Hkdn7V92dA==
X-Google-Smtp-Source: AGRyM1uNBQzDJkYi454IOJXVIyAzVKV5mR1OTKH/eBgZRaUvW+gzq32wgXrVEOg5B3MRbPGrkg7eDg==
X-Received: by 2002:a05:6638:160c:b0:33f:54c7:ee69 with SMTP id x12-20020a056638160c00b0033f54c7ee69mr2300998jas.65.1657727942903;
        Wed, 13 Jul 2022 08:59:02 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c35-20020a029626000000b0033f390d21d1sm5430698jai.144.2022.07.13.08.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 08:59:02 -0700 (PDT)
Message-ID: <2f8ec5a2-277a-d434-72c6-47fe2935c055@kernel.dk>
Date:   Wed, 13 Jul 2022 09:58:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] writeback: Cleanup bdi_sched_wait()
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, akpm@linux-foundation.org,
        neilb@suse.de, johannes.thumshirn@wdc.com, jack@suse.cz,
        willy@infradead.org, mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org
References: <20220713125314.171345-1-xiujianfeng@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220713125314.171345-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 6:53 AM, Xiu Jianfeng wrote:
> bdi_sched_wait() is no longer used since commit 839a8e8660b6 ("writeback:
> replace custom worker pool implementation with unbound workqueue"),
> so remove it.

Heh, 9 years later! Nice find:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

