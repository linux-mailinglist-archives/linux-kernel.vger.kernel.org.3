Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9582357B2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiGTI0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiGTI0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:26:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EA6167FA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:26:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v5so1636302wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7jccUrZM299hCC1xnWZMw1fh8jQct5pN4foSe7t64Vg=;
        b=V0pUHWqXlIT/C3pRkMKh87YcEqXAFmsDU+1EJSljEYE0cUx11qU671Aqr+ptMpP6VQ
         zKgX2TcgGMbClqCPMY15Zh2XFCBL5GIHXUUcD1ahyV7QlUnSnlPSmtGchwVC78fmpEkt
         Ie6j0zkivb6ymfzZDK5B/6DIpOU4FHlrm81asQQ14X2xRiHLzK5XvSCc844HdeP0/WyV
         oQabpaw/1rM5SI/+V+7JNf3gjWOzHsxoIiq1o+o3+blQvglmaZBUGUqzCN3BAGMwgyuV
         jC3NqRO8qpAu+RLOud+FKGjDJdgL+GjA0dcBUTvzXpmF2Dfok2HupzuKWIUVQEbge3Pm
         Imww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:organization
         :in-reply-to:content-transfer-encoding;
        bh=7jccUrZM299hCC1xnWZMw1fh8jQct5pN4foSe7t64Vg=;
        b=KdgB8o7TF2MnuyjKFvZAfE1gxP3qEZgmzSPoZ28CP2cqNphZLPTR2qxzgbiE+kCX/M
         eIq6fftw9YWv1tL5Pd4sTGImUmJpz3xFlJJ0WGupPBuBS/4FWmOpE29CRE4Kmb+KCFo5
         dNfEG0TcUe0IYzwcZ4rK0HMvvoMr7jFzq1T6NN2p1YlKYwOXgXCD1EuERKUTyYsKPV8O
         1Kcdqth97TFtOhSmWWClaKdsLaB8t+4RX6YuerS4PYrBkoE9rtVlHO6OeW9Vcq2k1ME6
         D6xz6mVQD4am//KoC4AEO9ZiC5CgN9nFkVBfrsI7xjeOiPgJ5Zp+5xlQUpq1KgcrkKb5
         r7VQ==
X-Gm-Message-State: AJIora+eKIpJlhOCG0wYJxR9Il8AMP75xg596zmd3fyoRUy7atxmz1fo
        R/Xke0uZwniVqpRW18biLZWbog==
X-Google-Smtp-Source: AGRyM1utC3apUmp4vpBaAQOO786Z1FegeNRlsYviqlJEBaI222tnk/Lm04rdJzJdpYk/zYnHDkFLqg==
X-Received: by 2002:a05:600c:28c:b0:3a3:2b26:d1cd with SMTP id 12-20020a05600c028c00b003a32b26d1cdmr1037678wmk.0.1658305564354;
        Wed, 20 Jul 2022 01:26:04 -0700 (PDT)
Received: from [172.31.98.152] ([185.13.181.2])
        by smtp.gmail.com with ESMTPSA id i64-20020a1c3b43000000b003a2c67aa6c0sm1952155wma.23.2022.07.20.01.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 01:26:04 -0700 (PDT)
Message-ID: <3feb6514-de2c-4b95-b203-74362b3cc002@6wind.com>
Date:   Wed, 20 Jul 2022 10:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] net: ipv6: avoid accepting values greater than 2
 for accept_untracked_na
Content-Language: en-US
To:     Jaehee Park <jhpark1013@gmail.com>, netdev@vger.kernel.org
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        dsahern@gmail.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        aajith@arista.com, roopa@nvidia.com, roopa.prabhu@gmail.com,
        aroulin@nvidia.com, sbrivio@redhat.com
References: <20220720065211.369241-1-jhpark1013@gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20220720065211.369241-1-jhpark1013@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 20/07/2022 à 08:52, Jaehee Park a écrit :
> The accept_untracked_na sysctl changed from a boolean to an integer
> when a new knob '2' was added. This patch provides a safeguard to avoid
> accepting values that are not defined in the sysctl. When setting a
> value greater than 2, the user will get an 'invalid argument' warning.
> 
> Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> Suggested-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Suggested-by: Roopa Prabhu <roopa@nvidia.com>
> ---
>  net/ipv6/addrconf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 6ed807b6c647..d3e77ea24f05 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -7042,9 +7042,9 @@ static const struct ctl_table addrconf_sysctl[] = {
>  		.data		= &ipv6_devconf.accept_untracked_na,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= (void *)SYSCTL_ZERO,
> -		.extra2		= (void *)SYSCTL_ONE,
> +		.extra2		= (void *)SYSCTL_TWO,
Nit: the cast is useless:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/sysctl.h#n40


Regards,
Nicolas
