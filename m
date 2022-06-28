Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDAC55E3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345955AbiF1NBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345896AbiF1NBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A5F22FFD1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656421270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3IfYxoA9KqKHyuaybC39E0ujQdqKOGByO6fbY7AG724=;
        b=bPKTO+0ls/TwdMhAjYZcftXnu1SAqfRA81MBOzJWvk/COiEJ70LVItOdQla06GbKP8TSJl
        Tcpfnajvms6YnA3vdM2N13Y658yo2cVg/IGLmfEezoNWI3x9nbBAVahtRtOsNDWDaeJ0tR
        5F/oGU8n1pIfGX7nHO2E72Q2A44d+kY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-bWZdYDiQO6eIkiflMIEE9g-1; Tue, 28 Jun 2022 09:01:09 -0400
X-MC-Unique: bWZdYDiQO6eIkiflMIEE9g-1
Received: by mail-wm1-f71.google.com with SMTP id r132-20020a1c448a000000b003a02a3f0beeso720797wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3IfYxoA9KqKHyuaybC39E0ujQdqKOGByO6fbY7AG724=;
        b=UlhG0/htGg6xPeJLnfManlDjJcg0Db60x6P5HIutHOI+51S8f6vccawKBS1oHotyW0
         wqx4izzRMN2te7hrv6D5hoMTXII85cVn6IPWCKLCAfiSTQB/UXiKfpHz6iwdFHbB2igv
         YXxWL1czDsqHbkACI1Z9K99+bz/3xDJZv2u9iEH5/TszH2+PWTQz1jmtAN0hd06LP2Ly
         I50olyoexNS8U9UsGoevx9GHjz6eDRVQ5s9nsR6RiszJgOHuGznJwwCwFQNV9YM9CzAp
         1ltGkHV1dmyWChPAk4Ezrf0mewIiK16Xj4Bd8Bf2GGn7v/MzQeWC/GY53thldDRCezQf
         CkfQ==
X-Gm-Message-State: AJIora+VPYkBxawzxAaeMigHWnwBNq8a8Ku58eniOE5Rs7jqgP/OreL6
        cwgb9LxOigR5kWxT28eHWdqVJj9FY+PyteNyWfIMqMBoECAbMt62yvUE0LhUI/u8Zd10+eySHm6
        KewszPGVPKlpsf/dMVCB9haPq
X-Received: by 2002:a05:600c:1d1c:b0:3a0:49a2:6b40 with SMTP id l28-20020a05600c1d1c00b003a049a26b40mr13014875wms.103.1656421268341;
        Tue, 28 Jun 2022 06:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tmPEHOeoR5wLw7eMT9FFvu5ZmS0E40QtfSJtOkpLlOqhK/qOZAvgYW2ho5KForaHKKuxHdzA==
X-Received: by 2002:a05:600c:1d1c:b0:3a0:49a2:6b40 with SMTP id l28-20020a05600c1d1c00b003a049a26b40mr13014827wms.103.1656421268078;
        Tue, 28 Jun 2022 06:01:08 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c500e00b003a03564a005sm19121071wmr.10.2022.06.28.06.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:01:07 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     syzbot <syzbot+d6caa905917d353f0d07@syzkaller.appspotmail.com>,
        bp@alien8.de, dave.hansen@linux.intel.com, glider@google.com,
        hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wanpengli@tencent.com, x86@kernel.org
Subject: Re: [syzbot] KMSAN: uninit-value in kvm_irq_delivery_to_apic_fast
In-Reply-To: <000000000000d8420a05e28075ea@google.com>
References: <000000000000d8420a05e28075ea@google.com>
Date:   Tue, 28 Jun 2022 15:01:06 +0200
Message-ID: <875ykluelp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+d6caa905917d353f0d07@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    4b28366af7d9 x86: kmsan: enable KMSAN builds for x86
> git tree:       https://github.com/google/kmsan.git master
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=126a4b60080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d14e10a167d1c585
> dashboard link: https://syzkaller.appspot.com/bug?extid=d6caa905917d353f0d07
> compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d596c4080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bcf08ff00000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d6caa905917d353f0d07@syzkaller.appspotmail.com
>
> L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
> =====================================================
> BUG: KMSAN: uninit-value in kvm_apic_set_irq arch/x86/kvm/lapic.c:634 [inline]
> BUG: KMSAN: uninit-value in kvm_irq_delivery_to_apic_fast+0x7a7/0x990 arch/x86/kvm/lapic.c:1044
>  kvm_apic_set_irq arch/x86/kvm/lapic.c:634 [inline]
>  kvm_irq_delivery_to_apic_fast+0x7a7/0x990 arch/x86/kvm/lapic.c:1044
>  kvm_irq_delivery_to_apic+0xdb/0xe40 arch/x86/kvm/irq_comm.c:54
>  kvm_pv_kick_cpu_op+0xd1/0x100 arch/x86/kvm/x86.c:9155
>  kvm_emulate_hypercall+0xee7/0x1340 arch/x86/kvm/x86.c:9285

...

According to the syz repro (and AFAIU), kvm_pv_kick_cpu_op()
doesn't set 'irq->vector' which is not really needed for APIC_DM_REMRD
but we still reference it e.g. in trace_kvm_apic_accept_irq().

I'll can send a patch (if noone beats me to it).

Thanks for the report!

-- 
Vitaly

