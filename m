Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7BA56B343
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiGHHQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbiGHHQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:16:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D1E796BB;
        Fri,  8 Jul 2022 00:16:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 264CB21A46;
        Fri,  8 Jul 2022 07:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657264573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AR73VFU4xhO2Wv5kLjdkzS0nSTAgkRpNRvkdlCke4Ak=;
        b=Bpppd1GEhso3X+/xusk2NqO2VthvZZ9NUM/R8rzwUFiPbL+NqMmBcNvU0Y72/EsGaFxXNU
        4BfsCGl1HPqsjjHOq58R82LNgbxVRH9gj7A6ERHrhWCiuZKf6OaPTin+rWsQQgmPwARIQm
        T7zP516fEPOXztnSV5wvWwaADdlN4KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657264573;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AR73VFU4xhO2Wv5kLjdkzS0nSTAgkRpNRvkdlCke4Ak=;
        b=s1QhdVaXv0j+QjrUNzPD2yeNaEJaxE+XelKwd6DEh3mzpEv69+0f6R1pG8r2pcWrhF0928
        rvplMhWpotDhgRBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5A1E13A7D;
        Fri,  8 Jul 2022 07:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id elb8NrzZx2IwDQAAMHmgww
        (envelope-from <jslaby@suse.cz>); Fri, 08 Jul 2022 07:16:12 +0000
Message-ID: <98363f27-e7a4-7351-fad7-361f7e465b7e@suse.cz>
Date:   Fri, 8 Jul 2022 09:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] clk: pistachio: Fix initconst confusion
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, mturquette@baylibre.com
Cc:     mliska@suse.cz, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, linux-clk@vger.kernel.org
References: <20220623083217.26433-1-jslaby@suse.cz>
 <20220624004225.0DE4AC3411D@smtp.kernel.org>
 <0edab0e2-5355-a3da-445d-b6f45e3082ed@suse.cz>
 <20220629082104.E25D2C34114@smtp.kernel.org>
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <20220629082104.E25D2C34114@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 06. 22, 10:21, Stephen Boyd wrote:
> Quoting Jiri Slaby (2022-06-27 00:46:15)
>> On 24. 06. 22, 2:42, Stephen Boyd wrote:
>>> Quoting Jiri Slaby (2022-06-23 01:32:16)
>>>> From: Andi Kleen <ak@linux.intel.com>
>>>>
>>>> A variable pointing to const isn't const itself. It'd have to contain
>>>> "const" keyword after "*" too. Therefore, PNAME() cannot put the strings
>>>> to "rodata".  Hence use __initdata instead of __initconst to fix this.
>>>>
>>>> [js] more explanatory commit message.
>>>>
>>>> Cc: Michael Turquette <mturquette@baylibre.com>
>>>> Cc: Stephen Boyd <sboyd@kernel.org>
>>>> Cc: linux-clk@vger.kernel.org
>>>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>>>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>>>> ---
>>>>    drivers/clk/pistachio/clk.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
>>>> index f9c31e3a0e47..742e5fab00c0 100644
>>>> --- a/drivers/clk/pistachio/clk.h
>>>> +++ b/drivers/clk/pistachio/clk.h
>>>> @@ -34,7 +34,7 @@ struct pistachio_mux {
>>>>           const char **parents;
>>>>    };
>>>>    
>>>> -#define PNAME(x) static const char *x[] __initconst
>>>> +#define PNAME(x) static const char *x[] __initdata
>>>
>>> Can it be const char * const and left as __initconst?
>>
>> Let me check, IIRC the struct where this is assigned would need to be
>> updated too.
>>
>> I will get into it only some time next week.
>>
> 
> Ok, sounds good. This seems to at least compile locally.

Yeah, that works. I've sent a v2.

BTW is the code intended to put the actual strings to .init.rodata? As 
that was never the case. Only those PNAME defined arrays (pointers to 
strings) end up in .init.rodata now and the strings are in .rodata.

> ----8<---
> 
> diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
> index f9c31e3a0e47..8be02ac2d909 100644
> --- a/drivers/clk/pistachio/clk.h
> +++ b/drivers/clk/pistachio/clk.h
> @@ -31,10 +31,10 @@ struct pistachio_mux {
>   	unsigned int shift;
>   	unsigned int num_parents;
>   	const char *name;
> -	const char **parents;
> +	const char * const *parents;
>   };
>   
> -#define PNAME(x) static const char *x[] __initconst
> +#define PNAME(x) static const char * const x[] __initconst
>   
>   #define MUX(_id, _name, _pnames, _reg, _shift)			\
>   	{							\


-- 
js
suse labs
