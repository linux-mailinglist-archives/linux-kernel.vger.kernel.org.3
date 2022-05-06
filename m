Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E4C51DFEC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391291AbiEFUJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352661AbiEFUJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:09:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D24913E9D
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:05:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651867535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVppxWloPHGJWVXPfoL2Mp1gCDmCbq5jYvkOUctTPwE=;
        b=zS7mT4GOFbktfGjTiNzsOezexuL61fgcFzjZlZAaPH7GPyJ2Q7bJAFEDsyscoPuCfFVQXy
        MQv9fxTolSCsKtYLSyZInAmifCbsge2rcmwRurq4fs6letvqkFnJbaTyhjCsRTPV60X6uE
        rinuSxovZT2eQZmTTINCqVtTXoHEFIdOgI1zfPR/KL1VUfVwn2fIFHM766ozhigodnfH5s
        jReDujbvbA2//EkDSTXQNLuOihMxNNQNvdzlCmWip8r6V8GGcekFaYq43MM8Slzjs9F8uF
        PGtWQGOFlmpNWcrTP2AzpuqH8ZoMSNTnNEko3cwpIKeOk6ve9AbhRkGjDS/MIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651867535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVppxWloPHGJWVXPfoL2Mp1gCDmCbq5jYvkOUctTPwE=;
        b=5wkuYkNHIkwqACUXoQDb2h1xfBOD4wVbdnhxKNW06YuXNMEFHsj/QnO9X2mOg3FHRYYiy1
        G0NPRPNdhl+hS1AA==
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
Subject: Re: [PATCH v6 03/29] x86/apic/msi: Set the delivery mode
 individually for each IRQ
In-Reply-To: <20220506000008.30892-4-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-4-ricardo.neri-calderon@linux.intel.com>
Date:   Fri, 06 May 2022 22:05:34 +0200
Message-ID: <8735hmh1f5.ffs@tglx>
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
> There are no restrictions in hardware to set  MSI messages with its
> own delivery mode.

"messages with its own" ? Plural/singular confusion.

> Use the mode specified in the provided IRQ hardware
> configuration data. Since most of the IRQs are configured to use the
> delivery mode of the APIC driver in use (set in all of them to
> APIC_DELIVERY_MODE_FIXED), the only functional changes are where
> IRQs are configured to use a specific delivery mode.

This does not parse. There are no functional changes due to this patch
and there is no point talking about functional changes in subsequent
patches here.

> Changing the utility function __irq_msi_compose_msg() takes care of
> implementing the change in the in the local APIC, PCI-MSI, and DMAR-MSI

in the in the

> irq_chips.
>
> The IO-APIC irq_chip configures the entries in the interrupt redirection
> table using the delivery mode specified in the corresponding MSI message.
> Since the MSI message is composed by a higher irq_chip in the hierarchy,
> it does not need to be updated.

The point is that updating __irq_msi_compose_msg() covers _all_ MSI
consumers including IO-APIC.

I had to read that changelog 3 times to make sense of it. Something like
this perhaps:

  "x86/apic/msi: Use the delivery mode from irq_cfg for message composition

   irq_cfg provides a delivery mode for each interrupt. Use it instead
   of the hardcoded APIC_DELIVERY_MODE_FIXED. This allows to compose
   messages for NMI delivery mode which is required to implement a HPET
   based NMI watchdog.

   No functional change as the default delivery mode is set to
   APIC_DELIVERY_MODE_FIXED."

Thanks,

        tglx
