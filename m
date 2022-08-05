Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2573A58B0C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbiHEUPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiHEUPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:15:00 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FFA2127A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:14:58 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id k12so5402655ybk.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BuvSK/V0ZrRKTjqHjq+/D2pJjzmruPCNM8f6YTDi3So=;
        b=JfVZtcvrjjM5c3/DFrRrII6jtFVVItnLL1BxEQyPgTOrYybcRox8CnOaKTS5BzWUfy
         iX1aic9UF60wqyscoAmuo900iQf3NazGvwC4AGnfj6JAPxy0RIf3mk3x+5HlbiAHUttT
         QQBSh+sTlN6yKrBsOCWNWg1j/jqJg+z/j0dkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BuvSK/V0ZrRKTjqHjq+/D2pJjzmruPCNM8f6YTDi3So=;
        b=4DOHUKOKXG6nE1HCsfJK2ws13argdZ2vQbKcJEL8qR+ovar5M866L6inPNtbv4D3QV
         Ahl0sq3dlNLGLbdiTl2bM8CB4T6i0v1kKhbk29tbJZ5QsOId/N7Am1zPCNktxJNed5ny
         rytdHbaFweXwNDernvqPYzS1EQvPoUQEaHumMpxhVZTiWEloiyfeD7hO6B1pCrRq3hBn
         bIAuTTJfvITz1n0sZOOPuStrF4pW1RYKgPesXF+xYdGGgIQts8HNzohWgrE/SJH8F3GV
         rSpTeeqXtm5f3d/etfJkV+z1FBJh9euGYfSbMwsnT5E6OBkqXtHAAEnRxt48hOXzLPPx
         Ajrg==
X-Gm-Message-State: ACgBeo1WhjQP2ZsDY2zdRxAwjJh6roEfdOCrleQHelg6FNIT5IfBPWQh
        f9J5g3YkHuIiLRv7t9Z1zbb3XKU+1IJ9PfKmZRFUeA==
X-Google-Smtp-Source: AA6agR5pHpD5rHBwIEtOATaPhjzSmS6L0l+TlGZuwOJZsdiIBBueHjlsXtJnN4GzHFgUQaN6uQGikkY/b6A1XiTRIWQ=
X-Received: by 2002:a25:d91:0:b0:67a:7d85:83d9 with SMTP id
 139-20020a250d91000000b0067a7d8583d9mr6739484ybn.373.1659730498053; Fri, 05
 Aug 2022 13:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+wXwBQ-VhK+hpBtYtyZP-NiX4g8fqRRWithFOHQW-0coQ3vLg@mail.gmail.com>
 <20220223115457.7bb575c1@gandalf.local.home> <CABWYdi1aKXWDjT+-aAQvn7eLcySbmeEucVS+8RAbUPE+bprK6A@mail.gmail.com>
 <20220805145333.1360dbbb@gandalf.local.home>
In-Reply-To: <20220805145333.1360dbbb@gandalf.local.home>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 5 Aug 2022 13:14:47 -0700
Message-ID: <CABWYdi05VjumiXUT1sNWrLKxSVm0FeaGzjkVqbesKK3C_8nu=A@mail.gmail.com>
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

On Fri, Aug 5, 2022 at 11:53 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 5 Aug 2022 11:37:56 -0700
> Ivan Babrou <ivan@cloudflare.com> wrote:
>
> > root@foo:~# echo 'bpf_dispatcher_*_func' >
> > /sys/kernel/tracing/set_ftrace_notrace
> >
> > root@foo:~# trace-cmd record -p function_graph -l handle_mm_fault -P 3367417
> > plugin 'function_graph'
> > Hit Ctrl^C to stop recording
>
>
> > [1459709.204253] ------------[ ftrace bug ]------------
> > [1459709.204257] ftrace failed to modify
> > [1459709.204262] [<ffffffffac3ea960>] bpf_dispatcher_xdp_func+0x0/0x10
> > [1459709.204275]  actual:   ffffffe9:ffffff9b:76:ffffffb0:14
> > [1459709.204302] Setting ftrace call site to call ftrace function
> > [1459709.204305] ftrace record flags: 10000001
> > [1459709.204309]  (1)
> >                   expected tramp: ffffffffabc4bcb0
> > [1459709.204325] ------------[ cut here ]------------
>
> Did you reboot since the error happened? Because the command you showed
> should not have touched bpf_dispatcher_xdp_func.

I did reboot, but I can reproduce if you have things for me to try.
