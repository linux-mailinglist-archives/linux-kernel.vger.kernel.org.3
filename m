Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4041A4E1CFB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 18:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245605AbiCTRBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 13:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiCTRBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 13:01:34 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3B74160B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 10:00:11 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id d15-20020a05683018ef00b005b2304fdeecso9120886otf.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 10:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/5C1qwFj67a9zWexu77e4cZW+g5iiQ0ee5PpEYurWY=;
        b=h/LVGRUfDmRkvqBG/eav8GF1N0hkpE+PCZQzL2lNsYNLaeyq82yG8/fncEBms6TWro
         xLL8k0LHFLhrrAh/l5X+aonWiTpNT2zPiauoEf08EZbUH80kak5T4ZeObsBkJychQHjk
         anbLE+I+b6A+r1A4OczkmNL3wmA7xPyFjgxTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/5C1qwFj67a9zWexu77e4cZW+g5iiQ0ee5PpEYurWY=;
        b=gw7JkqkHq1ukFvWftECuO+yTsUb29AmIqq/lzFR5Np3bFHRhWBq/r2MHLaaODEBkZt
         6n2xKh4A8G1ZWqW0ngbatTxeLpuMnTtwyfrlgeCgVcXm9QSUpjEQ72+pE4FxUMV4j+Tf
         Y5UIxnzynRos6sNS8PDAgOJGm2HtC+YdunJgG0IsTE0MpY8kDhEpqbYlyRm35QJ2o1m+
         HBwvlzDMdV0qcIy3WGMbtFm/p0XGPUc+jxs7rl20sS+r6qIEmx50ScxgIlqCaiuchU/h
         EPtK831VcfPuN3Bue7GKE9AD19i27u09pNOfptBpVNysAWyJ5Nwimh86cSWZU9dSuELW
         Ek6g==
X-Gm-Message-State: AOAM532W+FVCV9NoD+JTv6Sy2tTCZAaCw07shi1wfz+sMJ+cw6Lw4LKZ
        uE4FZPCxaQEyu4M1/zKkKXxqJzLukqhbsWGz
X-Google-Smtp-Source: ABdhPJxTOoruiomsTAQPV0ssgfEcoiFw1OgVE1q0jYzqTlAjoj+EYTDb96le+4cshq0SHyZOC8EZZA==
X-Received: by 2002:a9d:720d:0:b0:5cb:6545:57 with SMTP id u13-20020a9d720d000000b005cb65450057mr2881699otj.202.1647795609961;
        Sun, 20 Mar 2022 10:00:09 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id r21-20020a05683002f500b005b249ffa43fsm6493082ote.22.2022.03.20.10.00.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 10:00:09 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id w127so14080192oig.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 10:00:08 -0700 (PDT)
X-Received: by 2002:aca:58d7:0:b0:2ec:a246:ad04 with SMTP id
 m206-20020aca58d7000000b002eca246ad04mr8098261oib.53.1647795608531; Sun, 20
 Mar 2022 10:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <2efd5461-fccd-f1d9-7138-0a6767cbf5fe@I-love.SAKURA.ne.jp>
 <CAHk-=wgiCVcF4vJCOcg1hDw9PMT6zNSgt-pPuZL8ihWEcVv3eg@mail.gmail.com> <e4203c4f-9c3d-6e33-06e8-052676cc5af1@I-love.SAKURA.ne.jp>
In-Reply-To: <e4203c4f-9c3d-6e33-06e8-052676cc5af1@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Mar 2022 09:59:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whWreGjEQ6yasspzBrNnS7EQiL+SknToWt=SzUh4XomyQ@mail.gmail.com>
Message-ID: <CAHk-=whWreGjEQ6yasspzBrNnS7EQiL+SknToWt=SzUh4XomyQ@mail.gmail.com>
Subject: Re: [PATCH v3 (repost)] workqueue: Warn flushing of kernel-global workqueues
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 11:06 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> I know there are in-tree flush_scheduled_work() users.

It's not just that there are in-tree users - there are in-tree users
in CORE CODE anat pretty much everybody runs.

This is not some kind of "it's some broken rare driver that we can't
test because almost nobody has the hardware".

> This patch is intended for
>
>   (a) preventing developers from adding more flush_workqueue() calls on
>       kernel-global WQs.

No. We're not taking stuff like this when core code has it, and will
trigger the same warning.

A warning that nobody will look at anyway, because it's just a single
line in dmesg, and because I bet there are perfectly regular machines
that will trigger the warning with existing users.

For example, I'm looking at that acpi_release_memory() case as an
example - used by ucsi_acpi_probe. I have no idea whether UCSI is
actually all that common or not, but the Kconfig docs say

   "UCSI is available on most of the new Intel based systems
   that are equipped with Embedded Controller and USB Type-C ports"

which makes me think it's not exactly rare.

We're not adding warnings for alleged new uses - when that warning
would trigger on normal system,s.

>   (b) serving as an anchor to be referenced from individual patches

No. You can already reference the existing comment. There's no need to
create a bad commit just to make excuses to fix things up.

> This patch avoids emitting "WARNING:" in order not to disturb kernel testing.

See above: the patch is _pointless_.

And until normal systems don't have the warning, I don't want this
kind of pointless and wrong patch.

> If you want how to convert, I can include it into patch description.

I just want the existign users converted.

Once there are no existing users, we remove the interface.

And once the regular "flush_scheduled_work()" and friends are gone,
*THEN* we can add real verification that nobody tries to flush those
system-wide workqueues.

                 Linus
