Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DBC491089
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 20:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiAQTCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 14:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiAQTCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 14:02:19 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E957EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 11:02:18 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o12so44579928lfu.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 11:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=WvbXEhKMMN0GmOckN6zN2KXde81RRc5HGG+ozhtaEIg=;
        b=GPPkCee1xrGK7EyCkoGt+hwDgACYkjYj/t2hsJ/Cw+ZnWitIBKt6Wa3eSytB5aZjfW
         4rj3Pe3dMrTMemUrsnUGKelg1BQXS8S5xqKOcUU6O/J/GuIBK89//g7cjIGhfVHhE1zK
         4fRTKXGL7MydDNWN3trZa5WCj1sOleftnjCn3aYNO91h2JRD/GOP1hplXmzqDuLqvWGC
         7KbzM5gQOA69a/88lfOYUKXZRJprVQgLT7a46Ma+aQKtwMy+hZAG76jeyp/xzcmbt/fS
         UX2Eaaxdgdr9yVFk+jY5sa6fZQ1gLJ7X6Gyfsc7j8JSI3Rk8eeJE3XZdgBKEh5C9ZGhg
         s3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WvbXEhKMMN0GmOckN6zN2KXde81RRc5HGG+ozhtaEIg=;
        b=NN1Ei70eVv0ZelVihKaFSfXOhMkuIHy4NtLYIy4OBfLy74jHEyu/xVsDMW2wh35xN0
         IHniZ0YvYAvQGI8vRGa558tzWwzSDz5BWMqAQSrd+/lCEOVe5gG+fm/lMfSItl0yCr+M
         gT99u39kYAyaZSDJ/FHrXPwRmJEb32J6tR7c5RXC0T1HF3HFuFdycOUUTlSikDtNJygV
         V6MFL2yx9nE8Dz9oh3gZJyvISmcsOu16/XpOah9/S1CrXMpKBYPMfR//4BBTfToxvHrC
         fhsFMbRpj4MdCSNjSdNSQBLkSdSJev5w858I8XTU7JeM41pSoyK4PjSAH1LRWyeNl3FW
         iivw==
X-Gm-Message-State: AOAM5336G9vJ9p/PoQ2yvgAbP9I/unomu+Q/hClWsEeyVbKsBB8Du2QK
        BFLSzBHABZxxnh/puqHRE9HQiZm4eJo=
X-Google-Smtp-Source: ABdhPJz1YbYmEgd4oGiaAeaV2suCiVIh4pAX4ZjZXDs/uXT5r1OB4Ds3IzNI5uNpHmSvmtOqu2OkcQ==
X-Received: by 2002:ac2:58da:: with SMTP id u26mr17661738lfo.91.1642446137110;
        Mon, 17 Jan 2022 11:02:17 -0800 (PST)
Received: from [192.168.1.11] ([94.103.227.208])
        by smtp.gmail.com with ESMTPSA id t18sm1040360lfr.155.2022.01.17.11.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 11:02:16 -0800 (PST)
Message-ID: <38455f10-6cac-4eda-3e7a-3744fb377870@gmail.com>
Date:   Mon, 17 Jan 2022 22:02:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [syzbot] kernel BUG in ntfs_read_inode_mount
Content-Language: en-US
To:     syzbot <syzbot+3c765c5248797356edaa@syzkaller.appspotmail.com>,
        anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
References: <000000000000739eb405d5c458dc@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000739eb405d5c458dc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 13:09, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d0a231f01e5b Merge tag 'pci-v5.17-changes' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11f83837b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=986ed422f1741853
> dashboard link: https://syzkaller.appspot.com/bug?extid=3c765c5248797356edaa
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 

Sad :(

> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3c765c5248797356edaa@syzkaller.appspotmail.com
> 

__ntfs_malloc() calls BUG_ON() in case of requested size is equal to 
zero. Seems like syzbot has once again crafted malicious fs image that 
has attr_list_size == 0

Just for thoughts


With regards,
Pavel Skripkin
