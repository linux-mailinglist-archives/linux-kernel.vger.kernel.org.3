Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D54E5D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 04:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243783AbiCXDHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 23:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiCXDHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 23:07:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E879548F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 20:05:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a26so5805228lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 20:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fBzBNoKgFxLGcdpmnlK+MOCq0r40QxmLlPK5Ug935A=;
        b=ad3BgfB5qwNLDlYwYozBzXijd7DTY4dACXftQmRIKeYQVWoX0P864C4A4BNhxDvrxZ
         zkQHQRTpmBxLZKFNhqbsWe8ygl/ECRV61HlHbVNtH3tSg4g+zzvULbxFfCpVYljKn7Bu
         C4WisUApGmIms75xiP1cRui/IJTTj/TsDZhaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fBzBNoKgFxLGcdpmnlK+MOCq0r40QxmLlPK5Ug935A=;
        b=yzdQteS7lqJWZsjCsxLU5d60Sj4oLaYlylKP9t6ZtJA6JKUoqO52jGCEvwxDybm33n
         tbw6p09Gcu9Yu+y8Lp6pkNfOrV7R931lCXL4aKiKQd8Zv6OWK5IEOMpjVWuB7zI38jBy
         35XFXD278Bz2SxywMXdBUNu9btbBolvAYLLZWeFXrXjE63YZ4Te6AT/Xdn3xOW2q/Rjy
         ZeH5FLOZVvuHoBabTUC62pSkhsHc7o9pDvmncrGqMguANVrI2lKR+w8UfmLoASPtiVYM
         T9gbyMfDT22ajhnVpQF0y+h6lfMbI2YlxWPpkDMEoEHbffwhVsZLnrWtQDrWy4tD5k0o
         yokQ==
X-Gm-Message-State: AOAM532uZjnB/+Xl70o6OdnGj6q9HbACHrKTAXgocQSdWEqk9rGSo2WV
        3GnrR0DogtZt2IO9MtYLpk4603awohUToeGJNHA=
X-Google-Smtp-Source: ABdhPJxZC1/Spd0ODPsNAyJZxpGvgcYtpwjLf725LO1fflHXGq4y2klXUERHuO0JwlAfduhnGCcVXg==
X-Received: by 2002:a05:6512:68d:b0:44a:cc2:78b5 with SMTP id t13-20020a056512068d00b0044a0cc278b5mr2106247lfe.43.1648091129503;
        Wed, 23 Mar 2022 20:05:29 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id bu20-20020a056512169400b0043eaf37af75sm166248lfb.199.2022.03.23.20.05.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 20:05:28 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q5so4416289ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 20:05:28 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr2578934lja.443.1648091127827; Wed, 23
 Mar 2022 20:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cabcb505dae9e577@google.com> <CAHk-=wjLL3OB8PvFGBLgUs=zip-Q2m1P=UwG+Pw_E8nYDs+MUw@mail.gmail.com>
 <CAMZfGtW0tN+xYSGGVmxjosTuoRR-mETaNTFNFZu7WuPW2JL9JA@mail.gmail.com>
In-Reply-To: <CAMZfGtW0tN+xYSGGVmxjosTuoRR-mETaNTFNFZu7WuPW2JL9JA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 20:05:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW1hEUaQeX41+3w7AGsXkeE1XOXCMndXs3kFp-XjSVzQ@mail.gmail.com>
Message-ID: <CAHk-=wgW1hEUaQeX41+3w7AGsXkeE1XOXCMndXs3kFp-XjSVzQ@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
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

On Wed, Mar 23, 2022 at 7:19 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> After this commit, the rules of dentry allocations changed.
> The dentry should be allocated by kmem_cache_alloc_lru()

Yeah, I looked at that, but I can't find any way there could be other
allocations - not only are there strict rules how to initialize
everything, but the dentries are free'd using

        kmem_cache_free(dentry_cache, dentry);

and as a result if they were allocated any other way I would expect
things would go south very quickly.

The only other thing I could come up with is some breakage in the
superblock lifetime so that &dentry->d_sb->s_dentry_lru would have
problems, but again, this is *such* core code and not some unusual
path, that I would be very very surprised if it wouldn't have
triggered other issues long long ago.

That's why I'd be more inclined to worry about the list_lru code being
somehow broken.

               Linus
