Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B43849C9A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbiAZM0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:26:47 -0500
Received: from smtp117.ord1c.emailsrvr.com ([108.166.43.117]:49028 "EHLO
        smtp117.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241256AbiAZM0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1643199583;
        bh=ReKzEeMpEzLebnKabwkFlt+2OGOIe/9umBBTSRYIrCA=;
        h=Date:Subject:To:From:From;
        b=Xq2kMAvt7iEMJOeCphPlF49ooY3LBCSet4g97IAfgbsPtlL605ZBjCxKBXz/8R2a3
         QQNf0RWKxuYgkXG9+nwEhLEM1/jb3VZlOMxm/cv4sl9hnW9vOh/1kYDqxLYaNuZt5d
         2VALeFwc0HcCrx48aaedIK5dXiRXbXKmD6RAfLyM=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp15.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id F3DA32013E;
        Wed, 26 Jan 2022 07:19:42 -0500 (EST)
Message-ID: <43b079ef-1c4a-b4c4-62b3-10d6a62a3bac@mev.co.uk>
Date:   Wed, 26 Jan 2022 12:19:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH][next] comedi: das16: Use struct_size() helper in
 comedi_alloc_spriv()
Content-Language: en-GB
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220125232525.GA80228@embeddedor>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20220125232525.GA80228@embeddedor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 26608a2a-c2d7-4583-ba07-c77b0de1dce9-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2022 23:25, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/comedi/drivers/das16.c:964:45: warning: using sizeof on a flexible structure
> drivers/comedi/drivers/das16.c:998:45: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/comedi/drivers/das16.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/das16.c b/drivers/comedi/drivers/das16.c
> index 937a69ce0977..728dc02156c8 100644
> --- a/drivers/comedi/drivers/das16.c
> +++ b/drivers/comedi/drivers/das16.c
> @@ -961,7 +961,7 @@ static const struct comedi_lrange *das16_ai_range(struct comedi_device *dev,
>   
>   		/* allocate single-range range table */
>   		lrange = comedi_alloc_spriv(s,
> -					    sizeof(*lrange) + sizeof(*krange));
> +					    struct_size(lrange, range, 1));
>   		if (!lrange)
>   			return &range_unknown;
>   
> @@ -995,7 +995,7 @@ static const struct comedi_lrange *das16_ao_range(struct comedi_device *dev,
>   
>   		/* allocate single-range range table */
>   		lrange = comedi_alloc_spriv(s,
> -					    sizeof(*lrange) + sizeof(*krange));
> +					    struct_size(lrange, range, 1));
>   		if (!lrange)
>   			return &range_unknown;
>   

Looks like a nice tidy-up, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

(Note, I do not have anywhere to commit it, personally.)

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
