Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051DB4769AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 06:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhLPFir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 00:38:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbhLPFiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 00:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639633125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qrBEElh5/4hAbc/6jTGVDH5c4ghjYxLIGLQd5AjrjwY=;
        b=S+g/JS8Q5hysNpXgGr37/tF/WHGIbzgsXXF8BRi64SAo9TOMLygb+KapD4lwh7KhmqegqI
        0vwgi8oza4VWMG+k8I0JkxkazTUo8FFQESIS0QoOipriURuRw6mR9c5SndQj1xMKJ7kMxW
        gXqtJf8gy+s353UIu+lVZTJ+M5BFAPw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-sBAU0IrGMUGFv79s0JVthw-1; Thu, 16 Dec 2021 00:38:43 -0500
X-MC-Unique: sBAU0IrGMUGFv79s0JVthw-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso758059wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 21:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qrBEElh5/4hAbc/6jTGVDH5c4ghjYxLIGLQd5AjrjwY=;
        b=7TFmLVJ1vp7Wllv82mI5SY7eXdE0WiGGyB85r4sZlh6Rhkv/G8KQdTFc41HS99feYD
         GrpSA5fysVPJ2hOulAluwumR13vOixJ1K0+7FoaChhA1R0/V9ZWJXEehAp4c8Y0OdJxt
         ARhmVu1LHxCsAPxH3OpsSOXf/aN+dgyrWWaCw+jh6BHXjNmKAPsH51CvJVZAyC/hbAFX
         QP9enfBk5B7uEwjqeX7G1REPyFsGTUslhnnhwxLaLIje8IZG60GXunDcwhTPVb8o4RtY
         wUZVnIsJ7HVfdbcZg873ZuXdfG3knNPNatBCatx74tNNhgq8wIEfVCsg9gvmj4f/wQLY
         G4Mw==
X-Gm-Message-State: AOAM532wLYp33kou6QLmKWGxKnnoh+VGo8gwTqv3IxXhsZ5nWwqm4vqA
        O41X3NVpkVJH0gW3G3ZB7VsSw7Ls6TvQk5TZA9BsxGYzQrZdCbQ3ZzDLRCLoUHF3fwU7hwmIvQ/
        EBKgYzwANa+7yOn9x4ljEIjPr
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr1205794wrb.180.1639633122454;
        Wed, 15 Dec 2021 21:38:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqQ37OdEvGxFLS+2BX/bA8SD4YT3AcsowKwMM8wl7jpWe3zWiGOeyYUH+9wrL53x86/SZLbw==
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr1205778wrb.180.1639633122061;
        Wed, 15 Dec 2021 21:38:42 -0800 (PST)
Received: from xz-m1.local ([64.64.123.12])
        by smtp.gmail.com with ESMTPSA id h5sm3426758wrz.63.2021.12.15.21.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 21:38:41 -0800 (PST)
Date:   Thu, 16 Dec 2021 13:38:33 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v6 03/23] mm: Check against orig_pte for finish_fault()
Message-ID: <YbrQ2bsEYsfHrIIV@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com>
 <20211115075522.73795-4-peterx@redhat.com>
 <6260997.DYpkEd5BTb@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6260997.DYpkEd5BTb@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 04:01:47PM +1100, Alistair Popple wrote:
> On Monday, 15 November 2021 6:55:02 PM AEDT Peter Xu wrote:
> > We used to check against none pte and in those cases orig_pte should always be
> > none pte anyway.
> 
> Is that always true? From what I can see in handle_pte_fault() orig_pte only
> gets initialised in the !pmd_none() case so might not be pte_none.

I believe it's true, otherwise I must have overlooked.

IMHO it's not "when we set orig_pte" that matters - note that finish_fault()
(that this patch modifies) is only called for file-backed memories, and it's
only called in do_fault() where the pte is not mapped at all.

DAX seems to call it too, but still DAX comes from do_fault() too, afaict.

The pte will not be mapped in two cases in handle_pte_fault():

  - When pmd_none

  - When !pmd_none, however if we find that pte_none==true, that's:

        if (pte_none(vmf->orig_pte)) {
                pte_unmap(vmf->pte);
                vmf->pte = NULL;
        }

So when we're already in do_fault(), afaict, orig_pte must be pte_none().
Another side note is that, IIUC pte_none() is a looser check than the
pte_val()==0 and it should be arch dependent.

Thanks,

> 
> > This change prepares us to be able to call do_fault() on !none ptes.  For
> > example, we should allow that to happen for pte marker so that we can restore
> > information out of the pte markers.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 04662b010005..d5966d9e24c3 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4052,7 +4052,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> >  				      vmf->address, &vmf->ptl);
> >  	ret = 0;
> >  	/* Re-check under ptl */
> > -	if (likely(pte_none(*vmf->pte)))
> > +	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
> >  		do_set_pte(vmf, page, vmf->address);
> >  	else
> >  		ret = VM_FAULT_NOPAGE;
> > 
> 
> 
> 
> 

-- 
Peter Xu

