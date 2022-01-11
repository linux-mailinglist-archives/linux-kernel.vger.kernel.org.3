Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFEE48AB01
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348238AbiAKKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:06:35 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.169]:19978 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237384AbiAKKGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:06:34 -0500
X-KPN-MessageId: 91723933-72c5-11ec-9abf-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 91723933-72c5-11ec-9abf-005056abad63;
        Tue, 11 Jan 2022 11:02:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=EOOETbO5vVkzJvkYRefdFpbwIcgaffoiRwWeCBDL1IU=;
        b=EB4emMjTutQ5p/O2frDouI7woZeQ6UwrWzBsxvqKMf9O27C4B6ORqzonlEqrNQj2GCpjYj5Smc/+c
         Oez1wciRqNhUzH+TjwA5Fdh5tZ0n2Gqi/E9veEoERegrPTAJH6IuulNSZzhDEYkVSoJkltywaMhSv8
         0PrBOLmUBkL/koLhBrhYS7FiOEhlQY2Q8C+L/Ih9D5mqebsMfnIUsCh+SEAB6/dZYr2JNCwFFvd62Z
         A7ZzRvbOj3hOTWV66iHepka0xz6SfYI+Mkc0rMAZOnAD+dt0PKnlSdbbTvFTZubnHsRZfWEbSFhWY/
         xhPgBcZyQtbVEsN3AB77jDSY7ON9kKA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|krUIAOf9223901/Cn5TDSEEe2BQSGzbiaK6pCTWBl7LNTDJiMMNUwIkuLTuZv6X
 Z63O71jM+B2B17uAgHAP2zg==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 26f41c1e-72c6-11ec-83ab-005056ab1411;
        Tue, 11 Jan 2022 11:06:33 +0100 (CET)
Message-ID: <5454a150-7b11-dbce-02c4-d300c6629b1e@xs4all.nl>
Date:   Tue, 11 Jan 2022 11:06:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH] media: coda: Fix missing put_device() call in
 coda_get_vdoa_data
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220107081829.15108-1-linmq006@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220107081829.15108-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 09:18, Miaoqian Lin wrote:
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.
> Add the corresponding 'put_device()' in the error handling path.
> 
> Fixes: e7f3c5481035 ("[media] coda: use VDOA for un-tiling custom macroblock format")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/media/platform/coda/coda-common.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
> index 0e312b0842d7..579849082488 100644
> --- a/drivers/media/platform/coda/coda-common.c
> +++ b/drivers/media/platform/coda/coda-common.c
> @@ -405,9 +405,13 @@ static struct vdoa_data *coda_get_vdoa_data(void)
>  		goto out;
>  
>  	vdoa_data = platform_get_drvdata(vdoa_pdev);
> -	if (!vdoa_data)
> +	if (!vdoa_data) {
>  		vdoa_data = ERR_PTR(-EPROBE_DEFER);
> +		goto put;

Why the goto put? Just drop the goto...

> +	}
>  
> +put:

...and this label.

> +	put_device(&vdoa_pdev->dev);

This is the real fix :-)

Regards,

	Hans

>  out:
>  	of_node_put(vdoa_node);
>  

