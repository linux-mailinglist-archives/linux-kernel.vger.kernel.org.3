Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E2F54617F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344693AbiFJJQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347667AbiFJJPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:15:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BEC1CF935
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:15:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 928F461D54
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB82C3411C;
        Fri, 10 Jun 2022 09:15:08 +0000 (UTC)
Date:   Fri, 10 Jun 2022 10:15:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alejandro Tafalla <atafalla@dnyon.com>
Cc:     Will Deacon <will@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Fix typo in Enum element regex
Message-ID: <YqMLmMJ7v48me/5H@arm.com>
References: <20220609204220.12112-1-atafalla@dnyon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609204220.12112-1-atafalla@dnyon.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 10:42:18PM +0200, Alejandro Tafalla wrote:
> In the awk script, there was a typo with the comparison operator when
> checking if the matched pattern is inside an Enum block.
> This prevented the generation of the whole sysreg-defs.h header.
> 
> Fixes: 66847e0618d7 ("arm64: Add sysreg header generation scripting")
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> ---
>  arch/arm64/tools/gen-sysreg.awk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/tools/gen-sysreg.awk b/arch/arm64/tools/gen-sysreg.awk
> index 89bfb74e28de..5c55509eb43f 100755
> --- a/arch/arm64/tools/gen-sysreg.awk
> +++ b/arch/arm64/tools/gen-sysreg.awk
> @@ -253,7 +253,7 @@ END {
>  	next
>  }
>  
> -/0b[01]+/ && block = "Enum" {
> +/0b[01]+/ && block == "Enum" {

This makes sense but I'm surprised that we haven't noticed it until now
(maybe some awk versions treat it as a relational operator).

-- 
Catalin
