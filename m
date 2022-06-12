Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E027C547A5F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 15:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiFLNbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 09:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiFLNbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 09:31:10 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585A32A42B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 06:31:09 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id u99so5949452ybi.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZK9seyLhEtguREoqjcxM6GoxzolaKvu9wYtMvBrtBY=;
        b=ZqoHvd7CG5KBmX1FLe+L8i01SEWKpCro85xP1dfO7EacPV8GIBBrZOMK7iuVRFVLVz
         +jYGoyps1ep5Sa2Jm+hL8kSYMBMiBKkQW5sbeFvpQ26TZlIj0vXu/WlQ1GgBqclK4gPo
         mf/hOTJAWp+YCGDDKjjmkzb2ycDw/S/Xw5HCE2HgbNkzj9avH1+tF3cRO20MmyamiqD3
         0pbopRR3bGNm+6fZX+jXRb/fxIDRPKkCGrm0mVQHo+S7rjy27t0shoUZpZiPnF9/MlzR
         YVHi0Onn/Hg+89vRd7Tx8SDiLSWIxyAiWrxJApmcueW/0ed1m4s3/OFmKvRnYAA1P6EE
         /nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZK9seyLhEtguREoqjcxM6GoxzolaKvu9wYtMvBrtBY=;
        b=CcLimHwNI/VagWtE94q5UgGWDZ8By/w62hqZGWY927rlhp+VpFyzgChBG2eQ6jYkF0
         V6+TLwNEpqrsNKL8ZfCMZJ69di2DcMGaTWsi82EOCquoVhC09wiPNwqx18rOQCeL5smQ
         KtwRo18Iab56Pg/ONa3v+JaLNTzderrxEdmnFoIwJhVhm0hOzUOOgzPjmuwofuZBEnuF
         Jt3SzSIr5xIRWK8qDSyX9pAVOAmPRX+aO2xlD5Exmrk2bx2KIpcMJeb/VT3HjpCAc9cV
         AkbouHKDcpPGMW7H8ZKFHZwDXJM3aAH8D37O63HthmaSBX8xr1CSk00qum3Opn4pZ9VS
         OPcw==
X-Gm-Message-State: AOAM53074bJTHRDk1+NABFdon1Ge/dpFLcEQdLsKqg7e84Ue06y5NtgX
        fqCRZUmDhTR+pRKsGuyHDUUMh8Eg7gzcymEeZl5rJcs3
X-Google-Smtp-Source: ABdhPJw2TF8/MHzEcpbFalBW81mspwFL/pUg0AgJtnIKYyonLvXFewSvngmSeTKGyuRMc78G4MQZlMJ+cz/EbR/4Xzs=
X-Received: by 2002:a25:a066:0:b0:664:411a:1071 with SMTP id
 x93-20020a25a066000000b00664411a1071mr16726400ybh.366.1655040668484; Sun, 12
 Jun 2022 06:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de> <CAMdYzYr-Wo713Y4qjboTpoK6GcrYfKCfRJAEizwXw6-=dymVzg@mail.gmail.com>
 <YqVWL3gpfV9HJBLe@google.com>
In-Reply-To: <YqVWL3gpfV9HJBLe@google.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sun, 12 Jun 2022 09:30:57 -0400
Message-ID: <CAMdYzYoOcLhUpqOEmXQ7t90BOgYczfq0AxK5+JKQqrPo4NGgqw@mail.gmail.com>
Subject: Re: [BUG] Threaded printk breaks early debugging
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
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

On Sat, Jun 11, 2022 at 10:57 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/06/10 11:34), Peter Geis wrote:
> > > On 2022-06-10, Peter Geis <pgwipeout@gmail.com> wrote:
> > > > However I've run into an issue debugging early boot issues. Anything
> > > > that causes the kernel threading system to die (for example here, a
> > > > NPE) causes the boot console to halt before it outputs the error.
> > >
> > > A null pointer exception should trigger a panic, which will cause printk
> > > to enter direct mode for the oops. It should be just as effective as
> > > before introducing the printing kthreads.
> >
> > This might be a side effect of the fact that this is on a low powered
> > arm64 board. I noticed with threading enabled during large bursts the
> > console drops an excessive amount of messages. It's especially
> > apparent during the handover from earlycon to the normal console.
>
> How many CPUs does it have?

Four and all are online when the error occurs.
