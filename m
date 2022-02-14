Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E263A4B5E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiBNXlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:41:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiBNXlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:41:32 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E950114762
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:41:21 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w1so11744849plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=moNgRt/ZLEOBsvTByTxtoOs0vPE/zSrseOi9CrHk4fo=;
        b=yoV/X27MeBo7oIZfSwmeTrP3dQ/+GNhABFP1Nj4ylCVxf+C2qf+1N2m4gY5+NP0SYS
         MTK4VhrCChxql5dGYbg2D/eflP6WJWuMp2HL0yU5jMyfg1js+SOnqY4uf7Gk6Zwx1Dha
         q4Lc2suIJTeaK30TCLCX+YU6f52bh1A2KKlRcqLvwx9shfV9qXx7trZePAdXWgFVf+Ox
         0I7NDimuv+L78rDIfRcfFwGh8LpACXzlYn3M5dQl6uoQSjAyLPkT6f6GYvmvp8XpH8Mn
         /hO7TOJBxKJlBjRLSz044qvnAiXd6Tf7e5mp5HyrSrhs83jUk6p7RGp15qN0Bso40VyC
         Gq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=moNgRt/ZLEOBsvTByTxtoOs0vPE/zSrseOi9CrHk4fo=;
        b=gtz18q6GET+mMS8Y2Pdg1Tubi7wTyNysl03cCfujf6A3zaYs7IgvUZu2HIwm+8OQCt
         aAsDx/ZQNuBvblim7w1iuFDWotF1btJ88UaKUP3Rqx0pi2DnLBHHIwOlP0gV93xjvIzV
         Alel3Ye7Y+1WgV8NXt5nTsKDVPa4eqo+V0kQu7FLt6AqTan+Dw8ecTHBrWGKJ/i4xeQK
         GgwkZyXEeIRyV1XhgjCoJBq1qvmzYf7qAlUN/uKvosilPi+Kt7e36ZN1DapPb3BfVo/v
         VQm1fUqpG9sBMdfyi/m58JLYKzbDtu1ZtgxrTNtzSgACMcB5s+ECLSjXtMdnb5cdDH18
         A5sQ==
X-Gm-Message-State: AOAM533++BSRjv3qUVjkJFdKevYg3A8tL+gIoiRHmdWmWdFOLlANd+8H
        VtFUqK0r/ODJWg2zmg8kjiEyXA==
X-Google-Smtp-Source: ABdhPJxrSAvPdqz8scLzAe/1uJoOiULuiRw2YIGciMi8EOsLxfF2zYjgEjkB/FnV4NMi5Ru8+XTGMA==
X-Received: by 2002:a17:90b:2496:b0:1b9:a6dd:ae7 with SMTP id nt22-20020a17090b249600b001b9a6dd0ae7mr1233912pjb.35.1644882080753;
        Mon, 14 Feb 2022 15:41:20 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id 13sm36798718pfm.161.2022.02.14.15.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 15:41:19 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:41:19 -0800 (PST)
X-Google-Original-Date: Mon, 14 Feb 2022 15:40:54 PST (-0800)
Subject:     Re: [PATCH] riscv: mm: remove the BUG_ON check of mapping the last 4K bytes of memory
In-Reply-To: <36519886-cedc-a3e3-70d2-712f8a6d3a10@ghiti.fr>
CC:     jszhang@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-790fdd34-b20e-4c0a-b36d-eb91b16a3e44@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 08:10:41 PST (-0800), alex@ghiti.fr wrote:
>
> On 1/25/22 16:55, Jisheng Zhang wrote:
>> remove the BUG_ON check of mapping the last 4K bytes of the addressable
>> memory since "this is true for every kernel actually" as pointed out
>> by Alexandre.
>>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>   arch/riscv/mm/init.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index cf4d018b7d66..8347d0fda8cd 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -811,14 +811,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>   	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
>>   	BUG_ON((kernel_map.phys_addr % PMD_SIZE) != 0);
>>
>> -#ifdef CONFIG_64BIT
>> -	/*
>> -	 * The last 4K bytes of the addressable memory can not be mapped because
>> -	 * of IS_ERR_VALUE macro.
>> -	 */
>> -	BUG_ON((kernel_map.virt_addr + kernel_map.size) > ADDRESS_SPACE_END - SZ_4K);
>> -#endif
>
>
> This BUG_ON seems pretty legit to me: I re-read the exchanges we had,
> and I see that I didn't notice that in your v2, you actually removed the
> BUG_ON. So that's my bad, what I meant in the first place was that the
> BUG_ON is true for 32-bit and 64-bit kernels actually.

There's actually an ifndef 64BIT above that sort of handles this case 
(though I didn't check to see if we're getting the limits correct, so it 
may not work properly).  That's shrinking the memory, rather than just 
firing a BUG, and it's not really any more code so we should go that way 
for both.  I could see leaving a BUG in there, maybe just explicitly 
using IS_ERR_VALUE as that's really what we're checking for (though if 
that's not 4K a bunch of stuff will break, so maybe it just doesn't 
matter).

> Sorry my RB was not right on this one :(
>
> Alex
>
>
>> -
>>   	pt_ops_set_early();
>>
>>   	/* Setup early PGD for fixmap */
