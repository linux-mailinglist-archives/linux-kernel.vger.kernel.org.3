Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F90E5764CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiGOP6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGOP6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:58:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC56E65D4D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:58:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso11943549pjc.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xsKYhSLwsE8/SUXFxlsoQGizq/ndscv+1fEJX7G56IY=;
        b=WcGQ3p99TKasjnSfcWoBHd0IlimUMNYF7oGcVhFYwjkB1bYUS8HG3RfUQo9rksrGYI
         vmegpOSM1MfpWMTrkTNxNzAZT0+AiprGuV7mAdN0unBZI4+NN244skhoiJSAXDl4C7fJ
         8T5Mw6gZtDzLfE75JYN817ArQfyivhjWJ3pScPwPOEsqURQES0odQuxCNJxwKG4Bmke5
         j9O9SG72ZogYopzZnJrobPJot83KAwCreHM6aRrrQkCZ9EfFPYj16Lc7PiZKer59xpVg
         pR51RMvs8vIbYPzYWRqeSLJVnQHAznii+MgM2Rf+mIJX4WgmHw1pw8F9TVtyKw1a+NkM
         mXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xsKYhSLwsE8/SUXFxlsoQGizq/ndscv+1fEJX7G56IY=;
        b=fa9xoxNK9aWaoDlmfgm/3EqQ3qJy9P+9CVjQxTYf8F8+boIUOPnZW7VxP+JeYh4G3l
         MfUaBL71cHgt2/JUB18MWocMA6UlpuykrfhVGn5fA0YLziC1ExjhPhffjCwT9bAQD3jr
         snYzYSRIU1gbBKAd9UZlCZTfzaTORvuNQgDgfn9Xu6nS0wC9BU9xHPBNQtFngJAdCOvg
         u5iU1aA+mge7zG0nyGi7fGJaMiJ9AbiCF+jiqMJ92MIo+nDO2CN32jyvnwlY82k5ygj1
         wWmZJ7EJohwwiU2ZxucDGCS7rqEFK/l7BpHMRzAH9u8YGgZfiMyqLQkADO3ZDE04qP74
         dEUA==
X-Gm-Message-State: AJIora/+4Pv5NywREs6F+48HY0QPvLU7V5ZeH6rO8LcOxCXg5dilrbki
        mVuBvDZoGXJe3iyZ/GV/ZKUl/g==
X-Google-Smtp-Source: AGRyM1tqzKoamzwlhHnc+IM9pZxIoOzEVydP45L6Isk2EsXkeVmHXci+zPyFL6vkZ7f5VwiGiuTyYA==
X-Received: by 2002:a17:90b:341:b0:1e0:cf43:df4f with SMTP id fh1-20020a17090b034100b001e0cf43df4fmr16491919pjb.126.1657900700196;
        Fri, 15 Jul 2022 08:58:20 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id k2-20020a170902ce0200b0016c09e23b18sm3676427plg.154.2022.07.15.08.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 08:58:19 -0700 (PDT)
Date:   Fri, 15 Jul 2022 15:58:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH 00/19] Refresh queued CET virtualization series
Message-ID: <YtGOmEeMW1BbC3Ne@google.com>
References: <20220616084643.19564-1-weijiang.yang@intel.com>
 <YqsB9upUystxvl+d@hirez.programming.kicks-ass.net>
 <62d4f7f0-e7b2-83ad-a2c7-a90153129da2@redhat.com>
 <Yqs7qjjbqxpw62B/@hirez.programming.kicks-ass.net>
 <8a38488d-fb6e-72f9-3529-b098a97d8c97@redhat.com>
 <2855f8a9-1f77-0265-f02c-b7d584bd8990@intel.com>
 <YtBwRIiZi262hHiE@google.com>
 <950988cd-708c-af25-9d0e-47062aded504@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <950988cd-708c-af25-9d0e-47062aded504@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022, Yang, Weijiang wrote:
> 
> On 7/15/2022 3:36 AM, Sean Christopherson wrote:
> > It's definitely uncommon; unless I'm forgetting features, LA57 is the only feature
> > that KVM fully virtualizes (as opposed to emulates in software) without requiring
> > host enablement.  Ah, and good ol' MPX, which is probably the best prior are since
> > it shares the same XSAVE+VMCS for user+supervisor state management.  So more than
> > one, but still not very many.
> 
> Speaking of MPX, is it really active in recent kernel? I can find little
> piece of code at native side, instead, more code in KVM.

Nope, native MPX support was ripped out a year or two ago.  The kernel provides
just enough save+restore support so that KVM can continue to virtualize MPX.
