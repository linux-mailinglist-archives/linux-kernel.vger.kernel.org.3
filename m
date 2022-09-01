Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180195A89C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiIAAZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiIAAYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:24:55 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AEF140B2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661991892; x=1693527892;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ooxA17H90r4EJBbz/H4WAry0ZgcsiZQD5fz0PPvFxIs=;
  b=Zk6zsIemNK4swmKCBtUfsMk6K/pOTvrXiYB4v7brXi+o2coM6DBm7z9d
   KEo6v+VV5nUqm3PpugsljV9a/l+ppmRblSFs8MECjyy4IggVRUE6n4wVA
   9Cw+d5wrczzJsMSkicgXcyRFV43jC20mImZmGtbVfAyNvRoU0uMwp7YPi
   nIzbse3fRvnhSPw9cjmtqR/Cq5bLSDA+f7SqhPljJMd8VuhbOkDYxQFH4
   RdVbqv2FqTXk5/MiojHD8T+wXNY0uVmNs5SJBvSmBztYh0bdme9rEDNwn
   v5b3WGLxxy3MXYQXKsZmXDU4+QsE9Qc2qZd5uFjRSGM6Ao8SmBjFRYJD3
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,279,1654531200"; 
   d="scan'208";a="210170853"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 08:24:50 +0800
IronPort-SDR: h9VoCIT0I5D5WFHcbBBWFpyUXrwQL1zSd0ZIfHftmvpHyf1lJblJN08cBFgR7aCArlZTMT7UyK
 hUZYnFAMco7BWfushG3+dRcd5C3kugGKasdmgY1myrvOjI9FAIyHnrdQAxaKFKEYUkmelFeQdR
 nMb+4b8yeqmX/BRW79+y4lBq3Hk4tgEAwZSAtU6FMpooOz8ujxNWTuc/Km114UYX0RyH1dgFyA
 VrBKyUx9MVMgInV42mOPkIVA+vNVVKBBWyJEuP5P8PnfNAj4Ldfnm+s1qxX+RxGTP0VgD/ErRr
 MYIuFYPs3JynbQdH5gLBuslT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Aug 2022 16:45:20 -0700
IronPort-SDR: esf0nDOP0DcThfqZTGnSOywtwd0a0/VbgCiUcIbIhCMNPc8/Jj6jXwQfoBGF8FZau2OkXUZtre
 CS+I9ruBhldui7TqwCq6JC2WQytdLTMOUUtCJe5PHxcMoeBzEAAN8bJlzmDCpph+VMacuALdvB
 Ygtv2/WtG+tntpAi8/zlQg8G/xN7WFQc3NP8/r6fzxPpSSgOBTGuGqgjocDxlFG5ULWK70tUSA
 220pteM2tu8AkDwxIReJVTe0YDWXIX5r9aTbzMN3LIHYJVMGwLJZSTTjxYQDor1MPjeq9F4sN1
 cr0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Aug 2022 17:24:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MJ1yW0k3Xz1RvTp
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:24:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661991890; x=1664583891; bh=ooxA17H90r4EJBbz/H4WAry0ZgcsiZQD5fz
        0PPvFxIs=; b=sm28BkyJoQu2n/DP7jG1tYAQzBzENRq2rbMtWbMtT9u0tjKbVHg
        xZ0mNNRQgboxwzmIzm7RRWP1g9+xKjxDd5KI0XG8Ic6qs1daIZeT9y8PLK+e2C1H
        EGhZKRQhg7dNBJvNaY+5uSNjYqHbuZYBXv9gLY+zFy8WP3ngddfinR0uKCugEgZH
        giVD5RjYgCPlVFgdQz9YYHd2BAhQPFRrfmcEcDrZcmNZiJleFFy5N1gzeWnFDHbT
        6I4IbHFwYp/5NorqHFZr+H2tVysbxYBBEzU0V+3MYU3ermRweU/QxGUXbL6VTRmk
        JGkjBp1qMVXesiHFCmn3cz3WXFyA4sEQHIQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AsLfOZW8arkC for <linux-kernel@vger.kernel.org>;
        Wed, 31 Aug 2022 17:24:50 -0700 (PDT)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MJ1yT0sCjz1RvLy;
        Wed, 31 Aug 2022 17:24:48 -0700 (PDT)
Message-ID: <a4a486b3-7acc-090f-d9c5-bac7a2239482@opensource.wdc.com>
Date:   Thu, 1 Sep 2022 09:24:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] scsi: megaraid: convert sysfs snprintf to sysfs_emit
Content-Language: en-US
To:     Xuezhi Zhang <zhangxuezhi3@gmail.com>, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
References: <20220831140325.396295-1-zhangxuezhi3@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220831140325.396295-1-zhangxuezhi3@gmail.com>
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

On 8/31/22 23:03, Xuezhi Zhang wrote:
> From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> 
> Fix up all sysfs show entries to use sysfs_emit
> 
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Looks OK.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/scsi/megaraid/megaraid_mbox.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
> index 157c3bdb50be..132de68c14e9 100644
> --- a/drivers/scsi/megaraid/megaraid_mbox.c
> +++ b/drivers/scsi/megaraid/megaraid_mbox.c
> @@ -3979,7 +3979,7 @@ megaraid_mbox_app_hndl_show(struct device *dev, struct device_attribute *attr, c
>  
>  	app_hndl = mraid_mm_adapter_app_handle(adapter->unique_id);
>  
> -	return snprintf(buf, 8, "%u\n", app_hndl);
> +	return sysfs_emit(buf, "%u\n", app_hndl);
>  }
>  
>  
> @@ -4048,7 +4048,7 @@ megaraid_mbox_ld_show(struct device *dev, struct device_attribute *attr, char *b
>  		}
>  	}
>  
> -	return snprintf(buf, 36, "%d %d %d %d\n", scsi_id, logical_drv,
> +	return sysfs_emit(buf, "%d %d %d %d\n", scsi_id, logical_drv,
>  			ldid_map, app_hndl);
>  }
>  

-- 
Damien Le Moal
Western Digital Research

