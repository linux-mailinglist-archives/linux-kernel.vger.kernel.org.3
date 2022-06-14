Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA454A3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiFNByz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242358AbiFNByx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 845832FFDB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655171691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/D2zV8uYgr3E+2jnjqTkdGXtDdtpkC+Fc4LAvZ9Wl80=;
        b=MHWJ3MIZrezMi2Ouy5fznhiS//Bh7EAFeKLfeyAtjGZN3OrVGq5ao6p9bpkBZmluDzMtYP
        vV5iU9OXryfQyp2cSXYYKh0+LQRzmB2pCi5YDL1hOKblgSExNlbkaoYb7bnus0VYTpaoW2
        pkbDvxiE5e4hLmT2R1EdrUd5m16GX+I=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-2IMXUadlN8iRyLHo-frF0A-1; Mon, 13 Jun 2022 21:54:42 -0400
X-MC-Unique: 2IMXUadlN8iRyLHo-frF0A-1
Received: by mail-il1-f200.google.com with SMTP id q15-20020a056e0220ef00b002d15dcd2750so5721475ilv.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/D2zV8uYgr3E+2jnjqTkdGXtDdtpkC+Fc4LAvZ9Wl80=;
        b=2ocepc0P7mTf6aZPGMVHhDUoG0SU73cJjJXHkZgFcDa/8Eyge423APRi9cxrgZcugl
         uIzB7lbrgWoz0T9/DIPXC2oLPrNsF8sm42OFQDpC0QnDAgupekdekif+lmVA8xPx018W
         kU28i65ug/BFdN6EDHI8vI3GwoPVX1J9A8FXjwsk8upJIeGV+8F0RH6Oo3suqcv4uXnW
         /D/PA+PQlw2we5khBG/+GCSmtjFVgqj8Xk5fB4NzVTGs1z8Cp2f/LCghZe7nq3DS80Pc
         hq0aG4lgQWIKKk+/RImbuh74kpzjIyGuAHPcgacVzkoQG7qbo+sIYxGJtIUOr3iEZ0Fz
         VN9A==
X-Gm-Message-State: AOAM532/gtkJn6PSZGR6BGE+GZhWzULckQ7koXyixugXLQvdE960R/rN
        ltUuyKSKR6NM4cBuyTsbvr+SrwKI6yTEi102jyl22ZHqK/5YASOLOWW9LGw5v+cH+rvzfBH0urU
        ZSMNHZdG19wVQLqIMec1jtsmJ/GvWaKx60I+URop9
X-Received: by 2002:a5e:8404:0:b0:66a:13cc:f2bc with SMTP id h4-20020a5e8404000000b0066a13ccf2bcmr617841ioj.95.1655171682225;
        Mon, 13 Jun 2022 18:54:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsfLw/TVvIYon6xpgZ7S5cc632g91mYFy2r2EN8TmALPXrHX43fQtvYEYYDydUa3e7swddjRYM/znMCdhYKgc=
X-Received: by 2002:a5e:8404:0:b0:66a:13cc:f2bc with SMTP id
 h4-20020a5e8404000000b0066a13ccf2bcmr617827ioj.95.1655171682008; Mon, 13 Jun
 2022 18:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220505194658.246121-1-steve.wahl@hpe.com> <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613205734.3x7i46bnsofzerr4@cantor> <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
 <CALzcddsXciFgKOLSkXxx4Rv_rwh21qe8hkyiEET280D8orP6Vw@mail.gmail.com> <9c943703-0c2f-b654-a28b-f594bf90bec9@linux.intel.com>
In-Reply-To: <9c943703-0c2f-b654-a28b-f594bf90bec9@linux.intel.com>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Mon, 13 Jun 2022 18:54:13 -0700
Message-ID: <CALzcdduU-baVF9VV-NnYD2rKn0YC5hzS_F9udExRE7guvMqXWg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 6:51 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2022/6/14 09:44, Jerry Snitselaar wrote:
> > On Mon, Jun 13, 2022 at 6:36 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
> >> On 2022/6/14 04:57, Jerry Snitselaar wrote:
> >>> On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> >>>> To support up to 64 sockets with 10 DMAR units each (640), make the
> >>>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> >>>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> >>>> set.
> >>>>
> >>>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> >>>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> >>>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> >>>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> >>>> fails to boot properly.
> >>>>
> >>>> Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
> >>>> ---
> >>>>
> >>>> Note that we could not find a reason for connecting
> >>>> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> >>>> it seemed like the two would continue to match on earlier processors.
> >>>> There doesn't appear to be kernel code that assumes that the value of
> >>>> one is related to the other.
> >>>>
> >>>> v2: Make this value a config option, rather than a fixed constant.  The default
> >>>> values should match previous configuration except in the MAXSMP case.  Keeping the
> >>>> value at a power of two was requested by Kevin Tian.
> >>>>
> >>>>    drivers/iommu/intel/Kconfig | 6 ++++++
> >>>>    include/linux/dmar.h        | 6 +-----
> >>>>    2 files changed, 7 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> >>>> index 247d0f2d5fdf..fdbda77ac21e 100644
> >>>> --- a/drivers/iommu/intel/Kconfig
> >>>> +++ b/drivers/iommu/intel/Kconfig
> >>>> @@ -9,6 +9,12 @@ config DMAR_PERF
> >>>>    config DMAR_DEBUG
> >>>>       bool
> >>>>
> >>>> +config DMAR_UNITS_SUPPORTED
> >>>> +    int "Number of DMA Remapping Units supported"
> >>> Also, should there be a "depends on (X86 || IA64)" here?
> >> Do you have any compilation errors or warnings?
> >>
> >> Best regards,
> >> baolu
> >>
> > I think it is probably harmless since it doesn't get used elsewhere,
> > but our tooling was complaining to me because DMAR_UNITS_SUPPORTED was
> > being autogenerated into the configs for the non-x86 architectures we
> > build (aarch64, s390x, ppcle64).
> > We have files corresponding to the config options that it looks at,
> > and I had one for x86 and not the others so it noticed the
> > discrepancy.
>
> So with "depends on (X86 || IA64)", that tool doesn't complain anymore,
> right?
>
> Best regards,
> baolu
>

Yes, with the depends it no longer happens.

Regards,
Jerry

