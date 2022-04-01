Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6FE4EF9F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351277AbiDASit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiDASip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:38:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F59F1E31AD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:36:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e5so3160405pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=cqsuM9synFmM1yPUnHeSbl2P4nO3t+xg2dzn32HhZsU=;
        b=xNoYg77Py57X1Me0ur5VPCcatzUb1xYQqOXB3osYqUEJZfzafFqJoogVTp+lKN1g9Q
         g/jOWWRLrxIh7XlvcvzOO3Bun4bgj7ov1Qqtpxp6HG5kBgutbNTnrGemYPERcZugOBAN
         nWUML92Jqx8ffU+/0T9aiCDGOVQPtaPpNrI+gp665M/iVo5I6rDobtMXMwBNDp7Tt+eP
         bYKmDznFtNQYqD16E5guTIDDrgtCISFlRtpvrvQLwHvFV60H8ySyXFPwoN0f9iQk/Lks
         LkQxlmP5AGqOMBRUFflhbrBu+dQ3128WmdIVSMsrfaW/cZlL5J9tS7NevH4+TFXuT6K3
         hRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=cqsuM9synFmM1yPUnHeSbl2P4nO3t+xg2dzn32HhZsU=;
        b=1MJjM0borlepF6tPIwnsUtomLpbBtO2KcA7ZCA9ujjzkLL2oImRAjztkgNCHnbXASr
         OsQxMvmaEo92D5pT+cagM/yGRppewFT+n43nYhXneLB4Y5UleznPPB5rYVFd4V86J1ds
         R2y2y4+QbZDMuNmpo3+c9yS4foLTTlqEevpvZKWyra6Z3qVFUnHZx8YYpjDUP1iLaVad
         Ht28p6ZdTi5/zxa+u89vENUO0DNhd3LUXn3C3+9qxTVHcJHkuglh5DOe29/9CXbY7CwM
         GxwZYbKDIkta/B4f+OjxYARhRli+a1WUabaW685S9QMT34a4WFazUQappiA38CX/jNzi
         F8Nw==
X-Gm-Message-State: AOAM530zM5vRv9Qcpe6ocdSYW6hOWODtDakGhepCksBKfZYGyh7hqloL
        3uRseN2A+t7+GWwe8j//08ZAQiYgzPvA5A==
X-Google-Smtp-Source: ABdhPJxu0cXtXaLgk1bOZrTT27XsZcXSkZ6Zri7MAMHUWKOoDZ6GQ+6L8CEvdkcl0Jg4j4oCJybCgg==
X-Received: by 2002:a17:902:d48d:b0:154:54f6:9384 with SMTP id c13-20020a170902d48d00b0015454f69384mr11524985plg.83.1648838214767;
        Fri, 01 Apr 2022 11:36:54 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a0026ca00b004fb44e0cb17sm3875571pfw.116.2022.04.01.11.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 11:36:53 -0700 (PDT)
Date:   Fri, 01 Apr 2022 11:36:53 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Apr 2022 11:36:52 PDT (-0700)
Subject:     Re: [PATCH] habanalabs: Elide a warning on 32-bit targets
In-Reply-To: <CAFCwf13-o=kUR61xjWt=F-Q-Vfy=kF6fpMP7iB+83Gfqw7+2HA@mail.gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, osharabi@habana.ai
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     ogabbay@kernel.org
Message-ID: <mhng-89bfa679-14d3-436e-80e1-439ab154beb2@palmer-mbp2014>
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

On Fri, 01 Apr 2022 11:13:48 PDT (-0700), ogabbay@kernel.org wrote:
> On Fri, Apr 1, 2022 at 7:41 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> This double-cast pattern looks a bit awkward, but it already exists
>> elsewhere in the driver.  Without this patch I get
>>
>> drivers/misc/habanalabs/common/memory.c: In function ‘alloc_device_memory’:
>> drivers/misc/habanalabs/common/memory.c:153:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>>   153 |                                                 (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
>>       |                                                 ^
>>
>> which ends up promoted to a build error in my test setup.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> ---
>>
>> I don't know anything about this driver, I'm just pattern-matching the
>> warning away.
>> ---
>>  drivers/misc/habanalabs/common/memory.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
>> index e008d82e4ba3..f1fc79c1fc10 100644
>> --- a/drivers/misc/habanalabs/common/memory.c
>> +++ b/drivers/misc/habanalabs/common/memory.c
>> @@ -150,12 +150,12 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
>>                 for (i = 0 ; i < num_pgs ; i++) {
>>                         if (is_power_of_2(page_size))
>>                                 phys_pg_pack->pages[i] =
>> -                                               (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
>> -                                                                               page_size, NULL,
>> -                                                                               page_size);
>> +                                               (u64) (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
>> +                                                                                          page_size, NULL,
>> +                                                                                          page_size);
>>                         else
>> -                               phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
>> -                                                                               page_size);
>> +                               phys_pg_pack->pages[i] = (u64) (uintptr_t) gen_pool_alloc(vm->dram_pg_pool,
>> +                                                                                         page_size);
>>                         if (!phys_pg_pack->pages[i]) {
>>                                 dev_err(hdev->dev,
>>                                         "Failed to allocate device memory (out of memory)\n");
>> --
>> 2.34.1
>>
>
> This patch is:
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
>
> Greg,
> Could you please apply this directly to your misc tree and send it to
> Linus at your next pull request ?
> I don't have any other fixes pending for 5.18.
>
> For 5.19 we will do a more elegant solution that Arnd has recommended.

Thanks.

Assuming this is too late for rc1, would it be possibe to have it in 
something I can take into my fixes/for-next without too much diff?  I 
put this on top of the offending commit with a 

Fixes: e8458e20e0a3 ("habanalabs: make sure device mem alloc is page aligned")

at kernel.org/palmer/habana , if that helps any.  No big deal if it goes 
in another way, it's just nice to keep allyesconfig building on my 
branches directly.
