Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4049C51C9D8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384559AbiEEUFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244961AbiEEUFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:05:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832085EDF0
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:01:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fv2so5138003pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 13:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pgblE3j4iKhz7YnaakiOSpHlbjQP4SAyavbRgdtpp8I=;
        b=Fpczt1Rmo9bey40PtYJ41u9aQTEn4i74wmc8/xVaITuombJTgbBwdwhuoo8Da5pw/Z
         8erpU+uD0pDZ0o01228ZgmGm0cgCuGbgwdGB6JwmoWNdO5HkSq94CrZZhvxzzoY/CMLE
         VDgwPcqO66XU8yGHYqVJR6Pl+x10LQkTz7W89lTrnzVOP2xCQeWsvTCCOaI+LJ346+gn
         jEgpseOVNtomk93eXvWarsB52hyROlIyAwsFaEM/sD+ZkQwV5d47sK7oHOBFVEsZFX8v
         +ZDg+PHi2e5K1y1ZhQbObIX1gZ/xS0307712RoViSArPBFAWzxVSIeksKwyj+3AwPt//
         JnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pgblE3j4iKhz7YnaakiOSpHlbjQP4SAyavbRgdtpp8I=;
        b=GAClRsbQAMdyglMSfXcwktFFSltiaSYEagL29l93SaGIcmcAIkWnZE3+/IUbf/31r2
         nG6HESFTMPEYOmSt4WUltyCeZFZ3pUmIil4l3qjQuDWOhqEsiqdFzp5dfaewLK7OHnbo
         DA+hBYZl7A3XLKRy67HNoPBB69t+2/DyGFRp05gqhMwdowx7l/1plzOqjIlddPL/QUbB
         64/sAxPqGHi2b70GU/FXiwAzB2Y+M7Y+GC65lR7gGUQF4+MQEsc3+jsV9dm/Hpf7YhLb
         jKgrjXTGlaFx/hyUQEcGBTnfkSI3mjv69a7xwdSfU/R4KU0hX/CBPSmRRVoRrwLA1bDu
         IFfA==
X-Gm-Message-State: AOAM530KiTZvEMd7B3j7e/nAAMcoCVJDeBGhBuJ08DqZeWJmuFIAr5jk
        psPxHvGoGBlRtzVITuaxvaK0JyMeBEs=
X-Google-Smtp-Source: ABdhPJz3KAefvYlFE9BMykoe7YrxFjSJmSecI5KPAZIy2k3yzWGkd2x7eYYZKZMXiHO2cKu/E96BIg==
X-Received: by 2002:a17:902:8608:b0:158:b827:7721 with SMTP id f8-20020a170902860800b00158b8277721mr28760064plo.149.1651780913900;
        Thu, 05 May 2022 13:01:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:29a5])
        by smtp.gmail.com with ESMTPSA id s66-20020a625e45000000b0050dc76281dbsm1737123pfb.181.2022.05.05.13.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 13:01:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 May 2022 10:01:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] kernfs: make ->attr.open RCU protected.
Message-ID: <YnQtL7+GYHwpo4n2@slm.duckdns.org>
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
 <20220428055431.3826852-3-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428055431.3826852-3-imran.f.khan@oracle.com>
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

On Thu, Apr 28, 2022 at 03:54:28PM +1000, Imran Khan wrote:
> +static struct kernfs_open_node *kernfs_deref_on_raw(struct kernfs_node *kn)
> +{
> +	return rcu_dereference_raw(kn->attr.open);
> +}

Wrapping the above probably isn't helping anything.

> +/*
> + * Check ->attr.open corresponding to @kn while holding kernfs_open_file_mutex.
> + * ->attr.open is modified under kernfs_open_file_mutex. So it can be safely
> + * accessed outside RCU read-side critical section, while holding the mutex.
> + */
> +static struct kernfs_open_node *kernfs_check_on_protected(struct kernfs_node *kn)
> +{
> +	return rcu_dereference_check(kn->attr.open,
> +				      lockdep_is_held(&kernfs_open_file_mutex));
> +}

Maybe name this just kernfs_deref_on()?

> @@ -156,8 +188,9 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
>  static int kernfs_seq_show(struct seq_file *sf, void *v)
>  {
>  	struct kernfs_open_file *of = sf->private;
> +	struct kernfs_open_node *on = kernfs_deref_on_raw(of->kn);

I suppose this is protected by the fact that @of is on @on? If so, just add
the condition to the checked version. The condition doesn't have to be
perfect - e.g. you can just say that neither @on's and @of's list_head isn't
empty. While not comprehensive, it'd still provide meaningful protection
against mistakes and be easier to understand if the deref accessor clearly
explains the expectations.

> @@ -201,7 +235,8 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		goto out_free;
>  	}
>  
> -	of->event = atomic_read(&of->kn->attr.open->event);
> +	on = kernfs_deref_on_raw(of->kn);
> +	of->event = atomic_read(&unrcu_pointer(on)->event);

Ditto here.

> @@ -815,7 +843,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>  __poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
>  {
>  	struct kernfs_node *kn = kernfs_dentry_node(of->file->f_path.dentry);
> -	struct kernfs_open_node *on = kn->attr.open;
> +	struct kernfs_open_node *on = kernfs_deref_on_raw(kn);

and here.

> @@ -922,13 +950,13 @@ void kernfs_notify(struct kernfs_node *kn)
>  		return;
>  
>  	/* kick poll immediately */
> -	spin_lock_irqsave(&kernfs_open_node_lock, flags);
> -	on = kn->attr.open;
> +	rcu_read_lock();
> +	on = rcu_dereference(kn->attr.open);

Shouldn't this be kernfs_deref_on() too?

Thanks.

-- 
tejun
