Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609CC511610
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiD0KvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiD0KvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:51:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5F137306E;
        Wed, 27 Apr 2022 03:22:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA0C261CDF;
        Wed, 27 Apr 2022 10:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65856C385A7;
        Wed, 27 Apr 2022 10:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651054934;
        bh=/l0+X+uY0RGD3XCFihbZoXk+GiTAu5F7H5VVNMO1SFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPRpKWw7RkFCv3TNq6CrOTPWcmgczFFuWKF5CbARd8K3PteP1PdJA0od0eqcxe5pk
         WilNsgLzRyd3Q+4bdGK6xXhl218reLuUimckCK6QtU1QuQQK3/E1fGRcHzlFzXJ9TZ
         m4S/+2B4jKWMcZlj8I8iE1nR/2xe3ok2LtGF+lueyucO4sQCu/lDiuM4FL+3t/aZAE
         isjG7urMZuoAvrdOOg8mEDKzQqvQSa53V7G+xV+/QbLFwUDMFCC4z1qZwR9ETPFyta
         3GGHyJwQjXTKsHrm7dZHFXhbcjUgDdc+DnYk6Zrz8ydzZNtGJwC4cIAHDnWlhBt6ID
         6Sylq0yZhFFQA==
Date:   Wed, 27 Apr 2022 15:52:06 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Hemant Kumar <quic_hemantk@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Paul Davey <paul.davey@alliedtelesis.co.nz>,
        Kees Cook <keescook@chromium.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: replace snprintf with sysfs_emit
Message-ID: <20220427102206.GD2536@thinkpad>
References: <20220426125902.681258-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426125902.681258-1-wanjiabing@vivo.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:58:59PM +0800, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/bus/mhi/host/init.c:89:8-16: WARNING: use scnprintf or sprintf
> 
> Use sysfs_emit and sysfs_emit_at instead of snprintf.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/host/init.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index cbb86b21063e..c137d55ccfa0 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -86,7 +86,7 @@ static ssize_t serial_number_show(struct device *dev,
>  	struct mhi_device *mhi_dev = to_mhi_device(dev);
>  	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
>  
> -	return snprintf(buf, PAGE_SIZE, "Serial Number: %u\n",
> +	return sysfs_emit(buf, "Serial Number: %u\n",
>  			mhi_cntrl->serial_number);
>  }
>  static DEVICE_ATTR_RO(serial_number);
> @@ -100,9 +100,8 @@ static ssize_t oem_pk_hash_show(struct device *dev,
>  	int i, cnt = 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++)
> -		cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
> -				"OEMPKHASH[%d]: 0x%x\n", i,
> -				mhi_cntrl->oem_pk_hash[i]);
> +		cnt += sysfs_emit_at(buf, cnt, "OEMPKHASH[%d]: 0x%x\n",
> +				i, mhi_cntrl->oem_pk_hash[i]);
>  
>  	return cnt;
>  }
> -- 
> 2.35.3
> 
> 
