Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA9354421F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiFIDtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiFIDtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:49:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545732C;
        Wed,  8 Jun 2022 20:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+z54jbSAWnQmyf9OXbojvgiCd6Oq7Uy/qOERdfbzDCk=; b=EbcQV8lPjhM50JT0ZRxHwudtjz
        U6Lpl2XoRVcy00V3gfIZMYo8VYwuLsNvw8bw5pRB4xRT5/4+Q5TYIQaXvP5VJztQsynVAEqUg+azk
        3lVdxpRK0xQ9B3b2z43M9J8CvfY4JnA1SowhmuZsUMRpDs8WczdhTMfyrDHlWSctwiHuM2FioAW37
        YvcOaRdKyMu+qZcK74tOTT53vCebvSr3jGu4/a0t7jkrgosZEIMBBureKMG1a9lTxNL1bzYPzXme/
        /cPOYNkfVtlotI1gZ9W9BML4A1pQJtiMfByUUE0qpE7e4rx8k9ZSSUMdgIq+77fAtq402VQ3Viw8E
        l/II5PBw==;
Received: from [2601:1c0:6280:3f0::6c43]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nz9AF-006GMr-4D; Thu, 09 Jun 2022 03:48:55 +0000
Message-ID: <a4e7e2ce-8107-712c-1627-b3bb8646ed79@infradead.org>
Date:   Wed, 8 Jun 2022 20:48:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] kconfig: Add findconf script and helper program
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608095456.27479-1-zev@bewilderbeest.net>
 <6d6d252d-79e9-4b4c-4a62-aa4018a6254c@infradead.org>
 <YqFtHfC59akYP9jB@hatter.bewilderbeest.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YqFtHfC59akYP9jB@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/22 20:46, Zev Weiss wrote:
> On Wed, Jun 08, 2022 at 07:48:44PM PDT, Randy Dunlap wrote:
>> Hi--
>>
>> On 6/8/22 02:54, Zev Weiss wrote:
>>> scripts/findconf provides menuconfig's search functionality as a
>>> standalone, non-interactive command, somewhat in the spirit of
>>> scripts/config.  It is meant to be useful for tasks like getting a
>>> quick overview of symbol dependencies or determining which Kconfig
>>> file to edit for a given symbol, without having to fire up one of the
>>> interactive config programs.
>>>
>>> It accepts a single command-line flag, '-v', which causes it to also
>>> print the help text of each matching result.
>>>
>>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>> ---
>>
>> I can see how this could be useful.
>> It's a little easier to use than what I currently do:
>>
>> $ findconfig  DRM_HISI_HIBMC
>> ./drivers/gpu/drm/hisilicon/hibmc/Kconfig:2:config DRM_HISI_HIBMC
> 
> I'm guessing 'findconfig' here is some personal shell 
> alias/function/script?  (I can't see any references to it in the kernel 
> source tree.)
> 

Yes, it's just local.

>>
>> then $EDITOR that_Kconfig_file
>>
>>
>> In testing, I am seeing this:
>>
>> #
>> # using defaults found in /boot/config-5.3.18-150300.59.63-default
>> #
>> .config:421:warning: symbol value 'm' invalid for I8K
>> .config:2335:warning: symbol value 'm' invalid for 
>> MTD_NAND_ECC_SW_HAMMING
>> .config:2484:warning: symbol value 'm' invalid for PVPANIC
>> .config:8671:warning: symbol value 'm' invalid for INTERCONNECT
>> .config:9369:warning: symbol value 'm' invalid for 
>> CRYPTO_ARCH_HAVE_LIB_BLAKE2S
>> .config:9370:warning: symbol value 'm' invalid for 
>> CRYPTO_LIB_BLAKE2S_GENERIC
>> .config:9653:warning: symbol value '1' invalid for KASAN_STACK
>>
> 
> This I assume is just due to the contents of your .config file relative 
> to the current Kconfig definitions and not a problem with anything in 
> this patch?

There is no .config file in the linux/ source tree at the top level.
I use O=build_dir for all builds.

> 
>> How do I specify/choose a .config file to be used?
>>
>> Oh, use KCONFIG_CONFIG=filename
>>
> 
> Ah, I guess that'd be a nice thing to add a flag for to the wrapper 
> script -- I'll include that in v2.
> 
>>
>> Please update (add) usage/help text in scripts/kconfig/Makefile.
>>
> 
> Ack, will do.
> 
> 
> Thanks for the review!
> 
> 
> Zev
> 
