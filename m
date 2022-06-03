Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A77053CBEC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245298AbiFCPB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245300AbiFCPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:01:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7A110A8;
        Fri,  3 Jun 2022 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OHLzFhY1sgaXVkq2dkqUz+DXjlRYN/dI4bdYgt7Hz8c=; b=w2gkfziMSPSIJ07SVWnZmYlHmy
        T1gBfH2AfJiFIxiGLpAYpvUBuoiUqkzW5WRorzZuXomV0iIdMIBIVsjYDUZGbwtszPYYWkx4jDct4
        OIPYedfHpR/H5MFTA5A/M5QLQbPM20ChIWbUYx/uFD67CNhzLETygIjDkQIm7AWJao8TVOeY1+i76
        bHOEkeyGf1D1wUpNLmWMQe+oD0R5hDf4GmPvClqF52qy1CxKupNmgmgz/1EtBPlTS4lsIIG+fjMtI
        CSfsydhyflNa/c6N6Tz7kSunvmBXGO6T5NVL1GayEgIqTAKh6v8y23N+9BYqTmhUgwXJUJVR3Ci6m
        WTJsAs0Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx8o6-007vN1-US; Fri, 03 Jun 2022 15:01:46 +0000
Date:   Fri, 3 Jun 2022 08:01:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Saravana Kannan <saravanak@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH v1] module: Add support for default value for module
 async_probe
Message-ID: <YpoiWhMqANChE/ph@bombadil.infradead.org>
References: <20220603055442.521888-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603055442.521888-1-saravanak@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 10:54:41PM -0700, Saravana Kannan wrote:
> Add a module.async_probe kernel command line option that allows enabling
> async probing for all modules. When this command line option is used,
> there might still be some modules for which we want to explicitly force
> synchronous probing, so extend <modulename>.async_probe to take an
> optional bool input so that async probing can be disabled for a specific
> module.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++--
>  kernel/module/main.c                            | 11 ++++++++++-
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 710b52d87bdd..32083056bd25 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1147,8 +1147,12 @@
>  	nopku		[X86] Disable Memory Protection Keys CPU feature found
>  			in some Intel CPUs.
>  
> -	<module>.async_probe [KNL]
> -			Enable asynchronous probe on this module.
> +	<module>.async_probe[=<bool>] [KNL]
> +			If no <bool> value is specified or if the value
> +			specified is not a valid <bool>, enable asynchronous
> +			probe on this module.  Otherwise, enable/disable
> +			asynchronous probe on this module as indicated by the
> +			<bool> value.

The commit log says a bit more. Can you clarify this on the
documentation?

We should strive slowly towards more async probes. This will take
time. To help with further then a Kconfig option which sets this
to a default to true if enabled would be useful so that no kernel
parameter is needed at all to set the default. Then you can
override the default, and blacklist each driver as well.

  Luis
