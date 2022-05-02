Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B316F517675
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386840AbiEBS1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbiEBS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76F0765A1
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651515829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=YnGgV3cBQdP4rRNzFtYz1sHu9jEFYB/GjRyc9H3flIg=;
        b=ZxaaQbuYAISnMaD8w4ncGFcRXmpal5tS5iw/LWECNIuUbp9HtIwCfxdteG72IoKcj7ECU2
        6hYc2jRpd2Rj0tOR1Us9nHYpjdE/BR26Udv1ITshffxgCQS8RTFXpfG3uVtGFQe5XsI1XR
        UZm1UjB6IhM70xCWUlD9PW5Owspaa7c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-BWrhfp0QNx2yZGDGpirCqQ-1; Mon, 02 May 2022 14:23:48 -0400
X-MC-Unique: BWrhfp0QNx2yZGDGpirCqQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E2133C18520;
        Mon,  2 May 2022 18:23:48 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F387463E05;
        Mon,  2 May 2022 18:23:48 +0000 (UTC)
Received: from fche by redhat.com with local (Exim 4.94.2)
        (envelope-from <fche@redhat.com>)
        id 1nlai3-0006yl-3U; Mon, 02 May 2022 14:23:47 -0400
Date:   Mon, 2 May 2022 14:23:47 -0400
From:   "Frank Ch. Eigler" <fche@redhat.com>
To:     systemtap@sourceware.org, linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: systemtap 4.7 release
Message-ID: <20220502182347.GA26805@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The SystemTap team announces release 4.7

Enhancements to this release include: a new stap-profile-annotate
tool, a new --sign-module module signing option, -d is now implied for
processes specified with -c/-x

= Where to get it

  https://sourceware.org/systemtap/ - our project page
  https://sourceware.org/systemtap/ftp/releases/
  https://koji.fedoraproject.org/koji/packageinfo?packageID=615
  git tag release-4.7 (commit 0c335a75a789ff44b514e567d458881e15cc283d)

  There have been over 105 commits since the last release.
  There have been 17+ bugs fixed / features added since the last release.

= SystemTap frontend (stap) changes

- Regular expressions may now include non capturing groups, e.g.
  (abc) matches abc and \1 expands to abc. 
  (?:abc) matches abc but does no grouping.

- Validate sprintf precision parameter.  Check for case where a
  precision=-1 sentinel value got interpreted as UINT_MAX.

- The -d option is now implied for -c/-x.  The symbol and unwind
  information for processes specified with -c/-x is now included.

- Avoid a dtrace race condition when generating the same file.  This can
  occur when different targets happen to map to the same file.

= SystemTap backend changes

- Set default per-cpu buffer size (stap -s) to 16MB and repair -b bulk-mode
  operation and performance.
    
- Fix runtime VMA-tracking timing to give symbol info to early-process probes.

- Improve synchronization when multiple stap modules are being loaded.

- Add the --sign-module option to enable users to mok sign their own modules
  e.g.  stap --sign-module -e 'SCRIPT'
  will sign the module, assuming there is a common systemtap mok key.

- Add stap-profile-annotate tool, which combines systemtap and
  debuginfod to annotate source code with system-wide profiling statistics.

- Continue probing without doing liveness analysis for situations
  where liveness analysis does not succeed.

= SystemTap tapset changes

- Add probes for python function entry and python function return.

- Attempt userspace string access if kernel access fails for some $variables$.

- Support the memfd_secret and faccessat2 syscalls and update support for
  the sched_getattr, setns, sigpending, vmsplice, adjtimex syscalls.

- Correct nfs-related tapsets for more context variable accesses.

= SystemTap sample scripts

- All 180+ examples can be found at https://sourceware.org/systemtap/examples/

- New sample scripts:

  security-band-aids/cve-2021-4034.stp
  security-band-aids/cve-2021-4155.stp
  Historical emergency security band-aid scripts for example purposes only

= Examples of tested kernel versions

  2.6.32 (RHEL6 x86_64, i686)
  3.10.0 (RHEL7 x86_64)
  4.15.0 (Ubuntu 18.04 x86_64)
  4.18.0 (RHEL8 x86_64, aarch64, ppc64le, s390x)
  5.14.0 (CentOS Stream release 9 x86_64 / aarch64 / ppc64le)
  5.14.16 (Fedora 34 x86_64)
  5.16.14 (Fedora 35 x86_64)
  5.17.3 (Fedora 36 x86_64)
  5.18-rc (Fedora rawhide x86_64)

= Known issues with this release

- There are intermittent buffer transmission failures for high-trace-rate
  scripts.  Bulk mode (stap -b) helps. (PR29108)

- There are known issues on kernel 5.10+ after adapting to set_fs()
  removal, with some memory accesses that previously returned valid data
  instead returning -EFAULT (see PR26811).

= Contributors for this release

Sultan Alsawaf, *Marco Benatto, Martin Cermak, Di Chen, William Cohen, Stan Cox,
Frank Ch. Eigler, *Dann Frazier, Serhei Makarov, Aaron Merey, *Noah Sanci, 
*Jonathan Wakely

Special thanks to new contributors, marked with '*' above.

Thanks to Stan Cox for assembling these notes.

= Bugs fixed for this release <https://sourceware.org/PR#####>

26184 fullpath_struct_file does not handle struct dentry on 5.6.19-300.fc32.x86_64
28394 Systemtap 4.6 on Centos 8.4/4.18 kernel died in nfsd-trace example         
28418 Add support for new syscall memfd_secret
28557 unable to probe function in kernel module (xfs:xfs_ilock &others?)         
28633 examples/io/iostat-scsi.stp needs porting for kernel 5.16.0-0.rc2         
28634 ioscheduler.stp broken with new kernel 5.16.0-0.rc2
28767 Unable to run script on Ubuntu 20.04
28778 printf() generated code causes GCC errors
28781 make -c/-x imply -d
28788 consider low-security stap-server-less secureboot mode 
28790 Replace deprecated C++98 constructs with lambdas
28804 reduce default buffer sizes on small memory machines
28830 GCC 12 warnings
28923 dtrace predictable temp file causes race
28974 runtime event misordering between vma tracker and probe triggering         
29076 user_string_quoted() doesn't properly generate strings in .rodata on x86_64 
28958 Current git + RHEL (4.18.0) has 3 working NFSd examples, and one broken. 
29028 Linux 5.18.0 kernels changed struct kretprobe_instance member fields
29094 rpm_finder.cxx build broken by rpm-4.18.0-0.alpha1 moving rpmFreeCrypto

