Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BC3547B5E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiFLR7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 13:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiFLR6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 13:58:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D878F23BDD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 10:58:39 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i64so3895280pfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2CuKDAd5D7ltUDRzrtuGQVG2dY4NPIfLA70u/008IWU=;
        b=nR1rlPwaPGypMK6wprtWkOAYocGEjkja9qJB94a/PilVKxe8haF/8y8X/dUYP7TpDp
         KdtKzLKnuk4w0u+0A2ShLE18pz9PkyIuEvd0Q+TBPqs453JWvLaXjWFryt5pq8FW+AXW
         9ljCWuD3JEa3vK/9IRTgR7tI8IJ6f5gW40YyrX4NKh9rTlH0cCflqMr8haJzPVH9xADz
         ozIzIShuH+y07RS19uhQUt5ZacuWLUC0PtEF1uftuPmiI90ZzTZSKyhOpCULcre1KqLX
         4kp6fErTI9YI1xR+aGoB8uMIBeoOY8LY3C2i94QrMItzzq7iZsDnZnKTpArGmqXrlI3J
         dowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2CuKDAd5D7ltUDRzrtuGQVG2dY4NPIfLA70u/008IWU=;
        b=wz2PYM/DVxQi5J0YwJ4MKGJq/O+13NOlyHACnMwV4zTE4H+qdv3SrIaQEWjYZrko1z
         osCfPKg5ExxeOCVC2J8wGmbdc8cf/iFV01IxIMm+w0cdiTLC1dapWcT4z1wPfifSiLZR
         weUy5EOLHPEi5VyWENcd/68nOIMVq9rQacpF3FYAavxZ3hNro99NO2QaAEvwuZ5kN1lv
         xofmCoBW3q4xtTk2PwWmNGA5oPfx9N1/aTREpSfyNrM2JcruBU26v2HEhLNJbv8FY1a+
         QLVFRdZdMqYmwXMMWr3MCrIitUCYs5TRdaajhmS+JSF8Vcvik1lRRROFc76clzq9WtFe
         UDXw==
X-Gm-Message-State: AOAM530MqnrQeGl20MM2DJpZK1Cs5lQGQEDc1ObAc3B4oD8c6ZnJbcn+
        7Jq9G+hMscNbgeshjo9y+94=
X-Google-Smtp-Source: ABdhPJxMj0G4FKen9f6dYnI9kNyhwJGFIynoZ3wjU8scrH90yWneAuE1LpUacH9pHQQPqxtvOj2WoQ==
X-Received: by 2002:aa7:990e:0:b0:51f:2b9f:6402 with SMTP id z14-20020aa7990e000000b0051f2b9f6402mr14621474pff.9.1655056719292;
        Sun, 12 Jun 2022 10:58:39 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b001676dac529asm3330520pla.146.2022.06.12.10.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 10:58:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 12 Jun 2022 07:58:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        matthew.wilcox@oracle.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/4] kernfs: make ->attr.open RCU protected.
Message-ID: <YqYpTShTDLvAp4vx@slm.duckdns.org>
References: <20220602063907.136569-1-imran.f.khan@oracle.com>
 <20220602063907.136569-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602063907.136569-2-imran.f.khan@oracle.com>
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

Sorry about the long delay.

On Thu, Jun 02, 2022 at 04:39:04PM +1000, Imran Khan wrote:
> +/**
> + * kernfs_deref_open_node_protected - Get kernfs_open_node corresponding to @kn
> + *
> + * @kn: target kernfs_node.
> + *
> + * Fetch and return ->attr.open of @kn when caller(writer) holds
> + * kernfs_open_file_mutex.
> + *
> + * Update of ->attr.open happens under kernfs_open_file_mutex. So as long as
> + * the current updater (caller) is holding this mutex, other updaters will not
> + * be able to change ->attr.open and this means that we can safely deref
> + * ->attr.open outside RCU read-side critical section.
> + *
> + * This should ONLY be used by updaters of ->attr.open and caller needs to make
> + * sure that kernfs_open_file_mutex is held.
> + */
> +static struct kernfs_open_node *
> +kernfs_deref_open_node_protected(struct kernfs_node *kn)
> +{
> +	return rcu_dereference_protected(kn->attr.open,
> +				lockdep_is_held(&kernfs_open_file_mutex));
> +}
> +
> +/**
> + * kernfs_check_open_node_protected - Get kernfs_open_node corresponding to @kn
> + *
> + * @kn: target kernfs_node.
> + *
> + * Fetch and return ->attr.open of @kn when caller(reader) holds
> + * kernfs_open_file_mutex.
> + *
> + * Update of ->attr.open happens under kernfs_open_file_mutex. So as long as
> + * the current reader (caller) is holding this mutex, updaters will not be
> + * able to change ->attr.open and this means that we can safely deref
> + * ->attr.open outside RCU read-side critical section.
> + *
> + * This should ONLY be used by readers of ->attr.open and caller needs to make
> + * sure that kernfs_open_file_mutex is held.
> + */
> +static struct kernfs_open_node *
> +kernfs_check_open_node_protected(struct kernfs_node *kn)
> +{
> +	return rcu_dereference_check(kn->attr.open,
> +				      lockdep_is_held(&kernfs_open_file_mutex));
> +}

I don't understand why the above is necessary. Whether you're a reader or
writer, you can deref the pointer w/ _protected as long as you're holding
the lock, right? If I'm mistaken and somehow a reader needs to use a
deref_check, I don't see a reason for this to be a separate accessor. Why
not just merge the condition into the kernfs_deref_open_node()?

Thanks.

-- 
tejun
