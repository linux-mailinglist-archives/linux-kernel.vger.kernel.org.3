Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8221D47BD0F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhLUJmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLUJmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:42:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0B1C061574;
        Tue, 21 Dec 2021 01:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QrPDIHV6JKNuTSPi/TN4HuQpSRR4DdA0vk+MOGmkO44=; b=jVQVo1vfLncyRnh+JyueTcmffS
        kudGfbKBnmC15ob8RkoYAIK63151jaMVntkYbLmn74dx2jhKKAaySCbkmdTcRKoNdI9+RfgjAej9i
        c2Fy394CEC6yYR0THGvRFl7VIWqeFjdWedrG/SdpTSSxNWDjFd+AiANLVoIRyCXw2Z3lXnrlGrWBK
        Meb7Rrek2tSWgBNoyjfsaf2eB2wq24/XaxTCD3qNVg2yUtMmWFf/pYzXVrvaLVyGpcfhKFkyUVG0X
        Ua99fMmzccx0vxFtdIYTqNn6Kl/9fR3O/htcCn/0s6R7Wz2WVIIM2VwF57rDnTcNjo1XdXpDhiMzZ
        704lt1kQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzbeT-002hq3-T7; Tue, 21 Dec 2021 09:41:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 256EC3002BE;
        Tue, 21 Dec 2021 10:41:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 159BB2C9C5155; Tue, 21 Dec 2021 10:41:45 +0100 (CET)
Date:   Tue, 21 Dec 2021 10:41:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <YcGhWRPSbxNC4Qn9@hirez.programming.kicks-ass.net>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
 <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:40:50AM +0100, Peter Zijlstra wrote:
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 2e076a459a0c..cd8b5cac542a 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1485,6 +1485,7 @@ void __init tsc_early_init(void)
>  	loops_per_jiffy = get_loops_per_jiffy();
>  
>  	tsc_enable_sched_clock();
> +	use_tsc_delay();
>  }
>  
>  void __init tsc_init(void)

Thomas, the above hunk seems right to me; should I make a proper patch
ouf of that or did I overlook something obvious ?
