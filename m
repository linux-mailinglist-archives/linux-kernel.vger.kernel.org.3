Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0F852818C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiEPKMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiEPKMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:12:45 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF43B7CB;
        Mon, 16 May 2022 03:12:43 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G8R1lN020075;
        Mon, 16 May 2022 12:12:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=1lZTEYpiHVmria85cnju2KrvLQzQm3RbcC/Q2zv3Kt4=;
 b=yxv+PK9h/a8UXCVGIx41VNfdPXIHx45V5bDOJQi1lpaQSnH0C21EvZhaljTgUreeSK/V
 pn+zE+xMijrEwuAJEW/OTa/rhM8wwRzQC8pLOE3wKadrqHU0TtcFEM9mchr2UnBnJogE
 6OEfXbe7RIZm88tr2yR9TKazh3JUFx2ij8I2gMwvCqgBu3krf7x6xC1sJMsj4/9YAHRx
 PXyUmHclFcL9umQf8Kdk+GTHQHS6ujajT62JfsPoAO9xdZP+hORxW5NbV3rXzop/Usvu
 x3p7YHSLg9xCDwYriDXgZQlVT0iX2qL3j6YLLtGp4AW6ldpzgqkllGExNH/tqNAlCXjS Fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g21ukgtcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 12:12:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8389310002A;
        Mon, 16 May 2022 12:12:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7BF0121A20E;
        Mon, 16 May 2022 12:12:34 +0200 (CEST)
Received: from [10.0.2.15] (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 16 May 2022 12:12:33
 +0200
Subject: Re: [PATCH 2/3] media: st-mipid02: add support for YVYU and VYUY
 formats
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alain Volmat <alain.volmat@foss.st.com>
References: <20220516091934.263141-1-hugues.fruchet@foss.st.com>
 <20220516091934.263141-3-hugues.fruchet@foss.st.com>
From:   Benjamin Mugnier <benjamin.mugnier@foss.st.com>
Message-ID: <ea6ccaff-7af6-9e92-97e8-4d214c5ea133@foss.st.com>
Date:   Mon, 16 May 2022 12:12:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220516091934.263141-3-hugues.fruchet@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_06,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/05/2022 11:19, Hugues Fruchet wrote:
> From: Alain Volmat <alain.volmat@foss.st.com>
> 
> Those two formats were missing in the list of supported MBUS
> formats.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

Reviewed-by: Benjamin Mugnier <benjamin.mugnier@foss.st.com>

> ---
>  drivers/media/i2c/st-mipid02.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
> index 59b48026c752..fe884d81b08b 100644
> --- a/drivers/media/i2c/st-mipid02.c
> +++ b/drivers/media/i2c/st-mipid02.c
> @@ -64,7 +64,8 @@ static const u32 mipid02_supported_fmt_codes[] = {
>  	MEDIA_BUS_FMT_SGRBG12_1X12, MEDIA_BUS_FMT_SRGGB12_1X12,
>  	MEDIA_BUS_FMT_UYVY8_1X16, MEDIA_BUS_FMT_BGR888_1X24,
>  	MEDIA_BUS_FMT_RGB565_2X8_LE, MEDIA_BUS_FMT_RGB565_2X8_BE,
> -	MEDIA_BUS_FMT_YUYV8_2X8, MEDIA_BUS_FMT_UYVY8_2X8,
> +	MEDIA_BUS_FMT_YUYV8_2X8, MEDIA_BUS_FMT_YVYU8_2X8,
> +	MEDIA_BUS_FMT_UYVY8_2X8, MEDIA_BUS_FMT_VYUY8_2X8,
>  	MEDIA_BUS_FMT_JPEG_1X8
>  };
>  
> @@ -133,7 +134,9 @@ static int bpp_from_code(__u32 code)
>  		return 12;
>  	case MEDIA_BUS_FMT_UYVY8_1X16:
>  	case MEDIA_BUS_FMT_YUYV8_2X8:
> +	case MEDIA_BUS_FMT_YVYU8_2X8:
>  	case MEDIA_BUS_FMT_UYVY8_2X8:
> +	case MEDIA_BUS_FMT_VYUY8_2X8:
>  	case MEDIA_BUS_FMT_RGB565_2X8_LE:
>  	case MEDIA_BUS_FMT_RGB565_2X8_BE:
>  		return 16;
> @@ -164,7 +167,9 @@ static u8 data_type_from_code(__u32 code)
>  		return 0x2c;
>  	case MEDIA_BUS_FMT_UYVY8_1X16:
>  	case MEDIA_BUS_FMT_YUYV8_2X8:
> +	case MEDIA_BUS_FMT_YVYU8_2X8:
>  	case MEDIA_BUS_FMT_UYVY8_2X8:
> +	case MEDIA_BUS_FMT_VYUY8_2X8:
>  		return 0x1e;
>  	case MEDIA_BUS_FMT_BGR888_1X24:
>  		return 0x24;
> 
