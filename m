Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E3847895D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhLQLAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:00:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36406 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbhLQLAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:00:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F09F21112;
        Fri, 17 Dec 2021 11:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639738836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8jtGkkeifhcn5Pwgza9+c5s/LeDEW5/G8c411nJS58=;
        b=OJnOAhqjFqPEnNsAGR/FxTrf3DFD70DesFTyWdE5pO7UVRUPhjf7blqxpBZQGQkKKHKmxo
        ZoIMqWsAuJV7bMi2My67Qhx+CsKOkcgpOhBuNshiQrZa9QLeL4qIaIbD8Be8QcRVcEEjJf
        +ub1N172CJ7zosXd77d5SZKpmjLEL3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639738836;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8jtGkkeifhcn5Pwgza9+c5s/LeDEW5/G8c411nJS58=;
        b=WmTXz8gKVSiGdpvlfJ254SviGWN7UmGQhpO+Zo4fKPsQRvGiUZccqVbMBroyn5787QVe2x
        SnTy4H4VLU0oTvDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F07413DC1;
        Fri, 17 Dec 2021 11:00:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wW3WBdRtvGFCPQAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 17 Dec 2021 11:00:36 +0000
Date:   Fri, 17 Dec 2021 12:00:34 +0100
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
Message-ID: <Ybxt0g+U11hZhbSh@suse.de>
References: <20211213042215.3096-1-jiangshanlai@gmail.com>
 <20211213042215.3096-4-jiangshanlai@gmail.com>
 <YbkR36Vpb1h5SlMZ@zn.tnic>
 <YbxhBQg99YCTrYN3@suse.de>
 <Ybxmsn1wp8NZjXaD@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ybxmsn1wp8NZjXaD@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 11:30:10AM +0100, Borislav Petkov wrote:
> I audited the handful instructions in there and didn't find anything
> that would cause a #VC...

If the hypervisor decides to mess with the code-page for this path
while a CPU is executing it. This will cause a #VC on that CPU and that
could hit in the syscall return path.

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany
 
(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev

