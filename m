Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DB54E98E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243587AbiC1OFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiC1OE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:04:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F63D5EDE7;
        Mon, 28 Mar 2022 07:03:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EEAE51F37E;
        Mon, 28 Mar 2022 14:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648476194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mKaj769f6o7BeoQ24YhxAdfu6PG3zqKO0SxHdXcFt8=;
        b=CxlTxY/4QuwxdlwiSBSebYg2ffvjtZuWZJBb4D9zmxdkwtUEdlW8J3VxMITKwBWsigpRMj
        pAdKTsV7/7ETFJrav28Hq4h6EXFYWZA8p7q50hiGTOBMJT+axsmIplUMIs+SBOGCy6i4AW
        0dd9pKwCt1r5lcbUdd+UoZE/OyHIb6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648476194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mKaj769f6o7BeoQ24YhxAdfu6PG3zqKO0SxHdXcFt8=;
        b=bOjuzxjO/aBFTxAUkQvWrSHyXlWACDUicg1XK6iFj5JKFr9qzLq7MZ3TLtGjroogmRq/Y+
        FdcgYGpJv7FooABA==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7ED6CA3BE5;
        Mon, 28 Mar 2022 14:03:14 +0000 (UTC)
Date:   Mon, 28 Mar 2022 16:03:13 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     joeyli <jlee@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-modules@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Eric Snowberg <eric.snowberg@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 4/4] module, KEYS: Make use of platform keyring for
 signature verification
Message-ID: <20220328140313.GZ163591@kunlun.suse.cz>
References: <cover.1644953683.git.msuchanek@suse.de>
 <840433bc93a58d6dfc4d96c34c0c3b158a0e669d.1644953683.git.msuchanek@suse.de>
 <3e39412657a4b0839bcf38544d591959e89877b8.camel@linux.ibm.com>
 <20220215204730.GQ3113@kunlun.suse.cz>
 <20220328101557.GA11641@linux-l9pv.suse>
 <7265798627defd6111af4e3a863b8525b07c511d.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7265798627defd6111af4e3a863b8525b07c511d.camel@linux.ibm.com>
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

On Mon, Mar 28, 2022 at 09:28:14AM -0400, Mimi Zohar wrote:
> On Mon, 2022-03-28 at 18:15 +0800, joeyli wrote:
> 
> Hi Joey,
> 
> > Hi Mimi,
> > 
> > Sorry for bother you for this old topic.
> 
> Cc'ing Luis the kernel modules maintainer.
> 
> > 
> > On Tue, Feb 15, 2022 at 09:47:30PM +0100, Michal Suchánek wrote:
> > > Hello,
> > > 
> > > On Tue, Feb 15, 2022 at 03:08:18PM -0500, Mimi Zohar wrote:
> > > > [Cc'ing Eric Snowberg]
> > > > 
> > > > Hi Michal,
> > > > 
> > > > On Tue, 2022-02-15 at 20:39 +0100, Michal Suchanek wrote:
> > > > > Commit 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
> > > > > adds support for use of platform keyring in kexec verification but
> > > > > support for modules is missing.
> > > > > 
> > > > > Add support for verification of modules with keys from platform keyring
> > > > > as well.
> > > > 
> > > > Permission for loading the pre-OS keys onto the "platform" keyring and
> > > > using them is limited to verifying the kexec kernel image, nothing
> > > > else.
> > > 
> > > Why is the platform keyring limited to kexec, and nothing else?
> > > 
> > > It should either be used for everything or for nothing. You have the
> > > option to compile it in and then it should be used, and the option to
> > > not compile it in and then it cannot be used.
> > > 
> > > There are two basic use cases:
> > > 
> > > (1) there is a vendor key which is very hard to use so you sign
> > > something small and simple like shim with the vendor key, and sign your
> > > kernel and modules with your own key that's typically enrolled with shim
> > > MOK, and built into the kernel.
> > > 
> > > (2) you import your key into the firmware, and possibly disable the
> > > vendor key. You can load the kernel directly without shim, and then your
> > > signing key is typically in the platform keyring and built into the
> > > kernel.
> > >
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
> From what I understand, distros don't want customers resigning their
> kernels.  If they did, then they could have enabled the
> CONFIG_SYSTEM_EXTRA_CERTIFICATE, which would load the keys onto the
> "builtin" keyring, and anything signed by those keys could be loaded
> onto the secondary keyring.  (Of course CONFIG_SYSTEM_EXTRA_CERTIFICATE
> would need to be fixed/updated.)

You don't need to re-sign. You can just import the distro key into the
firmware.

> 
> We've gone through "what if" scenarios before.  My response then, as
> now, is post it as a patch with the real motivation for such a change.

Then that's what this does. Both modules and kernel run on ring0 so
there is no practical distinction. For consistency verify both with the
same keys.

Either way if there should be a disctinction it should be explicit, not
implicit.

That is each option that imports keys should crate a basic keyring that
just has keys, and we should have 'kexec' and 'module' keyrings that
do not have keys, only link the keyrings that import keys from some
specific source. All of them by default but you can adjust this in
defconfigs depending on platform-typical usage.

Contrast to that the current 'secondary' keyring that randomly links
some key sources and not others, is used in some kexec implementations
and not others. Also if you list the keys in it do you get the keys
dynamically added at runtime, or also all the keys on the linked
keyrings? Whatever you get is misleading and unclear.

Thanks

Michal
