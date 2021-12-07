Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8E846C371
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbhLGTWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:22:46 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:56976 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhLGTWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:22:45 -0500
Received: by mail-io1-f71.google.com with SMTP id r199-20020a6b2bd0000000b005e234972ddfso86107ior.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 11:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qwIHKUpEZfXAJ98aaHZ0G3Cq+vGsYXU3+sGI9JUl8Qs=;
        b=uyPbXlHw0+h+Vuj2RxtKGMjyFTEP3a2MozGYHLM/hGuF7l2lMc3tWRXG8IEHYkRf/P
         7Ta+d3d1muTKOe/CSyY3kOolqS01rcusM1Vv3zRC2wAdX87Db0LBzgfkXLVyhjZNlzxo
         s9NpxvdeL1EAYazW0uebFiO4bHa3bX4cdTtdP59IxmBMgLPVtctXxD3bZKT/1BvijsyJ
         qn3SZML8VPiepO5rWhseZE1y9U7gWEws6F3+ptT7v3mvYT54ZGM5SOt94A8Fq2KeaOIT
         oqy1jAgcaX2obPF10phFSJFeK6u6FEgLmfcKnsHmj5dfXXJHhsA4qhh5ml4CL1OhItce
         C0Sw==
X-Gm-Message-State: AOAM531davpmi0qu0FciBzEDNzaFRSveD6ViLZAg9Z8s/7ewj5TZiwl+
        NrrZISM28jzQ06ok9NBSVWps/W/TcqnTbzBzvgjnyb+QPms+
X-Google-Smtp-Source: ABdhPJzsAxGhr40s7GLGaVzV5ZP3zz35qdTxoDeDNmyRGE97aOMtDpkw4j5HGfgIf0P+VpdejmMSHCjtkDqG0IeNhi/TooDucIxx
MIME-Version: 1.0
X-Received: by 2002:a05:6602:8da:: with SMTP id h26mr1442606ioz.76.1638904754048;
 Tue, 07 Dec 2021 11:19:14 -0800 (PST)
Date:   Tue, 07 Dec 2021 11:19:14 -0800
In-Reply-To: <00000000000051f90e05d2664f1d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af941b05d2933f28@google.com>
Subject: Re: [syzbot] WARNING in nested_vmx_vmexit
From:   syzbot <syzbot+f1d2136db9c80d4733e8@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, fgheet255t@gmail.com,
        hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, mlevitsk@redhat.com, pbonzini@redhat.com,
        seanjc@google.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit c8607e4a086fae05efe5bffb47c5199c65e7216e
Author: Maxim Levitsky <mlevitsk@redhat.com>
Date:   Mon Sep 13 14:09:53 2021 +0000

    KVM: x86: nVMX: don't fail nested VM entry on invalid guest state if !from_vmentry

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f21e3ab00000
start commit:   f80ef9e49fdf Merge tag 'docs-5.16-3' of git://git.lwn.net/..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12f21e3ab00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14f21e3ab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d5e878e3399b6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=f1d2136db9c80d4733e8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1603533ab00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175b5f3db00000

Reported-by: syzbot+f1d2136db9c80d4733e8@syzkaller.appspotmail.com
Fixes: c8607e4a086f ("KVM: x86: nVMX: don't fail nested VM entry on invalid guest state if !from_vmentry")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
