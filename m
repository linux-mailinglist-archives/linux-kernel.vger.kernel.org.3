Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF6B51E11C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444483AbiEFVfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355056AbiEFVfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:35:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEABF5B8A8
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 14:31:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651872716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5YNXQOpOKXFVRz3iHvR1oAhEwQUbYYWJsKq1pUtVwd8=;
        b=A49620i7PRera+mhe1BweZ6Vv1Q3trFfvTBAN/4Kjrnu3jQc1o9ibi6TM3bHEk90av0atW
        t9hqMpAcGdW4SbUyZKmSOSd+YlbwGKNdD6WfYWTyEzICdgkDD0w9sM4vLp4oY9i0+I5D/s
        dNOmLMo8e7yKP2U1yZBOHkPKvDaLhKvj9DxFUsSN8bABxScYUK6yIdXlqeFsbRDt+wk7c4
        kvHyI7hjY2t5z2YVBVNHsqYSKqGW+DG2/TPqmSbklG7oUZCmxm5l3r7wnnk6rIfkS8A7Va
        sguCM4GL4nhWAwPbS2G9vdH00Fudh92BSslQrn7pJwyRBDGSW9Q3cY47KyfFoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651872716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5YNXQOpOKXFVRz3iHvR1oAhEwQUbYYWJsKq1pUtVwd8=;
        b=3yzJVIl7aCbWJSTq+FwrDzYos2+d1FJ1UOnv4pyL8gSCEpD/WyUdjoYCOlOsOeDopNjtU5
        7RCkeX440NM7qOAg==
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
Subject: Re: [PATCH v6 13/29] iommu/amd: Compose MSI messages for NMI irqs
 in non-IR format
In-Reply-To: <20220506000008.30892-14-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-14-ricardo.neri-calderon@linux.intel.com>
Date:   Fri, 06 May 2022 23:31:56 +0200
Message-ID: <87r156fiur.ffs@tglx>
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
> +	 *
> +	 * Also, NMIs do not have an associated vector. No need for cleanup.

They have a vector and what the heck is this cleanup comment for here?
There is nothing cleanup alike anywhere near.

Adding confusing comments is worse than adding no comments at all.

Thanks,

        tglx
