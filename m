Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC2D52E096
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbiESXdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiESXdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:33:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA98111BAA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:33:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c2so6047732plh.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OYzXukK98aJKq3a6xGyPchZ49wWZJ/uc2a08CvcVm9U=;
        b=y/jc69IS9sUqZZetgrRHXRRFv1eje+4PgPhQfOJU9xa7/514B3b718CER2giGIV0rG
         qnrE/Ws3+k+XnE9mhhaauwptosHK0ghKSJbApGjudjfPr2uuHHlrAO3lbJkJthsrHg7V
         /8IbeZDicDM71AW8hEedso3uO057vvYZxLnEpdoxE8Wr3wdyCqJtWctSvvr9PlMAG8+c
         V1wZuzCso+xVYmKawGXkZ03Ry4N8oz4iXPdLXTkFYWRj48StuFf/T9J9dRNTymBfuuAG
         KBWJaVIPjTrYwjCWgYk+9QjuW1cx5NAqDFLTZMoFaggvVscHRigp79ms+cQ/fKs8Dsvs
         pR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OYzXukK98aJKq3a6xGyPchZ49wWZJ/uc2a08CvcVm9U=;
        b=BwOrsZoMOqPjYjQL+74Jp4mjlGgB67/z7d2R2zUkJhTBKLeur+CPzSWawoRP2ZBhxD
         0HUZarzgLPMzopvTXsIUa1jZUKYKFtLPWaYfnjbkBKbpp3fX2kDgGAT+6tfDxlvM47F5
         O5NPZSW8FHwyEjSMINTqqqe8lqfSPhXZ+Jor7UVD/CONuOGiMurGcFz7SO94MK7povOQ
         p5Lk0MlmuWIaunuQEA2EGbkLvHR4uYoUadkvkPuUma+tRnhC7WqvuJcivP1ko/AtzGNv
         jsH3/0Bhmt+qOG6cu4pFPgdqFOz0SinGEnWUG6be6Injm42W/SG3TXc+i7z/pL9OBFS0
         x+Bg==
X-Gm-Message-State: AOAM533XnHWog/DedOZeI6V8HnjId9Rm7btR9cvMxiTU0F0uyOY4koQk
        Uif0YNK9Q2CxLwluzVln9Qq0Ng==
X-Google-Smtp-Source: ABdhPJwfh56rXy6fwqWu/SIfYU4hP3Wiydli22dR3VW/1pnyHoicOdFF4YYEL7pl9zkpeKCYad0fJA==
X-Received: by 2002:a17:902:e404:b0:161:9e38:63c8 with SMTP id m4-20020a170902e40400b001619e3863c8mr6953767ple.148.1653003182780;
        Thu, 19 May 2022 16:33:02 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709027fcc00b0015e8d4eb234sm4340317plb.126.2022.05.19.16.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 16:33:02 -0700 (PDT)
Message-ID: <3bcbfde4-3247-b4ff-9a7c-963a9a510703@kernel.dk>
Date:   Thu, 19 May 2022 17:33:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220519193133.194138-1-axboe@kernel.dk>
 <YoajCafKmgUbbaY0@zx2c4.com> <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk>
 <8e6c98d4-03e9-3eb5-3d4e-b9a9faeb677a@kernel.dk> <YobPfgkzGrNPDDFI@zx2c4.com>
 <60b82026-9c46-16ea-d9fa-05eb96ae2218@kernel.dk>
 <CAHmME9rdJ=Pa=KOY6voryiHffWSkRKxC75+Wz-xoQOpowObwWw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHmME9rdJ=Pa=KOY6voryiHffWSkRKxC75+Wz-xoQOpowObwWw@mail.gmail.com>
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

On 5/19/22 5:25 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Fri, May 20, 2022 at 1:22 AM Jens Axboe <axboe@kernel.dk> wrote:
>> I can certainly do the write side too. To fix this regression, I just
>> valued doing read_iter first and I'd hate to hold that up to do the
>> write side too. I'll do the write side later today, but let's keep them
>> separate.
> 
> Excellent, thanks. I plan to queue these up all in a row.

Built and tested v2, just sent it out. Note that it deviates from your
proposal a bit since with that we lost the

if (!len)
	break;

check, which is kind of important if you ever want to be done :-)

I'll do the write_iter side, but as mentioned, I'd prefer to keep it
separate from this patchset as this one fixes a real regression that we
need to get backported too.

-- 
Jens Axboe

