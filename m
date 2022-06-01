Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FA453AA2C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355584AbiFAPfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355709AbiFAPfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:35:10 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3856BA3085
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:35:09 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id x13-20020a0566022c4d00b0065491fa5614so1072610iov.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 08:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9C0QKRdIGPxqD8mQkX79ef3/DgDP49Pnes0coHe5ULQ=;
        b=nRIys3gqVC6eGSc+KiDKcYzcv0IpEtYRP40Nor30IhIfH0L99Pv5iqoofmJmEG20v5
         Zh75p0kp0Mqs4gwYpRz6FBiek4jMUMlYqbgDwNY7/NaNFu2Q5mCLMQ6/OyB0wTWNL5hk
         8Slr86s1Nmrb+gk1sC4ZrOngrxJMKPUqm/bqqRarG6JLguYuz+j0gmwno2xPANZANnkW
         oDXGj7NctK6UlHnwz6oIfWQjdabLzR84NaRGxqpYpq/BO+31+9dmi8q5fegyXOl/XCbo
         Zl+cHUVmlkf2qOJjuD+NOKEm6cbVwA6t9pMNYTvZOrZepf+yhTW6q7PmIRjFHusREW84
         4j2Q==
X-Gm-Message-State: AOAM530hrnyZh3Imhk9XdaHn9YHbKTpQuvPPEmXY0t8Da0YNqV6tz5VH
        uForhCKfyufqdeHWOqeRovM3bajzRZbsuMnHt1q6/fRGmC6F
X-Google-Smtp-Source: ABdhPJydphbmRxiHh6D6NWeiIDvir3a/DSN7vD5vVzYJCqeN6VMWeE+V2eQdNwlR3fM5UvfRemMkbxoJrDxwzUY0B6olKGfuCsX5
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2388:b0:330:135c:5568 with SMTP id
 q8-20020a056638238800b00330135c5568mr242450jat.126.1654097708550; Wed, 01 Jun
 2022 08:35:08 -0700 (PDT)
Date:   Wed, 01 Jun 2022 08:35:08 -0700
In-Reply-To: <000000000000915bd505ddaff576@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000578e0105e064a230@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_rawmidi_transmit
From:   syzbot <syzbot+39e3268af9968f153591@syzkaller.appspotmail.com>
To:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        anthony.l.nguyen@intel.com, coding@diwic.se, colin.king@intel.com,
        hdanton@sina.com, linux-kernel@vger.kernel.org,
        naamax.meir@linux.intel.com, perex@perex.cz,
        sasha.neftin@intel.com, syzkaller-bugs@googlegroups.com,
        tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit d098538ed4e8a6c09f86cf243f406c1451066040
Author: Sasha Neftin <sasha.neftin@intel.com>
Date:   Mon Mar 21 06:05:10 2022 +0000

    igc: Remove igc_set_spd_dplx method

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16458313f00000
start commit:   2a5699b0de4e Merge tag 'leds-5.19-rc1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15458313f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11458313f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f915857c44e13980
dashboard link: https://syzkaller.appspot.com/bug?extid=39e3268af9968f153591
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119d1fcbf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17716bedf00000

Reported-by: syzbot+39e3268af9968f153591@syzkaller.appspotmail.com
Fixes: d098538ed4e8 ("igc: Remove igc_set_spd_dplx method")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
