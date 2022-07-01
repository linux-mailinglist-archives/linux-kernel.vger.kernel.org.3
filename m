Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DB15639C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiGATVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiGATVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:21:17 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040861117C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 12:21:17 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id n19-20020a056602341300b0066850b49e09so1639454ioz.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 12:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ye2No0OzZ5T9BoIg9adcKjLovVqO3+HUrByWi9JzHGY=;
        b=TB5RWYE33y+S1YjdhK3pqzLjyUJSRndrCSmkxuMcwEf9aLOpVmMpIuKWnPTSUJ3R42
         ybsYhXBZJIUqH7Dey4wTZxPd8DJL/IhMnqunYP2ExsIcSd0QEV6nkLuF7HMtNUROW+kL
         yBJYpfkXu1SbXipUPZ/lVYlDGQAV5LVf77sM2s79+HYxFkdTTlg9f2VAq2IWwWvyKgzQ
         g1tLMNorPyY8kLwUfp3FyXpIp4RtSYTNXLMejbAYhe8ABp9jAUxr6f3ngG7Xl5LKXtyI
         Fh/U0ZllFCeMwCbptaV9uiHpeGbI7IzkAutzAzDJrERPbvhNIyR16h7oWSDhbNlqAGU2
         rzRQ==
X-Gm-Message-State: AJIora8cSGDtewdpFYagVRoWNxu7FDweC+tclqkv+Onx7h4uyQmUz8vy
        NY5RqiEcom/mWrHLBqHJ8SNexIoOOxZGDKW508UB40zxBM5Z
X-Google-Smtp-Source: AGRyM1v9vKew6tY0ycvE0awvKbkgQJImZOd7ba/9x+s/5xRRgM7XtTnjkOL+gSMcufvz8qKWya7foZ01NirGea8Ij4tjilewvOnT
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26c3:b0:66c:f8b2:53c with SMTP id
 g3-20020a05660226c300b0066cf8b2053cmr8270435ioo.50.1656703276391; Fri, 01 Jul
 2022 12:21:16 -0700 (PDT)
Date:   Fri, 01 Jul 2022 12:21:16 -0700
In-Reply-To: <000000000000915bd505ddaff576@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049a18105e2c34a0c@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_rawmidi_transmit
From:   syzbot <syzbot+39e3268af9968f153591@syzkaller.appspotmail.com>
To:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        anthony.l.nguyen@intel.com, clemens@ladisch.de, coding@diwic.se,
        colin.king@intel.com, hdanton@sina.com,
        linux-kernel@vger.kernel.org, naamax.meir@linux.intel.com,
        perex@perex.cz, sasha.neftin@intel.com,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
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

commit 0125de38122f0f66bf61336158d12a1aabfe6425
Author: Takashi Iwai <tiwai@suse.de>
Date:   Wed May 25 13:12:03 2022 +0000

    ALSA: usb-audio: Cancel pending work at closing a MIDI substream

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1180b25c080000
start commit:   2a5699b0de4e Merge tag 'leds-5.19-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f915857c44e13980
dashboard link: https://syzkaller.appspot.com/bug?extid=39e3268af9968f153591
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119d1fcbf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17716bedf00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ALSA: usb-audio: Cancel pending work at closing a MIDI substream

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
