Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935B1557EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiFWPh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiFWPh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:37:27 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F040F2FFE3;
        Thu, 23 Jun 2022 08:37:25 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 24 Jun 2022 00:37:25 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 6BD59205845A;
        Fri, 24 Jun 2022 00:37:25 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 24 Jun 2022 00:37:25 +0900
Received: from [10.212.180.217] (unknown [10.212.180.217])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 0A3C1B62E2;
        Fri, 24 Jun 2022 00:37:23 +0900 (JST)
Subject: Re: [PATCH] clk: Fix referring to wrong pointer in devm_clk_release()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1655946142-1346-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20220623070620.ndhnxeiw4wtjgpjm@pengutronix.de>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <3896b73a-d8fe-6b92-168a-f30d0a60bbbe@socionext.com>
Date:   Fri, 24 Jun 2022 00:37:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220623070620.ndhnxeiw4wtjgpjm@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

Thank you for pointing out.

On 2022/06/23 16:06, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Jun 23, 2022 at 10:02:22AM +0900, Kunihiko Hayashi wrote:
>> At bind phase, __devm_clk_get() calls devres_alloc() to allocate devres,
>> and dr->data is treated as a variable "state".
>>
>> At unbind phase, release_nodes() calls devm_clk_release() specified by
>> devres_alloc().
>>
>> The argument "res" of devm_clk_release() is dr->data, and this entity is
>> "state", however in devm_clk_release(), "*res" is treated as "state",
>> resulting in pointer inconsistency.
>>
>> Unbinding a driver caused a panic.
>>
>>      Unable to handle kernel execute from non-executable memory
>>      at virtual address ffff000100236810
>>      ...
>>      pc : 0xffff000100236810
>>      lr : devm_clk_release+0x6c/0x9c
>>      ...
>>      Call trace:
>>       0xffff000100236810
>>       release_nodes+0xb0/0x150
>>       devres_release_all+0x94/0xf8
>>       device_unbind_cleanup+0x20/0x70
>>       device_release_driver_internal+0x114/0x1a0
>>       device_driver_detach+0x20/0x30
>>
>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Fixes: abae8e57e49a ("clk: generalize devm_clk_get() a bit")
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> This is already fixed in clk-next:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=8b3d743fc9e2542822826890b482afabf0e7522a

Sorry for not finding the fix patch and duplicating it.
I'm waiting for it to be merged.

Thank you,

---
Best Regards
Kunihiko Hayashi
