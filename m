Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80A44D94A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244476AbiCOGdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbiCOGcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:32:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B704A3F6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 23:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647325899; x=1678861899;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=T43rbjuUfmYFNJl+eyDeXU+oKMJm8uoX+WBhgwCcupw=;
  b=HA7joJSIGiqKtH485mZtcmX0K7oeEGx1mAMFr1mE9PVwim9BZn7wwVBu
   78jAX9VTwsbk8hvmShOE3r5Uc/sAXR9rxya8GyAEnm6XpTl8HTM++oNXE
   J4Fq2GsqOcgVIvyV+J47qQ/mTWkCHfgo1Dc1B7Z+ooAuVLoMOrgIAAWjw
   EVUtpTMU5A24U/l0dn17QTPWY17DBLEt+rDFRNkD8HdqRFy7/Od34/wGe
   rIXxpaS5hRxCHBWqk2JTYfSsafx+bC811jN2L1fXXu62tFe8z1jRVuzPr
   8Kr+9CZeynOH9wEgYFt7zAtoi7AyMfRpYblK9eXAwuWvJ76nh+KDfIdK7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243676853"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="243676853"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 23:31:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="515743481"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 23:31:36 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Only re-generate demotion targets when a numa
 node changes its N_CPU state
References: <20220310120749.23077-1-osalvador@suse.de>
        <87mthxb514.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YisK2PEkKAqtZPfp@localhost.localdomain>
        <87czip73b4.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Yi9bhXSADpNt6WEC@localhost.localdomain>
        <6b63d2ad-9b21-3fd6-37b4-31d7ad804c30@intel.com>
        <YjAukR2aPkZ0z7Z9@localhost.localdomain>
Date:   Tue, 15 Mar 2022 14:31:34 +0800
In-Reply-To: <YjAukR2aPkZ0z7Z9@localhost.localdomain> (Oscar Salvador's
        message of "Tue, 15 Mar 2022 07:13:37 +0100")
Message-ID: <87tubz3ewp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> On Mon, Mar 14, 2022 at 08:20:57AM -0700, Dave Hansen wrote:
>> Qemu, for instance, has a "mem-path" argument.  It's typically used for
>> using hugetlbfs as guest memory.  But, there's nothing stopping you from
>> pointing it to a DAX device or a file on a DAX filesystem that's backed
>> by pmem.
>
> Thanks Dave.
>
> But that is somehow different, is not it?
> When you use pmem backed memory as a RAM for the guest, the guest is not
> seeing that as PMEM, but just as a normal RAM, right?
> IOW, the guest cannot use that memory for demotion, as we can use it in
> the host when configured.
>
> I might be missing something, I am using this qemu cmdline:
>
>         $QEMU -enable-kvm -machine pc -smp 4 -cpu host -monitor pty -m 5G \
> 	-object memory-backend-file,id=pc.ram,size=5G,mem-path=/mnt/pmem,share=off -machine memory-backend=pc.ram \
> 	$IMAGE -boot c -vnc :0 
>
> (/mnt/pmem was mounted with "mount -o dax /dev/pmem1 /mnt/pmem/")
>
> My point is, if it is really true that the guest cannot use that memory for
> demotion, then we would still need CONFIG_MEMORY_HOTPLUG, as that is the
> only way to expose PMEM to any system to be used as a demotion option
> (via add_memory_driver_managed() through kmem driver).
>
> Or am I missing some qemu magic to use that memory as demotion in the
> guest as well?

You need to put PMEM to a NUMA node to use demotion, as follows,

qemu-system-x86_64 --enable-kvm \
-M pc,accel=kvm,nvdimm=on -smp 8 -m 160G,slots=18,maxmem=703G \
-object memory-backend-ram,id=mem0,size=32G \
-object memory-backend-file,id=mem1,share=on,mem-path=/dev/dax0.0,size=128G,align=2M \
-numa node,memdev=mem0,cpus=0-7,nodeid=0 \
-numa node,memdev=mem1,nodeid=1 \
$IMAGE

Best Regards,
Huang, Ying
