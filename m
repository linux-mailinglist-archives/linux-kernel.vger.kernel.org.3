Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A194C5B0438
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiIGMtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIGMtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:49:02 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7294979C3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:49:01 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id cr9so10230100qtb.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 05:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UEpL02WJUezGx/kUOmp7jKU89VPDvQWvQ0H5PSEV0Qc=;
        b=cLcsj7v2xgxU69qHLa3gCzxn+5EuUC50B2y2FzSdL5e00+SDXnNitS9HiZM6LRXtV0
         /Kk5ngWCrpoAEUjuOGlJoUjq4yDbGLtqY6qk0V+k1XM62oKVN090W8bYzN0SdnznSbDl
         59vBwAKjkdCCOGk6lKhAZYmiCgY+XyQuv/+y6t1kWyXm/2MiAU4AtFlQfIFrJGzECe55
         BBMjOTj5wbGh2K7+B2mdkAaOpS9+mwhi3UBoEaBZyvdFEuU4lGzpFf4Na/xBvoEXITrC
         7u/luSFf05JU2Xfw34yV9GvCRBGBlC13fmnLBOblItDRb01My9kyLO1kzyt8Li+75Av6
         r7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UEpL02WJUezGx/kUOmp7jKU89VPDvQWvQ0H5PSEV0Qc=;
        b=Sk1Tux5PD/QsN4Rik5b4H7Z3aqIqpVKgzwS8czvaqL164i1gC6SS3MkKaMUYvZ/Jya
         KpwIN6aAosVRWdMg9HqAfpnPUypITQ2xPlLqEOLZud0oj9YyAl1X44+f45NJbutoscqS
         Iu+VTkOLDqSqRXJg8/H+ccEvl0YQvBeHmNFweu1sWqxvCva//POmYEdZ1oTTu4wuqzQ0
         tAg1r7cHPOz/B01m3TQdyix6mHzBYnd/E/l5TTIPSEPuKZk0qnx9qrd8E9OTPurK8X/w
         wHICcY5IFwJUvzgQRRMvHpruHOUmOkwMIjbJM/hXh1igeG/PAUR8xXU3X12RsyPpEdBh
         ByTw==
X-Gm-Message-State: ACgBeo3AeLV6p5hJtLYoZ7faAQdwzUkCd7aXeauROiWiOidnzMRyPEGc
        GnHPNLRGWfhDYKdRYQ9GthSRZg==
X-Google-Smtp-Source: AA6agR7sC41RjclcS0/9MrYMSIJjSI8TYcRdY34A8NHF2XxTj0+9V49syTe2anWUvpOCCXbt6lz7mA==
X-Received: by 2002:a05:622a:110e:b0:343:6f02:99fd with SMTP id e14-20020a05622a110e00b003436f0299fdmr2999298qty.141.1662554940897;
        Wed, 07 Sep 2022 05:49:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id bi13-20020a05620a318d00b006b59f02224asm13235821qkb.60.2022.09.07.05.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 05:49:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oVuUF-008ZL3-GS;
        Wed, 07 Sep 2022 09:48:59 -0300
Date:   Wed, 7 Sep 2022 09:48:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lpivarc@redhat.com" <lpivarc@redhat.com>,
        "Liu, Jingqi" <jingqi.liu@intel.com>,
        "Lu, Baolu" <baolu.lu@intel.com>
Subject: Re: [PATCH] vfio/type1: Unpin zero pages
Message-ID: <YxiTOyGqXHFkR/DY@ziepe.ca>
References: <166182871735.3518559.8884121293045337358.stgit@omen>
 <BN9PR11MB527655973E2603E73F280DF48C7A9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d71160d1-5a41-eae0-6405-898fe0a28696@redhat.com>
 <YxfX+kpajVY4vWTL@ziepe.ca>
 <b365f30b-da58-39c0-08e9-c622cc506afa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b365f30b-da58-39c0-08e9-c622cc506afa@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 11:00:21AM +0200, David Hildenbrand wrote:
> > > I do wonder if that's a real issue, though. One approach would be to
> > > warn the VFIO users and allow for slightly exceeding the MEMLOCK limit
> > > for a while. Of course, that only works if we assume that such pinned
> > > zeropages are only extremely rarely longterm-pinned for a single VM
> > > instance by VFIO.
> > 
> > I'm confused, doesn't vfio increment the memlock for every page of VA
> > it pins? Why would it matter if the page was COW'd or not? It is
> > already accounted for today as though it was a unique page.
> > 
> > IOW if we add FOLL_FORCE it won't change the value of the memlock.
> 
> I only briefly skimmed over the code Alex might be able to provide more
> details and correct me if I'm wrong:
> 
> vfio_pin_pages_remote() contains a comment:
> 
> "Reserved pages aren't counted against the user, externally pinned pages are
> already counted against the user."
> 
> is_invalid_reserved_pfn() should return "true" for the shared zeropage and
> prevent us from accounting it via vfio_lock_acct(). Otherwise,
> vfio_find_vpfn() seems to be in place to avoid double-accounting pages.

is_invalid_reserved_pfn() is supposed to return 'true' for PFNs that
cannot be returned from pin_user_pages():

/*
 * Some mappings aren't backed by a struct page, for example an mmap'd
 * MMIO range for our own or another device.  These use a different
 * pfn conversion and shouldn't be tracked as locked pages.
 * For compound pages, any driver that sets the reserved bit in head
 * page needs to set the reserved bit in all subpages to be safe.
 */
static bool is_invalid_reserved_pfn(unsigned long pfn)

What it is talking about by 'different pfn conversion' is the
follow_fault_pfn() path, not the PUP path.

So, it is some way for VFIO to keep track of when a pfn was returned
by PUP vs follow_fault_pfn(), because it treats those two paths quite
differently.

I lost track of what the original cause of this bug is - however AFAIK
pin_user_pages() used to succeed when the zero page is mapped.

No other PUP user call this follow_fault_pfn() hacky path, and we
expect things like O_DIRECT to work properly even when reading from VA
that has the zero page mapped.

So, if we go back far enough in the git history we will find a case
where PUP is returning something for the zero page, and that something
caused is_invalid_reserved_pfn() == false since VFIO did work at some
point.

IHMO we should simply go back to the historical behavior - make
is_invalid_reserved_pfn() check for the zero_pfn and return
false. Meaning that PUP returned it.

Jason
