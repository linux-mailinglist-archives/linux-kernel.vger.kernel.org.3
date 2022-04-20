Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96C509215
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382518AbiDTVbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382508AbiDTVa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:30:57 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE30845040
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:28:09 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id o9-20020a0566022e0900b00654b599b1eeso2002610iow.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6orOFsy74rNN5Tn6BrnH+g4zIxPrQE5SyUBi8riN0xM=;
        b=JPTkwpHk1J+DYyPBeJB67O5VEGnNVJElqvelxUmfOwzWXFdLcqg171NUVsvqeW77Fn
         eRtIvlZdLqAb06fYZyaMgKw7UvaC0Yp9VzNFXO6QmncriYy9CPgzjvxxULs6Vihr8drX
         5/rN0B0ogHZjSxlpv9REvj78osvsrOsWW5uWlv7HpUYPDB15pJR2xgY0LP73+nHr5MLq
         L3Pq/g9eAyUMcfpaQB7A783Za67aZob8WL8JzprbW4dUH0XSZ7WiLPN+N9NepNapsvf7
         GowrlOlhQye4Q4/vhBeIRW/wlbnQwhTkRd7dSq75+dYfdivBEQUSjVUWzpFhDr9EXQEt
         9qyg==
X-Gm-Message-State: AOAM533w2kdzpVfMBmv+ctjn4SmYAPrAqK5dilfsaYKnewVjh2DAy/rT
        Q9JuSpnC4vcZCLSN9lt2qgFn+KrRhzVxrBF1NgO3R+O1CYzy
X-Google-Smtp-Source: ABdhPJzgN+9LkncxNGek29FEzvDqYn7T+0paLfjRepDM958YF10ope2I5QGSX4+kSi2/D4KHU/1JAYks7qeWBzSeF0qDXlyP38dc
MIME-Version: 1.0
X-Received: by 2002:a05:6638:19c8:b0:328:6a22:8258 with SMTP id
 bi8-20020a05663819c800b003286a228258mr9997908jab.103.1650490089346; Wed, 20
 Apr 2022 14:28:09 -0700 (PDT)
Date:   Wed, 20 Apr 2022 14:28:09 -0700
In-Reply-To: <0000000000004ecea505c28504b9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b1cbd05dd1cab5a@google.com>
Subject: Re: [syzbot] general protection fault in pm_qos_update_target
From:   syzbot <syzbot+f7d9295d2565ee819d21@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz, perex@perex.cz, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 3c3201f8c7bb77eb53b08a3ca8d9a4ddc500b4c0
Author: Takashi Iwai <tiwai@suse.de>
Date:   Tue Mar 22 17:07:19 2022 +0000

    ALSA: pcm: Fix races among concurrent prepare and hw_params/hw_free calls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=104e3034f00000
start commit:   dbb5afad100a ptrace: make ptrace() fail if the tracee chan..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=91ff0467ce169bc
dashboard link: https://syzkaller.appspot.com/bug?extid=f7d9295d2565ee819d21
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c75e73d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ALSA: pcm: Fix races among concurrent prepare and hw_params/hw_free calls

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
