Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E44959703A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbiHQNw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiHQNwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:52:20 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9996FF7;
        Wed, 17 Aug 2022 06:52:17 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id a22so11535429pfg.3;
        Wed, 17 Aug 2022 06:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=vvb07CsEA4UGuE0zO/84ZhVWoMg9TxptV9DClaQUYJQ=;
        b=txZxiXqLmfGW6TCPCMkj4JJYFsVxTXK7OujzL6g2VjA+NW3qWi4wfZuzzfq302WGBs
         Uftmvwg47KLUbDJpk0CF+PLrUt9OGLFLCTT5HlpFxWUVY3cMT+92LPkw9QBuP/s5NEg2
         K3KrTlcXelz7HypZqwpV3czwrtGB9vCFB9iVAQA5Kfxe10lBmQMLTP2rZm5NJVabDR6Q
         DbJO0QUk98vWvbMWzSNPDFl+z1lm9CbCkH1epq9AUXItDlUm0sUuu6ssCjtwwZhToUTD
         JzPybA6XWKfBxaNv6bwl2yIvgJMm4WzUK8a9J03w2gvBrWj4OWpwPks1fOdbh9Hs/di6
         vOZg==
X-Gm-Message-State: ACgBeo1XlyGYWVpF95tf4hfyoGsrQlakpws/GInT2LGmu3rsjOfSBPrB
        3DibwOHzmxm2KI/8z95BOXY=
X-Google-Smtp-Source: AA6agR4r+iTGO7JHjATBc8wRWNuVuNqlGWU3KvnpF2F1XDDOLXI54rzA2PUZqh1xddk2wKBgSl/lpQ==
X-Received: by 2002:a62:a21a:0:b0:532:4191:610a with SMTP id m26-20020a62a21a000000b005324191610amr25682373pff.75.1660744336940;
        Wed, 17 Aug 2022 06:52:16 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001729da53673sm1578285plg.14.2022.08.17.06.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 06:52:16 -0700 (PDT)
Message-ID: <ceba3c96-5f32-9b5a-bacc-0eb942b9b90b@acm.org>
Date:   Wed, 17 Aug 2022 06:52:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] scsi: core: Fix block I/O error of USB card reader during
 resume
Content-Language: en-US
To:     Michael Wu <michael@allwinnertech.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220817083438.118293-1-michael@allwinnertech.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220817083438.118293-1-michael@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 01:34, Michael Wu wrote:
> When accessing storage device via an USB card reader, a block I/O error
> occurs during resume:
> 
> PM: suspend exit
> sd 0: 0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x00 driverbyte
> =0x08
> sd 0: 0:0:0: [sda] tag#0 Sense Key : 0x6 [current]
> sd 0: 0:0:0: [sda] tag#0 ASC=0x28 ASCQ=0x0
> sd 0: 0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 17 ce e1 00 00 f0 00
> blk_update_request: I/O error, dev sda, sector 1560289 op 0x0:(READ) flags
> 0x84700 phys_seg 19 prio class 0
> sd 0: 0:0:0: [sda] tag#0 device offline or changed
> 
> Fix it by changing the action in scsi_io_completion_action() from
> ACTION_FAIL to ACTION_RETRY by adding the condition `cmd->device->
> lockable`.
> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>   drivers/scsi/scsi_lib.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 4dbd29ab1dcc..4bc480721947 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -704,7 +704,8 @@ static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
>   	} else if (sense_valid && sense_current) {
>   		switch (sshdr.sense_key) {
>   		case UNIT_ATTENTION:
> -			if (cmd->device->removable) {
> +			if (cmd->device->removable &&
> +			    cmd->device->lockable) {
>   				/* Detected disc change.  Set a bit
>   				 * and quietly refuse further access.
>   				 */

To me the above doesn't look like a good way to address this. I don't 
see why a device being lockable should control whether or not a unit 
attention results in a retry? Shouldn't the decision taken by 
scsi_io_completion_action() depend on the ASC and ASCQ codes rather than 
on whether a device is removable and/or lockable?

BTW, the code modified by the above patch is old. This is what I found 
in the 2002 version of scsi_lib.c:

if ((SCpnt->sense_buffer[0] & 0x7f) == 0x70
     && (SCpnt->sense_buffer[2] & 0xf) == UNIT_ATTENTION) {
         if (SCpnt->device->removable) {
                 /* detected disc change.  set a bit and quietly refuse
                  * further access.
                  */
                 SCpnt->device->changed = 1;
                 SCpnt = scsi_end_request(SCpnt, 0, this_count);
                 return;
         } else {
                 /*
                  * Must have been a power glitch, or a
                  * bus reset.  Could not have been a
                  * media change, so we just retry the
                  * request and see what happens.
                  */
                 scsi_queue_next_request(q, SCpnt);
                 return;
}

Bart.

Thanks,

Bart.
