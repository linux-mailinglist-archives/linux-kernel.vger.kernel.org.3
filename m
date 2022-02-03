Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26CE4A7F3C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 07:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiBCGPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 01:15:15 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:53188 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiBCGPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 01:15:13 -0500
Received: by mail-il1-f197.google.com with SMTP id m3-20020a056e02158300b002b6e3d1f97cso1069685ilu.19
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 22:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1dk1fe22wAQD96KMpTrh1aJpCo8V8K5F5v+cSSPRAoo=;
        b=lqzcpO4fvoECGBjhEoZsvhqx4FNdE2F5xrnJ2ywkGAK0icOEkkst/J9bfU0eXbpGRl
         Rq/TsZAT4JBTIRoGCnNuOVxNzkWe2PmQ7jYsWye8YiTA/YceCujjbGdeUjrs18GtOzR+
         keocwKKcu1X2MEOhpP+sh6qbCgoKYu/39yQIxhAnG8teC8BOVQVpGViQoloVSbBr/SQb
         /qcR/ZKHBFKwyrpnp+QM0fMqzv7hlwvH2nappUf+adXxgtmkcLnxS0MAtNECoeknAh05
         xwNz7iiNxEvs5TOAyZwh1a0mF97uYHyawzswI1bfkBsPgepWkwKPlCHRC9SUHDJscGmD
         ZP7g==
X-Gm-Message-State: AOAM530xAb6kDwi26xlcxLEydgvIzk6tYyw+VvtqSBQiFHwO8oMPTzu/
        HOPPl3vQniwLWstUPjOuVOW2OeyNb8nKCrAJj8fbcEojh9Fv
X-Google-Smtp-Source: ABdhPJwG5KmUUYwacPuZ2fehr/MclNnEH3Zo1f357gXYPZfwm4VEsErIU/AlluZcFnV9djQq5ZDsqkgJgfxLeg23qz1oe7oFwDex
MIME-Version: 1.0
X-Received: by 2002:a02:710c:: with SMTP id n12mr18306379jac.67.1643868913131;
 Wed, 02 Feb 2022 22:15:13 -0800 (PST)
Date:   Wed, 02 Feb 2022 22:15:13 -0800
In-Reply-To: <00000000000061d7eb05d7057144@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fe31405d7170e81@google.com>
Subject: Re: [syzbot] WARNING in bpf_prog_test_run_xdp
From:   syzbot <syzbot+79fd1ab62b382be6f337@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, lorenzo@kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, toke@redhat.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 1c194998252469cad00a08bd9ef0b99fd255c260
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Fri Jan 21 10:09:58 2022 +0000

    bpf: introduce frags support to bpf_prog_test_run_xdp()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d81634700000
start commit:   000fe940e51f sfc: The size of the RX recycle ring should b..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15d81634700000
console output: https://syzkaller.appspot.com/x/log.txt?x=11d81634700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e029d3b2ccd4c91a
dashboard link: https://syzkaller.appspot.com/bug?extid=79fd1ab62b382be6f337
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a719cc700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15851cec700000

Reported-by: syzbot+79fd1ab62b382be6f337@syzkaller.appspotmail.com
Fixes: 1c1949982524 ("bpf: introduce frags support to bpf_prog_test_run_xdp()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
