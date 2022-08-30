Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D9D5A5A08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiH3Dbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiH3DbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:31:17 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C53AA346
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:30:59 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 202so9493882pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Gy9YEsBdDbtVX/3Y80hOdCjQjL++x+x3fWEIjnaGXeQ=;
        b=ne8kwc0jDnt5KZ8vTixBZW1PnZvG/6KPA200TdzWZAuxrM92TRPeaRiF+AJGNePkEu
         mn9R56EUmriofJiKsN9eDn5I2hgWmxakEk+oNnCEENjxN3jei+EI0Iyhfe7mA0p0XoD7
         bBg1ohTeoXsCEH2QMTZBvSBnbRZ81BYhOf63J0KUE9dEhoonXTr2bvXtueT1SQ2PqcQ+
         r7X3H4tV8tDW5vzpC+4E5qHA8JCDpwhbMBB1H9F/7LZbO/Lart6+E1VDbA8Dii6N0rug
         cap5pJ5MrtubucrdvolzSRc43S9E6mVoqfXbQ/U0Y6xJNufOKeR3zoQJmL2NP/smDANP
         76hg==
X-Gm-Message-State: ACgBeo2rDUM0nOx3QDyAtnmfBJ1yACOS7wRo0X/+FXs9cmNCgYteeU3I
        bUL0OIjxsX7QPEWToEGfG+YTTxHoKzY=
X-Google-Smtp-Source: AA6agR4xI2ojVx50t9P7GpGpjYE71Eigy08mvFfpR3uK5N8U5LzzyLeScNNNKtlA9uW0cB+ApbvG3A==
X-Received: by 2002:a63:4621:0:b0:429:f162:555e with SMTP id t33-20020a634621000000b00429f162555emr16210981pga.63.1661830257950;
        Mon, 29 Aug 2022 20:30:57 -0700 (PDT)
Received: from [172.20.0.236] ([12.219.165.6])
        by smtp.gmail.com with ESMTPSA id 198-20020a6216cf000000b0052b84ca900csm8054360pfw.62.2022.08.29.20.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 20:30:57 -0700 (PDT)
Message-ID: <3bd708e6-2cee-9177-5453-f6b152ec762c@acm.org>
Date:   Mon, 29 Aug 2022 20:30:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] testing/selftests: Add tests for the is_signed_type()
 macro
Content-Language: en-US
To:     Isabella Basso <isabbasso@riseup.net>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sander Vanheule <sander@svanheule.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yury Norov <yury.norov@gmail.com>
References: <20220826162116.1050972-1-bvanassche@acm.org>
 <20220826162116.1050972-2-bvanassche@acm.org>
 <74370E0B-AC37-435F-A44C-5DBAA8A38496@riseup.net>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <74370E0B-AC37-435F-A44C-5DBAA8A38496@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 19:33, Isabella Basso wrote:
>> +#include <kunit/test.h>
>> +#include <linux/overflow.h>
> 
> Nit: I don’t know if that makes a huge difference but you might include
> `<linux/compiler.h>` directly to make the final object smaller. Of course, that
> would ideally be a change happening in 2/2 but that was already merged :).

Right, that could have been done in patch 2/2 but I think this can also 
be done as a follow-up patch. I'm not sure what Kees prefers?

Thanks,

Bart.
