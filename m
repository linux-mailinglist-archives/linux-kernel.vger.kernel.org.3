Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA84FACF3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 10:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiDJIoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 04:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiDJIoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 04:44:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B4549910
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:42:01 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ndT8r-0008O2-Nu; Sun, 10 Apr 2022 10:41:53 +0200
Message-ID: <1b03d888-cea3-3e6f-087f-daeb5642a975@leemhuis.info>
Date:   Sun, 10 Apr 2022 10:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Jeff Dike <jdike@addtoit.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eduard-Gabriel Munteanu <maxdamage@aladin.ro>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        regressions@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
References: <20210508032239.2177-1-thunder.leizhen@huawei.com>
 <Yjt31seiNv18HYrf@dev-arch.thelio-3990X>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
In-Reply-To: <Yjt31seiNv18HYrf@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649580121;1780612e;
X-HE-SMSGID: 1ndT8r-0008O2-Nu
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

Zhen Lei, Richard, what's up here? Below regression report is more than
two weeks old now and afaics didn't even get a single reply.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.



On 23.03.22 20:41, Nathan Chancellor wrote:
> Hello,
> 
> On Sat, May 08, 2021 at 11:22:39AM +0800, Zhen Lei wrote:
>> Fix to return a negative error code from the error handling case instead
>> of 0, as done elsewhere in this function.
>>
>> Fixes: 89df6bfc0405 ("uml: DEBUG_SHIRQ fixes")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/um/drivers/chan_user.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
>> index d8845d4aac6a..6040817c036f 100644
>> --- a/arch/um/drivers/chan_user.c
>> +++ b/arch/um/drivers/chan_user.c
>> @@ -256,7 +256,8 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
>>  		goto out_close;
>>  	}
>>  
>> -	if (os_set_fd_block(*fd_out, 0)) {
>> +	err = os_set_fd_block(*fd_out, 0);
>> +	if (err) {
>>  		printk(UM_KERN_ERR "winch_tramp: failed to set thread_fd "
>>  		       "non-blocking.\n");
>>  		goto out_close;
>> -- 
>> 2.25.1
>>
>>
>>
> 
> Sorry for the necro bump but this patch as commit ccf1236ecac4 ("um: fix
> error return code in winch_tramp()") prevents UML from exiting cleanly
> when it is called from within in a shell script. It is still
> reproducible at next-20220323. I did see a patch from Richard that
> touches this area but that patch does not make a difference:
> 
> https://lore.kernel.org/r/20220101215810.13260-3-richard@nod.at/
> 
> My bisect log:
> 
> # bad: [7d2a07b769330c34b4deabeed939325c77a7ec2f] Linux 5.14
> # good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
> git bisect start 'v5.14' 'v5.13'
> # good: [406254918b232db198ed60f5bf1f8b84d96bca00] Merge tag 'perf-tools-for-v5.14-2021-07-01' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
> git bisect good 406254918b232db198ed60f5bf1f8b84d96bca00
> # good: [4ea90317956718e0648e1f87e56530db809a5a04] Merge tag 'for-linus-5.14-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
> git bisect good 4ea90317956718e0648e1f87e56530db809a5a04
> # bad: [65ca89c2b12cca0d473f3dd54267568ad3af55cc] ASoC: intel: atom: Fix breakage for PCM buffer address setup
> git bisect bad 65ca89c2b12cca0d473f3dd54267568ad3af55cc
> # bad: [6e207b882159ed3e35a4cd4ff0fc155cce5e3cbc] Merge tag 'arm-soc-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect bad 6e207b882159ed3e35a4cd4ff0fc155cce5e3cbc
> # good: [f55966571d5eb2876a11e48e798b4592fa1ffbb7] Merge tag 'drm-next-2021-07-08-1' of git://anongit.freedesktop.org/drm/drm
> git bisect good f55966571d5eb2876a11e48e798b4592fa1ffbb7
> # bad: [1459718d7d79013a4814275c466e0b32da6a26bc] Merge tag 'powerpc-5.14-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> git bisect bad 1459718d7d79013a4814275c466e0b32da6a26bc
> # good: [227c4d507c71acb7bece298a98d83e5b44433f62] Merge tag 'f2fs-for-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
> git bisect good 227c4d507c71acb7bece298a98d83e5b44433f62
> # good: [96890bc2eaa1f6bfc1b194e0f0815a10824352a4] Merge tag 'nfs-for-5.14-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
> git bisect good 96890bc2eaa1f6bfc1b194e0f0815a10824352a4
> # good: [e49d68ce7cc5a865ce14c1e57938438ab01c3ce3] Merge tag 'ext4_for_linus_stable' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
> git bisect good e49d68ce7cc5a865ce14c1e57938438ab01c3ce3
> # bad: [ccf1236ecac476d9d2704866d9a476c86e387971] um: fix error return code in winch_tramp()
> git bisect bad ccf1236ecac476d9d2704866d9a476c86e387971
> # good: [68f5d3f3b6543266b29e047cfaf9842333019b4c] um: add PCI over virtio emulation driver
> git bisect good 68f5d3f3b6543266b29e047cfaf9842333019b4c
> # good: [c0ecca6604b80e438b032578634c6e133c7028f6] um: enable the use of optimized xor routines in UML
> git bisect good c0ecca6604b80e438b032578634c6e133c7028f6
> # good: [80f849bf541ef9b633a9c08ac208f9c9afd14eb9] um: implement flush_cache_vmap/flush_cache_vunmap
> git bisect good 80f849bf541ef9b633a9c08ac208f9c9afd14eb9
> # good: [b77e81fbe5f5fb4ad9a61ec80f6d1e30b6da093a] um: fix error return code in slip_open()
> git bisect good b77e81fbe5f5fb4ad9a61ec80f6d1e30b6da093a
> # first bad commit: [ccf1236ecac476d9d2704866d9a476c86e387971] um: fix error return code in winch_tramp()
> 
> $ make -skj"$(nproc)" ARCH=um mrproper defconfig all
> 
> $ ./linux ubd0=...
> ...
> Run /sbin/init as init process
> EXT4-fs (ubda): re-mounted. Quota mode: none.
> Starting syslogd: OK
> Starting klogd: OK
> Running sysctl: OK
> Initializing random number generator: OK
> Saving random seed: OK
> Starting network: OK
> Linux version 5.17.0-next-20220323 (nathan@dev-arch.thelio-3990X) (gcc (GCC) 11.2.0, GNU ld (GNU Binutils) 2.38) #1 Wed Mar 23 12:05:22 MST 2022
> Stopping network: OK
> Saving random seed: OK
> Stopping klogd: OK
> Stopping syslogd: OK
> EXT4-fs (ubda): re-mounted. Quota mode: none.
> The system is going down NOW!
> Sent SIGTERM to all processes
> Sent SIGKILL to all processes
> Requesting system poweroff
> reboot: System halted
> 
> $ echo $?
> 0
> 
> $ cat test.sh
> #!/usr/bin/env bash
> 
> ./linux ubd0=...
> 
> $ ./test.sh
> ...
> Run /sbin/init as init process
> EXT4-fs (ubda): re-mounted. Quota mode: none.
> Starting syslogd: OK
> Starting klogd: OK
> Running sysctl: OK
> Initializing random number generator: OK
> Saving random seed: OK
> Starting network: OK
> Linux version 5.17.0-next-20220323 (nathan@dev-arch.thelio-3990X) (gcc (GCC) 11.2.0, GNU ld (GNU Binutils) 2.38) #1 Wed Mar 23 12:10:31 MST 2022
> Stopping network: OK
> Saving random seed: OK
> Stopping klogd: OK
> Stopping syslogd: OK
> EXT4-fs (ubda): re-mounted. Quota mode: none.
> The system is going down NOW!
> Sent SIGTERM to all processes
> Sent SIGKILL to all processes
> Requesting system poweroff
> reboot: System halted
> ./test.sh: line 5: 970978 Killed                  ./linux ubd0=...
> 
> $ echo $?
> 137
> 
> The rootfs is a simple Buildroot image, which just prints the version
> string then runs "poweroff". It is available at:
> 
> https://github.com/nathanchance/boot-utils/raw/bd4b962ee12e00f666eef12e3413a79d334a0685/images/x86_64/rootfs.ext4.zst
> 
> in case it helps. I am happy to provide more information or test patches
> as necessary.
> 
> Cheers,
> Nathan
> 
> 
