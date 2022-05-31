Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563905396C9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 21:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346749AbiEaTPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 15:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346826AbiEaTPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 15:15:14 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08786B650
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 12:15:13 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id d129so13672258pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 12:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LEQ/FAYXiOycH5Pgki0a9z4cyO6Zt9xfMoijJMruHE=;
        b=aoYECPuBKU7Lwlucej90ckQ541ZhjI9tXfhwwrKcylKXIDWfCbS506NUkmQoPpFtjp
         SxY2BDwXcLrnVWuj1tlKZZFXX3boTF7L4/UbiNTvLgRbtbDkTU4iJj5rlChLdWN+AXW9
         /8uU6E9xZwRmy7lGao0XRqc/MNAqTYJl5P/hqXTOYZPGOYjzn/bAAgwSrZzoRfJDN/cT
         SuEfeHBBPefKlsfPtsSVZxWgXtnCDoM36KPdTqy2nZJEgrImggnACjHpxleCCtC3++o9
         yxDwtO9/7vBZwXZmJ1VhyZ/Ls48fokKREiBfE3hRzy/o9DlM+JugKxkM4Tz9Yq/hcS03
         4NUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LEQ/FAYXiOycH5Pgki0a9z4cyO6Zt9xfMoijJMruHE=;
        b=oDe0Qs2SuwsuKPw5fCJyNs0/W/gFyZB0gi6twU6frfzImPLFj1XEDlE46Xe5QHHFYP
         DdEwWuw0046Vb20c50AhOn+TeCvt4632gKTGwAeY9caDhM8C8iB2ggnureCQNd3oJf3L
         +eFtYNj0nt9KyKp7aTutYQ8S/GhPA0YKXhVB/BXQoMFKVml41pdSLfkUKdLPN/goVWk+
         b545FBdBcgoZXeYJSJ4Y3FCryoxhnBan/t5JO5vbu3064fqBwFFyqxswpWtK3/3ry9iT
         bUysVVKMQEEdnq4jTni386bdnlcPUY4Ayfjc14CfRGcYn0+TRBK8CVGJJnywJX3rj4Gs
         4CxA==
X-Gm-Message-State: AOAM530TZ2sHSDJNrzs2EeGfPaFQydqHK1XqeDy4DSAGF8IVo+51WwjK
        LTdmgysws7ExaB3dsPRUmPGXDedmHuilkM2eIqiWyA==
X-Google-Smtp-Source: ABdhPJxAPLjjLuJnMkOUKZFNo6VjJcW6gX615tv0A0PeV8j4hPGz6HEz6HuE5g9ZfRLMUWFpXLfK3l0Q4MwhwgPaQrE=
X-Received: by 2002:a63:2ad6:0:b0:3f9:d9fa:2713 with SMTP id
 q205-20020a632ad6000000b003f9d9fa2713mr44449690pgq.512.1654024511581; Tue, 31
 May 2022 12:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com> <20220519153713.819591-4-chao.p.peng@linux.intel.com>
In-Reply-To: <20220519153713.819591-4-chao.p.peng@linux.intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 31 May 2022 12:15:00 -0700
Message-ID: <CAGtprH8EMsPMMoOEzjRu0SMVKT0RqmkLk=n+6uXkBA6-wiRtUA@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] mm/memfd: Introduce MFD_INACCESSIBLE flag
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
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

On Thu, May 19, 2022 at 8:41 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> Introduce a new memfd_create() flag indicating the content of the
> created memfd is inaccessible from userspace through ordinary MMU
> access (e.g., read/write/mmap). However, the file content can be
> accessed via a different mechanism (e.g. KVM MMU) indirectly.
>

SEV, TDX, pkvm and software-only VMs seem to have usecases to set up
initial guest boot memory with the needed blobs.
TDX already supports a KVM IOCTL to transfer contents to private
memory using the TDX module but rest of the implementations will need
to invent
a way to do this.

Is there a plan to support a common implementation for either allowing
initial write access from userspace to private fd or adding a KVM
IOCTL to transfer contents to such a file,
as part of this series through future revisions?

Regards,
Vishal
