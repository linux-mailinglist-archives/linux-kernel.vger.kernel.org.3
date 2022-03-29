Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47644EAA70
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiC2J0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbiC2J0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:26:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE2E27169
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GNMAqIh0j6P//qlq8Z1xIR7mjldURS8/Ro5eIkOUj+w=; b=B1myBB6pcjFAoPaZpBLrlBlJeD
        lsya7OrVyrHw3xcSbhztqK72QHvaKM7rlZiEwgxOP2yYEYqjbBeoEDmeVDa4MqcnzDMzmeGMW3H8q
        WtVql6DJiGqyDmAVKo7v46USmmMOREJ8zcQ5d2QzhOUaiFLbjciuI46l69y6CmIfyhB5A9fijRTEt
        jn/8DfIFZpZbfgX/7tE93ChQoMbYbftFhHJgPX7W41AB0ge/6sAAVoKDbQHbxuSj8Otk7dRXCqZVS
        pBJVklp/JiQAbIC48SRmBkrcEnzZl9fvhWoyE23U8AReqJwCGR+kLmJ9daNkl+SavvD5dOm8QRTMs
        JjVv4/rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZ84a-005o2F-Tu; Tue, 29 Mar 2022 09:23:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B1DD9861E9; Tue, 29 Mar 2022 11:23:30 +0200 (CEST)
Date:   Tue, 29 Mar 2022 11:23:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] sched: topology: add input parameter for
 sched_domain_flags_f()
Message-ID: <20220329092330.GG8939@worktop.programming.kicks-ass.net>
References: <1648545322-14531-1-git-send-email-wangqing@vivo.com>
 <1648545322-14531-2-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648545322-14531-2-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 02:15:19AM -0700, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> sched_domain_flags_f() are statically set now, but actually, we can get a lot
> of necessary information based on the cpu_map. e.g. we can know whether its
> cache is shared.
> 
> Allows custom extension without affecting current.

Still NAK
