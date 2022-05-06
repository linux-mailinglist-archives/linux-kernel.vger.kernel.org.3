Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDD351E104
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444413AbiEFV1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245548AbiEFV1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:27:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17A86339A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:23:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651872204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Qt7CUp/pjOXetxeeCEQTHQJVA1rcx9ZBnwtcdpqF+0=;
        b=1gitIq8FJN+a0xsKA2F9S/IkXhuehmIu/V1V6fDWUg4SgYJ6GNR70nqfi6IKrkT0vv4Yae
        ZCuqm/hYF1OxK74tQBPRc0TS/NELz45bgd73c1EXtOB7GCDM8SKQ7JiVY/gGbu0/kBholF
        JCPN0OvDqROnL3mfI+OVoJn1DJwxkm1w/Y3xe4jMDPcQgffkYct2evhH90bBtQYroQhHVQ
        9i8FfLmF9G8vaSrdByk6xcyydCReNyG8txnHNUi2JYzjXsYbUvxSIRC6g/Zy35cqfeWuEr
        XMxMC6wWl98ijxGTdbdsJG7bZbtwAoS6+gKor1KCGSBIS1sDipmE+IsdzaWeTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651872204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Qt7CUp/pjOXetxeeCEQTHQJVA1rcx9ZBnwtcdpqF+0=;
        b=kbgZs5IojxdNYid2PCX/up8UYQ0YquDeCHiNJom3jcEaJQf4cp68zTUaibdsa1SEQ7jM4L
        U3OxdSYz2NZABvDA==
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
Subject: Re: [PATCH v6 10/29] iommu/vt-d: Implement minor tweaks for NMI irqs
In-Reply-To: <20220506000008.30892-11-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-11-ricardo.neri-calderon@linux.intel.com>
Date:   Fri, 06 May 2022 23:23:23 +0200
Message-ID: <87wneyfj90.ffs@tglx>
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

On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> The Intel IOMMU interrupt remapping driver already programs correctly the
> delivery mode of individual irqs as per their irq_data. Improve handling
> of NMIs. Allow only one irq per NMI. Also, it is not necessary to cleanup
> irq vectors after updating affinity.

Structuring a changelog in paragraphs might make it readable. New lines
exist for a reason.

> NMIs do not have associated vectors.

Again. NMI has an vector associated, but it is not subject to dynamic
vector management.

> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index fb2d71bea98d..791a9331e257 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -1198,8 +1198,12 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  	 * After this point, all the interrupts will start arriving
>  	 * at the new destination. So, time to cleanup the previous
>  	 * vector allocation.
> +	 *
> +	 * Do it only for non-NMI irqs. NMIs don't have associated
> +	 * vectors.

See above.

>  	 */
> -	send_cleanup_vector(cfg);
> +	if (cfg->delivery_mode != APIC_DELIVERY_MODE_NMI)
> +		send_cleanup_vector(cfg);

So this needs to be replicated for all invocations of
send_cleanup_vector(), right? Why can't you put it into that function?
  
>  	return IRQ_SET_MASK_OK_DONE;
>  }
> @@ -1352,6 +1356,9 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
>  	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
>  		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
>  
> +	if ((info->flags & X86_IRQ_ALLOC_AS_NMI) && nr_irqs != 1)
> +		return -EINVAL;

This cannot be reached when the vector allocation domain already
rejected it, but copy & pasta is wonderful and increases the line count.

Thanks,

        tglx


