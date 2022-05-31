Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365CD538F68
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbiEaLDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiEaLDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:03:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE8B1994D2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:02:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C23C23A;
        Tue, 31 May 2022 04:02:59 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D57073F73D;
        Tue, 31 May 2022 04:02:58 -0700 (PDT)
Message-ID: <1cdf5131-a67b-7297-ad75-49b53f2da293@arm.com>
Date:   Tue, 31 May 2022 12:02:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Fix pointers arithmetic in Base
 protocol
Content-Language: en-GB
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
References: <20220530115237.277077-1-cristian.marussi@arm.com>
 <20220530115237.277077-2-cristian.marussi@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220530115237.277077-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-30 12:52, Cristian Marussi wrote:
> Fix a possible undefined behaviour involving pointer arithmetic in Base
> protocol scmi_base_implementation_list_get().
> 
> cppcheck complains with:
> 
> drivers/firmware/arm_scmi/base.c:190:19: warning: 't->rx.buf' is of type 'void *'. When using void pointers in calculations, the behaviour is undefined. [arithOperationsOnVoidPointer]
>   list = t->rx.buf + sizeof(*num_ret);

Except we use GNU C, where it is well-defined[1]. We use void pointer 
arithmetic *all over* Linux, so there really isn't any valid argument 
that it could be problematic. If this was a common SCMI library intended 
to be portable then the patch would seem more reasonable, but in 
Linux-specific driver code it's just pointless churn.

Cheers,
Robin.

[1] https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html

> Fixes: b6f20ff8bd94 ("firmware: arm_scmi: add common infrastructure and support for base protocol")
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/base.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> index 20fba7370f4e..6d6214d9e68c 100644
> --- a/drivers/firmware/arm_scmi/base.c
> +++ b/drivers/firmware/arm_scmi/base.c
> @@ -187,7 +187,7 @@ scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
>   
>   	num_skip = t->tx.buf;
>   	num_ret = t->rx.buf;
> -	list = t->rx.buf + sizeof(*num_ret);
> +	list = ((u8 *)t->rx.buf) + sizeof(*num_ret);
>   
>   	do {
>   		size_t real_list_sz;
