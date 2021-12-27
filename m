Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6149347FC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 13:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbhL0MTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 07:19:30 -0500
Received: from www381.your-server.de ([78.46.137.84]:59334 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbhL0MT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=bfPvK+uNfy/fPdeX5y49ljPp7IGjMAd0LS6/Rm/FA+M=; b=Ow2aVqdbToumpaIzYajJkeOxix
        nkcI7oznvYrgTXz9ESLbCfQpUiYwgjWCDYXLfShdxsW5Z83aMUOTE1tDDXjrY01NB134T+8hRwqGS
        VcV1k+dlgW9J6e6Pu/3qMjAAayR2H6vtzEJZSbWlXlzz6nEpsx9eXIwBNuAh6sCgvhHRznnSmDy7J
        cN1wIRq/RSW3/PCo7rj/1cOcbCoxNC00GfbVvpUnBS0U8oNSFlhc+55QNLMcXm2ppyFlIqNAfFZv+
        BPPIbxIVTAPBYWRUzCCTIKxJKEcMgYqgquR9Uo4931bXKUFUxjqc2oZGKLCw9JrH4H/hrVdfaZ+G9
        g0pphspA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1n1oyM-000AKd-GN; Mon, 27 Dec 2021 13:19:26 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1n1oyM-000553-9Z; Mon, 27 Dec 2021 13:19:26 +0100
Subject: Re: [PATCH v2 15/23] counter: 104-quad-8: Convert to new counter
 registration
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-16-u.kleine-koenig@pengutronix.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <406d627c-5eb3-b052-6d91-e37933584ed1@metafoo.de>
Date:   Mon, 27 Dec 2021 13:19:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211227094526.698714-16-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26404/Mon Dec 27 10:34:40 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 10:45 AM, Uwe Kleine-König wrote:
> [...]
>   
> -	return devm_counter_register(dev, &priv->counter);
> +	err = devm_counter_add(dev, counter);
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "Failed to add counter\n");
I wonder if we should put that dev_err_probe into the devm_counter_add 
since every driver wants to have it anyway.
> +
> +	return 0;
>   }
>   
>   static struct isa_driver quad8_driver = {


