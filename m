Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8A650E8A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbiDYSvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244651AbiDYSuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:50:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED14D7629C;
        Mon, 25 Apr 2022 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=CZXYnwzf0/zyAsq09zp3zqYMU6rsh9JejxfBdubxHoY=; b=LJyzOfULynUAOhxDw00BV3IB5H
        fvN/dKv8dnmCxaP4b2TOXC6pDNcHvmAU1EoJVSWBSA5bU5cA91jqYjnN9iMsHhup2ybalmuci9s+C
        fkYGjGbWynDUyGwLlbixM5wlWjRfwzO+TIVwVFw6o0M0ja688mkrvguFcc5Lp2oq4Cjy/hmJZ3ZNN
        PXGNWSe/72vK+UZHiMt0YT+VZFjal8yVAB0iwgoGC+xtS+UOST29IUQ0eBCMKWlch3d+xCoFcv6hG
        8ITygZn5uldBUuH7fO6vGt4vrYMM23wnZmrrx5udpOxerjpTPbvYc7UnGDuDnnAAnVDnjmh+fi+BG
        lT3/0hhA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nj3jv-008bUI-Sk; Mon, 25 Apr 2022 18:47:16 +0000
Message-ID: <4b16edaa-05ee-1dbd-e44b-c7e0512971bd@infradead.org>
Date:   Mon, 25 Apr 2022 11:47:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 01/11] scsi: aacraid: Fix undefined behavior due to shift
 overflowing the constant
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20220405151517.29753-1-bp@alien8.de>
 <20220405151517.29753-2-bp@alien8.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220405151517.29753-2-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/22 08:15, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Fix
> 
>   drivers/scsi/aacraid/commsup.c: In function ‘aac_handle_sa_aif’:
>   drivers/scsi/aacraid/commsup.c:1983:2: error: case label does not reduce to an integer constant
>     case SA_AIF_BPCFG_CHANGE:
>     ^~~~
> 
> See https://lore.kernel.org/r/YkwQ6%2BtIH8GQpuct@zn.tnic for the gory
> details as to why it triggers with older gccs only.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/scsi/aacraid/aacraid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
> index f849e7c9d428..5e115e8b2ba4 100644
> --- a/drivers/scsi/aacraid/aacraid.h
> +++ b/drivers/scsi/aacraid/aacraid.h
> @@ -121,7 +121,7 @@ enum {
>  #define SA_AIF_PDEV_CHANGE		(1<<4)
>  #define SA_AIF_LDEV_CHANGE		(1<<5)
>  #define SA_AIF_BPSTAT_CHANGE		(1<<30)
> -#define SA_AIF_BPCFG_CHANGE		(1<<31)
> +#define SA_AIF_BPCFG_CHANGE		(1U<<31)
>  
>  #define HBA_MAX_SG_EMBEDDED		28
>  #define HBA_MAX_SG_SEPARATE		90

-- 
~Randy
