Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81F75A92C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiIAJLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiIAJLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:11:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C450C2FB8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IspEq+yj6pohB+eIdHs2W79ztysrP825vNrScX367MU=; b=Uo6c88F/er8hSLdGvASzN+BpKf
        bafsTV6FZ8mA0DUlH5BBqJCeBZlZqn2C5I1vDt1AR0JO2ZfJBUohMJ6QL4NQ9fADLtumON/augwYK
        HoKG5sWR/XqPEZHwAG7BffE5k5NO+EnTnO/ER6dtBXcggo1pZ+AVP/f5sULqjbklxN+bbSBorA1jF
        2xEvUTZd3/ty9IztaSsvNhq+zHOEg+esldBLdfxzHgnUM8unm84q+jNz7vMKcEdEly4pEL8CaFxCx
        OUzAJiafWVqs0RxIbH8wHgiF8vHmdpl+leY0CsN5BLhfuff8VXXtmO1AOSiAObZ+4kquUQxsrSWzG
        lBQmhvZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTgDq-008MrA-7h; Thu, 01 Sep 2022 09:10:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCCCC3002A3;
        Thu,  1 Sep 2022 11:10:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B782E2B1A6BCE; Thu,  1 Sep 2022 11:10:49 +0200 (CEST)
Date:   Thu, 1 Sep 2022 11:10:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     x86@kernel.org, eranian@google.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v2 8/9] perf/x86/intel: Shadow
 MSR_ARCH_PERFMON_FIXED_CTR_CTRL
Message-ID: <YxB3GWVCNHg5RutQ@hirez.programming.kicks-ass.net>
References: <20220829100959.917169441@infradead.org>
 <20220829101321.905673933@infradead.org>
 <0b8477e2-6e85-b349-0e92-e6a298531c18@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8477e2-6e85-b349-0e92-e6a298531c18@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 09:52:19AM -0400, Liang, Kan wrote:
> 
> 
> On 2022-08-29 6:10 a.m., Peter Zijlstra wrote:
> > Less RDMSR is more better.
> 
> I had an RFC patch which does a further step to move the fixed
> control register write to right before the entire PMU re-enabling, which
> could also save some writes if there are several fixed counters enabled.
> https://lore.kernel.org/lkml/20220804140729.2951259-1-kan.liang@linux.intel.com/
> 
> Do you have any comments for the RFC patch?
> 

Oh, I like that better, let me just replace my patch with that.
