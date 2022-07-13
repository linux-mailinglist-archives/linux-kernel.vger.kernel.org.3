Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424E0573A97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiGMPwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiGMPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:52:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B95814F19E;
        Wed, 13 Jul 2022 08:52:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC1C315A1;
        Wed, 13 Jul 2022 08:52:32 -0700 (PDT)
Received: from [10.1.29.153] (e121487-lin.cambridge.arm.com [10.1.29.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 933993F792;
        Wed, 13 Jul 2022 08:52:31 -0700 (PDT)
Message-ID: <88d9e600-b687-7d09-53cb-727601612e21@arm.com>
Date:   Wed, 13 Jul 2022 16:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] random: cap jitter samples per bit to factor of HZ
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, ebiggers@google.com, tytso@mit.edu,
        torvalds@linux-foundation.org
References: <CAHmME9rrQVm72P6cLL4dUnSw+9nnXszDbQXRd3epRaQgKTy8BQ@mail.gmail.com>
 <20220713151115.1014188-1-Jason@zx2c4.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20220713151115.1014188-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 16:11, Jason A. Donenfeld wrote:
> Currently the jitter mechanism will require two timer ticks per
> iteration, and it requires N iterations per bit. This N is determined
> with a small measurement, and if it's too big, it won't waste time with
> jitter entropy because it'd take too long or not have sufficient entropy
> anyway.
> 
> With the current max N of 32, there are large timeouts on systems with a
> small CONFIG_HZ. Rather than set that maximum to 32, instead choose a
> factor of CONFIG_HZ. In this case, 1/30 seems to yield sane values for
> different configurations of CONFIG_HZ.
> 
> Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Fixes: 78c768e619fb ("random: vary jitter iterations based on cycle counter speed")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Vladimir - Can you let me know if this appears to fix the issue you're
> seeing? -Jason

Works for me, thanks! :) 

> 
>  drivers/char/random.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index e3dd1dd3dd22..a1af90bacc9f 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1174,7 +1174,7 @@ static void __cold entropy_timer(struct timer_list *timer)
>   */
>  static void __cold try_to_generate_entropy(void)
>  {
> -	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = 32 };
> +	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = HZ / 30 };
>  	struct entropy_timer_state stack;
>  	unsigned int i, num_different = 0;
>  	unsigned long last = random_get_entropy();

FWIW

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>

Cheers
Vladimir
