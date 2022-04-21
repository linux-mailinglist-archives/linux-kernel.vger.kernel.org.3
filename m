Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2983350977E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384880AbiDUG2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383929AbiDUG2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:28:04 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD2813F15;
        Wed, 20 Apr 2022 23:25:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAdJ87v_1650522310;
Received: from 192.168.0.205(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VAdJ87v_1650522310)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Apr 2022 14:25:11 +0800
Message-ID: <944afdcf-2901-babe-de4e-638582bd8632@linux.alibaba.com>
Date:   Thu, 21 Apr 2022 14:25:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [RFC PATCH] scsi: ses: Fix out-of-bound write at
 ses_enclosure_data_process()
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220415032313.94991-1-dtcccc@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20220415032313.94991-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

There seems to be some hardware problems with this machine, and it 
cannot bootup stably now... :-(

We guess the given desc_ptr[2] and [3] may be wrong on this machine, 
causing the calculated len becoming wrong too.

However, from the view of memory side, this is a potential oob write. 
Should we fix it?

On 2022/4/15 11:23, Tianchen Ding wrote:
> Our modified KFENCE reported a memory corruption:
> 
> [   52.584914] BUG: KFENCE: memory corruption in ses_enclosure_data_process+0x24b/0x310 [ses]
> 
> [   52.584917] Corrupted memory at 0xffff88982de06ff0 [ 0x00 . . . . . . . . . . . . . . . ] (in kfence-#1624698):
> [   52.607212]  ses_enclosure_data_process+0x24b/0x310 [ses]
> [   52.607215]  ses_intf_add+0x444/0x542 [ses]
> [   52.621369]  class_interface_register+0x110/0x120
> [   52.621373]  ses_init+0x13/0x1000 [ses]
> [   52.621377]  do_one_initcall+0x41/0x1c0
> [   52.621380]  do_init_module+0x5c/0x260
> [   52.621382]  __do_sys_finit_module+0xb1/0x110
> [   52.621386]  do_syscall_64+0x2d/0x40
> [   52.621388]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> [   52.621393] kfence-#1624698 [0xffff88982de06fc0-0xffff88982de06fe0, size=33, cache=kmalloc-64] allocated by task 1033:
> [   52.670344]  ses_enclosure_data_process+0x2ae/0x310 [ses]
> [   52.670347]  ses_intf_add+0x444/0x542 [ses]
> [   52.670353]  class_interface_register+0x110/0x120
> [   52.688165]  ses_init+0x13/0x1000 [ses]
> [   52.688169]  do_one_initcall+0x41/0x1c0
> [   52.688172]  do_init_module+0x5c/0x260
> [   52.688174]  __do_sys_finit_module+0xb1/0x110
> [   52.688177]  do_syscall_64+0x2d/0x40
> [   52.688179]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> This is because we check desc_ptr >= buf + page7_len first but then
> write '\0' to desc_ptr[len+4], while this address may be out of bound.
> 
> Fixes: 21fab1d0595e ("[SCSI] ses: update enclosure data on hot add")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
>   drivers/scsi/ses.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
> index 0a1734f34587..06b991e27c84 100644
> --- a/drivers/scsi/ses.c
> +++ b/drivers/scsi/ses.c
> @@ -559,11 +559,11 @@ static void ses_enclosure_data_process(struct enclosure_device *edev,
>   			struct enclosure_component *ecomp;
>   
>   			if (desc_ptr) {
> -				if (desc_ptr >= buf + page7_len) {
> +				len = (desc_ptr[2] << 8) + desc_ptr[3];
> +				desc_ptr += 4;
> +				if (desc_ptr + len > buf + page7_len) {
>   					desc_ptr = NULL;
>   				} else {
> -					len = (desc_ptr[2] << 8) + desc_ptr[3];
> -					desc_ptr += 4;
>   					/* Add trailing zero - pushes into
>   					 * reserved space */
>   					desc_ptr[len] = '\0';

