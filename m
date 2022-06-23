Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335055575FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiFWIy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiFWIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8E3936685
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655974491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULy9IIamPdfsZSRsFJ2H0uvIsCHgd0HnbDP0BI9tL4I=;
        b=c1yZ6YjpAvFJsD473U1QzOU78HgoftUsk6hIluYupi2k6gVPIWLkYJ7CH/aqXd/E6DR5+4
        udgtYrgGZx+mdKNcbFW+yZV6KFCRjeltz7hikwYqZWJ1vaStYwWHhcCgOB+4ZDz4IsPGwl
        aPpE7YFrxrw1K27YV9LEO96emE5HA0w=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-X2EwHh3vMsChFENMyxehBA-1; Thu, 23 Jun 2022 04:54:50 -0400
X-MC-Unique: X2EwHh3vMsChFENMyxehBA-1
Received: by mail-pj1-f71.google.com with SMTP id bk18-20020a17090b081200b001ec747bb1f7so997980pjb.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULy9IIamPdfsZSRsFJ2H0uvIsCHgd0HnbDP0BI9tL4I=;
        b=4ilcPMxfoUn9BzPgjxOP5DvmcLCTfiqaNvOhltrN4+htQldP8sf7PXXwUxn/3Qyiu+
         6Z30iQYW1u+6+WelU3mjS+e3xk4MHI3gEdkYR5pvbZmPWv6ocfQ/gt8vb8oTTaasKQyX
         eA+KVXcvXbWq+CW2zmVzlVqZJw6+jipQQFvAWdJgDls/ixlDkMBUDh9CD4jLPLYnNR9c
         dqTEgckn5wKpo96Y1Hn2PlPFMHV63mSmSGTzXcL9aMBdkTEbc+hbf6GiC7JPRUZ9sB8V
         vInG3zR9nvhKioND7liqZD3IWDnzm1ZTbn7jTHYRaMP8eh7C0PEToGwo96ZDycbwQl9P
         450Q==
X-Gm-Message-State: AJIora8eTooQfpb6VopFFzRdpXNZillasFvaRcAQmGqN+wBUZtSQSxfZ
        sZj/CyhukJbaHvMW9KLvkVIkA3EULCAjB4qvfU6d3wTJh6eor/nO8y6U/dfc5xu0D5ONU/tX+Rr
        FWrOQh4lZ/3JVKgWwZ36G1j+BiXsuFKG/K0tqiWJ7
X-Received: by 2002:a17:902:ec83:b0:16a:3029:a44 with SMTP id x3-20020a170902ec8300b0016a30290a44mr15842256plg.141.1655974489104;
        Thu, 23 Jun 2022 01:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vK4B3HncgW6duS5f+hx8kUoau/VW9nbZ05rE0/VJMQKcwWRVhW79OpJQA/P7Sn6FUm+rj+FSdF2+5UqBofQ2s=
X-Received: by 2002:a17:902:ec83:b0:16a:3029:a44 with SMTP id
 x3-20020a170902ec8300b0016a30290a44mr15842235plg.141.1655974488824; Thu, 23
 Jun 2022 01:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b9edeb05e1aca987@google.com> <0000000000008b8cd205e2187ea2@google.com>
In-Reply-To: <0000000000008b8cd205e2187ea2@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 23 Jun 2022 10:54:37 +0200
Message-ID: <CABgObfarsDqG3g1L561CHvg3j0aROSz5zdcB5kOibcjbLN_y9g@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage (5)
To:     syzbot <syzbot+9cbc6bed3a22f1d37395@syzkaller.appspotmail.com>
Cc:     Alexander Lobakin <alobakin@pm.me>, Borislav Petkov <bp@alien8.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Anvin, H. Peter" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: x86/kvm: Fix broken irq restoration in kvm_wait

On Thu, Jun 23, 2022 at 9:35 AM syzbot
<syzbot+9cbc6bed3a22f1d37395@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit c2ff53d8049f30098153cd2d1299a44d7b124c57
> Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Date:   Thu Feb 18 20:50:02 2021 +0000
>
>     net: Add priv_flags for allow tx skb without linear
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11596838080000
> start commit:   a5b00f5b78b7 Merge branch 'hns3-fixres'
> git tree:       net
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13596838080000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15596838080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=20ac3e0ebf0db3bd
> dashboard link: https://syzkaller.appspot.com/bug?extid=9cbc6bed3a22f1d37395
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143b22abf00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125194eff00000
>
> Reported-by: syzbot+9cbc6bed3a22f1d37395@syzkaller.appspotmail.com
> Fixes: c2ff53d8049f ("net: Add priv_flags for allow tx skb without linear")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>

