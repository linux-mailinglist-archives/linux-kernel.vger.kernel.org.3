Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE3E533BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbiEYLrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241097AbiEYLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:47:41 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089ABA204F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:47:39 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 93B8161EA1923;
        Wed, 25 May 2022 13:47:35 +0200 (CEST)
Message-ID: <acbc72fe-c09f-5cc9-3e4b-88fc3d3fe1b1@molgen.mpg.de>
Date:   Wed, 25 May 2022 13:47:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [solved] 2 s boot time regression between 5.17 and 5.18-rc4?
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
References: <a6688497-e234-ddaa-f371-b9e7539df74d@molgen.mpg.de>
 <YoF+H28BQxoD7rfj@zx2c4.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <YoF+H28BQxoD7rfj@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jason,


Thank you for your quick reply.


Am 16.05.22 um 00:26 schrieb Jason A. Donenfeld:

> On Mon, May 16, 2022 at 12:09:20AM +0200, Paul Menzel wrote:

>> Looking at the timestamps I only just noticed a two second regression.
>> The line below
>>
>>       systemd[1]: Created slice Slice /system/getty.
> 
> Known thing, but not quite a regression, as it does unblock and continue
> booting. IOW, there's no possibility it will hang forever.

Depends on the definition of *regression*. If you have boottime 
requirements, than it would be considered one, and would hold me back 
from always updating the Linux kernel confidently as promised by Linux. 
But in my case it’s not a product, so I do not care.

> But that's neither here nor there: your log says you're using systemd
> 250.4. This was fixed and backported to 250.5 (and 251 of course), so
> try updating, and the issue you're seeing will be gone. If not, do
> let me know.

systemd 251 was released last week, and entered Debian sid/unstable this 
week, and I can confirm, the two second delay is gone with Linux 5.18.

```
[    0.000000] Linux version 5.18.0-00107-geb50eb550f2c 
(root@4beb429beb4a) (gcc (Debian 11.2.0-12) 11.2.0, GNU ld (GNU Binutils 
for Debian) 2.37) #360 SMP PREEMPT_DYNAMIC Mon May 23 07:00:41 UTC 2022
[    0.000000] Command line: 
BOOT_IMAGE=/boot/vmlinuz-5.18.0-00107-geb50eb550f2c root=/dev/sda3 rw 
quiet noisapnp cryptomgr.notests ipv6.disable_ipv6=1 selinux=0
[    0.000000] random: get_random_u32 called from 
bsp_init_amd+0x142/0x210 with crng_init=0
[…]
[    0.000000] DMI: ASUS F2A85-M_PRO/F2A85-M_PRO, BIOS 
4.16-1133-g923080d1e6 05/25/2022
[…]
[    0.541486] Run /sbin/init as init process
[    0.541487]   with arguments:
[    0.541488]     /sbin/init
[    0.541489]     noisapnp
[    0.541490]   with environment:
[    0.541491]     HOME=/
[    0.541491]     TERM=linux
[    0.541492]     BOOT_IMAGE=/boot/vmlinuz-5.18.0-00107-geb50eb550f2c
[    0.592867] random: fast init done
[    0.711960] systemd[1]: Inserted module 'autofs4'
[    0.725757] NET: Registered PF_INET6 protocol family
[    0.726491] Segment Routing with IPv6
[    0.726509] In-situ OAM (IOAM) with IPv6
[    0.745301] systemd[1]: systemd 251-2 running in system mode (+PAM 
+AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS -OPENSSL 
+ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP 
+LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ 
+ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT 
default-hierarchy=unified)
[    0.745311] systemd[1]: Detected architecture x86-64.
[    0.747380] systemd[1]: Hostname set to <kodi>.
[    0.943692] systemd[1]: Queued start job for default target Graphical 
Interface.
[    0.946792] systemd[1]: Created slice Slice /system/getty.
[    0.947738] systemd[1]: Created slice Slice /system/modprobe.
[    0.948377] systemd[1]: Created slice User and Session Slice.
[    0.948528] systemd[1]: Started Dispatch Password Requests to Console 
Directory Watch.
[    0.948636] systemd[1]: Started Forward Password Requests to Wall 
Directory Watch.
[    0.949036] systemd[1]: Set up automount Arbitrary Executable File 
Formats File System Automount Point.
```


Kind regards,

Paul
