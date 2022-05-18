Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FF452BD05
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238338AbiERN47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiERNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:55:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE07119FF4C;
        Wed, 18 May 2022 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O9mZPAfhxk+vK1NmKVv9rMZucBWKRb6lp1Gqv3JYTMs=; b=k5zag6clGC7gAjXaCgqW79fCQm
        /ahuxMDTaWfqlQrnt2u6+d9fNqVCuClolQff+831R3HtXerbbuOUK/Ssn5rmlLVBFnqnKsEJhAsR4
        AuUXgr1p4/CCLLnGneGITW0wj4lSZIOS+iy7Dmq3NCKUZC9Mz8rYgVFNfawC67Bv9Xf15hPXpnSPD
        CyxRvgejbT1vyk0ejwnVyS+dsv2rXMn2LsaOrn2EgbE4UfeqSmJWwCO7Y4lgRwQC7g0VzUAu+Qrbj
        29taY2BZLdQaokwzFfEkgUG9lc7FzD6M+CYhJ1XVWBVrumujGt83uerUUZO9qfrUh4tv84Oqm40Rq
        shVyTMQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrK8l-001YRv-67; Wed, 18 May 2022 13:55:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5A583004B5;
        Wed, 18 May 2022 15:55:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A76FF202391E4; Wed, 18 May 2022 15:55:00 +0200 (CEST)
Date:   Wed, 18 May 2022 15:55:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
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
Message-ID: <YoT6tHWbBOchi29i@hirez.programming.kicks-ass.net>
References: <20220518131626.109123-1-linyujun809@huawei.com>
 <20220518134920.GA8361@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518134920.GA8361@embeddedor>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 08:49:20AM -0500, Gustavo A. R. Silva wrote:

> > Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> > ---
> >  arch/x86/events/rapl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> > index 77e3a47af5ad..c7e79f0ac04f 100644
> > --- a/arch/x86/events/rapl.c
> > +++ b/arch/x86/events/rapl.c
> > @@ -685,7 +685,7 @@ static int __init init_rapl_pmus(void)
> >  	int maxdie = topology_max_packages() * topology_max_die_per_package();
> >  	size_t size;
> >  
> > -	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
> > +	size = struct_size(rapl_pmus, pmus, maxdie);
> >  	rapl_pmus = kzalloc(size, GFP_KERNEL);
> 
> It seems that in this case, size could be entirely replaced by
> struct_size().

Except every time I look at struct_size() I go: WTF does that do; while
the code as-is is crystal clear, no de-obfucstaion required.

