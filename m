Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957D15893E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbiHCVDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238796AbiHCVDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FCC95C94E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659560589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRiv2PaeJkVEqCNTnndk1oWyf2qjDeiS5+bge+LAjkM=;
        b=d8lKUBiyNYB7GkbbjP8MBFdM/ii+8ECbpzbkgDEldlVQbl9XnzCNVPUQUjj7N80Qs1VvPg
        pFGBBv1uvSgyC+KICnpdo0GT/JW/MY3yieAGlLzMkrViurFRYv10XKynLG3EjyOKvattjT
        MQu2MYlFzmRRliN5s4Xg05OAAY8Wbws=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-hd3z8MuMNMicmeI3RAeLJw-1; Wed, 03 Aug 2022 17:03:07 -0400
X-MC-Unique: hd3z8MuMNMicmeI3RAeLJw-1
Received: by mail-qv1-f69.google.com with SMTP id cz12-20020a056214088c00b004763e7e7d81so6757642qvb.21
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 14:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uRiv2PaeJkVEqCNTnndk1oWyf2qjDeiS5+bge+LAjkM=;
        b=q80abWYMysxjtKSvM8vJ5gpf75oSCSwZDCw29FlMdLGmgbPYMOWySFhFM/VRG3uJ3I
         gdN2jGVP3prDwb7n82jXvcH3nW/fQvPWwqBJQTu4RFOV0+svyJZgiKWQQUXjfg3Hgn8V
         DWrEp4b65es5C5framCRPQEaelRnDmiFpPz2oyz49Qi36awganhvwRJGg1FYYmwWowiG
         JDOUj/rivf/xVboCLN1dZyWQRblGu1Zp3ns36KC/1a2biFjwPv8LZSE42CgotnEkWDze
         wBxTTTgQxgdFGjG4HS5fSvUsrPtPtjUtM3g8CMUDcv1YvG3bSsfCCQ2lp7F0pCx1N8qY
         JoCQ==
X-Gm-Message-State: ACgBeo3XK1AalCQW5Vq7ZPnog7sLQgQNBIhF4LlD3jo3giUce2133ZYu
        RH1x2mZo46G3CK2VkFIzOtR/ev2Kb6ix9Gy/Iw5tfMtKxijUdGR7IkIf0mJT7m3yIKvVs/Bcllm
        xnH4xUqdhlRNHBTVoc+MR2mIY
X-Received: by 2002:a05:620a:bce:b0:6b8:e8c5:21ce with SMTP id s14-20020a05620a0bce00b006b8e8c521cemr2917620qki.484.1659560586893;
        Wed, 03 Aug 2022 14:03:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5GW60o+oyBXaeA7BRV0uTMa9neCZkwEjzaqr7CvicF+UKU6v9EafYSt5KCp+LFKq/bp4OFTw==
X-Received: by 2002:a05:620a:bce:b0:6b8:e8c5:21ce with SMTP id s14-20020a05620a0bce00b006b8e8c521cemr2917597qki.484.1659560586523;
        Wed, 03 Aug 2022 14:03:06 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a448e00b006b6757a11fcsm14145144qkp.36.2022.08.03.14.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:03:05 -0700 (PDT)
Date:   Wed, 3 Aug 2022 17:03:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     syzbot <syzbot+824e71311e757a9689ff@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] WARNING in hugetlb_change_protection
Message-ID: <YuriiFpv/enJW1oE@xz-m1.local>
References: <000000000000098a0105e557f130@google.com>
 <YuqqLfu1E62PqnKS@monkey>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dGeUfg0yu8nnRmpU"
Content-Disposition: inline
In-Reply-To: <YuqqLfu1E62PqnKS@monkey>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dGeUfg0yu8nnRmpU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi, Mike,

Thanks for forwarding.

On Wed, Aug 03, 2022 at 10:02:37AM -0700, Mike Kravetz wrote:
> I'll start looking at this, but adding Peter this may be related to his
> recent changes.
> -- 
> Mike Kravetz
> 
> On 08/03/22 08:32, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    e65c6a46df94 Merge tag 'drm-fixes-2022-07-30' of git://ano..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=139cc282080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=26034e6fe0075dad
> > dashboard link: https://syzkaller.appspot.com/bug?extid=824e71311e757a9689ff
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: i386
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+824e71311e757a9689ff@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 28745 at include/linux/swapops.h:319 make_pte_marker_entry include/linux/swapops.h:319 [inline]

This is the warning code I added to make sure pte marker won't be created
if not configured at all:

static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
{
	/* This should never be called if !CONFIG_PTE_MARKER */
	WARN_ON_ONCE(1);
	return swp_entry(0, 0);
}

The stack below comes from a UFFDIO_WRITEPROTECT, however logically it
shouldn't really reach there - if with !PTE_MARKER then it must be with
!PTE_MARKER_UFFD_WP, then we should have returned "false" if hugetlb wanted
to register with uffd-wp:

static inline bool vma_can_userfault(struct vm_area_struct *vma,
				     unsigned long vm_flags)
{
	if (vm_flags & VM_UFFD_MINOR)
		return is_vm_hugetlb_page(vma) || vma_is_shmem(vma);

#ifndef CONFIG_PTE_MARKER_UFFD_WP
	/*
	 * If user requested uffd-wp but not enabled pte markers for
	 * uffd-wp, then shmem & hugetlbfs are not supported but only
	 * anonymous.
	 */
	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
		return false;
#endif
	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
	    vma_is_shmem(vma);
}

Then the UFFDIO_WRITEPROTECT should have failed already.. at:

	if (!userfaultfd_wp(dst_vma))
		goto out_unlock;

in mwriteprotect_range().

I still have no idea how the bot managed to trigger a real wr-protect upon
this vma (which I don't think should have registered with uffd-wp but maybe
it can be worked around somehow..).  However to make this even safer we can
also guard the pte marker callers with CONFIG_PTE_MARKER_UFFD_WP. Patch
attached for that, but since this seems to have no reproducer yet maybe no
easy way to verify it.

At the meantime, I'd also like to double check the kernel config to make
sure CONFIG_PTE_MARKER_UFFD_WP will always be unset when CONFIG_PTE_MARKER=n.
Anyone knows where I can fetch the config somewhere?

Thanks,

> > WARNING: CPU: 1 PID: 28745 at include/linux/swapops.h:319 make_pte_marker include/linux/swapops.h:342 [inline]
> > WARNING: CPU: 1 PID: 28745 at include/linux/swapops.h:319 hugetlb_change_protection+0xf85/0x1610 mm/hugetlb.c:6392
> > Modules linked in:
> > CPU: 1 PID: 28745 Comm: syz-executor.3 Not tainted 5.19.0-rc8-syzkaller-00146-ge65c6a46df94 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> > RIP: 0010:make_pte_marker_entry include/linux/swapops.h:319 [inline]
> > RIP: 0010:make_pte_marker include/linux/swapops.h:342 [inline]
> > RIP: 0010:hugetlb_change_protection+0xf85/0x1610 mm/hugetlb.c:6392
> > Code: e8 d0 5a b7 ff 0f b6 94 24 80 00 00 00 48 8b 84 24 98 00 00 00 84 d2 0f 84 ef 02 00 00 49 89 c4 e9 48 fb ff ff e8 ab 5e b7 ff <0f> 0b 48 b9 00 00 00 00 00 fc ff df 48 89 d8 48 c1 e8 03 80 3c 08
> > RSP: 0018:ffffc90014cc7780 EFLAGS: 00010212
> > RAX: 000000000000082a RBX: ffff88807750e820 RCX: ffffc90006723000
> > RDX: 0000000000040000 RSI: ffffffff81c30c25 RDI: 0000000000000007
> > RBP: ffff888074de5ea0 R08: 0000000000000007 R09: 0000000000000000
> > R10: 0000000000000004 R11: 0000000000000001 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000004 R15: ffff88801fcc8e00
> > FS:  0000000000000000(0000) GS:ffff8880b9b00000(0063) knlGS:00000000f7f06b40
> > CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > CR2: 0000000020000040 CR3: 000000001b84c000 CR4: 00000000003526e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  change_protection+0x96b/0x3ad0 mm/mprotect.c:463
> >  mwriteprotect_range+0x387/0x5c0 mm/userfaultfd.c:759
> >  userfaultfd_writeprotect fs/userfaultfd.c:1823 [inline]
> >  userfaultfd_ioctl+0x438/0x4340 fs/userfaultfd.c:1997
> >  compat_ptr_ioctl+0x67/0x90 fs/ioctl.c:906
> >  __do_compat_sys_ioctl+0x1c7/0x290 fs/ioctl.c:968
> >  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
> >  __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
> >  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
> >  entry_SYSENTER_compat_after_hwframe+0x70/0x82
> > RIP: 0023:0xf7f0b549
> > Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> > RSP: 002b:00000000f7f065cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000c018aa06
> > RDX: 00000000200000c0 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >  </TASK>
> > ----------------
> > Code disassembly (best guess):
> >    0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
> >    4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
> >    a:	10 06                	adc    %al,(%rsi)
> >    c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
> >   10:	10 07                	adc    %al,(%rdi)
> >   12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
> >   16:	10 08                	adc    %cl,(%rax)
> >   18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
> >   1c:	00 00                	add    %al,(%rax)
> >   1e:	00 00                	add    %al,(%rax)
> >   20:	00 51 52             	add    %dl,0x52(%rcx)
> >   23:	55                   	push   %rbp
> >   24:	89 e5                	mov    %esp,%ebp
> >   26:	0f 34                	sysenter
> >   28:	cd 80                	int    $0x80
> > * 2a:	5d                   	pop    %rbp <-- trapping instruction
> >   2b:	5a                   	pop    %rdx
> >   2c:	59                   	pop    %rcx
> >   2d:	c3                   	retq
> >   2e:	90                   	nop
> >   2f:	90                   	nop
> >   30:	90                   	nop
> >   31:	90                   	nop
> >   32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> >   39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 

-- 
Peter Xu

--dGeUfg0yu8nnRmpU
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-uffd-Guard-pte-marker-callers-with-PTE_MARKER_UFF.patch"

From 1be141a6accbb07e1c9bff665f3c5e147beea70f Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 3 Aug 2022 16:40:10 -0400
Subject: [PATCH] mm/uffd: Guard pte marker callers with PTE_MARKER_UFFD_WP
Content-type: text/plain

Logically no !PTE_MARKER user should be able to trigger make_pte_marker()
in any path, however to add extra guard with it put all pte marker code
into CONFIG_PTE_MARKER_UFFD_WP so they'll not be compiled in if not
configured.

Reported-by: syzbot+824e71311e757a9689ff@syzkaller.appspotmail.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c  | 6 ++++++
 mm/mprotect.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a18c071c294e..e632cdf1e3f4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5049,6 +5049,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		 * unmapped and its refcount is dropped, so just clear pte here.
 		 */
 		if (unlikely(!pte_present(pte))) {
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
 			/*
 			 * If the pte was wr-protected by uffd-wp in any of the
 			 * swap forms, meanwhile the caller does not want to
@@ -5060,6 +5061,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 				set_huge_pte_at(mm, address, ptep,
 						make_pte_marker(PTE_MARKER_UFFD_WP));
 			else
+#endif
 				huge_pte_clear(mm, address, ptep, sz);
 			spin_unlock(ptl);
 			continue;
@@ -5088,11 +5090,13 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
 		if (huge_pte_dirty(pte))
 			set_page_dirty(page);
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
 		/* Leave a uffd-wp pte marker if needed */
 		if (huge_pte_uffd_wp(pte) &&
 		    !(zap_flags & ZAP_FLAG_DROP_MARKER))
 			set_huge_pte_at(mm, address, ptep,
 					make_pte_marker(PTE_MARKER_UFFD_WP));
+#endif
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
 		page_remove_rmap(page, vma, true);
 
@@ -6387,10 +6391,12 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			pages++;
 		} else {
 			/* None pte */
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
 			if (unlikely(uffd_wp))
 				/* Safe to modify directly (none->non-present). */
 				set_huge_pte_at(mm, address, ptep,
 						make_pte_marker(PTE_MARKER_UFFD_WP));
+#endif
 		}
 		spin_unlock(ptl);
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ba5592655ee3..85ef55a74d6e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -221,6 +221,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 		} else {
 			/* It must be an none page, or what else?.. */
 			WARN_ON_ONCE(!pte_none(oldpte));
+#ifdef CONFIG_PTE_MARKER_UFFD_WP
 			if (unlikely(uffd_wp && !vma_is_anonymous(vma))) {
 				/*
 				 * For file-backed mem, we need to be able to
@@ -232,6 +233,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 					   make_pte_marker(PTE_MARKER_UFFD_WP));
 				pages++;
 			}
+#endif
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
-- 
2.32.0


--dGeUfg0yu8nnRmpU--

