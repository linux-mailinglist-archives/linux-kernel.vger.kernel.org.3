Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7E85A25FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343824AbiHZKkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343804AbiHZKkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:40:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F5617E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EA11B82F0E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28929C433C1;
        Fri, 26 Aug 2022 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661510404;
        bh=C7DYmqCDbWy1aG3SBsfI4uLxeQduKslhSNjhDMT5JHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ccYkJ1jjnjCPB3IOT9oaJXsTdXJJCMpV1gAnPjnb0CzJkNyDawwNgndAPPXrf4le0
         w89eALFDn8JKQlqSTRJmjKDKew292KBAnfZDx+BMQqUvwn8OKf4X9DU5tyFO4Ik8/H
         z8l0CxQW9iJYSvUClPJDs8+1+ffKapPW7LisJ5+j1fOzflWalThphFS9cJQoo9/oWw
         QUQKlGkArpxVy/qHoF9AZg1IHA6q47/ox+TpxoG5XBwenCRgrOjMhEgQtEtu4mIwox
         X9VAI+6J43fKoLUjDrkwvt4wSgWAAeWFVmZXqcPWxhPtz2cNOL5VqpiHRzlJQinq1N
         Y3hJOO7wrGvVQ==
Date:   Fri, 26 Aug 2022 11:39:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: spectre: increase parameters that can be used to
 turn off bhb mitigation individually
Message-ID: <20220826103958.GB19505@willie-the-truck>
References: <1659691274-48554-1-git-send-email-liusong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659691274-48554-1-git-send-email-liusong@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:21:14PM +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> In our environment, it was found that the mitigation BHB has a great
> impact on the benchmark performance. For example, in the lmbench test,
> the "process fork && exit" test performance drops by 20%.
> So it is necessary to have the ability to turn off the mitigation
> individually through cmdline, thus avoiding having to compile the
> kernel by adjusting the config.
> 
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> ---
>  arch/arm64/kernel/proton-pack.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
> index 40be3a7..bd16903 100644
> --- a/arch/arm64/kernel/proton-pack.c
> +++ b/arch/arm64/kernel/proton-pack.c
> @@ -988,6 +988,14 @@ static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
>  	isb();
>  }
>  
> +static bool __read_mostly __nospectre_bhb;
> +static int __init parse_spectre_bhb_param(char *str)
> +{
> +	__nospectre_bhb = true;
> +	return 0;
> +}
> +early_param("nospectre_bhb", parse_spectre_bhb_param);
> +
>  void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
>  {
>  	bp_hardening_cb_t cpu_cb;
> @@ -1001,7 +1009,7 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
>  		/* No point mitigating Spectre-BHB alone. */
>  	} else if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY)) {
>  		pr_info_once("spectre-bhb mitigation disabled by compile time option\n");
> -	} else if (cpu_mitigations_off()) {
> +	} else if (cpu_mitigations_off() || __nospectre_bhb) {
>  		pr_info_once("spectre-bhb mitigation disabled by command line option\n");
>  	} else if (supports_ecbhb(SCOPE_LOCAL_CPU)) {
>  		state = SPECTRE_MITIGATED;

It would be good to have an Ack (or a shrug) from somebody @arm.com on this
one.

Other than that, the documentation needs updating for the new option.

Will
