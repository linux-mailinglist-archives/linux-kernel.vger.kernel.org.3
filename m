Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12471526FF2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiENIPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 04:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiENIP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 04:15:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A608297
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 01:15:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652516125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHF9WVJF89fHPJq0+8oiweP3wjgNVxTMSM/vRu60nYc=;
        b=Tm0Wc2HrL4EoLv6k4cC472VP8Biprl05MvetpUZPEzW0ctnc4AfNAc9GzrCaDwbUR7asay
        k9meZSHbxU07Wx7caJes3ehRYibTz13rBlObuMSuFk7ZgN3LUGwEFHSwzQDAbs76ml91Iv
        TfrRfjYmgQ6VlChzQQtCqbE57X4yHCjEY/nFJ+u//Q0QW7b86PnnHZ0bks5Z5KNxstDgFB
        8ieqdzZXwb8nQd54BAROxS5Y0qPLEeda5doQcCE+EFzABk7gxmFkNcD+FzEZp8aT5/YOg/
        zBTpa9/aRp4PQD0V/GvzjQhFx5s/3qzmVoPUo4/nyL1Yd+fdRZVYofcuJu1UWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652516125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHF9WVJF89fHPJq0+8oiweP3wjgNVxTMSM/vRu60nYc=;
        b=DQ1ba3l4HOXe/g0FH1Hxfxmq/Jov5eLSl+952ajCcfZuyexUDsvo3a6HGCEtaOgGvBGZVv
        W7XCCMG7O6GU1PCg==
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
Subject: Re: [PATCH v6 05/29] x86/apic/vector: Do not allocate vectors for NMIs
In-Reply-To: <20220513234542.GC9074@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-6-ricardo.neri-calderon@linux.intel.com>
 <87zgjufjrf.ffs@tglx> <20220513180320.GA22683@ranerica-svr.sc.intel.com>
 <87v8u9rwce.ffs@tglx> <20220513234542.GC9074@ranerica-svr.sc.intel.com>
Date:   Sat, 14 May 2022 10:15:24 +0200
Message-ID: <87sfpcsf6r.ffs@tglx>
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

On Fri, May 13 2022 at 16:45, Ricardo Neri wrote:
> On Fri, May 13, 2022 at 10:50:09PM +0200, Thomas Gleixner wrote:
>> > Also, if lapic_nmi_controller.irq_set_affinity() is NULL, then irq_chips
>> > INTEL-IR, AMD-IR, those using msi_domain_set_affinity() need to check for NULL.
>> > They currently unconditionally call the parent irq_chip's irq_set_affinity().
>> > I see that there is a irq_chip_set_affinity_parent() function. Perhaps it can
>> > be used for this check?
>> 
>> Yes, this lacks obviously a NMI specific set_affinity callback and this
>> can be very trivial and does not have any of the complexity of interrupt
>> affinity assignment. First online CPU in the mask with a fallback to any
>> online CPU.
>
> Why would we need a fallback to any online CPU? Shouldn't it fail if it cannot
> find an online CPU in the mask?

Might as well fail. Let me think about it.

>> I did not claim that this is complete. This was for illustration.
>
> In the reworked patch, may I add a Co-developed-by with your name and your SOB?

Suggested-by is good enough.

Thanks,

        tglx
