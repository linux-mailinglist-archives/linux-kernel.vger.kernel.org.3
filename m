Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529AA4F0B45
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349759AbiDCQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiDCQjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:39:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DDE1401C;
        Sun,  3 Apr 2022 09:37:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649003861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eS+UiMhA8iNM6xa0w2K4AD9ghFBWI8GSz6jHOKEqkHs=;
        b=GVgZC5UJw/g4D+6k+FOVt826rgBPkHy6UWjV/T2XcE3bkgl1ijRsd1lx/dWwDzY1lue5pN
        yTs5bFL+wMYed0AysYWtK8Tq9k3gl3l080/wgjBerz8QajfZzLsDh/KvkzTXnqUlUNoEHv
        E/TkuFPQPdZNWpwuyxw6ZCp+4Tt02ZxYue7FVRMVCeQ5eEK1J74hxBwkvz8vymwI4dgNfQ
        oWVz2dJoYRVb0wUwH4lEhHrxi/Nv9cAT+VSjsuZhqZcCcoTFF+Zr+kdDZ1+xZU1kzfsddO
        LrUSeTFyuLBmgUSS+GeTs+i3lJJN4sWkr2vrvqSfgfxxr3qPIxIGdNCJRdqWog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649003861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eS+UiMhA8iNM6xa0w2K4AD9ghFBWI8GSz6jHOKEqkHs=;
        b=fNACQNkKyMDVclM89e5Xk72Ur5ULilHWF3O8aUr7zcowwB0cjZvboSRXA0EKgUnPQ3nIfI
        wZ9e+yVMRSn5kSBQ==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, peterz@infradead.org, bp@alien8.de,
        rafael@kernel.org, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v3 2/3] x86/fpu: Add a helper to prepare AMX state for
 low-power CPU idle
In-Reply-To: <20220325022219.829-3-chang.seok.bae@intel.com>
References: <20220325022219.829-1-chang.seok.bae@intel.com>
 <20220325022219.829-3-chang.seok.bae@intel.com>
Date:   Sun, 03 Apr 2022 18:37:40 +0200
Message-ID: <8735ium8bv.ffs@tglx>
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

On Thu, Mar 24 2022 at 19:22, Chang S. Bae wrote:
> When a CPU enters an idle state, non-initialized states left in large
> registers may be the cause of preventing deeper low-power states.
>
> The new helper ensures the AMX state is initialized to make the CPU
> ready for low-power states. It will be used by the intel idle driver.

What about AVX...AVX512? Are they harmless in that regard?

If so, then the first sentence above is confusing and should clearly
spell out that it's AMX which causes that problem.

In not, then why are we not putting them into init too?

Thanks,

        tglx
