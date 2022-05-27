Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF56535D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350252AbiE0JWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbiE0JWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:22:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C031C924;
        Fri, 27 May 2022 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653643343; x=1685179343;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hr6qCLiP6QnEv9xG4V+M7/oTTlO+mnKRkqHOJKBzOCk=;
  b=QCasqd1+j/E4ETYUfNlwdcMmk5ifFJuGR5G7LvbgX85zotfW/pdE0jhe
   8jylGWVdFz18M6A2x/HR8wqG4QqJJ202hbnxxJgAXJUyEq3vSEohK1TMB
   OBbXJxOWfbLJBMjuBfcbkO7gtMBYlyS+aZ7mkY11RigKxsHw/iAowUlrf
   Nry6+G1yn9Df6B1jzlv7v1pIv49jhr7KMQWf0sRRuvQJo47wmqKfBXZRw
   P0oC/PdcNc94WlWnxD+9Jal+InXAP1bx8yAZ+QLM9qQicXI1r2hfVZBsL
   piRSdM+l8pW0dUOK//eleltJBN/irjtGh64dJ5i/BaWHyi8/IUU8NBUKr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="299775110"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="299775110"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 02:22:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="603774435"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.5])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 02:22:18 -0700
Message-ID: <9baa3f34-8ef7-cee2-f396-163b8206534d@intel.com>
Date:   Fri, 27 May 2022 12:22:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH V2 1/2] mmc: core: Define a new vendor ops to enable
 wakeup capability
Content-Language: en-US
To:     Sarthak Garg <quic_sartgarg@quicinc.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_kamasali@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thorsten Scherer <t.scherer@eckelmann.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        lizhe <sensor1010@163.com>
References: <20220526121215.25947-1-quic_sartgarg@quicinc.com>
 <20220526121215.25947-2-quic_sartgarg@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220526121215.25947-2-quic_sartgarg@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/22 15:12, Sarthak Garg wrote:
> Define a new vendor ops to let vendor initialize card as wakeup source

Did you consider using the existing ->init_card() op?

> and enable wakeup capability specially for SDIO cards which supports
> waking host from system suspend through external dedicated pins.
> 
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> ---
>  drivers/mmc/core/bus.c   | 3 +++
>  include/linux/mmc/host.h | 7 +++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 58a60afa650b..6192a52288fd 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -364,6 +364,9 @@ int mmc_add_card(struct mmc_card *card)
>  #endif
>  	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
>  
> +	if (card->host->ops->card_init_wakeup)
> +		card->host->ops->card_init_wakeup(card);
> +
>  	device_enable_async_suspend(&card->dev);
>  
>  	ret = device_add(&card->dev);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c193c50ccd78..3bd4374a64b8 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -193,6 +193,13 @@ struct mmc_host_ops {
>  
>  	/* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
>  	int	(*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
> +
> +	/*
> +	 * Optional for vendor to initialize card as wakeup source and
> +	 * enable wakeup capability specially for SDIO cards which supports
> +	 * waking host from suspend through external dedicated pins.
> +	 */
> +	void    (*card_init_wakeup)(struct mmc_card *card);
>  };
>  
>  struct mmc_cqe_ops {

