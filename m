Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABF8527189
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 16:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiENOEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiENOEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 10:04:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C1A13FB4
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 07:04:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652537058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHOIys2lUf5zRjBsSOUOWEZGDpRLn7fWHLTsPdw7f4U=;
        b=LHg9QKXYPrV5G6DpjGAQUj+qfPDVnxCZetHDBfVfH+LeqCXHlJAbKb8WllnreP7S3bNkfN
        4KeQuJ7ASL57SIcHW5e0/ESjXmm27lFLndKPfS7ueia9+AnyVBizDI/I8cVvjyBodAV73C
        KuR6VX1IdjUZkcx7JJgKy1PXR652V3bzFUHb8gWx45QdbM32XdC1pSbLSU5kSVZNHK9CnN
        sYrvtcF6hGd4esjm7UwZp0Jjc3XOn+pTPW63vJAVYDRvjZI2qtcicolrLDuGi3y01KBsGF
        OHVzd6Qv0y0sYGOnTDmWoNHy2dKwZHGvbkDMdo4G48fllgMyGiB+2V0HQQZJAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652537058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHOIys2lUf5zRjBsSOUOWEZGDpRLn7fWHLTsPdw7f4U=;
        b=Wccmxkq4ead+q0uv0ac7dDXkCM4gzRqejs0vLHNPNyx0+CzSuVgKfK7pCPPycJh8YJUxj4
        LicVDTm3UgM/NtDA==
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
Subject: Re: [PATCH v6 22/29] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
In-Reply-To: <20220513221650.GA8691@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-23-ricardo.neri-calderon@linux.intel.com>
 <877d6uref8.ffs@tglx> <20220513221650.GA8691@ranerica-svr.sc.intel.com>
Date:   Sat, 14 May 2022 16:04:17 +0200
Message-ID: <875ym8rz1a.ffs@tglx>
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

On Fri, May 13 2022 at 15:16, Ricardo Neri wrote:
> On Mon, May 09, 2022 at 04:03:39PM +0200, Thomas Gleixner wrote:
>> > +			/* If we are here, IPI shorthands are enabled. */
>> > +			apic->send_IPI_allbutself(NMI_VECTOR);
>> 
>> So if the monitored cpumask is a subset of online CPUs, which is the
>> case when isolation features are enabled, then you still send NMIs to
>> those isolated CPUs. I'm sure the isolation folks will be enthused.
>
> Yes, I acknowledged this limitation in the cover letter. I should also update
> Documentation/admin-guide/lockup-watchdogs.rst.
>
> This patchset proposes the HPET NMI watchdog as an opt-in feature.
>
> Perhaps the limitation might be mitigated by adding a check for non-housekeeping
> and non-monitored CPUs in exc_nmi(). However, that will not eliminate the
> problem of isolated CPUs also getting the NMI.

Right. It's a mess...
