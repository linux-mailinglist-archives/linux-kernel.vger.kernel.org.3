Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C6256D757
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGKIER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGKIEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:04:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DE413F07
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=vd4w8U1sm/tll3tBVudqW3UexPb6PnDnqmY/hLVqkc8=; b=jXZgIdBhkS7XmVgp4ihhpi9SI1
        oSKtLZAgkwUXV4zY3y3HDrsEM54GizOA5fWFCF6gOlMYtVWzNLX6T6n0mBbCOTnV8XXln7XZH4X8l
        JtMKccRRhcm2J1i8ksGURmOPXKJLpl7vZ18XdfWO+eZsUPKyf6QdvnbCiCSJikRTTe1XG9nq97g3e
        PeJUtkd1IclAt76MCgRy4daC4DsBMzQkyOU4Scyk6LIqIPw3m/+WzOA3OQke0ZQcdkkZpGOb0yPVd
        IXRzrdRYn/LypBScf49h0/lQVHaQqa4EwVKUgjFffjN/fytIq8maMHDqlDjxBMGwpMyUkPe/rV+qc
        J20GeRBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAoOg-005mfz-Mt; Mon, 11 Jul 2022 08:04:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9F7D3001F3;
        Mon, 11 Jul 2022 10:04:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F6E42026E341; Mon, 11 Jul 2022 10:04:01 +0200 (CEST)
Date:   Mon, 11 Jul 2022 10:04:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Major Chen <major.chen@samsung.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        Hongfei Tang <hongfei.tang@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched,debug: fix dentry leak in
 update_sched_domain_debugfs
Message-ID: <YsvZcX4mZpP3a1L8@hirez.programming.kicks-ass.net>
References: <CGME20220711025311epcms5p874ccee18b6dd4e6a62759d0749936e61@epcms5p1>
 <20220711030341epcms5p173848e98b13c09eb2fcdf2fd7287526a@epcms5p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220711030341epcms5p173848e98b13c09eb2fcdf2fd7287526a@epcms5p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:03:41AM +0800, Major Chen wrote:
>  
> update_sched_domain_debugfs() uses debugfs_lookup() to find wanted dentry(which has
> been created by debugfs_create_dir() before), but not call dput() to return this dentry
> back. This result in dentry leak even debugfs_remove() is called.
>  
> Signed-off-by: major.chen <major.chen@samsung.com>
> ---
>  kernel/sched/debug.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>  
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index bb3d63b..4ffea2d 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -412,11 +412,14 @@ void update_sched_domain_debugfs(void)
>  
>          for_each_cpu(cpu, sd_sysctl_cpus) {
>                  struct sched_domain *sd;
> -                struct dentry *d_cpu;
> +                struct dentry *d_cpu, *d_lookup;
>                  char buf[32];
>  
>                  snprintf(buf, sizeof(buf), "cpu%d", cpu);
> -                debugfs_remove(debugfs_lookup(buf, sd_dentry));
> +                d_lookup = debugfs_lookup(buf, sd_dentry);
> +                debugfs_remove(d_lookup);
> +                if (!IS_ERR_OR_NULL(d_lookup))
> +                        dput(d_lookup);
>                  d_cpu = debugfs_create_dir(buf, sd_dentry);
>  
>                  i = 0;

Please try again, while not HTML, this email is severely whitespace
mangled (there's no '\t' characters in it for one).
