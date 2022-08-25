Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8D5A15DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbiHYPdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242887AbiHYPcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:32:45 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83584BB011
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:32:40 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w197so23713064oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BF1zNrYrm57PzI0kOZgixgNUjiOGt1ff9+aE0AWJYQI=;
        b=m/c5m0vZL75a8GxeNZKr5wrUmCNGKu3QQ5GbsAgpPhbnlEwfOI2ru540yng44ZVv4p
         KPep2s9ENlyNLFHqLmcUXI7DvzTuQaNrQYVS5rudbDBXjM8vPjiC1cs3tuCp6UtMRcpb
         KOKi3hR57OAefdXoqMBc6em4pbfHrdqdIzMzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BF1zNrYrm57PzI0kOZgixgNUjiOGt1ff9+aE0AWJYQI=;
        b=gUvPamL9LlMv3SJhNPjvUo0Onag9oFkxrsiBUa4jXvAklwYLqmO36yZExOWTTvnV/P
         swOy/+QokyWS7+nl47mz32+jPZZ4RwIV2emEQvZXAR0PZmxpUDNGFxX00PypKHpUTALj
         7/xpkA+aNieWxCiHDDxzUwaIbeZtop142JzCXsZUe+2V/EHEj6NeTCIxtUv2ea+fqlS/
         svne4H3qbEWQIEh9MgfNAJDKd0EeYI6C5TZ85+c7KNa27FaKrazNxSqoxVd/YCYtp+Da
         QCCVS9h7WMdPoG/gHjZKiFfArMYuStMxDx9njZsLfvl3G/hvm1mM1ZEYXc+Mse6S2sz1
         ItxA==
X-Gm-Message-State: ACgBeo37xWLWXODjRF4Br7yJo0T5h5rUDq7ij12sXqDwamuRYaVE2qw1
        8ZGGD5+WXVHe0Fn16QOSZ9r5IqrYfTBYtA==
X-Google-Smtp-Source: AA6agR43VvmKP9eet4msaqKWe/KdA+S3GaHj1vciUBt0mEuopu2UDyOAgAE0PtSpsW9F3fYVDJrwWQ==
X-Received: by 2002:a05:6808:3:b0:343:7d5c:ac50 with SMTP id u3-20020a056808000300b003437d5cac50mr2110027oic.108.1661441559076;
        Thu, 25 Aug 2022 08:32:39 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id t26-20020a0568080b3a00b003434b221a17sm4818153oij.52.2022.08.25.08.32.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 08:32:37 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id r1-20020a056830418100b0063938f634feso6941045otu.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:32:36 -0700 (PDT)
X-Received: by 2002:a05:6830:58:b0:637:1974:140a with SMTP id
 d24-20020a056830005800b006371974140amr1607371otp.362.1661441556115; Thu, 25
 Aug 2022 08:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20220112211258.21115-8-chang.seok.bae@intel.com> <CAE=gft4P2iGJDiYJccZFR1VnNomQB7Uo522r2gvrfNY9oKz5jg@mail.gmail.com>
 <763bddd2-2fc3-a857-0dff-a5ae4ae1f298@intel.com> <CAE=gft5VajfoAT6hVxiCzAMYiDV+pHRbC-F7s4+qK94qa0og5w@mail.gmail.com>
 <6f2dcc0c-99a2-8698-13ae-d5cbea9945b0@intel.com>
In-Reply-To: <6f2dcc0c-99a2-8698-13ae-d5cbea9945b0@intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 25 Aug 2022 08:31:59 -0700
X-Gmail-Original-Message-ID: <CAE=gft6sO85RBpfdXnR=_r=KGmVrx0mnBOHK7XadNk00gDr-WA@mail.gmail.com>
Message-ID: <CAE=gft6sO85RBpfdXnR=_r=KGmVrx0mnBOHK7XadNk00gDr-WA@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] x86/cpu/keylocker: Load an internal wrapping key
 at boot-time
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        herbert@gondor.apana.org.au, Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>, bp@suse.de,
        dave.hansen@linux.intel.com, mingo@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        ravi.v.shankar@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 6:06 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> On 8/24/2022 3:52 PM, Evan Green wrote:
> >
> > Whatever we ended up landing in the ChromeOS tree (which I think was
> > v4 of this series) actively hit this bug in hibernation, which is how
> > I found it. I couldn't get a full backtrace because the backtracing
> > code tripped over itself as well for some reason. If the next patch in
> > this series is different from what we landed in ChromeOS, then maybe
> > your description is correct, but I haven't dug in to understand the
> > delta.
>
> So the change from v4 is simply dropping CBC mode. Marvin who reported
> another issue told me that he pushed the fix to some Chrome repository.
> But I don't know that's the same repo that you mentioned. Are you able
> to locate that tree if possible?

I see. The only ChromeOS tree I'm aware of where keylocker has landed
is our 5.10 tree. This is the change where it landed:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3373776/12

>
> Also, it would be nice to have more detail about that hibernation bug.

Here's the log I've got that pointed me down this path:
https://pastebin.com/VvR1EHvE

Relevant bit pasted below:

<6>[43486.263035] Enabling non-boot CPUs ...
<6>[43486.263081] x86: Booting SMP configuration:
<6>[43486.263082] smpboot: Booting Node 0 Processor 1 APIC 0x1
<2>[43486.264010] kernel tried to execute NX-protected page - exploit
attempt? (uid: 0)
<1>[43486.264019] BUG: unable to handle page fault for address: ffffffff94b483a6
<1>[43486.264021] #PF: supervisor instruction fetch in kernel mode
<1>[43486.264023] #PF: error_code(0x0011) - permissions violation
<6>[43486.264025] PGD 391c0e067 P4D 391c0e067 PUD 391c0f063 PMD
10006c063 PTE 8000000392148163
<4>[43486.264031] Oops: 0011 [#1] PREEMPT SMP NOPTI
<4>[43486.264035] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G U
5.10.136-19391-gadfe4d4b8c04 #1
b640352a7a0e5f1522aed724296ad63f90c007df
<4>[43486.264036] Hardware name: Google Primus/Primus, BIOS
Google_Primus.14505.145.0 06/23/2022
<4>[43486.264042] RIP: 0010:load_keylocker+0x0/0x7f
<4>[43486.264044] Code: 02 46 0a 0c 07 08 44 0b 24 00 00 00 10 26 00
00 44 d5 e9 ff dd 00 00 00 00 41 0e 10 86 02 43 0d 06 42 8d 03 49 8c
04 02 61 0a <0c> 07 08 48 0b 00 24 00 00 00 38 26 00 00 fc d5 e9 ff ba
00 00 00
<4>[43486.264046] RSP: 0000:ffffb1c7000afe50 EFLAGS: 00010046
<4>[43486.264048] RAX: ffffffff9483a898 RBX: ffff8d64ef855440 RCX:
0000000000310800
<4>[43486.264049] RDX: 0000000000310800 RSI: 0000000000000000 RDI:
00000000003f0ea0
<4>[43486.264051] RBP: ffffb1c7000afe88 R08: 0000000000000000 R09:
0000000000003000
<4>[43486.264052] R10: 0000000000000500 R11: ffffffff92c6c775 R12:
ffff8d64ef8554c0
<4>[43486.264053] R13: 0000000000000000 R14: 0000000000000082 R15:
ffff8d64ef855460
<4>[43486.264055] FS: 0000000000000000(0000) GS:ffff8d64ef840000(0000)
knlGS:0000000000000000
<4>[43486.264057] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[43486.264058] CR2: ffffffff94b483a6 CR3: 0000000391c0c001 CR4:
00000000003f0ea0
<4>[43486.264063] invalid opcode: 0000 [#2] PREEMPT SMP NOPTI
<4>[43486.264065] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G U
5.10.136-19391-gadfe4d4b8c04 #1
b640352a7a0e5f1522aed724296ad63f90c007df
<4>[43486.264066] Hardware name: Google Primus/Primus, BIOS
Google_Primus.14505.145.0 06/23/2022
<4>[43486.264069] RIP: 0010:__show_regs+0x2ed/0x338
<4>[43486.264071] Code: 81 fc 00 04 00 00 75 44 48 f7 05 ca 83 90 01
10 00 00 00 0f 84 fa fd ff ff 31 d2 48 f7 05 b7 83 90 01 10 00 00 00
74 07 31 c9 <0f> 01 ee 89 c2 48 c7 c7 90 38 29 94 4c 89 f6 48 83 c4 28
5b 41 5c
<4>[43486.264072] RSP: 0000:ffffb1c7000afc90 EFLAGS: 00010046
<4>[43486.264074] RAX: 00000000ffff0ff0 RBX: 0000000000000000 RCX:
0000000000000000
<4>[43486.264075] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
ffffffff94cf27f4
<4>[43486.264076] RBP: ffffb1c7000afce0 R08: 0000000000000000 R09:
00000000ffffdfff
<4>[43486.264078] R10: ffffffff94658600 R11: 3fffffffffffffff R12:
0000000000000400
<4>[43486.264079] R13: ffff8d64ef840000 R14: ffffffff9435d0a9 R15:
00000000ffff0ff0
<4>[43486.264080] FS: 0000000000000000(0000) GS:ffff8d64ef840000(0000)
knlGS:0000000000000000
<4>[43486.264082] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[43486.264083] CR2: ffffffff94b483a6 CR3: 0000000391c0c001 CR4:
00000000003f0ea0
<4>[43486.264085] invalid opcode: 0000 [#3] PREEMPT SMP NOPTI
<4>[43486.264086] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G U
5.10.136-19391-gadfe4d4b8c04 #1
b640352a7a0e5f1522aed724296ad63f90c007df
<4>[43486.264088] Hardware name: Google Primus/Primus, BIOS
Google_Primus.14505.145.0 06/23/2022
<4>[43486.264089] RIP: 0010:__show_regs+0x2ed/0x338

I landed this change, though I'm still working on verifying the issue
goes away with this fix:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3851401

I don't have direct access to this machine, but I wonder if a simple
cpu hotplug might also exercise this path.
-Evan

>
> Thanks,
> Chang
>
