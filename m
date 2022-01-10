Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6339489F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbiAJSgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:36:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60412 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243677AbiAJSfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:35:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54C831F37B;
        Mon, 10 Jan 2022 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641839738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooAnzGomoG63yl/jXgVsStP5Zm/sLy34cn8YPg9NdrE=;
        b=0zjRw24mO2XdrJ/P9/aEEKgs99cI5zNtw1jS+4JymhvlG7ZnAEIsDO1JA68p2w9LUpsIu+
        AM8VJP0dv5T/Pfy3cteQ9V2TJR3hUO+9yXdGnrvyLAtMBzDfxqP8EhOCcoeGqGzA4G1r9V
        7HdgcsW0jWbMTNZf8d9BTaeABXDo+NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641839738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooAnzGomoG63yl/jXgVsStP5Zm/sLy34cn8YPg9NdrE=;
        b=1yf0XLyziuZKmbpQDbJ/guxaV7AA7N6mdD/5vFq5sK0uP4ZOIhZGKsJopSBrV6esD395C+
        bIIQZ33IcWCojmAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BC6513B26;
        Mon, 10 Jan 2022 18:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JFspDnp83GFRYQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 18:35:38 +0000
Date:   Mon, 10 Jan 2022 19:35:41 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [GIT PULL] x86/cpu for v5.17
Message-ID: <Ydx8fUCotPI++UEW@zn.tnic>
References: <YdwVl0H54fmUIux0@zn.tnic>
 <CAHk-=wh+UbGrgH4CzKSoTYGPidyv5isiLMxJKAqnV3NFTiRdaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh+UbGrgH4CzKSoTYGPidyv5isiLMxJKAqnV3NFTiRdaQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCing the folks who were involved in this one...

On Mon, Jan 10, 2022 at 10:18:06AM -0800, Linus Torvalds wrote:
> On Mon, Jan 10, 2022 at 3:16 AM Borislav Petkov <bp@suse.de> wrote:
> >
> > - Avoid writing MSR_CSTAR on Intel due to TDX guests raising a #VE trap
> 
> This is all fine, but my reaction to this is that I would have
> expected it to be either a wrmsrl_safe(), or using an actual CPU
> feature check.
> 
> Checking for a particular vendor seems a bit hacky. We generally try
> to avoid things like that, don't we?
> 
> Not a big deal, I just thought I'd mention it since I reacted to it.
> And we don't seem to have those vendor checks in any of the other code
> that uses MSR_CSTAR (just grepping for that and seeing it mentioned in
> kvm code etc)

Right, the only point for doing the vendor check I see here is, well,
because it is Intel who doesn't have CSTAR, let's check for Intel. But
yeah, we do avoid the vendor checks if it can be helped.

We can do a synthetic X86_FEATURE flag but that would be a waste. So the
_safe thing and keep the comment sounds optimal to me.

I can whip up a patch ontop if people agree.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
