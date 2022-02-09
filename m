Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ACA4AE73C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbiBICpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbiBICgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:36:12 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2099DC0613CC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 18:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644374174; x=1675910174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WZcfzHor8V18qVDf7WVRCiIw8N5Zefnh5RiocBfInSA=;
  b=czufpgyjK4XTCULQIE8uZZY6D78KsTuti1bcOu0FiVmtyCZjqYr6kcck
   ZmmfNSVxgZqsCViWPFQu2tJ0yBlLMvAz2zl3zFrC1VYxxh1D/F2u6n5pb
   lTyYGmFFokNb29Yi1F1dS34bp8axZrCXMc75icueB5Yn1/xk1AX0Ksifw
   xfeB0yheMWOHy75Bh4CukkIQl925Tz+YJsfvzSf0waiHJQNHlqSv4HCls
   FnxG5o5Up4fJHXir5poJYdoZKVtBz8dhduujHdSvFg69lMc/guXQ+cIOC
   kHELK41XlxcLcyeMk0+tKfMj1p2Drb4aw0e3X4ricmU0VciAvd0ODVW3l
   A==;
X-IronPort-AV: E=Sophos;i="5.88,354,1635177600"; 
   d="scan'208";a="193449438"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 10:36:13 +0800
IronPort-SDR: u7alX/8NsaHPo44m9l6MsICsmiCr7E3di9DX3bZ742FCBSpPX1cDQjtmSb3UnCPBO3QaIXDEjN
 9dqOsz/XM7sR3Y6DXaz/PZT9FI9R65UpL23/jAqhQwJyE7T6srK2/tkPX3e38wbKVoRpfaE/T3
 FtYZxGlpTYKFB8gKIlXclgDQFkS3pkkHmAEijiCgqiZaE4v0H2PhGrty5ePcjDGWo7zk4+RhSn
 jctL2vT9TzVAcoMCgoHhaJiiI0DNL/iW77jTdQKYrWIPTH+74WW8Tj0dCVbpgwpGSWY2Ae6qI8
 iB/pI9mY5NULZn42t3C7IuuD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 18:09:05 -0800
IronPort-SDR: 6yL7r+GRB+kA7T9uhMrIxcVvppHaPzGcKXlirnDhRnKPs3JEG5j97+ePJNbxbYdiKMuuXGGPaD
 SWq/MqvG/7vafkHoj3ygRS6D8uQTB4FHFDW3WJKRFzPupXvPHT6K5BbgwyHq/lBPUtxKVbVEJG
 V0rru9c9IizKRE3GLcR8xE01L92XBbNBGs4psl1GcIjPUD90vlvGbDS199OIVNhUTuy85uJ3OL
 uw8VxqGuF69CNBNhrB6JdcBSX3Pf3ilFGuoGXdFYKycXK0qtU922iibltizqBlqVN7G2gKzYkl
 /SQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 18:36:06 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JtkX55V9pz1SVp0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 18:36:05 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644374163; x=1646966164; bh=WZcfzHor8V18qVDf7WVRCiIw8N5Zefnh5Ri
        ocBfInSA=; b=qvr1oje8ZXvRsv1k156dL4q9Uq7XkAT/sETGmc16wQ2ftwIRLzC
        x7e4zoGaRqmIilNGhO/AsUVfd+OA0mCUmOWTlroU+KWVvYmpXPXfExWV3FFzY+df
        WQ5BbHbjDxmE2yDbPrqGSl4ZZVNKGNo65NYCPiD/MMLm/81py377Hr8BlcnMZVmM
        SyGodaI183XR26/aoR40alGvNpMtNdVSXthODxlOZkHlhfjNjM8kiRJQ507tHqta
        b2nMVlcCcCPmPGPd/QNMaixh+0eXicZNtS+Q7+h1tsd2wCykwhQCy1HYWuWd9ruY
        Dpp5vtIqltc/wA7ueubWlZ5dIkKPvz25ZlQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UbIp0mc8Iw5P for <linux-kernel@vger.kernel.org>;
        Tue,  8 Feb 2022 18:36:03 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JtkX22GY2z1Rwrw;
        Tue,  8 Feb 2022 18:36:02 -0800 (PST)
Message-ID: <148a5448-71f1-4f39-834b-eb9283de0bfb@opensource.wdc.com>
Date:   Wed, 9 Feb 2022 11:36:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] scsi: csiostor: replace snprintf with sysfs_emit
Content-Language: en-US
To:     davidcomponentone@gmail.com, jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, bvanassche@acm.org,
        yang.guang5@zte.com.cn, jiapeng.chong@linux.alibaba.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
References: <d711ec5a5f416204079155666d2de49d43070897.1644287527.git.yang.guang5@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d711ec5a5f416204079155666d2de49d43070897.1644287527.git.yang.guang5@zte.com.cn>
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

On 2/9/22 09:40, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> coccinelle report:
> ./drivers/scsi/csiostor/csio_scsi.c:1433:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/csiostor/csio_scsi.c:1369:9-17:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/csiostor/csio_scsi.c:1479:8-16:
> WARNING: use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>
> ---
>  drivers/scsi/csiostor/csio_scsi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
> index 55db02521221..f9b87ae2aa25 100644
> --- a/drivers/scsi/csiostor/csio_scsi.c
> +++ b/drivers/scsi/csiostor/csio_scsi.c
> @@ -1366,9 +1366,9 @@ csio_show_hw_state(struct device *dev,
>  	struct csio_hw *hw = csio_lnode_to_hw(ln);
>  
>  	if (csio_is_hw_ready(hw))
> -		return snprintf(buf, PAGE_SIZE, "ready\n");
> +		return sysfs_emit(buf, "ready\n");
>  	else
> -		return snprintf(buf, PAGE_SIZE, "not ready\n");
> +		return sysfs_emit(buf, "not ready\n");

While at it, you could remove the useless "else" above.

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

num_reg_rnodes is uint32_t so the format should use %u.

>  }
>  
>  static DEVICE_ATTR(num_reg_rnodes, S_IRUGO, csio_show_num_reg_rnodes, NULL);


-- 
Damien Le Moal
Western Digital Research
