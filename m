Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A448A4D686A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350899AbiCKS1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345752AbiCKS1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:27:41 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEFB139CC5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:26:37 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id w2so2196140oie.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HUwsxCDI5eep5h3+/sZF2aMU4ocqUJVeU3fCG0QnouQ=;
        b=hnlPSzayd7hTXkxJH+IMk63zeSXmrLVDCozNeSxzxQDHb+6rBGSuBHtdKIXQ8fRy9H
         S9ovYFh3VnxK/+we+HtygfTxBh9DhUdCpv6z7tHeQ13HPp65ylLi3fzpSmOOW8wvUeb/
         efcIm3+xWxIqMzkXPCTpw/24XGm921Wl0z30yk97xLQHp0+qis2SnIDAK4RNEKh0zQIQ
         1iLzvANEUdyR7YuMwIqcUDxO7QIbJomUUmyrFNA5tU/dADG+Iqyetb+zlQC4HUBcHy1O
         uokGZk9lsGWB1ULYadXo6ka+72okLmh6m+WN9tGrtEHEnuAk2KOMUOlmbRF+zSKZN4+T
         Kjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HUwsxCDI5eep5h3+/sZF2aMU4ocqUJVeU3fCG0QnouQ=;
        b=rZcCQwkRuTWOCfnEO4HyS3WWdAIdmp6PtMZdnEAJK+apG6IVqtiAZ411qro47peyib
         LfrEpJps45O4+lseaBVVxLfLG9rWdDUrzJXyDkEFIFYvMyBvw9SY/Dku99UL00RxhcUH
         t4HVa/5tEjqa1Lo2EXibcYrfzHz4nuj66wt5oAyW6NZOfMYlIg32f/ya6MIIVCiw07uk
         nov38DF4spYSFH2zJYbT+gi8ZB0QRFMQyE9sFiNo2fMp5WtAiaQ8onJJWsevw4N8V7C2
         ciaX39xUkzUHIh3z/KktZPgrdBMPHbOWSux3GTKs6dUgDGJibAyvzrSQpc9+U9G+ZGWv
         txcw==
X-Gm-Message-State: AOAM530K8V32MRqYhaBT/xK8uQyQHxqhWVdBJd7CrH+NW3u6+WIJ5Nzr
        r13wTKJ8Eqq3GDI4Qo6Hq90c9Q==
X-Google-Smtp-Source: ABdhPJxUTkC1zsRy7tzC+LxUTYngF3zP5MN4dpcPGoIuyB+UFRogcuE2ndA7Gs0fcVGpFc+zplBVUQ==
X-Received: by 2002:aca:42c4:0:b0:2d4:e81d:7740 with SMTP id p187-20020aca42c4000000b002d4e81d7740mr7323326oia.118.1647023196741;
        Fri, 11 Mar 2022 10:26:36 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id z25-20020a056808065900b002d97bda386esm4012548oih.51.2022.03.11.10.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 10:26:36 -0800 (PST)
Date:   Fri, 11 Mar 2022 12:26:34 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     mathieu.poirier@linaro.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
Subject: Re: [PATCH V2 1/2] remoteproc: introduce rproc features
Message-ID: <YiuUWmWvRARTHjOL@builder.lan>
References: <20220308064821.2154-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308064821.2154-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Mar 00:48 CST 2022, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
> 
> remote processor may support:
>  - firmware recovery with help from main processor
>  - self recovery without help from main processor
>  - iommu
>  - etc
> 
> Introduce rproc features could simplify code to avoid adding more bool
> flags and let us optimize current code.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  New
> 
>  include/linux/remoteproc.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h

This is the API that other parts of the kernel use to interact with a
struct rproc, what feature flags do you have a need for other parts of
the kernel to be able to query?

> index 93a1d0050fbc..51edaf80692c 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -417,6 +417,7 @@ struct rproc_ops {
>   *			has attached to it
>   * @RPROC_DETACHED:	device has been booted by another entity and waiting
>   *			for the core to attach to it
> + * @RPROC_CRASHED_ATTACH_RECOVERY: device has crashed and self recovery

This seems to belong in the other patch...

>   * @RPROC_LAST:		just keep this one at the end
>   *
>   * Please note that the values of these states are used as indices
> @@ -489,6 +490,11 @@ struct rproc_dump_segment {
>  	loff_t offset;
>  };
>  
> +enum rproc_features {
> +	RPROC_FEAT_ATTACH_RECOVERY = 0,

No need to specify that this is bit 0, and the enum will do that for you.

> +	RPROC_MAX_FEATURES = 32,

You're using DECLARE_BITMAP() so why 32?

Regards,
Bjorn

> +};
> +
>  /**
>   * struct rproc - represents a physical remote processor device
>   * @node: list node of this rproc object
> @@ -530,6 +536,7 @@ struct rproc_dump_segment {
>   * @elf_machine: firmware ELF machine
>   * @cdev: character device of the rproc
>   * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
> + * @features: indicate remoteproc features
>   */
>  struct rproc {
>  	struct list_head node;
> @@ -570,8 +577,19 @@ struct rproc {
>  	u16 elf_machine;
>  	struct cdev cdev;
>  	bool cdev_put_on_release;
> +	DECLARE_BITMAP(features, RPROC_MAX_FEATURES);
>  };
>  
> +static inline bool rproc_has_feature(struct rproc *rproc, unsigned int feature)
> +{
> +	return test_bit(feature, rproc->features);
> +}
> +
> +static inline void rproc_set_feature(struct rproc *rproc, unsigned int feature)
> +{
> +	set_bit(feature, rproc->features);
> +}
> +
>  /**
>   * struct rproc_subdev - subdevice tied to a remoteproc
>   * @node: list node related to the rproc subdevs list
> -- 
> 2.30.0
> 
