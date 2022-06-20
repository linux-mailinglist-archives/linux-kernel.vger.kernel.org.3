Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7938155176F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbiFTL2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbiFTL2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:28:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7483014039
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:28:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a13so6895438lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=meVnAecWUQF25yX15/OHTINDjMs2a72gykuqkkrcMHA=;
        b=ja7p7ZQ21wVeFQaYtfTriKaBLxv+4hXdVybTDLc87wxIudSr0d93DXPS99czmRxzyU
         BC1GIWDWhFU2WUaiO09wg7Xv23g2UEbcHFzkULTyBsSD+qxmTje77/d5XxuBN7PTzp9f
         KTo6wMJzdK0bc4RTTqDG7sb3hjICqY49kcKg6+AinaOM433oUGOfzRZkSK6EOd/PIF5c
         UnoLjRNNefRB6/BhadhHYOI+YfwT9X5qxLTGC5C2bKWA6TiZC2NYPJg4aVfFNLz6IZ8I
         4ZXTQmszKEBvx99ZGOH2d10z6gVa8LWCJNONkFicCYzR4dLFetHbdtyJoStVAVdP13Tg
         DWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meVnAecWUQF25yX15/OHTINDjMs2a72gykuqkkrcMHA=;
        b=TiwiQQQphvpCy0CYcxSXf+Ud8fYO4ml+YVuFTvIk88lxZ9FNpH/nD+Dpzu2foP9Js3
         SnIOBt07Aj2NLMjXraoTO5XJVnxTfWWVISVfTItMfEZCDXtyuL1J48rEb13X7BXtOvx1
         bT9BmUtmFOfZYLJewggMDiIEfakneaqBcsLVb8Kd6HAYxCo5IhSUNLKF1U9y0eXBjkE7
         L6nsttungMrCmnuft+wm4hFSCI4OmZt0Af36ES0d85v6lKuYLzsgaOfrdM+DgltCPazn
         BsuSyY/yWZYBKmhMDfgDb12eENNViPM8ObT4tpA5HDv+CXbDgxbYOE6Ar3gCiN3Tkq6S
         d9tA==
X-Gm-Message-State: AJIora/slvVN1N+Ct+p6ePDUPcVDuP2r+Nz5jpPscok5v7w98oIvIIVF
        Db8PHJFs+ghrUsDQZ6T9xTsU9bn5MGCwtHA+Ket+DA==
X-Google-Smtp-Source: AGRyM1uv77nKs/dsjnRJ7SVGnCgZPNgaNGRos4I+PHQ0GKelzlJR25a2gvPMN1e3LTNRKQd6+bOEXWvUNAJ+AnKXzGQ=
X-Received: by 2002:a05:6512:3191:b0:47f:646d:56c3 with SMTP id
 i17-20020a056512319100b0047f646d56c3mr5972097lfe.206.1655724507522; Mon, 20
 Jun 2022 04:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007ba8cd05d0c1c3b0@google.com> <00000000000071951f05e1c4d7c8@google.com>
 <YrAJNuGg8n6f9Fcw@google.com> <CACT4Y+aFArPDsyvpNko+_eZi=1UTd2NxfejiyawRA0aKScWmJA@mail.gmail.com>
 <YrA8vzVjxJIrZFBz@google.com>
In-Reply-To: <YrA8vzVjxJIrZFBz@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Jun 2022 13:28:15 +0200
Message-ID: <CACT4Y+ZifXiJL=vvbvL8Ug5apq9-h50rZJusyMSRo_OYdFUPzQ@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in console_lock_spinning_enable (2)
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     syzbot <syzbot+3cc1054e15babd5f4cd2@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, glider@google.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, pmladek@suse.com, rdunlap@infradead.org,
        rostedt@goodmis.org, swboyd@chromium.org,
        syzkaller-bugs@googlegroups.com
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

On Mon, 20 Jun 2022 at 11:24, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/06/20 10:16), Dmitry Vyukov wrote:
> > On Mon, 20 Jun 2022 at 07:44, Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > On (22/06/18 20:47), syzbot wrote:
> > > > syzbot suspects this issue was fixed by commit:
> > > >
> > > > commit faebd693c59387b7b765fab64b543855e15a91b4
> > > > Author: John Ogness <john.ogness@linutronix.de>
> > > > Date:   Thu Apr 21 21:22:36 2022 +0000
> > > >
> > > >     printk: rename cpulock functions
> > >
> > > I'd rather guess that it was console kthread patch that fixed the problem.
> >
> > Hi Sergey,
> >
> > Do you mean this commit:
> >
> > author: John Ogness 2022-04-21 23:28:48 +0206
> > printk: add kthread console printers
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09c5ba0aa2fcfdadb17d045c3ee6f86d69270df7
>
> Yes, I'd assume so. The patch removes
>
>         tty -> printk -> tty
>
> which re-enters tty in unsafe manner, and replaces it with
>
>         tty -> printk -> wake_up console printer


Thanks. Let's tell syzbot so that it reports similar issues in future:

#syz fix: printk: add kthread console printers
