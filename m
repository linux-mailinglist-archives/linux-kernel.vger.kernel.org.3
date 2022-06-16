Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089CD54EA49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378419AbiFPTo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347111AbiFPTo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:44:26 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B4580C2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=gBBIiGrIzQFDdusUg+O8IwmvVD8wi/w7fagdVX80l70=; b=vZa9DhHtWjq1lMb3ZHtzkpRalg
        gPOQOG9/87rrZsr2ifRQTfpoAahv7cEb8WzyEBDjcTBlP+WIoPTrQzehXaqLVycLVz3mmH4GOu7uZ
        1UDfg0fVxWsLpN551c6bMEeOujXGmfbGcmsol/Spo+PuCW9nO1ukmOS+hxo+OkAUsC0u+Qco6mKOF
        2Owc5fyoK4MP9M5jP2vGLGeu8J9Q+7MoiSUn8AzuMcIlppi0qrahk6/EO+7S973NieifmgCKxicY5
        ABeeyVyqCdxVlteYYxjmK8MbJ/+ui42j6p5v9NDsjLBmjORXUQHRV/SX6NBaN02/QYL/v0Rrljt3a
        y3r9jZiUpQ3PBRNcmCLB/6OYK5l/UphW/PjdXvV3M3IrjIWQSwrRakyC8Y6JSOu4NX4szA91WJKAu
        bN/U1uVS2RNoV8Gj8oMM8pdD8S3U6UmUScDu9BF2nWDkSFgmIfSdF9PUWcyMv0TtGbu/FHi7ThN50
        ek0GluXf2tsMkN/R3gSeVUwzlnJbiw9K2oiDZSaUNtUiLtibMD5EeVOrzu6/SV9H2Sd2+9IKAsNV9
        0cpUIwc7/cF9yEkFVR5Fim8pSLSRe0hGcZ3CWXlgj0N1lz9X/G9/zlcbaPfXiQScKsvpvLXCeiHy7
        e5rzIpu4QvGLVD4OFHcm1DOVmrduwZiMLwKTdL6U0=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] net/9p: show warning on Tread/Twrite if wrong file mode
Date:   Thu, 16 Jun 2022 21:44:16 +0200
Message-ID: <1692377.rnsbsUYrV6@silver>
In-Reply-To: <E1o1tHC-00039k-04@lizzy.crudebyte.com>
References: <E1o1tHC-00039k-04@lizzy.crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 16. Juni 2022 19:09:42 CEST Christian Schoenebeck wrote:
> The netfs changes (eb497943fa21) introduced cases where 'Tread' was sent
> to 9p server on a fid that was opened in write-only file mode. It took
> some time to find the cause of the symptoms observed (EBADF errors in
> user space apps). Add warnings to detect such issues easier in future.
> 
> Signed-off-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Link: https://lore.kernel.org/netdev/3645230.Tf70N6zClz@silver/
> ---
> As requested by Dominique, here a clean version of my previous
> EBADF trap code to be merged. Dominique, if you already have an
> equivalent patch queued, then just go ahead. I don't mind.
> 
> I'm currently testing your EBADF fix patch and the discussed,
> slightly adjusted versions. Looking good so far, but I'll report
> back later on.
> 
> 
>  net/9p/client.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 8bba0d9cf975..05dead12702d 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -1555,6 +1555,8 @@ p9_client_read(struct p9_fid *fid, u64 offset, struct
> iov_iter *to, int *err) int total = 0;
>  	*err = 0;
> 
> +	WARN_ON((fid->mode & O_ACCMODE) == O_WRONLY);
> +
>  	while (iov_iter_count(to)) {
>  		int count;
> 
> @@ -1648,6 +1650,8 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct
> iov_iter *from, int *err) p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset
> %llu count %zd\n", fid->fid, offset, iov_iter_count(from));
> 
> +	WARN_ON((fid->mode & O_ACCMODE) == O_RDONLY);
> +
>  	while (iov_iter_count(from)) {
>  		int count = iov_iter_count(from);
>  		int rsize = fid->iounit;

Better postpone this patch for now: when I use cache=loose, everything looks
fine. But when I use cache=mmap it starts with the following warnings on boot:

[    7.164456] WARNING: CPU: 0 PID: 221 at net/9p/client.c:1653 p9_client_write+0x1b6/0x210 [9pnet]
[    7.164528] ? aa_replace_profiles (security/apparmor/policy.c:1089) 
[    7.164534] v9fs_file_write_iter (fs/9p/vfs_file.c:403) 9p
[    7.164539] new_sync_write (fs/read_write.c:505 (discriminator 1)) 
[    7.164551] vfs_write (fs/read_write.c:591) 
[    7.164557] ksys_write (fs/read_write.c:644) 
[    7.164559] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[    7.164571] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115)

[    9.698867] WARNING: CPU: 1 PID: 314 at net/9p/client.c:1653 p9_client_write+0x1b6/0x210 [9pnet]
[    9.737339] ? folio_add_lru (./arch/x86/include/asm/preempt.h:103 mm/swap.c:468) 
[    9.738599] ? _raw_spin_unlock (./arch/x86/include/asm/preempt.h:103 ./include/linux/spinlock_api_smp.h:143 kernel/locking/spinlock.c:186) 
[    9.739940] v9fs_file_write_iter (fs/9p/vfs_file.c:403) 9p
[    9.742655] new_sync_write (fs/read_write.c:505 (discriminator 1)) 
[    9.744063] vfs_write (fs/read_write.c:591) 
[    9.744858] ksys_write (fs/read_write.c:644) 
[    9.745573] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[    9.746339] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115)

And then after booting, when I start to actually do something on guest, it
spills the terminal with the following:

[  876.260885] WARNING: CPU: 1 PID: 197 at net/9p/client.c:1653 p9_client_write+0x1b6/0x210 [9pnet]
[  876.260955] ? preempt_count_add (./include/linux/ftrace.h:910 kernel/sched/core.c:5558 kernel/sched/core.c:5555 kernel/sched/core.c:5583) 
[  876.260960] v9fs_file_write_iter (fs/9p/vfs_file.c:403) 9p
[  876.260966] new_sync_write (fs/read_write.c:505 (discriminator 1)) 
[  876.260972] vfs_write (fs/read_write.c:591) 
[  876.260975] __x64_sys_pwrite64 (./include/linux/file.h:44 fs/read_write.c:707 fs/read_write.c:716 fs/read_write.c:713 fs/read_write.c:713) 
[  876.260979] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[  876.260982] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115)

Best regards,
Christian Schoenebeck


