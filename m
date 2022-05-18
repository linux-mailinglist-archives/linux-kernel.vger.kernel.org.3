Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E58052BF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbiERPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbiERPy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:54:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F511CC9BB;
        Wed, 18 May 2022 08:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8CA3B82162;
        Wed, 18 May 2022 15:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6101AC385A5;
        Wed, 18 May 2022 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652889260;
        bh=prv+Ye/H1mstl526vAK0JQj51CiNh01NdvehTiX0OrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KL54s7+jyxQ1hiSfnf2oJBJo9yCTsB/6fsZAVfj4vEhnGh3Xrgk2KolU/7mHh+Wmm
         wEVJaX0REY2vi8KE/n1rATu92AKEJJEN0/F0NexNz5CeB1T725/pJ1LprH2RzTD1D5
         6LLRQ2Ss3tbygJUEFd9Vl5GJllQwWvEnie3/YBRHIoru49Jdc7kJ5n/89E8AvSwUmZ
         rg2248jMnVt4UoY3CefYw0HMoS8O57IdQoN6otO2a/ET1KYfh8MnmbAP4WUv/W0MIa
         CEMaVF/6fYZiNSUJgTPVTi9ROseGQSvBa8a5wRsmhoQxRt7A7dIvpDGkfc1L7U4SQD
         jThtgEZl2X5PA==
Date:   Wed, 18 May 2022 11:03:45 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lin Yujun <linyujun809@huawei.com>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnny.chenyi@huawei.com, chenjiahao16@huawei.com,
        chenlifu@huawei.com, lizhengyu3@huawei.com, liaochang1@huawei.com,
        wangzhu9@huawei.com, xuyihang@huawei.com, chris.zjh@huawei.com,
        zouyipeng@huawei.com
Subject: Re: [PATCH -next] x86/events:Use struct_size() helper in kzalloc()
Message-ID: <20220518160345.GA43938@embeddedor>
References: <20220518131626.109123-1-linyujun809@huawei.com>
 <20220518134920.GA8361@embeddedor>
 <YoT6tHWbBOchi29i@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoT6tHWbBOchi29i@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:55:00PM +0200, Peter Zijlstra wrote:
> On Wed, May 18, 2022 at 08:49:20AM -0500, Gustavo A. R. Silva wrote:
> 
> > > Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> > > ---
> > >  arch/x86/events/rapl.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> > > index 77e3a47af5ad..c7e79f0ac04f 100644
> > > --- a/arch/x86/events/rapl.c
> > > +++ b/arch/x86/events/rapl.c
> > > @@ -685,7 +685,7 @@ static int __init init_rapl_pmus(void)
> > >  	int maxdie = topology_max_packages() * topology_max_die_per_package();
> > >  	size_t size;
> > >  
> > > -	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
> > > +	size = struct_size(rapl_pmus, pmus, maxdie);
> > >  	rapl_pmus = kzalloc(size, GFP_KERNEL);
> > 
> > It seems that in this case, size could be entirely replaced by
> > struct_size().
> 
> Except every time I look at struct_size() I go: WTF does that do; while
> the code as-is is crystal clear, no de-obfucstaion required.

Naming it flex_struct_size() would be more informative?

--
Gustavo

