Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D9259BA40
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiHVH3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiHVH3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:29:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4091A1AF3D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1D6960FDE
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB14C433D7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661153350;
        bh=+8IijsJUhRwr97hw2sfvQ1Otgz6poc1sQ1PhlZhbT/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a5qj7xC5vJNjRgV1ZxTHLpwCnJjlKAAHOtmykY1X9XbCGIMg+NxCxZ3cefHhAV41g
         /a2y/B9QQ20jaYxAzkxnbXbVRyasERWvQumMppjsgTWS3LwYBR/Udh0R7EvRJWjaMC
         ORNXx0AuFkGPlhmpEunp0HmurgE2AIyCSQanQrn9Om2yZ2JZKHhDkFH1n/00CKWjd2
         VaDa0rMFXkbDvlx2X4PMx/iuA6WSf2xrCUm8bBzggfPqjaLDsRrI3coN1pMcRR7yla
         SNoUyMAnqBgE2bj/G0UsciSNBecRot1Wjrpr706n++1SjAmtQuwwd7P7QZA0gtf3v5
         bMAD7w9ltfUUw==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3376851fe13so235989777b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:29:10 -0700 (PDT)
X-Gm-Message-State: ACgBeo3Lbp1DbtDq1H7MYkCLolCeF2S6X4EkNh+DQvQ9OujWcOZ+BUah
        Oxx0+P+MTzXXaXkiqAVkeT49p8PZg4+rxgyVWQk=
X-Google-Smtp-Source: AA6agR6bvQWqWYbaPzBMiLggEt2XpygU/4px1AFAxazuxHPg+mBhcysm7nQpVyXnWmCHQJjiiqTm78y4dqr/50AA/FI=
X-Received: by 2002:a25:8b92:0:b0:66d:553a:f309 with SMTP id
 j18-20020a258b92000000b0066d553af309mr18260563ybl.322.1661153349149; Mon, 22
 Aug 2022 00:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <87fshpggb7.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fshpggb7.wl-kuninori.morimoto.gx@renesas.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 22 Aug 2022 00:28:58 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6gAHPeRF0cqpi0Z4znWbw+rhz3h4yXYOWQ-__zPY7LoA@mail.gmail.com>
Message-ID: <CAPhsuW6gAHPeRF0cqpi0Z4znWbw+rhz3h4yXYOWQ-__zPY7LoA@mail.gmail.com>
Subject: Re: [PATCH] ftrace: makes ops_references_rec() inline
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 7:31 PM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> commit 53cd885bc5c3e ("ftrace: Allow IPMODIFY and DIRECT ops on the
> same function") changed ops_references_rec() inline to function,
> thus we will get below error if .config doesn't have CONFIG_MODULES.
>
>   CC      kernel/trace/ftrace.o
> ${linux}/kernel/trace/ftrace.c:3149:1: error: 'ops_references_rec' \
> defined but not used [-Werror=unused-function]
>  3149 | ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
>       | ^~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[2]: *** [${linux}/scripts/Makefile.build:249: kernel/trace/ftrace.o] error 1
> make[1]: *** [${linux}/scripts/Makefile.build:466: kernel/trace] error 2
> make: *** [/opt/disk_cd/morimoto/linux/Makefile:1843: kernel] error 2
>
> This patch makes it to inline again, and fixes the issue.
>
> Fixes:  53cd885bc5c3e ("ftrace: Allow IPMODIFY and DIRECT ops on the same function")
> CC: Song Liu <song@kernel.org>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Song Liu <song@kernel.org>

Thanks for the fix!
