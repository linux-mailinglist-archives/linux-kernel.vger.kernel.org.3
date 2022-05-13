Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A798252594B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376305AbiEMBNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353878AbiEMBNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:13:09 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E6222C2F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:13:08 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id l3-20020a05660227c300b0065a8c141580so4009666ios.19
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eUXlZRRWqWJeVNbzS1bUZMqw+XLq1Ya2CWkXg+H4K7M=;
        b=zKl2D/DSAZJzMZENsOWxzXMyGIOEoVCR8V7d5KTbchX3C0/Hu6Lfn0ItkaKq6aij3m
         v3QAlL4K6ZIn7QED10WQkWM+NPLhbTXVSRunkbMLmw/jTUcbN63OkEX00qnopAVFzvJk
         RB8ALM80zrm52Vfv8mAqPFf8pXxNxRUQIjQ0f0nJAl0ugHBDewPfNfcIoe/RnAL3Bniu
         MlhMOJZKCxFK9RCVxoWvOYrYMCdweqfChpi36dfKfQ3Q5GB0SY5fQzGvWpJ+kwCPrZ03
         VNUzgQyRMNkE+Skg+idtT7BJCOY5n33NY4E12uMUdB3ZUdolQhwut8hBHeGX770aSvkz
         dQaw==
X-Gm-Message-State: AOAM532S78+0JS9Hxp0+M0/Rcbz8kSELUeWSoMLZhqECzXUsIjnFyOAE
        9pTvuQzRFlsM8UtKEbdqh9u+lrxUFoEIRhUo1524BMZW0EXp
X-Google-Smtp-Source: ABdhPJwEwZtIN8NhhD/fHwNeTBgHW63SLd1vEX6YrIqvoAOZP0GB242kidijQKRELxiUGhbx+xyHNgyEBAeFVAtSXiabk98omDxW
MIME-Version: 1.0
X-Received: by 2002:a6b:3f05:0:b0:65a:431a:30cf with SMTP id
 m5-20020a6b3f05000000b0065a431a30cfmr1250181ioa.117.1652404387949; Thu, 12
 May 2022 18:13:07 -0700 (PDT)
Date:   Thu, 12 May 2022 18:13:07 -0700
In-Reply-To: <0000000000005f1a8805ded719cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091b7f505deda6057@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in tcf_pedit_init
From:   syzbot <syzbot+8ed8fc4c57e9dcf23ca6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, geliang.tang@suse.com,
        jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mathew.j.martineau@linux.intel.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
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

commit 8b796475fd7882663a870456466a4fb315cc1bd6
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue May 10 14:57:34 2022 +0000

    net/sched: act_pedit: really ensure the skb is writable

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=158d3969f00000
start commit:   810c2f0a3f86 mlxsw: Avoid warning during ip6gre device rem..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=178d3969f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=138d3969f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=331feb185f8828e0
dashboard link: https://syzkaller.appspot.com/bug?extid=8ed8fc4c57e9dcf23ca6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104e9749f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f913b9f00000

Reported-by: syzbot+8ed8fc4c57e9dcf23ca6@syzkaller.appspotmail.com
Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writable")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
