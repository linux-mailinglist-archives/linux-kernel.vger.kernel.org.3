Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DB04F1203
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353999AbiDDJdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbiDDJdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:33:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBCC21E1F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CEAFB80977
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1292EC2BBE4;
        Mon,  4 Apr 2022 09:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649064669;
        bh=mQugju9fdZKSPsDLJ4dTbDGA9sMELOUz89Yoa0qxZCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLXoxnRWTgvz+3oys66LJgl024/6FpYp2k+fz5WQOT53pqqDXxcAhGTcCyRjJmQ8w
         YTUlKNlLujzwPDWBJd+B9u9pNV3lmCc1XfgCe560gZILjMKQwm4vYeNtaqPGGTYQkp
         8TNm1dRoWaz1GKOej291bssce+JrGPSTEiQftPl47jHlD9LuLL7iK1ycpIHTAi1YhD
         m3uc52nAsSb6B3XSAjHqYYJTGVmeU4OA/rhjgPbLP8v9ik6v9kq5ZoCUGa9n3LLw/a
         a0yqYsoKQUrBK3fWnpwDCVzAC6ZiZo2ZSddJIIFEEjNXnjd/Zki9FOoRP2nLANdvLg
         gwFaz8tjZAXjw==
Date:   Mon, 4 Apr 2022 10:31:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/refcount: Use REFCOUNT_WARN() to simplify code
Message-ID: <20220404093103.GA22875@willie-the-truck>
References: <20220316125114.1177-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316125114.1177-1-thunder.leizhen@huawei.com>
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

On Wed, Mar 16, 2022 at 08:51:14PM +0800, Zhen Lei wrote:
> To avoid the check "new > val" appears twice, and make the style
> consistent with that in refcount_warn_saturate().
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  lib/refcount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/refcount.c b/lib/refcount.c
> index a207a8f22b3ca35..d36aa3fa728f53b 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -84,7 +84,7 @@ bool refcount_dec_not_one(refcount_t *r)
>  
>  		new = val - 1;
>  		if (new > val) {
> -			WARN_ONCE(new > val, "refcount_t: underflow; use-after-free.\n");
> +			REFCOUNT_WARN("underflow; use-after-free");
>  			return true;
>  		}

Acked-by: Will Deacon <will@kernel.org>

Will
