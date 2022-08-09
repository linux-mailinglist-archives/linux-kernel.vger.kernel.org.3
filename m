Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3CD58D71C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbiHIKFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241412AbiHIKFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:05:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8266B1EACC
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:05:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D63523A;
        Tue,  9 Aug 2022 03:05:46 -0700 (PDT)
Received: from [10.57.74.141] (unknown [10.57.74.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164653F67D;
        Tue,  9 Aug 2022 03:05:43 -0700 (PDT)
Message-ID: <f2ccc321-c892-0e35-3760-1d0ed5b5dbf3@arm.com>
Date:   Tue, 9 Aug 2022 11:05:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] perf/arm-cmn: Add more bits to child node address
 offset field
Content-Language: en-GB
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com
References: <20220808195455.79277-1-ilkka@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220808195455.79277-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-08 20:54, Ilkka Koskinen wrote:
> CMN-600 uses bits [27:0] for child node address offset while bits [30:28]
> are required to be zero.
> 
> For CMN-650, the child node address offset field has been increased
> to include bits [29:0] while leaving only bit 30 set to zero.
> 
> Let's include the missing two bits and assume older implementations
> comply with the spec and set bits [29:28] to 0.

Ah, I don't think it ever even crossed my mind to look for changes here, 
but of course if the node regions have grown from 16KB to 64KB then it's 
only natural that offsets grow to match. I expect the CMN-700 config 
that we tested on internally would have been small enough for this not 
to make a difference. Thanks for the catch!

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
> 
> I have tested this patch on CMN-600 and CMN-650.
> 
> drivers/perf/arm-cmn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 80d8309652a4..b80a9b74662b 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -36,7 +36,7 @@
>   #define CMN_CI_CHILD_COUNT		GENMASK_ULL(15, 0)
>   #define CMN_CI_CHILD_PTR_OFFSET		GENMASK_ULL(31, 16)
>   
> -#define CMN_CHILD_NODE_ADDR		GENMASK(27, 0)
> +#define CMN_CHILD_NODE_ADDR		GENMASK(29, 0)
>   #define CMN_CHILD_NODE_EXTERNAL		BIT(31)
>   
>   #define CMN_MAX_DIMENSION		12
