Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3852E07F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343570AbiESXZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242935AbiESXZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:25:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0DC106A51
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:25:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 137so6322964pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p68EmoNaEEOsAqeaNIXul3KX+T3iJWozbvcDZAFGNxE=;
        b=baIglwYwoHxOaHvMD/1BXVWOcznuSUxHLDjJBCPIsWWj31mTCW2q09DtEuXK4PdGn+
         toUzwKoiGm0YRuwsvJpfvQ1wprwODofctz5CZ3EH9w7HrgDjkDPQ+7rScUxi3Ou15Lhh
         Vbk94m28QjAA9nvAIBL/LJP9HP+pR5uRVnB/4Es+gxO3ciNeN4ehXJMyB5CvO6SQH0l4
         cXiVn1ayT1KMJnd9QlSVsLaT8LNDJaWp4o5h1smUCjo9PEiUb/5nqmXcPIjh+axLEcji
         afjgZA70dFIQHC9647V5CnMx9l9BdFmRLCxvYwuidrlW4R318X1P0qHkfY2beB02t64T
         06WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p68EmoNaEEOsAqeaNIXul3KX+T3iJWozbvcDZAFGNxE=;
        b=zHs0+H8dpqG/2+w4jU2L3UK++XUmJssy3TFoUQVS6modGG5MWUdD5mZdY9PLSaXADD
         6dHFZulwxOQ0AHouaGM6EFhMB/ng24G9u8ZQLeDmxYkHDYnTD8mILJFCZ7czHAo2TvkR
         tB77eBLFwO9QD4RCxB49tWUAbHq3Jl8U6AVO7joFrepFo0NJ7Q9EjmHuouXBhj2acepF
         VotgtsTtSdlB+jaTu6lb/uqx5AIM5gC3aYaWwzIbRtYWXHiRcEKvCZXFCyf0Y33F4vvw
         b0ox9op6xB6KogQaVmFAc1dwufA7iqUgewQlisabU4QT5kDoVwrPsuNyXtXRzdRJV6yt
         R/xQ==
X-Gm-Message-State: AOAM532r49rGOkN9AGnlmj44X/V+zJNx6RZr0hsPl79aaPrHfcPqEJ5N
        Va98K923TJd0NeuKHN6IOrqKHr4mmBLDkA==
X-Google-Smtp-Source: ABdhPJw9v2uw8vBubNXtXk8nRwY9DLWEE2zoRbIj0mgYIB6e//kYlj6VfTJvXnfbEDrYJSr+/Fgxmg==
X-Received: by 2002:a05:6a00:1385:b0:50a:9768:9eca with SMTP id t5-20020a056a00138500b0050a97689ecamr7123335pfg.43.1653002714727;
        Thu, 19 May 2022 16:25:14 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0016189ed82c4sm4280549plk.79.2022.05.19.16.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 16:25:14 -0700 (PDT)
Message-ID: <aa7ae20c-a2d7-4959-b5fb-efe7b56294f1@kernel.dk>
Date:   Thu, 19 May 2022 17:25:13 -0600
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
 <YobPB27Ozl7uqUEu@zx2c4.com> <3553b935-0aca-3d3e-2495-12288f601b53@kernel.dk>
 <CAHmME9riX+YuqSVp64bhy=nX08_7d-m8es82BHy2qh-oWkqa8Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHmME9riX+YuqSVp64bhy=nX08_7d-m8es82BHy2qh-oWkqa8Q@mail.gmail.com>
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

On 5/19/22 5:23 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Fri, May 20, 2022 at 1:19 AM Jens Axboe <axboe@kernel.dk> wrote:
>> The source and destination for the copies are exactly the same with the
>> change as before, so no changes there. The non-user copy is a different
>> helper.
> 
> Oh, okay. Maybe a silly question but: should we wire up that helper
> too? (If I'm understanding your meaning right.) Seems like it'd be a
> good idea to just wire up all the things while we're at it.

I'll leave that to you :-)

I'll do the write_iter though, just for completeness.

-- 
Jens Axboe

