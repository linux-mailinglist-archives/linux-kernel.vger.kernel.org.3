Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2152857A574
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbiGSRfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbiGSRfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:35:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0747E0C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:35:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ss3so28483771ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tnyHXEPt7s4Hu+atwyWT41QjMNO3QXDExK9gYwA1iFo=;
        b=cHu51hj12r7iQc2qyxLjkVoVif3j6nsczpvsYRyUA1j/of+rBAWUDd6qw2jKlzno7F
         r56GwpxwoYHkkUsfxkv1NRmshwA+9f2LnrYO7lDBkrFwqsd1nKbkoG7yEBcSScGiKkjb
         OFEzxrZPv8a2GJc7DF6gAf3Ukd5+mM1000gZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tnyHXEPt7s4Hu+atwyWT41QjMNO3QXDExK9gYwA1iFo=;
        b=azTCWHujfBA0n0v2dw351GxmNrmn/07O8akf1RdEkZjDRU8fPtEgPiQh738AxyhjzX
         v4/nGkR9rnTYfZa2UmnKDZN+KTEq1BqGsFCZif8/5anZ15SeOX749SnQ0wm6GWqqOcmO
         Ww64IJfjMtpAmNQjVKxR0vvaE9quduXgU7VOhnEBLxDzkOc1G2K7maO6GCX0SxzwokkR
         2+skkVUthrUqTFVuw9UskjFhB/fmsRUguCZKUMPLmkDF8lyA4Vw6d3JXwfNxWC5wSIak
         V+qvKOJZzvP7BRuJ9ahqvyprTn5kIzo3/kYJa/bdC9OzL+FyXZs64emzSJtjjoCn/IEP
         9HdQ==
X-Gm-Message-State: AJIora97VC4E20JLIdtDYnx+egEsXOUWOX7VfD3JQxA1D0SHdzypqBCj
        4/fHbSzd1C7L2djuy6clQIXE4cgUi9ZJ9nAMKoM=
X-Google-Smtp-Source: AGRyM1vife3EXrGXSJqBtpSvbY2GpVfynLxUPT40S2OETVMxFmBAEKOuWlS6vgakTcGpZiPNkv2tPw==
X-Received: by 2002:a17:907:6890:b0:72c:7533:8901 with SMTP id qy16-20020a170907689000b0072c75338901mr30734815ejc.100.1658252108251;
        Tue, 19 Jul 2022 10:35:08 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906560d00b006fee98045cdsm7012568ejq.10.2022.07.19.10.35.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 10:35:08 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id n185so9383841wmn.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:35:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec9:b0:3a2:e9bd:fcd9 with SMTP id
 g9-20020a05600c4ec900b003a2e9bdfcd9mr352500wmq.154.1658251636400; Tue, 19 Jul
 2022 10:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx> <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx> <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <CAHk-=wiYHXeWnF8Ea5xb735ehJ8FbjTT6UCvHYjX=Ooc7Z5sOw@mail.gmail.com>
 <0e038c2795784b7eb4de52f77b67206a@AcuMS.aculab.com> <CAHk-=whycTCSPwqV53ybUX=fDKMDk_Y8JaLug3KfUSiMF2TOQg@mail.gmail.com>
 <YtbolH9YegJWUmHT@google.com>
In-Reply-To: <YtbolH9YegJWUmHT@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Jul 2022 10:27:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghqo3OtyR54FkBjkuELubPE3RzRNYU1z90BYtfuaoxzA@mail.gmail.com>
Message-ID: <CAHk-=wghqo3OtyR54FkBjkuELubPE3RzRNYU1z90BYtfuaoxzA@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joao Moreira <joao@overdrivepizza.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Nuzman, Joseph" <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:23 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> The preamble hash is encoded into an instruction just to avoid special
> casing objtool, which would otherwise get confused about the random
> bytes. On arm64, we just emit a bare constant before the function.

Ahh.

I think objtool would want to understand about kCFI anyway, so I think
in the long run that hack isn't a goog idea.

But I get why you'd do it as a "do this as just a compiler thing and
hide it from objtool" as a development strategy.

                Linus
