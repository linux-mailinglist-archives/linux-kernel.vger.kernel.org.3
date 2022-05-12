Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6B8525340
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356434AbiELRJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356871AbiELRJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:09:30 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540682618C8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:09:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p12so5425845pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AHUI82AL6t0Yfkf0Z6V6/QPVk46THH6YFPcBjf1d2No=;
        b=er5OG0fLdKmH3qjOJPBm0m+LCGS33b43tE/0nTQY2eEUB68cdhEAexBtUg/0pqIPhT
         qND/VOPU2YfuPvlUd94akMeJ6YAff9B1lungPrHkR95oxF0Rt9ZaP+fA/lFnYVbYTfc8
         7Ldw7nCi+Yed0L3LfS4pUP7ll9LtYT92UnA8H8JGD8YTAtkJqQZNqpWlvKatFxFaaFRv
         NVmYsWnuNzy5c6lG6+e+sMNfDRn9CObCo+aSqaRsD9Tha61wO64JDBVQ11/FK74f3jkP
         LNNToYFVOdi0H6fVQclNHhfpiGTE3OWaV7bfkbEcuJf08rQEpaMYEy9cSUgb2ZEGXcXe
         M+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AHUI82AL6t0Yfkf0Z6V6/QPVk46THH6YFPcBjf1d2No=;
        b=j639sLWi69ZQsbq1A5STMcGNOgMxwzQDR/Ot4j/SDwtDtoP0CeQPSe+l6hnVKhdS3a
         RHoa21gCmC8QeUuYbSNOVEu3GEc3gHPBCBq4ERFt9mAwWnuFkUp33LzsFJOX8zgz1mf7
         ZCOGQeAGX8EcmDxLbCU6vd3poCdrmcRaETkmXc56t++k2eezPQQYErnSDN7jOblyUCAR
         Aete2yxhM4biXAikw+Q1VD14GEwmzPWmKX0waW4ai4AMYTMwVIxGXLO9MfO9xiyoImg5
         tLcpcHIkPBxAAoTAyG9c5BxZvfeKI5pqyeTTx3rAOTxZXpm3GuPpmU5Q3V+egxdUB0qC
         6eVA==
X-Gm-Message-State: AOAM5330RcdJeI/D7Onex/XbeClZHMs0B04+0j/5lkEKxS0Ko42FGcQX
        ljFRIjiEV34PqPI8Kraookc=
X-Google-Smtp-Source: ABdhPJy3HC0hloEPNPiVPH2Vy22oHbmvqkQO6WnUQpFIc34SlLYtKUCH1Ron72kBcIxnOraXIZ4bAA==
X-Received: by 2002:a65:6093:0:b0:373:9c75:19ec with SMTP id t19-20020a656093000000b003739c7519ecmr505226pgu.539.1652375368061;
        Thu, 12 May 2022 10:09:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:6c64])
        by smtp.gmail.com with ESMTPSA id m25-20020a62a219000000b0050dc7628140sm99290pff.26.2022.05.12.10.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:09:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 May 2022 07:09:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] kernfs: make ->attr.open RCU protected.
Message-ID: <Yn0/RrgMRie2YPEb@slm.duckdns.org>
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
 <20220428055431.3826852-3-imran.f.khan@oracle.com>
 <YnQtL7+GYHwpo4n2@slm.duckdns.org>
 <f5ff2554-580c-c817-b77f-25e2ef46411f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ff2554-580c-c817-b77f-25e2ef46411f@oracle.com>
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

On Fri, May 06, 2022 at 09:12:23AM +1000, Imran Khan wrote:
> On 6/5/22 6:01 am, Tejun Heo wrote:
> > On Thu, Apr 28, 2022 at 03:54:28PM +1000, Imran Khan wrote:
> >> +static struct kernfs_open_node *kernfs_deref_on_raw(struct kernfs_node *kn)
> >> +{
> >> +	return rcu_dereference_raw(kn->attr.open);
> >> +}
> > 
> > Wrapping the above probably isn't helping anything.
> > 
> 
> This change is using raw deref at a few places, so I thought of putting
> raw deref under a wrapper and explain in the wrapper function comment
> under what conditions raw dereferencing was safe.

I don't think they need raw deref in the first place and if you *really*
need raw deref, the wrapper explaining why they're needed and how they're
safe is the whole point of it and I don't think the wrapper achieves that.

> >> +/*
> >> + * Check ->attr.open corresponding to @kn while holding kernfs_open_file_mutex.
> >> + * ->attr.open is modified under kernfs_open_file_mutex. So it can be safely
> >> + * accessed outside RCU read-side critical section, while holding the mutex.
> >> + */
> >> +static struct kernfs_open_node *kernfs_check_on_protected(struct kernfs_node *kn)
> >> +{
> >> +	return rcu_dereference_check(kn->attr.open,
> >> +				      lockdep_is_held(&kernfs_open_file_mutex));
> >> +}
> > 
> > Maybe name this just kernfs_deref_on()?
> > 
> 
> Sure. I can mention in the function comment that this should be used
> only under kernfs_open_file_mutex.

and in the check condition, add the conditions that you need to make this
not trigger warning when used in all the places that you wanna use it.

> +static struct kernfs_open_node *kernfs_deref_on_raw(struct
> kernfs_open_file *of, struct kernfs_node *kn)
>  {
> -       return rcu_dereference_raw(kn->attr.open);
> +       struct kernfs_open_node *on;
> +
> +       if (list_empty(&of->list))
> +               return NULL;
> +
> +       on = rcu_dereference_raw(kn->attr.open);
> +
> +       if (list_empty(&on->files))
> +               return NULL;
> +       else
> +               return on;

Put the above conditions in the rcu_dereference_check(). That's what it is
for - describing the additional conditions that make the dereference safe.

Thanks.

-- 
tejun
