Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0902B494ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359843AbiATNT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:19:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44152 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359828AbiATNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:19:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 603FC1F388;
        Thu, 20 Jan 2022 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642684777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/rIyZ0eYHwO24uH3+p50XNcMLDIC/903Ut0llfCdn8g=;
        b=AwNHdnlmrxrsb2c4T+hyxuzkrhPIGHag6/34I8hExXvWUNN+eAfkUoXMeWmLbKhwaYB6qg
        JfGFxR6mPVpbL01KgWbZrLu9w0doL+oFf/YEQc9p9HSzZr4yib9TZVSGVSxb11ZXFo8dhp
        fw8d2Ia+EzdAkOMYJ9FaT3vb+D1OVqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642684777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/rIyZ0eYHwO24uH3+p50XNcMLDIC/903Ut0llfCdn8g=;
        b=atlMhBqFcTmmNOsTNZk87Y41sPOPiZjo7jp7cwNz9ebrTz1hcktOk9dODehAZ1QaIPr/uD
        geg/mMKMmWlqDBBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50F4213BCC;
        Thu, 20 Jan 2022 13:19:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hrO6E2lh6WFvdwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 20 Jan 2022 13:19:37 +0000
Date:   Thu, 20 Jan 2022 14:19:36 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] block: hold queue lock while iterating in
 diskstats_show
Message-ID: <20220120131936.mlug7nhnoe73abx5@carbon.lan>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-3-dwagner@suse.de>
 <Yelb4+r5KuV67tO0@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yelb4+r5KuV67tO0@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On Thu, Jan 20, 2022 at 08:56:03PM +0800, Ming Lei wrote:
> On Thu, Jan 20, 2022 at 11:52:48AM +0100, Daniel Wagner wrote:
> > The request queues can be freed while we operate on them. Make sure we
> 
> It shouldn't be freed here.

No, that is not what I tried to say. We somehow end here operating on
pointers which are invalid.

> > hold a reference when using blk_mq_queue_tag_busy_iter.
> > 
> > RIP: blk_mq_queue_tag_busy_iter
> 
> Any chance to pose the whole stack trace?

[323465.820735] nvme nvme3: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 100.102.253.10:8009
[323465.821654] nvme nvme3: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[323465.850291] nvme nvme3: creating 80 I/O queues.
[323465.974196] nvme nvme3: mapped 80/0/0 default/read/poll queues.
[323466.031107] nvme nvme3: new ctrl: NQN "nqn.1988-11.com.dell:powerstore:00:a2ee06317d1845EE5227", addr 100.102.251.11:4420
[323466.093520] nvme nvme4: creating 80 I/O queues.
[323466.131740] nvme nvme4: mapped 80/0/0 default/read/poll queues.
[323466.194742] nvme nvme4: new ctrl: NQN "nqn.1988-11.com.dell:powerstore:00:a2ee06317d1845EE5227", addr 100.102.252.12:4420
[323466.207338] nvme nvme5: creating 80 I/O queues.
[323466.219473] nvme nvme5: mapped 80/0/0 default/read/poll queues.
[323466.256877] nvme nvme5: new ctrl: NQN "nqn.1988-11.com.dell:powerstore:00:a2ee06317d1845EE5227", addr 100.102.253.12:4420
[323466.295990] nvme nvme6: creating 80 I/O queues.
[323466.308171] nvme nvme6: mapped 80/0/0 default/read/poll queues.
[323466.359055] nvme nvme6: new ctrl: NQN "nqn.1988-11.com.dell:powerstore:00:a2ee06317d1845EE5227", addr 100.102.251.12:4420
[323466.366912] nvme nvme7: creating 80 I/O queues.
[323466.379132] nvme nvme7: mapped 80/0/0 default/read/poll queues.
[323466.432957] nvme nvme7: new ctrl: NQN "nqn.1988-11.com.dell:powerstore:00:a2ee06317d1845EE5227", addr 100.102.252.11:4420
[323466.458548] nvme nvme8: creating 80 I/O queues.
[323466.474414] nvme nvme8: mapped 80/0/0 default/read/poll queues.
[323466.548254] nvme nvme8: new ctrl: NQN "nqn.1988-11.com.dell:powerstore:00:a2ee06317d1845EE5227", addr 100.102.253.11:4420
[323467.255527] BUG: kernel NULL pointer dereference, address: 0000000000000000
[323467.255538] #PF: supervisor read access in kernel mode
[323467.255541] #PF: error_code(0x0000) - not-present page
[323467.255544] PGD 0 P4D 0 
[323467.255550] Oops: 0000 [#1] SMP PTI
[323467.255555] CPU: 13 PID: 17640 Comm: iostat Kdump: loaded Tainted: G          IOE  X    5.3.18-59.27-default #1 SLE15-SP3
[323467.255559] Hardware name: Dell Inc. PowerEdge R940xa/08XR9M, BIOS 2.12.2 07/12/2021
[323467.255569] RIP: 0010:blk_mq_queue_tag_busy_iter+0x1e4/0x2e0
[323467.255573] Code: 89 44 24 48 41 8b 1f 85 db 0f 84 d1 fe ff ff 4c 89 6c 24 20 4c 89 74 24 28 89 e8 44 29 e3 48 8d 04 40 48 c1 e0 06 49 03 47 10 <48> 8b 10 39 d3 0f 43 da 48 8b 90 80 00 00 00 41 01 dc 48 f7 d2 48
[323467.255583] RSP: 0018:ffffb701aefb7c20 EFLAGS: 00010246
[323467.255587] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[323467.255592] RDX: ffff954f43c14c00 RSI: ffffffffbaa442c0 RDI: ffff954fb3749010
[323467.255597] RBP: 0000000000000000 R08: 0000000800000000 R09: 00000008ffffffff
[323467.255602] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[323467.255607] R13: ffff9567b2200000 R14: ffff954798c09bc0 R15: ffff954798c09c20
[323467.255612] FS:  00007f6032444580(0000) GS:ffff956fbf6c0000(0000) knlGS:0000000000000000
[323467.255616] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[323467.255618] CR2: 0000000000000000 CR3: 00000037bc7c0001 CR4: 00000000007726e0
[323467.255621] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[323467.255624] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[323467.255626] PKRU: 55555554
[323467.255628] Call Trace:
[323467.255641]  ? blk_mq_hctx_mark_pending+0x70/0x70
[323467.255647]  ? diskstats_show+0x207/0x2a0
[323467.255651]  ? blk_mq_hctx_mark_pending+0x70/0x70
[323467.255654]  blk_mq_in_flight+0x35/0x60
[323467.255659]  diskstats_show+0x6d/0x2a0
[323467.255669]  ? klist_next+0x88/0x110
[323467.255676]  seq_read+0x2a6/0x3f0
[323467.255682]  proc_reg_read+0x39/0x60
[323467.255690]  vfs_read+0x89/0x140
[323467.255693]  ksys_read+0xa1/0xe0
[323467.255702]  do_syscall_64+0x5b/0x1e0
[323467.255709]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

> The disk device's refcnt is supposed to be grabbed by class device
> iterator code, so queue shouldn't be released in diskstats_show().

Okay, but it's not the disk device which is invalid as far I
understand. It's the request_queue which is bogus.

> Not mention blk_queue_enter() won't prevent disk from being released...

Understood.

Daniel
