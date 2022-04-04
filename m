Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB544F15AF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350573AbiDDNTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350338AbiDDNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:18:58 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE55E3CA78
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:17:02 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l129so8329396pga.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnom-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mKke3ZW7YzPazEGnfpnATNOWvziR+i28givSHJrWaOw=;
        b=cVKAM39FCBLPbj+N2GUU92EuN4rYWMZd/f8Uq5P+bsgsSVOInRYYRfA0xfFRQXaYRs
         eGbLmaFEPsikmjxzQxjVoqiQZmN2UHlo0kb/qDBbUdx1vquaOyTbDQYNQOP8u6VdSC47
         OTbEbOinweLxGh6WXT2xj4O+33+BT4jBWs6aJIEbJgtHj2835uvhUV9hPIp2nPw/BMSA
         TdyrIYixhSoUwBSryWo0TcZ80p3G7ZyLpZSJIss3AVwrPXLzI0bE2DyDmxYfFRYo8P9n
         zUe7LLjnjUciCNcCCMPE0T7R8oh1hUUDZ1iT0DgaJOHesT6ixAAbPQEPxlgMx/Eb7APS
         be8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mKke3ZW7YzPazEGnfpnATNOWvziR+i28givSHJrWaOw=;
        b=yjKfkQN0C7TkHUlDjOp55n6CzE/drrqU+5aROxeFUUOw4fNguxkjKg2QN3UMWr4wnj
         e9QiYz5K3/IlieyWqBbvxzgrxdUAeRz8/HjE/PP3UQkYreyUxkbVi7g7HgiCI7ZCWD48
         YZ9EKzWF11sTZtusr8gpf06KRGZgA5FEBT84A+r/V02iAvZ7KXQi7rFD0oukpEcWSp5k
         xRszCW29CzrMTJ+XRYFowU0RonshU0A2UjJUV5QTU0CjN4444vPqNsv4uSC7BMAj4RmY
         h7acw8SUSSEBZqvGk0vWNXmgsYWGmxN7xC+ADf4C3QYvZgb9nYxwrbinE/X8gt3aLCFQ
         fSwQ==
X-Gm-Message-State: AOAM531+LzOOMmYrt2xuOnvDPEMOHeO3tRpaEL70C4VWYI6sRGM0Bm85
        XrM3D9IqfqWgE/V0ezKtydvkjg==
X-Google-Smtp-Source: ABdhPJwUflBp5uXuiEKuzc/im/k02M+xdFepRcJPxj1hPjnm/Gqfb00vQzMorWd/sC26qoePdFlK4Q==
X-Received: by 2002:a63:fd01:0:b0:381:31b7:8bc5 with SMTP id d1-20020a63fd01000000b0038131b78bc5mr25651049pgh.206.1649078222148;
        Mon, 04 Apr 2022 06:17:02 -0700 (PDT)
Received: from [172.21.10.158] (119-18-16-128.771210.mel.static.aussiebb.net. [119.18.16.128])
        by smtp.gmail.com with ESMTPSA id i187-20020a62c1c4000000b004faafada2ffsm12696583pfg.204.2022.04.04.06.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 06:17:01 -0700 (PDT)
Message-ID: <b273a9b7-82f7-5883-14d2-973dd005b005@omnom.net>
Date:   Mon, 4 Apr 2022 23:16:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] MIPS: pgalloc: fix memory leak caused by pgd_free()
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     yaliang.wang@windriver.com, rppt@kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        huangpei@loongson.cn, Andrew Morton <akpm@linux-foundation.org>,
        kumba@gentoo.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        anshuman.khandual@arm.com, penberg@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
References: <20220310113116.2068859-1-yaliang.wang@windriver.com>
 <alpine.DEB.2.21.2204021446370.47162@angie.orcam.me.uk>
 <9cc88b1c-8a8c-95ea-2cf7-31be3b771495@omnom.net>
 <alpine.DEB.2.21.2204031122020.47162@angie.orcam.me.uk>
From:   Andrew Powers-Holmes <aholmes@omnom.net>
In-Reply-To: <alpine.DEB.2.21.2204031122020.47162@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/04/2022 8:37 pm, Maciej W. Rozycki wrote:
> AFAIK the MIPS port is only maintained on the best effort basis 
> nowadays I'm afraid.  I.e. it's enthusiasts investing their free time
> for the joy of fiddling with things.  So things are bound to break
> from time to time and remain unnoticed for a while.  We're doing our
> best, but our resources are limited.
> 
> Taking these limitations into account I think Thomas has been doing a
> tremendous job maintaining the MIPS port, but he hasn't been cc-ed on
> the submission of the original change and it's very easy to miss 
> stuff in the flood that has only been posted to a mailing list.
> 
> Maciej

Fair enough :) apologies, didn't mean to sound combative or ungrateful.
I know there's far more work to go around than people to do it,
everyone's doing the best they can, and I have nothing but appreciation
for all the work the kernel community does.

It's just surprising that this *could* go unnoticed for over a year -
though I suppose most of the MIPS64 systems out there are running on one
or another old vendor SDK kernel so won't have been affected...

Would the best way to get this merged into 5.10/15 (and maybe .16 just
for good measure) be to email the stable team (since it's already in
Linus' tree)? Documentation/process/stable-kernel-rules seems to say
yes, but I'd like to avoid stepping on anyone's toes given that it's not
my patch.

- Andrew
