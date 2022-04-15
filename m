Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA1502976
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244115AbiDOMQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiDOMQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:16:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5EFBF51A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MILgHchDw/IeKkYl1D6SOFjIDDJ9KwwN+5ggHUMxk60=; b=dmJQE2xYgRH2XkTu0C4r6F8AxH
        1Z7Hxy59HvK5tl9PIBCpodHZcD+98LI3BvOLfHODMAt1EgHVo2ud7CZhwj4rcXpbDSvsGFMc6TfeL
        O4Z1zYQjTUXd5ya0WVLkc7sgGjXuGKijRVqFbbZRXdn3sVwnY/6frekJrPSdC33djWWDwBmFirzkT
        k3GyqPoC53vRYDD4gxOkwMRCsSJD9ecZ/1f+XCvGVh/e9pE2GZncirbwewZUEFkNjxr1iTd1WKtVl
        GHr9wwAbFwSgO8cETeKLnsAy6nst9Saf8FkBpQigKSGM5/7UCuh6uN3bhS8L4PPP5DsVUEPBKeEih
        1oGJVnwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfKp3-005NLJ-5p; Fri, 15 Apr 2022 12:13:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB3323001AD;
        Fri, 15 Apr 2022 14:13:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EA2330A47E04; Fri, 15 Apr 2022 14:13:07 +0200 (CEST)
Date:   Fri, 15 Apr 2022 14:13:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Donghai Qiao <dqiao@redhat.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, tglx@linutronix.de,
        gor@linux.ibm.com, donghai.w.qiao@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] smp: cross CPU call interface
Message-ID: <YllhUx6g7ySAtk9k@hirez.programming.kicks-ass.net>
References: <20220415024701.876364-1-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415024701.876364-1-dqiao@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:46:50PM -0400, Donghai Qiao wrote:
> The motivation of submitting this patch set is intended to make the
> existing cross CPU call mechanism become a bit more formal interface
> and more friendly to the kernel developers.
> 
> Basically the minimum set of functions below can satisfy any demand
> for cross CPU call from kernel consumers. For the sack of simplicity
> self-explanatory and less code redundancy no ambiguity, the functions
> in this interface are renamed, simplified, or eliminated. But they
> are still inheriting the same semantics and parameter lists from their
> previous version.
> 
> int smp_xcall(int cpu, smp_call_func_t func, void *info, unsigned int flags)
> 
> int smp_xcall_cond(int cpu, smp_call_func_t func, void *info,
>                    smp_cond_func_t condf, unsigned int flags)
> 
> void smp_xcall_mask(const struct cpumask *mask, smp_call_func_t func,
>                     void *info, unsigned int flags)
> 
> void smp_xcall_mask_cond(const struct cpumask *mask, smp_call_func_t func,
>                          void *info, smp_cond_func_t condf, unsigned int flags)
> 
> int smp_xcall_private(int cpu, call_single_data_t *csd, unsigned int flags)
> 
> int smp_xcall_any(const struct cpumask *mask, smp_call_func_t func,
>                   void *info, unsigned int flags)
> 

Can we please remove that x? That's going to be horrible pain for a long
time to come.
