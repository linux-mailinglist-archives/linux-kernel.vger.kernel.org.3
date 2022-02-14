Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCE64B5865
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357025AbiBNRYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:24:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiBNRYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:24:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B244652DE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:23:57 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644859435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d1o25gj0Q/pp9DqFCFKZq8sPPIEkmpv/ZWAOVwPqZ78=;
        b=FxBkfG5SpY54hfO5mDqy+1Z87DlSpfiiv4x2bYaRw8x5L+9YwvfqpIKGDOLMD+3SSHSiob
        RcKOImGYf+gNiUDlMIa5CZdRyGSBtKAo3gWp7xEVJL5lI8kOoKC2SRxLYmmbmHtjLn6C6G
        H2Le+8BSvohX7pK4fz7b8tW3ut6fpcLK7o0vm9QUFEv4FLhVfXYTjRFrgYThCGSSLgV1Wg
        zl4YaVVt87I4RooYsnDSKijmfGiy+Pu513WngKWrTx5xiAWWjzEf99n4IpVuYYdxCXAJ5M
        X+RvPVfwf1DHUA5pJMFOh1EJYaQjjfKcqZyvOneadFcHGfSIbtKq/3+DCqb5sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644859435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d1o25gj0Q/pp9DqFCFKZq8sPPIEkmpv/ZWAOVwPqZ78=;
        b=x0jfrvJ2Ui8x+bWKo2Eq0MJes/8k37hz73YSpXorf7YsZ7Hm27JRj6iVBmPfkP5LFGsDqU
        +Kj99zAWGSqnhQAg==
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v4 04/11] kernel/fork: Initialize mm's PASID
In-Reply-To: <20220207230254.3342514-5-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-5-fenghua.yu@intel.com>
Date:   Mon, 14 Feb 2022 18:23:54 +0100
Message-ID: <87v8xhqs45.ffs@tglx>
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

On Mon, Feb 07 2022 at 15:02, Fenghua Yu wrote:

> A new mm doesn't have a PASID yet when it's created. Initialize
> the mm's PASID on fork() or for init_mm to INVALID_IOASID (-1).
>
> INIT_PASID (0) is reserved for kernel legacy DMA PASID. It cannot be
> allocated to a user process. Initializing the process's PASID to 0 may
> cause confusion that why the process uses the reserved kernel legacy DMA
> PASID. Initializing the PASID to INVALID_IOASID (-1) explicitly
> tells the process doesn't have a valid PASID yet.
>
> Even though the only user of mm_pasid_init() is in fork.c, define it
> in <linux/sched/mm.h> as the first of three mm/pasid life cycle
> functions (init/set/drop) to keep these all together.
>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
