Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00A4B586D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357042AbiBNRYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:24:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiBNRYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:24:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F0652EF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:24:41 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644859480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kA70/BPufwIFD+QWkWEZYMJvcssYHGwiSjUsZ3KLlEs=;
        b=eUn2vcLrQBcjtPtLYnzSg3MVFxReID3dSowCi2S/RCkhhYKB1Xh2GNzY1dz+T/MdGEX4F3
        CQnqjyZiPLQiJfvnPlI5joF/r0ocuCnw3TxaTkKUFGgCmasx5aoQQ40zWnSPdw3wDjKYE5
        ljgSPQ7ScF6H6hGr3MxTrYLtvWxw+/Iggtb/iGFSLL+yeFxXWqFRJTbaUi15kamKZleZuI
        ZMhzTW7G9qZM16yOSekuliNmh+SSdzLgywaOnzmz1WhKAr8wB1PcTSLsVwrkpQwO/wfVi9
        nDMS6kUxDB1/0yjqH1zr3o9YSeiS/orCE1aOxug2/UsLPAnZ5o1V+ccfDljLow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644859480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kA70/BPufwIFD+QWkWEZYMJvcssYHGwiSjUsZ3KLlEs=;
        b=5rLS96djUHvk6cd2KmGq84zNkFHTKuMhbrsdvfp72s+BFzWbABl5PKvYjJWod5ckJVpJsE
        YILVINJrsg2eH4Dg==
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
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <20220207230254.3342514-6-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
Date:   Mon, 14 Feb 2022 18:24:39 +0100
Message-ID: <87sfslqs2w.ffs@tglx>
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

> PASIDs are process wide. It was attempted to use refcounted PASIDs to
> free them when the last thread drops the refcount. This turned out to
> be complex and error prone. Given the fact that the PASID space is 20
> bits, which allows up to 1M processes to have a PASID associated
> concurrently, PASID resource exhaustion is not a realistic concern.
>
> Therefore it was decided to simplify the approach and stick with lazy
> on demand PASID allocation, but drop the eager free approach and make
> a allocated PASID lifetime bound to the life time of the process.
>
> Get rid of the refcounting mechanisms and replace/rename the interfaces
> to reflect this new approach.
>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
