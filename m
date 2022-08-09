Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EE958E3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiHIXx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiHIXxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:53:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15980487
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:53:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660089229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jrOHN1U1qKnc1USHcJnkCBvBpPEAggRR6sgX6Oq23xU=;
        b=kPoVqRP3UDkuegp5e0Fz4RkoFSWPbOWvIfryUzF2vpvdANTCMg6t5JcYltQZOmYOMuL1Lz
        yLv1gpPpoopmyGhMbNBMYGu/AdaZwL3wojUch3yGFYXEWjYmKUJHLFuBIFVMit6Uv+kxLT
        h3IW33IKjme268KKUryrn1kFKBXC81Tp1Ou307xOqrfhGS2RWdMCsWRjQYy6uI/QI+Q3Di
        rk1iq7Pr7jEi7NTW13HMBqGEm74f//2nmlR5gjP/mq/NBYU4np3Qgs+/LHu4IZfV0BHHIw
        iFeCMn2TZBateBkJ2iQKANaeSa8NmZr//CpVDmA8Og1IJ+fxEYQlCORv9/AYrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660089229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jrOHN1U1qKnc1USHcJnkCBvBpPEAggRR6sgX6Oq23xU=;
        b=X8HUFGpOsIiRxq+j6xHaMLYK4imR47XMAulj1f8viUBYfaeNHZxf7RpOCsnPwsz+CQpygd
        BqR4hiuoOSN5BqCw==
To:     Ira Weiny <ira.weiny@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 2/5] entry: Add calls for save/restore auxiliary
 pt_regs
In-Reply-To: <YvLWX4NiqReB5CHB@iweiny-desk3>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-3-ira.weiny@intel.com> <YvJNe2rzXfcogFFX@zn.tnic>
 <YvKpi/CVHko50PNQ@iweiny-desk3> <YvKsS3QuOu4JVzZU@zn.tnic>
 <YvLWX4NiqReB5CHB@iweiny-desk3>
Date:   Wed, 10 Aug 2022 01:53:49 +0200
Message-ID: <87czd9q8he.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09 2022 at 14:49, Ira Weiny wrote:
> On Tue, Aug 09, 2022 at 08:49:47PM +0200, Borislav Petkov wrote:
>> Why does that need to run with instrumentation enabled?
>
> This does not.
>
> Am I wrong that instrumentation begin/end are 0 overhead in production builds?

instrumentation_begin/end() are annotations and never emit executable
code. Neither in production nor in debug builds. Why keep you harping on
this question? Is it so hard to figure out what it does?

But that's not the question at all. The question is where auxregs need
to be set up.

Once the entry code leaves non-instrumentable code it's obviously
desired to have consistent state for instrumentation.

This obviously applies also to the auxreg space unless there is a
compelling reason why this is not required.

Thanks,

        tglx
