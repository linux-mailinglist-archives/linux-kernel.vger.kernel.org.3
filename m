Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C924DE525
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 03:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbiCSCW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 22:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiCSCW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 22:22:28 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF43278572
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 19:21:05 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2dbd8777564so108894807b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 19:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCZT+zb7EAFnc6hRGhTEdVJUiTHs/qJW5IO9CJAQOWU=;
        b=L4Rm7D8CY/Cy1ItHtYjZ+zkXORPWp0pJGh+Usl1EQm/ngUTzG0x49cbRDbFNase4ds
         ttWjz57n96zbgo2S09nW5pp/61QCoum8yjBa5YMMaLsM5RfShwVfEVKgdbfCvpkpyDwB
         O5rKlkfrYJvVBw1ilfZTV7/G3YLRCfHrG2HKbSvQneNFHItNzhpJ8U0H0FMCuulnYmN0
         kAAKNvi7JSe5L+8vZtads4j1YFtI/5bBpubOCasgAOlHPIySkboA3+y4goPlq4QA+ny0
         eLdgPEU+Gb8LijLucwdV5RN98wBWXPO48g8OJoCgbxpCAgcIpOjw8TxICSruv6xlae87
         YFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCZT+zb7EAFnc6hRGhTEdVJUiTHs/qJW5IO9CJAQOWU=;
        b=1jC1V53iRbVm2esxxSgeRLaVUpsz58qVQwcVZtb9hZp9aIZ1k7mPZzn7QX+go/PcNG
         Yx8E/9tvTHwkCMlPUbNni7u72MYDSFvL4i0f+UXS/vSizYidrN+s72IxWzsBFtnkQxtK
         8Ng+jkn1UYCXR2utFky9iZsS2Fr+jS16b1A4Kpffa0pXi6A0A1v4gk6y2/m1KeY/WCFN
         ZOvXLllU8bbGrwe4oYaDZTUHsSA/Lc3M4sRrFeObrw82C9YoQaFfcvnoAKs31Vnngqq4
         YHz6ZOVMDXmHPX2RI4YVBU8PMC4jqEnALLD7L72GNgR2FXw8/yh5FB+wW8mMmD63in1J
         CoJA==
X-Gm-Message-State: AOAM532wlHRk0rBieyGRBk+BJDNMb5jtyrlE2IxMa5ANvK6ahXr+HvJU
        ZFbysT8jTlPb7R2feO48VOD7g6K+0SJxy2PFhEBVhn2X/tNdfQ==
X-Google-Smtp-Source: ABdhPJxedKVItQZjB0XAwvylwOmrCH/rILDsFqkrh8ho0TeJVllNoHD5cX3XGmiHQg2AlPTJIHh5MI4bJ6NUkWDKzS0=
X-Received: by 2002:a0d:d203:0:b0:2e3:3db4:7de1 with SMTP id
 u3-20020a0dd203000000b002e33db47de1mr14219633ywd.458.1647656465178; Fri, 18
 Mar 2022 19:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dda2f905da80c934@google.com> <00000000000009cf1e05da85bb31@google.com>
In-Reply-To: <00000000000009cf1e05da85bb31@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 19 Mar 2022 10:19:12 +0800
Message-ID: <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
To:     syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 6:33 AM syzbot
<syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 2768c206f2c3e95c0e5cf2e7f846103fda7cd429
> Author: Muchun Song <songmuchun@bytedance.com>
> Date:   Thu Mar 3 01:15:36 2022 +0000
>
>     mm: list_lru: allocate list_lru_one only when needed
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495694d700000
> start commit:   91265a6da44d Add linux-next specific files for 20220303
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1695694d700000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1295694d700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
> dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f17d9700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ebabd700000
>
> Reported-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com
> Fixes: 2768c206f2c3 ("mm: list_lru: allocate list_lru_one only when needed")

Does this patch [1] fix the issue? If yes, I am confused why the Fixes tag
should be the commit 2768c206f2c3?  What am I missing here?

[1] https://lore.kernel.org/r/20220315132814.12332-1-dzm91@hust.edu.cn

Thanks.
