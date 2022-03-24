Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25344E6094
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349025AbiCXIqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346126AbiCXIq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:46:27 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B55A9BBAD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:44:56 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2e5e31c34bfso43189757b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U0rTbwDMd/5uQMVxOHrK8h1z3AEXugxrJS5vU8Jbm2s=;
        b=kfqxIL1GEmSLP50aI2SsObytHgtl329v2FWvuAW1mh0ud7q9P0uRYiVA994vHaIHJn
         gTJ5lkc4jQlBX7sKoXh2bB9jqrxu4B7xqCUcjI/SSWb706JjJNiMNswQbZsPia2vTyfz
         FxIXSMECfOlf7af27zy4L46FQkTtiaPH6chO9Ydli0JWJ35NX7GnUpteKQychaUSLJD3
         LEywWp/+u1C9pRYp6dgeyNN2o7JX8QpZBmvUPun7PuNn21HlvqvBZHwkPQ0foRueZxEt
         rXBT7J1beSNed1J8Hv2kYmMXDPWp+z+8uJXGmCBlywtIJQforipYaVDmnFUxxRVQ1idx
         FWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U0rTbwDMd/5uQMVxOHrK8h1z3AEXugxrJS5vU8Jbm2s=;
        b=o75KkeQtbkI0yijH3Re2g56G6PV0oCd4dpey0zmRhwto0uaoWRPOfp8ZTtKyNZQqox
         dSQWJrL863A9XaAH13auWDwI1t6gwE/s3fUatQBqThQPZd5tceWtoF+nH8PCf4E08ciR
         DyZzXYPOdU1CBAI2zScU8B2hRf31+Q5BVgM/EWBywOauTwEz1ysM6aWh7IcUkaLq14Aa
         CZ/vvY3hRAxFeUZfTbWp85xM/Xe6e9Yd+4f03O8k8J1DYbVcFpPFbkw4Ti/OKEor/LGD
         tjcPz5CPyVAomHRV9VDq3i+tg8Rw9h9D368N8wcLl9WzvnAdPlBpFpYeSANIENRgvJMA
         m3Wg==
X-Gm-Message-State: AOAM531+InNZIxHJSOKqTiGSXRykgvezH84U1LZ69dj1Ha8V3IJYcG+x
        7KDzRCygyQpKpaOthuqijkh8CEzGZX1O91uLAfFOgQ==
X-Google-Smtp-Source: ABdhPJw8YRcniP1OOPuA2yhslqQljNk3WTgH8zNFt8mCdlaw+kmGNnOajE/rdPsKj/c0NX9u/4t1CFPLnV0lS1Mq5ss=
X-Received: by 2002:a05:690c:827:b0:2e5:a53b:cffc with SMTP id
 by7-20020a05690c082700b002e5a53bcffcmr3753085ywb.31.1648111495436; Thu, 24
 Mar 2022 01:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cabcb505dae9e577@google.com> <CAHk-=wjLL3OB8PvFGBLgUs=zip-Q2m1P=UwG+Pw_E8nYDs+MUw@mail.gmail.com>
 <CAMZfGtW0tN+xYSGGVmxjosTuoRR-mETaNTFNFZu7WuPW2JL9JA@mail.gmail.com> <CAHk-=wgW1hEUaQeX41+3w7AGsXkeE1XOXCMndXs3kFp-XjSVzQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgW1hEUaQeX41+3w7AGsXkeE1XOXCMndXs3kFp-XjSVzQ@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 24 Mar 2022 16:44:18 +0800
Message-ID: <CAMZfGtVRWKhAf-fNWcLQgjb0zBZHX3bQ+aYywfiRsapoLacq3g@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 11:05 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Mar 23, 2022 at 7:19 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > After this commit, the rules of dentry allocations changed.
> > The dentry should be allocated by kmem_cache_alloc_lru()
>
> Yeah, I looked at that, but I can't find any way there could be other
> allocations - not only are there strict rules how to initialize
> everything, but the dentries are free'd using
>
>         kmem_cache_free(dentry_cache, dentry);
>
> and as a result if they were allocated any other way I would expect
> things would go south very quickly.
>
> The only other thing I could come up with is some breakage in the
> superblock lifetime so that &dentry->d_sb->s_dentry_lru would have
> problems, but again, this is *such* core code and not some unusual
> path, that I would be very very surprised if it wouldn't have
> triggered other issues long long ago.
>
> That's why I'd be more inclined to worry about the list_lru code being
> somehow broken.
>

I also have the same concern.  I have been trying for a few hours to
reproduce this issue, but it didn't oops on my test machine.  And I'll
continue reproducing this.

Thanks.
