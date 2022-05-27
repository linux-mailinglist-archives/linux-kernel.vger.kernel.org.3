Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22265357E3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbiE0Cxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbiE0Cxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:53:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A14E52B3;
        Thu, 26 May 2022 19:53:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFAD961D92;
        Fri, 27 May 2022 02:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DB0C36AE3;
        Fri, 27 May 2022 02:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653620029;
        bh=jRrmb+WY8SmmVO2qZ6rXbdCeblMikLu5B7yCzBt4omk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QBg48D/uMB9idZo4/veU2bIN9NhwWSP7GRNS3p+U3eRK4n+CRBrLY4f1GajuLDURt
         OcsqqdflgIO0PdZpO28WUlv2sfIYGpg5hcq4i+R9jmqes00VAUira42Lq5iIpgz97e
         8tJ+yF3oemeLL6STjS0hfeHsBzSw0Hm21REBNeERgFoGjtmzbQz1G4Ca2WLMCeullX
         McqKE636CkW1NJF3MCKLLCA5RJJiWCJPQm1xIUuU30OuYuwGUoyYDbCmnYaTeoBgAd
         uFm35wmiacxyInuMPHfUa8yYwPZH7v/RqTjOSe0HoNjm3btRM4urBapfQ81gRiX1kq
         ijL3kNJH8BTig==
Received: by mail-vs1-f52.google.com with SMTP id h4so3097162vsr.13;
        Thu, 26 May 2022 19:53:48 -0700 (PDT)
X-Gm-Message-State: AOAM532dh1hqZJQJa3FgPpqwPkbb4YxrlxQuvNJZ3WQNuZwg3JglF7ub
        g+2e814o9DNvui5tBHfRkxDevG6J3Kv2Gs+VLSI=
X-Google-Smtp-Source: ABdhPJx67KXeWbGYypI8IYtzCmhK91ZGjgLQH6NToDhTReVD3kt2eb93TvEq8imbj5V9czsxj+H0mpolKkFghtfgBiY=
X-Received: by 2002:a67:c89c:0:b0:335:d83b:df76 with SMTP id
 v28-20020a67c89c000000b00335d83bdf76mr15258150vsk.51.1653620027916; Thu, 26
 May 2022 19:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220525080241.117084-1-liaochang1@huawei.com> <20220527003006.76a52390841f7fba9680d636@kernel.org>
In-Reply-To: <20220527003006.76a52390841f7fba9680d636@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 27 May 2022 10:53:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTW6qpBWw2tEHg+WLywRnAR2G5gqRoYF_inzzS_tEUz=A@mail.gmail.com>
Message-ID: <CAJF2gTTW6qpBWw2tEHg+WLywRnAR2G5gqRoYF_inzzS_tEUz=A@mail.gmail.com>
Subject: Re: [PATCH] csky/kprobe: reclaim insn_slot on kprobe unregistration
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Liao Chang <liaochang1@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        jszhang@kernel.org, linux-csky@vger.kernel.org,
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

On Thu, May 26, 2022 at 11:30 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Wed, 25 May 2022 16:02:41 +0800
> Liao Chang <liaochang1@huawei.com> wrote:
>
> > On kprobe registration kernel allocate one insn_slot for new kprobe,
> > but it forget to reclaim the insn_slot on unregistration, leading to a
> > potential leakage.
> >
> > Reported-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
>
> This looks good to me too. I think this should go through csky tree.
Okay, I would add the Fix line and put it into Linux-5.19-rc2.

>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Thank you,
>
>
> > ---
> >  arch/csky/kernel/probes/kprobes.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
> > index 42920f25e73c..661da54b418f 100644
> > --- a/arch/csky/kernel/probes/kprobes.c
> > +++ b/arch/csky/kernel/probes/kprobes.c
> > @@ -124,6 +124,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
> >
> >  void __kprobes arch_remove_kprobe(struct kprobe *p)
> >  {
> > +     if (p->ainsn.api.insn) {
> > +             free_insn_slot(p->ainsn.api.insn, 0);
> > +             p->ainsn.api.insn = NULL;
> > +     }
> >  }
> >
> >  static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
> > --
> > 2.17.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
