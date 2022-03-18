Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7384DE0AB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiCRSER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbiCRSEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:04:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1429E2986CD;
        Fri, 18 Mar 2022 11:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61C2E61AC4;
        Fri, 18 Mar 2022 18:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53691C340EC;
        Fri, 18 Mar 2022 18:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647626573;
        bh=wqaDNmfAV73edja4gt4wDALkdE0waPsuWJQeh4kUqTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEQfpV0iL0MVeQsG0LWCZBK9MWKHRjSANH7xVzjFnQM/Of+XL97zCzjvn6h3j6jK0
         M2DJlGPv70ysNWIvpeHcejd91zeBPwPy74cQJxECJPdqc7dzSV/78H9dNxQOqGoUm3
         H9MUWhCY9qv42OSEhi0UpYr5Yzcq63Ki0B7d2u2XieHELRh3GY8HWHMetYvQQfu9Ii
         I/VxUgggMoH4SebCCXl1IXwSoTRfO4XaBxbkUm9Vz9os0nM9ef1GXhWlpGy2Zte2wk
         V9lkVCPwz+flNLcJ+4NlTvL7MAMgkeZu+7dd4hpgC9ehl8RUJLdaDQFcQWPAwycYfv
         oGTXngjasBSww==
Date:   Fri, 18 Mar 2022 11:02:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] soc: qcom: smem: use correct format characters
Message-ID: <YjTJRqlFOsXz7Ss7@dev-arch.thelio-3990X>
References: <20220316213118.2352683-1-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316213118.2352683-1-morbo@google.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 02:31:18PM -0700, Bill Wendling wrote:
> When compiling with -Wformat, clang emits the following warnings:
> 
> drivers/soc/qcom/smem.c:847:41: warning: format specifies type 'unsigned
> short' but the argument has type 'unsigned int' [-Wformat]
>                         dev_err(smem->dev, "bad host %hu\n", remote_host);
>                                                      ~~~     ^~~~~~~~~~~
>                                                      %u
> ./include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
>         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                                                ~~~     ^~~~~~~~~~~
> ./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
>                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>                              ~~~    ^~~~~~~~~~~
> drivers/soc/qcom/smem.c:852:47: warning: format specifies type 'unsigned
> short' but the argument has type 'unsigned int' [-Wformat]
>                         dev_err(smem->dev, "duplicate host %hu\n", remote_host);
>                                                            ~~~     ^~~~~~~~~~~
>                                                            %u
> ./include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
>         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                                                ~~~     ^~~~~~~~~~~
> ./include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
>                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>                              ~~~    ^~~~~~~~~~~
> 
> The types of these arguments are unconditionally defined, so this patch
> updates the format character to the correct ones for ints and unsigned
> ints.

Right. Alternatively, remote_host could be turned into a u16 to match
host0 and host1, as those are the only values that will ever be assigned
to it, which should have been done in commit 13a920ae7898 ("soc: qcom:
smem: a few last cleanups") to avoid introducing this warning in the
first place.

Probably does not matter though, unless the maintainers feel that is a
better fix.

> Link: ClangBuiltLinux/linux#378

Link: https://github.com/ClangBuiltLinux/linux/issues/378

as discussed on other patches :)

> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/soc/qcom/smem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index e2057d8f1eff..a98b5f395d15 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -844,12 +844,12 @@ qcom_smem_enumerate_partitions(struct qcom_smem *smem, u16 local_host)
>  			continue;
>  
>  		if (remote_host >= SMEM_HOST_COUNT) {
> -			dev_err(smem->dev, "bad host %hu\n", remote_host);
> +			dev_err(smem->dev, "bad host %u\n", remote_host);
>  			return -EINVAL;
>  		}
>  
>  		if (smem->partitions[remote_host]) {
> -			dev_err(smem->dev, "duplicate host %hu\n", remote_host);
> +			dev_err(smem->dev, "duplicate host %u\n", remote_host);
>  			return -EINVAL;
>  		}
>  
> -- 
> 2.35.1.723.g4982287a31-goog
> 
> 
