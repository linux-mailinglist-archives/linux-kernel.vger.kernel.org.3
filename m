Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC8F59B31C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 12:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiHUKU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 06:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHUKUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 06:20:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71748140AC
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 03:20:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fy5so16263626ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=LX+6Y3J7NBpt2yMeFwFFwIC5Leg2hEnRCyqHn0VPvDo=;
        b=d07yH0kygyLJOxqLq2147/N73AxZ5f3tGbe8gvFccThsDGfONVLppvTah1r0vZZzrH
         t4tZfFMWo9KLBgJ5A+/RgaqlGX9T2+xBb+LxfBnXArXQmpgxwnX6zqdxqDUZC/R0Ev++
         SYYPvIQ8gMMW1pJfpY2A4tMehVCRhggcL1gtS0qM5H011ju2D2nKjRzoWysrUHcdOlnd
         xa96IvjTF1wfLkVmEeFMNdSyEzfbs49MvQIfqnjHKqtgLdC4eerKfgMwZCDzqnx/+LTj
         h6B6hXxLNmdizUP4zRbSrjQw++6llPyFsajCgKtmEhhHwdV4/ojdsaUi1S/22uLt7jY5
         Xiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=LX+6Y3J7NBpt2yMeFwFFwIC5Leg2hEnRCyqHn0VPvDo=;
        b=1dZg9Au43p6ZuKGDZ1S7EXEJPY/fqEdZgket0omSr39Ep2/bqCoWU7WdhnIsgEFyh8
         vfGAPUAx+R5ArcBqSctCT4lW2P86i9V8DfTBwssffCz0d3ob/4sDlmGIcfXxp4/vvd9L
         hFZ3d0jRlBMane43tzXTgh+Gwu2u1M/wkn+im1SP6PdY0ZbqtE2CdCIu7YxGbkRMHVSQ
         Z7XhQPAp2vye+PgnFLlQYttPutMhKDHToPXD/VnWPDixvVdlhlkwlRVAp+diaA2NPvKa
         GlS10SSfrJJ+EQbo1iMpu93OH3n2QEf+S7bjI68XkE4fzUphM2LIcq+22E0hkluN7hIu
         4dvg==
X-Gm-Message-State: ACgBeo2qAmj9P7UCB+5S2ZHbfIZ/zFd4vxPrjxhnlJZByYo57KIhz2Ww
        rXROTfzaXwk/TL8yHMnuRmY=
X-Google-Smtp-Source: AA6agR4n45dKQUPg4qZz1vUJIc+mbL/zSceMyEviddXqiJNVG5avVlc9HCLXUsgGj61C64BxaWUKIg==
X-Received: by 2002:a17:907:720b:b0:731:6e49:dc93 with SMTP id dr11-20020a170907720b00b007316e49dc93mr10151421ejc.421.1661077253044;
        Sun, 21 Aug 2022 03:20:53 -0700 (PDT)
Received: from gmail.com (195-38-113-151.pool.digikabel.hu. [195.38.113.151])
        by smtp.gmail.com with ESMTPSA id c23-20020a056402101700b00445b3cab975sm6204043edu.56.2022.08.21.03.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 03:20:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 21 Aug 2022 12:20:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Subject: Re: [PATCH v2] x86/unwind/orc: unwind ftrace trampolines with
 correct orc
Message-ID: <YwIHAvSGOmDLZ42k@gmail.com>
References: <20220819084334.244016-1-chenzhongjin@huawei.com>
 <20220819132812.391619d2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819132812.391619d2@gandalf.local.home>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 19 Aug 2022 16:43:34 +0800
> Chen Zhongjin <chenzhongjin@huawei.com> wrote:
> 
> > When meeting ftrace trampolines in orc unwinding, unwinder uses address
> > of ftrace_{regs_}call address to find the orc, which gets next frame at
> > sp+176.
> > 
> > If there is an irq hitting at sub $0xa8,%rsp, the next frame should be
> > sp+8 instead of 176. It makes unwinder skip correct frame and throw
> > warnings such as "wrong direction" or "can't access registers", etc,
> > depending on the content of the wrong frame address.
> > 
> > By adding the base address ftrace_{regs_}caller with the offset
> > *ip - ops->trampoline*,
> > we can get the correct address to find orc.
> > 
> > Also change "caller" to "tramp_addr" to make variable name conform to
> > its content.
> > 
> > Fixes: 6be7fa3c74d1 ("ftrace, orc, x86: Handle ftrace dynamically allocated trampolines")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Would someone from the tip tree care to pull this in?

Picked it up into tip:x86/urgent with minor edits to the changelog - will 
push it out after some testing.

Thanks,

	Ingo
