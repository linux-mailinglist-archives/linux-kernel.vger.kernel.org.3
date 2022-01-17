Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DA5490566
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbiAQJtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:49:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236027AbiAQJtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642412961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6UhCfxh0kYRjvMOUSeeMixfl9rDKRgr6zR9cysLT+s=;
        b=fc2Ia8mg4GOeqXs8KRvvBKt99VcEG2cbn/0hYTYVSYLe8fxyNTxZhYZqIUmBXgsVKorglX
        pvWLVgmfj+5Sx6KjIvj/qJp2G/WRUB8s7TJa4ct7iQe2gMjVjoimv4TdtVQkAm5k9NJSzW
        et7i1XmIj1oQyR3nQzA19qJCw7COPHo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-0-6hmoLiPGWWpD1fLwPpLg-1; Mon, 17 Jan 2022 04:49:20 -0500
X-MC-Unique: 0-6hmoLiPGWWpD1fLwPpLg-1
Received: by mail-ed1-f69.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso13671529edt.20
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L6UhCfxh0kYRjvMOUSeeMixfl9rDKRgr6zR9cysLT+s=;
        b=r3WZh+V9YOdVj14wZ0b/FYBV6NXQjexWgZ5M/8nehkVBihKvqqiMDsug/HYyKJVGdb
         zOcXzrv/bdEKi7DswV7OSDuqbQsixVd9dh6MXOicm6tw1OFV0S1eMgF7Yh/v25qc+HcM
         4dcfs8WN6F/dZKTzDizV1d+xXgWyAntadnAxKVRHtUaSX4vjl5b8CAob6lM41fNt+ZIw
         NjkKOqRaFFQZzMxCOG4Ngi4u64h94VpxfM9NGFpy3cSgshP/0wnGdWeWUSW6xbx6Djzz
         vw41X3g2JnD32OByANGPVhGe8RMH7IOyLKxg2GbRygkXk5EeOk7r6gCLnjKgZyZCZ5vm
         nb8w==
X-Gm-Message-State: AOAM532mf1y+vpxVYjxGoaKs/HY2PhM1ApezkPZced6yawmO5bZZGF/1
        jWhNJjGJnlBVoP1fsjYmXeBMvoqTYpr6ucLdjdj4YNGBJlGiS1hHCInochjkmJWoTmtMh6MZH2X
        rsbdcxJf+N9Yc2e8ZO4SIco4V
X-Received: by 2002:a05:6402:518d:: with SMTP id q13mr20011000edd.377.1642412959281;
        Mon, 17 Jan 2022 01:49:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznkw/kzkt83FlVdPD+srXP4wOHPNVBlFm7pWhqZcdQJh+8gc3cC8kPbTgfzRMPOGqkQtXbyA==
X-Received: by 2002:a05:6402:518d:: with SMTP id q13mr20010987edd.377.1642412959116;
        Mon, 17 Jan 2022 01:49:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id l8sm1650172edv.52.2022.01.17.01.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 01:49:18 -0800 (PST)
Message-ID: <e49ac79d-eca1-e404-922b-48129f8a7e54@redhat.com>
Date:   Mon, 17 Jan 2022 10:49:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] platform/x86: intel_scu_ipc: Keep polling IPC status if
 it reads IPC_STATUS_ERR
Content-Language: en-US
To:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>
References: <20211230082353.2585-1-rajat.khandelwal@intel.com>
 <CO1PR11MB48359C6EC7DAC17F7FDD91D896459@CO1PR11MB4835.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CO1PR11MB48359C6EC7DAC17F7FDD91D896459@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/30/21 09:30, Khandelwal, Rajat wrote:
> Hi Mika
> I hope this annotation is correct? Sorry for the multiple errors! 
> 
> -----Original Message-----
> From: Khandelwal, Rajat <rajat.khandelwal@intel.com> 
> Sent: Thursday, December 30, 2021 1:54 PM
> To: mika.westerberg@linux.intel.com
> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; Khandelwal, Rajat <rajat.khandelwal@intel.com>; Westerberg, Mika <mika.westerberg@intel.com>
> Subject: [PATCH] platform/x86: intel_scu_ipc: Keep polling IPC status if it reads IPC_STATUS_ERR
> 
> The current implementation returns -EIO if and when IPC_STATUS_ERR is returned and returns -ETIMEDOUT even if the status is busy.
> This patch polls the IPC status even if IPC_STATUS_ERR is returned until timeout expires and returns -EBUSY if the status shows busy.
> Observed in multiple scenarios, trying to fetch the status of IPC after it shows ERR sometimes eradicates the ERR status.

So what this is doing is continue to poll,
even though the SCU says it is ready,
when the ERR bit is set ?

Are we sure the IPC does not just simply clear the err bit after some
time becuse it expects it to be "consumed" within X msec after dropping
busy low?

IOW what guarantees are there that this new behavior of ipc_data_readl()
is not actually causing us to ignore actual errors ?

Regards,

Hans





> 
> Signed-off-by: Rajat-Khandelwal <rajat.khandelwal@intel.com>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 7cc9089d1e14..1f90acaa7212 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -233,17 +233,23 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)  static inline int busy_loop(struct intel_scu_ipc_dev *scu)  {
>  	unsigned long end = jiffies + IPC_TIMEOUT;
> +	u32 status;
>  
>  	do {
> -		u32 status;
> -
>  		status = ipc_read_status(scu);
> -		if (!(status & IPC_STATUS_BUSY))
> -			return (status & IPC_STATUS_ERR) ? -EIO : 0;
> +		if (!(status & IPC_STATUS_BUSY)) {
> +			if (!(status & IPC_STATUS_ERR))
> +				return 0;
> +		}
>  
>  		usleep_range(50, 100);
>  	} while (time_before(jiffies, end));
>  
> +	if (status & IPC_STATUS_BUSY)
> +		return -EBUSY;
> +	if (status & IPC_STATUS_ERR)
> +		return -EIO;
> +
>  	return -ETIMEDOUT;
>  }
>  
> --
> 2.17.1
> 

