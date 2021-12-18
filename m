Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF11F479ABA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 13:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhLRM35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 07:29:57 -0500
Received: from mail1.perex.cz ([77.48.224.245]:40224 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230159AbhLRM34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 07:29:56 -0500
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id DD70DA003F;
        Sat, 18 Dec 2021 13:29:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz DD70DA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1639830594; bh=b6Fmz+wyxMl12NKeEZ4nicex/pDNEYbXV2fvvJpGl88=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=CtfIb210wnTBfmzIKu220oPA2XBRQZ9BKIS/KYiOqgxTVl5OgqgRYGtGhPQc8ZE+U
         p+owvUTNewy49/G4hBmq3OekDhvHKgjCliNzzSyQ9ENkceUhjF1mYs88rShu84T5oD
         LOSYO3C3F6nv+Gyz0nyij1hfzecCQzGTkSyZQ4zU=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Sat, 18 Dec 2021 13:29:43 +0100 (CET)
Message-ID: <9603b40e-d038-1252-d613-8ece55029f07@perex.cz>
Date:   Sat, 18 Dec 2021 13:29:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [syzbot] KMSAN: uninit-value in snd_rawmidi_ioctl
Content-Language: en-US
To:     syzbot <syzbot+88412ee8811832b00dbe@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, broonie@kernel.org, coding@diwic.se,
        colin.king@intel.com, glider@google.com, joe@perches.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tiwai@suse.com
References: <0000000000004255b405d369cd72@google.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <0000000000004255b405d369cd72@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 12. 21 12:17, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8b936c96768e kmsan: core: remove the accidentally committe..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=11791d89b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e00a8959fdd3f3e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=88412ee8811832b00dbe
> compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a7abf9b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172410b9b00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+88412ee8811832b00dbe@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in snd_rawmidi_ioctl+0xf1e/0x1330 sound/core/rawmidi.c:887
>   snd_rawmidi_ioctl+0xf1e/0x1330 sound/core/rawmidi.c:887

Nice catch. I wonder why the problem was not detected by tests. The patch 
bellow should initialize the user_pversion variable:

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 6f30231bdb88..befa9809ff00 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -447,6 +447,7 @@ static int snd_rawmidi_open(struct inode *inode, struct 
file *file)
                 err = -ENOMEM;
                 goto __error;
         }
+       rawmidi_file->user_pversion = 0;
         init_waitqueue_entry(&wait, current);
         add_wait_queue(&rmidi->open_wait, &wait);
         while (1) {

I'll send the path in the proper format ASAP.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
