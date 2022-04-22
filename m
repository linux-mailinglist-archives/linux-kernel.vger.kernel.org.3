Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A5350C025
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 21:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiDVTGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiDVTGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 15:06:16 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143E013A4F8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:55:18 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id u18-20020a5d8712000000b0064c7a7c497aso5908803iom.18
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SW7d9SQV8ry87PsdVWpwkJKv15ZwuogCuWjTqDpXCOs=;
        b=oQiobKXeQoWtSJfnhdK+k3l7BjzIztKRLmDBiQKLrbxOeBq8SlM0q07eQldnAZhZ7D
         K6cBWJ8Y1KVBKrCGePeegBF4YqYoTwOlu1qdF2PEZAVfOEv5U8fd2/5GO8I/AUBFzI8Y
         hbqngKMarJ38pbCEd5Fnr4dYNR3MnIcznKWCz3BlCeWK0RGy1RA6CgxD0/BQOzDnpZvT
         Ai4qkp5AB9CXxIOzqIyLC2hdvJvIDAagGhpaLGDR8pTtZgrG9lZH/ATu6aRQL18WaJJc
         278ZHMv8kY8L4bOUN2IkzdAwhuK6dDB+gUckygUzogIWMRdTI7gTFSHqvFa4j/GAukd1
         j+fg==
X-Gm-Message-State: AOAM532F5sfUj7fIy4LUA/2ERQjcAR4q+4oR0Bgrva7ZMwley+Xcz169
        IFD+NyiKiejyoZbQ+9o5nWpsTkdmc7TmAow4VYahZycAZuiR
X-Google-Smtp-Source: ABdhPJzpcaxVT7ae5c/OrtdmL1gderEJn20oa971shuXRjgHIybvnhbBnELrASUvsLmPnZE7qyOWwVK2wIG0wS0Lt5aGrJzx2a80
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a62:b0:2cc:5634:763e with SMTP id
 w2-20020a056e021a6200b002cc5634763emr2550900ilv.68.1650653590752; Fri, 22 Apr
 2022 11:53:10 -0700 (PDT)
Date:   Fri, 22 Apr 2022 11:53:10 -0700
In-Reply-To: <00000000000033acbf05d1a969aa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec946105dd42bcd6@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in bpf
From:   syzbot <syzbot+cecf5b7071a0dfb76530@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        jiri@nvidia.com, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, leonro@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, yhs@fb.com
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

commit 0708a0afe291bdfe1386d74d5ec1f0c27e8b9168
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Fri Mar 4 14:26:32 2022 +0000

    mm: Consider __GFP_NOWARN flag for oversized kvmalloc() calls

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1499c6fcf00000
start commit:   1d5a47424040 sfc: The RX page_ring is optional
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
dashboard link: https://syzkaller.appspot.com/bug?extid=cecf5b7071a0dfb76530
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176738e7b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b4508db00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: Consider __GFP_NOWARN flag for oversized kvmalloc() calls

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
