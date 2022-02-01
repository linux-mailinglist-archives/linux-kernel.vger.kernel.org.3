Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738AA4A6338
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241746AbiBASHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:07:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241731AbiBASHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643738867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WbBlRRySTSYfyiFCmjcFdtwLEhU3rffLIxhLq8iPqzY=;
        b=MlpqS1EeJMgJoJ14qRud4UFhYD9AzMqmSy2oIr2NkoldqO/4q2tRkvzPvOol4OWTXE5Sqg
        HRa3RuuFRhGVLVbTRSA3Y8ALJHZ+9qqN1i3Hus0fCIwnF79bwaYVmz219Z3we1k1IqznqE
        Dp+IXQN4O68ICHXQ0iJkxl/fNVWeJYQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-fAphjLNtNqC-cbSDw0t6SQ-1; Tue, 01 Feb 2022 13:07:46 -0500
X-MC-Unique: fAphjLNtNqC-cbSDw0t6SQ-1
Received: by mail-wm1-f70.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so2053625wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WbBlRRySTSYfyiFCmjcFdtwLEhU3rffLIxhLq8iPqzY=;
        b=cvUtZZk3vAvzePiOA5sL58Th0C7gO2VuKIUnGErPp4ounOFt5twF6F1IYdLjERKvpq
         D1/rgx8+a6BOORE2T5HgZ4Ldtn02kL4laAOyixC+h1zr7Kj9Ua5ed2onOiCt7VuXjUD7
         Fo6k1uA45HvMaJL2ZNO7lh9ZKMaMWW9G4h2pf+TEkjXakZpIT7e955k1VxNE8mHrgPqc
         bJHQkczjGq53OWgxPq4XHwQ6ytMrpWsNgz2FmIDz+Pwbna7WpT1vWA7jTn61jAhb8Tbw
         vx0a3vtwHinRVpM4L37yW7T7FZSAmIlpHVqX0mQBEEzSFRlwHSPdbT7/Jdq230y0jZSm
         dhvA==
X-Gm-Message-State: AOAM533E4NJ8/ABKeb7kzLc/9PBJMVH75VxVQu7VKq78RAn4eDHgXctj
        9DsXjXKHDiP4WcB85BauMwuXntET+uLeUAv59HhQjoAlcfTXmLfBc1yc5ImTYoiIIWcSjukCtUK
        7M/sONyAXawjql+kouuRiMpLM
X-Received: by 2002:adf:ef05:: with SMTP id e5mr2411067wro.413.1643738865383;
        Tue, 01 Feb 2022 10:07:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEMGb5gkaJl9q84gkPJPKSY0nbPh9TUR5tTp3lEGzAv+bm64PK8deuOj2kLWisFBBgOydY2Q==
X-Received: by 2002:adf:ef05:: with SMTP id e5mr2411018wro.413.1643738864991;
        Tue, 01 Feb 2022 10:07:44 -0800 (PST)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id o14sm17659694wry.104.2022.02.01.10.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:07:44 -0800 (PST)
Date:   Tue, 1 Feb 2022 18:07:41 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        dougmill@linux.vnet.ibm.com, gcwilson@linux.ibm.com,
        gjoyce@ibm.com, linuxppc-dev@lists.ozlabs.org, mjg59@srcf.ucam.org,
        mpe@ellerman.id.au, dja@axtens.net
Subject: Re: [PATCH v7 0/5] Allow guest access to EFI confidential computing
 secret area
Message-ID: <Yfl27cDpAUYy59ss@work-vm>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <Yfk6vEuZFtgtA+G+@kroah.com>
 <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
User-Agent: Mutt/2.1.5 (2021-12-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* James Bottomley (jejb@linux.ibm.com) wrote:
> [cc's added]
> On Tue, 2022-02-01 at 14:50 +0100, Greg KH wrote:
> > On Tue, Feb 01, 2022 at 12:44:08PM +0000, Dov Murik wrote:
> [...]
> > > # ls -la /sys/kernel/security/coco/efi_secret
> > > total 0
> > > drwxr-xr-x 2 root root 0 Jun 28 11:55 .
> > > drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
> > > -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-
> > > 06879ce3da0b
> > > -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-
> > > d3a0b54312c6
> > > -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-
> > > ff17f78864d2
> > 
> > Please see my comments on the powerpc version of this type of thing:
> > 	
> > https://lore.kernel.org/r/20220122005637.28199-1-nayna@linux.ibm.com
> 
> If you want a debate, actually cc'ing the people on the other thread
> would have been a good start ...
> 
> For those added, this patch series is at:
> 
> https://lore.kernel.org/all/20220201124413.1093099-1-dovmurik@linux.ibm.com/
> 
> > You all need to work together to come up with a unified place for
> > this and stop making it platform-specific.
> 
> I'm not entirely sure of that.  If you look at the differences between
> EFI variables and the COCO proposal: the former has an update API
> which, in the case of signed variables, is rather complex and a UC16
> content requirement.  The latter is binary data with read only/delete. 
> Plus each variable in EFI is described by a GUID, so having a directory
> of random guids, some of which behave like COCO secrets and some of
> which are EFI variables is going to be incredibly confusing (and also
> break all our current listing tools which seems somewhat undesirable).
> 
> So we could end up with 
> 
> <common path prefix>/efivar
> <common path prefix>/coco
> 
> To achieve the separation, but I really don't see what this buys us. 
> Both filesystems would likely end up with different backends because of
> the semantic differences and we can easily start now in different
> places (effectively we've already done this for efi variables) and
> unify later if that is the chosen direction, so it doesn't look like a
> blocker.
> 
> > Until then, we can't take this.
> 
> I don't believe anyone was asking you to take it.

I have some sympathy in wanting some unification; (I'm not sure that
list of comparison even includes the TDX world).
But I'm not sure if they're the same thing - these are strictly
constants, they're not changable.

But it is a messy list of differences - especially things like the
UTF-16 stuff
I guess the PowerVM key naming contains nul and / can be ignored
- if anyone is silly enough to create keys with those names then they
can not access them; so at least that would solve that problem.

I don't really understand the talk of 32bit attributes in either the
uEFI or PowerVM key store case.

Is that GOOGLE_SMI stuff already there? If so I guess there's not much
we can do  - but it's a shame that there's the directory per variable.

Dave



> James
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

