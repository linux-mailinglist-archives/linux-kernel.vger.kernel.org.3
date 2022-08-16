Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E225961B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiHPSAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbiHPSAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:00:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456B2832EE
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=mUeMEEoPpuSOhmM19gXypq+f5Dbt5Qm5CVzcZ+ucRFs=; b=Ugkfd59ZNGHLCjQPzc4I1XhTto
        u2/T+Dbc0fAzP/pAB8ljx5Fs8SpCmThUrrC8bay7DKKu3VZ6RRT2jo53HitRrt7U1PbR2G+Qvo/78
        q92CkEnsRCbk+fgbnRN3poPQ8R2jv/LtUK5R09xPG2teTEwhIajnMlBVtBm650UExQPF+YJi3871A
        ewWqoDqqbLnf4vdzZZsQr0v1U0zpJF704BISNgNGt3nsNMEm2Xc5DGln16i8Ce+z254r2n0BL4qOk
        2YUCSNcHInEmgtSowl6qvwxjmDnrP6jSgzen6veHGc1uZgDJnbDWWr+Sf3guC0wnpre+p+rqjN8C6
        48lykPiQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oO0rC-005XEX-IB; Tue, 16 Aug 2022 18:00:02 +0000
Message-ID: <071ecdab-98a8-1f3b-a442-26668b2da446@infradead.org>
Date:   Tue, 16 Aug 2022 11:00:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
Content-Language: en-US
To:     Junhao He <hejunhao3@huawei.com>, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        liuqi115@huawei.com, f.fangjian@huawei.com,
        prime.zeng@hisilicon.com
References: <20220816131634.38195-1-hejunhao3@huawei.com>
 <20220816131634.38195-2-hejunhao3@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220816131634.38195-2-hejunhao3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/16/22 06:16, Junhao He wrote:
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 514a9b8086e3..4380eb1a0a73 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -201,4 +201,14 @@ config CORESIGHT_TRBE
>  
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called coresight-trbe.

Please insert a blank line here like it is done elsewhere.

> +config ULTRASOC_SMB
> +	tristate "Ultrasoc system memory buffer drivers"
> +	depends on ACPI && ARM64 && CORESIGHT_LINKS_AND_SINKS
> +	help
> +	  This driver provides support for the Ultrasoc system memory buffer (SMB).
> +	  SMB is responsible for receiving the trace data from Coresight ETM devices
> +	  and storing them to a system buffer.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ultrasoc-smb.
>  endif

thanks.
-- 
~Randy
