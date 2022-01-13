Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDEA48D56E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiAMKJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:09:19 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.168]:31014 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiAMKJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:09:16 -0500
X-KPN-MessageId: c4b65610-7458-11ec-8862-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id c4b65610-7458-11ec-8862-005056aba152;
        Thu, 13 Jan 2022 11:08:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=3T/HKHFxjeunEssHrg2roWSWvU5aHHqCJVybm4QtGj0=;
        b=WNPj3QT/CgbFQAm5xcAv+o+uBsNkJBToPWHS3Qh9yggr9C2hnZBdtDADFBd1oTjMbFViscQ7dmGxG
         lWGDVDtFXZ9s81xNOlgH5y96qyfqa7YSiMG6hgjw7Ti4HimI41QBFZ7WrOfQ/AKnwGNfWdRkpONswu
         P9oSEjNjFU2e4E6DK3t4maVDIV7syG/uTjmg41lVK51mH7HthGDrGshR4jLZIUqKUHJYqMFWsfrrDM
         H88Gl97bC8lHw3H0mZV9hfiva71LVvKFoMPYzKmF1B8JX1kz+K2RAGFnSF7IgJCJoO+0ADEfmpTlr1
         T3McRuXKqMtAEhRVZe+LhasAz4hFBQA==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|vGuEdGoB77J0Odt/rWdNlYkIXWAWAbuja0doN16FgfcQpTL9Z20qIZNk3JGwbuc
 RvPPNZE6bMi2OlG7MxfeLpA==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id dcacec19-7458-11ec-81f5-005056ab7447;
        Thu, 13 Jan 2022 11:09:15 +0100 (CET)
Message-ID: <dff360d3-ff6b-b90c-89aa-2e21120f9a3f@xs4all.nl>
Date:   Thu, 13 Jan 2022 11:09:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH] media: vidtv: Add the missing kfree to avoid the memory
 leak
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, dwlsalmeida@gmail.com,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220112020555.692057-1-jiasheng@iscas.ac.cn>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220112020555.692057-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2022 03:05, Jiasheng Jiang wrote:
> Since kstrdup() allocate a space for e->name and will not automatically
> free.
> If kzalloc() fails, we just kfree e without e->name.
> Then we cannot get the pointer 'e->name' and cause the memory leak.
> 
> Fixes: 3d1387b3b8f6 ("media: vidtv: fix some warnings")
> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/media/test-drivers/vidtv/vidtv_s302m.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/test-drivers/vidtv/vidtv_s302m.c b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
> index ddaff46c440f..433fc0c7fdfa 100644
> --- a/drivers/media/test-drivers/vidtv/vidtv_s302m.c
> +++ b/drivers/media/test-drivers/vidtv/vidtv_s302m.c
> @@ -474,6 +474,7 @@ struct vidtv_encoder
>  
>  	ctx = kzalloc(priv_sz, GFP_KERNEL);
>  	if (!ctx) {
> +		kfree(e->name);

It should also free e->encoder_buf.

Regards,

	Hans

>  		kfree(e);
>  		return NULL;
>  	}

