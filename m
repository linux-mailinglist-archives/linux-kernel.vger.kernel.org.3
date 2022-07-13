Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97047573CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiGMSt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236706AbiGMStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:49:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D580C189;
        Wed, 13 Jul 2022 11:49:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8245BB81D5E;
        Wed, 13 Jul 2022 18:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953EBC34114;
        Wed, 13 Jul 2022 18:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657738160;
        bh=4Q43VFLHPkBuTC36761H4oMGA8kLGgGH0ySOW/UBI0w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NFuc3ybhNFiuE64aFe2/wEuJIhwCX/SNQVywxc5VSLmYqVcZbQHI6UHFjlr8OaTlb
         sWG0yw6gbIqWgDspVSA2Y2tlO/DMy+/R8GEeWGHaU0ZqhOp/6QL0orjpo+JVDyYJyh
         6F1TIkzNuWRXqESI1Yi1/wKvjtuJMUabiBQtmBmKb73b6iRtwCjHXdPBtpqDG3lzcY
         enHKD8lPiugEc8ZUzdbB2e/cL1CGhU+/XZF5+4ig7wgYCXe5MKms6LYdkwPix5X54v
         twg/EvLLzCqVQzky5bDEnB+YSXrdEmCq1SapA7VKaB016Imi7ICsU13xmEPNFex/Ai
         xzOkZMIifg0nw==
Message-ID: <c9721122-bc90-9223-aadb-460b8471b3f7@kernel.org>
Date:   Wed, 13 Jul 2022 20:49:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 17/20] watchdog/dev: Add tracepoints
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <e153b772306577bcb3915474ed10eb3dcb228eda.1655368610.git.bristot@kernel.org>
 <a141e63a-c62c-8094-fedf-7f22f9090b0f@roeck-us.net>
 <4d8c53a1-7b94-fb0e-29e5-ed13b72093f1@kernel.org>
 <dc48373d-6568-4fab-cbe6-39f2c84ee1b5@roeck-us.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <dc48373d-6568-4fab-cbe6-39f2c84ee1b5@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 01:55, Guenter Roeck wrote:
>>
>> ack! I will change it. (I am seeing unsigned int, am I missing something?).
> 
> Yes, you are correct.

Fixed!

-- Daniel


