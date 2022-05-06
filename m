Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7240A51E109
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444421AbiEFVaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442687AbiEFVaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:30:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CD063BDB
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:26:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651872383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dnFvEUjYaXkrUWbb6k6bH4W0I42U5bcK4xwKGB/iA1Q=;
        b=TDgZZgVD6IKft2KB8Wjp08EzKo+lWC4nCxQY6ojpI4H1hUj4ZvLjNxRSX0cZajHu50JwKv
        S6eyooGuo8RTT0twSIFJzJRx+0XWf4p4QZoC70idfNUEQKDd4JKeiB38aUfRUgTRSl4Ytx
        J9UOxaYgiNIc/l5TkYWQ0UPuIB3Flgj/r61E4f3wH/jBRPrNNloFPy5HHlEW4paO7xvr6z
        ucwcH/2OmkHFNT49SvK4W47lcG3kv+jtISDCrBMBmB1LotCwdfAjUujREzm87wctSczMFW
        nZOJjp1eDlE3hKYW9r1ilgjBXgjXQm0A1xqVryDZVytZbeicQgcQW+OFBPPMhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651872383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dnFvEUjYaXkrUWbb6k6bH4W0I42U5bcK4xwKGB/iA1Q=;
        b=WcZEnao8xTtQZ0w7qAuY+S/Xb9SfBJExBnOLNsmkdy8OV6SGqwMvfpax3q411PgaPTVg7X
        ZEuh2NASqTIUK4Dw==
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v6 12/29] iommu/amd: Enable NMIPass when allocating an
 NMI irq
In-Reply-To: <20220506000008.30892-13-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-13-ricardo.neri-calderon@linux.intel.com>
Date:   Fri, 06 May 2022 23:26:22 +0200
Message-ID: <87tua2fj41.ffs@tglx>
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
>  
> +	if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
> +		/* Only one IRQ per NMI */
> +		if (nr_irqs != 1)
> +			return -EINVAL;

See previous reply.

