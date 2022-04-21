Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EC05095AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 06:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376849AbiDUELg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 00:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242619AbiDUELe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 00:11:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1782E03F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 21:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=KiNULmOIfBpp9dTLGboOTY6sH6tkkRYBTzgb9rAUnLQ=; b=P9E6AyWTxDYeHa1x5GmxWvZKP8
        z97ICf5JZpuBf1wLSXJ3V8teW0vAqdZH43J7nGb2kHMVevj7HwOwfwfgif12y5W4eTjCaFWmJOCfH
        f+SBeyfze7sW0mn9NmhuAFfPT2fn5W/JNKpB0dQsMwIf9Rh0Gm5eLGUwJ/yIX4xdsNjoRW1tbnglh
        fDIGKs/HfJWuOrChmA6Lj4OSAUEQCmzAfXbao7danilJNPi1lH7sRUkuaHF8ByytnSyBOwpwjOT1H
        8bSSB8Z5OYMBHFBayYy3b++FtTqw9uO1povGj51xWtc9hiv8gbmWlae7tD6JXt5ib+ElEBj7is3GJ
        pIWoahAA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhO7T-004jq8-T7; Thu, 21 Apr 2022 04:08:40 +0000
Message-ID: <461fa8ba-82c1-73b0-b900-7fa1ffb774f9@infradead.org>
Date:   Wed, 20 Apr 2022 21:08:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 5.10] fix csdlock_debug cause arm64 boot panic
Content-Language: en-US
To:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     peterz@infradead.org, gor@linux.ibm.com, tglx@linutronix.de,
        axboe@kernel.dk, arnd@arndb.de
References: <20220421033914.217622-1-chenzhongjin@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220421033914.217622-1-chenzhongjin@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/20/22 20:39, Chen Zhongjin wrote:
> csdlock_debug is a early_param to enable csd_lock_wait
> feature.
> 
> It uses static_branch_enable in early_param which triggers
> a panic on arm64 with config:
> CONFIG_SPARSEMEM=y
> CONFIG_SPARSEMEM_VMEMMAP=n
> 
> The log shows:
> Unable to handle kernel NULL pointer dereference at
> virtual address ", '0' <repeats 16 times>, "
> ...
> Call trace:
> __aarch64_insn_write+0x9c/0x18c
> ...
> static_key_enable+0x1c/0x30
> csdlock_debug+0x4c/0x78
> do_early_param+0x9c/0xcc
> parse_args+0x26c/0x3a8
> parse_early_options+0x34/0x40
> parse_early_param+0x80/0xa4
> setup_arch+0x150/0x6c8
> start_kernel+0x8c/0x720
> ...
> Kernel panic - not syncing: Oops: Fatal exception
> 
> Call trace inside __aarch64_insn_write:
> __nr_to_section
> __pfn_to_page
> phys_to_page
> patch_map
> __aarch64_insn_write
> 
> Here, with CONFIG_SPARSEMEM_VMEMMAP=n, __nr_to_section returns
> NULL and makes the NULL dereference because mem_section is
> initialized in sparse_init after parse_early_param stage.
> 
> So, static_branch_enable shouldn't be used inside early_param.
> To avoid this, I changed it to __setup and fixed this.
> 
> Reported-by: Chen jingwen <chenjingwen6@huawei.com>
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>  kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 65a630f62363..1ce64de460d0 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -176,7 +176,7 @@ static int __init csdlock_debug(char *str)
>  
>  	return 0;

^^^ This should be
	return 1;

since __setup() functions return 1 on success -- opposite of
early_param() return values.

>  }
> -early_param("csdlock_debug", csdlock_debug);
> +__setup("csdlock_debug=", csdlock_debug);
>  
>  static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
>  static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);

Thanks.

-- 
~Randy
