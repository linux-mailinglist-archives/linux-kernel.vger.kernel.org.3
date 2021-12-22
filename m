Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4289447D835
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 21:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbhLVUPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 15:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbhLVUPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 15:15:37 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CB6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 12:15:37 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g26so7701571lfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 12:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kg2IAg/CjcdsbtMVjYJaw+Xd6RBeV50zMt05f5cGIus=;
        b=h9iRtgJYSrRAdzsauBtw6VH5R3rdeWM8VHKPsOznvkXMaFPSuE7fJqrzmeCXNb1KJe
         EBOKs+IjLgwnV9of969DT+IEjaC6aoiBoTr66WgdNdz7wmlkKVzlzNA6RgqWj/p6qsaF
         oZa4brQjgwZRuyMs9D5IdkPvWszziDcZXV7mxLbtQ0kwRsJQm7T83Yb8cnFx8ZSbGtZQ
         FTq7uIQe4x2NJeUQ0Jnge+OzJOK4XEfyqOdbxRfsE5/3lCsaUo0wuxTiYzzU3nlXVatI
         KRAWEn0Prwl6KpSdYR1hhXe0pPXHQ9mp7m7LhLCuQ+0yoSExwMvyUJz+COi37aB5h/GV
         9ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kg2IAg/CjcdsbtMVjYJaw+Xd6RBeV50zMt05f5cGIus=;
        b=bWIiWZfurdYALeRoqx9c++RhpeCzUyvvHYKURRCZyxOH64hEvsLYnNZ9giv8tF2Nm8
         Q/VDLpfK4AQ13BYEv+K5VQIpQhmUagTAKEp9SrbWC8ho+oPwbtnMgAoSOdKB2IouJq3D
         2YFFZU5jczmU0YSVIIvgTNyP+f4xfw0+FV47LzjXy4bk8toO+OXQzpUxmyHQSMQGaDms
         DraPAyk0Upmov/6I4xqvbJYK694tYk9NRDjG6fwCsve/xNfcpPGavyNeT8p1RZdQ+8pG
         I1OpX+82StSEqdsgn51TtI2Vyc8V+vg04RhnVXBiZO3M3joPjNUhcVwiRjb1svGMn8zV
         cASg==
X-Gm-Message-State: AOAM532AG/OxjacY0c3WPUKmaCAjsmHWia/y7mkNHfjKhICTCnas5tyl
        OeBUNaB8Yssy9Cc1WBJsnAOifxiXlHQZykAfVz6DRw==
X-Google-Smtp-Source: ABdhPJyC+u8WRM0bOZNPMvJ++NmTfvPYfPT3kuEBqCeAY1BtqpBJh36SHPzkW61SYWmwM8zBd47NIOlA8/5LsJLHhwE=
X-Received: by 2002:ac2:52a3:: with SMTP id r3mr3501411lfm.580.1640204135378;
 Wed, 22 Dec 2021 12:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20211214050708.4040200-1-vipinsh@google.com> <CAJhGHyDJ8XG6ZCC-NoATFgyeuyEq_A7zmF4TSFA5ubONv7Mx1g@mail.gmail.com>
In-Reply-To: <CAJhGHyDJ8XG6ZCC-NoATFgyeuyEq_A7zmF4TSFA5ubONv7Mx1g@mail.gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 22 Dec 2021 12:14:59 -0800
Message-ID: <CAHVum0cTEcSSNNJNKQEMEW=a11hay_VJMCzJ-7LRu81qBJZ22g@mail.gmail.com>
Subject: Re: [PATCH] KVM: Move VM's worker kthreads back to the original
 cgroups before exiting.
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 8:14 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> Hello
>
> Off-topic, can this kvm worker_thread and the thread to do async pagefault
> be possibly changed to use something like io_uring's IOWQ (fs/io-wq.c)
> created by create_io_thread()?
>
> So that every resource the threads used are credited to the process
> of the vm.
>

Sorry, I am not very familiar with it. Maybe someone from the
community knows better about this.
