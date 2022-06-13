Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55140549D33
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbiFMTPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbiFMTNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:13:13 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB86B3466D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:11:09 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31336535373so5184147b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lxnscG/JNtgOWE9jQWIUqeD55ivz+kwxNuPsSHi0x9c=;
        b=kgpfPIza6D47Yy3A7QPVKp7S+L2QZc52wDk8RktuuLZ2pirZHo3X9hqIEg03DdU5Kj
         kGs01SD/wJXcQBsr1GyD9HYzrn7TkcbrkyczXCgU8jDfzw0Gwp320/L14wjVFj7CsGEp
         piwJbv56dGZ1dXWzgeakJ3zcm+Z8Rdl7alsq1u4mPPObbHk6b/Vuspv2a1nn12Pm6ial
         idn5YuA4kgaCNVuUA9IsZoqHjoEOnan7Dt5uu6KkqAbtKT6LKDCqScHhKnIcpaTj862L
         /7j8glV5SvOTvXAAa5ajv743XfuAVLg32Y7NvkcXk0sf7cNXap6LTbvfDrlWGhR1FYi0
         M/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lxnscG/JNtgOWE9jQWIUqeD55ivz+kwxNuPsSHi0x9c=;
        b=cclStziGniJSxp3pfa0jKKvnJLTgRukbmo94eY092md3EQuQVN4Cg11Lc6P2rt2fWm
         7cYLlhjM9Yx/0wtT9iMWLAmkMtgPdOL3cTGPcdpmgcMqDphqFnWVsGkmcZZMuvovsRNl
         I1mtPY8AzldwZcLsFUo8111d+YjS5TgkcjzDqCTOg5N2ELnVPkA70V6kRhhB99euIq3H
         4Vy8WKV/uJ+BpIUrTvBpWBKtBOk7fkXEyTzAGh+QhYfuv4SzbS6N+mhg129Z8B//TYM0
         FJJ33vuefRYE6SGpRPtpkXeJQRZ2zb1oP28LJVXkhe42J5ENysYPDRhpfnmOa1SOA7ui
         ryGw==
X-Gm-Message-State: AJIora//GDZ2VUDdasz53R7vo8VuWJ3iDL/r5gqmAoWXm+xEwmlLODv3
        qjjYF59NaoyyRq+xSN0VhJ3AZeTbVZ7C486BfMpJqQ==
X-Google-Smtp-Source: AGRyM1uPdNjyKRMzWcP2/055rvVBV0fVI4MOte181aLN7zEuSnDuvuqOS+srKXUr9bNoZ7HGfg9d4uNR7NKEv23mKHE=
X-Received: by 2002:a81:2186:0:b0:313:ab0c:280d with SMTP id
 h128-20020a812186000000b00313ab0c280dmr757404ywh.467.1655140268534; Mon, 13
 Jun 2022 10:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220608060802.GA22428@xsang-OptiPlex-9020> <20220608064822.GC7547@1wt.eu>
 <CACi_AuAr70bDB79zg9aAF1rD7e1qGgFwCGCAPYtS-zCp_zA0iw@mail.gmail.com>
 <20220608073441.GE7547@1wt.eu> <20220613020943.GD75244@shbuild999.sh.intel.com>
In-Reply-To: <20220613020943.GD75244@shbuild999.sh.intel.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 13 Jun 2022 10:10:57 -0700
Message-ID: <CANn89i+9Vq7Kiusp1jJBLgGMprb=psrVaWwz5u4F3dunw2vR3Q@mail.gmail.com>
Subject: Re: [tcp] e926147618: stress-ng.icmp-flood.ops_per_sec -8.7% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     Willy Tarreau <w@1wt.eu>, Moshe Kol <moshe.kol@mail.huji.ac.il>,
        fengwei.yin@intel.com, kernel test robot <oliver.sang@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Yossi Gilad <yossi.gilad@mail.huji.ac.il>,
        Amit Klein <aksecurity@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, zhengjun.xing@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Jun 12, 2022 at 7:09 PM Feng Tang <feng.tang@intel.com> wrote:
>
> Hi,
>
> On Wed, Jun 08, 2022 at 09:34:41AM +0200, Willy Tarreau wrote:
> > On Wed, Jun 08, 2022 at 10:26:12AM +0300, Moshe Kol wrote:
> > > Hmm, How is the ICMP flood stress test related to TCP connections?
> >
> > To me it's not directly related, unless the test pre-establishes many
> > connections, or is affected in a way or another by a larger memory
> > allocation of this part.
>
> Fengwei and I discussed and thought this could be a data alignment
> related case, that one module's data alignment change affects other
> modules' alignment, and we had a patch for detecting similar cases [1]
>
> After some debugging, this could be related with the bss section
> alignment changes, that if we forced all module's bss section to be
> 4KB aligned, then the stress-ng icmp-flood case will have almost no
> performance difference for the 2 commits:
>
> 10025135            +0.8%   10105711 =C2=B1  2%  stress-ng.icmp-flood.ops=
_per_sec
>
> The debug patch is:
>
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index 7fda7f27e7620..7eb626b98620c 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -378,7 +378,9 @@ SECTIONS
>
>         /* BSS */
>         . =3D ALIGN(PAGE_SIZE);
> -       .bss : AT(ADDR(.bss) - LOAD_OFFSET) {
> +       .bss : AT(ADDR(.bss) - LOAD_OFFSET)
> +       SUBALIGN(PAGE_SIZE)
> +       {
>                 __bss_start =3D .;
>                 *(.bss..page_aligned)
>                 . =3D ALIGN(PAGE_SIZE);
>
> The 'table_perturb[]' used to be in bss section, and with the commit
> of moving it to runtime allocation, other data structures following it
> in the .bss section will get affected accordingly.
>

As the 'regression' is seen with ICMP workload, can you please share with u=
s
the symbols close to icmp_global (without your align patch)

I suspect we should move icmp_global to a dedicated cache line.

$ nm -v vmlinux|egrep -8 "icmp_global$"
ffffffff835bc490 b tcp_cong_list_lock
ffffffff835bc494 b fastopen_seqlock
ffffffff835bc49c b tcp_metrics_lock
ffffffff835bc4a0 b tcpmhash_entries
ffffffff835bc4a4 b tcp_ulp_list_lock
ffffffff835bc4a8 B raw_v4_hashinfo
ffffffff835bccc0 B udp_memory_allocated      << Note sure why it is
not already in a dedicated cache line>>
ffffffff835bccc8 B udp_encap_needed_key
ffffffff835bccd8 b icmp_global                               <<<HERE>>
ffffffff835bccf0 b inet_addr_lst
ffffffff835bd4f0 b inetsw_lock
ffffffff835bd500 b inetsw
ffffffff835bd5b0 b fib_info_lock
ffffffff835bd5b4 b fib_info_cnt
ffffffff835bd5b8 b fib_info_hash_size
ffffffff835bd5c0 b fib_info_hash
ffffffff835bd5c8 b fib_info_laddrhash
