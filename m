Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A868146F6AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhLIWWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:22:46 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:58298 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLIWWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:22:45 -0500
Received: from [10.0.2.15] ([146.0.31.27])
        by smtp.orange.fr with ESMTPA
        id vRkqmeRsoMNzvvRkqmHJXw; Thu, 09 Dec 2021 23:19:10 +0100
X-ME-Helo: [10.0.2.15]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 09 Dec 2021 23:19:10 +0100
X-ME-IP: 146.0.31.27
Message-ID: <52c4bc82-f8eb-c884-dfd8-2579f6632517@wanadoo.fr>
Date:   Thu, 9 Dec 2021 23:19:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] scsi: elx: efct: Avoid a useless memset
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, james.smart@broadcom.com,
        ram.vegesna@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, dwagner@suse.de
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <009cddb72f4a1b6d1744d5a8ab1955eb93509e41.1639086550.git.christophe.jaillet@wanadoo.fr>
 <4208b3d08a677601c73889f78dd25e5c9f056a86.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <4208b3d08a677601c73889f78dd25e5c9f056a86.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/12/2021 à 22:57, Joe Perches a écrit :
> On Thu, 2021-12-09 at 22:51 +0100, Christophe JAILLET wrote:
>> 'io->sgl' is kzalloced just a few lines above. There is no need to memset
>> it another time.
> 
> Better to use kcalloc as well and delete the memset

Sure, thanks for spotting it Joe.

Should a clean v2 be sent or the patch in your reply is enough?
As your proposal is better than mine, if a v2 is needed, can you do it?

CJ


> 
>> diff --git a/drivers/scsi/elx/efct/efct_io.c b/drivers/scsi/elx/efct/efct_io.c
> []
>> @@ -62,7 +62,6 @@ efct_io_pool_create(struct efct *efct, u32 num_sgl)
>>   			return NULL;
>>   		}
>>   
>> -		memset(io->sgl, 0, sizeof(*io->sgl) * num_sgl);
>>   		io->sgl_allocated = num_sgl;
>>   		io->sgl_count = 0;
>>   
> 
> ---
>   drivers/scsi/elx/efct/efct_io.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/elx/efct/efct_io.c b/drivers/scsi/elx/efct/efct_io.c
> index 71e21655916a9..109483f3e3dfd 100644
> --- a/drivers/scsi/elx/efct/efct_io.c
> +++ b/drivers/scsi/elx/efct/efct_io.c
> @@ -56,13 +56,12 @@ efct_io_pool_create(struct efct *efct, u32 num_sgl)
>   		}
>   
>   		/* Allocate SGL */
> -		io->sgl = kzalloc(sizeof(*io->sgl) * num_sgl, GFP_KERNEL);
> +		io->sgl = kcalloc(num_sgl, sizeof(*io->sgl), GFP_KERNEL);
>   		if (!io->sgl) {
>   			efct_io_pool_free(io_pool);
>   			return NULL;
>   		}
>   
> -		memset(io->sgl, 0, sizeof(*io->sgl) * num_sgl);
>   		io->sgl_allocated = num_sgl;
>   		io->sgl_count = 0;
>   
> 
> 
