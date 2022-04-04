Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F024F1E83
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380639AbiDDVsq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Apr 2022 17:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380278AbiDDT1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:27:12 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4F03B295
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 12:25:15 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id m3-20020a056e02158300b002b6e3d1f97cso6706421ilu.19
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 12:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=kmWFJFj34/4zFHaivaN7YD9rve+XHxpxZd65FGGyjrQ=;
        b=tsNPEjtePJorrjxM7MEGsJBY+p0P1C/qHyLGBVzt/A2RO1lN6v+rfnvA1pYw9grNo6
         +B3T+yIkBFsjGod213nLPyoFA4YZlGX+Vwe3ehIGshStYmkR/MrIZ6qvMn31ELVwj0rW
         Jl1uPJNoCjGPsos9A232rhCCTnhUsd/7NGyAldFT3rbeerWCbCTpKZtuqFGCtgVLuY9+
         n6jyDakjdsmVSPJGFx+pg/0YxiNGwbfaxrgYhh5ADoDRe0GQO7M/0wmTX9VMwGyp9Di8
         ATKPl9qijt0Z20gbUbTjwzivgQGYzexmLMkZ+A8zur9fRlRD+0XttCEXwRrLJXcHJ02m
         QtTw==
X-Gm-Message-State: AOAM5326hsF6ah5P030REGGLaRU3Y9aTtskJpbfKc3TpeahpPsiluPhT
        EiL5VFo9++sp868F0t0Sss/xHntE1/1JjHZB2Or6qm5mAry7
X-Google-Smtp-Source: ABdhPJwu0I+tkB37kU2Qzn6gi2n1zL0hp4u1Zi1zgPa4Zh1RdJP9BTUrQKrvjyQW2pqi/qB2v0WNoXpnUj34T7J5r8Tmxqtwtswv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa7:b0:2ca:52e8:b500 with SMTP id
 l7-20020a056e021aa700b002ca52e8b500mr676538ilv.34.1649100314393; Mon, 04 Apr
 2022 12:25:14 -0700 (PDT)
Date:   Mon, 04 Apr 2022 12:25:14 -0700
In-Reply-To: <000000000000264b2a05d44bca80@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070561105dbd91673@google.com>
Subject: Re: [syzbot] WARNING in cpuset_write_resmask
From:   syzbot <syzbot+568dc81cd20b72d4a49f@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, changbin.du@intel.com,
        christian.brauner@ubuntu.com, davem@davemloft.net,
        edumazet@google.com, hannes@cmpxchg.org, hkallweit1@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, longman@redhat.com, mkoutny@suse.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org, yajun.deng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

commit d068eebbd4822b6c14a7ea375dfe53ca5c69c776
Author: Michal Koutný <mkoutny@suse.com>
Date:   Fri Dec 17 15:48:54 2021 +0000

    cgroup/cpuset: Make child cpusets restrict parents on v1 hierarchy

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142f17f7700000
start commit:   e5313968c41b Merge branch 'Split bpf_sk_lookup remote_port..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=c40b67275bfe2a58
dashboard link: https://syzkaller.appspot.com/bug?extid=568dc81cd20b72d4a49f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bb97ce700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12062c8e700000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: cgroup/cpuset: Make child cpusets restrict parents on v1 hierarchy

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
