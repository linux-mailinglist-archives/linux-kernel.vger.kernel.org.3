Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26064D97C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346686AbiCOJh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346678AbiCOJhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:37:24 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284194E389
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:36:12 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id z10-20020a056602080a00b00645b9fdc630so14156912iow.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=scxpqyv1QCaqaidKXli17C6qUPYI7CzIakzRF5Ou8Kg=;
        b=YYRhh5byU6GjL+p+sEekb030vbYqDrslzVejJFRhDeydBcS9VAosNueBSLUbsH/Riw
         /sdFl4DE+d0sW1NsaC1apwIldom+oSd8G+n0Q+qaz7LvkMDVvEME8FIxpAVXJM1nsOo/
         13INK4c1PMGIeXoyoyk5+AZSSiqe5OtWWKLvoQXYWDxrd7SdFj5cOYBe+6TDwLHdKv7l
         4oLt9eUghGwXg4DtaiIxFvq52lxW10kex3uxzgf4kW4hqVIQfHJKuHrz6gVSjVl+WePO
         pJqrLQrus6l0hSBJHPtM2QW1Hy5Wsne/hAe0rJNVFkrYulVfSTwbbG8MQs8YIkOAwtBM
         mcHQ==
X-Gm-Message-State: AOAM5333Sr0KvhHLVsR6sjSgbNciQJQdjFFW2rldqpS1xtbKPc9/cVp7
        0xSnWC0QB8lvZB9pRDXtEoWEPkIuGz42oNeyXzkkPFCC5n/b
X-Google-Smtp-Source: ABdhPJxuGoffg/pqrbkgpJV8mQBOrM3W+1KUP7ru6GCbSnpEcm7RSNXialOrf39P4ZLfattjVwZw+j4AThI3Al+cbuX6d+5XO7C/
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3415:b0:648:b4f6:6e4d with SMTP id
 n21-20020a056602341500b00648b4f66e4dmr18825594ioz.98.1647336971535; Tue, 15
 Mar 2022 02:36:11 -0700 (PDT)
Date:   Tue, 15 Mar 2022 02:36:11 -0700
In-Reply-To: <0000000000009e7a1905b8295829@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003887a05da3e872c@google.com>
Subject: Re: [syzbot] KASAN: out-of-bounds Read in ath9k_hif_usb_rx_cb (3)
From:   syzbot <syzbot+3f1ca6a6fec34d601788@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, ath9k-devel@qca.qualcomm.com,
        chouhan.shreyansh630@gmail.com, davem@davemloft.net,
        kuba@kernel.org, kvalo@codeaurora.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
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

syzbot suspects this issue was fixed by commit:

commit 09688c0166e76ce2fb85e86b9d99be8b0084cdf9
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Mar 13 20:23:37 2022 +0000

    Linux 5.17-rc8

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140283ad700000
start commit:   f5b6eb1e0182 Merge branch 'i2c/for-current' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a9e9956ca52a5f6
dashboard link: https://syzkaller.appspot.com/bug?extid=3f1ca6a6fec34d601788
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158914ebd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17720670300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Linux 5.17-rc8

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
