Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539754A8246
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbiBCKZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:25:13 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:36416 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBCKZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:25:12 -0500
Received: by mail-io1-f72.google.com with SMTP id b15-20020a056602330f00b006109348c3daso1601236ioz.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 02:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Rxhq5+VXSIrIwj7a/GsrEywPOO2yQbABshUuuSgeFDs=;
        b=3o0P1tDQYjuHo5V2kfaAIdA26GntEYgGGlzm2wQp3VB7EHyXGRkrkZVXKoxwBXgjiY
         A19zi39r/zASn3Agc01Jv8z+Csz31bBgXc5XNV+1yaEHR4xKIKYzy9+HidmEXywoF9od
         1vODzug3D5nRb+zFukaf62mbhTjzvIIv/oR5dxgwFZIRSLNWkxsc0YpOxh7kQ/VdTzJN
         QOK04sWVgNWNS7RQD2hM42dmDeXhB3be/lsvX08giR9OeR5n8EzqCUWmXogFExYI+ams
         a7tY+WyAYOXazPLh/UDZMUHUXvF5oWBjbQDfxwLCoaU/bY/8hgGI7VHmooC9TRGkmgPo
         15jQ==
X-Gm-Message-State: AOAM530x4duoFx2KILu+xfz2VbFihuRiKwbukm167QYhCrh+f0yhwGiV
        +vT8RQI0D+QuKGqJNuUzCGepfXI4uWCDhs3pXsO8ulGTFyE2
X-Google-Smtp-Source: ABdhPJwciDKQal6Z8tQiBUOtqqjZ9Z10+I25ua2fg40YZSw5o6TjWWvTvcWi43d589ZwucSUE+At081HdhPPiDtRhfgxGm6Iv0ds
MIME-Version: 1.0
X-Received: by 2002:a6b:f218:: with SMTP id q24mr17682264ioh.55.1643883911669;
 Thu, 03 Feb 2022 02:25:11 -0800 (PST)
Date:   Thu, 03 Feb 2022 02:25:11 -0800
In-Reply-To: <00000000000079a24b05d714d69f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b6eaa05d71a8c06@google.com>
Subject: Re: [syzbot] general protection fault in btf_decl_tag_resolve
From:   syzbot <syzbot+53619be9444215e785ed@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, daniel@iogearbox.net,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit b5ea834dde6b6e7f75e51d5f66dac8cd7c97b5ef
Author: Yonghong Song <yhs@fb.com>
Date:   Tue Sep 14 22:30:15 2021 +0000

    bpf: Support for new btf kind BTF_KIND_TAG

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12183484700000
start commit:   b7892f7d5cb2 tools: Ignore errors from `which' when search..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11183484700000
console output: https://syzkaller.appspot.com/x/log.txt?x=16183484700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5044676c290190f2
dashboard link: https://syzkaller.appspot.com/bug?extid=53619be9444215e785ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16454914700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ceb884700000

Reported-by: syzbot+53619be9444215e785ed@syzkaller.appspotmail.com
Fixes: b5ea834dde6b ("bpf: Support for new btf kind BTF_KIND_TAG")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
