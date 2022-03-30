Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE134EBF78
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245720AbiC3LEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245693AbiC3LD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:03:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8EBF501
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+jFj5rr6yQzhbA251iVOAFS94UsGyfyHfTGBlFeCuv4=; b=kd34vxPcIY5/k4shGzvxOs5HDL
        4ZkzOopTzrHxlvjODjHa2gODXf+W7fF2PBI8deixaMu55z+WC9mCS7XR+LVwcrg++j/1VCHZTr9vp
        FVghgHWvZxO8dPh2pQuvazR/tJ7ZjmZVMrCOTREtU/6OdOYga8p84MSFgnKHn9mxQg65225wUjk37
        W5k2JkjplFl3VfkjTGVXVfHtOYg+o9xzZon0kjs1yqocz9WiVcchpgS68ux0lG0jAQkBzUz9Y4DvB
        a3Msl7muJIJ/AG6MbiLFu0U/Uz9Y86FCBK0cq46vyobSDrLb20mI1F6ESou8YRIO5G/EsAZs7hlm3
        JPSlbppQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZW5J-006C5u-AB; Wed, 30 Mar 2022 11:01:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9ED05986215; Wed, 30 Mar 2022 13:01:51 +0200 (CEST)
Date:   Wed, 30 Mar 2022 13:01:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        rafael@kernel.org, ravi.bangoria@amd.com, Sandipan.Das@amd.com
Subject: Re: [PATCH v7 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling
 support
Message-ID: <20220330110151.GJ8939@worktop.programming.kicks-ass.net>
References: <20220322221517.2510440-1-eranian@google.com>
 <20220324145902.GG8939@worktop.programming.kicks-ass.net>
 <CABPqkBTVFNOW0Y-suYVRjf07aBC41gEw1m4Ym78sR39BRzLDcQ@mail.gmail.com>
 <20220325082855.GL8939@worktop.programming.kicks-ass.net>
 <CABPqkBSNG=kLae6dN9iCuyuMVAvt-n+waW9SL4AfNDCOc3px0A@mail.gmail.com>
 <CABPqkBQ6ZyqSzQyJeNW5GE22V1sygB3zz5JQ45AT1TxMnwWScg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQ6ZyqSzQyJeNW5GE22V1sygB3zz5JQ45AT1TxMnwWScg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 04:47:52PM -0700, Stephane Eranian wrote:
> False alarm. I had not forced the config option. With the config
> option enabled, it works as expected.

Great!

> I just found a minor issue in case BRS is not enabled. To be
> consistent, we should do:
> 
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1265,7 +1265,7 @@ static inline s64 amd_brs_adjust_period(s64 period)
>  #else
>  static inline int amd_brs_init(void)
>  {
> -       return 0;
> +       return -EOPNOTSUPP;
>  }

Done!
