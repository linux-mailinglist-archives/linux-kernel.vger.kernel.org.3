Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F02E590DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbiHLIqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiHLIqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:46:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F02985BD
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11CAB6119D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542A9C433D6;
        Fri, 12 Aug 2022 08:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660293979;
        bh=MagKmuuq+7peZgngSsZBaAoznV16sMBw8KhDbFrAO3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZlFvzAP4520xYW8BVt/yUa2S9ZDOpp3QphX1XbHWo1Wnm2cetctAtxKl1Xahkh6Ge
         RqSrZcZPbGn0NRHno/JnowFf9YN06tT+Tgkm0ecHA9g95PHup3hdPkpJM1eLYaxAbh
         hPlDWAKdLbdbrQQ0nZh3hxL/wC7UOB6ixQjQloUS6enK9TL+i1n/ZprQGwozXmpmeQ
         ZYgwN/iwWdTYEA7h4/lUAT1lgZWkeAJFL54Ej0Y2vfqVgXDoCIvd28Bu3bGLGhhA9C
         MeQA5ibv+Ez9mruT6LjQrNjfCwyICjeeGQFEsO9UShsL+jkxZ+ltSVqcjnAsCWPddC
         Bd96/WX10QPSw==
Date:   Fri, 12 Aug 2022 09:46:14 +0100
From:   Will Deacon <will@kernel.org>
To:     "George G. Davis" <george_davis@mentor.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "George G. Davis" <davis.george@siemens.com>
Subject: Re: [PATCH] arm64: enable kernel command line concatenation
Message-ID: <20220812084613.GA3107@willie-the-truck>
References: <20220811231127.787178-1-george_davis@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811231127.787178-1-george_davis@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 07:11:27PM -0400, George G. Davis wrote:
> From: "George G. Davis" <davis.george@siemens.com>
> 
> Enable CONFIG_CMDLINE to extend the boot loader supplied cmdline. This
> can then be used in config fragments to set command line arguments
> specific to testing of different kernel config options.
> 
> Signed-off-by: George G. Davis <davis.george@siemens.com>
> ---
>  arch/arm64/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 571cc234d0b3..cf4a44cde21b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2140,6 +2140,12 @@ config CMDLINE_FROM_BOOTLOADER
>  	  the boot loader doesn't provide any, the default kernel command
>  	  string provided in CMDLINE will be used.
>  
> +config CMDLINE_EXTEND
> +	bool "Extend bootloader kernel arguments"
> +	help
> +	  The command-line arguments provided by the boot loader will be
> +	  appended to the default kernel command string.
> +

Please see cae118b6acc3 ("arm64: Drop support for CMDLINE_EXTEND") and the
Link tags in there for some background as to why we shouldn't just enable
this option.

Thanks,

Will
