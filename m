Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76E455E059
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiF0HqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiF0HqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:46:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4149860ED;
        Mon, 27 Jun 2022 00:46:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B82601F9FB;
        Mon, 27 Jun 2022 07:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656315975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Wdlvn9sWciNbkMAfVF+Ot+ku+tBgw7fKynxQLGq3pE=;
        b=Cq44lemIAuPusIQCMbihA5ru9uASaxqbg5Yty7Vo2Dz/MJp+wBXc9M0P1JG8FEalaO+D+L
        FN7f7kESMjoOorE8RfU/5h8NAU8pFoiv7PPbgVJfVVeAUQ3LKjE4qEv2jc5UdZV3xsI2sh
        OaArb2LHXD7hKtA7esCUNqgRfTg7vTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656315975;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Wdlvn9sWciNbkMAfVF+Ot+ku+tBgw7fKynxQLGq3pE=;
        b=G9RfW/D5cD2/Ga1NucU0E7s0cAxwrNN2s2t+4a2qWnAhI6p4M1qfY7UR2fy43LgCx4zR5j
        5vjHoSw841KWzXBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94F6913456;
        Mon, 27 Jun 2022 07:46:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m9NuI0dguWLjegAAMHmgww
        (envelope-from <jslaby@suse.cz>); Mon, 27 Jun 2022 07:46:15 +0000
Message-ID: <0edab0e2-5355-a3da-445d-b6f45e3082ed@suse.cz>
Date:   Mon, 27 Jun 2022 09:46:15 +0200
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
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <20220624004225.0DE4AC3411D@smtp.kernel.org>
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

On 24. 06. 22, 2:42, Stephen Boyd wrote:
> Quoting Jiri Slaby (2022-06-23 01:32:16)
>> From: Andi Kleen <ak@linux.intel.com>
>>
>> A variable pointing to const isn't const itself. It'd have to contain
>> "const" keyword after "*" too. Therefore, PNAME() cannot put the strings
>> to "rodata".  Hence use __initdata instead of __initconst to fix this.
>>
>> [js] more explanatory commit message.
>>
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Stephen Boyd <sboyd@kernel.org>
>> Cc: linux-clk@vger.kernel.org
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>   drivers/clk/pistachio/clk.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
>> index f9c31e3a0e47..742e5fab00c0 100644
>> --- a/drivers/clk/pistachio/clk.h
>> +++ b/drivers/clk/pistachio/clk.h
>> @@ -34,7 +34,7 @@ struct pistachio_mux {
>>          const char **parents;
>>   };
>>   
>> -#define PNAME(x) static const char *x[] __initconst
>> +#define PNAME(x) static const char *x[] __initdata
> 
> Can it be const char * const and left as __initconst?

Let me check, IIRC the struct where this is assigned would need to be 
updated too.

I will get into it only some time next week.

thanks,
-- 
js
suse labs
