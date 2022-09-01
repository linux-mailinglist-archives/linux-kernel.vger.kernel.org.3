Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79FE5A8B79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiIAC3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiIAC3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:29:38 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A7710B967
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661999377; x=1693535377;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AmAbtgwvf10cQiM7/CdK9N2i6a9/rk3f8YXqb8N5pFo=;
  b=rZXQdsIegvmL/e1t0qdA0dMxqwZxlIwvqfpmMeXGtFM73fuRtqG6GP/r
   QFJsL0Cle643fxtKZQEXDagkxv5Y1pWr2tGy3wYOj+SOzGd6tqaRV1vUB
   OwlyLSy7rTTAoRhJK+xp87RH06c2taHGlMlVjIbYx5CHD1suh9r3q0Cz5
   7b2WVuz7M2n2G/ydBETA9x+GqIQ5bfHwIySoX1ri1U4jiY6Xjhuh9cAax
   43EU+hOEyJ9fsypH8ol9dE2z/UEW4RTMspfNAfV/GWzIMp5nKAIKN1tHQ
   74apAae9QQyltTTL9KWcHAUB2bP7JbgdEJWIufKfRRbnpv1Soc0gtVT31
   A==;
X-IronPort-AV: E=Sophos;i="5.93,279,1654531200"; 
   d="scan'208";a="322292690"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 10:29:34 +0800
IronPort-SDR: /l/GKtqo4DV7FEFP39rVVV59z4Wnv9vddXwoxRQRqbNd6x1wuLt969h+fjlkjYs1Mg0Mxqrgs0
 UqF+zFiPUieX7UEkRIk2d4+Qq4XuKIxwKUA4m26UTHZbbYrsLh5e67Pd7OucCrsKloE7+yrhHc
 GYqpBDBnOlvZRO69YLYmAEM4G/cAm5hGV1nylzj1k9PXPTAKzt7YaF0w4N14Eoj6gn/FaZAFM5
 QtbGiinXKGI21vK+H+q0MfRJr71xl1ga1a3cvON8wSYLkL5ukrUsoXFfesQW+/Yox4XxEgLZ05
 Y4/SMDSv7dmzOlDCj2V7ZOKK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Aug 2022 18:50:03 -0700
IronPort-SDR: 7chTr04vTzUYIan+ddSPxBjAzdL75R12ze3ZwJkph4hpHPQUUTANgp3fk/LrRYyMi9UNepxv5e
 bVfalTXIZntB/EWumUdSLDzZA048FVXLJPFQEzBLlrAmKRO+iKmUXeys9hrm6dlWdbNNjemh0Q
 CUJlMCcsgp7qTeytPkMwO1ohMDsR+rEP6eeuNklutLnQgTN9W5L+nCQAiQyTwi1qyJBILvEN6F
 OEBVXjJGijgJQGZH1io59J08nHxLJvmpzNCxtWIJkh5AxOLnGxSR8tYCSfcHDG9KUstPi8dSAC
 mVo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Aug 2022 19:29:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MJ4kP74Nlz1RvTp
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:29:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661999373; x=1664591374; bh=AmAbtgwvf10cQiM7/CdK9N2i6a9/rk3f8YX
        qb8N5pFo=; b=Mz5wRbcJtzaU52xyP+271zksFtmgPwaTj9PY3o2+USGg6JYXYsC
        +4asGD2yhJexB3onnuvbjLyeb/SWM5zqCW0YsUoxjEJfHgTlGKxGUOn6IpKKdUmx
        vZucAPdR0ZT/B4xMG/VPyR1lbO2k2gv4CyDQ3l11pEm01oZjPyB89Am9PenI5Z0R
        nEo9kBxVIrRuF9UdV4PK8yVs2iQ4dgqU/jI765siK8wmAQIycQdCDNQ8kqclwoD0
        Rk3SjZQf989tjeg4HT/xSt7dkq0xEzH9r6yd99JA8tbkhhnwEFGx02PH7E14kTqh
        T/03iMnBb+bsaXMcVWIsDZX4xXlvuYkgbHw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vxjmvswvxzIC for <linux-kernel@vger.kernel.org>;
        Wed, 31 Aug 2022 19:29:33 -0700 (PDT)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MJ4kM478Gz1RvLy;
        Wed, 31 Aug 2022 19:29:31 -0700 (PDT)
Message-ID: <8c61be8b-61dc-5b90-43a4-bed15d6a6b8d@opensource.wdc.com>
Date:   Thu, 1 Sep 2022 11:29:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] scsi: csiostor: convert sysfs snprintf to sysfs_emit
Content-Language: en-US
To:     Xuezhi Zhang <zhangxuezhi3@gmail.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, bvanassche@acm.org,
        johannes.thumshirn@wdc.com, himanshu.madhani@oracle.com,
        zhangxuezhi1@coolpad.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220901015130.419307-1-zhangxuezhi3@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220901015130.419307-1-zhangxuezhi3@gmail.com>
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

On 9/1/22 10:51, Xuezhi Zhang wrote:
> From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst
> and show() should only use sysfs_emit() or sysfs_emit_at()
> when formatting the value to be returned to user space.
> 
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Looks OK.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
> v2: delete 'else' and extra space.
> v3: delete extra configs in patch v2
>     and use a new changelog.
> ---
>  drivers/scsi/csiostor/csio_scsi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
> index 9aafe0002ab1..05e1a63e00c3 100644
> --- a/drivers/scsi/csiostor/csio_scsi.c
> +++ b/drivers/scsi/csiostor/csio_scsi.c
> @@ -1366,9 +1366,9 @@ csio_show_hw_state(struct device *dev,
>  	struct csio_hw *hw = csio_lnode_to_hw(ln);
>  
>  	if (csio_is_hw_ready(hw))
> -		return snprintf(buf, PAGE_SIZE, "ready\n");
> -	else
> -		return snprintf(buf, PAGE_SIZE, "not ready\n");
> +		return sysfs_emit(buf, "ready\n");
> +
> +	return sysfs_emit(buf, "not ready\n");
>  }
>  
>  /* Device reset */
> @@ -1430,7 +1430,7 @@ csio_show_dbg_level(struct device *dev,
>  {
>  	struct csio_lnode *ln = shost_priv(class_to_shost(dev));
>  
> -	return snprintf(buf, PAGE_SIZE, "%x\n", ln->params.log_level);
> +	return sysfs_emit(buf, "%x\n", ln->params.log_level);
>  }
>  
>  /* Store debug level */
> @@ -1476,7 +1476,7 @@ csio_show_num_reg_rnodes(struct device *dev,
>  {
>  	struct csio_lnode *ln = shost_priv(class_to_shost(dev));
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n", ln->num_reg_rnodes);
> +	return sysfs_emit(buf, "%d\n", ln->num_reg_rnodes);
>  }
>  
>  static DEVICE_ATTR(num_reg_rnodes, S_IRUGO, csio_show_num_reg_rnodes, NULL);

-- 
Damien Le Moal
Western Digital Research

