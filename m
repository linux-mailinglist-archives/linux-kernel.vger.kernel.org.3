Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB9652819B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242268AbiEPKOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242247AbiEPKOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:14:12 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A596BC0A;
        Mon, 16 May 2022 03:14:04 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G8G140000699;
        Mon, 16 May 2022 12:12:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=KfKrm3sBYSHtTqJoRSBDteMQlV8Hhg0xxEFjLsYm0mQ=;
 b=kFuSMPE5Y/svmlPHGJX9/+n0gSpEDLXSSL6I7q96JDi21FXNQPa/SVyel3P9nZpC4kQm
 ci/9kYzJHDVFapgB0A0jeMzdAC73aFCS6taDYiNvP6J+gwkdHkd3B+HQRED2kRCP+OQs
 Sb9GziYX2ew+7x1c6E7dENHAtd6M24Ilei2bR7/Du5uTLt0GmQq3zBwbE+SlOTb3rcT/
 2WhCf6hZVWuVZSJFyC/eIdQsqtIFcw6l4Cwbiki/IYRSg/pjywp5C74k9Db8sRbJ/qFU
 E4HYj7+c6+zLIdf6p+Xqs38e8UCmAmGuPCrjogEFIldR+FoL3jsANVxRTTZm9syhcG4Q vA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g23s18eq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 12:12:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E0A7A10002A;
        Mon, 16 May 2022 12:12:21 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D5B5021A215;
        Mon, 16 May 2022 12:12:21 +0200 (CEST)
Received: from [10.0.2.15] (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 16 May 2022 12:12:21
 +0200
Subject: Re: [PATCH 1/3] media: st-mipid02: add support of pixel clock
 polarity
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alain Volmat <alain.volmat@foss.st.com>
References: <20220516091934.263141-1-hugues.fruchet@foss.st.com>
 <20220516091934.263141-2-hugues.fruchet@foss.st.com>
From:   Benjamin Mugnier <benjamin.mugnier@foss.st.com>
Message-ID: <d99db0c5-548d-6dee-5e44-cbef20074ec5@foss.st.com>
Date:   Mon, 16 May 2022 12:12:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220516091934.263141-2-hugues.fruchet@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
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

Hi Hugues,

Thank you for the patchset.

On 16/05/2022 11:19, Hugues Fruchet wrote:
> Add support of pixel clock polarity.
> 
> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>

Reviewed-by: Benjamin Mugnier <benjamin.mugnier@foss.st.com>

> ---
>  drivers/media/i2c/st-mipid02.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
> index ef976d085d72..59b48026c752 100644
> --- a/drivers/media/i2c/st-mipid02.c
> +++ b/drivers/media/i2c/st-mipid02.c
> @@ -50,6 +50,7 @@
>  /* Bits definition for MIPID02_MODE_REG2 */
>  #define MODE_HSYNC_ACTIVE_HIGH				BIT(1)
>  #define MODE_VSYNC_ACTIVE_HIGH				BIT(2)
> +#define MODE_PCLK_SAMPLE_RISING				BIT(3)
>  /* Bits definition for MIPID02_DATA_SELECTION_CTRL */
>  #define SELECTION_MANUAL_DATA				BIT(2)
>  #define SELECTION_MANUAL_WIDTH				BIT(3)
> @@ -494,6 +495,8 @@ static int mipid02_configure_from_tx(struct mipid02_dev *bridge)
>  		bridge->r.mode_reg2 |= MODE_HSYNC_ACTIVE_HIGH;
>  	if (ep->bus.parallel.flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH)
>  		bridge->r.mode_reg2 |= MODE_VSYNC_ACTIVE_HIGH;
> +	if (ep->bus.parallel.flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
> +		bridge->r.mode_reg2 |= MODE_PCLK_SAMPLE_RISING;
>  
>  	return 0;
>  }
> 
