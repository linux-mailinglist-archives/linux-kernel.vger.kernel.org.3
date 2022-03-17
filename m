Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5184DC041
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiCQHiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiCQHiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:38:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77768EE4DE;
        Thu, 17 Mar 2022 00:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24B77B81DBB;
        Thu, 17 Mar 2022 07:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EE9C340EE;
        Thu, 17 Mar 2022 07:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647502615;
        bh=Lq/j8Muv+YhQPhXUdIbr3sM8xNZ7ybJA7We/n6/A47c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDMQbANAaOAqnU3GhJW4lx8iDyzGXT0FrAVV49RebNIZTkND47CSxvBFhEDFB+ccw
         PCQlNa+IwNgisR6eoDYOAUUT1AGJEDRuh+MU9uhokgF5+dqZkXSvN7zHyF/uji85Gh
         /QOpi+DDDHR3v0YAOGYM3Tm8JmyklxRQ7wqS/EM57C+GzA8JsUADxKbBtWAWjQ7pjT
         Lyzf08H/q+QCh8j89EvKl8RsWEnF+wvOSlHLAcSyIyNUONWZYEOtT2X+g3jj/osrsq
         MDAycSjiJ8sXcdZtLBNm5lRRM68QHMFk7REFVNj4q5K8yaAGOGZRe2bhG+CXJtttGw
         kyqN+a0Uz2Gow==
Date:   Thu, 17 Mar 2022 09:36:06 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] certs: Remove panic() calls from
 system_trusted_keyring_init()
Message-ID: <YjLk5p1ej3JwFdaJ@iki.fi>
References: <20220311174741.250424-1-mic@digikod.net>
 <20220311174741.250424-3-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220311174741.250424-3-mic@digikod.net>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 06:47:41PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Replace panic() calls from device_initcall(system_trusted_keyring_init)
> with proper error handling using -ENODEV.
> 
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org> [1]
> Link: https://lore.kernel.org/r/Yik0C2t7G272YZ73@iki.fi [1]
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220311174741.250424-3-mic@digikod.net
> ---
>  certs/system_keyring.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 05b66ce9d1c9..428046a7aa7f 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -148,8 +148,10 @@ static __init int system_trusted_keyring_init(void)
>  			      KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH),
>  			      KEY_ALLOC_NOT_IN_QUOTA,
>  			      NULL, NULL);
> -	if (IS_ERR(builtin_trusted_keys))
> -		panic("Can't allocate builtin trusted keyring\n");
> +	if (IS_ERR(builtin_trusted_keys)) {
> +		pr_err("Can't allocate builtin trusted keyring\n");
> +		return -ENODEV;
> +	}
>  
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  	secondary_trusted_keys =
> @@ -161,14 +163,26 @@ static __init int system_trusted_keyring_init(void)
>  			      KEY_ALLOC_NOT_IN_QUOTA,
>  			      get_builtin_and_secondary_restriction(),
>  			      NULL);
> -	if (IS_ERR(secondary_trusted_keys))
> -		panic("Can't allocate secondary trusted keyring\n");
> +	if (IS_ERR(secondary_trusted_keys)) {
> +		pr_err("Can't allocate secondary trusted keyring\n");
> +		goto err_secondary;
> +	}
>  
> -	if (key_link(secondary_trusted_keys, builtin_trusted_keys) < 0)
> -		panic("Can't link trusted keyrings\n");
> +	if (key_link(secondary_trusted_keys, builtin_trusted_keys) < 0) {
> +		pr_err("Can't link trusted keyrings\n");
> +		goto err_link;
> +	}
>  #endif
>  
>  	return 0;
> +
> +err_link:
> +	key_put(secondary_trusted_keys);
> +
> +err_secondary:
> +	key_put(builtin_trusted_keys);
> +
> +	return -ENODEV;
>  }
>  
>  /*
> -- 
> 2.35.1
> 

Changes make sense to me but you should implement all this to the original
patch set.

BR, Jarkko
