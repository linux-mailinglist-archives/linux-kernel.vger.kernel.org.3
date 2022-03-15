Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA94D9471
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244506AbiCOGOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiCOGOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:14:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92973A71E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 23:13:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 531CF210DD;
        Tue, 15 Mar 2022 06:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647324819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7OQUAsHYpuDcIcBxp2yn2HNjgjPTj9XE8xl4qxKMMAE=;
        b=eJHxa5DoERKoyDiKJ4QLQ9YlntA68Gvp6LAseIWjJyldLZ5rwrql0zS3U9Aq8ER3wYGkyP
        9RZrwFRfAZBc4z2YpD0Lq+12y+8IKqtVoE/ibRVdvEuEmyi606Xy9u285TQogE47BDwb4w
        /ibO9TUyY2M4dS5XeOm2Pakvhr3/gnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647324819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7OQUAsHYpuDcIcBxp2yn2HNjgjPTj9XE8xl4qxKMMAE=;
        b=K6tOVG8A1GNRGorh2XeFUnwOCwRCurUNZ0/tKSqc1uyep3PuPKr5GrgxF1XO/dCU17xAP7
        C7RhP90wr3PgBFBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFCAE13B4E;
        Tue, 15 Mar 2022 06:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O/0pK5IuMGKMMwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 15 Mar 2022 06:13:38 +0000
Date:   Tue, 15 Mar 2022 07:13:37 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Only re-generate demotion targets when a numa
 node changes its N_CPU state
Message-ID: <YjAukR2aPkZ0z7Z9@localhost.localdomain>
References: <20220310120749.23077-1-osalvador@suse.de>
 <87mthxb514.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YisK2PEkKAqtZPfp@localhost.localdomain>
 <87czip73b4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Yi9bhXSADpNt6WEC@localhost.localdomain>
 <6b63d2ad-9b21-3fd6-37b4-31d7ad804c30@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b63d2ad-9b21-3fd6-37b4-31d7ad804c30@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 08:20:57AM -0700, Dave Hansen wrote:
> Qemu, for instance, has a "mem-path" argument.  It's typically used for
> using hugetlbfs as guest memory.  But, there's nothing stopping you from
> pointing it to a DAX device or a file on a DAX filesystem that's backed
> by pmem.

Thanks Dave.

But that is somehow different, is not it?
When you use pmem backed memory as a RAM for the guest, the guest is not
seeing that as PMEM, but just as a normal RAM, right?
IOW, the guest cannot use that memory for demotion, as we can use it in
the host when configured.

I might be missing something, I am using this qemu cmdline:

        $QEMU -enable-kvm -machine pc -smp 4 -cpu host -monitor pty -m 5G \
	-object memory-backend-file,id=pc.ram,size=5G,mem-path=/mnt/pmem,share=off -machine memory-backend=pc.ram \
	$IMAGE -boot c -vnc :0 

(/mnt/pmem was mounted with "mount -o dax /dev/pmem1 /mnt/pmem/")

My point is, if it is really true that the guest cannot use that memory for
demotion, then we would still need CONFIG_MEMORY_HOTPLUG, as that is the
only way to expose PMEM to any system to be used as a demotion option
(via add_memory_driver_managed() through kmem driver).

Or am I missing some qemu magic to use that memory as demotion in the
guest as well?


-- 
Oscar Salvador
SUSE Labs
