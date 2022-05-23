Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48DD531379
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiEWOdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbiEWOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:33:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E2649CB6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653316416; x=1684852416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IuGXxsgG3ZhE9KtfQ6orMoFZqsUCaaLiOomnMzr6usE=;
  b=jM6ZUb/ctz5fmIimTtiz/uHxODuMkN+n7QMoJz/9eLRaLrP+CoeErh3V
   8F/akKqcauP2X9hmhEh3NEqZQuA6HH5E3Q/VuFV1f0LWAvgfjs6mjopri
   Nz1Ko5f+dPIV1MTbfzWeITk4CoWrXv6GzANZHQLB7JuosLxPf4o1Hi+GX
   mB8wUEbJADyV+xg7vIohDhQWijQMOUXnuiuODNq/AnZon/OwWRajy0mAj
   G6sgStaGlhUhbHubmzWf6/jVHK17JvXhOwWND6mWXIDYK8wjJxY3WmQhT
   o7Nz4Wu1K8WD1rVjfHr6qhOrLvaeqRPWNqciKgkfQDMq19pRvuooDdyNx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="272055966"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="272055966"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 07:33:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="600679342"
Received: from jiaqingz-mobl.ccr.corp.intel.com (HELO [10.249.171.16]) ([10.249.171.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 07:33:34 -0700
Message-ID: <fde9bd5a-7161-9222-4719-4279b2416163@linux.intel.com>
Date:   Mon, 23 May 2022 22:33:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: Add support for mx66l2g45g
Content-Language: en-US
To:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org
References: <20220523143002.1754922-1-jiaqing.zhao@linux.intel.com>
From:   Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
In-Reply-To: <20220523143002.1754922-1-jiaqing.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PARSE_SFDP for now as the SNOR_ID3() patch is not merged yet, will
switch to it after it is merged.

On 2022-05-23 22:30, Jiaqing Zhao wrote:
> Macronix mx66l2g45g is a 3V, 2Gbit (256MB) NOR flash that supports
> x1, x2, and x4 operation modes.
> 
> Tested read/write/erase with Aspeed AST2600 BMC SoC operating in x2
> mode at 50MHz, using Aspeed spi-mem driver.
> 
> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
> ---
>  drivers/mtd/spi-nor/macronix.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index d81a4cb2812b..fd24ce9f02e2 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -95,6 +95,8 @@ static const struct flash_info macronix_nor_parts[] = {
>  	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> +	{ "mx66l2g45g",  INFO(0xc2201c, 0, 64 * 1024, 4096)
> +		PARSE_SFDP },
>  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
>  		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
>  	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
