Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F865336B8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbiEYGYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiEYGYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:24:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9341E56227
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14B60B81C85
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D40C3411D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653459842;
        bh=8JeSY/sJW0TChA7xKBf64BJ4OLClx1fdn0a73g46m4A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dd2exBhd4iziobSgWVVc4i2DZ2clmpTQMzE6Kg7Xg3XcT+Cn8/vgC5stKzx0EmdpI
         OKFu8LN6mYB4ww8q4C+RjlOulNKcz11p6xp6F6XR7eqWmQJiKnA4yiDwlz7xs2PInt
         ZcyQB7HV1V9tROXCcwz/hx8qsJBWKSi5hlBgU2Q9qIAIIx3cMyIs7Q3AE3ShCc22ld
         tly/twutxjFXMD5oF73TYh9Vz0Lh0iJVKFs3JmKeD1XHp6jvIJk/yxOQTnOyf57Ll4
         JXf8URnQit6COQ3p7XaZnWWd1klI34CoiPpaeWcESV67GBY47THY1bGiTNIOZBFUHo
         E6YULeCjYKzAQ==
Received: by mail-ua1-f47.google.com with SMTP id n24so6999883uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:24:02 -0700 (PDT)
X-Gm-Message-State: AOAM530X/SfPgynMLO1H8n6eS3fr3as5L0vxzuL0GZ5VCPQractZyRLW
        MYHRA7hB4JlF6Ro5HILbWc9tNeK2PnkK/5pyekY=
X-Google-Smtp-Source: ABdhPJwuCM250IKJvWb9N4Igtg/fl/O3mlCxq3BqoJ3ItwbOfg0xvWQxiVKJF5CgbSheKVFn+LMtxgRwYLbR35+o1rI=
X-Received: by 2002:a05:6130:90:b0:362:891c:edef with SMTP id
 x16-20020a056130009000b00362891cedefmr10463434uaf.106.1653459841603; Tue, 24
 May 2022 23:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220525014424.20717-1-liaochang1@huawei.com>
In-Reply-To: <20220525014424.20717-1-liaochang1@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 25 May 2022 14:23:50 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS9_1D+K-ok2vxQpbq6B7zxv1K-t8cfcu1hFjF=7a5yxQ@mail.gmail.com>
Message-ID: <CAJF2gTS9_1D+K-ok2vxQpbq6B7zxv1K-t8cfcu1hFjF=7a5yxQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv/kprobe: reclaim insn_slot on kprobe unregistration
To:     Liao Chang <liaochang1@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        jszhang@kernel.org, linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 9:46 AM Liao Chang <liaochang1@huawei.com> wrote:
>
> On kprobe registration kernel allocate one insn_slot for new kprobe,
> but it forget to reclaim the insn_slot on unregistration, leading to a
> potential leakage.
>
> Reported-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
> v2:
>   Add Reported-by tag
>
>  arch/riscv/kernel/probes/kprobes.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index e6e950b7cf32..f12eb1fbb52c 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -110,6 +110,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
>
>  void __kprobes arch_remove_kprobe(struct kprobe *p)
>  {
> +       if (p->ainsn.api.insn) {
> +               free_insn_slot(p->ainsn.api.insn, 0);
> +               p->ainsn.api.insn = NULL;
> +       }
Thx reviewed-by: Guo Ren <guoren@kernel.org>

You also could give a fixup patch to csky, thx:

diff --git a/arch/csky/kernel/probes/kprobes.c
b/arch/csky/kernel/probes/kprobes.c
index 42920f25e73c..661da54b418f 100644
--- a/arch/csky/kernel/probes/kprobes.c
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -124,6 +124,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)

 void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
+       if (p->ainsn.api.insn) {
+               free_insn_slot(p->ainsn.api.insn, 0);
+               p->ainsn.api.insn = NULL;
+       }
 }

 static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)

>  }
>
>  static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
