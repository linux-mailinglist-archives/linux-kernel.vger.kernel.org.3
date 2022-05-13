Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0624D526328
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381635AbiEMNiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381484AbiEMNha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:37:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344DDE2E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:37:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f4so1741916lfu.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNun4ZTStfT49QHEpCQD8tjXU6kqYy14sdjKYugygVM=;
        b=dugEPaRnc81vdHcYLXTwEg09DwWdgNK8aq3YFDbhGqRHq2+0pH78YRR5OacHw/9ekI
         SeTPlA9FCZnmbjeCdFVit5DAKGDM/YLaXvR1mqygL2qq0vIMkmqele/NXQyAT8bVC1/W
         hZufPIDp9VFsZcy61dw0456Y5ekfWsyaZ4K6ceC+4QUWjppBEtfq+tKnCsxVxi6gJwtO
         sLqWW+iXN8gL7dTyfh7yGuEufpQ2/TRPytHGs9DeLfcvYGQ7/9lsLNau3G/o5kuJRumh
         iINyZNx+I/FJa9RFkQFP8AMhm3r5LhuRFcy0myq7BcvYDpaE7x48jAcm1ArDnJg/gRNC
         msmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNun4ZTStfT49QHEpCQD8tjXU6kqYy14sdjKYugygVM=;
        b=p5iFwasyrpUHTJtJm+QuTthcXEJqk+mA6kudvzntD54e/iO1E7VsS6piNRUb5EMshv
         m1HvmDij0DPsikYn9KCkTawwRCl0SWEqhtfZlLuFqTg8tOZJVOB6zAb4CL52yKvxG7//
         QMuvXY3VN20kpOri0SJn6dfLij7aTLGfnMX1IRN4RL/twDh1Zq6APikpciC7C0bHevyu
         RH6PxlwzjrqhYj8oXOwSwN6D7Fw9Tay3NGhJTVfaGDsO1jV+lQ/Q0U0UGXnvkdeKLItA
         hVC5KWpetfqBAP2Pw4mATF7ztZ+d0lyxOAzkWyERruOpZt5RRL83yQ+UnaNtjTt6+LTH
         7xQg==
X-Gm-Message-State: AOAM5301HPkJZWnYSNnDP7H0dNj4GXgEAbaRz9CK+goK58UvATI1hAAg
        u0YR7EAqiodyuthwwfUMs9p/UOcvO2ABdzQ8WKahEw==
X-Google-Smtp-Source: ABdhPJw4mopRb/AcWYZNSPPYhotHrAhFymOgtcNEija7JL7Xo6Q4eQqzZtgVFlxABVf3k53ALIc4jnlSQVfoaCnYEo4=
X-Received: by 2002:a05:6512:234c:b0:473:c3ba:2cf1 with SMTP id
 p12-20020a056512234c00b00473c3ba2cf1mr3518251lfu.402.1652449046335; Fri, 13
 May 2022 06:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220512202328.2453895-1-Ashish.Kalra@amd.com>
In-Reply-To: <20220512202328.2453895-1-Ashish.Kalra@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 13 May 2022 09:37:15 -0400
Message-ID: <CAMkAt6ogEpWf7J-OhXrPNw8KojwuLxUwfP6B+A7zrRHpNeX3uA@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Use kzalloc for sev ioctl interfaces to prevent
 kernel memory leak.
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Nguyen <theflow@google.com>,
        David Rientjes <rientjes@google.com>,
        John Allen <john.allen@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 4:23 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> For some sev ioctl interfaces, the length parameter that is passed maybe
> less than or equal to SEV_FW_BLOB_MAX_SIZE, but larger than the data
> that PSP firmware returns. In this case, kmalloc will allocate memory
> that is the size of the input rather than the size of the data.
> Since PSP firmware doesn't fully overwrite the allocated buffer, these
> sev ioctl interface may return uninitialized kernel slab memory.
>
> Reported-by: Andy Nguyen <theflow@google.com>
> Suggested-by: David Rientjes <rientjes@google.com>
> Suggested-by: Peter Gonda <pgonda@google.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Can we just update all the kmalloc()s that buffers get given to the
PSP? For instance doesn't sev_send_update_data() have an issue?
Reading the PSP spec it seems like a user can call this ioctl with a
large hdr_len and the PSP will only fill out what's actually required
like in these fixed up cases? This is assuming the PSP is written to
spec (and just the current version). I'd rather have all of these
instances updated.
