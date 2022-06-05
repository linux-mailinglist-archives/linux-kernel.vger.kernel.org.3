Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1687553DAF0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350897AbiFEJDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiFEJDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:03:06 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D82C6357;
        Sun,  5 Jun 2022 02:03:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e66so10605403pgc.8;
        Sun, 05 Jun 2022 02:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jMe9UQjF0xNszBaL1E6Odj0nZx5BKRzZXCCjpHMFYVA=;
        b=HGQKZadr+c97pHA6QzB1624+xF86tfBtVr4HttvwEThQOzYrAWesLpjfdgRmjo+nZF
         Mc6kFfulDg8PkT67oiK3limvCJCJht9Ha9f9YXH4tI7sBn2nCQCJyZ6vg9fEy9AfFklN
         b1exfuOp5h14637shuLdl2EvAclli3Bqy22sJa84q3YQZ5/SRNY0/J99kdN6Yb0EKBeQ
         rR9q66szGQ+AD5YjLfX0t474en2w84bAOvbBENp+/cgWXNJgLATbMl4pDxsVJNaEbVWF
         7AmHSPUa1dk1s6LfcDtZCpU36DsmN2mJmS+TNA0piVmxi76wpPxEYXCGGnNZO9F0WQ/x
         +eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jMe9UQjF0xNszBaL1E6Odj0nZx5BKRzZXCCjpHMFYVA=;
        b=UyFMPzoPQ1sVkXZS5igVa/ripjy+fTacYBzeOiErk3jjel2hEpa0W3mBcTLZ39g1Qa
         ji+5hJc0t5RRCZ0XdgTUNTRApot/dmTraUe6GT1ZreIeWBPFDxuEEe4++QbhCUwCXAlu
         hyJVUMOv1YUTUn5khiM77TjJAiblFFh1Kb3CzgOQfX6Fm5UxOG1Tshv3WkGuOrh9+UD+
         wlimrhdDMazuBur+noZjUrAbY1uWbKAsjtKVD6pdkxyULhbTKu1hm1uWzFc9sQrCxfkc
         aSm4JfYROlSsSb7Jh9rf+hxU0OXR0JOb+CK/TpBrVQTZggPxorh13myfrqu6QNyEUhd6
         TEgg==
X-Gm-Message-State: AOAM531FHq7AEHENeI8H8kIW3mV2Dc9PpvD9fgLb5w9qu4RN0F3TvrIA
        00mdvZ7FLHsnDqivz47BNZvy0GzSFvacIxyQ
X-Google-Smtp-Source: ABdhPJwV8FaUTS9Exe8w4+YK5TAZxn0UoCsE1aUI5iA06E7YT+cp3gsHhJETiPREw8OgOOpVLCDvcw==
X-Received: by 2002:a05:6a00:1a89:b0:518:fbf6:9276 with SMTP id e9-20020a056a001a8900b00518fbf69276mr18563193pfv.74.1654419783529;
        Sun, 05 Jun 2022 02:03:03 -0700 (PDT)
Received: from [172.16.4.4] ([106.39.148.251])
        by smtp.gmail.com with ESMTPSA id je18-20020a170903265200b0015e8d4eb259sm8395743plb.163.2022.06.05.02.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 02:03:02 -0700 (PDT)
Message-ID: <800915fc-c865-2c1e-43a5-514325198469@gmail.com>
Date:   Sun, 5 Jun 2022 17:02:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] sparc32,leon: Fix reference leak in leon_ipi_init
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Hellstrom <daniel@gaisler.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220605052943.54265-1-linmq006@gmail.com>
 <YpxfvKVTBkZRpXTy@ravnborg.org>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <YpxfvKVTBkZRpXTy@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/6/5 15:48, Sam Ravnborg wrote:
> On Sun, Jun 05, 2022 at 09:29:41AM +0400, Miaoqian Lin wrote:
>> of_find_node_by_path() returns a node pointer with
>> refcount incremented, we should use of_node_put() on it when done.
>> Add missing of_node_put() to avoid refcount leak.
>>
>> Fixes: 1ca0c808c60f ("sparc32,leon: Implemented SMP IPIs for LEON CPU")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> The patch is finei, thanks:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>
> All other uses of of_find_node_by_path() in sparc has the same issue.
> Could you try to take a look at the rest too?

Sure, I will look into them.

> 	Sam
>> ---
>>  arch/sparc/kernel/leon_smp.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
>> index 1eed26d423fb..85b22669c002 100644
>> --- a/arch/sparc/kernel/leon_smp.c
>> +++ b/arch/sparc/kernel/leon_smp.c
>> @@ -284,6 +284,7 @@ static void __init leon_ipi_init(void)
>>  		pp = of_find_property(rootnp, "ipi_num", &len);
>>  		if (pp && (*(int *)pp->value))
>>  			leon_ipi_irq = *(int *)pp->value;
>> +		of_node_put(rootnp);
>>  	}
>>  	printk(KERN_INFO "leon: SMP IPIs at IRQ %d\n", leon_ipi_irq);
>>  
>> -- 
>> 2.25.1
