Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2F35A3327
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 02:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiH0Ad6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 20:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiH0Ady (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:33:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B830E1168
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:33:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v23so2914700plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=14KpB5p7sZ3dVxtoeGHlHAy+LcMprsDaESSmFVj0Geo=;
        b=J65P8wFFHZx2QuvqZamtjeDO5Snhz0qIBKV4vBTBh8708yABn+LsVsoPenJ2C6r6H7
         PYVcV7ugxrFDsaRxIpOKcN7IiHZrYo0ruO4DaLRyVQNUtUvVYAru7DeNFs9v6+h1T9WE
         e/EWJIFPdM7Yc8/I3DfCoSNPZ8uQEvIvGTM1zd1A4dH6H//m3Q6A52/C3FUxKKA+YxyE
         5+sjtMOa40Fq8s61n8LuEkCSGgJWdowMdFZ8r5j2pNfi3dv86Mq5g6DDlA5iUvSNOZdC
         pusx0VCZOuBJX+XpyYKAwimqU96xZySW+CscIq43CN1+6wwx3MR3UuxU5JQPGhImNuB3
         6tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=14KpB5p7sZ3dVxtoeGHlHAy+LcMprsDaESSmFVj0Geo=;
        b=ZfaDFsHB0f+mIg7vTryQ4OGJxfS9wpyz32Au8ufKo4ZPgUUaV7mJtJfeuaXgSiILG1
         8Ami/SsaW+vGathkk15ngtoI319I45d1jM7y020owtPKXflY5FBQ6Aidjgy9ccjqZrME
         SVgeEuq1dCkZWUGcV5zyugQNoAVmUhz4Ejv9wdo37AttZRbYyI/VmNHUysuPZQS/dr2p
         634A4nICMDQJnK9ioPd3uy5ciI4+PXCT9rOwLy8yG7v2IsVsztgiVhFYb4b+4RmtwKxR
         dLzzlbL2bZDaaXw0kJIzcoGDsCLAxAo4JkzqNrWfxL9p2ksPPVKhXS+JAe52KYwhlvm/
         81tQ==
X-Gm-Message-State: ACgBeo07LmABFcgFIk47sxKhrKq+00GOW6Jg5aCz6EKGIUNZiiCBYvjg
        ecW8YulqYg2rR/WLbLc/ATg=
X-Google-Smtp-Source: AA6agR5eU8jL6jmmJU+d6DDd9Egp4yW2wMcQn/B1CKBK8pRJMrxuvv9azaY3iDXqyeJJ0KQdm7vdQg==
X-Received: by 2002:a17:902:d505:b0:173:cf6:f819 with SMTP id b5-20020a170902d50500b001730cf6f819mr6074130plg.117.1661560433534;
        Fri, 26 Aug 2022 17:33:53 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709027e0e00b0016befc83c6bsm2215522plm.165.2022.08.26.17.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 17:33:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 26 Aug 2022 14:33:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Zqiang <qiang1.zhang@intel.com>
Subject: Re: [PATCH] workqueue: Protects wq_unbound_cpumask with
 wq_pool_attach_mutex
Message-ID: <Ywlmb1ADhHnfFUI8@slm.duckdns.org>
References: <Yvrb3hfZuUzSpX5e@slm.duckdns.org>
 <20220818143348.1134136-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818143348.1134136-1-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 18, 2022 at 10:33:48PM +0800, Lai Jiangshan wrote:
> @@ -5342,6 +5344,11 @@ static int workqueue_apply_unbound_cpumask(void)
>  		apply_wqattrs_cleanup(ctx);
>  	}
>  
> +	if (!ret) {
> +		mutex_lock(&wq_pool_attach_mutex);
> +		cpumask_copy(wq_unbound_cpumask, unbound_cpumask);
> +		mutex_unlock(&wq_pool_attach_mutex);

Is this enough? Shouldn't the lock be protecting a wider scope? If there's
someone reading the flag with just pool_attach_mutex, what prevents them
reading it right before the new value is committed and keeps using the stale
value?

Thanks.

-- 
tejun
