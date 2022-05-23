Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688B0530F75
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiEWNQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbiEWNQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:16:07 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E1CC4D;
        Mon, 23 May 2022 06:16:05 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a23so17140534ljd.9;
        Mon, 23 May 2022 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=voRusfwPDgbYnKIneCk1q/QajnrGU+j2sBEypeQsrkA=;
        b=fUENnyKisj3kE8siuU26QfhsE7X00eMlpxvV2zw+ZoJqJjbb/zO4TqYF4LdezwU5Il
         0uFCZXeZx8h8X5Z0DwOdVNPeI/i78OQBsa6u31o3t/kxrRs22COBky/3RGd42l4WftQO
         0ERKwFobDbmmwbrHR3uqDhRKCrNF70koFYQzt+6lMYF7yTAnM/4t3EwBmihU7KwtWah3
         3UCcnftl6x4OcYB2zax/8OFRbvmfcekUXGfvExhXhck5Lzzxa6ucDA05Xp4aOfdap16h
         TrrcLCcA+24Q5Zf4MJDCxzbeqL3nUW2p28q2oCA3Wg1JbwFKhiJSbO7Sxdei567nT97R
         Gz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=voRusfwPDgbYnKIneCk1q/QajnrGU+j2sBEypeQsrkA=;
        b=AvfBiqQBjqJkLRHUucauIpMJkiTQT9LK1Og4QaPn1zTx1ijUllDqibF2GkUoad0pcP
         j6++EyCLYMcdTeTmpsUT2e+is6UCqyLC0sHUgtmR81uxqACBjpg9fV9JV/i7ugA86xST
         JL34NnktFRg9Su1OCj8EtIGpnx/FuABds2udnmS+FWRn0NSvXiEjMmnIOPmrLB/2RMX2
         8rLfr/Gf3cOvdIGUU2lkmP/fRJaMrHN3pk8PD9kddE2lfZhdZFEuOAMXkZ8ikmYFNzBx
         uktvzuTBHP+8XiRjo1Lef9SLQchD+42UxSPDNA0t70ogIpXWAmX9g30+sEGKVhNqw257
         wTFw==
X-Gm-Message-State: AOAM53291CREyXp3vhqGKi84zw4otthaGgq5942QppX42RBEbnUJjAxr
        Tr3QFTyjCS1D3DRiIV/1nVCo+MNM/zfc9g==
X-Google-Smtp-Source: ABdhPJwHl86D+ixChN9+31DiSrptpRtmXKthZbV39mpCRjUEqeQ6+rqRlURlMKxJnr1h1rK2UNhHsQ==
X-Received: by 2002:a05:651c:1a14:b0:253:ed7b:c22 with SMTP id by20-20020a05651c1a1400b00253ed7b0c22mr2301520ljb.84.1653311764187;
        Mon, 23 May 2022 06:16:04 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id j14-20020ac2454e000000b00477cab3374asm1867345lfm.303.2022.05.23.06.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:16:03 -0700 (PDT)
Date:   Mon, 23 May 2022 16:16:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: CPC: Fix refcount leak in
 mips_cpc_default_phys_base
Message-ID: <20220523131601.uo2ts4vjj6qvibxy@mobilestation>
References: <20220516043353.8147-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516043353.8147-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, May 16, 2022 at 08:33:50AM +0400, Miaoqian Lin wrote:
> of_find_compatible_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 791412dafbbf ("MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Right. It's similar to the CDMM fix:
commit 4528668ca331 ("mips: cdmm: Fix refcount leak in mips_cdmm_phys_base")

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
>  arch/mips/kernel/mips-cpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
> index 17aff13cd7ce..3e386f7e1545 100644
> --- a/arch/mips/kernel/mips-cpc.c
> +++ b/arch/mips/kernel/mips-cpc.c
> @@ -28,6 +28,7 @@ phys_addr_t __weak mips_cpc_default_phys_base(void)
>  	cpc_node = of_find_compatible_node(of_root, NULL, "mti,mips-cpc");
>  	if (cpc_node) {
>  		err = of_address_to_resource(cpc_node, 0, &res);
> +		of_node_put(cpc_node);
>  		if (!err)
>  			return res.start;
>  	}
> -- 
> 2.25.1
> 
