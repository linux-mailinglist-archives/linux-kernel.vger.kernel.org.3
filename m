Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306BE53C7F7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243255AbiFCJzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbiFCJzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:55:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B289F3AA4D;
        Fri,  3 Jun 2022 02:55:14 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q1so7894763ljb.5;
        Fri, 03 Jun 2022 02:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OWftr5rdooB1seu2CxMvWy4qJk9OeiT3kgBXgjqZdPg=;
        b=ShCcYVwxNf9xqvzDmLZrM4BHJ0z+7tlnyFxgGORXdxDR5cDAhS+v6fvTqXwWkb+Af4
         2y/+GlCQYSH6qUSbjlzcLF2MfW8w8SWXOjphqQAcnQHOijj7+AoCUhl4SNr3D/QcpWsV
         sRG5Cx5WxwkSGi757m/HUMwYmNwqI/HvAC04cpM9PQEPSFR3lvynH9MY+CCDYbELf0KT
         nKUqa7q1EHmizxWjDXr6y0Nf5zi0dZa6vqv+/VesFrhuXlwkHe2vzGwCmMy8yoOKuWFx
         Kw2tTmGVUP5XcWENKifidR/KTRb874f9Mw+Xe8gS1UKRdX2TioLTXbY+3rE5n13HyRRV
         VfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OWftr5rdooB1seu2CxMvWy4qJk9OeiT3kgBXgjqZdPg=;
        b=A2pm+7wQib6FI/a7aTLQR8Jwv85Gi0L/SLVPZjvMgucVRN9ppYMcYfI0nycK5JOJOd
         RB3+f2WOAngfAvrzfN5dJixxUhIPOfc9cv7h/W/dSheLJh/J6UbqmCPsYxBSU97jwhIW
         xhEylWuzAoOZ/A3qKlm3Ay7Ly+ibb5xbOMvUyNVwsAnIjDnyVKp2vkHUv8AeIo2KUfbZ
         NPtgtDxAtrg9iOqJJZEWyI1NwWpDvxTGP9txMAzUQOEllX6PSDfRJ81CMz3+rXhmKs3P
         NWlwKteGZ460U47PlOX9zHF3ea4ZquRFRhyK7IJtpQqngfBm+v4Pan3nnwhNNH2y8fcI
         dTxw==
X-Gm-Message-State: AOAM533D/bwLcID3vjb+C03gBPpGkG6AeQt8d/d2jbmUt/VaVFJqozlm
        j274ZCM5QCp2L+qgwU0FShckLXlFU7VNjg==
X-Google-Smtp-Source: ABdhPJwFPYGwdKJjJYBBZKPQnuxSXZum+xOwCTGSjAvuv3dWejOJbQB/6YmuhueXE+AvjG6HmoVoeQ==
X-Received: by 2002:a2e:9584:0:b0:255:829e:590a with SMTP id w4-20020a2e9584000000b00255829e590amr473270ljh.170.1654250113061;
        Fri, 03 Jun 2022 02:55:13 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id l26-20020a19495a000000b004790230b032sm1504717lfj.40.2022.06.03.02.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:55:12 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 3 Jun 2022 11:55:10 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] rcu/kvfree: Introduce KFREE_DRAIN_JIFFIES_[MAX/MIN]
 interval
Message-ID: <Ypnafl/65x4jHnfv@pc638.lan>
References: <20220602080644.432156-1-urezki@gmail.com>
 <20220602080644.432156-2-urezki@gmail.com>
 <YplIh8BoYXc8X77q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YplIh8BoYXc8X77q@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 11:32:23PM +0000, Joel Fernandes wrote:
> On Thu, Jun 02, 2022 at 10:06:44AM +0200, Uladzislau Rezki (Sony) wrote:
> > Currently the monitor work is scheduled with a fixed interval that
> > is HZ/20 or each 50 milliseconds. The drawback of such approach is
> > a low utilization of page slot in some scenarios. The page can store
> > up to 512 records. For example on Android system it can look like:
> > 
> > <snip>
> >   kworker/3:0-13872   [003] .... 11286.007048: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=1
> >   kworker/3:0-13872   [003] .... 11286.015638: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> >   kworker/1:2-20434   [001] .... 11286.051230: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> >   kworker/1:2-20434   [001] .... 11286.059322: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=2
> >   kworker/0:1-20052   [000] .... 11286.095295: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=2
> >   kworker/0:1-20052   [000] .... 11286.103418: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=1
> >   kworker/2:3-14372   [002] .... 11286.135155: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> >   kworker/2:3-14372   [002] .... 11286.135198: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> >   kworker/1:2-20434   [001] .... 11286.155377: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=5
> >   kworker/2:3-14372   [002] .... 11286.167181: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=5
> >   kworker/1:2-20434   [001] .... 11286.179202: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000008ef95e14 nr_records=1
> >   kworker/2:3-14372   [002] .... 11286.187398: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000c597d297 nr_records=6
> >   kworker/3:0-13872   [003] .... 11286.187445: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000050bf92e2 nr_records=3
> >   kworker/1:2-20434   [001] .... 11286.198975: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=4
> >   kworker/1:2-20434   [001] .... 11286.207203: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=4
> > <snip>
> > 
> > where a page only carries few records to reclaim a memory. In order to
> > improve batching and make utilization more efficient the patch introduces
> > a drain interval that can be set either to KFREE_DRAIN_JIFFIES_MAX or
> > KFREE_DRAIN_JIFFIES_MIN. It is adjusted if a flood is detected, in this
> > case a memory reclaim occurs more often whereas in mostly idle cases the
> > interval is set to its maximum timeout that improves the utilization of
> > page slots.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
Thanks!

This patch makes the interval hard-coded in some sense so you can not change
it in runtime, only recompilation. If there is a need or request we can make
both as module_param().

If we are to do that we can just add one extra patch on top of it.

--
Uladzislau Rezki
