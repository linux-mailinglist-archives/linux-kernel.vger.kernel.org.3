Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2201551073B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245551AbiDZSkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352151AbiDZSkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:40:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB1C496AE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:37:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n33-20020a17090a5aa400b001d28f5ee3f9so3309565pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tBbgUCNdr6ph2o8lgFO7/KNelCwZdOJMwobml+T/vmk=;
        b=dXYhjl1ZogZCLW7pJiWl3EePAGZUCp2eAcRyVfZ4C3eC6ziSc4EWvtK7CbQ5rNO5Fs
         ctf7B4BN+aC5OrGYEwdaodL7XyZOmmAsjPYc42T5HmAvkKCUDXaH7036xXeWxBm23Z5t
         DRtEdNQfjjreGBjIGZ4H2lZS9GqVwEG8Zf/vWb4g846y6nkDuFKQXZOVgBnZuQMGFf6d
         lPGLHky4ib8rHZ1uTZ2EvVGLTbHVpCtgEH8YpQV5q344Vmf56Hf7Hw5treiXna/Cz79Y
         Kd8R1BRTX+8cfwSRJprB59A7bEPMA9XYVW3HDW60Ois6DQg4RViw3VsTHIIcmxYhTPVz
         mc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tBbgUCNdr6ph2o8lgFO7/KNelCwZdOJMwobml+T/vmk=;
        b=GKeduidSHcp93Qh0FCLOTyI+eKKTSbEFRJGAX4Scy0nyjpgW/2XKXnGEL/UMsNmCeh
         kqiSQ+avha5mNHMzK06DNU/NKznxq/go4AXr+pp1KhLxMeTeONlGSzQ91vN9ZJWKNNxH
         piiiFbtMhynvVM6qJeiSPMJ4QFhyvacGB8xNMSt9aKwrf2jr858IxzDHYvBrYeTEK+CY
         nGpYwFJkY3xM1rindm3Ic2+qJOX7DmuWVNJSHOJXzuOrEfHDL9EUnwWFRPsJFoB7SbQx
         KPH2umRI+H237T+TRKrQQITLAS9ZIwHIXeHOeD+03lBIHbL4dZ4UnyIzGFDtnVpqC9IU
         MX1w==
X-Gm-Message-State: AOAM53371uvb71kwy50HPWu6sLXjGccmz8cTXgkwU4FN4JQPq+l4Zdcb
        bcNUbuftCr0VLwAQ4aHo+48=
X-Google-Smtp-Source: ABdhPJzG7IqVC51RS5LYtlpE7nRLYtD2SwlF8bv19uIJCHVaD5g7Of1sj+CPLIjTpo85hMrsoFW0UQ==
X-Received: by 2002:a17:90a:4d04:b0:1d9:3f18:f4dd with SMTP id c4-20020a17090a4d0400b001d93f18f4ddmr18980993pjg.111.1650998253363;
        Tue, 26 Apr 2022 11:37:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7a3e])
        by smtp.gmail.com with ESMTPSA id y64-20020a62ce43000000b0050d2bab906esm10993399pfg.183.2022.04.26.11.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:37:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 26 Apr 2022 08:37:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/10] kernfs: make ->attr.open RCU protected.
Message-ID: <Ymg76nQOOv7hwtc1@slm.duckdns.org>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
 <20220410023719.1752460-3-imran.f.khan@oracle.com>
 <YmLVrfI4UN8ajoUM@slm.duckdns.org>
 <4a778d83-df05-14e6-038a-9e0fb86f068e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a778d83-df05-14e6-038a-9e0fb86f068e@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:54:36AM +1000, Imran Khan wrote:
> >> @@ -912,14 +920,13 @@ void kernfs_notify(struct kernfs_node *kn)
> >>  		return;
> >>  
> >>  	/* kick poll immediately */
> >> -	spin_lock_irqsave(&kernfs_open_node_lock, flags);
> >> -	on = kn->attr.open;
> >> +	rcu_read_lock();
> >> +	on = rcu_dereference(kn->attr.open);
> >>  	if (on) {
> >>  		atomic_inc(&on->event);
> >>  		wake_up_interruptible(&on->poll);
> >>  	}
> >> -	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
> >> -
> >> +	rcu_read_unlock();
> > 
> > An explanation of why this is safe in terms of event ordering would be great
> > here.
> > 
> 
> This is safe because here we don't need to refcnt ->on in this case. If
> writer (kernfs_put_open_node) has already made ->attr.open NULL we will
> bail out. If kernfs_notify got an old ->attr.open we can still safely
> process the event, even if kernfs_put_open_node updates ->attr.open to
> NULL in parallel.
> In both the cases the behaviour/order will be same as earlier code that
> used kernfs_open_node_lock.
> Please let me know if this answers your query or if something is still
> missing.

I was more wondering whether if there's someone waiting for an event which
should arrive considering the sequence of events, whether the lockless code
would have the same ordering properties. I think it does given that the
event sequence can only be defined in memory visibility terms anyway.

Thanks.

-- 
tejun
