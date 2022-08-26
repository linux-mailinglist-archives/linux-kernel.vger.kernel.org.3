Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AED65A242C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343601AbiHZJVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245405AbiHZJVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:21:53 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AACBD2772;
        Fri, 26 Aug 2022 02:21:52 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q7FCEs022515;
        Fri, 26 Aug 2022 11:21:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=CVBSjOH/bwtlQxmEDweF2DMTVjTpkvUK2sI9jy9nqCc=;
 b=oNuU5Uyj1VSnFR0+pfXTcPFm2jxipKb2ey6H7RtbKGYfLb/05llcdnKOkny9/BT1R+JB
 DcuH1dMsKg6cRJ0v+sTIBViWb4JZwTn7lpBiPocVSkOOWXwlaWgHLXqTYP95wxuYDY6K
 L2ihI+dsM/uE9vnZKL83IkqKhMyBazIUWCA6okh4UbZJozj4kjiYTZUMggMPaLUttkiV
 r03x44LMzwsuSaFJqQivlJOxLXi5Fx9vbSiMdmUpRLhCh4HImYjb7hPc9BhE1iPkymd0
 U1nAjerMbfr3zPAjCllMPlcxUOIHf9vf0UkuYhBlgTQZP44QbItVXzjIyN4qlnrTIGdR kQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3j58m5r4v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 11:21:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D0D3F10002A;
        Fri, 26 Aug 2022 11:21:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CBD39217B7B;
        Fri, 26 Aug 2022 11:21:40 +0200 (CEST)
Received: from [10.201.21.72] (10.75.127.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 26 Aug
 2022 11:21:40 +0200
Message-ID: <5bd8dfad-de31-a5ac-2efc-a9a3d80650f0@foss.st.com>
Date:   Fri, 26 Aug 2022 11:21:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: spi: stm32-qspi: Fix stm32_qspi_transfer_one_message() error path
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220826091851.1393266-1-patrice.chotard@foss.st.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220826091851.1393266-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.122]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_04,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

Patch sent with incorrect commit title, a new one is in the pipe.
Sorry for that

Patrice

On 8/26/22 11:18, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> The patch a557fca630cc: "spi: stm32_qspi: Add transfer_one_message()
> spi callback" from Aug 23, 2022, leads to the following Smatch static
> checker warning:
> 
> drivers/spi/spi-stm32-qspi.c:627 stm32_qspi_transfer_one_message()
> error: uninitialized symbol 'ret'.Fix the following Smatch static checker warning:
> 
> Fixes: a557fca630cc ("spi: stm32_qspi: Add transfer_one_message() spi callback")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  drivers/spi/spi-stm32-qspi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
> index 92459daca95f..679fd1c34f7e 100644
> --- a/drivers/spi/spi-stm32-qspi.c
> +++ b/drivers/spi/spi-stm32-qspi.c
> @@ -562,7 +562,7 @@ static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
>  	struct spi_transfer *transfer;
>  	struct spi_device *spi = msg->spi;
>  	struct spi_mem_op op;
> -	int ret;
> +	int ret = 0;
>  
>  	if (!spi->cs_gpiod)
>  		return -EOPNOTSUPP;
> @@ -592,8 +592,10 @@ static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
>  			dummy_bytes = transfer->len;
>  
>  			/* if happens, means that message is not correctly built */
> -			if (list_is_last(&transfer->transfer_list, &msg->transfers))
> +			if (list_is_last(&transfer->transfer_list, &msg->transfers)) {
> +				ret = -EINVAL;
>  				goto end_of_transfer;
> +			}
>  
>  			transfer = list_next_entry(transfer, transfer_list);
>  		}
