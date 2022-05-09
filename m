Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE6851FEF5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiEIODo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbiEIODg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:03:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB9716D5CC
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:59:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652104781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDSynU42H0ANPTpjgbswkYJXVZufPOPf8nzkhHqjA9g=;
        b=vmKUlABhaBvEYz0X9LA3g5SRs3q6NK9pjEq5HDfdrkv8DNhJiu+xhSkMA6zdgQEprlDzCg
        uQWR46Hiz1n5Y0hzLAPihWXSh1PrxlSYk2hsuQTYX1OFGec+wVrZGK7qp4we6RqTX+Qakh
        BSagp92ogKOfiZ4quMyZMILbTxMIr02LfddqQvQLeX/k6xcU1kjTJJJN9L3wNd+67mHM8m
        16UrGlt5n8Yz3RlqdYJT1GHL7F4HJ3T/aHL+iOWbDqGgRE84ihDkeISbp4UTxCINqutLyz
        0i120YG1QFJBnP0HMncXXV9Af4R86Xe56Ls8BflDNQUL6C1XIO8Zsz+kiLneKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652104781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDSynU42H0ANPTpjgbswkYJXVZufPOPf8nzkhHqjA9g=;
        b=VlTE3d1mTqdZW3KhBs4KorVfZhqO0/Xdh68Ua4w6Qxm6hC/qsLC7dU9afDjI28gB3NaJhD
        xlvkhK2X24Pr7XCw==
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
Subject: Re: [PATCH v6 21/29] x86/nmi: Add an NMI_WATCHDOG NMI handler category
In-Reply-To: <20220506000008.30892-22-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-22-ricardo.neri-calderon@linux.intel.com>
Date:   Mon, 09 May 2022 15:59:40 +0200
Message-ID: <87a6bqrelv.ffs@tglx>
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

On Thu, May 05 2022 at 17:00, Ricardo Neri wrote:
> Add a NMI_WATCHDOG as a new category of NMI handler. This new category
> is to be used with the HPET-based hardlockup detector. This detector
> does not have a direct way of checking if the HPET timer is the source of
> the NMI. Instead, it indirectly estimates it using the time-stamp counter.
>
> Therefore, we may have false-positives in case another NMI occurs within
> the estimated time window. For this reason, we want the handler of the
> detector to be called after all the NMI_LOCAL handlers. A simple way
> of achieving this with a new NMI handler category.
>
> @@ -379,6 +385,10 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
>  	}
>  	raw_spin_unlock(&nmi_reason_lock);
>  
> +	handled = nmi_handle(NMI_WATCHDOG, regs);
> +	if (handled == NMI_HANDLED)
> +		goto out;
> +

How is this supposed to work reliably?

If perf is active and the HPET NMI and the perf NMI come in around the
same time, then nmi_handle(LOCAL) can swallow the NMI and the watchdog
won't be checked. Because MSI is strictly edge and the message is only
sent once, this can result in a stale watchdog, no?

Thanks,

        tglx



