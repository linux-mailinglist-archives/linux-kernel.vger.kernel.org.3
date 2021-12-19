Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C642547A139
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 16:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhLSP5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 10:57:09 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:35567 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbhLSP5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 10:57:08 -0500
Received: by mail-il1-f198.google.com with SMTP id b3-20020a92c563000000b002aea8d2dfa7so3866758ilj.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 07:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=J1Z0E8FYOyeGYmMCih47JGz9INwvVqcSBEE3r+oJjRA=;
        b=Sj0kOicynoQXgF//kR//B2TBcOgsquhpSLbWEpY2z4dem6qwlAEnZczlRGFlr/WVKg
         HCNWKvgIfFr2YUsjg6gNknu0H6VgSfI3Ol77JTgzL3gwCE5greHdHsvEZYp5TqXW1Zdl
         4s39OjTTKgkaJANBlOipnXk+1vsVEpMe3C/wR+cGItpUCwXd22Wk922e+tIcdC/GeX9h
         /2Pk8zyh/q6mzuGEI+yBg0ajoRBIjYaJDTz/2IdFwo8TxmsF/jbOkkFlVOpretMmKth3
         NdVhwvnm/GJ5nTUMSBnfV3T6OQM7Z6QFBcFH8oP9X6OpKvdO2bsbFhX0ODJpqmhu/IBW
         vmHQ==
X-Gm-Message-State: AOAM531LShf3arxBfCdYjT7RuBl9BroXfwpUqtRz9JeHQePD/25zf8En
        8K2k1VB1VkvhfOGRMF6eY+prtn5JeoqTPUzPyabNWSFX+T8o
X-Google-Smtp-Source: ABdhPJzibjb8GU6GjM7AflOG1x8TLswRn7G6hxR5g2tBuxN6SrcEX/7NjUMQhAmD4CNcXRBnPUoAQBEM5E0iq4KRPSEZAzxtSFzJ
MIME-Version: 1.0
X-Received: by 2002:a6b:2cc1:: with SMTP id s184mr6122309ios.63.1639929427727;
 Sun, 19 Dec 2021 07:57:07 -0800 (PST)
Date:   Sun, 19 Dec 2021 07:57:07 -0800
In-Reply-To: <000000000000685c4605d0e47dad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff1c4105d381d24f@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in drm_gem_object_release_handle
From:   syzbot <syzbot+c8ae65286134dd1b800d@syzkaller.appspotmail.com>
To:     airlied@linux.ie, christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        daniel.vetter@intel.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linaro-mm-sig-owner@lists.linaro.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sumit.semwal@linaro.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 45d9c8dde4cd8589f9180309ec60f0da2ce486e4
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu Aug 12 13:14:12 2021 +0000

    drm/vgem: use shmem helpers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=147953cbb00000
start commit:   3f667b5d4053 Merge tag 'tty-5.16-rc6' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=167953cbb00000
console output: https://syzkaller.appspot.com/x/log.txt?x=127953cbb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa556098924b78f0
dashboard link: https://syzkaller.appspot.com/bug?extid=c8ae65286134dd1b800d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fd41ebb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1483c7d5b00000

Reported-by: syzbot+c8ae65286134dd1b800d@syzkaller.appspotmail.com
Fixes: 45d9c8dde4cd ("drm/vgem: use shmem helpers")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
