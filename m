Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5769546971
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344912AbiFJPfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbiFJPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:35:03 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148CB1CF178
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:35:02 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id h27so3384989ybj.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C14q5Dy6Du+XHvgXj/VVrOd11AGI0NT/UdqNE8EdfT4=;
        b=Knbu7UAyfQ9/FBzc3DL1apaZSuXrKn83d3MtaAVYfYl0no7peCglt6G2ZzMZzV67dq
         AA705/VF7SMPxEnDOG07G247GA9eif2QHe43vSOQB1WDZM29CSIiPIFG0nObuGBWL/5g
         9cDIjOpqkH90hUqh1OPfGQ2eP3S5DtxFURji18+qpMr8BIqqxYmECZha+3/OaY+a4Go4
         /DLQa1gi83e5YJcJm5gQ4ma5kN6cLPnycMHXGfXtcZ217Hj5Dhz4Pzhwl9+f4yhlg63Z
         dvGUNmc+7vuWipq28hCch+cpXZN7rRF4m0TO+KQ6QBU27ft2JjUB5CNtaLp1JGx3BsBL
         LsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C14q5Dy6Du+XHvgXj/VVrOd11AGI0NT/UdqNE8EdfT4=;
        b=hqlzhZdao9A7F5LCB4rJOIVkQmReO1KLL6cqEhGfIwmCcaJHhVSF3qaeqUpGFtGaTt
         jqYxhcbVobds6+BIbifVDXga/9HXCimCaURQs1PRyI/5mE2mVH6vhCrrn/BBxt5CsnXm
         8hm28wJmMim5U6gAs2Hta95JmsW1u9CfGZZASSE3AiX0uCq/Dx7+gPKaTNF0DOqFfqNu
         NAfEzP8PNVfM07WYwYYR75+XiybjwultnZWHDZzw3CIngDaKc8OEw/QzOk2yvOG13lET
         cG073gwl6DPGglYoNtwhnqvuofzCc2fKwpyMXQfXQ944zUxAZBc83XudzWMs1y9UxQZx
         KElA==
X-Gm-Message-State: AOAM530tJLHpwUSClrUudQr7kA+EKVZkuuWiT5VBLgDBMXyqPVf5pWSo
        rUBrM0m0lt+vslDaQxVeZ8lGZHyXoM8tmyR03Cg=
X-Google-Smtp-Source: ABdhPJyE0wTeNeQSFfZWpdVduVIqNiDJ6Db1s47ilpLanpPzyafdxrAH+yvrGRlISWMDLXFqBCaW6UEvu/qHPAhZKxk=
X-Received: by 2002:a25:d195:0:b0:663:ff7a:b5bc with SMTP id
 i143-20020a25d195000000b00663ff7ab5bcmr13226171ybg.51.1654875301266; Fri, 10
 Jun 2022 08:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de>
In-Reply-To: <87y1y48spg.fsf@jogness.linutronix.de>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 10 Jun 2022 11:34:47 -0400
Message-ID: <CAMdYzYr-Wo713Y4qjboTpoK6GcrYfKCfRJAEizwXw6-=dymVzg@mail.gmail.com>
Subject: Re: [BUG] Threaded printk breaks early debugging
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
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

On Fri, Jun 10, 2022 at 11:05 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> Hi Peter,
>
> On 2022-06-10, Peter Geis <pgwipeout@gmail.com> wrote:
> > However I've run into an issue debugging early boot issues. Anything
> > that causes the kernel threading system to die (for example here, a
> > NPE) causes the boot console to halt before it outputs the error.
>
> A null pointer exception should trigger a panic, which will cause printk
> to enter direct mode for the oops. It should be just as effective as
> before introducing the printing kthreads.

This might be a side effect of the fact that this is on a low powered
arm64 board. I noticed with threading enabled during large bursts the
console drops an excessive amount of messages. It's especially
apparent during the handover from earlycon to the normal console.

>
> Can you please provide a test case or patch that will trigger the
> problem you refer to?

Unfortunately no, unless you have a Rockchip rk356x device with both
DSI and HDMI. We're working on adding DSI support to the new video
output driver, and when both are enabled it tosses a NPE.

>
> > Would it be possible to have both a kconfig option and a runtime
> > option to toggle printk_fallback_preferred_direct()? Currently I've
> > had to force it at all times while debugging.
>
> It would be trivial to provide a boot parameter for this behavior, but I
> think we first need to see a real problem and also see if we can fix
> that problem.
>
> John Ogness
