Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5944CCB6B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 02:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiCDBql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 20:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiCDBqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:46:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D1070CDA;
        Thu,  3 Mar 2022 17:45:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D09BCB826EA;
        Fri,  4 Mar 2022 01:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5EEC004E1;
        Fri,  4 Mar 2022 01:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646358351;
        bh=0aPOpaQ2BPQ0jRueWi+QUNcFY1xrd96ui2PZawQzDXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PaM2OBojj30OBaAOBgfA7eyGSq0Fee0QhbijRiGxS3VpiLTyB8BGMkGACtw83x9S3
         GoYuQZqYWhG+5LWcRrcWdFZ1z6P6ASBFgbDDUrwyRdRfQfDw3SRCmVlKllsKTLGR9C
         HHeWUPxJiJV/jZV4gX3ywHErFvLXPc814GJpt5WI=
Date:   Thu, 3 Mar 2022 17:45:50 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        kernel test robot <lkp@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] lib/Kconfig.debug: add ARCH dependency for
 FUNCTION_ALIGN option
Message-Id: <20220303174550.4baa4d6d228320f09807c987@linux-foundation.org>
In-Reply-To: <20220303082048.16558-1-feng.tang@intel.com>
References: <20220303082048.16558-1-feng.tang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Mar 2022 16:20:48 +0800 Feng Tang <feng.tang@intel.com> wrote:

> 0Day robots reported there is compiling issue for 'csky' ARCH
> when CONFIG_DEBUG_FORCE_DATA_SECTION_ALIGNED is enabled [1]:
> 
> ...
>
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -401,8 +401,8 @@ config SECTION_MISMATCH_WARN_ONLY
>  	  If unsure, say Y.
>  
>  config DEBUG_FORCE_FUNCTION_ALIGN_64B
> -	bool "Force all function address 64B aligned" if EXPERT
> -	depends on PPC || ARM || X86

I cannot find a kernel which contains the above line?

> +	bool "Force all function address 64B aligned"
> +	depends on EXPERT && (X86_64 || ARM64 || PPC32 || PPC64 || ARC)
>  	help
>  	  There are cases that a commit from one domain changes the function
>  	  address alignment of other domains, and cause magic performance

