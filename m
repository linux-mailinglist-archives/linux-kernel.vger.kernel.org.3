Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD485915C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiHLTDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHLTDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:03:40 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D657AE6C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:03:39 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 199so2840473ybl.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3WrnfzUEkDBhIosmCHTih2AdmfL8Xn5M/6UF69F+rxw=;
        b=OAWJKR/khgs3Z1U0Y+r4xBVak7HVj2xuq98+RABrnIs5UxKgQXaB4Ex+YD5DnEzxd/
         08mJ4LQlF/8v1g+WhRoqzGOZTqvlN20vVQhS9qqjZ2yopHkNSXyXl00P3+zz5rbC0YbK
         +TxC0uFopeGQ1ug2pTUNE0zY8KFnIMghkT76A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3WrnfzUEkDBhIosmCHTih2AdmfL8Xn5M/6UF69F+rxw=;
        b=okt8eq1M1sSbNVw4LkYg5MBQRAVEJEQAJ3sESk7bautCHskt/F/0x+bSmP7d92iqxB
         fux17EdeNF9Hzfyqo1eg+wTgG4ntRSuvi21SbrmduxKsYQrRNIHuw9C+v7/wUgO9ex2H
         XSaQHL43N7LpW06zI1sHLrdKY8RV3VxSCj6FzjIdmc6Ij4dtiJjOmDWc/J4H16tQBN9G
         6cko7VTQT7gWd3PDaxqqnL+z/HrtuxuQSN6+v5Al7e8Thd7VIkO/tIkzYXW5mYX7bcPj
         n2NrXRb9QmYI3Xe5DhRlLw/TbVwvpucvXJ3DAoqiiSXujDc+7vE/NwAhb7Fy9SCLwY8Q
         mKPA==
X-Gm-Message-State: ACgBeo2QSEp7n0at0RGFdDBMAV87WubcW/5XbVnIevmfs6JRBgLKof8r
        dEdI5SDOemW0Y0lzdrlXWjhRVC0mA9ZZMRpfURqO8Q==
X-Google-Smtp-Source: AA6agR41gBVRH6yIzkojZUp0kN1vGjaEAeHHVEF0YtKnHncRTaO93M/DBsIYDgmBMYgfw32f25kVJksLNiG1V1jnCro=
X-Received: by 2002:a25:d496:0:b0:676:f547:cb5b with SMTP id
 m144-20020a25d496000000b00676f547cb5bmr4450767ybf.115.1660331019065; Fri, 12
 Aug 2022 12:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+wXwBQ-VhK+hpBtYtyZP-NiX4g8fqRRWithFOHQW-0coQ3vLg@mail.gmail.com>
 <20220223115457.7bb575c1@gandalf.local.home> <CABWYdi1aKXWDjT+-aAQvn7eLcySbmeEucVS+8RAbUPE+bprK6A@mail.gmail.com>
 <20220805145333.1360dbbb@gandalf.local.home> <CABWYdi05VjumiXUT1sNWrLKxSVm0FeaGzjkVqbesKK3C_8nu=A@mail.gmail.com>
 <20220805182552.742c4162@gandalf.local.home>
In-Reply-To: <20220805182552.742c4162@gandalf.local.home>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 12 Aug 2022 12:03:28 -0700
Message-ID: <CABWYdi0BumUX=UzzMDp1H2G40TSh9mL5chyAc6f7Mfgv1yW2pA@mail.gmail.com>
Subject: Re: 5.15 ftrace bug when enabling function_graph
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Dao <dqminh@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 3:25 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 5 Aug 2022 13:14:47 -0700
> Ivan Babrou <ivan@cloudflare.com> wrote:
>
> > On Fri, Aug 5, 2022 at 11:53 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Fri, 5 Aug 2022 11:37:56 -0700
> > > Ivan Babrou <ivan@cloudflare.com> wrote:
> > >
> > > > root@foo:~# echo 'bpf_dispatcher_*_func' >
> > > > /sys/kernel/tracing/set_ftrace_notrace
> > > >
> > > > root@foo:~# trace-cmd record -p function_graph -l handle_mm_fault -P 3367417
> > > > plugin 'function_graph'
> > > > Hit Ctrl^C to stop recording
> > >
> > >
> > > > [1459709.204253] ------------[ ftrace bug ]------------
> > > > [1459709.204257] ftrace failed to modify
> > > > [1459709.204262] [<ffffffffac3ea960>] bpf_dispatcher_xdp_func+0x0/0x10
> > > > [1459709.204275]  actual:   ffffffe9:ffffff9b:76:ffffffb0:14
> > > > [1459709.204302] Setting ftrace call site to call ftrace function
> > > > [1459709.204305] ftrace record flags: 10000001
> > > > [1459709.204309]  (1)
> > > >                   expected tramp: ffffffffabc4bcb0
> > > > [1459709.204325] ------------[ cut here ]------------
> > >
> > > Did you reboot since the error happened? Because the command you showed
> > > should not have touched bpf_dispatcher_xdp_func.
> >
> > I did reboot, but I can reproduce if you have things for me to try.
>
> Let's see if this works manually.
>
> Reboot again.
>
> Make sure the above "ftrace bug" is not there.
>
> If not already mounted, as root:
>
>  # mount -t tracefs tracefs /sys/krenel/tracing
>  # cd /sys/kernel/tracing
>  # cat enabled_functions
>
> Let me know what is there.
>
>  # echo handle_mm_fault > set_ftrace_filter
>  # cat set_ftrace_filter
>
> to make sure that handle_mm_fault is listed.
>
>  # echo function_graph > current_tracer
>
> If it fails again, let me know. It should not, but if it does, it needs to
> be investigated.

It does not fail this way. It also doesn't fail when I run perf:

perf ftrace -N 'bpf_dispatcher_*_func' -G handle_mm_fault -a -- sleep 1

It does fail without "-N 'bpf_dispatcher_*_func'".

I suppose there's something about trace-cmd that makes it fail for me.
