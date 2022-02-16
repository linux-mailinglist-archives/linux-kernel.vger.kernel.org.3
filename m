Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300614B8647
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiBPK5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:57:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiBPK5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:57:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B19659E;
        Wed, 16 Feb 2022 02:56:48 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 87FBA1F394;
        Wed, 16 Feb 2022 10:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645009007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czkTwuPVNY+CGK+iaNWgAo7tiJWsOUPbMC8dAAd2acc=;
        b=J3Y97nwkpCZ7yBjFC/lwyP8P7M39QAd1xriK7UqEWU1S4SAFOX5hHDTKY6IppSIb7v5pLE
        YtYkKR7imTavHOTWbDb3xYh6hHquisyVI9D9jWX1PrfmGfAfIFPdBQDWqLFXQi5uUUSWB1
        DvuPKc5K1aRC0+f/HCsc4auYBCVHABA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645009007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czkTwuPVNY+CGK+iaNWgAo7tiJWsOUPbMC8dAAd2acc=;
        b=XoXSVg9x0SbI71JVqNQjmgQuHmwkjv1Dt86matdSZvHZIoNH6UqIwN7/vkuQn6Aen4DpRr
        pd4rSLFRsHDSFxAA==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0BC1BA3B88;
        Wed, 16 Feb 2022 10:56:47 +0000 (UTC)
Date:   Wed, 16 Feb 2022 11:56:45 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        stable@kernel.org, Eric Snowberg <eric.snowberg@oracle.com>
Subject: Re: [PATCH 4/4] module, KEYS: Make use of platform keyring for
 signature verification
Message-ID: <20220216105645.GS3113@kunlun.suse.cz>
References: <cover.1644953683.git.msuchanek@suse.de>
 <840433bc93a58d6dfc4d96c34c0c3b158a0e669d.1644953683.git.msuchanek@suse.de>
 <3e39412657a4b0839bcf38544d591959e89877b8.camel@linux.ibm.com>
 <20220215204730.GQ3113@kunlun.suse.cz>
 <c3f6f6c8a9db34cc1cdc1000f9272c2b36445e15.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3f6f6c8a9db34cc1cdc1000f9272c2b36445e15.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 05:12:32PM -0500, Mimi Zohar wrote:
> On Tue, 2022-02-15 at 21:47 +0100, Michal Suchánek wrote:
> > Hello,
> > 
> > On Tue, Feb 15, 2022 at 03:08:18PM -0500, Mimi Zohar wrote:
> > > [Cc'ing Eric Snowberg]
> > > 
> > > Hi Michal,
> > > 
> > > On Tue, 2022-02-15 at 20:39 +0100, Michal Suchanek wrote:
> > > > Commit 278311e417be ("kexec, KEYS: Make use of platform keyring for signature verify")
> > > > adds support for use of platform keyring in kexec verification but
> > > > support for modules is missing.
> > > > 
> > > > Add support for verification of modules with keys from platform keyring
> > > > as well.
> > > 
> > > Permission for loading the pre-OS keys onto the "platform" keyring and
> > > using them is limited to verifying the kexec kernel image, nothing
> > > else.
> > 
> > Why is the platform keyring limited to kexec, and nothing else?
> > 
> > It should either be used for everything or for nothing. You have the
> > option to compile it in and then it should be used, and the option to
> > not compile it in and then it cannot be used.
> > 
> > There are two basic use cases:
> > 
> > (1) there is a vendor key which is very hard to use so you sign
> > something small and simple like shim with the vendor key, and sign your
> > kernel and modules with your own key that's typically enrolled with shim
> > MOK, and built into the kernel.
> > 
> > (2) you import your key into the firmware, and possibly disable the
> > vendor key. You can load the kernel directly without shim, and then your
> > signing key is typically in the platform keyring and built into the
> > kernel.
> > 
> > In neither case do I see any reason to use some keyrings for kexec and
> > other keyrings for modules.
> 
> When building your own kernel there isn't a problem.  Additional keys
> may be built into the kernel image, which are loaded onto the
> ".builtin_trusted_keys" keyring, and may be stored in MOK.  Normally
> different keys are used for signing the kernel image and kernel

That's actually not normal.

> modules.  Kernel modules can be signed by the build time ephemeral
> kernel module signing key, which is built into the kernel and
> automatically loaded onto the ".builtin_trusted_keys" keyring.

Right, there is this advice to use ephemeral key to sign modules.

I don't think that's a sound advice in general. It covers only the
special case when you build the kernel once, only rebuild the whole
kernel and never just one module, don't use any 3rd party module, don't
bother signing firmware (I am not sure that is supported right now but
if you are into integrity and stuff you can see that it makes sense to
sign it, too).

And you need to manage the key you use for the kernel signing, anyway.
Sure, you could use the same ephemeral key as for the modules, enroll
it, and shred it but then it is NOT a key different from the one you use
for modules.

Or you could maintain a long-lived key for the kernel, but if you do I
do NOT see any reason to not use it also for modules, in-tree and
out-of-tree.

> Similarly distros build the kernel module signing key into the kernel,
> which is built into the kernel and loaded onto the
> ".builtin_trusted_keys" keyring.  By loading the pre-OS keys onto the
> ".platform" keyring,  kexec may verify the distro or other signed
> kernel images.

Which are signed by the same key as the modules so there is no reason to
load the platform key at all. I don't think loading shim with kexec is
supported.

Thanks

Michal
