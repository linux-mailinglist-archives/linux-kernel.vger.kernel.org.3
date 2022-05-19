Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ED652CFF9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiESJ6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbiESJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:58:07 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073499C2C4;
        Thu, 19 May 2022 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=sDvSwmy0bLm/bkmjH6GZeJZtaSz1EYheO2GvB9soUVc=; b=T7G7yrs8wan/jqyYwWtZwzna0+
        nubVgz1bp5GWsrLPiqSnwKiqIppWOqytMCv45q4GtdzY10a74FVpTyvjhssK5F0sF5mAwenN1sfce
        fyCCPUVmfK+y7MOOVLQmcpuF0iOX7QCc/bAsL5D/kwi72GaEamjqHEK1eSVhEF4PMhF3orU6ZHDcr
        Tc8eMmCoAutOTcsLyriHBzbreSXT3axSmBKE6iEpKfluxiEzS78oyWNL66uZ7LRUZAf1D6iih3DGb
        fjT7GeBn2qkDvkv/gZSWOXF+ApAT1qgCJNzbUPLB36lZXJxXbInoQSvAMSn+hZuVXO7kD+dSr7GoZ
        xuaMEAJA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1nrcux-000AXa-WF; Thu, 19 May 2022 11:58:04 +0200
Received: from [2001:a61:2ba3:7b01:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1nrcux-000D36-Pf; Thu, 19 May 2022 11:58:03 +0200
Message-ID: <d777d12c-7fd2-07d8-60ee-d2dc8f73f6c7@metafoo.de>
Date:   Thu, 19 May 2022 11:58:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] iio: trigger: sysfs: fix use-after-free on remove
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     kernel@axis.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220519091925.1053897-1-vincent.whitchurch@axis.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220519091925.1053897-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.5/26546/Thu May 19 10:03:47 2022)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 11:19, Vincent Whitchurch wrote:
> [...]
>   
>
> Fixes: e64e7d5c8c86e ("iio:trigger:sysfs Move out of staging.")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Thanks for the patch!

Strictly speaking the Fixes: should be

f38bc926d022 ("staging:iio:sysfs-trigger: Use irq_work to properly 
active trigger")


Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   drivers/iio/trigger/iio-trig-sysfs.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
> index 2a4b75897910..3d911c24b265 100644
> --- a/drivers/iio/trigger/iio-trig-sysfs.c
> +++ b/drivers/iio/trigger/iio-trig-sysfs.c
> @@ -191,6 +191,7 @@ static int iio_sysfs_trigger_remove(int id)
>   	}
>   
>   	iio_trigger_unregister(t->trig);
> +	irq_work_sync(&t->work);
>   	iio_trigger_free(t->trig);
>   
>   	list_del(&t->l);


