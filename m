Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8A8466B7C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377016AbhLBVVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:21:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37962 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377002AbhLBVUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:20:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 20D7C1FD39;
        Thu,  2 Dec 2021 21:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638479849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0WkjIG0mIUYzeQg4wlNOKOVUyvoVZ0NiWOA4f1ODqU=;
        b=JEbLfvkrNHU0dV5z9rqcx/v8xL/NB/kW/eXnqKH7abawn3ViArIZWa7wPFRdTLSBEYjxEc
        1v+gkaSKYe0+a6cKXwZ7WPKdXE6VP5PyuiaMZi/mdKfFDw9aIBdfqlaHJOG2YcTA79lX9+
        89Iftx4tMUHG3zlHpn9b/wSni1N9/i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638479849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0WkjIG0mIUYzeQg4wlNOKOVUyvoVZ0NiWOA4f1ODqU=;
        b=jIvPZoLzLTNPWqS/wKUrfAyH06eFhgPwLUJjxuAcXN7DJrmfhGId73yLeijsgysPFfkGuJ
        ngnoK0BJjG9jFhCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A389F13EB4;
        Thu,  2 Dec 2021 21:17:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zH8XJug3qWFNCgAAMHmgww
        (envelope-from <jroedel@suse.de>); Thu, 02 Dec 2021 21:17:28 +0000
Date:   Thu, 2 Dec 2021 22:17:27 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] x86/mm/64: Flush global TLB on boot and AP bringup
Message-ID: <Yak357ZHiz2+DyON@suse.de>
References: <20211001154817.29225-1-joro@8bytes.org>
 <20211001154817.29225-3-joro@8bytes.org>
 <YXfQoO0McyPiOFwz@zn.tnic>
 <YXf7hBEbW0CmwYwz@zn.tnic>
 <YajA/Ux5ydtP5Bi3@suse.de>
 <YakOG4lGTk+qiy9N@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YakOG4lGTk+qiy9N@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 07:19:07PM +0100, Borislav Petkov wrote:
> I'd gladly review a preparatory patchset doing that. The usual strategy
> is, cleanup and refactoring first, new features later.

Is that also true for fixes? Because this patch-set actually tries to
fix an issue present in current code and not adding any new feature.

Thanks,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany
 
(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev

