Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77104B72A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241007AbiBOPvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:51:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiBOPvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:51:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3155BC1D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644940246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLICeKJBXSwpSnP3JhYsPftkHusO2mSaNRauGzzS1kQ=;
        b=WyrXOidd6i59Ux4bmmVjQhC+7dbYzh9hH5dUBBgAset9mQMCru8uFG95xAPaoKY9eF0Tm0
        /zU/9q/y7uXD5LZ5JyY9Y2EY0gSXDAN8FpX/pr7cG7EJV8852qEE/DCLMGmv4hU0vD8Kla
        YnFqQnWhXhQFmpsgXtBJwKDqAIWzScs=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-NshtCdyQNHaEKWy-DfdAWA-1; Tue, 15 Feb 2022 10:50:44 -0500
X-MC-Unique: NshtCdyQNHaEKWy-DfdAWA-1
Received: by mail-oo1-f69.google.com with SMTP id t12-20020a4ab58c000000b002dcbee240efso12834917ooo.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dLICeKJBXSwpSnP3JhYsPftkHusO2mSaNRauGzzS1kQ=;
        b=7R+5yWeVpZRyvbL7JtmRu7bz0lRTw+TkpxQKfwRHclhOUBvjVk2nQQCEiCZ4SeVZzb
         ATb8jr6+1q2L3fqOs93rWpb80JDUUET8OGgQOelCb45I3RhFwzZNS9cRkzssD58UqLjd
         D1bl6DthG5Onk9tEXRbgefrDEEXplYaZ+OclqWMCt0x7uwqYK+c88FIlHkt5QKcjebtb
         zCYF3StfuG99I3AEODEktalv8n/peoGutAS4wKlEiSI6+OuyaOOBZ+1dKjVfmo3AW/Zl
         g+810Ri0I9F0tJmYQwspDDEuDDCnXOdH1eMsm8I6joHP20zP4Mm8KdQTKrISrsYDaGji
         WnOA==
X-Gm-Message-State: AOAM531baabRlOE69oaf/E9zz6OdPT3c+V/mzPiEW8d+Ki8TXtx5/vUp
        XasaxIrQdvRaSe5zlJdbNf2t3Mz0GuJ3gxH2CI/IFdQOr8mSnLyC9Wcy0fhPPTfNO2KDI8Bl2gp
        LNHLdIXaBX4m1wOjDPZw3rkzN
X-Received: by 2002:a9d:a28:: with SMTP id 37mr1098484otg.225.1644940243977;
        Tue, 15 Feb 2022 07:50:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbDHT+/ZKmI2sFiyJuItMHm4fmoZcrlrJeWNTWAPast7TEOmnI7Tbs6g1lSY552mvQQLiGwA==
X-Received: by 2002:a9d:a28:: with SMTP id 37mr1098472otg.225.1644940243774;
        Tue, 15 Feb 2022 07:50:43 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id c14sm4375713ots.71.2022.02.15.07.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 07:50:42 -0800 (PST)
Subject: Re: [PATCH v1 4/7] fpga: dfl: fix VF creation when ports have no
 local BAR space
To:     Tianfei zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-5-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c527e9c7-4588-463b-8a6b-3db68d003d7a@redhat.com>
Date:   Tue, 15 Feb 2022 07:50:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220214112619.219761-5-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/14/22 3:26 AM, Tianfei zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> When a port is not connected to the same PCIe endpoint as
> the FME, the port does not need to be released before being
> virtualized.  Fix VF creation code to handle this new use
Similar, how does this fit in with iofs, this looks like it would not be 
valid for the existing cards
> case.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>   drivers/fpga/dfl.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 26f8cf890700..cfc539a656f0 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1705,15 +1705,22 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_ports_pf);
>   int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
>   {
>   	struct dfl_feature_platform_data *pdata;
> -	int ret = 0;
> +	int ret = 0, port_count = 0;
>   
>   	mutex_lock(&cdev->lock);
> +
> +	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
> +		if (pdata->dev)

This looks wrong,

pdata->dev is dereferenced below, if there is a case were (!pdata->dev) 
here there would be crash later.

> +			continue;
> +		port_count++;

how does this work when only some of the ports are handled in the new way ?

Tom

> +	}
> +
>   	/*
>   	 * can't turn multiple ports into 1 VF device, only 1 port for 1 VF
>   	 * device, so if released port number doesn't match VF device number,
>   	 * then reject the request with -EINVAL error code.
>   	 */
> -	if (cdev->released_port_num != num_vfs) {
> +	if (port_count && cdev->released_port_num != num_vfs) {
>   		ret = -EINVAL;
>   		goto done;
>   	}

