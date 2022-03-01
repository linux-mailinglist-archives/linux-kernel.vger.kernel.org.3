Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB69E4C955D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbiCAUGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiCAUGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:06:20 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1267A60CCF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:05:39 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e13so14376808plh.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aC2oMMHQFLdJ/XqP7d9vygv8pntf7KifLNUmGDpGgXc=;
        b=Rp8+Us/o05ECuRNzQODaQy/2PEmT0m4PhVvuS0TQMQ7/SY+1sul/+Y6HsEVjpo9QoV
         cHep4QNa67NMaWCv3vjWeedfi1qY82bIMjTMUDc68wVHuMXuLFIOIAOjZZbdnGBCY3PC
         QyRN7BPqwOCQiS58GCz8QDrSXxgxxcsJE0e8yYOLr1QXHFEsjW3FdZNsoExi26Ir24RQ
         /ExJQL3Wx5ucVYgE/JwMNWl6grTRDAb5WYFN3KeupcsXlEWqMIApKqihJxALmw7HB0D7
         rL5bYGRmT50oWjHpzaeIYBiM5w2QUe8C8VLcKU2XCIvfpyQyMgsRA6zL9i9qlJMq0ROR
         ppgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aC2oMMHQFLdJ/XqP7d9vygv8pntf7KifLNUmGDpGgXc=;
        b=AAKcBsa0Sg0lpR4DvcnIOSSL72pewRjIwO0dWbwa1SnpiArzQannbbw2R5Rpyf78Ot
         27hlmV7bl5BioZcyADWoev2jvo1Kf4eO4AcHXAiDo53HGne91W2DAxaZrcJx6UHfirxV
         OpRkMaT+5YT/ntnCObXEYbJQ1P7S7ieUfAOvx7u5J1+oh0CjLlAotGjE/x4wrSz3VdzS
         PyPhUFbiDi8czFKIpx0O4zXawBF9CrCys5XEA3cROAvDJc8WYxcJCB2DHIpuxtMhO/Qv
         bPrhbvZLMJsjeSf4leY5m1XSz7iomz1o49VLW8daDd7fY2u1ag4S1/0nUSvqVZd/YPow
         ovvg==
X-Gm-Message-State: AOAM532KvxQ++MQsZnda8Q9239qozCPsi1vCMihf0Ny049/3ellYmuOi
        fMS9iMRO1IZNsIshQC1tZo2BXA1z7JVIUbih1uRxqg==
X-Google-Smtp-Source: ABdhPJyot3uCbPG3oShNMDNTdf1a6402955RgMvd/jnl2LORATOaEArR4uLbJRg2d/HeDY/id/hd38IfLPL+799etQ4=
X-Received: by 2002:a17:90b:d91:b0:1bc:ade1:54e3 with SMTP id
 bg17-20020a17090b0d9100b001bcade154e3mr23532934pjb.8.1646165138605; Tue, 01
 Mar 2022 12:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-42-ira.weiny@intel.com>
 <CAPcyv4h1Q6H6_VApe3eFhEwe0McqbrFGRmy9rzFSPP0ATsTeTw@mail.gmail.com> <Yh535Zqe/GtuF/Xh@iweiny-desk3>
In-Reply-To: <Yh535Zqe/GtuF/Xh@iweiny-desk3>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Mar 2022 12:05:27 -0800
Message-ID: <CAPcyv4g+Cbqk5bev8=SNz-8EwzofER0HrTzUiJ87ygdWSsXAiA@mail.gmail.com>
Subject: Re: [PATCH V8 41/44] kmap: Ensure kmap works for devmap pages
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 11:45 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, Feb 04, 2022 at 01:07:10PM -0800, Dan Williams wrote:
> > On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> > >
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > Users of devmap pages should not have to know that the pages they are
> > > operating on are special.
> >
> > How about get straight to the point without any ambiguous references:
> >
> > Today, kmap_{local_page,atomic} handles granting access to HIGHMEM
> > pages without the caller needing to know if the page is HIGHMEM, or
> > not. Use that existing infrastructure to grant access to PKS/PGMAP
> > access protected pages.
>
> This sounds better.  Thanks.
>
> >
> > > Co-opt the kmap_{local_page,atomic}() to mediate access to PKS protected
> > > pages via the devmap facility.  kmap_{local_page,atomic}() are both
> > > thread local mappings so they work well with the thread specific
> > > protections available.
> > >
> > > kmap(), on the other hand, allows for global mappings to be established,
> > > Which is incompatible with the underlying PKS facility.
> >
> > Why is kmap incompatible with PKS? I know why, but this is a claim
> > without evidence. If you documented that in a previous patch, there's
> > no harm and copying and pasting into this one. A future git log user
> > will thank you for not making them go to lore to try to find the one
> > patch with the  details.
>
> Good point.
>
> > Extra credit for creating a PKS theory of
> > operation document with this detail, unless I missed that?
>
> Well...  I've documented and mentioned the thread-local'ness of PKS a lot but
> I'm pretty close to all of this so it is hard for me to remember where and to
> what degree that is documented.  I've already reworked the PKS documentation a
> bit.  So I'll review that.
>
> >
> > > For this reason
> > > kmap() is not supported.  Rather than leave the kmap mappings to fault
> > > at random times when users may access them,
> >
> > Is that a problem?
>
> No.

What I meant was how random is random and is it distinguishable from
direct page_address() usage where there is no explicit early failure
path?

>
> > This instrumentation is also insufficient for
> > legitimate usages of page_address().
>
> True.  Although with this protection those access' are no longer legitimate.
> And it sounds like it may be worth putting a call in page_address() as well.
>
> > Might as well rely on the kernel
> > developer community being able to debug PKS WARN() splats back to the
> > source because that will need to be done regardless, given kmap() is
> > not the only source of false positive access violations.
>
> I disagree but I'm happy to drop pgmap_protection_flag_invalid() if that is the
> consensus.
>
> The reason I disagree is that it is generally better to catch errors early
> rather than later.  Furthermore, this does not change the permissions.  Which
> means the actual invalid access will also get flagged at the point of use.
> This allows more debugging information for the user.
>
> Do you feel that strongly about removing pgmap_protection_flag_invalid()?

You haven't convinced me that it matters yet. Do you have an example
of a kmap() pointer dereference PKS splat where it's not clear from
the backtrace from the fault handler that a kmap path was involved?

At a minimum if it stays it seems like something that should be
wrapped by VM_WARN_ON_ONCE_PAGE() like other page relative memory
debugging extra checks that get disabled by CONFIG_DEBUG_VM, but the
assertion that "early is better" needs evidence that "later is too
ambiguous".
