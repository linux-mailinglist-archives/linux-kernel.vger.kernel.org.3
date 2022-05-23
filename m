Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CC75314A7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbiEWN5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiEWN5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:57:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D70562D4;
        Mon, 23 May 2022 06:57:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 661FFB810BF;
        Mon, 23 May 2022 13:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67746C385AA;
        Mon, 23 May 2022 13:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653314219;
        bh=bLx74LGCuJSrln4gwnEZH4RTmeZooGdfAbU6lFv4YMg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=VsVmeth4WWMB62LFq9A8lhVFWoTQsy49D0ojuW4tEM4Esw4fs7J1VKmYNWBdVpKo5
         qkcyTa4bRf9QnIXtmAsCoYH48nRk0YNOqxPfi3opDtVIZvPuBmyj1a0AvT0yjLMeDu
         dCe/RlqoSHQcR5QKac3fLBUth/G7O7FE6nk8QInKmFROLLZFBpnVe/WGiQe41M0plk
         SIG8tVj6dViIzbs0TtLycqWIiuQyG66iguCNyVTiapQZxBuJZKRpyjQJcwzXetvgZH
         jtvRUxd9jPr7b1haA7sr/8YFhdpuwhA9BAid8ZgAVP8VaO6JC0EIY1FTAg8xsCWZ4c
         HXFeEMCp7ozLg==
Message-ID: <1a6535c7-df9c-1e08-8818-b8cd2c6d8fc2@kernel.org>
Date:   Mon, 23 May 2022 08:56:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 12/17] nios2: use fallback for random_get_entropy()
 instead of zero
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-13-Jason@zx2c4.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220423212623.1957011-13-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/23/22 16:26, Jason A. Donenfeld wrote:
> In the event that random_get_entropy() can't access a cycle counter or
> similar, falling back to returning 0 is really not the best we can do.
> Instead, at least calling random_get_entropy_fallback() would be
> preferable, because that always needs to return _something_, even
> falling back to jiffies eventually. It's not as though
> random_get_entropy_fallback() is super high precision or guaranteed to
> be entropic, but basically anything that's not zero all the time is
> better than returning zero all the time.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   arch/nios2/include/asm/timex.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/nios2/include/asm/timex.h b/arch/nios2/include/asm/timex.h
> index a769f871b28d..40a1adc9bd03 100644
> --- a/arch/nios2/include/asm/timex.h
> +++ b/arch/nios2/include/asm/timex.h
> @@ -8,5 +8,8 @@
>   typedef unsigned long cycles_t;
>   
>   extern cycles_t get_cycles(void);
> +#define get_cycles get_cycles
> +
> +#define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
>   
>   #endif

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
