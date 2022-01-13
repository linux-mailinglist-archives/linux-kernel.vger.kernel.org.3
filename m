Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E348DDE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbiAMSz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237707AbiAMSz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:55:27 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F54C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:55:26 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u25so26649302edf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRiVpEhqgJD+mGewiIi65w1fedUbfZZFb7W9HHAZRIE=;
        b=ct37F4+kNDa/5rStIs6q5gEJQHPbgNgsFIIOgbhuczvIpsihHXfdAvP0aHiEsoL+rp
         aPk9bagtKhFcdssAU0zK/53zynLDefrVybrhHiJe3LQ/Knt24pwdimn7uebHLTPlJyAJ
         LhzOFrLz/C7Lwij0on65wfikAZho0IiSAc/+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRiVpEhqgJD+mGewiIi65w1fedUbfZZFb7W9HHAZRIE=;
        b=rUjBrCPRPW8xvReB7H1vT2QRpzeOFEdpWA5kr1gIJdzwJjyPloV+lGi++61sZ9j8k2
         6auChXG4KsSA4IKSsOFnJS5ekZqRcVkHYYF90YwvUREGEIxYGjungEtY83veTX1OqEZT
         /UzUeiCHkSUu9XxIII9ElR5W4iDUg0hwmp+sJ56L3s6C26Pk55n/UstM/d7sGXOZxGI5
         T67zSokdR+UGrLBpqW1uLksccHDPdtmTU9aa5wFPcWfx7rjFzzQp4MFH3lorDROBKEno
         bRPtSA/YAT64oQ7nM5T2vJ6Mlpj2Q5w6zLtBKhgptGWMv968vusM8v3nCr5zirHVB1wK
         zXJg==
X-Gm-Message-State: AOAM533/lz0fJ2EJ90ei1RRiWPjzRNmOEiakO8O6w+bOWpijEQcyqGnb
        otMdyxXAri5vKmRnCJZqHyKSp6ArmWWpe+fF
X-Google-Smtp-Source: ABdhPJyLTZCBi3heFHewHk8trDegBWC08Vmun98vSfG2bT5gSmu8Vy5oqW/omdkBPzxfYvevdOZSfw==
X-Received: by 2002:a17:906:c0d6:: with SMTP id bn22mr1302484ejb.740.1642100124998;
        Thu, 13 Jan 2022 10:55:24 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id j5sm1133797ejo.171.2022.01.13.10.55.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 10:55:23 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso5995850wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:55:22 -0800 (PST)
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr12264326wmq.152.1642100122506;
 Thu, 13 Jan 2022 10:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org> <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com> <CAHk-=wi21DZ4H5uLnn2QgAeAUqg0wNPboijC0OgDDk1e7TdkPw@mail.gmail.com>
 <c3f34084-7315-e0c5-55db-d1cb006979f4@redhat.com> <CAHk-=wjv+beg2gRNdERANGfaGcqwDzzVD5RDD07FcrE5c6k-XA@mail.gmail.com>
 <0c44a89d-06a7-d0bb-e71e-7947d651f4d1@redhat.com>
In-Reply-To: <0c44a89d-06a7-d0bb-e71e-7947d651f4d1@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Jan 2022 10:55:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg-FvLd9Vyg1+n47gDSSDmHJnjmW0-FaQGJcbrtgbYALg@mail.gmail.com>
Message-ID: <CAHk-=wg-FvLd9Vyg1+n47gDSSDmHJnjmW0-FaQGJcbrtgbYALg@mail.gmail.com>
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Liang Zhang <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 9:55 AM David Hildenbrand <david@redhat.com> wrote:
>
> However, reuse_swap_page() currently does multiple things, and that's part of the issue.

Yeah, I think it's a horrible function. The COW path was explicitly
changed not to use it because it's so confusing.

> While we're at it, is there a real reason we can't simplify to
>
> diff --git a/mm/memory.c b/mm/memory.c
> index e8e2144cbfa6..ab114a5862a0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3295,7 +3295,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> -               if (PageKsm(page) || page_mapcount(page) != 1 || page_count(page) != 1) {
> +               if (PageKsm(page) || page_count(page) != 1) {

No, I think both the mapcount and the ksm check are bogus and should
be removed, but they are both examples of "get rid of the nastiest
complexity, leave the stuff that doesn't much matter".

Somebody who really knows the ksm logic should check all the ksm
tests. I really think they are pointless, and came from the old and
horribly broken page_mapcount() logic that did *not* check
page_count().

When you think page_mapcount() matters, suddenly you have to worry
about all the other non-mapping uses of a page, which is why I think
that ksm test still exists. But I didn't mind keeping a couple of
extraneous tests that I didn't see the point of , as long as the core
page-count-based logfc was solid

          Linus
