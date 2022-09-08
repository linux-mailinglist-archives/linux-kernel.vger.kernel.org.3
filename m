Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4455B258B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiIHSWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIHSWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0557F1F1B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:22:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9457A61DB1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 18:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6196CC433D6;
        Thu,  8 Sep 2022 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662661351;
        bh=J68cIAc2CCed2bgOrr17GCBVeMa7VXnHmwblwXxfDmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=upZUijli6CnLSsfh/tvmu5c5UN0c9V0kl6R+tPLmbVjDRZWzGk0MTqpSJG8vlMvT6
         hcF58XysNcHBw1AMSQYc7xlQO1clUagMeoyllpW9JpkdU+bZEnSX7nqexGsEA6wtdb
         3MaBwePsqsChrdmBepFLKDf8C4sNPO2qY8h8gErOd46NEH2nmbyrQjwEUS5tdsnyhX
         kzsyd+C5Qh+G0VPMEz5oLT1Szk6/GyKvQx05vXX8XNtA7P8GZXGwsP+S2Dnvk16NMm
         gMOdY2Y9J6nkl/ieTnw/lQSuL9h/KnC4MPvJdScnEEfD5qUNikW2dgfpHI82803y4s
         SI3DkFcRlFDMA==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH v2] mm/damon/vaddr: add a comment for 'default' case in damon_va_apply_scheme()
Date:   Thu,  8 Sep 2022 18:22:28 +0000
Message-Id: <20220908182228.92058-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1662606797-23534-1-git-send-email-kaixuxia@tencent.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kaixu,

On Thu, 8 Sep 2022 11:13:17 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The switch case 'DAMOS_STAT' and switch case 'default' have same
> return value in damon_va_apply_scheme(), and the 'default' case
> is for DAMOS actions that not supported by 'vaddr'. It might
> make sense to add a comment here.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---

From next time, giving change log from previous versions of the patch here
would be a good practice:
https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format


Thanks,
SJ

>  mm/damon/vaddr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 3c7b9d6dca95..3814200e61e4 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -646,6 +646,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  	case DAMOS_STAT:
>  		return 0;
>  	default:
> +		/*
> +		 * DAMOS actions that not yet supported by 'vaddr'.
> +		 */
>  		return 0;
>  	}
>  
> -- 
> 2.27.0
