Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391C14985F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbiAXRKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:10:13 -0500
Received: from foss.arm.com ([217.140.110.172]:41132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244122AbiAXRKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:10:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 765CD113E;
        Mon, 24 Jan 2022 09:10:11 -0800 (PST)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEE863F73B;
        Mon, 24 Jan 2022 09:10:10 -0800 (PST)
Message-ID: <5d9d0ead-f828-1e8a-b7cd-3ad50213c6bd@foss.arm.com>
Date:   Mon, 24 Jan 2022 17:09:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 02/60] drm/arm/hdlcd: Add support for the nomodeset kernel
 parameter
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Liviu Dudau <liviu.dudau@arm.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
 <20211215010008.2545520-3-javierm@redhat.com>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <20211215010008.2545520-3-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems fine.

Reviewed-by: Carsten Haitzler <carsten.haitzler@arm.com>

On 12/15/21 00:59, Javier Martinez Canillas wrote:
> According to disable Documentation/admin-guide/kernel-parameters.txt, this
> parameter can be used to disable kernel modesetting.
> 
> DRM drivers will not perform display-mode changes or accelerated rendering
> and only the systewm system framebuffer will be available if it was set-up.
> 
> But only a few DRM drivers currently check for nomodeset, make this driver
> to also support the command line parameter.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>   drivers/gpu/drm/arm/hdlcd_drv.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> index 479c2422a2e0..0939a64a9bd2 100644
> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> @@ -382,6 +382,9 @@ static int hdlcd_probe(struct platform_device *pdev)
>   	struct device_node *port;
>   	struct component_match *match = NULL;
>   
> +	if (drm_firmware_drivers_only())
> +		return -ENODEV;
> +
>   	/* there is only one output port inside each device, find it */
>   	port = of_graph_get_remote_node(pdev->dev.of_node, 0, 0);
>   	if (!port)
