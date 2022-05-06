Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C09E51E165
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444581AbiEFVzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355406AbiEFVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:55:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007F16FA20
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:51:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651873913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJ3McpVzRFsgMBX23wgT/+qwHu2rZPiW0v6oIUJCIkI=;
        b=igj0qkwuwc7TJty88qJFZzgeFNtRFh7UFPJIoYtA35jxy2m3y6o5O4BdduJ2eTQP9yoEOj
        Y/Pma7uZ5nWvIQhbGPHLJmY6SG3i1CJVChRqzHb1xg1wCqo9z7wxEHAXtt5f9+bWp12aKl
        yxCDDHDVcTytIFMWLuivfqlaAY9rBazDQQyIjF1A+y1F0wqODasPHnEJyRNpLJt15J6YsH
        E5X1+fUKoagpdADMaiiKzhZbUA2CMwr6sDFvgkwLGqIpuqPfaj+XgnRcnoX0GKhhe7+t9y
        p/OQVpvdQapJpV5hYP5MRwR5/f2imVDr8Suxn6wvt2CDlZBIK6rpU9RNXp1y6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651873913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJ3McpVzRFsgMBX23wgT/+qwHu2rZPiW0v6oIUJCIkI=;
        b=JhebiFX5xqgDI1pfgNQ3AdRq6c3Eu2eESoBA4srTY5Ncp8q55tWwCzdaaNdIoRN0NdxHUo
        pfYq18JFAjczX9Dg==
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
Subject: Re: [PATCH v6 15/29] x86/hpet: Add helper function
 hpet_set_comparator_periodic()
In-Reply-To: <87mtfufifa.ffs@tglx>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
 <87mtfufifa.ffs@tglx>
Date:   Fri, 06 May 2022 23:51:52 +0200
Message-ID: <87ilqifhxj.ffs@tglx>
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

On Fri, May 06 2022 at 23:41, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
>> Programming an HPET channel as periodic requires setting the
>> HPET_TN_SETVAL bit in the channel configuration. Plus, the comparator
>> register must be written twice (once for the comparator value and once for
>> the periodic value). Since this programming might be needed in several
>> places (e.g., the HPET clocksource and the HPET-based hardlockup detector),
>> add a helper function for this purpose.
>>
>> A helper function hpet_set_comparator_oneshot() could also be implemented.
>> However, such function would only program the comparator register and the
>> function would be quite small. Hence, it is better to not bloat the code
>> with such an obvious function.
>
> This word salad above does not provide a single reason why the periodic
> programming function is required and better suited for the NMI watchdog
> case and then goes on and blurbs about why a function which is not
> required is not implemented. The argument about not bloating the code
> with an "obvious???" function which is quite small is slightly beyond my
> comprehension level.

What's even more uncomprehensible is that the patch which actually sets
up that NMI watchdog cruft has:

> +       if (hc->boot_cfg & HPET_TN_PERIODIC_CAP)
> +               hld_data->has_periodic = true;

So how the heck does that work with a HPET which does not support
periodic mode?

That watchdog muck will still happily invoke that set periodic function
in the hope that it works by chance?

Thanks,

        tglx
