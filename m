Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9294CC354
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiCCRA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiCCRA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:00:26 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CB116203C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:59:40 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v4so5059674pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 08:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TRe594s70/BSgqAig7s+8kVsNXAhB41CkpW4XEV91Hg=;
        b=Sw0dfYxFJ4mEKPvVublWYLsl673lFfJ18wDifxKlKiovIH089C/9DXqx76iw+U9Wy1
         c1QZEs/MqMiWOaevM2WlLHTh9kxnCfRnHseHHrArIGj5zCh7NuIA5+mLEPKfM1HDYAjj
         KeX4REFSgSXsCkIJugPgRW8jOLuV4i4C5vJLDAdw+ygAHwbKFm3tIwOGzm9ZIJ3zLAbi
         iRov0EnBkeoxOiMZf/W1aSyhlXQPw1zq+pnjcpFm4RjNTAeMRtd3mAomXCp+mhkAANRY
         SMQDUSV9wuO4oWfxGQwK/UkFWNnnRFDeQSayvqvTNKh9rNu3RdkAwy+P1OtFzm6n7reI
         wOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TRe594s70/BSgqAig7s+8kVsNXAhB41CkpW4XEV91Hg=;
        b=58RJCfHkEC53+RLlAbhkwkp9qj0DH33f0AqNxwAXITtriJmC031/y7OxK5rRplAo2O
         vMCX7ue7o7vRjA4t2sZsqdD43cFkHg5oIBHiOc9e0ogSsGdmB+2+7PDS7YICpERwmgxv
         pK5mDeS2JpWjE+GacQ0zlNCsEFNOQKyYpUYAkUaZis6WfM6efPcQAWYRLsmksCtm5nk2
         j0PHc6efLQcQ7qCYVWp6h2RpddHeXWHSjqizc9t0ccK5iB5P2CKL4RZ3iYaTCJeI1vId
         yBCR1yU2gZVAillDe9Au/XycdzwVGzOoa5QAwuADb6fYySFWmnxgcZHkqmD32q2rV6qp
         zD8Q==
X-Gm-Message-State: AOAM533HWKPGsKKWQJyV0cRhGGIBE/pfNCSSH3x8/glPpXaNP0Eg+S9p
        KVkGOuB+UHZiVS1w5M2iw2JNXw==
X-Google-Smtp-Source: ABdhPJxb4kj47xxaByYvUO4XtKKnHahIGOZu3XEgeG5BAzJeSsGKxMgaQOn+rxpNIox3oVhLlWIOmw==
X-Received: by 2002:a17:903:244d:b0:150:18f3:8e98 with SMTP id l13-20020a170903244d00b0015018f38e98mr37058822pls.28.1646326779923;
        Thu, 03 Mar 2022 08:59:39 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090ad81300b001bc447c2c91sm8558375pjv.31.2022.03.03.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:59:39 -0800 (PST)
Date:   Thu, 3 Mar 2022 16:59:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: SVM: Fix missing kvm_cache_regs.h include in svm.h
Message-ID: <YiDz9w7W6+LTRtVz@google.com>
References: <20220303160442.1815411-1-pgonda@google.com>
 <YiDsEgxUDZL+XY9R@google.com>
 <CAMkAt6rwiL_G1w66_rseKSFOTSV4zX8gnb1EOoQNv5TH=ToHGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMkAt6rwiL_G1w66_rseKSFOTSV4zX8gnb1EOoQNv5TH=ToHGw@mail.gmail.com>
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022, Peter Gonda wrote:
> On Thu, Mar 3, 2022 at 9:26 AM Sean Christopherson <seanjc@google.com> wrote:
> > Ha, we've already got a lovely workaround for exactly this problem.  This patch
> > should drop the include from svm_onhyperv.c, there's nothing in that file that
> > needs kvm_cache_regs.h (I verified by deleting use of is_guest_mode()), it's
> > included purely because of this bug in svm.h.
> 
> Ah good catch. I assume I should add kvm_cache_regs.h to
> arch/x86/kvm/svm/nested.c too since it uses is_guest_mode().

Nah, picking it up from svm.h (and several other headers) is ok.  If we required
every compilation unit to _directly_ include every header, we'd probably double
the size of the kernel source :-)
