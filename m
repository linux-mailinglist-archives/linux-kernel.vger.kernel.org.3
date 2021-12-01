Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA59246522C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351160AbhLAP6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351204AbhLAP6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:58:44 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50947C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:55:23 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id k37so64119731lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xL/SpxsRDGwnkxLz+6BUFTtHIU21cRhV7c5wnSAq5Yw=;
        b=I9ghR7dt4Gsu2/sYeRlTJJVcMRtr/3zIlV90L93Rm2vWQQlekO0Gh/KlB+6MCE9mh/
         juwc6AzqEs6nuuZfCfIT0KtgAq4d8EPA+f1TyawHpHBGFqlagkI1HRMoaokxQe1oLeTI
         3+nwmHhW9uCJTy1yQjGwikexKvJy8O/+WwGbH4ni0za9FZKFfu/j2DiwCLI9vlWjz0Ck
         loIEZyFSE05BB2FEUebNqKkCSIs5xrOKRHLL+3SE/O2PRgpeOQY10NypbaUy18r5XAyx
         HpWpUZ2O9GxMYTvzRyByPETbnLA1n4a4CCXhzNR/9pJEWugmO5XVUH1hXskJbIQj+hge
         RnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xL/SpxsRDGwnkxLz+6BUFTtHIU21cRhV7c5wnSAq5Yw=;
        b=biCT08qph/Atls+OG1ZwuFUcbupxiZ6uxT4+yix9agkZe0mEG4LwgS7ErPsR6tp8v/
         1fZRHISZwOdugzruybe9pIoGfkzq3h/tQhyjwZQFTYDXSNclBZ6OeRnMxrYXQ/Mhzool
         yue0zfrXjc4IE0mGUtGfxOckieFKr+7gO9lXyDSi6wSthlBrbcT+Okez2oAt0C4ZbJyV
         V1UIDKUMNaTjC8Ju9PWkZW+gN0NFb65yl6fCq79YOaLuN3XuH6//hwHE7vGW+nD4Fpbu
         b6ItQyNxVtx/n+IN1/pjd+OVZwi8xbYNUcNRnP4mBnXM05vcFEuzbfP6rVM4BsB9qv4V
         yKRA==
X-Gm-Message-State: AOAM5311ckQyJtDgXkOifLjvc5MhnhksLLrlWc6gQGNAqSRTOfuh8+J5
        KzKBtRVFlmCTbI0rZGdXcju7tmDX5edlsQjZc713KacBhI8rkQ==
X-Google-Smtp-Source: ABdhPJy/+/3rg39jeP45zH9ymgRTv59GH1CjAnXh2e39aAzfNKAr8HYBD2a8dwlALIOyVHSFKkWKQev3T2wRxUjX9aw=
X-Received: by 2002:a05:6512:1148:: with SMTP id m8mr6362883lfg.456.1638374121401;
 Wed, 01 Dec 2021 07:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20211123005036.2954379-1-pbonzini@redhat.com> <20211123005036.2954379-4-pbonzini@redhat.com>
 <YaVUBv9ILIkElc/2@google.com>
In-Reply-To: <YaVUBv9ILIkElc/2@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 1 Dec 2021 08:55:10 -0700
Message-ID: <CAMkAt6obMZp9hBS02-AxNLEeYfCs2vLu0dxpJUaP9mOfUGAxdA@mail.gmail.com>
Subject: Re: [PATCH 03/12] KVM: SEV: expose KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM capability
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 3:28 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Nov 22, 2021, Paolo Bonzini wrote:
> > The capability, albeit present, was never exposed via KVM_CHECK_EXTENSION.
> >
> > Fixes: b56639318bb2 ("KVM: SEV: Add support for SEV intra host migration")
> > Cc: Peter Gonda <pgonda@google.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
>
> Reviewed-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Peter Gonda <pgonda@google.com>
