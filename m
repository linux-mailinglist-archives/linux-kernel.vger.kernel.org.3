Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644CA515AD5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382229AbiD3Gd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348588AbiD3GdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:33:22 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21296393E4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:29:57 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id kgc0nZiwSuIQVkgc0nTrzn; Sat, 30 Apr 2022 08:29:55 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 30 Apr 2022 08:29:55 +0200
X-ME-IP: 86.243.180.246
Message-ID: <794191df-e745-c591-bf1d-37945f96e73a@wanadoo.fr>
Date:   Sat, 30 Apr 2022 08:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] scsi: elx: efct: remove unnecessary memset in efct_io
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>,
        James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daniel Wagner <dwagner@suse.de>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Newsgroups: gmane.linux.scsi,gmane.linux.scsi.target.devel,gmane.linux.kernel
References: <20220318145230.1031-1-wanjiabing@vivo.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220318145230.1031-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/03/2022 à 15:52, Wan Jiabing a écrit :
> io->sgl is allocated by kzalloc(). The memory is set to zero.
> It is unnecessary to call memset again.
> 

Hi,

Nitpick: this kzalloc() should be a kcalloc() to avoid an open-coded 
multiplication when computing the size to allocate.

CJ


> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>   drivers/scsi/elx/efct/efct_io.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/scsi/elx/efct/efct_io.c b/drivers/scsi/elx/efct/efct_io.c
> index c3247b951a76..c612f0a48839 100644
> --- a/drivers/scsi/elx/efct/efct_io.c
> +++ b/drivers/scsi/elx/efct/efct_io.c
> @@ -62,7 +62,6 @@ efct_io_pool_create(struct efct *efct, u32 num_sgl)
>   			return NULL;
>   		}
>   
> -		memset(io->sgl, 0, sizeof(*io->sgl) * num_sgl);
>   		io->sgl_allocated = num_sgl;
>   		io->sgl_count = 0;
>   

