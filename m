Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727ED478859
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhLQKGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:06:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33306 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbhLQKGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:06:00 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9DF111F38A;
        Fri, 17 Dec 2021 10:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639735559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v8YgkHaAmVqXtCcb0n9WniYbynLnHwe9xmhLh6/MX/o=;
        b=ZOYQJkQDRq3usUkyeuSmjOxlNmcyjWAh/GAiEg4b23EkbBp/mJy0Fg7y4GDnY9ZSKAn4zS
        NWwomILkgFvABJBQIN0da4HwDQYsLQtayyNWsZj5LHgVcIvxoJ+VkKXDli2erM8PUfsCue
        vMQD+t5LbcfevXWEW3fH4i/icofXJTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639735559;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v8YgkHaAmVqXtCcb0n9WniYbynLnHwe9xmhLh6/MX/o=;
        b=LL4VYDwQFBS+qDBOmUYWoIHSGzfu2GoRS9Hrl+4/zt9K882/Povl6qlNzR4RInKDqDnOOX
        H165O9NfT8x7UCCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D58B13BF8;
        Fri, 17 Dec 2021 10:05:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zkEaBQdhvGEjIgAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 17 Dec 2021 10:05:59 +0000
Date:   Fri, 17 Dec 2021 11:05:57 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: The code for returning to user space is
 also in syscall gap
Message-ID: <YbxhBQg99YCTrYN3@suse.de>
References: <20211213042215.3096-1-jiangshanlai@gmail.com>
 <20211213042215.3096-4-jiangshanlai@gmail.com>
 <YbkR36Vpb1h5SlMZ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbkR36Vpb1h5SlMZ@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 10:51:27PM +0100, Borislav Petkov wrote:
> I'd expect to see here some text analyzing the couple of instructions
> between those new labels you've added and whether a #VC can happen
> there.

While it is true that the exit path can't trigger #VC right now, it will
be able with SNP.

So this change makes sense, either now or as part of the SNP-guest
patch-set.

Regards,

	Joerg
