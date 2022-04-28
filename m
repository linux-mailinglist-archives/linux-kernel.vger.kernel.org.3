Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB69C512AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242873AbiD1FQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiD1FQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:16:55 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A2A7521D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:13:37 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id m11so4241434oib.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZ0kXxBSl23w8GkxJCbpihVcMvIBI0EhKBEVZyl19iU=;
        b=dvftVoIMKtGIe2CqgEQVSZkJI1zm+fPAvSgmxv4X4kZ7DVd7W6SrmLMRZkZQ6EwSvV
         yT22EXrwEA+DNaLxV2s/XJYBoxapr8kqn7UsTVOUUP8tzzoJoatSFEbfC6TlS7rpIrTc
         OQYmlpnKP7AUCPfB9B7HMIh6hkjBUKWwQ2dT6mwtMroUOz7+A3y9NlYKIg08+X3YWiAO
         OFK4VhpU0R9IuPAOCncrJS2+H2jtFpxvuxmRkBlS6FrBY+SvHLRUgRS8ZlpKgqnjJv3A
         Q+ygVBrbRlqRjbg1KUnPDfeCVmeK4MQe6RdrQZi3rQJROVtACYJuzzR/9n8L2Rnsto5Y
         RjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZ0kXxBSl23w8GkxJCbpihVcMvIBI0EhKBEVZyl19iU=;
        b=TPhX4RQjvTLepsh3mwruFe0d438t5Tr8Q+qYnCHxbDhQBOTiWG2YU3N81CvtnyY7T7
         aRPJU2DcTEaL99vFyFvrx9JycuEM2Zw+4njl/mKzYztMYhMl+CTfoFlBfb2kbn0RCXgG
         MtOoR6TVEszo0hQdyqV6khpdBd1A47u0UkLUBK84gYlJvGJa23XsM43sAIq3n7R6Zf9q
         MOorol+sa3j+jA4qSbx7YC266crPAi9JzTBQqozGbTqyRLopq/X11ak+7AKCn17AOoYf
         jrX9g9FJbgvKlUOeryJ0GTcfdvtIEtrqwjAjX3nhBNIdAVksE0i6xDRfJRnX1TDZ88FQ
         xDGg==
X-Gm-Message-State: AOAM530gyb8AhCSgH5Adv4Thild5sA2oGMjI5qwggvq1P0YfjP3jWZcP
        9d1IY9jJ1hcg3+xrdFtPJ9M4gUPgYzi8jIvXYClBnQ==
X-Google-Smtp-Source: ABdhPJy3HFzFNgAPmuC1QL08wYl+z2x2VruD9o0uNrzOW+yxDSEP76x8hxU5uC3/wq1Efr/Hz7pL3BCyhhsnTJAk0/w=
X-Received: by 2002:a05:6808:21a1:b0:322:b5a1:b261 with SMTP id
 be33-20020a05680821a100b00322b5a1b261mr19509167oib.211.1651122816673; Wed, 27
 Apr 2022 22:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a23c8505dda227eb@google.com> <000000000000f28f0005dda29992@google.com>
 <20220427102032.5a87283eb64d06c1a6d682fd@linux-foundation.org>
 <20220427175218.cazytgdlpc6lpn45@revolver> <20220427190622.wgoxjjbmphdo3xxw@revolver>
In-Reply-To: <20220427190622.wgoxjjbmphdo3xxw@revolver>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Apr 2022 07:13:25 +0200
Message-ID: <CACT4Y+YvDPF=_cEZ5bREPN1tgqdMYydiEmDbtzrTq_C2CyyT5w@mail.gmail.com>
Subject: Re: [syzbot] WARNING in vma_merge
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Peter Xu <peterx@redhat.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 at 21:06, Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [220427 13:52]:
> > * Andrew Morton <akpm@linux-foundation.org> [220427 13:20]:
> > > On Wed, 27 Apr 2022 06:15:20 -0700 syzbot <syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com> wrote:
> > >
> > > > syzbot has found a reproducer for the following issue on:
> > >
> > > Thanks.
> > >
> > > userfaultfd_release() appears to have offended vma_merge().
> >
> > Potentially apply_mlockall_flags() and not userfaultfd_release(). There
> > is a potential that the vma iterator is stale if a split/merge succeeds,
> > although KASAN should pick this up and KASAN is active according to the
> > config below. I've sent a patch for the mlockall issue after Qian Cai's
> > reported it to linux-mm.
> >
> > >
> > > I'm not seeing any changes in that area from Peter, but Liam's
> > > mapletree work changed things around a bit.  Gents, could you please
> > > take a look?
> > >
> > >
> > > > HEAD commit:    f02ac5c95dfd Add linux-next specific files for 20220427
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=105a33a2f00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=e9256c70f586da8a
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=7728e4ab5371cebc9c00
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f76f82f00000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b42c3cf00000
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com
> > > >
>
> ...
>
> >
> > I cannot get this issue to trigger with the given tree and git repo with
> > my config.  I will try again with the kernel config above.
>
>
> I was able to reproduce the issue using the config from syzkaller in my
> VM and can confirm it was the apply_mlockall_flags() bug also reported
> by Qian Cai [1].  The patch I sent earlier [2] fixes this issue as well.
>
>
> 1. https://lore.kernel.org/linux-mm/20220427161033.GA1935@qian/
> 2. https://lore.kernel.org/linux-mm/20220427165139.5s3qcj2u5vqrvwlc@revolver/
>
> Thanks,
> Liam

Let's tell syzbot about the fix:
#syz fix: mm/mlock: use maple state in apply_mlockall_flags()
