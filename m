Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C9F57A513
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbiGSRV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiGSRVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:21:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AABBC0A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:21:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q13-20020a17090a304d00b001f1af9a18a2so7983321pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nxSzpV0hO6sx7HedazM5gIz+cjDlm1nQzCRG9Z5vJw4=;
        b=BvN5J3EWujanwvsvnFMaJpYUNwsY0yMPJOkLcDYs+UuUnVtGxRlLIoDV9g5GkzPwxq
         52X/hPLRXtmdyJHUHmMvZMLYu3HUkVqakqaN++qrSTm9B+5rUxZdugqqQ9z3AlEQkFc+
         MjgDVZOxGa+nSVJVJkzbiSDCYia0bk21XO392ruFTyfoAToTRG3k8hXR+uLWNwlcPRc+
         5IA1YZJWJZrtH7d50JnJ2fyfFoOvqfPTmYGwYjwmNfp0dR612sedDaEaLtRxb9NVgDUL
         G/IHVXn17unEbPu/dWVsUDz0lcpWLFjzsW3YYKdtuWYLt5FPqq6GxVkDSNTDGGYNFXcF
         dn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nxSzpV0hO6sx7HedazM5gIz+cjDlm1nQzCRG9Z5vJw4=;
        b=VGpBkat5qTwnk19EySyCvzPXHeN+ah1TEGUTrmnRxNmfGMr5+QqxE4Ihcp12H+DjUz
         MgUI9LniQhblN0B8ZS9mu9Ir6isCjsqmOK04qkLZa+44B6WFEEH5mX/oaETUnzq+VvTV
         uKnL24Gs+q6DqknJO9SxhckWCoeCxm6AShi5/yGvNoTECDjYA9xxc+6un7hvNEb759Ht
         tDHnkVSCkeYG4H9WN8IxHtwrrw0dtAdmJ6aI49DzYtn3YcwBe+HNx14toQLJTcYCxsi1
         gnUlBTKQ+5rb1TAIeXWipvG94JavJakr7m2TSuhU7fWxIVuaW2zFPchRUt98ORfzZEnr
         yKmw==
X-Gm-Message-State: AJIora86uf90RrmyMVhpPWnbAK4MXJM1PMVwu5x8EsACV7Vi0xCsONFQ
        dt4TzqYJOJnqn+cYMns9Ne4Rtw==
X-Google-Smtp-Source: AGRyM1s0ubt5Hqvnyaii7gg47VKz8saqIw2k4jCYRZag+tqtdg8ytpav2sKq+W+fctch1DenBTiarw==
X-Received: by 2002:a17:902:efc6:b0:16b:dd12:4d30 with SMTP id ja6-20020a170902efc600b0016bdd124d30mr33929304plb.29.1658251284626;
        Tue, 19 Jul 2022 10:21:24 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:893a:f024:99b0:7299])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79f94000000b00528d11c26f2sm11815447pfr.1.2022.07.19.10.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 10:21:24 -0700 (PDT)
Date:   Tue, 19 Jul 2022 10:21:17 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <YtboDUndGtMVGRCU@google.com>
References: <87o7xmup5t.ffs@tglx>
 <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx>
 <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx>
 <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <CAHk-=wiYHXeWnF8Ea5xb735ehJ8FbjTT6UCvHYjX=Ooc7Z5sOw@mail.gmail.com>
 <a6d75b81cdba4a244b142e2f8bb65d71@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6d75b81cdba4a244b142e2f8bb65d71@overdrivepizza.com>
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

On Mon, Jul 18, 2022 at 05:19:13PM -0700, Joao Moreira wrote:
> > The extra instruction is likely less of a problem than the extra
> > register used.
> > 
> FWIIW, per-ABI, R11 is a scratch-reg and should be usable without hard
> consequences in this scenario.

Clang always uses r11 for the indirect call with retpolines, so we'd
need to use another register. Nevertheless, splitting the constant into
two instructions would solve the call target gadget issue.

Sami
