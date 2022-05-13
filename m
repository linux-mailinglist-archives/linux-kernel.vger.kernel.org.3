Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A90526950
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383321AbiEMScY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383125AbiEMScW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:32:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7674F59B8A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:32:21 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id t25so11261994ljd.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZziBTXmRqnnjBhHuhXJdxWbOyffyqPRZmceazeKo90w=;
        b=JQPjZMg6WTdJ5IkgPmm2nrTHq/REs21h1opfEUiqioaskxK6ylnGBPeutd4Im9Pet8
         IidW9WQ0B41kp4NgcaA8h2Pj7S6uKuKGIfbk1x3zUM2W1f5ZyJsPAim8jLCN3PA7iaPt
         IomTrGdLdosutEMG14ePfnjE79UNNfeaVyq9jTaTUwhYo/3ldjVDt+FtugCgmCYzdVxS
         TPk4FomP/AJ2GrtNnFRhLiRpYkMt5jjzNusMgizl/Ekcc57YGKKwseW4s6+ZD9fBmiUm
         7F+sLPgvnukoNJeD2VyCksXF2bcbkOsTzbXYpxEJcijIMP54qTFAVzo20x7bHWnzYASN
         hlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZziBTXmRqnnjBhHuhXJdxWbOyffyqPRZmceazeKo90w=;
        b=uF87y5zVAofu+sLsDcmfUZZPcFWl0XY3R9sPYEI0gBHdXdomasLMeH27gS4xG9C/UE
         n8CM0iuC7JNjRrQw/nSrxhLKOeemQaNE15zifr/nais7/4WaC+TJETFXt6pnlBhBlZc8
         sQhhRUbC79YFLxZjYZ/FxKXCjdIu815d+5uVH4tr5zQbCCmFeCNMZN7ZnjiujTMsIT6M
         B4jPtrl2Y8cZmHrNVduU0gjvofGcyG6MTDwVKMO15g+qGl3q137AbkAUrcezzplztOZp
         gQ0b/zsPgFmTHw1uhevW2Yfm/yOVGNKzCDB9uofH0HaI1bt08aVVlNJg6sp6Ceh8Tv01
         haPA==
X-Gm-Message-State: AOAM531HAVew+sZ8dlDnBCjlqqnZBi+ynC4cUOTJUcXu7EBCqfefRF/U
        4YDrSpNQ3DHAA0mYMORGs+XnjmhiEQ2Vnp6bK4oOdQ==
X-Google-Smtp-Source: ABdhPJzgfOdxieaj7s58NJrKZJAiqjyxiNs0PouTjUbGkAyfnrvMQXGFwnN+Oha5JEddW0Xhn91GlqPaGSJq4Jjio8Y=
X-Received: by 2002:a2e:9e54:0:b0:250:d6c8:c2a6 with SMTP id
 g20-20020a2e9e54000000b00250d6c8c2a6mr3977716ljk.16.1652466739597; Fri, 13
 May 2022 11:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220503150735.32723-1-jiangshanlai@gmail.com> <CAJhGHyA3UxremNUH6x5NfUtNMG57zWMM776jzPfj9wfjqvXd2A@mail.gmail.com>
In-Reply-To: <CAJhGHyA3UxremNUH6x5NfUtNMG57zWMM776jzPfj9wfjqvXd2A@mail.gmail.com>
From:   David Matlack <dmatlack@google.com>
Date:   Fri, 13 May 2022 11:31:53 -0700
Message-ID: <CALzav=e-4npHpR6XbCe_JO1R74_=KivoGfM9bB6uHxnuF+X+Gw@mail.gmail.com>
Subject: Re: [PATCH V2 0/7] KVM: X86/MMU: Use one-off special shadow page for
 special roots
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR MIPS (KVM/mips)" 
        <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
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

On Fri, May 13, 2022 at 1:22 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> On Tue, May 3, 2022 at 11:06 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> >
> > From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> >
> > Current code uses mmu->pae_root, mmu->pml4_root, and mmu->pml5_root to
> > setup special roots.  The initialization code is complex and the roots
> > are not associated with struct kvm_mmu_page which causes the code more
> > complex.
> >
> > So add new special shadow pages to simplify it.

FYI I plan to review this after I get a v5 Eager Page Splitting out
(today hopefully). But from looking at it so far, it looks like a
great cleanup!

> >
>
> Ping
