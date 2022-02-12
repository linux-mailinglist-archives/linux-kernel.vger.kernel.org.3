Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB84B4B386D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 23:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiBLWnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 17:43:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiBLWnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 17:43:19 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1135D23BD5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 14:43:16 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id k12-20020a92c24c000000b002bc9876bf27so8343658ilo.21
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 14:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Qndx5/xlMDuMFsAiyXYtZiMwVkwJVHOfIbITY7SRWJQ=;
        b=ufkh+wy+hAqY+nwTFfDWWbj9LQSZV2Fu2T5xu22tZ5/lQWMJooBRh3MF4eBreR4hbk
         YF0q1q+JJUvaVN27iLN0Uxlt1eqbbwAr9Eagylwarho9XQefrF6UscEBPV4ECX/echn4
         KPjjRqtbNANF94bq8uQ+0b6MOoQhqDJSdrUe+AVum+XRkxsxq0bRIBwVsvfAHq7kuy6D
         lgjEjYO36UyQiFZRJ9oU2uu90ERnTEgSuCTCxhLbpDwoiaE1KyMEPPeMV4fGORwWPuvf
         1O5SW+JWEA5wYgUcU4+N3nLOhh/iZD9ffDeN1CiehugHylx+isQr7PESW4DIajE8OHue
         MH6Q==
X-Gm-Message-State: AOAM530dQbMgiC6NBWIsnEEg2nWBfRyTZUFss6vpud+2VAFgWCfSuxbX
        i9sIB3hMsltT00+4QhsZpMDYz0fKHF+0OhTjs4HeqiCJ7UKg
X-Google-Smtp-Source: ABdhPJyYJiru2zx+c/KVjgt1xGFubXKCnNkIk4JRjg/rcylmahzVP9hbqgP6bfAIgw0MItzt6bpF6kOvtY69glToznfqQq+iuQ/5
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1806:: with SMTP id a6mr3393462ilv.272.1644705795363;
 Sat, 12 Feb 2022 14:43:15 -0800 (PST)
Date:   Sat, 12 Feb 2022 14:43:15 -0800
In-Reply-To: <0000000000004c57c005b0fc4114@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b15b3505d7d9e8ca@google.com>
Subject: Re: [syzbot] INFO: task hung in usb_get_descriptor
From:   syzbot <syzbot+31ae6d17d115e980fd14@syzkaller.appspotmail.com>
To:     brouer@redhat.com, coreteam@netfilter.org, davem@davemloft.net,
        edumazet@google.com, eman.mohamed@rofaidarealestate.com,
        gregkh@linuxfoundation.org, gustavoars@kernel.org,
        hdanton@sina.com, ingrassia@epigenesys.com, johan@kernel.org,
        kaber@trash.net, kadlec@blackhole.kfki.hu,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        skhan@linuxfoundation.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
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

commit 363eaa3a450abb4e63bd6e3ad79d1f7a0f717814
Author: Shuah Khan <skhan@linuxfoundation.org>
Date:   Tue Mar 30 01:36:51 2021 +0000

    usbip: synchronize event handler with sysfs code paths

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1616e872700000
start commit:   4fa56ad0d12e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=144ecdb0be3abc07
dashboard link: https://syzkaller.appspot.com/bug?extid=31ae6d17d115e980fd14
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12548d11d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ec77e9d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: usbip: synchronize event handler with sysfs code paths

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
