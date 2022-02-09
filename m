Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC5E4AE792
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbiBIDD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354131AbiBICuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:50:00 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE8DC0401D1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 18:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644374700; x=1675910700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H7X0q8+8Rf4sF4doHl8BZDH9YkalaHuLv0owIfyARug=;
  b=Si+MChCymv5PUehx6G5WXnB48SwE3M50ksYCf6fZzVDdD5D7XBMRxrHE
   sq0i9JlO9CEr3defsQCQZnO3Eb6VSPrg78Z+HPsTGrj3n2U31FhiPMey9
   4J3sQ2YHZpam10MIek8fxgwRfd1RApDmj7dOqDLnuKizsIcVn84b0feVq
   Mw0V1euO2QMthIlun8zljdLcnX5Ww1eU5P1vcnKZTXn7PlyFch+NRYQfT
   8NGe6kPbieA9+sw61sptaV6ZEIjc02c9tGfb/JJnqSaTwhZth8l+sYk1d
   GD+lHSdWyIlTgBIZEwJuMRDa7If1PwSOjt42Y0R+MCehFxTwKgDbyzFTf
   A==;
X-IronPort-AV: E=Sophos;i="5.88,354,1635177600"; 
   d="scan'208";a="191407415"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 10:44:58 +0800
IronPort-SDR: LUluk24CgoIngvBak3CQe0/WL1FCaab5FtlaMlKVmXnOZVzve+oO7wJoSi1HtSIuqR+7aGdwjp
 6dsuhg4/nt99U7+BztBcA/bDo7KyZ5HWnSDW2FFbStyoDrpn1XvNWMMKtpP33paMM8Lxe5xX6R
 iqOF4hruDxc5rGC7jnzBhxHqcLxGcEuA7oDzTrEvP/GD6uVNZzTs+BggiDfU2LIHrk8fZmQrbZ
 k4Vh/YuEX7jXlLqK4UR8f0UhFOYUN7Hi1Hnr7fNcK2Vj+ctxH18Ctr9Cx7UQvgpVGZgFPBuSwd
 XbaVoklUX0UWxcI0thCdohc0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 18:17:57 -0800
IronPort-SDR: wRg7hRa1o8S1PzDQc2iM9dz/760wufVIEPHaDJmCnfhEuA1PryCSB8lA8Nx61uAG1kv0+DiATT
 kdcDsxnkvG6GZq5vOkUjXkW5KzIzpReSD4N0MLpaUfbwVBW1Pwr29URSCHH69vkCNrgkzVHoVi
 oNm+EIQs5SvOaCt1k42nNyIPhNn6z4RB+bl2XeHG5MXpy5TeeoGu/Xfqp44aCR815T+tvP3P2I
 lPnOQHtszUW79bMVpNnctyiqqjR3SC7F2N4cKpfv4rlsbhceg+z8vfQg8W2N5GxScaVvGjma0P
 u0Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 18:44:59 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JtkkK75b4z1SVp5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 18:44:57 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644374696; x=1646966697; bh=H7X0q8+8Rf4sF4doHl8BZDH9YkalaHuLv0o
        wIfyARug=; b=k2oav77+hmIPbaHN7yC1Y1a1CFzgg2SKukyV4vi0MQiUOBT/L8Q
        LjPAw+CxG1S+yH7Siil4fyRBCwHy6hnLReLO26unlsP71enF8Wu6E7+9lAu64Qqb
        OWQneM6bK3qItF0DultMCVm2PPtZuuTm+p4DaEycHPc5pWYaLnvQB0j4lK1yysqb
        XzEX6WPR5vKA97QljcMq3F1rcJnCKXy/V22HUuS82IhCcypl0rd52tVYI5a27Obp
        YPS4GNZPIXQKt4qgcJF7NxFSzbtZzjpmm4WPhphZj9bBwj6y7zE30i8IIOLcUJmz
        PHYErrucJ7s5kfx0cJ2bEW8rVANg5+SUGjQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D-WNElVKbn2k for <linux-kernel@vger.kernel.org>;
        Tue,  8 Feb 2022 18:44:56 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JtkkH2fzGz1Rwrw;
        Tue,  8 Feb 2022 18:44:55 -0800 (PST)
Message-ID: <9fc56cf0-1a8c-fa9b-60ce-74b7c7104902@opensource.wdc.com>
Date:   Wed, 9 Feb 2022 11:44:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] scsi: arcmsr: replace snprintf with sysfs_emit
Content-Language: en-US
To:     davidcomponentone@gmail.com, jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, yang.guang5@zte.com.cn,
        bvanassche@acm.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
References: <1c5ade32e6e60c94dd357c4a159df64a7e311459.1644283712.git.yang.guang5@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1c5ade32e6e60c94dd357c4a159df64a7e311459.1644283712.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 09:47, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> coccinelle report:
> ./drivers/scsi/arcmsr/arcmsr_attr.c:297:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/arcmsr/arcmsr_attr.c:273:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/arcmsr/arcmsr_attr.c:285:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/arcmsr/arcmsr_attr.c:261:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/arcmsr/arcmsr_attr.c:374:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/arcmsr/arcmsr_attr.c:309:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/arcmsr/arcmsr_attr.c:348:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/arcmsr/arcmsr_attr.c:335:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/arcmsr/arcmsr_attr.c:361:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/arcmsr/arcmsr_attr.c:322:8-16:
> WARNING: use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>
> ---
>  drivers/scsi/arcmsr/arcmsr_attr.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/scsi/arcmsr/arcmsr_attr.c b/drivers/scsi/arcmsr/arcmsr_attr.c
> index baeb5e795690..e66d761926e9 100644
> --- a/drivers/scsi/arcmsr/arcmsr_attr.c
> +++ b/drivers/scsi/arcmsr/arcmsr_attr.c
> @@ -258,8 +258,7 @@ static ssize_t
>  arcmsr_attr_host_driver_version(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE,
> -			"%s\n",
> +	return sysfs_emit(buf, "%s\n",
>  			ARCMSR_DRIVER_VERSION);

No need for the line break.

>  }
>  
> @@ -270,8 +269,7 @@ arcmsr_attr_host_driver_posted_cmd(struct device *dev,
>  	struct Scsi_Host *host = class_to_shost(dev);
>  	struct AdapterControlBlock *acb =
>  		(struct AdapterControlBlock *) host->hostdata;
> -	return snprintf(buf, PAGE_SIZE,
> -			"%4d\n",
> +	return sysfs_emit(buf, "%4d\n",
>  			atomic_read(&acb->ccboutstandingcount));
>  }
>  
> @@ -282,8 +280,7 @@ arcmsr_attr_host_driver_reset(struct device *dev,
>  	struct Scsi_Host *host = class_to_shost(dev);
>  	struct AdapterControlBlock *acb =
>  		(struct AdapterControlBlock *) host->hostdata;
> -	return snprintf(buf, PAGE_SIZE,
> -			"%4d\n",
> +	return sysfs_emit(buf, "%4d\n",
>  			acb->num_resets);

Please add a blank line after the declarations and there is no need for
the line break. The format should be %4u (unsigned value).

>  }
>  
> @@ -294,8 +291,7 @@ arcmsr_attr_host_driver_abort(struct device *dev,
>  	struct Scsi_Host *host = class_to_shost(dev);
>  	struct AdapterControlBlock *acb =
>  		(struct AdapterControlBlock *) host->hostdata;
> -	return snprintf(buf, PAGE_SIZE,
> -			"%4d\n",
> +	return sysfs_emit(buf, "%4d\n",
>  			acb->num_aborts);

Same comments (all of them).

>  }
>  
> @@ -306,8 +302,7 @@ arcmsr_attr_host_fw_model(struct device *dev, struct device_attribute *attr,
>  	struct Scsi_Host *host = class_to_shost(dev);
>  	struct AdapterControlBlock *acb =
>  		(struct AdapterControlBlock *) host->hostdata;
> -	return snprintf(buf, PAGE_SIZE,
> -			"%s\n",
> +	return sysfs_emit(buf, "%s\n",
>  			acb->firm_model);

blank line and line break comments apply.

>  }
>  
> @@ -319,8 +314,7 @@ arcmsr_attr_host_fw_version(struct device *dev,
>  	struct AdapterControlBlock *acb =
>  			(struct AdapterControlBlock *) host->hostdata;
>  
> -	return snprintf(buf, PAGE_SIZE,
> -			"%s\n",
> +	return sysfs_emit(buf, "%s\n",
>  			acb->firm_version);

line break not needed.

>  }
>  
> @@ -332,8 +326,7 @@ arcmsr_attr_host_fw_request_len(struct device *dev,
>  	struct AdapterControlBlock *acb =
>  		(struct AdapterControlBlock *) host->hostdata;
>  
> -	return snprintf(buf, PAGE_SIZE,
> -			"%4d\n",
> +	return sysfs_emit(buf, "%4d\n",
>  			acb->firm_request_len);

line break not needed and %u format.

>  }
>  
> @@ -345,8 +338,7 @@ arcmsr_attr_host_fw_numbers_queue(struct device *dev,
>  	struct AdapterControlBlock *acb =
>  		(struct AdapterControlBlock *) host->hostdata;
>  
> -	return snprintf(buf, PAGE_SIZE,
> -			"%4d\n",
> +	return sysfs_emit(buf, "%4d\n",
>  			acb->firm_numbers_queue);

Same.

>  }
>  
> @@ -358,8 +350,7 @@ arcmsr_attr_host_fw_sdram_size(struct device *dev,
>  	struct AdapterControlBlock *acb =
>  		(struct AdapterControlBlock *) host->hostdata;
>  
> -	return snprintf(buf, PAGE_SIZE,
> -			"%4d\n",
> +	return sysfs_emit(buf, "%4d\n",
>  			acb->firm_sdram_size);

Again same.

>  }
>  
> @@ -371,8 +362,7 @@ arcmsr_attr_host_fw_hd_channels(struct device *dev,
>  	struct AdapterControlBlock *acb =
>  		(struct AdapterControlBlock *) host->hostdata;
>  
> -	return snprintf(buf, PAGE_SIZE,
> -			"%4d\n",
> +	return sysfs_emit(buf, "%4d\n",
>  			acb->firm_hd_channels);
>  }

And here too.


-- 
Damien Le Moal
Western Digital Research
