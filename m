Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9DF5242F7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbiELDCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243403AbiELDCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:02:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2272E666B1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Q2yMx5x7K3+9k25ap2IGUEoyLrH07N7kDSErTWFX/a4=; b=q4feL1AMsF7OPJPBzZJXrWa5ua
        NChwvuckN+i51dPr4Kra+u6e9DmxRRu7ulwy0Owc7JIjLSQJTGtjirbVIXLQdL1BiTiQkenbLamik
        2C85uaGPm0zG9FXC7+mx48DvrSENAtJThctDIv5SwJp16cdPZpoD0n34EBKRNrXqGObcUw4Zka04z
        9xz0vlrvzB6DOUCrYhoPLyDbjuV4I+HRwmjpVjkBqnE05CCgYGhprG0eUAb8hXayiybMisRO6cWj3
        T+7VnSeIoargCVdpV4Q2z0tuw1ZieYMbS2wDaS3BNr10LcXoZoYdwlK8VunACbehon5Ua3tpkMuIu
        bBq5RWGQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noz5y-00DN97-4O; Thu, 12 May 2022 03:02:30 +0000
Message-ID: <6a1a59cb-7184-5cad-e69c-fd3aa46c19f5@infradead.org>
Date:   Wed, 11 May 2022 20:02:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] scripts:force conversion argument type
Content-Language: en-US
To:     Dong Chuanjian <chuanjian@nfschina.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220512023853.GA4018@localhost.localdomain>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220512023853.GA4018@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/22 19:38, Dong Chuanjian wrote:
> scripts:force conversion argument type
> 
> Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>
> ---
>  scripts/kallsyms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 8caabddf817c..544ab1e1b5ca 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -498,7 +498,7 @@ static void write_src(void)
>  
>  	output_label("kallsyms_token_index");
>  	for (i = 0; i < 256; i++)
> -		printf("\t.short\t%d\n", best_idx[i]);
> +		printf("\t.short\t%d\n", (int)best_idx[i]);

Or (better) you could use %u instead of %d to print the unsigned int value.

>  	printf("\n");
>  }
>  

-- 
~Randy
