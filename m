Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608F858D776
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbiHIKeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiHIKeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:34:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC522316F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:34:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso6469081wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 03:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DQRRlVUhziUMpmzTtyj/FjxWnL2Ta3UOCCMy0rVxtPo=;
        b=hIe85Ye8U0fpIgLGMyqDJw0sLOJ0iRRkFLAHnJXEHUY106Gcz0hFC4cU2pbLzAa7aP
         XMrYEze9DfYlOICkai5vEXdJVK6oUJG6LlK61EgCJmvm4+FatxTpueasi+MprmrjwUca
         boi6pWHAnY7TvTnj6vlQv2+IpQ3b68lXwZobRhNxadSYGTCW4+/7oBMwIXhC28ItViMB
         8NT/znXui4fC0mctyMq395of3BdAr7dMM+X5H9v9vy5tGZHxLMjS+TLeFCKqNlrQHhHZ
         F/TnydJR3YHohlIARSUL877cQdkAQyDdoooOAuRKSNpPjx/Zstmz7a8s9yYs6BBMGnNr
         4chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DQRRlVUhziUMpmzTtyj/FjxWnL2Ta3UOCCMy0rVxtPo=;
        b=H7fEsbeCbLsM0q01RXp2ozsvot33FlJwDIrUTV1v9Hd0ewVvHWjWjKZRsd+DpkEfq/
         XrW4NRC/jyvjOr2y7w3DBC5n76Eikk44FhQoMVz82w67PvYF3Q1nPSBAHyXlzspGgpeB
         ZhBvq0ijkc4MAVI72cAM8C7B1oYxq6BNQgiVrfxFLc5l+o/I2OzqwNPificlhLdmNMh9
         undETCjNIVbSk6Y3nruyFjc1N3rEJqwnTZPsQxmWVFfVDwTW2ErnsozQMAEOvbP1DmVL
         tawq83KWTC2p9374JyNDj2FJpro+crDlGDsto7bDu9kRtyyISXOAdYk0jZe7piJbpVDv
         KZlw==
X-Gm-Message-State: ACgBeo2U8QblEkPkXLO1X6MmE+T4YfHl1y3OIH+fskirZh7+jWDh6ASv
        /e/99UQxsWHmlXNXHlWPvEeArwXLWkYA9w==
X-Google-Smtp-Source: AA6agR7TCPhH3qG1wN2U9szW1/m0SMOjYHQp5Yh8MIRWhgqYyLEubveA/vIHJQl9qfruXgoqkj4zOg==
X-Received: by 2002:a05:600c:2b87:b0:3a5:237a:baa with SMTP id j7-20020a05600c2b8700b003a5237a0baamr10872953wmc.66.1660041240334;
        Tue, 09 Aug 2022 03:34:00 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c190a00b003a32251c3f9sm24569253wmq.5.2022.08.09.03.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 03:33:59 -0700 (PDT)
Date:   Tue, 9 Aug 2022 11:33:58 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
        kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH bpf] bpf, arm64: Fix bpf trampoline instruction endianness
Message-ID: <YvI4FqZ91e2+0sBA@myrica>
References: <20220808040735.1232002-1-xukuohai@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808040735.1232002-1-xukuohai@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ arm64 maintainers]

On Mon, Aug 08, 2022 at 12:07:35AM -0400, Xu Kuohai wrote:
> The sparse tool complains as follows:
> 
> arch/arm64/net/bpf_jit_comp.c:1684:16:
> 	warning: incorrect type in assignment (different base types)
> arch/arm64/net/bpf_jit_comp.c:1684:16:
> 	expected unsigned int [usertype] *branch
> arch/arm64/net/bpf_jit_comp.c:1684:16:
> 	got restricted __le32 [usertype] *
> arch/arm64/net/bpf_jit_comp.c:1700:52:
> 	error: subtraction of different types can't work (different base
> 	types)
> arch/arm64/net/bpf_jit_comp.c:1734:29:
> 	warning: incorrect type in assignment (different base types)
> arch/arm64/net/bpf_jit_comp.c:1734:29:
> 	expected unsigned int [usertype] *
> arch/arm64/net/bpf_jit_comp.c:1734:29:
> 	got restricted __le32 [usertype] *
> arch/arm64/net/bpf_jit_comp.c:1918:52:
> 	error: subtraction of different types can't work (different base
> 	types)
> 
> This is because the variable branch in function invoke_bpf_prog and the
> variable branches in function prepare_trampoline are defined as type
> u32 *, which conflicts with ctx->image's type __le32 *, so sparse complains
> when assignment or arithmetic operation are performed on these two
> variables and ctx->image.
> 
> Since arm64 instructions are always little-endian, change the type of
> these two variables to __le32 * and call cpu_to_le32 to convert
> instruction to little-endian before writing it to memory.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: efc9909fdce0 ("bpf, arm64: Add bpf trampoline for arm64")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  arch/arm64/net/bpf_jit_comp.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 7ca8779ae34f..29dc55da2476 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1643,7 +1643,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
>  			    int args_off, int retval_off, int run_ctx_off,
>  			    bool save_ret)
>  {
> -	u32 *branch;
> +	__le32 *branch;
>  	u64 enter_prog;
>  	u64 exit_prog;
>  	struct bpf_prog *p = l->link.prog;
> @@ -1698,7 +1698,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
>  
>  	if (ctx->image) {
>  		int offset = &ctx->image[ctx->idx] - branch;
> -		*branch = A64_CBZ(1, A64_R(0), offset);
> +		*branch = cpu_to_le32(A64_CBZ(1, A64_R(0), offset));
>  	}
>  
>  	/* arg1: prog */
> @@ -1713,7 +1713,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
>  
>  static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
>  			       int args_off, int retval_off, int run_ctx_off,
> -			       u32 **branches)
> +			       __le32 **branches)
>  {
>  	int i;
>  
> @@ -1784,7 +1784,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>  	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>  	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
>  	bool save_ret;
> -	u32 **branches = NULL;
> +	__le32 **branches = NULL;
>  
>  	/* trampoline stack layout:
>  	 *                  [ parent ip         ]
> @@ -1892,7 +1892,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>  				flags & BPF_TRAMP_F_RET_FENTRY_RET);
>  
>  	if (fmod_ret->nr_links) {
> -		branches = kcalloc(fmod_ret->nr_links, sizeof(u32 *),
> +		branches = kcalloc(fmod_ret->nr_links, sizeof(__le32 *),
>  				   GFP_KERNEL);
>  		if (!branches)
>  			return -ENOMEM;
> @@ -1916,7 +1916,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>  	/* update the branches saved in invoke_bpf_mod_ret with cbnz */
>  	for (i = 0; i < fmod_ret->nr_links && ctx->image != NULL; i++) {
>  		int offset = &ctx->image[ctx->idx] - branches[i];
> -		*branches[i] = A64_CBNZ(1, A64_R(10), offset);
> +		*branches[i] = cpu_to_le32(A64_CBNZ(1, A64_R(10), offset));
>  	}
>  
>  	for (i = 0; i < fexit->nr_links; i++)
> -- 
> 2.30.2
> 
