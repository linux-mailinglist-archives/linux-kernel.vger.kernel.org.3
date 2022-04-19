Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB725060DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiDSAWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbiDSAWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:22:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A6E0D5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:19:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b21so26680247lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3DkPb6o1PzrEfvEQlx3KBWUoes3B0+AA9beFlBvYSQ=;
        b=An99LtRG1FkYexpgla3X1/qDm/a/1F14+Uyfx1jAIJ+b6+p6WWVMOIRBbd0541Y35s
         XQHp97t02HymcG61QlrTgCaxBCa+4iY645k3FtZ/oJP1sPWneO1lNg2IJOIzk+sHoBww
         T00CdrYB+oxTVXOnHlRLu3/eV0usgOhJwixlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3DkPb6o1PzrEfvEQlx3KBWUoes3B0+AA9beFlBvYSQ=;
        b=OHj0LGs6P5A+dhrR1hPZQ95SlyTR7ZUV5kVa7yw2p4/DGlYh5wZ4RlMSRlv8rTil6c
         a/FWOZu62uBS4ikZq2p57mG5Uv8EHv8Si4cliYoP9ScuN1zNkKgoc1Ns1+ruZDtDItr+
         ozkeRS9bCNka1IJy8BU3URFh9OHJnWYAHrMaBhGM6MUwAviLOkHMcF5K4SX40n8oM+6Q
         4bNwV1iO3X90H3pftViRyuGnAqm2iV0lDQ7JfiPSIZq2wTlNFe3zBQs/35uq8xtXGTHP
         IpLusjyoVX/jUBkGRE25tkkN4YkOFSvIvUxeCJQR4BK6UWvX3WzShz9dXsSZZGpjc0Xp
         yNoA==
X-Gm-Message-State: AOAM533isLMglpVOF2HEm5Qc8RGki9pAaUY6sBFUY3aEm1aTXRgpbmQ3
        +qlPEhRpwg5zEL7vhioMkKVTbQ9lf0v1HRuqKFc=
X-Google-Smtp-Source: ABdhPJwxDN8TR0P/6fXgJcnKlYQsqJGNrEnwHWGbZenUTCWgy4VMAbyT1NF6Rot5HM/S5pdzl/REQw==
X-Received: by 2002:a05:6512:308d:b0:471:88d8:5798 with SMTP id z13-20020a056512308d00b0047188d85798mr6358820lfd.154.1650327595669;
        Mon, 18 Apr 2022 17:19:55 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id s1-20020ac24641000000b0046d10a0bba2sm1349942lfo.176.2022.04.18.17.19.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 17:19:54 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id p10so26640729lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:19:53 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr9452554lfv.27.1650327593699; Mon, 18
 Apr 2022 17:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220418092824.3018714-1-chengzhihao1@huawei.com>
 <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
 <587c1849-f81b-13d6-fb1a-f22588d8cc2d@kernel.dk> <CAHk-=wjmFw1EBOVAN8vffPDHKJH84zZOtwZrLpE=Tn2MD6kEgQ@mail.gmail.com>
 <df4853fb-0e10-4d50-75cd-ee9b06da5ab1@kernel.dk>
In-Reply-To: <df4853fb-0e10-4d50-75cd-ee9b06da5ab1@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Apr 2022 17:19:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6s5gHCc-JngKFfOS7uZUrT9cqzNDKqUQZON6Txfa_rQ@mail.gmail.com>
Message-ID: <CAHk-=wg6s5gHCc-JngKFfOS7uZUrT9cqzNDKqUQZON6Txfa_rQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2=5D_fs=2Dwriteback=3A_writeback=5Fsb=5Finodes=EF=BC=9AR?=
        =?UTF-8?Q?ecalculate_=27wrote=27_according_skipped_pages?=
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yukuai3@huawei.com
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

On Mon, Apr 18, 2022 at 3:12 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Hmm yes. But doesn't preemption imply a full barrier? As long as we
> assign the plug at the end, we should be fine. And just now looking that
> up, there's even already a comment to that effect in blk_start_plug().
> So barring any weirdness with that, maybe that's the solution.

My worry is more about the code that adds new cb_list entries to the
plug, racing with then some random preemption event that flushes the
plug.

preemption itself is perfectly fine wrt any per-thread data updates
etc, but if preemption then also *changes* the data that is updated,
that's not great.

So that worries me.

             Linus
