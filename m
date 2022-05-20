Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4930A52EF80
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350998AbiETPok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351017AbiETPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:44:29 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494071796EC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:44:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id bh5so7681453plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9mUPsRUC7556BCOoMKheuSYgEvTIkY7O5zyQUwY11vk=;
        b=FR3VFmMKFp1j7UuMtIgzK1hv8FGWhrsa7vPsjwpbPh1oA4HdcnynTJofpJL+E6jYgT
         Us0/zcjNc2PnuO0EADQsM62moDvpOgBpNXIT0DC2UAkWYkQR1ZA+S4YJYChD+5bajI19
         1yeUolfrb8UA/qXLzgjYnCT27LdGk4CR2zTRkhrA/4DgI/ADp6KK3MHQ6zwLuy9hF2Qz
         2fUTKG2hYsOy8Sl+2k4sD4ZNfIIYPnvcByevLF1YlZiJTx/Gso7PSIIkF5SfUI64te/L
         OKPlx9Kf/vppdxvA3m8JALgSl/aKqdkXRaoQkxeCjXcHOd/oJo6doc9D9F/Bel5ihFmA
         bvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9mUPsRUC7556BCOoMKheuSYgEvTIkY7O5zyQUwY11vk=;
        b=QT+d/eKEv9PhK1hZ0LKbBeqzkbgEZt+P2f0ttKzxElyK2wgv+3Boz22VY/vbEKaU+7
         nvUeGE8I0m71/DfNXkIULYFBPdo+KCKZKgxtN8WMFNpRKKaux+76zuiJpZZM6DoApdxT
         aBNtPpjb7JcwfgLDFrWrd7NcCRdiOMnPWscDH9a7g+KsnSRJ3pSvmglvOcch4T0fMPXu
         R2tT3ENfIefDZhnOV7R3LzIA8Gaw7dlczsyENWYTbmEB3BlaLgwYA9ts7+Dagmp9NfIx
         Hkmp1qSx+03nOll1dVuh04EmhYSBNc7NyzLHKJJ7K8o7+64Ix7i/V5qXO5OlIB4LcQUq
         EqwQ==
X-Gm-Message-State: AOAM5338O40vvfKUnQrP8AECEJ9d//R4bGFPwP/TdvwtLJV7K0r7X8Ez
        ejQfkvsYYR1vwxwpYP5nqUuihA==
X-Google-Smtp-Source: ABdhPJy07HmIagMR/Y4Umfb72aBazBOqkx7r1N+ScbzNtv9e5BohxLRE+S+KqKQzNs0x691oCUjsHg==
X-Received: by 2002:a17:902:bd83:b0:15f:a13:dfd8 with SMTP id q3-20020a170902bd8300b0015f0a13dfd8mr10233871pls.87.1653061467397;
        Fri, 20 May 2022 08:44:27 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m11-20020a63fd4b000000b003c14af50607sm5660761pgj.31.2022.05.20.08.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:44:27 -0700 (PDT)
Message-ID: <0a6ed6b9-0917-0d83-5c45-70ff58fad429@kernel.dk>
Date:   Fri, 20 May 2022 09:44:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com> <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
 <Yoe2PPA/pzqhf+GZ@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yoe2PPA/pzqhf+GZ@zx2c4.com>
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

On 5/20/22 9:39 AM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Fri, May 20, 2022 at 09:34:46AM -0600, Jens Axboe wrote:
>> On 5/20/22 9:25 AM, Jason A. Donenfeld wrote:
>>> Hi Jens,
>>>
>>> On Fri, May 20, 2022 at 11:44:56AM +0200, Jason A. Donenfeld wrote:
>>>> Jens Axboe (3):
>>>>   random: convert to using fops->read_iter()
>>>>   random: convert to using fops->write_iter()
>>>>   random: wire up fops->splice_{read,write}_iter()
>>>
>>> FYI, this series makes reads from /dev/urandom slower, from around 616
>>> MiB/s to 598 MiB/s on my system. That seems rather unfortunate.
>>
>> How reproducible is that? That seems like a huge difference for the
>> change. How big are the reads?
> 
> Fairly reproducible. Actually, if anything, it reproduces consistently
> with worst results; I chose the most favorable ones for the new code.
> This isn't any fancy `perf` profiling, but just running:
> 
> $ pv /dev/urandom > /dev/null
> 
> From looking at strace, the read size appears to be 131072.

Ran 32, 1k, 4k here and it does seem to be down aboout 3%. Which is
definitely bigger than I expected, particularly for larger reads. If
anything, the 32b read seems comparably better than eg 1k or 4k, which
is also unexpected. Let me do a bit of profiling to see what is up.

If you're worried about it, I'd just keep the read/write and add the
iter variants on the side.

-- 
Jens Axboe

