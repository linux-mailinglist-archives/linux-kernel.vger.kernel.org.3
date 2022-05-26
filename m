Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A81534915
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbiEZC5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239304AbiEZC4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:56:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07FD8DDED
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:56:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id d22so259748edj.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/f+kIrdBFHC65DVHSr+BTnTC0fF5q81rMDDOfyiD654=;
        b=Z/rNiCa09OUBCMiQjoRDx83QdZD702DaqjPDsUPMD9T+5L1M4LKv/sAnmlOalu/TF9
         vfhab89ZlrhWprBxvUy4qqjmS6TXouMB1W2bCmtdC+y4kkhHTAIXEWexSFGb8rPos9eF
         bVnf4I0g2l86xNx+ofyWhsIQeBy7iubJ3LdDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/f+kIrdBFHC65DVHSr+BTnTC0fF5q81rMDDOfyiD654=;
        b=SKp71sj5Cw4laW4+eS9zlS+eMNnTpUqBlBltCAp4g1/edwjYP2/HDYQWQRcbspMHOz
         MlzZ6BF7NFq4IHbTqQhOIThG/4qich1Smd1kau4KK8zsmxQ8T6u9qiK1a2mQKaYryi5C
         R4YtzmbMQfSNcu/WlPUklDAp56ZMGmr42z/su9eeZwmHoK5A9ZB9JQnvZDlM8mQA/MX5
         8Gvxd5FXK6t/wpO7Pt3NygIOWqMZF5ptApDQ8ITrBVRb3PsNed+gPBwxO8BToGt/NeJH
         k7mkJHHniDvhGHNRlKezM2+a2AHhOOfCO7MZV2kw3JfRYtwyUjv7dYX5i9cn7SIyUviK
         kX8g==
X-Gm-Message-State: AOAM532pF8Uozyfd6tkVywgThzet+yvLY0oFHKr4zZydSP0/Ain3Q7q6
        DxyG9t/K+HeZD6l7KdLHjiAxjT1QLPWq8T9oTIw=
X-Google-Smtp-Source: ABdhPJyeF2Uqod6/tqiLcWWk05TdZ96UG6zqWiuOWq3ynwDrF5fcnssIvSkEL2W7tuEAaOc+rZEmrA==
X-Received: by 2002:a05:6402:4311:b0:42b:5f80:4526 with SMTP id m17-20020a056402431100b0042b5f804526mr20566128edc.126.1653533808852;
        Wed, 25 May 2022 19:56:48 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id m22-20020a17090679d600b006f3ef214da9sm114697ejo.15.2022.05.25.19.56.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 19:56:48 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id e2so496538wrc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:56:47 -0700 (PDT)
X-Received: by 2002:a5d:58cc:0:b0:20e:643d:e46a with SMTP id
 o12-20020a5d58cc000000b0020e643de46amr28382959wrf.97.1653533807553; Wed, 25
 May 2022 19:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220526022053.GY2306852@dread.disaster.area>
In-Reply-To: <20220526022053.GY2306852@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 19:56:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8R2sYVKi7bgwVN8n-exN766PSJwYg+18SLbR=+vQtVA@mail.gmail.com>
Message-ID: <CAHk-=wg8R2sYVKi7bgwVN8n-exN766PSJwYg+18SLbR=+vQtVA@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new code for 5.19
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <djwong@kernel.org>
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

On Wed, May 25, 2022 at 7:21 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Can you please pull the XFS updates for 5.19 from the tag listed
> below? It merges cleanly with the TOT kernel I just pulled a couple
> of minutes ago, though the diffstat I got on merge:
>
> 105 files changed, 4862 insertions(+), 2773 deletions(-)
>
> is slightly different to the diffstat the pull request generated.

Funky. I get the same diffstat that you list below in the pull
request, not the above.

Different diff algorithms do get different results, so the actual line
numbers vary a bit with the default myers vs minimal vs patience vs
histogram algorithms. But while that changes line numbers, it
shouldn't then change the actual number of files...

I wonder what the difference is, but I'm not going to delve into it
further since what I see matches the pull request and it all looks
fine.

I do notice that if I use

   git diff -C10 ..

to make git more eagerly find file copies, I get

 [...]
 104 files changed, 4444 insertions(+), 3125 deletions(-)
 copy fs/xfs/{xfs_bmap_item.c => xfs_attr_item.c} (13%)
 create mode 100644 fs/xfs/xfs_attr_item.h

and adding "-B/10%" to make git also look for rewrites (ie files that
might be better shown as "remove file and then re-add") gives:

 [..]
 104 files changed, 5449 insertions(+), 4130 deletions(-)
 rewrite fs/xfs/libxfs/xfs_attr.c (43%)
 copy fs/xfs/{xfs_bmap_item.c => xfs_attr_item.c} (13%)
 create mode 100644 fs/xfs/xfs_attr_item.h
 rewrite fs/xfs/xfs_log.h (31%)
 rewrite fs/xfs/xfs_message.h (30%)

so it might be something along those lines where our git configs
differ. I couldn't get it to give "105 files", though.

Not important. I just got curious.

And it might also be as simple as you just having had something else
in your tree at the same time, that you didn't want to send, but
forgot about when you did the test-merge. That would be the simplest
explanation..

> If I've made any mistakes or done stuff that is considered wrong or
> out of date, let me know and I'll fix them up - it's been a while
> since I built a tree for upstream merge.

It all looks fine.

I might wish that your merge commit messages were a bit more
consistent about the merge details ("why and what"), but you are most
definitely not the only one with that, and a number of them are quite
nice (ie the merge of the large extent counters has a nice informative
commit message, as does the rmap speedup one).

And then some of them are the uninformative one-lines that just say
"Merge branch X"

               Linus
