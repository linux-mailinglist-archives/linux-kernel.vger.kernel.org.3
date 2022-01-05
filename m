Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDDA4859C1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbiAEUHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:07:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243804AbiAEUHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641413230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8MZFVlpgT6OszG47rgOiJuQIvMn4MT3P/ee6EVCrTU=;
        b=LX9Qt6k2BNU9JRaI4j2kXy7FZHwWnDgvz7MhbeEcqTGj7b5lxZyurfeG9FgJy1SRIZAFb0
        ngOU6snhq0CX3hqeLzGCQDHxLPBFZaQ/ZShxA1ZB4QGqHVVcQ42pDqh91QtmP5DznD9KP8
        0pUOp70w7fRzcQE+yMWE/aEKKOCSfXU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-jVRHUs4EP0SWNjKnK3wIpA-1; Wed, 05 Jan 2022 15:07:09 -0500
X-MC-Unique: jVRHUs4EP0SWNjKnK3wIpA-1
Received: by mail-wm1-f70.google.com with SMTP id j8-20020a05600c1c0800b00346504f5743so2300809wms.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 12:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A8MZFVlpgT6OszG47rgOiJuQIvMn4MT3P/ee6EVCrTU=;
        b=DTBw+h4kjwADa4apWHgLKHw8ASQmKddn1y47QGHaPv4Fo0/bYxNwOQZMsZ5xZYnt6v
         i3wH5KnfhEbXaNQRDQVmOaZd0TOjMn1toUoHqJ3kObX67pFRM17Wzentx7AL5GNfPbPO
         Pe6L9E51N9M2F7ChsPZTmjy1FYZR8UQWuSP4ZodZM7GDeDzGpsB2bIRChVz92PZVgBCc
         j8xnTxgscCoR1JybLngdcRMGnYPFrqMhdW5FHN5UJ0/zfL9b44R5R2udm8HfKAKkk8RK
         uqBEXpJHxObfjbWcd6Nym6Y6VrCdGhwYy74qjKyplHDzyad3aPiPL2uIWZNM8T9oE/Yh
         2vsg==
X-Gm-Message-State: AOAM533kmq67q5Th8Txsfes1SHi3QEQn94sECQO74mXvbLxKbcuDq+E/
        xBtHQjs542Fvvg3okf7bk+dcaUWP1Mq12j+QQD4fPHKe7lvRSzTg26shl34G5BMfa+vkbkz0sbE
        aKG84EdeD76A3DUoIf6dnGFup
X-Received: by 2002:a5d:6d09:: with SMTP id e9mr48944220wrq.142.1641413227584;
        Wed, 05 Jan 2022 12:07:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqcXy8RbxWDVk9mGaKfR5t7S8HKm+nBYmYenSuqXrW0ScmqqVktMDY51dAqnBoNGakZFJBDQ==
X-Received: by 2002:a5d:6d09:: with SMTP id e9mr48944197wrq.142.1641413227386;
        Wed, 05 Jan 2022 12:07:07 -0800 (PST)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id o3sm3388849wmr.15.2022.01.05.12.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:07:06 -0800 (PST)
Date:   Wed, 5 Jan 2022 20:07:04 +0000
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Dov Murik <dovmurik@linux.ibm.com>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Allow guest access to EFI confidential computing
 secret area
Message-ID: <YdX6aAwy0txT9Dk7@work-vm>
References: <20211129114251.3741721-1-dovmurik@linux.ibm.com>
 <YdNHgtuVoLofL4cW@zn.tnic>
 <0280e20e-8459-dd35-0b7d-8dbc1e4a274a@linux.ibm.com>
 <YdSRWmqdNY7jRcer@zn.tnic>
 <YdWEXRt7Ixm6/+Dq@work-vm>
 <YdXq9t75aYLJfb69@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdXq9t75aYLJfb69@zn.tnic>
User-Agent: Mutt/2.1.3 (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Borislav Petkov (bp@suse.de) wrote:
> On Wed, Jan 05, 2022 at 11:43:25AM +0000, Dr. David Alan Gilbert wrote:
> > There's more than one type of dance;
> 
> So Brijesh and I talked about this a bit yesterday. There's all kinds of
> dances...
> 
> > this partially varies depending on the system (SEV/TDX etc)
> 
> By "SEV" I guess you mean pre-SNP because SNP attestation is reportedly
> much better.
> 
> TDX I'm being told is not interested in something like that atm. I guess
> they wanna do something different wrt attestation.

I thought I saw something in their patch series where they also had a
secret that got passed down from EFI?  As I remember they had it with an
ioctl and something; but it felt to me if it would be great if it was
shared.

> So what we're talking about here is pre-SNP attestation, AFAICT.
> 
> > and also depends on how you depend to boot your VM (separate kernel
> > or VM disk). Also it's important to note that when the dance happens
> > varies - in SEV and SEV-ES this happens before the guest executes any
> > code. So at the end of the dance, the guest owner hands over that
> > secret - but only then does the geust start booting;
> 
> Right.
> 
> > that secret has to go somewhere to be used by something later. For
> > example, something might pull out that key and use it to decrypt a
> > disk that then has other secrets on it (e.g. your ssh key).
> 
> That is the other example I heard about.
> 
> So, to sum up: this looks like part of a pre-SNP attestation flow, i.e.,
> for SEV and SEV-ES guests.

Yeh. SNP is a whole different question.

> Follow-up question: is this going to be used by other cloud vendors too?
> Or am I gonna get another implementation of sharing secrets with a guest
> which is just a little bit different but sender #2 can't use this one
> because raisins?
> 
> Because that would not be good.
> 
> So, is this what cloud vendors using SEV/-ES guests would like to use
> and what they all agree upon?

I'd love to hear from those other cloud vendors; I've not been able to
find any detail on how their SEV(-ES) systems actually work.

However, this aims to be just a comms mechanism to pass that secret;
so it's pretty low down in the stack and is there for them to use -
hopefully it's general enough.
(An interesting question is what exactly gets passed in this key and
what it means).

All the contentious stuff I've seen seems to be further up the stack - like
who does the attestation and where they get the secrets and how they
know what a valid measurement looks like.

Dave

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

