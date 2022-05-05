Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1980F51C9E8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244992AbiEEUJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbiEEUJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:09:34 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B99B3615A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:05:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d22so5382672plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sIjvi2ONOFeBeVuRiGtsd7aQNLczbj8OwDdnK8wAXKw=;
        b=aer0VOWfI6ezatiFZA9hRTPxPjQ0x/qrluledVqkvB5bOCsQoGzYQ3n7KQdAzZhaLe
         juxO6rqI80TIWFlaS22iD1IuIVkvh6MWX3XFN38CjbOZPoUpQsbOwmcb7OKU1TsqwQMu
         VIpptp76tlnlP8Nt1kggAoIOfS3of/aC/M1vFugeMajoGiw1FFSt4tFkKvvyG6+hrrtw
         3/6X6nvHfBKWcMwnIs15SFv62euGepNTjE2J1+TVQoRHFoAB5zMabtkGL6Jh6h97gCcC
         gmjl0LU84CFuM620BagphiELDR0Twy/Bo04EdbYivdLObqlJn6SKyuf0zs8MB90G/j8y
         MdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sIjvi2ONOFeBeVuRiGtsd7aQNLczbj8OwDdnK8wAXKw=;
        b=4YYqWQJdrzHNum0LCGrjyNUrGV/dvqq+/i0U5BbjxBgW05gevJy/t9Ws+0AfFuSEqu
         PsQwTX11tDWZENMn4IDKrw/xxOgVAyidecNOT/6Q/CaVFENQimziOEr/AOR0MMZxEnqP
         eLY6IRvT2SfgPafgxDlzRaQxdYBMzbdMc9/uqhVXY6w1SucE+NYxJpiYuEKKKX9rdjKi
         dQS6D2jpwEJcL0imgFjgOMC/YwsOU7eNPvPPD4P0UBSX24lAkAFBtQH3QMI1JAcEJHxm
         2njmpsDoZAV1is8DmM6GIPeOWjoJQgT4FNNlKbZLLaQi1rio9BpUPKHyQdGN+CDfeHu6
         18XA==
X-Gm-Message-State: AOAM532efQ28DiZlfTxuFGFLN8+r95/rSxypjU2ZyjeCIlnmTUYlqPU/
        6mFqjVuEry0Bogke3T0T1ljpLYoq7rY=
X-Google-Smtp-Source: ABdhPJwl8xLedKURjvC11+HfZk5h0bIB/dsfccejNkSyACDDv19V3hInR/dRk28kR0qmHPzHIkVobA==
X-Received: by 2002:a17:90b:1c88:b0:1b8:a77e:c9cb with SMTP id oo8-20020a17090b1c8800b001b8a77ec9cbmr8048314pjb.205.1651781153629;
        Thu, 05 May 2022 13:05:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:29a5])
        by smtp.gmail.com with ESMTPSA id bh4-20020a170902a98400b0015e8d4eb1c9sm46022plb.19.2022.05.05.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 13:05:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 May 2022 10:05:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] kernfs: Replace global kernfs_open_file_mutex with
 hashed mutexes.
Message-ID: <YnQuH5ijv6bWUKPM@slm.duckdns.org>
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
 <20220428055431.3826852-6-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428055431.3826852-6-imran.f.khan@oracle.com>
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

On Thu, Apr 28, 2022 at 03:54:31PM +1000, Imran Khan wrote:
> +static void __init kernfs_mutex_init(void)
> +{
> +	int count;
> +
> +	for (count = 0; count < NR_KERNFS_LOCKS; count++)
> +		mutex_init(&kernfs_locks->open_file_mutex[count]);
> +}

Does this need to be a separate function?

> +static void __init kernfs_lock_init(void)
> +{
> +	kernfs_locks = kmalloc(sizeof(struct kernfs_global_locks), GFP_KERNEL);
> +	WARN_ON(!kernfs_locks);
> +
> +	kernfs_mutex_init();
> +}
> +
>  void __init kernfs_init(void)
>  {
>  	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",

Other than that minor nitpick,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
