Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB248C801
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354998AbiALQPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354996AbiALQOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:14:24 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0177C061751
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 08:14:23 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p14so4751237plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 08:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QzWQq20E27Vzi9uGpH2lyjhZH6GcnE726DILtQYXDnE=;
        b=G/Epxa6o/cF1a+I2JjaNLnOmIgaTpu1NN8e6Ri5Wjq+agl3MQR9pjQl/ks7k/66qfV
         SojtVBThpbU8yW4XtKCwhkZa7kap4QshbtWtv96Q/JCUofc35laLQIPTsEOY8xJhLiJe
         B046CcEAaOrOKfeqMermxm1+ML9L4IcB16l4E5L3I9Z788mreifsY8Mv+xXf3NQIkZGB
         jY03lWKPW4dXq0oAIXlb0OnXHg150iPp+Bph/88YX4Ri9e2+7SDq6PSECqfIPaxVg1gh
         QdNyJMbT23/WNcRsVhM/BkA2YC5X41DbAi6H7pkRCFSgWVyAk7w9o0vAyssrn01ypmlq
         +6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QzWQq20E27Vzi9uGpH2lyjhZH6GcnE726DILtQYXDnE=;
        b=22svBP8RKrTBCuBLkNucMgHbpPYvWyIZN2kdWXee7OzI3IRE5Qx7cHoYDhxiiiaRgk
         QrAl2Yyl8F3kKqrDStZsgQpXfIwcAJChbBV1UjeWHYef2XRtd8ieN0yxrDEN8jWdOhvh
         dRKilAPNaHuvCuX5cSYODUQddJnc3bi74T1igOtVkzl/tj7fBDQnPj9o1G8tzv3VSrlW
         yLxxQeU4858r3U8UfsvaSESdfuiz9W7o8DSmsH1uvDWUzgCBDzdL+7lzIgr7bJSutr+v
         VRbmxz6qedETU5LZLLQesZBgY43+qqgXTR6I5q657C2AsRol/+2qqIaVTkZKwn2KFUu0
         wzpw==
X-Gm-Message-State: AOAM531oosxoNn5NtRMIRZutjukvNAnnHxPlJBgLZ2AwqqsgPFq0MSjx
        eLGwLhnbIiH8GtMy1DFWaBXllg==
X-Google-Smtp-Source: ABdhPJyilz9gDJSj+JPNs0NJORi1Cw+A9gLTls0R5lSDAL+XwGTrZERgTMg+z12MUL1iCuICvb2Tng==
X-Received: by 2002:a17:903:41c1:b0:14a:695a:f372 with SMTP id u1-20020a17090341c100b0014a695af372mr354767ple.166.1642004063214;
        Wed, 12 Jan 2022 08:14:23 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g22sm104235pfc.130.2022.01.12.08.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 08:14:22 -0800 (PST)
Date:   Wed, 12 Jan 2022 16:14:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [x86/entry_32]  aa93e2ad74:
 BUG:soft_lockup-CPU##stuck_for#s![systemd-logind:#]
Message-ID: <Yd7+W1gFbkBs5Lkd@google.com>
References: <20220106083523.GB32167@xsang-OptiPlex-9020>
 <Yd1l0gInc4zRcnt/@hirez.programming.kicks-ass.net>
 <Yd4u2rVVSdpEpwwM@google.com>
 <Yd6ssarpDknV1r9z@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd6ssarpDknV1r9z@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022, Peter Zijlstra wrote:
> On Wed, Jan 12, 2022 at 01:28:58AM +0000, Sean Christopherson wrote:
> > The issue is that PARANOID_EXIT_TO_KERNEL_MODE in the handle_exception_return
> > path overwrites the entry stack data with the task stack data, restoring the "bad"
> > segment value.
> 
> Oh gawd... that's terrible, and yes, that now makes perfect sense.
> 
> However did you find that?

printf and running under QEMU, which has a interactive "monitor" that lets you
read/write guest memory and can also do VA=>PA translations.  Code inspection
once I realized the value on the stack was being restored between the exception
fixup and the POP.
