Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58144510C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351306AbiDZXWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242199AbiDZXWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:22:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF982FFEC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:19:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d6so36616ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=I12FseGpNZFjVRmn5cSNRW69oiEmtDZ/uG4cngFYR/E=;
        b=Tzq1jYp4wkcTjMZv0yfDaecsq7guRfTN1LOyoH5fwLQXplSvz4cqbIV0fpfLsdmSSf
         nPyfjXDwES9SKAaisER0zCniR91iHngrGAnFsU6OfLKHLzn4Ex6Y5ZFHZLb0oCoEIxln
         oR1KihGGEWbnC4pv9KeLdcJCz82xXLL/VQwUiFZdNB0CMzKILGGco5fUBY50qJqfFPaL
         aLibHVvHsLjoXBqbvdQiBRX7nUuj87fh+C553AoJ++6ITz/9asKKAOHLEJOQgA9ZSVXX
         H+ENhvDMUqTdVTmTKUB43LgIP7eU04AL0rgvAUdmO6PPbW3JIwt6pAdtva7Pli4zvESC
         /P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=I12FseGpNZFjVRmn5cSNRW69oiEmtDZ/uG4cngFYR/E=;
        b=h2mVvy+BdxZeatvHQQSqXxLaAQ+rH6j8n7jKdULKxq7Ixp+kc9SEw4AVXUHig3NBch
         u0BsfAFeYMZQbJKmaw/+ZPZKvipzMyYqQcDaM+VqHhR6esN6EamG59Kkz1V2Gkv1bKMI
         8T78vg4uFAM9BdI/Upsc/xg4dlnOTcq8XHYvPaZ0e6kH3kmNU/ihLP+hOsnuu2PNKKxW
         JckjY9TYa5Ypg7NnpSU4mx1Z0MQAlHh9CH9ju0bt56KxYH2lG+VVgyhCEcp8dce9yR83
         ayEZM4mNiTkI8m/+8QKQLxVGidmKJgkn4jSB2Eq5hJLEWMYx1uWXEAgEd9A5kA4joP+G
         eiLA==
X-Gm-Message-State: AOAM531gq/PhveutTm9+u2u14zPEVNcZCes9SMX+oRcGYuEGFlYOwraT
        JTFj3bLlrAem5fCVzKFYnLsdqRX/Nfc2ZtG5MHM=
X-Google-Smtp-Source: ABdhPJxqAHHEcStmtW0maUvW8wuhWOtediVX49nG357iKpxU0MDdLlQ4wVKoPMGgAnPfl4yg9aFZBPO9peiHr9je63g=
X-Received: by 2002:a05:6402:5106:b0:425:f733:8d9b with SMTP id
 m6-20020a056402510600b00425f7338d9bmr8451468edd.326.1651015174287; Tue, 26
 Apr 2022 16:19:34 -0700 (PDT)
MIME-Version: 1.0
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 27 Apr 2022 11:19:23 +1200
Message-ID: <CAGsJ_4x_k9009HwpTswEq1ut_co8XYdpZ9k0BVW=0=HRiifxkA@mail.gmail.com>
Subject: DAMON VA regions don't split on an large Android APP
To:     sj@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, shuah@kernel.org,
        brendanhiggins@google.com, foersleo@amazon.de, sieberf@amazon.com,
        Shakeel Butt <shakeelb@google.com>, sjpark@amazon.de,
        tuhailong@gmail.com, Song Jiang <sjiang88@gmail.com>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>,
        =?UTF-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SeongJae & Andrew,
(also Cc-ed main damon developers)
On an Android phone, I tried to use the DAMON vaddr monitor and found
that vaddr regions don't split well on large Android Apps though
everything works well on native Apps.

I have tried the below two cases on an Android phone with 12GB memory
and snapdragon 888 CPU.
1. a native program with small memory working set  as below,
#define size (1024*1024*100)
main()
{
        volatile int *p = malloc(size);
        memset(p, 0x55, size);

        while(1) {
                int i;
                for (i = 0; i < size / 4; i++)
                        (void)*(p + i);
                usleep(1000);

                for (i = 0; i < size / 16; i++)
                        (void)*(p + i);
                usleep(1000);

        }
}
For this application, the Damon vaddr monitor works very well.
I have modified monitor.py in the damo userspace tool a little bit to
show the raw data getting from the kernel.
Regions can split decently on this kind of applications, a typical raw
data is as below,

monitoring_start:             2.224 s
monitoring_end:               2.329 s
monitoring_duration:       104.336 ms
target_id: 0
nr_regions: 24
005fb37b2000-005fb734a000(  59.594 MiB): 0
005fb734a000-005fbaf95000(  60.293 MiB): 0
005fbaf95000-005fbec0b000(  60.461 MiB): 0
005fbec0b000-005fc2910000(  61.020 MiB): 0
005fc2910000-005fc6769000(  62.348 MiB): 0
005fc6769000-005fca33f000(  59.836 MiB): 0
005fca33f000-005fcdc8b000(  57.297 MiB): 0
005fcdc8b000-005fd115a000(  52.809 MiB): 0
005fd115a000-005fd45bd000(  52.387 MiB): 0
007661c59000-007661ee4000(   2.543 MiB): 2
007661ee4000-0076623e4000(   5.000 MiB): 3
0076623e4000-007662837000(   4.324 MiB): 2
007662837000-0076630f1000(   8.727 MiB): 3
0076630f1000-007663494000(   3.637 MiB): 2
007663494000-007663753000(   2.746 MiB): 1
007663753000-007664251000(  10.992 MiB): 3
007664251000-0076666fd000(  36.672 MiB): 2
0076666fd000-007666e73000(   7.461 MiB): 1
007666e73000-007667c89000(  14.086 MiB): 2
007667c89000-007667f97000(   3.055 MiB): 0
007667f97000-007668112000(   1.480 MiB): 1
007668112000-00766820f000(1012.000 KiB): 0
007ff27b7000-007ff27d6000( 124.000 KiB): 0
007ff27d6000-007ff27d8000(   8.000 KiB): 8

2. a large Android app like Asphalt 9
For this case, basically regions can't split very well, but monitor
works on small vma:

monitoring_start:             2.220 s
monitoring_end:               2.318 s
monitoring_duration:        98.576 ms
target_id: 0
nr_regions: 15
000012c00000-0001c301e000(   6.754 GiB): 0
0001c301e000-000371b6c000(   6.730 GiB): 0
000371b6c000-000400000000(   2.223 GiB): 0
005c6759d000-005c675a2000(  20.000 KiB): 0
005c675a2000-005c675a3000(   4.000 KiB): 3
005c675a3000-005c675a7000(  16.000 KiB): 0
0072f1e14000-0074928d4000(   6.510 GiB): 0
0074928d4000-00763c71f000(   6.655 GiB): 0
00763c71f000-0077e863e000(   6.687 GiB): 0
0077e863e000-00798e214000(   6.590 GiB): 0
00798e214000-007b0e48a000(   6.002 GiB): 0
007b0e48a000-007c62f00000(   5.323 GiB): 0
007c62f00000-007defb19000(   6.199 GiB): 0
007defb19000-007f794ef000(   6.150 GiB): 0
007f794ef000-007fe8f53000(   1.745 GiB): 0

As you can see, we have some regions which are very very big and they
are losing the chance to be splitted. But
Damon can still monitor memory access for those small VMA areas very well like:
005c675a2000-005c675a3000(   4.000 KiB): 3

Typical characteristics of a large Android app is that it has
thousands of vma and very large virtual address spaces:
~/damo # pmap 2550 | wc -l
8522

~/damo # pmap 2550
...
0000007992bbe000      4K r----   [ anon ]
0000007992bbf000     24K rw---   [ anon ]
0000007fe8753000      4K -----   [ anon ]
0000007fe8754000   8188K rw---   [ stack ]
 total         36742112K

Because the whole vma list is too long, I have put the list here for
you to download:
wget http://www.linuxep.com/patches/android-app-vmas

I can reproduce this problem on other Apps like youtube as well.
I suppose we need to boost the algorithm of splitting regions for this
kind of application.
Any thoughts?

Thanks
Barry
