Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0CA489D82
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbiAJQ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:27:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237384AbiAJQ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641832043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jeIheefqGaZ2GeSClHVA0Xt4+ifFFQupgVzVvNBmh9M=;
        b=Pi480Z0asA4vSBivD65Wluk6xgLj0c9zI88z0zIe2xS8Al+DMoMjaZPVP2XlVZEsLVqtQ7
        mqD/E1YF9sHZm8U+ZmIYhNJPaBYAmw6BjvllsOMCHhxuHEvOvrN2gFSKEQcJxFgXb8Z/Mx
        jZ1u9mEUCC6SnPv8F/sjm9ZMgIi14n4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-VeIean_aMaGWOcVkngqFTw-1; Mon, 10 Jan 2022 11:27:22 -0500
X-MC-Unique: VeIean_aMaGWOcVkngqFTw-1
Received: by mail-wr1-f71.google.com with SMTP id o28-20020adfa11c000000b001a60fd79c21so2593163wro.19
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 08:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jeIheefqGaZ2GeSClHVA0Xt4+ifFFQupgVzVvNBmh9M=;
        b=jgWr8KIovu8Dn6RSuLT1pksVMQjqmiGyjPb0alWRIik8OMHLjTbrQ1YHa+Yw9K9hWi
         DHkh3/nwpYtPAUbbMHzMrw1iHPCZydg95eiqfAUFeZFEeFVqFxJBzfALsUpvr28syJ3u
         ulx4U/UEGt7mRoqQSUPCGhAPsfhpzXONxSzXU81gxDf0AXH7JaL9Hbr378qT66FXdT7J
         6i2bGwbVn/9xAm9pbBMqtwzV+Qrgl3Z2YGugbUpXdqf6ytDe7IgtPL9aKaNzUZ3gaPKl
         zI/js0UKM89Erx0uCLH4Gw0rPJEgPyiTZA3v0dwfHRmeHj99qSqrXiVS7VH1/0YI4ycI
         AX2Q==
X-Gm-Message-State: AOAM532E73m9WQUFf2iCJjAMN/ES1vnvfkZvLIF6xPgU9wBoy8oibjuV
        AO1gSSIlMjneZ9cLl0Q2J6ORi7O/NIOujf15YvWRUerkn9cQlGgxjh9rsvvewILq4neycoZNXHR
        9ymx34iFQVatJJACHQ0B9Je7r
X-Received: by 2002:a05:600c:1c22:: with SMTP id j34mr3870360wms.116.1641832040370;
        Mon, 10 Jan 2022 08:27:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw78/dFkceXP7vi+FCTgn09bLS0ejoLHTG16lQIhQ5MhHYjaxHo78dnCGmFqnQo+pPk89TDmg==
X-Received: by 2002:a05:600c:1c22:: with SMTP id j34mr3870348wms.116.1641832040150;
        Mon, 10 Jan 2022 08:27:20 -0800 (PST)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id e13sm7183050wmq.10.2022.01.10.08.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 08:27:19 -0800 (PST)
Date:   Mon, 10 Jan 2022 16:27:17 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     Borislav Petkov <bp@suse.de>, Dov Murik <dovmurik@linux.ibm.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-efi@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/5] Allow guest access to EFI confidential computing
 secret area
Message-ID: <YdxeZWmQxbfa+Fa2@work-vm>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
 <YdNHgtuVoLofL4cW@zn.tnic>
 <0280e20e-8459-dd35-0b7d-8dbc1e4a274a@linux.ibm.com>
 <YdSRWmqdNY7jRcer@zn.tnic>
 <YdWEXRt7Ixm6/+Dq@work-vm>
 <YdXq9t75aYLJfb69@zn.tnic>
 <YdX6aAwy0txT9Dk7@work-vm>
 <YdgrDRCJOOg4k1Za@zn.tnic>
 <CAMkAt6qCHPzUT=COb_HQ51rRKwtaCC3Zxgc6k6ivB_dZUKx5Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMkAt6qCHPzUT=COb_HQ51rRKwtaCC3Zxgc6k6ivB_dZUKx5Hw@mail.gmail.com>
User-Agent: Mutt/2.1.3 (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Gonda (pgonda@google.com) wrote:
> On Fri, Jan 7, 2022 at 4:59 AM Borislav Petkov <bp@suse.de> wrote:
> >
> > On Wed, Jan 05, 2022 at 08:07:04PM +0000, Dr. David Alan Gilbert wrote:
> > > I thought I saw something in their patch series where they also had a
> > > secret that got passed down from EFI?
> >
> > Probably. I've seen so many TDX patchsets so that I'm completely
> > confused what is what.
> >
> > > As I remember they had it with an ioctl and something; but it felt to
> > > me if it would be great if it was shared.
> >
> > I guess we could try to share
> >
> > https://lore.kernel.org/r/20211210154332.11526-28-brijesh.singh@amd.com
> >
> > for SNP and TDX.
> >
> > > I'd love to hear from those other cloud vendors; I've not been able to
> > > find any detail on how their SEV(-ES) systems actually work.
> >
> > Same here.
> >
> > > However, this aims to be just a comms mechanism to pass that secret;
> > > so it's pretty low down in the stack and is there for them to use -
> > > hopefully it's general enough.
> >
> > Exactly!
> >
> > > (An interesting question is what exactly gets passed in this key and
> > > what it means).
> > >
> > > All the contentious stuff I've seen seems to be further up the stack - like
> > > who does the attestation and where they get the secrets and how they
> > > know what a valid measurement looks like.
> >
> > It would be much much better if all the parties involved would sit down
> > and decide on a common scheme so that implementation can be shared but
> > getting everybody to agree is likely hard...
> 
> I saw a request for other cloud provider input here.

Thanks for the reply!

> A little
> background for our SEV VMs in GCE we rely on our vTPM for attestation,
> we do this because of SEV security properties quoting from AMD being
> to protect guests from a benign but vulnerable hypervisor. So a
> benign/compliant hypervisor's vTPM wouldn't lie to the guest. So we
> added a few bits in the PCRs to allow users to see their SEV status in
> vTPM quotes.

OK, so we're trying to protect from a malicious hypervisor - we don't
trust anything on the host (other than the CPU, and it's got to be
signing the attestation);  we don't think there's a way to do that with
a vTPM on plain SEV/SEV-ES

> It would be very interesting to offer an attestation solution that
> doesn't rely on our virtual TPM. But after reading through this cover
> letter and the linked OVMF patches I am confused what's the high level
> flow you are working towards? Are you loading in some OVMF using
> LAUNCH_UPDATE_DATA, getting the measurement with LAUNCH_MEASURE, then
> sending that to the customer who can then craft a "secret" (maybe say
> SSH key) for injection with LAUNCH_SECRET? Thats sounds good but there
> are a lot details left unattested there, how do you know you will boot
> from the image loaded with the PSP into a known state? Do you have
> some documentation I could read through to try and understand a little
> more and apologies if I missed it.

I'll defer to Dov's reply on that.

Dave

> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
> >
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

