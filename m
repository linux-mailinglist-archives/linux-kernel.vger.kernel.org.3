Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1A4BB9BD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiBRM7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:59:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiBRM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:59:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEB6DE2F5;
        Fri, 18 Feb 2022 04:59:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05B3EB8261A;
        Fri, 18 Feb 2022 12:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14CDC340E9;
        Fri, 18 Feb 2022 12:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645189138;
        bh=jPGzG7uRElyCvzBuI1vVzDz2ITCvtuBTtR2EITAfhaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWaVqk8Vs0nzGiNjcgSI37+76hDIHGdtO7JsBaGQAN1KhZqG1QiZQtpjINHDHNW6x
         wo3/Pan1v71YFwMBANQGGewmyF/FQawhamtjN9B8pRWlOBehb43ZhxIH0yegbaV9Dr
         Bc2azqdLq12Hs7XtaNAd/TwPgmMy+m3GWn8DBJqh7hbMZYvxb7T9KPJGLz+NDeYJcY
         jJzUUU8wLKPVlTOT7CnsiySsa9lhvfMrtMaRAIHNeG76UB4QWSw6bgbriU4adDKSly
         AhUUZeGp9QWifMBCHEpALh/yegvrx3nFzlrkMVUKJi0PoPIJarLozZZ4lL1Ph0axBA
         maIFo+r2/L0Gg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 180E0400FE; Fri, 18 Feb 2022 09:58:57 -0300 (-03)
Date:   Fri, 18 Feb 2022 09:58:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     cgel.zte@gmail.com
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com,
        atrajeev@linux.vnet.ibm.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, deng.changcheng@zte.com.cn,
        german.gomez@arm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] perf tools: Replace zero-length array with
 flexible-array member
Message-ID: <Yg+YEfv5vvT3RIxy@kernel.org>
References: <20220218031352.1906077-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218031352.1906077-1-deng.changcheng@zte.com.cn>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 18, 2022 at 03:13:52AM +0000, cgel.zte@gmail.com escreveu:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use "flexible array members" for these cases. The older
> style of one-element or zero-length arrays should no longer be used.
> Reference:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

You can't do that as this will break the build as explained in that
patch e-mail thread.

Adrian provided an alternative patch that I have to process.

Thanks for the patch anyway,

- Arnaldo

> ---
>  tools/perf/util/event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index cdd72e05fd28..320cbcd5b902 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -308,7 +308,7 @@ struct perf_synth_intel_evt {
>  		};
>  		u32	cfe;
>  	};
> -	struct perf_synth_intel_evd evd[0];
> +	struct perf_synth_intel_evd evd[];
>  };
>  
>  struct perf_synth_intel_iflag_chg {
> -- 
> 2.25.1

-- 

- Arnaldo
