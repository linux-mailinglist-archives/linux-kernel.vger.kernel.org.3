Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467DD51C6CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383051AbiEESQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242421AbiEESQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:16:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2527E5C66B;
        Thu,  5 May 2022 11:12:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC78EB82E2B;
        Thu,  5 May 2022 18:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166B9C385A4;
        Thu,  5 May 2022 18:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651774371;
        bh=WCTrfyIGMORRs4jTd94rX0toCSZo6++euRRkU7UoJ1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YeWCFMS6ouaJZXwFCFa913pvJPovGxKh9T3XXsWnAfH9Afh3cqp7rUi38sHHMqXMg
         rVGJWDLlAWo0l+i0TLrAutyM0Yt0T7Z7ATsFf0vSNnydX8mVxlA6vRrx/sKD/EhP0/
         2BRberpL5FYsumRjFD8BHx0PLRQ+4GvHRdZofiP8ISJS3iVtEIN5zyKJEZ1nDNOOTc
         B22izljyLVHgqTXrXeqGajURvvWl+82r18kIBZFyQ8TQAopf5TeChuQ0Gz4/3E5dcd
         sDw4WDNo7uR3YrUXYRGNUK+c8aX6ZQKjINYAv1qZcPtEa9MfK7QVzxZCw/kUQ0VBeS
         SIR26kRfb0AxQ==
Date:   Thu, 5 May 2022 11:12:49 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <YnQToaOno0MZzJ5r@dev-arch.thelio-3990X>
References: <20220505194717.065db7ab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505194717.065db7ab@canb.auug.org.au>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, May 05, 2022 at 07:47:17PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the amdgpu tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 

<snip long error message>

> 
> Caused by commit
> 
>   028c3fb37e70 ("drm/amdgpu/mes11: initiate mes v11 support")
> 
> This build has __BIG_ENDIAN set.
> 
> I have applied the following patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 5 May 2022 19:14:25 +1000
> Subject: [PATCH] mark CONFIG_DRM_AMDGPU as depending on CONFIG_CPU_LITTLE_ENDIAN
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index e88c497fa010..2aaa9ef1168d 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -244,6 +244,7 @@ source "drivers/gpu/drm/radeon/Kconfig"
>  config DRM_AMDGPU
>  	tristate "AMD GPU"
>  	depends on DRM && PCI && MMU
> +	depends on CPU_LITTLE_ENDIAN
>  	select FW_LOADER
>  	select DRM_DISPLAY_DP_HELPER
>  	select DRM_DISPLAY_HDMI_HELPER
> -- 
> 2.35.1

This fixup makes CONFIG_DRM_AMDGPU unselectable on any architecture that
does not have CONFIG_CPU_LITTLE_ENDIAN, such as x86_64. I was rather
surprised when my AMD test system did not reach the login screen and
there were no error messages in dmesg, only to find that
CONFIG_DRM_AMDGPU had disappeared from my build.

If this is not fixed by the time you do next-20220506, would you
consider swapping the logic like so? This should allow all implicitly
little endian architectures to work (at least, I tested it with x86_64),
while preventing errors for CONFIG_CPU_BIG_ENDIAN configurations.

Cheers,
Nathan

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 2aaa9ef1168d..a57843733a96 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -244,7 +244,7 @@ source "drivers/gpu/drm/radeon/Kconfig"
 config DRM_AMDGPU
 	tristate "AMD GPU"
 	depends on DRM && PCI && MMU
-	depends on CPU_LITTLE_ENDIAN
+	depends on !CPU_BIG_ENDIAN
 	select FW_LOADER
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDMI_HELPER
