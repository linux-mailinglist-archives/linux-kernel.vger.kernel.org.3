Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0FF4DD1EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiCRA2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiCRA1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:27:51 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67561A9C8C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:26:34 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q19so3900898pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epXL49XBlsiDoMlo5NLPPmLnmNNIAccQYNPU/Jj1s5U=;
        b=OQD5axhv7UZBjF2qc0k4ko2pedX/Lb8CPTIHEJOhEh56Iz/yk+viKWMrq2p6xFCyEM
         kRBWTSSBnO+9+wsWAAoTVSEIjR2kFKRrCrMosX67ivFF1zMC7yHuQuquUJM+7hfNbu7p
         S/XvCHwsqWNKx6YSW4MX6oHqeXZ0EtpXakTAjED3FJf0O5V1HrdTjb6RDidcNsNJHPMi
         4+fJy2oAIHttMBGXeP7pF7yyF8yPXQKRQK7c3b2LovgVmRmwZUdtjACISzhogS7GKk3R
         yy/QuLcNaFKipgiHL+YaqwUugK6uieDFK/KVGjq2aK2duF0MuYRyafSvpFg2FiT+KPe9
         PpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epXL49XBlsiDoMlo5NLPPmLnmNNIAccQYNPU/Jj1s5U=;
        b=2JbDFCZWpjH/UisrJBIzlenw7mcNqjTGvugRx4NO8QeOqT2QAbqre2ZTGRQ+94a0uY
         qJoxYLpgMSzPUdes99mtLS8WL/9VPSty/O9ys73QmAsqHFQlU0GWacJ18CYlod2fqNox
         cBrVctKyc09tyJqrtiWZtNkkEaDwwA6jtZ4XiqNE+W/aC3vIHPGsMQtSaZtJ+e0orB9U
         0+H4rTPjrqyKx7H+rrWeqcWAckvzzlQUJB1zaxq5lO8obyD6IHP8i+Zgpa710irly03R
         qy4YOCwlB656Tqp29jvIEFW2evSIwMtW83Di/0951C7QIQsdpV8+byfY6pkLUKsxEizx
         KPuQ==
X-Gm-Message-State: AOAM532j/fJVtdXv/zgXUYlyzsfS1UmQjcRDzB+4v2ZL1eAGqQKxd913
        AVf6Qt1mYDztdllRHNXN93vbDg2DUqEcUOBvgEs=
X-Google-Smtp-Source: ABdhPJyeItmC3/Kc0NMOwglxNGnoxywDrL0VobQf2FWXQj16riiF/ji13DNFD/BXWxWmwgL1OSfouXTi9xNve0Yb46g=
X-Received: by 2002:a63:c00c:0:b0:37c:942e:6c3c with SMTP id
 h12-20020a63c00c000000b0037c942e6c3cmr5939196pgg.336.1647563193972; Thu, 17
 Mar 2022 17:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220317152458.213689956@goodmis.org> <20220317152522.284233550@goodmis.org>
 <CAEf4BzaN_HnyAkVYeUmYoxvW01cFKR2FW0MwZJBL3gvkRw0TYg@mail.gmail.com> <20220317194937.08584828@gandalf.local.home>
In-Reply-To: <20220317194937.08584828@gandalf.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 17 Mar 2022 17:26:23 -0700
Message-ID: <CAADnVQJSZhJo5XK-h6t8oHuNtiPxYx9Zjav=wvm92m-cpTpghw@mail.gmail.com>
Subject: Re: [for-next][PATCH 03/13] fprobe: Add ftrace based probe APIs
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 4:49 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 17 Mar 2022 15:03:33 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > Do I understand correctly that this patch set was applied in your
> > tree? I was under the impression that we agreed to route this through
> > the bpf-next tree earlier (see [0]), but I might have misunderstood
> > something, sorry.
> >
> > Either way, the reason it matters is because Jiri's multi-attach
> > kprobe patch set ([1]) is depending on Masami's patches and having
> > fprobe patches in bpf-next tree would simplify logistics
> > significantly.
>
> I knew Jiri's patches were to go through the bpf tree, but I missed that
> those were dependent on this and you wanted these to go through as well.
>
> I had just finished my automated tests that ran these patches. I haven't
> pushed them to my next branch yet so I can hold them off. I don't have
> anything dependent on them.

Excellent. Thanks for testing.

> Would you be able to take these for-next patches directly (as they all have
> been tested) and you can switch my signed-off-by to Reviewed-by.
>
> The first of the series is unrelated and will go through my tree. That's
> the user_events patch.

Right.
We're talking about this set:
https://patchwork.kernel.org/project/netdevbpf/cover/164735281449.1084943.12438881786173547153.stgit@devnote2/

I believe it has a small doc difference vs what you've tested.
Looks like our CI is green on it too.
We'll do additional testing and add your SOB and Tested-by
before pushing.

Thanks!
