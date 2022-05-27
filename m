Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31905362C2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350591AbiE0Mlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353133AbiE0MkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:40:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A6F1A825
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:30:05 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id l30so1546416lfj.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Qa+1ZMKXDipYVZiH4DqDDXVdhhdm8UiF6LTZCsTZAk=;
        b=jnoWM/4bXd6/3S8i7E6RROWqw5Q3r/Opq8dru2NjrmovsEu31qYWFVYYAFRpKM+xLG
         iP48vA/CXfRLV0FeddB0j9PD8H781O+xrJg+PP1/fQNXrFOIKRRBvESy5JrsVZbAWpcH
         Q29xCeNF5oFUNsi2IA2M1nxWl4jI3s/EFnmcfSVqBhPn3avDF98adTNymtz8avaQOSef
         Di11fGfQf/L63AlmwDNjK6u70mIrdCsfCPZ2HHsAnP0O7kHQbC+rOottO1phPElLhWiu
         iur0FMiFtnTMCXaJRX40thJS4TZDRhHYzNpqaZFVPjV1UpsFxWxlxPiE7Yd+7/OU6Jaz
         Clng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Qa+1ZMKXDipYVZiH4DqDDXVdhhdm8UiF6LTZCsTZAk=;
        b=hFsminWOq4vCTExjQBscbHT2ZSufFA8/RCxIMFLr4zl/Uaos1VlODM6X+havGy9RUf
         iyRe3kKfU7ksNDanpJKFhgVdvIfn45gBHDwuBPuoDdYVBsVf0BKYNx/6OxqRSN4dIhvN
         CwOvD0TGwWdTC/E3syJKx4yXMZu2MTl3qDHPPOlOg9I2l2OhzmOFpJO4VimPPqmkRty3
         W79nXAd7MlG3+D1dFWWZYk1K1ZOmos23FfcQFAP+ljIBBAgfyLYzKAsrWIV5zwIZoWxn
         TixTfqYTuog5/uGXMsEt9T/prnDWhwBVsvsimRxEQ9U75oV+cxBVGqgYn7ijvV4HkjZF
         a4MA==
X-Gm-Message-State: AOAM53117+0lQTqdNh+LjK/0pwoo/tKW54wgWJJf68AAWzpctXxudMSE
        Z4+mK0wGFAsQjAatE8th8OtZmWSRHZUyrKZrlU4KeA==
X-Google-Smtp-Source: ABdhPJyT/zlf0aaVyN/7Ekiu3XK/wY5Ir31SlVnBYaqmXj51swK9kyiUEUYHzU7LhBJqeYOiF8BSDJEHabUlJSHwyow=
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr29719365lfb.376.1653654603880; Fri, 27
 May 2022 05:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f2655205dff90da9@google.com> <c674af89-5596-3298-1730-47c0bfe6230d@linux.alibaba.com>
In-Reply-To: <c674af89-5596-3298-1730-47c0bfe6230d@linux.alibaba.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 May 2022 14:29:52 +0200
Message-ID: <CACT4Y+bA4AQvXpuxV19cg-5_LJ7zdYoxEBfNuth2FiAWNiaH0Q@mail.gmail.com>
Subject: Re: [syzbot] upstream build error (18)
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     syzbot <syzbot+a0b95614aef2afe9e488@syzkaller.appspotmail.com>,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.kravetz@oracle.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org
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

On Fri, 27 May 2022 at 10:24, Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>
> Hi,
>
> On 5/27/2022 3:14 PM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    7e284070abe5 Merge tag 'for-5.19/dm-changes' of git://git...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1233ae81f00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=854cea6cbaeb1d1b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a0b95614aef2afe9e488
> > compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm64
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+a0b95614aef2afe9e488@syzkaller.appspotmail.com
> >
> > arch/arm64/mm/hugetlbpage.c:515:9: error: implicit declaration of function 'get_clear_flush'; did you mean 'ptep_clear_flush'? [-Werror=implicit-function-declaration]
> > arch/arm64/mm/hugetlbpage.c:515:9: error: incompatible types when returning type 'int' but 'pte_t' was expected
> > arch/arm64/mm/hugetlbpage.c:516:1: error: control reaches end of non-void function [-Werror=return-type]
>
> I've sent out a fix patch [1], please try it. Thanks.
>
> [1]
> https://lore.kernel.org/all/814e20c19b110209ee12ecae7cb05f8a78d021c8.1653625820.git.baolin.wang@linux.alibaba.com/

Let's tell syzbot about the fix:

#syz fix: arm64/hugetlb: Fix building errors in huge_ptep_clear_flush()
