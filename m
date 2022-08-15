Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA74C5943C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 00:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349422AbiHOWdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350984AbiHOW1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:27:23 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0447C6C755
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:45:59 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id o123so8175260vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SlaiWNqTZoWL+lFJCamcfLR1t+u+g8gF/zBXqP5yDPc=;
        b=TobsT/D9AeL7kSYxDLQc8dWGrs6dhRGxGd3qfeoVBiFnMLiGP4TJxthchSbOuUE4mO
         ciq12U98VGy1yn3HhrlJKkkyZR5AViNPjPtC/i+oaXTBKsGT1Z//fflwTW+agfEf6+Mf
         tFKCy0Uk2HKm013Snihtw1eqLih0ekayliUMdPfmGRUR1LTtQ50/6+a10XYInPDqLLuA
         PdzMyoco4dkxGORhencXVHU3cclCDq7rA5AyfLsTjG71zpiyvU2Hlq7twfJJWbNlX/nc
         VL4cGtrRWRxEul0n8MxpAvCOFeZ4ucv6j4IOXqzIeRxtzM0OsP38XSvjqP6hmNZQL3A0
         vBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SlaiWNqTZoWL+lFJCamcfLR1t+u+g8gF/zBXqP5yDPc=;
        b=oGkqFoD6LbAJtpo/Vp1E/uXo22akfPldxB0AnIHyiC7F36IW+Hv9mu2/GfSbCLxXp7
         c+vWhLk9v//StL3zqz7gymJQLMIo+1FUeSp8h6thJlpDFHxV8LoAuBSmU0/ridhkhnm8
         soVg7bwnKKEdVEGqe02pb/wwNeiKw1ruaAZ//tPgdahYZmYtOgi38CkunHxw1swXvDn8
         obpCDRAmrMbkuDWhALbaA1nNyklR9VJ3p3Dr5grtPVV27gMjHM1voI5foiErTg2pm5pT
         1DhgXC23JN++wUk4+DyxwD5ZU9EzDeI9Y+fcesYw/cKI9HDdB4vF26ZJr+D2aHb6gjzp
         dLsQ==
X-Gm-Message-State: ACgBeo1GR2/SO0s9U9H9ij18pU4Z1wzcTOS93ItZFfpxykdCI768sUI+
        zv52zZxUPUAC1sawP8s2uodw7J/2h9SZvHj2X3HSuw==
X-Google-Smtp-Source: AA6agR78kWY9PviK2xZASsF11776y++DUtP+wf55vu15D0fiqTRz3HsRHH5c3NPmSrL/DIrS8hM4uSzr3N+t+JzlgcE=
X-Received: by 2002:a67:a408:0:b0:38a:dbca:760 with SMTP id
 n8-20020a67a408000000b0038adbca0760mr1557770vse.54.1660592758029; Mon, 15 Aug
 2022 12:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220810210656.2799243-1-eranian@google.com> <0267c94e-7989-ca92-4175-d820d1d63a0c@linux.intel.com>
 <CABPqkBSD5xg=sEkWU01RQ5+aj1X1dtzt2e7FbZBzrcE8dxqM=A@mail.gmail.com>
 <48297c1e-6e44-53f1-da7d-4437ed87cf6f@linux.intel.com> <CABPqkBSUkUTXxS4PwDXYwvTCZ-abY41qyedRGFVoWE9ERtmwsQ@mail.gmail.com>
 <CABPqkBRKpUOEwhbu+YsGTx=bWu6DaeTxcCkcKbx5tkCONnJnRw@mail.gmail.com>
 <2fc8dc1d-6922-e2e0-8b5d-fad25ab12cbd@linux.intel.com> <fa9f74d3-3a5e-9b8c-3142-9377677a6b74@linux.intel.com>
 <6ebd8b96-b589-cded-58f0-76e56a64081c@linux.intel.com>
In-Reply-To: <6ebd8b96-b589-cded-58f0-76e56a64081c@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 15 Aug 2022 12:45:46 -0700
Message-ID: <CABPqkBQS+CUB2TJs4xcHPq+ymr3=OCwxa2pamtLR+r5AyBsmKQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel/lbr: fix branch type encoding
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, kan.liang@intel.com, acme@redhat.com,
        namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 12:37 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2022-08-12 4:16 a.m., Andi Kleen wrote:
> >
> >>
> >> I think the option is to avoid the overhead of disassembling of branch
> >> instruction. See eb0baf8a0d92 ("perf/core: Define the common branch type
> >> classification")
> >> "Since the disassembling of branch instruction needs some overhead,
> >> a new PERF_SAMPLE_BRANCH_TYPE_SAVE is introduced to indicate if it
> >> needs to disassemble the branch instruction and record the branch
> >> type."
> >
> >
> > Thanks for digging it out. So it was only performance.
> >
> >>
> >> I have no idea how big the overhead is. If we can always be benefit from
> >> the branch type. I guess we can make it default on.
> >
> > I thought even arch LBR had one case where it had to disassemble, but
> > perhaps it's unlikely enough because it's pre filtered. If yes it may be
> > ok to enable it there unconditionally at the kernel level.
> >
>
> Yes, Arch LBR should have much less overhead than the previous
> platforms. The most common branches, JCC and near JMP/CALL, are from the
> HW. Only the other branches, e.g., far call, SYS* etc, which still rely
> on the SW disassemble. The number of the other branches should not be
> big. I agree that we should enable the branch type for the Arch LBR
> unconditionally at the kernel level.
>
> Peter? Stephane? What do you think?
>
> > Still have to decide if we want older parts to have more overhead by
> > default. I guess would need some data on that.
>
I don't think you want that. It is okay to have it when it is free. Otherwise it
is best if it remains opt-in.
>
> The previous LBR already has high overhead. The branch type overhead
> will make it worse. I think it's better keep it default off. I think we
> can make it clear in the document that the branch type is only default
> on for the new platforms with Arch LBR support (12th-Gen+ client or
> 4th-Gen Xeon+ server).
>
I am okay with that.
