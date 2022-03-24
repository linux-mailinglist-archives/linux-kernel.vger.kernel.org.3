Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1864E6726
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351742AbiCXQlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351738AbiCXQlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:41:01 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D5E4739E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:39:28 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id o5so9453646ybe.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8UOBFY2l0b9A+kpZ8tf1lAyxdLadr0jYEAlGlUrUMBM=;
        b=S5r43KchMEQw1qXS8oQvSjNUpAs7bGmcq2WNRAI7YIG09sb7fT7HIsqnctoFGWI2T4
         08i0z1pSjYSqpjDC/Ysrl1gEmXSeyX1BdpYUsm4kMFGlcoV5QUgx3fduLHmS9vm5LjnS
         4XKGbL1X6bOcf7/20dbloq0T+4v1gRz6JKjiOvNzyY8M2ln2JF6aub2etu3PIqDmTXCe
         UhJ03WEqDRedN2YW0SDbVN6nFqDn5rwMZlgIMwszIYaSW7IIp88/UL10/MW1ghOrgDVr
         CFeVW/PE0CBJSFbE8rPxcF48z2tblE0+jhREBhsxVEYyd1TKFW4DIe09ttfPlOK+hgWA
         oUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UOBFY2l0b9A+kpZ8tf1lAyxdLadr0jYEAlGlUrUMBM=;
        b=YLRjbICEhsB2Hw/8wpRx7LuTyK/2daBDxRiJ0UQk6OuhYeBkUxktoq6T67KoomBXsx
         Ge6xumhFN3D1VfG0nQ8WeChBb9+lFGKHN7/qH2Z0Wxg65XPr2KX2yjh6qJMsixkr9hZp
         IzLdipRlcGchCUy/gVLpJ3oDabOc4oRIGGy3+vTkjZY9nTRsL3kwGcUp2+8t0bhUD3gp
         rHqEmyZguEf+wfgM6GPD/0AQ0uR3uCOyIsIMnbTWnrwo/3kwMnAaxCRNiE6DIDKdtmvV
         afO0Wxgy+bVdlG4STbxgtMXq2QNySBGpvLUgeUbHcv/fftU+JB0nH6mjfSmyw/aJrMKr
         x1UQ==
X-Gm-Message-State: AOAM532n43HaY4C+1+jOOYlSOrjAUT1NEMevGLbTlmvBkFowL2WKPOM/
        GUk3su1xdLF87YL6E0EC2xac9Wt2glMdBKVYaBshCw==
X-Google-Smtp-Source: ABdhPJxkXt68T+gykq+P1IG8ngyfCwnjTsxxExNkG4ytkuxdArONJO0PpMpNO0C+EIf+9iGo18H4TTvTG4N8WNHB5SA=
X-Received: by 2002:a25:24d:0:b0:633:6b37:bea1 with SMTP id
 74-20020a25024d000000b006336b37bea1mr5148302ybc.427.1648139967726; Thu, 24
 Mar 2022 09:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cabcb505dae9e577@google.com> <CAHk-=wjLL3OB8PvFGBLgUs=zip-Q2m1P=UwG+Pw_E8nYDs+MUw@mail.gmail.com>
 <CAMZfGtW0tN+xYSGGVmxjosTuoRR-mETaNTFNFZu7WuPW2JL9JA@mail.gmail.com>
 <CAHk-=wgW1hEUaQeX41+3w7AGsXkeE1XOXCMndXs3kFp-XjSVzQ@mail.gmail.com>
 <CAMZfGtVRWKhAf-fNWcLQgjb0zBZHX3bQ+aYywfiRsapoLacq3g@mail.gmail.com>
 <CACT4Y+aQOziG8LGiTdyjTTHXJ4tNy2qxJ4yTPy-aUBG9CQB3_w@mail.gmail.com>
 <CAMZfGtUr6V5pTrPhZukD2_KbB7BLPoKvF6H63HP4pykY36Ou9A@mail.gmail.com> <CACT4Y+Z5y8moL4ph=2uNoeJ1oZDaq9oJjEqHtrh0t0Ef7Oag2w@mail.gmail.com>
In-Reply-To: <CACT4Y+Z5y8moL4ph=2uNoeJ1oZDaq9oJjEqHtrh0t0Ef7Oag2w@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 25 Mar 2022 00:38:50 +0800
Message-ID: <CAMZfGtVzUZmz7UObNfEgbxue32_2rivajTbiwZQhGkGhDzLthA@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000517a9505daf97d52"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000517a9505daf97d52
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 25, 2022 at 12:18 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, 24 Mar 2022 at 17:13, Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Thu, Mar 24, 2022 at 4:50 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Thu, 24 Mar 2022 at 09:44, Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > On Thu, Mar 24, 2022 at 11:05 AM Linus Torvalds
> > > > <torvalds@linux-foundation.org> wrote:
> > > > >
> > > > > On Wed, Mar 23, 2022 at 7:19 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > > >
> > > > > > After this commit, the rules of dentry allocations changed.
> > > > > > The dentry should be allocated by kmem_cache_alloc_lru()
> > > > >
> > > > > Yeah, I looked at that, but I can't find any way there could be other
> > > > > allocations - not only are there strict rules how to initialize
> > > > > everything, but the dentries are free'd using
> > > > >
> > > > >         kmem_cache_free(dentry_cache, dentry);
> > > > >
> > > > > and as a result if they were allocated any other way I would expect
> > > > > things would go south very quickly.
> > > > >
> > > > > The only other thing I could come up with is some breakage in the
> > > > > superblock lifetime so that &dentry->d_sb->s_dentry_lru would have
> > > > > problems, but again, this is *such* core code and not some unusual
> > > > > path, that I would be very very surprised if it wouldn't have
> > > > > triggered other issues long long ago.
> > > > >
> > > > > That's why I'd be more inclined to worry about the list_lru code being
> > > > > somehow broken.
> > > > >
> > > >
> > > > I also have the same concern.  I have been trying for a few hours to
> > > > reproduce this issue, but it didn't oops on my test machine.  And I'll
> > > > continue reproducing this.
> > >
> > > syzbot triggered it 222 times in a day, so it's most likely real:
> > > https://syzkaller.appspot.com/bug?extid=f8c45ccc7d5d45fc5965
> > >
> > > There are 2 reproducers, but they look completely different. May be a race.
> > > You may also try to use syzbot's patch testing feature to get some
> > > additional debug info.
> >
> > Do you know how to tell the syzbot to test the following patch?
> > I found some infos from github, it says "#syz test:", is it like the following?
> > Thanks.
> >
> > #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> > master
>
> Yes, this is correct. You can now see the request listed here:
> https://syzkaller.appspot.com/bug?extid=f8c45ccc7d5d45fc5965
>

Cool!.

> but the patch was truncated (probably you email client messed
> whitespaces). In such case it's more reliable to attach the patch as
> text file.

Thanks for your reminder.

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
5abc1e37afa0335c52608d640fd30910b2eeda21

--000000000000517a9505daf97d52
Content-Type: application/octet-stream; name="test.patch"
Content-Disposition: attachment; filename="test.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l157vmgz0>
X-Attachment-Id: f_l157vmgz0

ZGlmZiAtLWdpdCBhL21tL2xpc3RfbHJ1LmMgYi9tbS9saXN0X2xydS5jCmluZGV4IGM2NjlkODcw
MDFhNi4uZGRiMmVlNjI3ZDMyIDEwMDY0NAotLS0gYS9tbS9saXN0X2xydS5jCisrKyBiL21tL2xp
c3RfbHJ1LmMKQEAgLTY3LDYgKzY3LDcgQEAgbGlzdF9scnVfZnJvbV9rbWVtKHN0cnVjdCBsaXN0
X2xydSAqbHJ1LCBpbnQgbmlkLCB2b2lkICpwdHIsCiAJc3RydWN0IGxpc3RfbHJ1X25vZGUgKm5s
cnUgPSAmbHJ1LT5ub2RlW25pZF07CiAJc3RydWN0IGxpc3RfbHJ1X29uZSAqbCA9ICZubHJ1LT5s
cnU7CiAJc3RydWN0IG1lbV9jZ3JvdXAgKm1lbWNnID0gTlVMTDsKKwlpbnQga21lbWNnX2lkOwog
CiAJaWYgKCFsaXN0X2xydV9tZW1jZ19hd2FyZShscnUpKQogCQlnb3RvIG91dDsKQEAgLTc1LDcg
Kzc2LDEzIEBAIGxpc3RfbHJ1X2Zyb21fa21lbShzdHJ1Y3QgbGlzdF9scnUgKmxydSwgaW50IG5p
ZCwgdm9pZCAqcHRyLAogCWlmICghbWVtY2cpCiAJCWdvdG8gb3V0OwogCi0JbCA9IGxpc3RfbHJ1
X2Zyb21fbWVtY2dfaWR4KGxydSwgbmlkLCBtZW1jZ19rbWVtX2lkKG1lbWNnKSk7CisJa21lbWNn
X2lkID0gbWVtY2dfa21lbV9pZChtZW1jZyk7CisJbCA9IGxpc3RfbHJ1X2Zyb21fbWVtY2dfaWR4
KGxydSwgbmlkLCBrbWVtY2dfaWQpOworCWlmICghbCkgeworCQlwcl9pbmZvKCJCVUc6IHRoZSBt
ZW1jZyglcHgpLT5vYmpjZyglcHgpLCBrbWVtY2dfaWQ6ICVkXG4iLAorCQkJbWVtY2csIG1lbWNn
LT5vYmpjZywga21lbWNnX2lkKTsKKwkJQlVHKCk7CisJfQogb3V0OgogCWlmIChtZW1jZ19wdHIp
CiAJCSptZW1jZ19wdHIgPSBtZW1jZzsK
--000000000000517a9505daf97d52--
