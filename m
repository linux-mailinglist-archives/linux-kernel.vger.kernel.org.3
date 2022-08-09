Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AFB58D382
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiHIGDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiHIGDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:03:15 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973613881;
        Mon,  8 Aug 2022 23:03:14 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id b96so13917369edf.0;
        Mon, 08 Aug 2022 23:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=hWQlAJpIhq6PXdJBV/3SWerV1V3bKyFHMIODmIuBBHw=;
        b=Dh2dTtI7A6DUjHwPjPc8/MFolUEPZy1HE5lqCinwumtlAhsX4YwSJdi/DLdFSkxOu3
         7+8lzFNPBIQlA3IJn0eFRYjmptjEosWsDhkgDy8vCttupmbCElrt9syMooggSPhUfVQT
         b5KoECgmy7jh0w+QPckSkwRrAvLSNtpOqnsCim2iKUM73pz8zb6K5daMQNRyCJRcp62r
         kSYi+3Hr5QFxslOEVElOB3M+C2pWnjHcmGz46qESGWsHhKsY3Gt4dtj8GXsFfKEz4OFr
         XpxlJv/+f/bw4C9minS+tRVlqvNBP+uD5I7V6dJcU5i4B8XeUd22g52IYZuHi+SDof3v
         J07Q==
X-Gm-Message-State: ACgBeo1ikYpbTp5nMWGO+wG+VKMogk/w8710ZeglQ6Tz87PgQ6gK66Ug
        HTJFgEjIIfctjyLLzNSa97PQJ4vhS2c=
X-Google-Smtp-Source: AA6agR6dCZQcBqkC3EqcwGkNWFi2GALmfUEVlcDhcU+4btLyElaB4y6GVk9Lkjy9nklLANV74PeZig==
X-Received: by 2002:aa7:d513:0:b0:43d:5c81:4f71 with SMTP id y19-20020aa7d513000000b0043d5c814f71mr16352096edq.308.1660024993019;
        Mon, 08 Aug 2022 23:03:13 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b007309d640484sm705723ejn.91.2022.08.08.23.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 23:03:12 -0700 (PDT)
Message-ID: <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
Date:   Tue, 9 Aug 2022 08:03:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: ext2/zram issue [was: Linux 5.19]
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jan Kara <jack@suse.com>, Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31. 07. 22, 23:43, Linus Torvalds wrote:
> So here we are, one week late, and 5.19 is tagged and pushed out.
> 
> The full shortlog (just from rc8, obviously not all of 5.19) is below,
> but I can happily report that there is nothing really interesting in
> there. A lot of random small stuff.

Note: I originally reported this downstream for tracking at:
https://bugzilla.suse.com/show_bug.cgi?id=1202203

5.19 behaves pretty weird in openSUSE's openQA (opposing to 5.18, or 
5.18.15). It's all qemu-kvm "HW"¹⁾:
https://openqa.opensuse.org/tests/2502148
loop2: detected capacity change from 0 to 72264
EXT4-fs warning (device zram0): ext4_end_bio:343: I/O error 10 writing 
to inode 57375 starting block 137216)
Buffer I/O error on device zram0, logical block 137216
Buffer I/O error on device zram0, logical block 137217
...
SQUASHFS error: xz decompression failed, data probably corrupt
SQUASHFS error: Failed to read block 0x2e41680: -5
SQUASHFS error: xz decompression failed, data probably corrupt
SQUASHFS error: Failed to read block 0x2e41680: -5
Bus error



https://openqa.opensuse.org/tests/2502145
FS-Cache: Loaded
begin 644 ldconfig.core.pid_2094.sig_7.time_1659859442



https://openqa.opensuse.org/tests/2502146
FS-Cache: Loaded
begin 644 Xorg.bin.core.pid_3733.sig_6.time_1659858784



https://openqa.opensuse.org/tests/2502148
EXT4-fs warning (device zram0): ext4_end_bio:343: I/O error 10 writing 
to inode 57375 starting block 137216)
Buffer I/O error on device zram0, logical block 137216
Buffer I/O error on device zram0, logical block 137217



https://openqa.opensuse.org/tests/2502154
[   13.158090][  T634] FS-Cache: Loaded
...
[  525.627024][    C0] sysrq: Show State



Those are various failures -- crashes of ldconfig, Xorg; I/O failures on 
zram; the last one is a lockup likely, something invoked sysrq after 
500s stall.

Interestingly, I've also hit this twice locally:
 > init[1]: segfault at 18 ip 00007fb6154b4c81 sp 00007ffc243ed600 error 
6 in libc.so.6[7fb61543f000+185000]
 > Code: 41 5f c3 66 0f 1f 44 00 00 42 f6 44 10 08 01 0f 84 04 01 00 00 
48 83 e1 fe 48 89 48 08 49 8b 47 70 49 89 5f 70 66 48 0f 6e c0 <48> 89 
58 18 0f 16 44 24 08 48 81 fd ff 03 00 00 76 08 66 0f ef c9
 > ***  signal 11 ***
 > malloc(): unsorted double linked list corrupted
 > traps: init[1] general protection fault ip:7fb61543f8b9 
sp:7ffc243ebf40 error:0 in libc.so.6[7fb61543f000+185000]
 > Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
 > CPU: 0 PID: 1 Comm: init Not tainted 5.19.0-1-default #1 openSUSE 
Tumbleweed e1df13166a33f423514290c702e43cfbb2b5b575

KASAN is not helpful either, so it's unlikely a memory corruption 
(unless it is "HW" related; should I try to turn on IOMMU in qemu?):
> kasan: KernelAddressSanitizer initialized
> ...
> zram: module verification failed: signature and/or required key missing - tainting kernel
> zram: Added device: zram0
> zram0: detected capacity change from 0 to 2097152
> EXT4-fs (zram0): mounting ext2 file system using the ext4 subsystem
> EXT4-fs (zram0): mounted filesystem without journal. Quota mode: none.
> EXT4-fs warning (device zram0): ext4_end_bio:343: I/O error 10 writing to inode 16386 starting block 159744)
> Buffer I/O error on device zram0, logical block 159744
> Buffer I/O error on device zram0, logical block 159745



They all occur to me like a zram failure. The installer apparently 
creates an ext2 FS and after it mounts it using ext4 module, the issue 
starts occurring.

Any tests I/you could run on 5.19 to exercise zram and ext2? Otherwise I 
am unable to reproduce easily, except using the openSUSE installer :/.

Any other ideas? Or is this known already?

¹⁾ main are uefi boot and virtio-blk (it likely happens with virtio-scsi 
too). The cmdline _I_ use: qemu-kvm -device intel-hda -device hda-duplex 
-drive file=/tmp/pokus.qcow2,if=none,id=hd -device 
virtio-blk-pci,drive=hd -drive 
if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/qemu/ovmf-x86_64-opensuse-code.bin 
-drive if=pflash,format=raw,unit=1,file=/tmp/vars.bin -cdrom 
/tmp/cd1.iso  -m 1G -smp 1 -net user -net nic,model=virtio -serial pty 
-device virtio-rng-pci -device qemu-xhci,p2=4,p3=4 -usbdevice tablet


thanks,
-- 
js
suse labs

