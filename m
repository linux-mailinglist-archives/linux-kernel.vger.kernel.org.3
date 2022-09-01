Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B645A89C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIAAYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiIAAYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:24:18 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F8AE01E7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661991858; x=1693527858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b+nLJgpn28rI8XB+tceCDIqsNDOgTwY8YQFEJt059HM=;
  b=BhViqjnAIWncfaSvGVdgcthGu8rzpxkny2DeKzCAGxJiMsnjixH10vaw
   bk2EZMa+F3BF/h5YIFqj0BoVJxh8Q1P5ujjBvnzkc/MLvuh1OZ7wqeH0G
   DZhpOSTJXnHb+jkwycUKDTmOzr3Fzo6DBh9IRvBS6+1ndVNTPUpXc3iiB
   Mdwl693+Gv3YLcxkWDGofILBIzpWWhPiuToJ4VSPE2A12t0kE1yyTRHza
   Pjb1k7/Z/K/CNPYm1cGaWSkQT9YCF2h4dpnufv2S8IHqROXFvmId6ZPXC
   wW+8JEU3afLs85F9m9k5Eujllu/tajq9mh4d95YoRj1xfLJzGa2gS9K6D
   A==;
X-IronPort-AV: E=Sophos;i="5.93,279,1654531200"; 
   d="scan'208";a="322283317"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 08:24:03 +0800
IronPort-SDR: bWfHGvBUtIsRhu2gW4wI1sQb+16uY48gizIIfO0SRv0TELyW0NZfuBam7xaFBqZaUiAFYutGyG
 AXqoS2bcQ2B8bjR5T9itRAxLDky/vDaNtQbJPYoKV1q1BUV2m2wbr/qDlZS9VvOcd+LzN8Xp/m
 Qk3zoe1JcyLkmvprsEyl9gUWqnQOKxJ5IRfIXyZk7W6+giR+KxmEkfLGl1CNPwPFymhrFbvePv
 w2fiIL0QSJQMjPBXqX3RzW8qV+ytPP9PuCN2FX2w4mrdFS7Rs/rIqeVPBBDUvgG98IaWN4RE8g
 AW5chsyrq7XAT11H0YhEb/Z9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Aug 2022 16:44:32 -0700
IronPort-SDR: v/9UOPcnz8Ems1wGGgYsjW22qvNwOzpwP3kgodGQsFvvcLSwTJUnycSZKyBr+Pqg7FzrXFw7hY
 Vn8IHZoID5WFaEzEQZl2RcejBUx6CuXxLjWAiGf1wPvJjSpSaZcJQcgsCPmGcCTBsgP1hVlNqw
 0zOoUno28Sgt2MFAs875mdWhVdJdqCWklD+DR4suai5vKiCwYMYAdc1ZHyouk7w9poPFh5RTBo
 PewKLnGf/liUCGz2tMF4vbEjKimYo5NI2SThqRQrKi+0gdJa1h6N8uJzzg1yKTeYbCgTZYGC7w
 9IE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Aug 2022 17:24:03 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MJ1xZ417vz1Rwtm
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:24:02 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661991841; x=1664583842; bh=b+nLJgpn28rI8XB+tceCDIqsNDOgTwY8YQF
        EJt059HM=; b=JTtFZkmw3v192aUDwLFkhQq3NUpdFAX9T6Tkbf6SytEuCZljEm0
        0tdUyXI9KCRsrvUkH8MUnhWFEDYuntoSdItWs5IO43ThROrLE0RslYLWhRueFKwh
        URGER98smDL4qW9BPDGBP9delJtcMgX6mJ6LvR5bRDz2WDXTnZKdzEpi6h+S6Z1L
        MYhFhXqAE+xFbynyGtZavdV3lpN7LIaff7I7a5FxhRjNi7oWemdlhLpCD9pVYYr6
        QribCWlWQujm+0XaHJIp1Bh8TGF9qXEAyQRKFi3SoG1tpoPgOJ8ZP2zwZFYuSLyv
        3J2gu02nPatjI+INajmjSbwuRsWNN6Npsfg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NYy141TaSYGy for <linux-kernel@vger.kernel.org>;
        Wed, 31 Aug 2022 17:24:01 -0700 (PDT)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MJ1xX1klHz1RvLy;
        Wed, 31 Aug 2022 17:24:00 -0700 (PDT)
Message-ID: <b2a4ba8c-c67b-3041-9b81-783611de0763@opensource.wdc.com>
Date:   Thu, 1 Sep 2022 09:23:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] scsi: csiostor: convert sysfs snprintf to sysfs_emit
To:     Xuezhi Zhang <zhangxuezhi3@gmail.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, bvanassche@acm.org,
        johannes.thumshirn@wdc.com, himanshu.madhani@oracle.com,
        zhangxuezhi1@coolpad.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220831141046.406837-1-zhangxuezhi3@gmail.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220831141046.406837-1-zhangxuezhi3@gmail.com>
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

On 8/31/22 23:10, Xuezhi Zhang wrote:
> From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> 
> Fix up all sysfs show entries to use sysfs_emit
> 
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> ---
>  drivers/scsi/csiostor/csio_scsi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
> index 9aafe0002ab1..39e8c3c26a19 100644
> --- a/drivers/scsi/csiostor/csio_scsi.c
> +++ b/drivers/scsi/csiostor/csio_scsi.c
> @@ -1366,9 +1366,9 @@ csio_show_hw_state(struct device *dev,
>  	struct csio_hw *hw = csio_lnode_to_hw(ln);
>  
>  	if (csio_is_hw_ready(hw))
> -		return snprintf(buf, PAGE_SIZE, "ready\n");
> +		return sysfs_emit(buf, "ready\n");
>  	else

While at it, you could remove this useless else here.

> -		return snprintf(buf, PAGE_SIZE, "not ready\n");
> +		return sysfs_emit(buf,  "not ready\n");

Extra space after the ",".

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

