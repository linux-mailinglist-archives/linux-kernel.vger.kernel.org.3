Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F057CC1F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiGUNlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGUNlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:41:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9E86E2EE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:41:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso845198wmm.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ZOd/Gq++6P9/egrjfq0hLbqfmWCQrpYvj+T6OMIRcA=;
        b=XePPEM4RRwanEDLwjDstnSZCVj1tto3cW5NKsAzKSn1mccMSMC/Kuk1+bODT32j6ro
         lU0EQLFZO/jmM0fADBWn/HBeLcOHrmKOpxS51Bdj+Mo9u2PfEGdD05msKOxw09yc5/fJ
         +14EaD9uzzG2/OGgSkWSBGhgbSbIy3sa2pBORDupvOHcLrvzjHFwEGPSAqL/WLkoBBkB
         3cEIGnGKxCX/iNlsspBW+UJmxQidu1C2WcAw4k8jSaqnV2D32xwSXeGcZH8BPxiVdaOA
         kiZZQ7alXk5g7dtU0VcGXBk/z9MwXQry8wno1WiMdGaz5+9rOmgAj8QJuwc0X3Wu7t/X
         7OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ZOd/Gq++6P9/egrjfq0hLbqfmWCQrpYvj+T6OMIRcA=;
        b=t/ifN1TLnIINxAP+T55+bzCzOlIJsQVfD/FeYUAvLQdzwTflYRis5v5zhz014pwv0/
         h2gDPytQdzUUWos0jCINZBhaN1G7bIsTsKgm90rG1c5Xqg1JEIfQmYO4CgX3m8vDYaBG
         3RR2E1lrDgDLTF3FrvIS5acu2KjjJBdmLBIib9VvjrL7jyjH6akHuuWS6B7N9ju9oZ+L
         5cH+m5pFjb8RlV+JizXStcF5gQmOPKpykiQlMDV4Z0LnWGMLEiJlq+ezyRm07x1VcET9
         8F32i6Z5vlfsVRhjUGIFJTEll/W23DWQizupTnbHJSheMmyV0wxlSYUEr3GWWJ7i+iYz
         RFXw==
X-Gm-Message-State: AJIora9godpf15f2PjNluyT3Cd78D7OrgUzjLgFuIyQu9BLhseGBXiVQ
        g9VFABeVWMhmekuBmlydqlQXZA==
X-Google-Smtp-Source: AGRyM1tyiSs+bsKfSaH2hJxxA8JS1C7ucliDlZGzwNOh7X+0SsXr+sRq5xXvqIfCkBSEEyZx4FYHqg==
X-Received: by 2002:a05:600c:35d5:b0:3a3:2490:c984 with SMTP id r21-20020a05600c35d500b003a32490c984mr8823738wmq.162.1658410901611;
        Thu, 21 Jul 2022 06:41:41 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id i13-20020adff30d000000b0021e4982270asm2078759wro.13.2022.07.21.06.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 06:41:41 -0700 (PDT)
Date:   Thu, 21 Jul 2022 14:41:15 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Will Deacon <will@kernel.org>, Yonghong Song <yhs@fb.com>,
        Zi Shen Lim <zlim.lnx@gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Fix compile error in dummy_tramp()
Message-ID: <YtlXe3OKS9u+3jFx@myrica>
References: <20220721121319.2999259-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721121319.2999259-1-xukuohai@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 08:13:19AM -0400, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> dummy_tramp() uses "lr" to refer to the x30 register, but some assembler
> does not recognize "lr" and reports a build failure:
> 
> /tmp/cc52xO0c.s: Assembler messages:
> /tmp/cc52xO0c.s:8: Error: operand 1 should be an integer register -- `mov lr,x9'
> /tmp/cc52xO0c.s:7: Error: undefined symbol lr used as an immediate value
> make[2]: *** [scripts/Makefile.build:250: arch/arm64/net/bpf_jit_comp.o] Error 1
> make[1]: *** [scripts/Makefile.build:525: arch/arm64/net] Error 2
> 
> So replace "lr" with "x30" to fix it.
> 
> Fixes: b2ad54e1533e ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Right, it looks like the lr alias was only added to binutils 2.30, and
Linux supports 2.23+

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  arch/arm64/net/bpf_jit_comp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index dcc572b7d4da..7ca8779ae34f 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -610,8 +610,8 @@ asm (
>  #if IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)
>  "	bti j\n" /* dummy_tramp is called via "br x10" */
>  #endif
> -"	mov x10, lr\n"
> -"	mov lr, x9\n"
> +"	mov x10, x30\n"
> +"	mov x30, x9\n"
>  "	ret x10\n"
>  "	.size dummy_tramp, .-dummy_tramp\n"
>  "	.popsection\n"
> -- 
> 2.30.2
> 
