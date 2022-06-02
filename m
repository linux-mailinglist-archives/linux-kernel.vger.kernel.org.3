Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CEB53B2CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 06:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiFBEmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 00:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiFBEmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 00:42:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C10C5C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 21:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hQK/DUQZjTQ7XsvXsvUPNgT7QOvNAYN5rC7mbS0noYY=; b=JWWDpJuxetC2AL4txjIGxjdJTa
        vWfoBwtp3h/OYEIZh9AGayPq9Ng4gOMO7KJ/yI19HYVkD/JnhrsrwQcAWuBPksDZQQszZuASvKyao
        Z+uOFwx8DclfKUo0mqvU+bpR8ApPaxDHr2gu1DdVjaKYsCskpFuiltgZqkA0+UTAlJpE3pi6Vv6Ek
        /1/8sCMeVpnFUO+ZO8qoma3JE2FOf+cCbED8Srk0kq5YtcaaZtMcLEbP0/B2G2pR8mIK7seedFxwL
        3B3WXT9PsIO/SBqXT6d/YDcMYOeBAL9LOeCdnLU6Ae1r6kYza2NnXZhPH60Nt/yJQOa34uarrkkMJ
        TcJq7y3A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwcen-003zne-7A; Thu, 02 Jun 2022 04:42:02 +0000
Message-ID: <0408ae38-235e-ffd1-2743-c37e5c801c28@infradead.org>
Date:   Wed, 1 Jun 2022 21:41:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] average: Clarify the restrictions
Content-Language: en-US
To:     Jui-Tse Huang <juitse.huang@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Bruno Randolf <br1@einfach.org>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
References: <20220602014557.5657-1-juitse.huang@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220602014557.5657-1-juitse.huang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/22 18:45, Jui-Tse Huang wrote:
> There is several restrictions in the EWMA helper macro that the
> developers should take care of, but the comment does not mentioned yet,
> thus, this patch clarify the restrictions.
> 
> Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
> ---
> 
> Notes:
>     v3: fix typo (Randy Dunlap)
>     v2: fix spelling and wording (Bruno Randolf)

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> 
>  include/linux/average.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/average.h b/include/linux/average.h
> index a1a8f09631ce..9c3c8b5b518e 100644
> --- a/include/linux/average.h
> +++ b/include/linux/average.h
> @@ -11,7 +11,10 @@
>   *
>   * This implements a fixed-precision EWMA algorithm, with both the
>   * precision and fall-off coefficient determined at compile-time
> - * and built into the generated helper funtions.
> + * and built into the generated helper functions.
> + *
> + * This implementation supports up to 30 bits of precision, and only
> + * the API for fetching non-fractional part is provided for now.
>   *
>   * The first argument to the macro is the name that will be used
>   * for the struct and helper functions.

-- 
~Randy
