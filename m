Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A964CA9FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241715AbiCBQUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238228AbiCBQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:20:04 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B6A11149
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:19:21 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so1570054wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 08:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BgI8sFrydK5FTn/7e1TRvZf45as613ywq4EmjpiUGno=;
        b=mc1v4qGg4jJ2tODesV1KU6A7Y3OYtWWWQ7Zujh/RUofxBAHg0a7ysBrtKe/wQbgZGv
         fsz4H0B/IUi0AF45fckWnnSJzJozr4Hk0akezyJfX/hKJg7zLInTC4O8bsYeqrMHWARX
         MX76OjU/C6NHHVNPohTLmneuEArql5wki6hyz++VFI0Xq8spr6FvHbsu3Au2QZRjdPC7
         YKsBvI13Sp/pZlR/eumbBsZcCL+IEts7yg7u6ZojoOfnRwvy6XCKW2BnqMBSGMXffMQB
         GU9wXpS+0eTtIu203cE4VjbYPRtgqwh18YVx/65qcTg/3PkPfLZkeqseNntSDgTSnlLP
         MVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BgI8sFrydK5FTn/7e1TRvZf45as613ywq4EmjpiUGno=;
        b=lW24+FKQsK9TwHmrUL55+hBOfPM2Iu5QANc+F0TQUNWwZz1FH46NzH+txRDPEZBtIE
         mnH4wjARoJ4dt5BNxA94AiW8ICCAwUMzRMOX8Ur9Pw7aFrpN+qw15FOSxaxanOLA/UAf
         eunjz4597DLMcEqSfRfLUs/nTLXgcUqX/+dgyjCsRhKYcnj/DQC6/Lk0FFNY9su3XqDx
         Za9gIpGIfNc72qA0E0IkXgy4ptMOd1EjHhJL+jzDbNesANxQFKYbG8yhLnQZ7Xz2jbUk
         SyygerM0GvZJzhvXFxWRK8O70tCPMpuXZy7okcruQ9KrpcLcXt0oiRu4aoOg1wtnD7yk
         JgXA==
X-Gm-Message-State: AOAM530Lep49qXY2Hd7vMg3zUskuXwxM4qpb+Q9WaHouRlzHW7K8tSll
        PXJ4kSHojzt8OlDux3M7vh93cQ==
X-Google-Smtp-Source: ABdhPJyYA7ctJCwfna7Guslsg1HHzVclL/ntG/Oe7hbbAwqSsQv1yNoVySgOeeCulhYwPrFwYePfjA==
X-Received: by 2002:a7b:cc0d:0:b0:381:220e:a3a0 with SMTP id f13-20020a7bcc0d000000b00381220ea3a0mr435984wmh.59.1646237959729;
        Wed, 02 Mar 2022 08:19:19 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm5999091wmc.47.2022.03.02.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 08:19:19 -0800 (PST)
Date:   Wed, 2 Mar 2022 16:19:17 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220302161917.gx5icfszakoye4uh@maple.lan>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228234322.2073104-14-atomlin@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 11:43:21PM +0000, Aaron Tomlin wrote:
> No functional change.
> 
> This patch migrates kdb_modules list to core kdb code
> since the list of added/or loaded modules is no longer
> private.
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  kernel/debug/kdb/kdb_main.c    | 5 +++++
>  kernel/debug/kdb/kdb_private.h | 4 ----
>  kernel/module/main.c           | 4 ----
>  3 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 0852a537dad4..5369bf45c5d4 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -59,6 +59,11 @@ EXPORT_SYMBOL(kdb_grepping_flag);
>  int kdb_grep_leading;
>  int kdb_grep_trailing;
>  
> +#ifdef CONFIG_MODULES
> +extern struct list_head modules;
> +static struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */

If modules is no longer static then why do we kdb_modules at all?
kdb_modules is used exactly once and it can now simply be replaced
with &modules.


Daniel.
