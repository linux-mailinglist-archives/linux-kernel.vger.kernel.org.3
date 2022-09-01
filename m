Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE9E5AA2AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiIAWOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiIAWOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:14:19 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Sep 2022 15:14:12 PDT
Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA6E1088
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:14:12 -0700 (PDT)
Received: from eig-obgw-5018a.ext.cloudfilter.net ([10.0.29.204])
        by cmsmtp with ESMTP
        id TfCuoqVreh3t8TsQToF1EM; Thu, 01 Sep 2022 22:12:41 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id TsQRonhtHJaa0TsQSoOvqS; Thu, 01 Sep 2022 22:12:40 +0000
X-Authority-Analysis: v=2.4 cv=Ko5eZEaN c=1 sm=1 tr=0 ts=63112e58
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=72JPPVIfIzSNxL7kpSG7Lw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=xOM3xZuef0cA:10
 a=wYkD_t78qR0A:10 a=jYsEJFciAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=6onvJrg5vSmBz42BuywA:9 a=QEXdDO2ut3YA:10
 a=cMfT0svooCsP4Al2A5dO:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q6ukgrEbB6qAjtGfaPyoouWhUSMHIGJkP/IXfkGbr5w=; b=pRlfgfuF4uCfH/UwxDBWg0lzyX
        fuCKYgsk010mLwphdLD37+hTdNSyiB3ZOZz6e799RDGlTB04az1h7QpVGAxhHbOfI9hkA37PBRgJ5
        RLj1N5jpiia6Q/4ef10sTfFpjh9EOcUZubOUb6tlCXDpHFnXhN1jOcCkxv4/8+w4FyomqM2G5tDg2
        WnIMb/6A5ULDqkR0aJFFK4TSo1Q9xnu4eq2aFVqEP9aS53ECidTcWeNM07igJvbedJ2W+Dpzh2IUM
        Zo9S77CfRiCrVl/Hvcll2OHNXyhLDNTgEHzPaYyRSXZHFAB+0O+JKr0ghrdrgEfjwEXfb09K3lwoM
        PqeGZ1JA==;
Received: from 51-171-241-192-dynamic.agg2.bbh.bbh-prp.eircom.net ([51.171.241.192]:47140 helo=[192.168.1.33])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1oTsQQ-002xVq-U0;
        Thu, 01 Sep 2022 17:12:39 -0500
Message-ID: <0255091d-e3df-7a4a-fa4c-7f9ae7226c73@embeddedor.com>
Date:   Thu, 1 Sep 2022 23:12:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] esas2r: Use flex array destination for memcpy()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Bradley Grove <linuxdrivers@attotech.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220901205729.2260982-1-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20220901205729.2260982-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 51.171.241.192
X-Source-L: No
X-Exim-ID: 1oTsQQ-002xVq-U0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 51-171-241-192-dynamic.agg2.bbh.bbh-prp.eircom.net ([192.168.1.33]) [51.171.241.192]:47140
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAHMpXUOxK1ap8j4yodqeCHBRjrl1ZFM/nhPG+WYNov/svcNWEjSCH5SEKLRex0BSqT3H9zfL+m+PBY9B6msKLSmgZzL3tD8NUTXQ+LUC7V7YSE9NIkh
 cpUELTAd3Gt8hTbvmV/X7oi4wM4YqjMMll8A46W1GJs24d9MaLp7YKzE5vEdu8AAQ96tESNZp0kNImgFahZfy+iovxEO5X9FosKcROa7JKA5NAq4piCZqMeK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/22 15:57, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing run-time destination buffer
> bounds checking for memcpy(), specify the destination output buffer
> explicitly, instead of asking memcpy() to write past the end of what
> looked like a fixed-size object. Silences future run-time warning:
> 
>    memcpy: detected field-spanning write (size 80) of single field "trc + 1" (size 64)
> 
> There is no binary code output differences from this change.
> 
> Cc: Bradley Grove <linuxdrivers@attotech.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/scsi/esas2r/atioctl.h      | 1 +
>   drivers/scsi/esas2r/esas2r_ioctl.c | 3 +--
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/esas2r/atioctl.h b/drivers/scsi/esas2r/atioctl.h
> index ff2ad9b38575..dd3437412ffc 100644
> --- a/drivers/scsi/esas2r/atioctl.h
> +++ b/drivers/scsi/esas2r/atioctl.h
> @@ -831,6 +831,7 @@ struct __packed atto_hba_trace {
>   	u32 total_length;
>   	u32 trace_mask;
>   	u8 reserved2[48];
> +	u8 contents[];
>   };
>   
>   #define ATTO_FUNC_SCSI_PASS_THRU     0x04
> diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
> index 08f4e43c7d9e..e003d923acbf 100644
> --- a/drivers/scsi/esas2r/esas2r_ioctl.c
> +++ b/drivers/scsi/esas2r/esas2r_ioctl.c
> @@ -947,10 +947,9 @@ static int hba_ioctl_callback(struct esas2r_adapter *a,
>   					break;
>   				}
>   
> -				memcpy(trc + 1,
> +				memcpy(trc->contents,
>   				       a->fw_coredump_buff + offset,
>   				       len);
> -
>   				hi->data_length = len;
>   			} else if (trc->trace_func == ATTO_TRC_TF_RESET) {
>   				memset(a->fw_coredump_buff, 0,
