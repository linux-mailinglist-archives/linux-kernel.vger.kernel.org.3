Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482C048BA7B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245634AbiAKWIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiAKWIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:08:10 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885B4C06173F;
        Tue, 11 Jan 2022 14:08:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so7949656pjj.2;
        Tue, 11 Jan 2022 14:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7W9wG6a0r9h7eh7Y/7gTmsEddpx4vXeMZh5gRfRyQq0=;
        b=lqsd1muZWKNtM/4KRKzxNEh8aEaBd5mcI5R0gwCpoeJqYiJAAs5eTuqjujaGgGgSuR
         HI5RtAlrnryMg7ksr2f4JOyDyLddfg4AIEdSWtIr5J0KCsd1VtOv2p+7RSZLpguPkgrp
         WhsVitTUAsqJ4v/DhNkWkXgADvU3D110GZiNHlwdttla+nBKbTmDKzFhYAxVCRbPatyr
         Haw0MObb1ZRboaCPFCMp32hO1JQX1dpkeEG/mYvFg8FH7edH6+MTuMig7MePcHTGuzxh
         WjMFPEiMG5tzYrKJtt4FvWcZtYHQKUbUSzGBZHGwADZX1uh/CXziNPQPeBk/NXowILT9
         4ZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7W9wG6a0r9h7eh7Y/7gTmsEddpx4vXeMZh5gRfRyQq0=;
        b=3Kbkk8V1C3AsoBKqPpazYT6yuWrZb1aWtM353VexvV1Ghcbugiea/I1v9FKR+DoY6h
         d6C3K9tjkmHQqrsXc0vhE7lAnvaRB/PgJ38fPF1WZRV6xvdk5pwndsuLXQ2AEeiiJt1p
         PnU1uqwQfzFIp/bs3e31tl/0u+ZbHajY8qOYhtHv2HtjxlzBs4a7nnoxuEuHHtk9B8Kc
         hjOPq1feHuUaQ0qMNdiYA8tl5LLA9iWflab/pGUiVgyniAaYvkUt6JStJdV9uSnMApLf
         qd1iLpXxyMYWShu4GY2918Bou5in+LNt3s4FANkGFQi6jFEU6NYXmzJJaWLksKMVKJNg
         4xGw==
X-Gm-Message-State: AOAM533fCT9zks+IryFaTqS4WVXK6gfI+dso5cehGWRL0mx5zx58EXXP
        u75d7Tm/IaaePI7uHDO6JJo=
X-Google-Smtp-Source: ABdhPJyBTijm2jOTPtlSr+F1WHmw3ZLTBS/FkX3bF7cWBldnBRWTgwprecoZw/DwGmk2UBs7Sjtbhw==
X-Received: by 2002:a63:7c48:: with SMTP id l8mr5623231pgn.483.1641938889874;
        Tue, 11 Jan 2022 14:08:09 -0800 (PST)
Received: from [10.69.44.239] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id nn16sm3378762pjb.54.2022.01.11.14.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 14:08:09 -0800 (PST)
Message-ID: <292c6bcd-8e6f-49d9-3356-4dc3906f3d05@gmail.com>
Date:   Tue, 11 Jan 2022 14:08:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] lpfc: Retry FLOGI if previous attempt was rejected with
 busy
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
References: <20220110145937.129224-1-dwagner@suse.de>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220110145937.129224-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/2022 6:59 AM, Daniel Wagner wrote:
> The login state machine stops at the first FLOGI attempt which fails
> marked as busy:
> 
> lpfc 0000:58:00.0: 1:(0):2858 FLOGI failure Status:x9/x50000 TMO:x14 Data x19140820 x0
> 
> Add the FLOGI cmd to the list of commands which are allowed to retry.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> we observerd log below during failover operations. With this patch all
> is good. FLOGI is retried and succeeds eventually.
> 
> lpfc 0000:58:00.0: 29: [  575.971250] 1:0392 Async Event: word0:x8010140, word1:x3204000, word2:x3, word3:xc0011000
> lpfc 0000:58:00.0: 30: [  575.971260] 1:2896 Async FC event - Speed:8000GBaud Topology:x1 LA Type:x1 Port Type:1 Port Number:0 Logical speed:8000Mbps Fault:0
> lpfc 0000:58:00.0: 31: [  575.971264] 1:(0):0354 Mbox cmd issue - Enqueue Data: x95 (x0/x0) x0 xc600 x2
> lpfc 0000:58:00.0: 32: [  575.971266] 1:(0):0355 Mailbox cmd x95 (x0/x0) issue Data: x0 xc700
> lpfc 0000:58:00.0: 33: [  575.971461] 1:(0):0307 Mailbox cmd x95 (x0/x0) Cmpl lpfc_mbx_cmpl_read_topology [lpfc] Data: x9500 x3 x2001 x1 x80 x277cd000 x44 x80002005 x200a x0 x76cf064 x0
> lpfc 0000:58:00.0: 34: [  575.971472] 1:(0):0354 Mbox cmd issue - Enqueue Data: x8d (x0/x0) x0 xc600 x2
> lpfc 0000:58:00.0: 35: [  575.971473] 1:(0):0354 Mbox cmd issue - Enqueue Data: x7 (x0/x0) x6 xc600 x2
> lpfc 0000:58:00.0: 36: [  575.971475] 1:(0):0355 Mailbox cmd x8d (x0/x0) issue Data: x6 xc700
> lpfc 0000:58:00.0: 37: [  575.971682] 1:(0):0355 Mailbox cmd x7 (x0/x0) issue Data: x6 xc700
> lpfc 0000:58:00.0: 38: [  575.971689] 1:(0):0307 Mailbox cmd x8d (x0/x0) Cmpl lpfc_mbx_cmpl_read_sparam [lpfc] Data: x8d00 x0 x0 x70 x277cd800 x44 x1 x0 x0 x0 x0 x0
> lpfc 0000:58:00.0: 39: [  575.971826] 1:(0):0307 Mailbox cmd x7 (x0/x0) Cmpl lpfc_mbx_cmpl_local_config_link [lpfc] Data: x700 x0 x0 x0 x7d0 x76c xa x0 xf x0 x1800 x0
> lpfc 0000:58:00.0: 40: [  575.971827] 1:(0):0354 Mbox cmd issue - Enqueue Data: x8d (x0/x0) x6 xc600 x2
> lpfc 0000:58:00.0: 41: [  575.971827] 1:(0):0355 Mailbox cmd x8d (x0/x0) issue Data: x6 xc700
> lpfc 0000:58:00.0: 42: [  575.972048] 1:(0):0307 Mailbox cmd x8d (x0/x0) Cmpl lpfc_mbx_cmpl_read_sparam [lpfc] Data: x8d00 x0 x0 x70 x277cd800 x44 x1 x0 x0 x0 x0 x0
> lpfc 0000:58:00.0: 43: [  575.972050] 1:(0):0247 Start Discovery Timer state x7 Data: x21 xffff8804c6b149e8 x0 x0
> lpfc 0000:58:00.0: 44: [  575.972051] 1:(0):0932 FIND node did xfffffe NOT FOUND.
> lpfc 0000:58:00.0: 45: [  575.972052] 1:0001 Allocated rpi:x0 max:x3000 lim:x3000
> lpfc 0000:58:00.0: 46: [  575.972053] 1:(0):0007 Init New ndlp xffff8804c715d000, rpi:x0 DID:fffffe flg:x0 refcnt:1
> lpfc 0000:58:00.0: 47: [  575.972055] 1:(0):0116 Xmit ELS command x4 to remote NPORT xfffffe I/O tag: x2fc0, port state:x7 rpi x0 fc_flag:x810114
> lpfc 0000:58:00.0: 48: [  575.972055] 1:(0):0247 Start Discovery Timer state x7 Data: x21 xffff8804c6b149e8 x0 x0
> lpfc 0000:58:00.0: 49: [  576.011558] 1:0357 ELS CQE error: status=x9: CQE: 2fc00900 00000000 00050000 80010000
> lpfc 0000:58:00.0: 50: [  576.011566] 1:0328 Rsp Ring 2 error: IOCB Data: x40000000 x277cd400 x44 x0 x50000 xfffffe x12fc0 x14428a96 x0 x0 x0 x0 x0 x0 x0 x0
> lpfc 0000:58:00.0: 1:(0):2858 FLOGI failure Status:x9/x50000 TMO:x14 Data x19140820 x0
> 
> 
>   drivers/scsi/lpfc/lpfc_els.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
> index db5ccae1b63d..1880e95cb785 100644
> --- a/drivers/scsi/lpfc/lpfc_els.c
> +++ b/drivers/scsi/lpfc/lpfc_els.c
> @@ -4664,7 +4664,8 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   			break;
>   
>   		case LSRJT_LOGICAL_BSY:
> -			if ((cmd == ELS_CMD_PLOGI) ||
> +			if ((cmd == ELS_CMD_FLOGI) ||
> +			    (cmd == ELS_CMD_PLOGI) ||
>   			    (cmd == ELS_CMD_PRLI) ||
>   			    (cmd == ELS_CMD_NVMEPRLI)) {
>   				delay = 1000;

Daniel,

We want to look more closely at this. We do have FLOGI retry logic, but 
perhaps not tied to lsrjt logical busy. We have had OEM requirements as 
to how we do FLOGIs and respond to different status's. This change may 
disrupt those requirements (works for this config, not others). I'll get 
back to you shortly.

-- james

