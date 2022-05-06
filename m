Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5344951DFCE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391912AbiEFTwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242556AbiEFTwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:52:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E264B40A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 12:48:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651866508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=obKDPm1us147PjbB0DX4AOLNMPgBymj9mmgDJjujsNQ=;
        b=HioOdTsoFc6QL4Q5ukxv+Ntea8dHeHBk4X2FT+oa3bbwVlhaaalijyMz3Ud42vI0Xz+Pm5
        5uNcxKXmjg9OVSDh0Dt4tYZQOtxWfVFjjhHrSpCQezPQxTgdp4FY13dtV9rXwDevFIpXv6
        muaKmsTE1yrW4JvMj8a2VNOKwIw/8hiF4TH9d66KAra9PGXIcwgS+d6jJ9pIjFAO9TVsmJ
        7WIXTpeAKzbt2/hokUTls/YOcFf5INx190TqnegdhNw+Iz7enysvt7LGD9aYjh0IdLT2O1
        F9KOHoFhYxx5YN++nCtmpnJKTcTtL7nhOGwRsnjxvDLfRK1XRQCtPb9oaZBu4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651866508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=obKDPm1us147PjbB0DX4AOLNMPgBymj9mmgDJjujsNQ=;
        b=PhVvmh62AnNYLXZZs9XTvL0zSLIZOMjOmiHCiiYPPKnVJ9DouHuXu7vrlN828CvNAlUl2q
        /dCD5SBWUsoH+LDA==
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
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
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v6 01/29] irq/matrix: Expose functions to allocate the
 best CPU for new vectors
In-Reply-To: <20220506000008.30892-2-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-2-ricardo.neri-calderon@linux.intel.com>
Date:   Fri, 06 May 2022 21:48:28 +0200
Message-ID: <878rreh27n.ffs@tglx>
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

Ricardo,

On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> Certain types of interrupts, such as NMI, do not have an associated vector.
> They, however, target specific CPUs. Thus, when assigning the destination
> CPU, it is beneficial to select the one with the lowest number of
> vectors.

Why is that beneficial especially in the context of a NMI watchdog which
then broadcasts the NMI to all other CPUs?

That's wishful thinking perhaps, but I don't see any benefit at all.

> Prepend the functions matrix_find_best_cpu_managed() and
> matrix_find_best_cpu_managed()

The same function prepended twice becomes two functions :)

> with the irq_ prefix and expose them for
> IRQ controllers to use when allocating and activating vector-less IRQs.

There is no such thing like a vectorless IRQ. NMIs have a vector. Can we
please describe facts and not pulled out of thin air concepts which do
not exist?

Thanks,

        tglx
