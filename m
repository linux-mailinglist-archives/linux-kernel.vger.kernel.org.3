Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328BB581863
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbiGZRa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiGZRa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:30:26 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B6D13F0A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:30:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c13so7244821pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QtXo7eD9excPf433931+cz+8Qs1v7ryjcIg+fUZzvcE=;
        b=DgZBpkIF3DWZmzRvdsg0CG76bXnbZU37Soe5JWaax+s3zJ8fbqXqrRDrdgk9gPw5Bb
         Nn7hQ2MDEN22iOOZwmkfp5WRhSZk1wGS25/uvUuSAx9qjxaAFjf/SuJUfSoDnw9/FSU5
         uD8pptjgGPZqKHs63xneTc2H4mwqRvRnrTXj7KxjsB3KRN063sn6F3s/eEk7R079c9el
         gT7AEMQ59kmfWE//8FfzRhJc+wyKKwZTAuCzewyNMg8G5KUfBuEeotKAzWYO00gwni18
         Mrjy8KZQ4+pRyQhUADJfPZELEk3vpz17UyUm5vRr+YKLrBD25jX90e5Rkk2nCScgb6zD
         kyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QtXo7eD9excPf433931+cz+8Qs1v7ryjcIg+fUZzvcE=;
        b=l+VKrO0a+pWZApRmjPMCmaxKCGHfNpY+T7MFO2yp7KcTpXSjCV3k8qgOFB5pc3Avy/
         2R59uW3n7iFty0g4F+2Wa4Jd29WZGVgpKevhdIpLkOPDQIsYtq1ilXznuvvWtINwopi9
         gm5UMru1XmUkt2IYj1JbNt4o6t6gqp2a/7V2AzT64UTj8X4mtsuEO1GQIMhB44rde3bb
         RCrsyJFrtNzCopXUda/GRGK5T+TppKdwQSpRK92pMCEN1kQk9uTuz5a0iisbPTgq9z6p
         r4gWPg1BZZAdM3fOgreJ/t6DMtdI0KFu8QvLJ/lbzfeITIVVqkYK81XYppoX5ep0/JOh
         lbCQ==
X-Gm-Message-State: AJIora/FFUgctSL+Urf1L/KuJYVWKbZ1azIr11aUilisnfFniRC12QOJ
        Vsayv+5uo8nOXms857AtFgJDvDtJuK0=
X-Google-Smtp-Source: AGRyM1uz1pnwkM9MAUWc6zXr5l+o8vnxhGI5yjU8ZZNoGjJu+Amy5sY1FlhSUV2l7QQO9BpS8O1HQg==
X-Received: by 2002:a17:903:1302:b0:16d:300a:7ff1 with SMTP id iy2-20020a170903130200b0016d300a7ff1mr17731959plb.3.1658856624647;
        Tue, 26 Jul 2022 10:30:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:370d])
        by smtp.gmail.com with ESMTPSA id k17-20020aa79991000000b0052090076426sm12344518pfh.19.2022.07.26.10.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:30:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 26 Jul 2022 07:30:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH] workqueue: Unbind workers before sending them to
 exit()
Message-ID: <YuAkroXHF+Zg45KU@slm.duckdns.org>
References: <20220719165743.3409313-1-vschneid@redhat.com>
 <YthDjPq3CtWc+o0/@slm.duckdns.org>
 <CAJhGHyAso+JH+QMXcfKTyOqq4yBD9Vc19sBbebEXohHe5znL8Q@mail.gmail.com>
 <xhsmhv8rqfu6w.mognet@vschneid.remote.csb>
 <YtuEJLDkO/lATYeb@slm.duckdns.org>
 <xhsmh8rohfq6m.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh8rohfq6m.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 25, 2022 at 11:21:37AM +0100, Valentin Schneider wrote:
> On 22/07/22 19:16, Tejun Heo wrote:
> > On Thu, Jul 21, 2022 at 02:53:43PM +0100, Valentin Schneider wrote:
> >> > I think it needs something like task_set_cpumask_possible() which is
> >> > documented as being usable in (raw) spinlocks and set the task's cpumask
> >> > to cpu_possible_mask and let the later ttwu help migrate it to a
> >> > proper non-isolated CPU or let it keep running.
> >> 
> >> I'll see what I can come up with, thanks for the suggestion.
> >
> > Alternatively, we can just kill all the idle kworkers on isolated cpus at
> > the end of the booting process.
> 
> Hm so my choice of words in the changelog wasn't great - "initial setup"
> can be kernel init, but *also* setup of whatever workload is being deployed
> onto the system.
> 
> So you can be having "normal" background activity (I've seen some IRQs end
> up with schedule_work() on isolated CPUs, they're not moved away at boot
> time but rather shortly before launching the latency-sensitive app), some
> preliminary stats collection / setup to make sure the CPU will be quiet
> (e.g. refresh_vm_stats()), and *then* the application starts with
> fresh-but-no-longer-required extra pcpu kworkers assigned to its CPU.

Ah, I see. I guess we'll need to figure out how to unbind the workers then.

Thanks.

-- 
tejun
