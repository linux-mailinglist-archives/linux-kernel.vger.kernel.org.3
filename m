Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1654931F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347646AbiASApr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:45:47 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:44791 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiASApp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:45:45 -0500
Received: by mail-pj1-f42.google.com with SMTP id m8-20020a17090a4d8800b001b4f361964fso936303pjh.3;
        Tue, 18 Jan 2022 16:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VB0exzG3tDGWmLfYVnTMtz9qpXJ6BzIlDOd7jL4cUNs=;
        b=wbedrUx/1HabTmeXyOZqDcjVA7dULNb8TTCIS4FoThdi4lq0iJtkZWiEiZaV+1Nwmi
         gQ6dQFTMu+6OBdTxBouxhXFid/ed5tE15WSP3VzEBaPv/RCSkT9e0Quy5PEOyS0nt9F6
         H5v4jjvWmhpGVpgCuFaJcu5bWY6k1y3red/ZXaUP9XQ5EZR8m0yAxG7Yqz72mLx2jbpv
         Pj9H4x3fUQe/MdPIa/nBfniH533OCp/l9GN8P0MkJKYZea+GdoXSLOcrSTz8qsVl0qqG
         lJEBB50QeNX4k6x4KnhuXg6ADaDN3Hi9al5oRahEfnr0DWptoQ9bTm7bXB1fgT7ZyfAs
         Pakg==
X-Gm-Message-State: AOAM532tThZ30XibduF5jcQllUfl4SvDKm/FcrniKtmigs2ycyCp0mmQ
        Bnvv+v4QDzKdr3K+b+MFaMc=
X-Google-Smtp-Source: ABdhPJzMKiBor0q4c7YB4psMDJsdynCNwv+LrVoE5n0ZzXxm5ZbwckSrMAntRIgmDJcPE4I0SO+1iw==
X-Received: by 2002:a17:902:bd05:b0:14a:f110:84e3 with SMTP id p5-20020a170902bd0500b0014af11084e3mr159569pls.110.1642553144421;
        Tue, 18 Jan 2022 16:45:44 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id d13sm19264813pfj.135.2022.01.18.16.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 16:45:43 -0800 (PST)
Message-ID: <3bb0f5ad-2cea-2509-a9e1-d8ed159bd875@acm.org>
Date:   Tue, 18 Jan 2022 16:45:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1] scsi: ufs: use an generic error code in
 ufshcd_set_dev_pwr_mode
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
References: <CGME20220117103107epcas2p3d7223ff63f6cb575316695cc8fb155a4@epcas2p3.samsung.com>
 <1642415361-140388-1-git-send-email-kwmad.kim@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1642415361-140388-1-git-send-email-kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 02:29, Kiwoong Kim wrote:
> The return value of ufshcd_set_dev_pwr_mode is given to
> device pm core. However, the function currently returns a result
> in scsi command and the device pm core doesn't understand it.
> It might lead to unexpected behaviors of user land. I found
> the return value led to platform reset in Android.
> 
> This patch is to use an generic code for SSU failures.
> 
> Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> ---
>   drivers/scsi/ufs/ufshcd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 1049e41..a60816c 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -8669,6 +8669,7 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
>   			    pwr_mode, ret);
>   		if (ret > 0 && scsi_sense_valid(&sshdr))
>   			scsi_print_sense_hdr(sdp, NULL, &sshdr);
> +		ret = -EIO;
>   	}
>   
>   	if (!ret)

Shouldn't "ret = -EIO" only be executed if ret > 0? Additionally, please 
update the documentation of ufshcd_set_dev_pwr_mode(). I'm referring to 
the following comment: "Returns non-zero if failed to set the requested 
power mode".

Thanks,

Bart.
