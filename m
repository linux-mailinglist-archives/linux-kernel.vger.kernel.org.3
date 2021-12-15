Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521104752EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhLOGXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhLOGXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:23:46 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75078C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:23:46 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id kl7so2581349qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Rc5xtFp4u75d66LLYKtxhf7lmOqThaEzRIkdwyUgUEc=;
        b=H7f/qfVfKBmo+iFdBKfYICARTkjIneUXudsZaaPgNIY1nXeISYJ9ZgzT8vROoaR/j6
         TbeX1N45CrKCQpSJnW4myRzFVD1laJa1Cs1eVEQlhd9ilSHUn8/KXrW7O00qV1fDXJhR
         fsUQtqffQZ5TJ7OWAwaKVGaOFPk6HIxAZwPNBZn4cDd+7jOggIa5hcYiONsolLEUT93b
         UT1IXhB/gN+VWDsHCD91PHc+op6SChCDrGehX4QoTf+hpwaVAz5tOJlLTxkApvzkoOYW
         ht8HAvDVw0/0q1jwqNjOqJec7H1KHId3Lj/WSt4kpBXBSpG4oMyipfvSyLdgaIbW3vhq
         HQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Rc5xtFp4u75d66LLYKtxhf7lmOqThaEzRIkdwyUgUEc=;
        b=7Hjn+al6sQ0N80n//jsx/Nm96ldn11Su0AhD/1mRTWkGfMiTRUeIdIZQvBoCMTAHD5
         hzgJi8ADl/HMDUvYQkkBCkq4OqCxWuYB0d8bNMX5YLRh8pbiTrofGMyzVisnyH6QvK47
         CaPpUij3YtZWsNIOehvF6OEuBr5NkdZyX5ORByoDayKAqxk6bmhlM2gf5tO5m6liiMNh
         BCILEQw1423ZrylV5GADR9rky0+rU+v09bQFIc2nRabE0p3V9jWTn24/7bHj7Ih1C5ZX
         Prrs7Rd8WrhblXpXOyYq8atDWU5SUSu3GQUMaEpR/xZxeqMXNRgB3nBNsSARb1fSb8l+
         njhg==
X-Gm-Message-State: AOAM53335yH9n5fE0TRZZ16LxwczDXqCEopirhqzzytmaY+4YDXy1NAL
        0wQTyp35LAXxTuu3nffLBtd/xAebYhYbQA==
X-Google-Smtp-Source: ABdhPJwrqhJXWl1YMtTct0xm5CppzumvwPiBGXjS6u4bkCZS76kogu7ZJdfk89rUy2GooCf6KVwrqQ==
X-Received: by 2002:a05:6214:246d:: with SMTP id im13mr2449436qvb.44.1639549425089;
        Tue, 14 Dec 2021 22:23:45 -0800 (PST)
Received: from juliacomputing.com ([2601:184:4780:3aef:8c6:cc82:9394:77a7])
        by smtp.gmail.com with ESMTPSA id r8sm857396qtw.35.2021.12.14.22.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 22:23:44 -0800 (PST)
Date:   Wed, 15 Dec 2021 01:23:42 -0500
From:   Keno Fischer <keno@juliacomputing.com>
To:     linux-kernel@vger.kernel.org
Cc:     gorcunov@openvz.org, khlebnikov@openvz.org, oleg@redhat.com,
        akpm@linux-foundation.org, keescook@chromium.org, tj@kernel.org,
        dbueso@suse.de, matthltc@us.ibm.com,
        kosaki.motohiro@jp.fujitsu.com, xemul@parallels.com,
        linux-mm@kvack.org
Subject: [PATCH] c/r: prctl: Remove PR_SET_MM_EXE_FILE old file mapping
 restriction
Message-ID: <20211215062342.GA1548576@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* What this patch does

This patch changes the behavior of replace_mm_exe_file to remove the
restriction that the current mm may not have any mappings of the
previous exe_file. This restriction has a bit of a complicated history,
which I will summarize below, but the upshot is that whatever value it
may have had when originally introduced (and it is worth pointing out
that the history does not suggest it was ever seen as a security
feature) - in its current state, the restriction is essentially useless
and merely forces userspace into awkward contusions (and extra system
calls) to be able to use it.

* Context/History

The /proc/<pid>/exe symlink provides access to the file that was used
to execve <pid>. It is used for example by gdb to find the on-disk location
of the executed binary and read its debug information.

Originally, the /proc/<pid>/exe symlink was immutable, set by the
kernel upon execve and never changed again. However, in b32dfe377
("c/r: prctl: add ability to set new mm_struct::exe_file"), `prctl`
gained the ability to modify this symlink for use by c/r, under a couple
of restrictions:

1. The process contains no mappings marked as VM_EXECUTABLE (i.e. mappings
   created in execve or by splitting mappings thereof).
2. The new file has appropriate access permissions
3. The call may only be made once
4. The calling process has CAP_SYS_RESOURCE

The restriction we're considering here is point 1. For completeness, I
will note that restriction 3 was subsequently dropped, and restriction 4
was expanded to also allow the local user namespace's root to perform
the operation (as long as this was done using `PR_SET_MM_MAP`).

On restriction 1, the original commit notes that:

    Note it allows to change /proc/$pid/exe if there are no VM_EXECUTABLE
    vmas present for current process, simply because this feature is a special
    to C/R and mm::num_exe_file_vmas become meaningless after that.

The `num_exe_file_vmas` counter was a refcount for the number of mapped VMAs
with the VM_EXECUTABLE flag set. It was used to drop the reference of
/proc/<pid>/exe to the execve'd file if all mappings to it created in
sys_execve were subsequently removed. Thus, as best I can tell, this restriction
was simply a convenience to avoid the additional complexity of correctly handling
non-zero `num_exe_file_vmas` while updating the exe_file.

However, `num_exe_file_vmas` was removed a few months later in e9714acf8c
("mm: kill vma flag VM_EXECUTABLE and mm->num_exe_file_vmas") with the
justification that nobody depended on it and the functionality could
be replaced by an appropriate use of PR_SET_MM_EXE_FILE.

Because of this change, the restriction was updated in bafb282d ("c/r: prctl:
update prctl_set_mm_exe_file() after mm->num_exe_file_vmas removal") to
not allow any mappings present in the memory map of the process other
than the *new* exe_file (a more strict restriction than the original
restriction) and then again in 4229fb1dc ("c/r: prctl: less paranoid
prctl_set_mm_exe_file()") to disallow any mappings of the old exe_file
(still a more strict restriction than the original restriction on
VM_EXECUTABLE mappings, as now any mapping with the same path would
be forbidden not just those created in execve).

It is worth noting that at this point the check for mappings of the
original file and the modification to mm->exe_file were still protected
by the mm's mmap_sem and thus atomic with respect to other modifications
of the mm. However, this too was changed in 6e399cd14 ("prctl: avoid using mmap_sem
for exe_file serialization") and the prctl now separately acquires the
mm's read sema just for the purpose of enforcing the restriction (but
does not enforce any sort of atomicity with respect to the update of
the exe_file).

Except for minor refactorings, this is essentially the state of the
restriction in today's kernel. It appears to me that this was originally
a technical restriction to avoid additional complexity from the interaction
with VM_EXECTUABLE, but when this was removed the question of whether the
restriction was still sensible was not revisited. I searched around for
any additional justifications for this restriction, but could not
find any, and given the lack of enforced atomicity, it does not seem
that any guarantees are actually provided in practice.

* The use case for dropping the restriction

Apart from a general dislike for executing unnecessary code, there are
some practical reasons to want to drop the restriction. In particular,
it is currently awkward to call PR_SET_MM_MAP from an executable itself.
In the original c/r usecase, the restorer was a ptracer and the original
exe_file merely a stub that essentially did nothing, so it was no trouble
to unmap it completely, However, there are a few usecases where
PR_SET_MM_MAP would be useful that are not ptracers.

One such use case are preloaders that run before ld.so and the main
executable in order to control the memory layout. Wine has such a
preloader, but they are also useful to control memory layout for
debugging purposes. Another use case are non-ptrace checkpoint/restore
systems (ptrace is powerful, but not particularly performant, so
c/r systems that are ok with some state changing can gain
performance by not using it).

It is of course possible to use PR_SET_MM_MAP in these contexts
by relocating the executable to private memory and unmapping the
original, but this introduces additional unnecessary complexity for
what appears to be no good reason.

* Summary

As far as I can tell, the restriction against mappings of the old
exe_file in PR_SET_MM_EXE_FILE/PR_SET_MM_MAP exists for no good
reason, but is simply an artifact of its development process.
Because it makes it hard to use this APIs in legitimate contexts
I propose that the restriction be dropped.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 kernel/fork.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697..11e01dae8bbc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1203,27 +1203,9 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
  */
 int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 {
-	struct vm_area_struct *vma;
 	struct file *old_exe_file;
 	int ret = 0;
 
-	/* Forbid mm->exe_file change if old file still mapped. */
-	old_exe_file = get_mm_exe_file(mm);
-	if (old_exe_file) {
-		mmap_read_lock(mm);
-		for (vma = mm->mmap; vma && !ret; vma = vma->vm_next) {
-			if (!vma->vm_file)
-				continue;
-			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path))
-				ret = -EBUSY;
-		}
-		mmap_read_unlock(mm);
-		fput(old_exe_file);
-		if (ret)
-			return ret;
-	}
-
 	/* set the new file, lockless */
 	ret = deny_write_access(new_exe_file);
 	if (ret)
-- 
2.25.1

