Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E3D5A1E77
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244246AbiHZCBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiHZCBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE951C8751
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 19:01:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4043861DEE
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67758C433C1;
        Fri, 26 Aug 2022 02:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661479306;
        bh=4G/cK7OUMoRHnhqGTeJLjX2Y5vRMe8slDX1/cmfVkeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V8CpFKKNELxxzF8fIpK3IzIyAi1AsgXz3i924nRm4BCubiECS+CJ8BCRrNEIYPwAI
         lUoL9swrT88hvd1jM5Z6BauMTpd9qAEc5YUSYpj2g3sYh2GY83mGUKYQicNUfKqF78
         zfJTe/fQxANHNN7IgWOLuCM1mqQJXAMkrhNKzvVE=
Date:   Thu, 25 Aug 2022 19:01:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 2/3] mm/zswap: delay the initializaton of zswap
 until the first enablement
Message-Id: <20220825190145.b0fc3267e16705866660f947@linux-foundation.org>
In-Reply-To: <20220825142037.3214152-3-liushixin2@huawei.com>
References: <20220825142037.3214152-1-liushixin2@huawei.com>
        <20220825142037.3214152-3-liushixin2@huawei.com>
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

On Thu, 25 Aug 2022 22:20:36 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> In the initialization of zswap, about 18MB memory will be allocated for
> zswap_pool in my machine. Since not all users use zswap, the memory may be
> wasted. Save the memory for these users by delaying the initialization of
> zswap to first enablement.
> 
> ...
>
> +static int __init init_zswap(void)
> +{
> +	/* skip init if zswap is disabled when system startup */
> +	if (!zswap_enabled)
> +		return 0;
> +	return zswap_setup();
> +}
> +

I can't resist.

--- a/mm/zswap.c~mm-zswap-delay-the-initializaton-of-zswap-until-the-first-enablement-fix
+++ a/mm/zswap.c
@@ -1556,7 +1556,7 @@ cache_fail:
 	return -ENOMEM;
 }
 
-static int __init init_zswap(void)
+static int __init zswap_init(void)
 {
 	/* skip init if zswap is disabled when system startup */
 	if (!zswap_enabled)
@@ -1565,7 +1565,7 @@ static int __init init_zswap(void)
 }
 
 /* must be late so crypto has time to come up */
-late_initcall(init_zswap);
+late_initcall(zswap_init);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Seth Jennings <sjennings@variantweb.net>");

It's the usual way and makes things more consistent.
