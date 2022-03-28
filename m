Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218324E9C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241658AbiC1Qar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbiC1Qap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:30:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F882C649;
        Mon, 28 Mar 2022 09:29:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C4AA0210DD;
        Mon, 28 Mar 2022 16:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648484942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S32zs0pa2gEQEVNruGhWyIWEZSFgiNpA/SIR+p8B8Io=;
        b=T7JP2LZxKvC6S64IAXjGt/3rro2IKKDx5Wwwk+5LDKln1XPFyTO9piyvZvPCoOdzIsESP5
        tRzkCVOh1rdNSdartBydlZX3FeFTbK6c4ZPtVwpDEfVRrBcQkSU0Qt4gTWAHskJkBGWd1N
        Jhyrh9fK6tLPCbpDovciiEEeN17G6y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648484942;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S32zs0pa2gEQEVNruGhWyIWEZSFgiNpA/SIR+p8B8Io=;
        b=/9UV5RKOAnikidCt+0qBaYGt+ZUtALDd6HKE5cJm/x6k0se36icsNFK8f1zod5h/Z0tphR
        8NGwZj6tqW5X+iBQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5CCA3A3B89;
        Mon, 28 Mar 2022 16:29:02 +0000 (UTC)
Date:   Mon, 28 Mar 2022 18:29:01 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     joeyli <jlee@suse.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Kairui Song <kasong@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: Re: [PATCH 4/4] module, KEYS: Make use of platform keyring for
 signature verification
Message-ID: <20220328162901.GC163591@kunlun.suse.cz>
References: <cover.1644953683.git.msuchanek@suse.de>
 <840433bc93a58d6dfc4d96c34c0c3b158a0e669d.1644953683.git.msuchanek@suse.de>
 <3e39412657a4b0839bcf38544d591959e89877b8.camel@linux.ibm.com>
 <20220215204730.GQ3113@kunlun.suse.cz>
 <20220328101557.GA11641@linux-l9pv.suse>
 <6A29007F-F1B7-4CDE-B3ED-7BF700B5ED2B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6A29007F-F1B7-4CDE-B3ED-7BF700B5ED2B@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 28, 2022 at 02:44:30PM +0000, Eric Snowberg wrote:
> 
> 
> > On Mar 28, 2022, at 4:15 AM, joeyli <jlee@suse.com> wrote:
> > 
> > Hi Mimi,
> > 
> > Sorry for bother you for this old topic.
> > 
> > On Tue, Feb 15, 2022 at 09:47:30PM +0100, Michal Suchánek wrote:
> >> Hello,
> >> 
> >> On Tue, Feb 15, 2022 at 03:08:18PM -0500, Mimi Zohar wrote:
> >>> [Cc'ing Eric Snowberg]
> >>> 
> >>> Hi Michal,
> >>> 
> >>> On Tue, 2022-02-15 at 20:39 +0100, Michal Suchanek wrote:
> >>>> Commit 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
> >>>> adds support for use of platform keyring in kexec verification but
> >>>> support for modules is missing.
> >>>> 
> >>>> Add support for verification of modules with keys from platform keyring
> >>>> as well.
> >>> 
> >>> Permission for loading the pre-OS keys onto the "platform" keyring and
> >>> using them is limited to verifying the kexec kernel image, nothing
> >>> else.
> >> 
> >> Why is the platform keyring limited to kexec, and nothing else?
> >> 
> >> It should either be used for everything or for nothing. You have the
> >> option to compile it in and then it should be used, and the option to
> >> not compile it in and then it cannot be used.
> >> 
> >> There are two basic use cases:
> >> 
> >> (1) there is a vendor key which is very hard to use so you sign
> >> something small and simple like shim with the vendor key, and sign your
> >> kernel and modules with your own key that's typically enrolled with shim
> >> MOK, and built into the kernel.
> >> 
> >> (2) you import your key into the firmware, and possibly disable the
> >> vendor key. You can load the kernel directly without shim, and then your
> >> signing key is typically in the platform keyring and built into the
> >> kernel.
> >> 
> > 
> > In the second use case, if user can enroll their own key to db either before
> > or after hardware shipping. And they don't need shim because they removed
> > Microsoft or OEM/ODM keys.  Why kernel can not provide a Kconfig option to
> > them for trusting db keys for verifying kernel module, or for IMA (using CA
> > in db)?
> > 
> > In the above use case for distro, partner doesn't need to re-compiler distro
> > kernel. They just need to re-sign distro kernel and modules. Which means
> > that the partner trusted distro. Then the partner's key in db can be used to
> > verify kernel image and also kernel module without shim involve.
> 
> If shim is used, the new machine keyring can be used to solve this problem. 
> This pull request [1] allows additional certificates to be loaded into the MOKList 
> without going through MokManager.  Have the end-user/partner create a 
> shim_certificate.efi containing their key. Then sign it with their DB key.  When 
> shim boots, it will validate shim_certificate.efi against the DB key and load the 
> key contained within it into the MOKList.  Now both module and kernel validation 
> can be performed with this key, since it is contained within the machine keyring.

And why would you go through that when your platform keyring already has
the key and you don't need shim for anything? This sounds a lot like "I
have a hammer and all these look like nails" thinking.

Sure, there is use for the machine keyring in the case you need it and
have it regardless of the kernel making any use of it for anything.
Artifically adding it because the kernel fails to work with the platform
keyring sounds backwards, though.

Thanks

Michal
