Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03C1586E9F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiHAQfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiHAQfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:35:08 -0400
X-Greylist: delayed 461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 Aug 2022 09:35:05 PDT
Received: from mailout.easymail.ca (mailout.easymail.ca [64.68.200.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2EE3E74A;
        Mon,  1 Aug 2022 09:35:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 65A0FE3147;
        Mon,  1 Aug 2022 16:27:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo08-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo08-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W-TnW8K1KDWU; Mon,  1 Aug 2022 16:27:22 +0000 (UTC)
Received: from mail.gonehiking.org (unknown [38.15.45.1])
        by mailout.easymail.ca (Postfix) with ESMTPA id 19364E3145;
        Mon,  1 Aug 2022 16:27:22 +0000 (UTC)
Received: from [192.168.1.4] (internal [192.168.1.4])
        by mail.gonehiking.org (Postfix) with ESMTP id D15913EE33;
        Mon,  1 Aug 2022 10:27:20 -0600 (MDT)
Message-ID: <dfcbacca-5b64-9c8a-cce1-6434e97563ee@gonehiking.org>
Date:   Mon, 1 Aug 2022 10:27:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: khalid@gonehiking.org
Subject: Re: [PATCH] scsi: FlashPoint: remove redundant variable bm_int_st
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220730123736.147758-1-colin.i.king@gmail.com>
From:   Khalid Aziz <khalid@gonehiking.org>
In-Reply-To: <20220730123736.147758-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/22 06:37, Colin Ian King wrote:
> The variable bm_int_st is assigned a value but it is never read. The
> variable and the assignment are redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/scsi/FlashPoint.c:1726:7: warning: Although the value stored
> to 'bm_int_st' is used in the enclosing expression, the value is never
> actually read from 'bm_int_st' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/scsi/FlashPoint.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Khalid Aziz <khalid@gonehiking.org>


> 
> diff --git a/drivers/scsi/FlashPoint.c b/drivers/scsi/FlashPoint.c
> index 90253208a72f..3d9c56ac8224 100644
> --- a/drivers/scsi/FlashPoint.c
> +++ b/drivers/scsi/FlashPoint.c
> @@ -1712,7 +1712,7 @@ static unsigned char FlashPoint_InterruptPending(void *pCurrCard)
>   static int FlashPoint_HandleInterrupt(void *pcard)
>   {
>   	struct sccb *currSCCB;
> -	unsigned char thisCard, result, bm_status, bm_int_st;
> +	unsigned char thisCard, result, bm_status;
>   	unsigned short hp_int;
>   	unsigned char i, target;
>   	struct sccb_card *pCurrCard = pcard;
> @@ -1723,7 +1723,7 @@ static int FlashPoint_HandleInterrupt(void *pcard)
>   
>   	MDISABLE_INT(ioport);
>   
> -	if ((bm_int_st = RD_HARPOON(ioport + hp_int_status)) & EXT_STATUS_ON)
> +	if (RD_HARPOON(ioport + hp_int_status) & EXT_STATUS_ON)
>   		bm_status = RD_HARPOON(ioport + hp_ext_status) &
>   					(unsigned char)BAD_EXT_STATUS;
>   	else

