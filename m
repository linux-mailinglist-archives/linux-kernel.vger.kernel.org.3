Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24BC4DDF27
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbiCRQgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiCRQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:36:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BD92487AC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n/SvPEm9vzOpBons3hXz4LD7sf0VlztDTbLUwpFwtSU=; b=jawbSOY5FJWejPFZnSvUUR3Mzp
        eaI/6U9Dptd+Da+Gx+hM52OdPC+K54YhlEkg6SNEOn3HfIyuAfjfHrm5H+lNJOMNXM9QXok0Nk0aQ
        pcjpNUQeESI2ZViPe7ezUTItvQNkKWFmxz92gNSUFPBjZQcvBhLeP1aL0VLquohZQ/G5JwAE+2OLP
        uw3Fa94DhmD/U/OKYGRDYqVa2c0XlQvOGvJyyR7RaNBnhviDQXhvWJuis8yIMU6Lij3LroP8B61WW
        b2F30x9rRiMWKC+6dPQRNoCYW0CCcRpTf4sg0VczOGqagoKZigfOPRiXvOIigA4PRr8d7eR7qpQsC
        +G0cB0CA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVFYl-002Pmx-5z; Fri, 18 Mar 2022 16:34:39 +0000
Date:   Fri, 18 Mar 2022 09:34:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Baisong Zhong <zhongbaisong@huawei.com>,
        Zhen Ni <nizhen@uniontech.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sched/rt: fix build error when CONFIG_SYSCTL is
 disable
Message-ID: <YjS0n6OetpxNGiDL@bombadil.infradead.org>
References: <20220318025417.3683430-1-zhongbaisong@huawei.com>
 <YjQ52q5voQRBRgKw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjQ52q5voQRBRgKw@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 08:50:50AM +0100, Ingo Molnar wrote:
> 
> I believe these build errors are caused by new commits in the sysctl-next 
> tree that change scheduler code:
> 
>   4925401d06dc sched: Move rr_timeslice sysctls to rt.c
>   5f6e55c2485c sched: Move rt_period/runtime sysctls to rt.c
> 
> In particular I don't see any Cc: to scheduler folks in these two commits - 
> and I'd have preferred to pick these up into the scheduler tree, to avoid 
> the merge conflicts and the build failure regressions...

Sorry about that, Peter was Cc'd on the patches and he did provide
feedback on the first set. During that review I also had suggested that
since it seemed that during the new kernel development cycle the next
target was sched for sysctl moves out of kernel/sysctl.c *but* that since
Andrew had merged these during the last kernel release I had suggested
to Peter that perhaps these should just go through his tree [0]. No
was no replies to that thread.

I had provided feedack for Zhen Ni's 2nd series of his patches and I
also had suggested for him to use 0day to avoid build issues. By his
3rd spin it was already on my radar that more syctls changes were being
posted outside of sched and so I asked for feedback from Andrew / Peter
about using instead a dedicated tree to collect sysctl changes to avoid
possible merge conflicts [1]. The only replies came from Andrew agreeing
to a syctl-next tree to help to avoid merge conflicts [2]. By v3 then,
through feedback by Andrew and no replies by Peter I decided to take this
via sysctl-next and let these get baked / tested through linux-next and
0day.

Let me know if you'd like me to drop these patches and rebase my tree,
or if you'd like to proceed some other way.

[0] https://lkml.kernel.org/r/YgaprpOvUYlrNvdH@bombadil.infradead.org               
[1] https://lkml.kernel.org/r/Yg3+bAQKVX+Dj317@bombadil.infradead.org               
[2] https://lkml.kernel.org/r/Yg/jxFqiuyR/xB2s@bombadil.infradead.org               

  Luis
