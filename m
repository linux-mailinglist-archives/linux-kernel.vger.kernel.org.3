Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9A8526FFA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 10:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiENIRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 04:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiENIRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 04:17:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E879A
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 01:17:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652516259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ptxkYIfclqy5O/gMkPytM7FecBAPXApyhBHx/s6t5+k=;
        b=cHjQpeFhBi4mMqPWUFdjjdKbCNxSUbeCTq7e9TuG54QoSwZllWwAyWn/VA2bxfbp8FS79W
        lpKpONGN1xhSlu8/eUzJRYbZ8z2/7An4yFUXSfE69IHtfw3wF6lHivRNX1/x1EP43Mxg+m
        2YzOH1KhXwKXiNv80jZNKNSgxmxnjKjeDjsWmZo7PZev0MONnAMymFNV4PW0L08JGwT5Dg
        XeCV5Hvab1ALlurGE9Sq5nyeVvDP0baDIxSjf5ud747JWKgjVTe0VrA/BAmffaTatkL5Fl
        PsToyX+G9Z4WITvp+Bj9egqL+hjA9Kgbm3/OPtSDBuAAsUQm8y4Dgg3PUukvnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652516259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ptxkYIfclqy5O/gMkPytM7FecBAPXApyhBHx/s6t5+k=;
        b=4QyQkuDjHvg4QNWDVHeMxsVLfTUC/+wKMBTajewFUyM/io2iH9gFUIPw+ugISd8SAFk2b1
        J7VmY4C7MwqIN+Bg==
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/29] x86/hpet: Add helper function
 hpet_set_comparator_periodic()
In-Reply-To: <20220513211944.GE22683@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
 <87mtfufifa.ffs@tglx> <20220513211944.GE22683@ranerica-svr.sc.intel.com>
Date:   Sat, 14 May 2022 10:17:38 +0200
Message-ID: <87pmkgsf31.ffs@tglx>
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

On Fri, May 13 2022 at 14:19, Ricardo Neri wrote:
> On Fri, May 06, 2022 at 11:41:13PM +0200, Thomas Gleixner wrote:
>> The argument about not bloating the code
>> with an "obvious???" function which is quite small is slightly beyond my
>> comprehension level.
>
> That obvious function would look like this:
>
> void hpet_set_comparator_one_shot(int channel, u32 delta)
> {
> 	u32 count;
>
> 	count = hpet_readl(HPET_COUNTER);
> 	count += delta;
> 	hpet_writel(count, HPET_Tn_CMP(channel));
> }

This function only works reliably when the delta is large. See
hpet_clkevt_set_next_event().

Thanks,

        tglx
