Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3245950FD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350053AbiDZMm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350022AbiDZMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:42:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2E71773C0;
        Tue, 26 Apr 2022 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UgkxP6AMfnaAWLQABV2a9gqxkUf3RZZ7Bpg1ZSLjFy8=; b=AWBZ9Ezn9EEeNgu1/KnwmLjXko
        yb5HjsfLMUe0EgqI6u4af4kjFMFIcitq92LFPJdg9xsjZn4Bhzu2mdSADx2d/v2pTOiFySJB1I5Zg
        UZxbJhVXYzIGEuK6pTHJ3l9QZRrLDZUHiks7NWSrxPXJzxAD0HBNhbSdG1JxT3G7IJ8/HrmbOd2EB
        SZYukMFZhT7BlVg2S8TV8eVa3gCWKzmOfVyOXF1TGuLQwxBf0x6wPdlRCz53BTozzxmjgQ9Rgi1zL
        IMkSfI8uD7DHkU2YRGguKmgWDmFUddCQ9WRdzru1H4PvSh/wu8oZfyq5RVDB7L1s3buD/gKFqSQDx
        8dtIgOtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njKTW-009dLL-BW; Tue, 26 Apr 2022 12:39:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94F4030093A;
        Tue, 26 Apr 2022 14:39:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F9362029F9FF; Tue, 26 Apr 2022 14:39:24 +0200 (CEST)
Date:   Tue, 26 Apr 2022 14:39:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wen Pu <puwen@hygon.cn>
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "like.xu.linux@gmail.com" <like.xu.linux@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
        "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
        "santosh.shukla@amd.com" <santosh.shukla@amd.com>
Subject: Re: [PATCH v2 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
Message-ID: <Ymfn/Fw4AoOHnoNF@hirez.programming.kicks-ass.net>
References: <cover.1650515382.git.sandipan.das@amd.com>
 <54bc7fe4cadf6bdef823bab1fba43d4891d2e1a9.1650515382.git.sandipan.das@amd.com>
 <20220426081550.GO2731@worktop.programming.kicks-ass.net>
 <9e6d14a0-a658-195c-c7a3-7d2687a61544@amd.com>
 <25e89d27-d7da-2dea-dd20-0a9d8dcdee83@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25e89d27-d7da-2dea-dd20-0a9d8dcdee83@hygon.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:45:32AM +0000, Wen Pu wrote:

> I have confirmed that Hygon processors do not support CPUID leaf 0xA.
> Sandipan, could you please also add X86_VENDOR_HYGON in the if
> conditional?

Will do, thanks!
