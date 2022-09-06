Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B805AEED6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiIFPbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiIFPag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:30:36 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703B89C205
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:41:41 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j6so8262873qkl.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UJM5srF8hEIXQkbrFMWMpqfmvKyMTxPhXcroonaQ7aQ=;
        b=epwK90jy61HZNipHj8B/Tf8YmC7Qsc3IQVW+IlHHrLXfo8k5D7ZxivfiRbzUQLHUUd
         wLtaPMkqKiEE/Dbedbqv8XPxEnrBV/w/G5Xd1/wVjJba6ZfKbKacxZe1uFkYLfZHY8gc
         5Cg1Oyp96V5d94RRdwEqDgBG5iiWJH2JpMVSo6r0F39OFCHdfBzUI7clZPLo7QFHFbPU
         PSTQiTW4VEfeLMb2IknBj9pjs9T6/edDMMoMjMfxxQ8x0merJzV9oqMLzj7gpki1hd2O
         kurkxImGxOykfUkGrFXkFkwxqp+OiDexOmKn/p58f9mZmq0T/e+8+5j4bqEUp0dRA4R9
         JoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UJM5srF8hEIXQkbrFMWMpqfmvKyMTxPhXcroonaQ7aQ=;
        b=Ggr5aDU3OiBHt93dB50smqIN3gdSMMP3XdIVfZMR7zlnivjb4zkMlT84DnFqWulyiC
         mvwhA4hH6NU6L75ddTSNraA//pHoyLnzPGCv8quzSPDVhrPLki93VQPAdRAkilrx/Mds
         aa97ihDxno5DLmeBhsTIMU3D1Kg01esXgmy3WclMh3j3w0ewhMOtDLupQjoI3NiyvEPe
         ZKWnMU3YpJGOFYqnctejT5rlhEk4oO4/2GL4o/GbghuLlannHLnOokEXHLwGFwlOyHW0
         VUZfqnrUU4mIUyH2PvqdBgWZEZ14lktHT9q3NJKkJiTtsgJqvEEvZd16SdlQQfOs/xx6
         KvIQ==
X-Gm-Message-State: ACgBeo0W/dscdWvunLv5pK1NhCCUNHlWwAI7+hzjklcRlHbxAfAIhqwH
        Zv6AOuWH1oghDULUsvnFwZMfxeGdawuAu2FQIwM=
X-Google-Smtp-Source: AA6agR4MBUJtnIa50hiAS7G9JA5E6Aq1xbxIHPwY3sOf3SUdmPfliYyjNzIfBE9ijKwOdRqDo+ZSK6IXoihAPG5g2ck=
X-Received: by 2002:a05:620a:254f:b0:6bc:5763:de4b with SMTP id
 s15-20020a05620a254f00b006bc5763de4bmr34905718qko.207.1662475208646; Tue, 06
 Sep 2022 07:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004387dc05e5888ae5@google.com> <CA+fCnZc9u+QrF-JCQSA+uCM9-egh_=9x4hPdJng6T_uh6XWMZQ@mail.gmail.com>
 <YxdJ684ypgAy8k98@arm.com> <CACT4Y+YOnTpWT5NCNhsPY=kV=2gFfQkY=7xGdU_1k7AdGhQneg@mail.gmail.com>
 <YxdZXvsWr37RrFRk@arm.com>
In-Reply-To: <YxdZXvsWr37RrFRk@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 6 Sep 2022 16:39:57 +0200
Message-ID: <CA+fCnZf-GOZpnBRLkRPrL7FUwYrAb-bu=PV0zMfbKOuNYrZ00A@mail.gmail.com>
Subject: Re: [syzbot] KASAN: invalid-access Read in copy_page
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tongtiangen@huawei.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>,
        syzbot <syzbot+c2c79c6d6eddc5262b77@syzkaller.appspotmail.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>
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

On Tue, Sep 6, 2022 at 4:29 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> > > Does it take long to reproduce this kasan warning?
> >
> > syzbot finds several such cases every day (200 crashes for the past 35 days):
> > https://syzkaller.appspot.com/bug?extid=c2c79c6d6eddc5262b77
> > So once it reaches the tested tree, we should have an answer within a day.

To be specific, this syzkaller instance fuzzes the mainline, so the
patch with the WARN_ON needs to end up there.

If this is unacceptable, perhaps, we could switch the MTE syzkaller
instance to the arm64 testing tree.

> That's good to know. BTW, does syzkaller write tags in mmap'ed pages or
> only issues random syscalls?

syzkaller doesn't write tags. Or, at least, shouldn't. Theoretically
it could come up with same way to generate instructions that write
tags, but this is unlikely.

> I'm trying to figure out whether tag 0xf2
> was written by the kernel without updating the corresponding
> page_kasan_tag() or it was syzkaller recolouring the page.

Just in case, I want to point out that the kasantag == 0xa from the
page flags matches the pointer tag 0xf5 in the report. The tag value
is stored bitwise-inverted in the page flags. Not that this matters in
this case though.
