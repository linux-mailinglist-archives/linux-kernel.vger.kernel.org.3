Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6869D5859A3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiG3JdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiG3JdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:33:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8463E773
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:33:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 12FF820898;
        Sat, 30 Jul 2022 09:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659173584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Lb9yZCabxMhizNdALgYsCx1Z50UiodZ1L7bHVlBBoM=;
        b=t9yFOOEf3uz5UIrvNQthegCtPzKTUFZJBiHeDDX/N2pXIg16z9UjJstoBm2QgT9mtQEQRs
        AnWsAkBsWNst/Vv+3NJr9LUa8a2SVefZr9VUVVA1T5B660FvJROGXtb7AVxtHPY1xuNLt+
        2U/Kx6oBFNgRkNurAaXu7nBRl4ZylBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659173584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Lb9yZCabxMhizNdALgYsCx1Z50UiodZ1L7bHVlBBoM=;
        b=AmhbWKgJVB8lpmYEVEBaSvf/XMLxj8tino+7plHi6Z7uD6NqmziMoDkiB8N9dOWJK81+oz
        8w/njsH7cc5aupAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E45F91331F;
        Sat, 30 Jul 2022 09:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FFP2Nc/65GKALwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Sat, 30 Jul 2022 09:33:03 +0000
Date:   Sat, 30 Jul 2022 11:33:02 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] firmware: dmi: Don't take garbage into
 consideration in dmi_smbios3_present()
Message-ID: <20220730113302.6215923d@endymion.delvare>
In-Reply-To: <YuQljCM4LZXhSkbh@smile.fi.intel.com>
References: <20220726094329.1725-1-andriy.shevchenko@linux.intel.com>
        <20220727102504.6bbefcf9@endymion.delvare>
        <YuQljCM4LZXhSkbh@smile.fi.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, 29 Jul 2022 21:23:08 +0300, Andy Shevchenko wrote:
> On Wed, Jul 27, 2022 at 10:25:04AM +0200, Jean Delvare wrote:
> > On Tue, 26 Jul 2022 12:43:29 +0300, Andy Shevchenko wrote:  
> > > The byte at offset 6 represent length. Don't take it and drop it immediately
> > > by using proper accessor, i.e. get_unaligned_be24().  
> > 
> > The subject sounds like you are fixing a bug, while this is only, at
> > best, a minor optimization.  
> 
> I don't know how to improve it, but it kinda a bug in a logic for non-prepared
> reader, esp. as specification suggests different thing about version offset.

I didn't consider that. Having code match the documentation is indeed
valuable.

> > > -		dmi_ver = get_unaligned_be32(buf + 6) & 0xFFFFFF;
> > > +		dmi_ver = get_unaligned_be24(buf + 7);  
> 
> > I admit I did not know about get_unaligned_be24(). While I agree that
> > it makes the source code look better, one downside is that it actually
> > increases the binary size on x86_64. The reason is that
> > get_unaligned_be32() is optimized by assembly instruction bswapl, while
> > get_unaligned_be24() is not. Situation appears to be the same on ia64
> > and arm. Only arm64 would apparently benefit from your proposed
> > change.  
> 
> Good to know!
> But here it's not a hot path, right?

True.

> > I'm not too sure what is preferred in such situations.
> 
> For cold paths I think the correctness prevail the performance.

You have a point.

> Alternatively we might add a comment in the code explaining the trick,
> although I won't like to do it.
> 
> Another way is to have a subset of 24-/48-bit unaligned accessors that
> use the trick specifically for hot paths with a caveat that they may
> access data out of the 24-/48-bit boundaries.

I considered that, but that's too hackish for me and could easily cause
confusion leading to improper use. Not worth it. Let's keep things
simple and understandable.

So I'll apply your patch, thanks for contributing it.

-- 
Jean Delvare
SUSE L3 Support
