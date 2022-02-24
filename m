Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320DA4C23B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 06:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiBXFv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 00:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiBXFv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:51:56 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669A92649A5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645681887; x=1677217887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y7ovshWXavovqNwSWM4vADOjZzxYbsup6lywxIbOhis=;
  b=XOk4KhKlUSBHPkx0Dt8SpW7HlAMmd20m9C39wuVsoj6XBxtZF3/vV17B
   G6J1MMmUipdRws4KR/OVLvFKreGKbY+mTgxIfr5LzUVgJbSAbqHBCexdE
   3hcdoOk5BFZ9uNye9T1VZR4FDypVp64ZtRUI9ZuQq6XbMs7Wm1tIH5KXw
   a7Gs9OOw9N4BvcyewQo9JsR5Kp/mhAS3W6mMp3Fo0RBgnjofigI++RrJx
   EE33Q++vH0jZMzND+RlX0wMMHtDWPqpaeluZOZ6e0ZS2vaoDlwkmmKlh5
   gHeKkzIxme67MOK64nip5AsVR/5+I4LG3aVGTlLF+4TEWQYKqDT+xWR3y
   g==;
X-IronPort-AV: E=Sophos;i="5.88,393,1635177600"; 
   d="scan'208";a="297948721"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2022 13:51:26 +0800
IronPort-SDR: n+G/rgXHcn5TF1JmY71w/ioXs9jYba99f7128WwX9lgyDY+Wss8U4efIBBmKTEa6+7zi1FZCAy
 N79s1tXOn9nB3Iu0Y16MptDm3dVzTDmeB8qMTeaZoVgTHqqNzGkXMdPm10g/hSxw2P2J8NZPBP
 X94dWtgx9zrtnYebtPGHpyQeWMvyGnYMDf6rK5RnpcnJIWgVUjzE74kIV4flspkgFLdxmNkpQp
 z+enxid/2OQg1fj2ZDgrmhfakErViSowHAc8ziHI7SYXg04B1FAaWmkbIcPx/3nJ67Oyc+TmsD
 PQR4VCTdLXBG60B4SVx0Bc8v
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 21:22:57 -0800
IronPort-SDR: ulOdA/+kKy1PMS6EtaGPU6rz6LoNdf5FgFsncPm8gR8EHlHQM17UdQgyaFB3kL1KmjgDc/OrE1
 RPB/B4voJkHz6mPsNqF3HcKMx1QrFazc0Hm3RjjMR6Dc9u75t4PgRkJDyLkd6zqN8k8f/ByB0C
 duda8oMROevG0Tc0jdpa0qpMJdksNqwBua+TfsMQXFtlc5f88sX1NL+Hzk9/8Wjk/WcQfIVIHj
 fz9o7QnN1FwY4RZww2sjXm989HaVESZX+LloecAZg1FnMG/dWeAibjR+NDp+AhaT//AVxva5E+
 tSU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 21:51:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K428Z2zwGz1SVp0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:51:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645681885; x=1648273886; bh=Y7ovshWXavovqNwSWM4vADOjZzxYbsup6ly
        wxIbOhis=; b=myOmQ6c6qtJL6xA5AVR878wAEF8PR8B+EJFgbQF5/YN59UZa3EP
        iGDhe/ufDPdEGCh2X0KfanDcn3N/NPIGIGtlcXAdvH/jbWJ+qd8dcyV2/Kex7u1d
        HtxNWq3YttVHxf3LZFJ2W8uZ0Ud1V2ZOyatZ+c2f1Iuw3k0WcBuQdbX5cCx7rUmI
        bZ8hYYIH3HDk/XMbuZmQNJlaN16dk7a1tjtFM4ioiIAtTkcKQJaxHhM7vKzVjHIR
        yhFZpjfU4nJN/rkzzJbIHACEE4i87ob2XbdW7bHHS0SOyhQd3z1ZLMKn1fRXuyAW
        UU+0HjdYFE482kIurErikk5VNoQvDgdKi7A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7J-uKFa1m-QR for <linux-kernel@vger.kernel.org>;
        Wed, 23 Feb 2022 21:51:25 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K428W6blfz1Rvlx;
        Wed, 23 Feb 2022 21:51:23 -0800 (PST)
Message-ID: <b62a0767-db0b-ad4f-2fdf-9b4e32e59af2@opensource.wdc.com>
Date:   Thu, 24 Feb 2022 14:51:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next] scsi: megasas: clean up some inconsistent indenting
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, kashyap.desai@broadcom.com
Cc:     sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220224004748.59442-1-yang.lee@linux.alibaba.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220224004748.59442-1-yang.lee@linux.alibaba.com>
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

On 2/24/22 09:47, Yang Li wrote:
> Eliminate the follow smatch warning:
> drivers/scsi/megaraid/megaraid_sas_fusion.c:5104 megasas_reset_fusion()
> warn: inconsistent indenting
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index c72364864bf4..aab600ef4cd6 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -5101,8 +5101,8 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
>  				for (j = 0; j < MAX_LOGICAL_DRIVES_EXT; ++j) {
>  					memset(fusion->stream_detect_by_ld[j],
>  					0, sizeof(struct LD_STREAM_DETECT));

While at it, you could fix this weird indentation too.

> -				 fusion->stream_detect_by_ld[j]->mru_bit_map
> -						= MR_STREAM_BITMAP;
> +				fusion->stream_detect_by_ld[j]->mru_bit_map
> +					= MR_STREAM_BITMAP;

Still inconsistent: missing one tab, no ?

>  				}
>  			}

Given the depth of the indentation, this initialization loop could go
into a little inline helper function.

-- 
Damien Le Moal
Western Digital Research
