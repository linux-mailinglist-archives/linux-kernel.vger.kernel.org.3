Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871794AE749
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241790AbiBICrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiBIClL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:41:11 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739AFC07E5C0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 18:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644374412; x=1675910412;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5jGen3hKuAqmZCUZesezMs0C28vFlrjgrYakLwisLjM=;
  b=hKy/hjvKzd+wIqTn77jqiAiJueNt9HGN/4y2HEor9n1j4eMfLic8s82O
   x56+LUhtQJae5KaXY2KJgTVTI1fcf95F61b2peH9IpwUz8rxngU7ZxnS/
   tD3MM34QDjq8aWQpak7JS6sbyfz0AALV9D7R1CZcaYJZONpKFwgDtbY4G
   LI271eiSjsNb9+YMB1EdMireCu9bO8Y9BOIE73c4k9xUthkL5kyw/Qqcu
   YjQiWwSp4tsBg4ld7OeMLlzUCXJHRibNiTz4QuRqmV/scg084XJx16Wjm
   wHYi9fxhvUG1u5xx3DFJQQ4EP7nQnTF2cUMR+JDgFp54lJXUoIVudAMN+
   A==;
X-IronPort-AV: E=Sophos;i="5.88,354,1635177600"; 
   d="scan'208";a="193449709"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 10:40:12 +0800
IronPort-SDR: wbGwYMLbbSKqgcknWsdbrl2RlEK6M5wq+kbblV9IKKxDhMPpKT69pOANxs5tEUgihxQdUmIXZt
 DvHa/JQuiiXnGZhKWnICMgFSI/4l92FnvaV+hUehgSO87oYctQIOqxj5SxUFMfSOTkkqbrwwSj
 9LtZlcXc5IKyHfmHLuow7dNHTf3JUTtahPu5nIcGHTLpaCAtwuQalij/caX8bZzOmW/kljp9j0
 bDQ5a3Gq5gWWiizmhpHeFe+MrLwoXDl2g7zuDbNREbn+rEHQ384vMLzixHEd7STaf8HD+/3fmx
 WFmT6VPMD1Fm6dt+6yP3hBni
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 18:12:01 -0800
IronPort-SDR: PRVvmd513psvC+D8OdYZTcjG/rX8LY+L6USNRxnjlb6Ya7hkYeO0iu/lc8t2RqXqCgSGKASaCL
 IxVrp5doldXPozK96gB21wMTRjnBRh5EJOZKpIy/7JvpiIAGTZxj9e3+9QhdQSB417q+EiIw4X
 bHGNB1zZVSxchmh8SAKPqj49qbv5MNQLv/mhI6BE2kCrMSv9Xft7a+7vybK7N8iMiQw5GRLIx4
 2OijRS8yEgDzkTono4cGeHk3hb62LG9KcmayZ/DDbxFf6MFSqOO+WbILwXXqC2Uv5ztV2RiFGX
 NVA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 18:40:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jtkcq4g7Fz1SVp0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 18:40:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644374410; x=1646966411; bh=5jGen3hKuAqmZCUZesezMs0C28vFlrjgrYa
        kLwisLjM=; b=b5vxNOXovYZpnITGpEvJ4Vr4BmUY9xkeyqQubYzQRSo317/KyUx
        XdqsSzfDK8Nppd2BEZFG0GgvRyJHrNfJ/Jn0FHKxMYgogDO/51MVmU5qYYNebiSz
        fzTZqxmcCdxYg/GRmLWpK04k4p1Slk1tg+J7oE9AAL7z1LE5xl9euMB2Co3JOVfQ
        4OZW/Qi3ANlf2SOp4RT4SQdlt2Say/QfNQeA3lcEacEhpA2nVRI8tJXiYtNoHKvi
        /PsjX5Stam2mDF25DsD8C6et4KnZ+tM5BfU58nH+p3FU70GHv8grXJXxxuBLSW3Y
        ioeJz0mLZB0eM3ik1VWHfiz85WSzbMWkmRg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 26x7ipbS-P36 for <linux-kernel@vger.kernel.org>;
        Tue,  8 Feb 2022 18:40:10 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jtkcm6B4Xz1Rwrw;
        Tue,  8 Feb 2022 18:40:08 -0800 (PST)
Message-ID: <a0ec0411-6388-197f-abaa-08b2dc9dac4d@opensource.wdc.com>
Date:   Wed, 9 Feb 2022 11:40:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] scsi: ibmvfc: replace snprintf with sysfs_emit
Content-Language: en-US
To:     davidcomponentone@gmail.com, tyreld@linux.ibm.com
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <b4c150c86f539d3bac3fc8885252adb9f24ee48f.1644286482.git.yang.guang5@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b4c150c86f539d3bac3fc8885252adb9f24ee48f.1644286482.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 09:43, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> coccinelle report:
> ./drivers/scsi/ibmvscsi/ibmvfc.c:3453:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/ibmvscsi/ibmvfc.c:3416:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/ibmvscsi/ibmvfc.c:3436:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/ibmvscsi/ibmvfc.c:3426:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/ibmvscsi/ibmvfc.c:3445:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/ibmvscsi/ibmvfc.c:3406:8-16:
> WARNING: use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>
> ---
>  drivers/scsi/ibmvscsi/ibmvfc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
> index d0eab5700dc5..d5a197d17e0a 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c
> @@ -3403,7 +3403,7 @@ static ssize_t ibmvfc_show_host_partition_name(struct device *dev,
>  	struct Scsi_Host *shost = class_to_shost(dev);
>  	struct ibmvfc_host *vhost = shost_priv(shost);
>  
> -	return snprintf(buf, PAGE_SIZE, "%s\n",
> +	return sysfs_emit(buf, "%s\n",
>  			vhost->login_buf->resp.partition_name);
>  }
>  
> @@ -3413,7 +3413,7 @@ static ssize_t ibmvfc_show_host_device_name(struct device *dev,
>  	struct Scsi_Host *shost = class_to_shost(dev);
>  	struct ibmvfc_host *vhost = shost_priv(shost);
>  
> -	return snprintf(buf, PAGE_SIZE, "%s\n",
> +	return sysfs_emit(buf, "%s\n",
>  			vhost->login_buf->resp.device_name);
>  }
>  
> @@ -3423,7 +3423,7 @@ static ssize_t ibmvfc_show_host_loc_code(struct device *dev,
>  	struct Scsi_Host *shost = class_to_shost(dev);
>  	struct ibmvfc_host *vhost = shost_priv(shost);
>  
> -	return snprintf(buf, PAGE_SIZE, "%s\n",
> +	return sysfs_emit(buf, "%s\n",
>  			vhost->login_buf->resp.port_loc_code);
>  }
>  
> @@ -3433,7 +3433,7 @@ static ssize_t ibmvfc_show_host_drc_name(struct device *dev,
>  	struct Scsi_Host *shost = class_to_shost(dev);
>  	struct ibmvfc_host *vhost = shost_priv(shost);
>  
> -	return snprintf(buf, PAGE_SIZE, "%s\n",
> +	return sysfs_emit(buf, "%s\n",
>  			vhost->login_buf->resp.drc_name);
>  }
>  
> @@ -3442,7 +3442,7 @@ static ssize_t ibmvfc_show_host_npiv_version(struct device *dev,
>  {
>  	struct Scsi_Host *shost = class_to_shost(dev);
>  	struct ibmvfc_host *vhost = shost_priv(shost);
> -	return snprintf(buf, PAGE_SIZE, "%d\n", be32_to_cpu(vhost->login_buf->resp.version));
> +	return sysfs_emit(buf, "%d\n", be32_to_cpu(vhost->login_buf->resp.version));

The format should be %u, not %d. And while at it, please add a blank
line after the declarations.

>  }
>  
>  static ssize_t ibmvfc_show_host_capabilities(struct device *dev,
> @@ -3450,7 +3450,7 @@ static ssize_t ibmvfc_show_host_capabilities(struct device *dev,
>  {
>  	struct Scsi_Host *shost = class_to_shost(dev);
>  	struct ibmvfc_host *vhost = shost_priv(shost);
> -	return snprintf(buf, PAGE_SIZE, "%llx\n", be64_to_cpu(vhost->login_buf->resp.capabilities));
> +	return sysfs_emit(buf, "%llx\n", be64_to_cpu(vhost->login_buf->resp.capabilities));
>  }

Ditto for the blank line.

>  
>  /**
> @@ -3471,7 +3471,7 @@ static ssize_t ibmvfc_show_log_level(struct device *dev,
>  	int len;
>  
>  	spin_lock_irqsave(shost->host_lock, flags);
> -	len = snprintf(buf, PAGE_SIZE, "%d\n", vhost->log_level);
> +	len = sysfs_emit(buf, "%d\n", vhost->log_level);
>  	spin_unlock_irqrestore(shost->host_lock, flags);
>  	return len;
>  }
> @@ -3509,7 +3509,7 @@ static ssize_t ibmvfc_show_scsi_channels(struct device *dev,
>  	int len;
>  
>  	spin_lock_irqsave(shost->host_lock, flags);
> -	len = snprintf(buf, PAGE_SIZE, "%d\n", vhost->client_scsi_channels);
> +	len = sysfs_emit(buf, "%d\n", vhost->client_scsi_channels);
>  	spin_unlock_irqrestore(shost->host_lock, flags);
>  	return len;
>  }


-- 
Damien Le Moal
Western Digital Research
