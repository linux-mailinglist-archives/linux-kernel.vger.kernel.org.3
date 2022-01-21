Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C024964E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382076AbiAUSSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381873AbiAUSSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:18:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1926C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=qJqfOISO6T+iTDW/zdzr5qhydNTWknW2VivfkJ9v0+E=; b=Tu6isNws4GCX25N3emOB/9+wpp
        6605E4FcMUiCdqO+kQNnAi+mpKRDXRXbDjOzdCV/K1Pg1YyYLYvxl7VsoO+t0X0wVHR0iElqah5NA
        JmGQnn4rwnjk1H9CMSrb/wmFGWpLhCyl+y4LOIc1JudT/Rrno6n+1gj1eBqM06G2560nZjHX5mj3w
        hx24JH/YIzpwsOapyTk45EhYuqxqooo4LwKaVM/pqsIZHKkgAdDMtm8iq3pW1lWrvVCi4RRuR3DB8
        5xzelTmkiNdKFh/pOyJXaUqhFcD9TCh06bbXXTP9UafBqd9XF/8KrL1YVGeUCw4Fw06oM1J3UJ9y1
        VS4EGP3A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAyU2-002cnK-Ri; Fri, 21 Jan 2022 18:17:59 +0000
Message-ID: <2e7a440f-b942-2794-6c15-66baf81801ae@infradead.org>
Date:   Fri, 21 Jan 2022 10:17:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Issue With Kernel Changes To Core Dump Collection (Kernel
 Bug...?)
Content-Language: en-US
To:     Bill Messmer <wmessmer@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
References: <SJ0PR21MB13117BB925ABFD8857CAA5B5C45B9@SJ0PR21MB1311.namprd21.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <SJ0PR21MB13117BB925ABFD8857CAA5B5C45B9@SJ0PR21MB1311.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add the patch author, Jann]


On 1/20/22 17:31, Bill Messmer wrote:
> Hello,
> 
> It has been my understanding for some time that the kernel config option CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS (and the corresponding bit 4 of the coredump filter) was, at one point, added for the purpose of ensuring that the GNU build-id of ELF objects was included in core dumps.  The config description in Kconfig.binfmt even alludes to this in its description.
> 
> I am trying to understand why in the 5.10+ kernels, there was a change in the kernel that, instead of checking whether a given memory mapping had an ELF header in order to determine whether to include the page to checking whether the inode is executable.  The change in question:
> 
> 	github.com/torvalds/linux/commit/429a22e776a2b9f85a2b9c53d8e647598b553dd1
> 

Bill,
You should send email(s) to the relevant people if you can identify them.
LKML is a huge pipe (hose) and people don't normally browse it.  :)


> In many distributions (e.g.: Ubuntu), the shared objects in /usr/lib and elsewhere are not marked as executable.  One of the net effects here is that the first page of shared objects on these distributions are no longer captured in core dumps.
> 
> A core dump taken on Ubuntu 21.10 (with the 5.13 kernel) will, by default, not include these pages:
> 
>   LOAD           0x0000000000007000 0x00007f375855f000 0x0000000000000000
>                  0x0000000000000000 0x000000000002c000  R      0x1000
> 
>    0x00007f375855f000  0x00007f375858b000  0x0000000000000000
>         /usr/lib/x86_64-linux-gnu/libc.so.6
> 
> Doing a quick "sudo chmod +x /usr/lib/x86_64-linux-gnu/libc.so.6" and repeating shows that it is:
> 
>   LOAD           0x0000000000007000 0x00007fefd5282000 0x0000000000000000
>                  0x0000000000001000 0x000000000002c000  R      0x1000
> 
>     0x00007fefd5282000  0x00007fefd52ae000  0x0000000000000000
>         /usr/lib/x86_64-linux-gnu/libc.so.6
> 
> Prior to running with 5.10+ kernels, I was always seeing the first page of shared objects (and the contained build-id) within core dumps (assuming the proper kernel config and core dump filter bits).  Not any longer.
> 
> The reason I ask this is that, as more teams here at Microsoft have products running on Linux (or in Linux containers), we have been pushing the crash reports for those up through the same post-mortem crash analysis infrastructure that we do for Windows.  That means that what has traditionally been the Windows debugger (e.g.: WinDbg) has, for some time, been able to open, debug, and analyze various Linux post-mortem crash formats.  Part of doing this on a post-mortem basis requires finding the original images and debug information for the executables and shared objects referenced in those core dumps.  Whether we do that via our own symbol servers or via a debuginfod service -- the post-mortem debugger needs access to the build-ids of those objects.
> 
> Until recently, finding these from a core dump has been stable and working quite well.  Of late, however, we have been seeing a number of crash reports (e.g.: from Debian or Ubuntu containers) where we can no longer find images & symbols based on the core dumps because this kernel change has caused the first page of shared object files to not be captured in core dumps.  I don't know how many post-mortem Linux crash analysis solutions this is affecting...  
> 
> Was the change here really the intent...?  or is this a kernel bug?
> 
> Sincerely,
> 
> Bill Messmer
> wmessmer@microsoft.com

-- 
~Randy
