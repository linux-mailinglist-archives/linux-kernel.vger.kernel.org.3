Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5944A3D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 07:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiAaGXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 01:23:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35030 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiAaGXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 01:23:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 622DD21116;
        Mon, 31 Jan 2022 06:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643610186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=glFJZo9ETm7z/ROJWLizrW+pr8HZoGe/q8WkURW8RkQ=;
        b=w8KMAEvyM5acD//MgH4CajE1JEJz8SxcqA0XTBpjOLdP3Y3DfOPgmknPgt6vMEQSu2UxKr
        u3k9g5AC6FK3rteUS6oQ2W4X6pdLAj2nmcydWV74bIC4MaopLhoOsqvmK/IQCZkgUjj+nU
        t+q5jmvCPZIh0ma+eKW6RgMXyvuYuxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643610186;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=glFJZo9ETm7z/ROJWLizrW+pr8HZoGe/q8WkURW8RkQ=;
        b=TDQphaJNby4XljQkkKeL0ahZQdHJQgHaQp8Z41WoJRUMdR2cjZ5r7SYEkGg5JZegoMuWcn
        bVZwx8tB3cZ/YtBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E00713A89;
        Mon, 31 Jan 2022 06:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kb0eD0iA92GYMAAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 31 Jan 2022 06:23:04 +0000
Date:   Mon, 31 Jan 2022 07:23:02 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH RFC v1] drivers/base/node: consolidate node device
 subsystem initialization in node_dev_init()
Message-ID: <YfeARpenqPii1WQH@localhost.localdomain>
References: <20220128151540.164759-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128151540.164759-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 04:15:40PM +0100, David Hildenbrand wrote:
> ... and call node_dev_init() after memory_dev_init() from driver_init(),
> so before any of the existing arch/subsys calls. All online nodes should
> be known at that point.
> 
> This is in line with memory_dev_init(), which initializes the memory
> device subsystem and creates all memory block devices.
> 
> Similar to memory_dev_init(), panic() if anything goes wrong, we don't
> want to continue with such basic initialization errors.
> 
> The important part is that node_dev_init() gets called after
> memory_dev_init() and after cpu_dev_init(), but before any of the
> relevant archs call register_cpu() to register the new cpu device under
> the node device. The latter should be the case for the current users
> of topology_init().

So, before this change we had something like this:

do_basic_setup
 driver_init
  memory_dev_init
 do_init_calls
  ...
   topology_init
    register_nodes/register_one_node

And after the patch all happens in driver_init()

driver_init
 memory_dev_init
 node_dev_init

I guess this is fine as we do not have any ordering problems (aka: none
of the functions we used to call before expect the nodes not to be
there for some weird reason).

So, no functional change, right?

This certainly looks like an improvment. 

-- 
Oscar Salvador
SUSE Labs
