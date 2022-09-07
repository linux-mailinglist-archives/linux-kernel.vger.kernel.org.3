Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE95B0BA6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiIGRmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiIGRmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66F5832D5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7323E619F6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42131C433C1;
        Wed,  7 Sep 2022 17:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662572529;
        bh=Fxy9JuorIOPwm9qgEKC5873CJe+ELikzyA/2KWjOoRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KLYZmnbw38GsCpgRtC0AUxgr7KRmniYbNUydgRsLcmfNsRiphKFn8hAZ8mT2PbrrA
         8VWC1vIRSK6wCCRNWC3HPwHc86aHPdx9DBNO/6timSsWeoSF1yej9TEbfny98qdrfV
         S2kzwmzOZs0QEJ3h6O31mjFrcPT6AmYOHcZ2akxHJgh/77u93gqokWwjMCFUY0rSMv
         ZYSuei1s/ZyRiS7FlcEY0KsOGfRcKZ09vLaRlwyy7C7HcY4YhsuCs3+BagDD4AeuMY
         DlYopfvHqzShTfddz4M7gIjZErHPup3XZfBL7LddKhsswawfA4rQMWfHSFGiLbxuMy
         ip2/VFVrdbNmQ==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon/vaddr: remove unnecessary switch case DAMOS_STAT
Date:   Wed,  7 Sep 2022 17:42:07 +0000
Message-Id: <20220907174207.61191-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1662568262-20925-1-git-send-email-kaixuxia@tencent.com>
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

On Thu, 8 Sep 2022 00:31:02 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The switch case DAMOS_STAT and switch case default have same
> return value in damon_va_apply_scheme(), so we can combine them.

Good point.  I have a comment below, though.

> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  mm/damon/vaddr.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 3c7b9d6dca95..94ae8816a912 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -643,8 +643,6 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  	case DAMOS_NOHUGEPAGE:
>  		madv_action = MADV_NOHUGEPAGE;
>  		break;
> -	case DAMOS_STAT:
> -		return 0;

IMHO, keeping the 'case' makes the code easier to read, as we can find what is
the expected flow for DAMOS_STAT here immediately, instead of asking readers to
find what are the actions that not specified here and therefore fall though to
'default'.

Also, my another intention here is to mark 'DAMOS_STAT' is supported by
'vaddr'.

>  	default:
>  		return 0;

That is, 'default' case here is for DAMOS actions that not supported by
'vaddr'.  So, I'd like to keep the code as is.  Maybe we could add a comment
saying 'default' case is for DAMOS actions that not yet supported by 'vaddr'.

>  	}
> -- 
> 2.27.0


Thanks,
SJ
