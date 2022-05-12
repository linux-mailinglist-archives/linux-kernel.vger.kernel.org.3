Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A975257EE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359266AbiELWnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbiELWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:43:51 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC67282478
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:43:50 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id k25-20020a056830169900b00605f215e55dso3746483otr.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1t970B0fJHlEuyIXUobZJRtdZ+neS/qyKKJxNpMTOxg=;
        b=jS0cP6aQeTYuJhFXvnLlQ+p5gdFQUNk4IZuAln/UMY8iT0rGeTreJ6hilp0syiuyVb
         pbwQol8xkHcGnHNptEVqx6GpVQ0saHx/X0aXVRDVXjPXmPd7Y9HDUo0bfv8evYBbiAup
         bVHNFJZjkz47YxvA54L95gGRuqm/J7udeWeTUmT2i+zGNYGR8awOzW8ViwG7GxWGa2pB
         SVpsKhe+h/wdxFPoQ+LDcYPM0jQLH+z1BmzFenKmKpzeomolN1xm7NgcZRXJWA/1Kutv
         X1ujJOcUIM9CIvDGQ8foE4gKd71NemiU90d51zP1vJ1PjtZlLwmtoYXmqWdPP+gSNbvH
         41wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1t970B0fJHlEuyIXUobZJRtdZ+neS/qyKKJxNpMTOxg=;
        b=4Pc9Ufc+nRUwBXMbtHjJFb4IgbMrPT5M8dTdQTXU0VkJgPo1LqoDaJvrgukA1WxvBK
         HzDqK/M5KODPcG7A/1Q73XXoS6tHw6wY5VRrxwolUuvwtrd3D1vYnUFC1sEgjfbkoShR
         QxuCc8dybz0jYz3pcg8ke56ZG0vHLokbXr9bjZscoGowN/Y6/lDQMdNpDR+TLW+UsiWq
         Di1udwkJYqoEZPRKLf2tPTtwhuEPBBZ7fv8l5na6gHwPf4YVY8r0/89j6JNBcjP5nKmX
         CvuTli+IAdwuvstn0SCwIfS1I/b/rG3XhDsGbMt4f/ullc3ZDrzNC2UEqV0XUvJYfcAY
         ngSg==
X-Gm-Message-State: AOAM533TtsxZTu8qXKHbd1XZYe/C0FKIR3p7qF8DL0tTCfGAaVOMEc+R
        TEmG9nterUD7WzVTfocnEWe8jQPR4/MSqDk1pb51Kg==
X-Google-Smtp-Source: ABdhPJx7ZsFAXwdLg9qDgIdSwjaW2ZGxSuROUTaCnIssPEdTzTozEAQCGpFfehKDAZJpy9Jb+A01B3nYcORcUVnCKUE=
X-Received: by 2002:a05:6830:280e:b0:606:ae45:6110 with SMTP id
 w14-20020a056830280e00b00606ae456110mr851166otu.14.1652395429826; Thu, 12 May
 2022 15:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220512222716.4112548-1-seanjc@google.com> <20220512222716.4112548-2-seanjc@google.com>
In-Reply-To: <20220512222716.4112548-2-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 12 May 2022 15:43:38 -0700
Message-ID: <CALMp9eSzx6SEa+rrBR2DpizuwqUzYvU7GNQrW=AOToeTp9mC8Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: x86: Signal #GP, not -EPERM, on bad WRMSR(MCi_CTL/STATUS)
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jue Wang <juew@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 3:27 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Return '1', not '-1', when handling an illegal WRMSR to a MCi_CTL or
> MCi_STATUS MSR.  The behavior of "all zeros' or "all ones" for CTL MSRs
> is architectural, as is the "only zeros" behavior for STATUS MSRs.  I.e.
> the intent is to inject a #GP, not exit to userspace due to an unhandled
> emulation case.  Returning '-1' gets interpreted as -EPERM up the stack
> and effecitvely kills the guest.
>
> Fixes: 890ca9aefa78 ("KVM: Add MCE support")
> Fixes: 9ffd986c6e4e ("KVM: X86: #GP when guest attempts to write MCi_STATUS register w/o 0")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
