Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F9157A613
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbiGSSGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbiGSSGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:06:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F1248E91
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:06:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t15so2100760pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mzb5Z4lYzEx/QvNne+kWXHe3dE7MvmmW8R2SziljTZQ=;
        b=iws/cgY/LU04Xj4DXlB/H4/xL2g/jmk3tvbLLtIS3LW88swZhh9p8V5IeWbcElmdJf
         HSDpGB2J/p8yGEGisqXIrSnHnqwHR9Db/ldCkU16w6KhsfalI9zaohshdbOY4ZQP+Tqh
         UHS3RTp5GiAZ5Hf1QStX/uJRWzoySC69LBZJlXFgf4A1kbeyPluI6z09gyJ4beylspE1
         BKXROi2y9jGRIV13jDfHfiF1tB7w1nyaq7KyYoT+LOJsclHg9iVnUQU0DcB2f+zrvN8b
         WrHX/OTZj+tzNi0x7/QHc9zA6BWE/gh318SjngnZlPvPYTqWTs8nh8TwP/9GvxQ4q5P7
         o8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mzb5Z4lYzEx/QvNne+kWXHe3dE7MvmmW8R2SziljTZQ=;
        b=TxUMlbdx/qEaaLde8zP4R7rZt/kSSghK0TYVoWajoCYRQAmAvE1cGu/3mWDzU9N3tg
         uw3WMv0gNV7KbOLUqNKPsYQR2rwyIS5TpSz0LfsD8TqXwnfS8aWCEUWrvZE1KU8THN29
         Ev7u/L9IMaSX4YACR/g1UZURhdp8lQZr3i53u8P5bQq3ZPDVfXnrYXgz8mT+hvCRq5rU
         WlRsm8kWu1C9Qf36nU8bYV8WkidC25MRunatA8RrwjwuA02VsVJrnNlhUmNlGzpEOjjR
         8a/qdy1haf0O2txcRcGk2D5fTHoDKybSI6xx8AcN8EhmfR0HMV/w3R1XV3Yfdw1MORjy
         T9JA==
X-Gm-Message-State: AJIora/Pi5uwPS+bpjUDxdPbhLV0n2bkytjO9OYGtBqH0FOPJSUOObYj
        rVFDt3eMa16Pmm3hLu9oBhjSDA==
X-Google-Smtp-Source: AGRyM1uagtiFU31sX/Y1AFnGSAEXE8zlgR6JV3fWyjCsmm1YRPewoYF8PxQI6c9GGHXU5D61L7upng==
X-Received: by 2002:a17:902:70cc:b0:16c:60e0:50fb with SMTP id l12-20020a17090270cc00b0016c60e050fbmr34530051plt.156.1658254008214;
        Tue, 19 Jul 2022 11:06:48 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:893a:f024:99b0:7299])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902bd4300b0016c1efb9195sm11972306plx.298.2022.07.19.11.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:06:47 -0700 (PDT)
Date:   Tue, 19 Jul 2022 11:06:40 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joao Moreira <joao@overdrivepizza.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
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
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <YtbysBfeEZJmHtiB@google.com>
References: <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx>
 <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <CAHk-=wiYHXeWnF8Ea5xb735ehJ8FbjTT6UCvHYjX=Ooc7Z5sOw@mail.gmail.com>
 <0e038c2795784b7eb4de52f77b67206a@AcuMS.aculab.com>
 <CAHk-=whycTCSPwqV53ybUX=fDKMDk_Y8JaLug3KfUSiMF2TOQg@mail.gmail.com>
 <YtbolH9YegJWUmHT@google.com>
 <CAHk-=wghqo3OtyR54FkBjkuELubPE3RzRNYU1z90BYtfuaoxzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wghqo3OtyR54FkBjkuELubPE3RzRNYU1z90BYtfuaoxzA@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:27:00AM -0700, Linus Torvalds wrote:
> On Tue, Jul 19, 2022 at 10:23 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > The preamble hash is encoded into an instruction just to avoid special
> > casing objtool, which would otherwise get confused about the random
> > bytes. On arm64, we just emit a bare constant before the function.
> 
> Ahh.
> 
> I think objtool would want to understand about kCFI anyway, so I think
> in the long run that hack isn't a goog idea.
> 
> But I get why you'd do it as a "do this as just a compiler thing and
> hide it from objtool" as a development strategy.

I believe it was actually Peter's idea to use an instruction. :) In
earlier revisions of KCFI, I did teach objtool about the preambles, but
that was just so it can ignore them.

Sami
