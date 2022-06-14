Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F48654BA0B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358073AbiFNTDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345245AbiFNTCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:02:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6689616596
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655233310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SAh+GOzRM5ZJKSrACCl7nQjWeiM90GqoVoI/fuo1lHY=;
        b=a4w/oG3yZrhIYO/Flql3/5EeKOjKFznxdLycpIVP90ijdgy8wWQVUuwnxe3KlM9kiYHWSO
        Qd77uy/hZ+9ES7Edhy8xBOFv96jXgf7GSvkgGcVwlC0kOqA4hbup1WfSZ0HJZ6ULkJQ/cP
        JJjmddgX+odD34cyNsAYfHWzjuYLgVI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-INcCPwaDMx-eJAP4NRRzdw-1; Tue, 14 Jun 2022 15:01:49 -0400
X-MC-Unique: INcCPwaDMx-eJAP4NRRzdw-1
Received: by mail-pj1-f70.google.com with SMTP id h6-20020a17090a580600b001eab5988770so2790775pji.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SAh+GOzRM5ZJKSrACCl7nQjWeiM90GqoVoI/fuo1lHY=;
        b=KkSpqWNGwLk0Rrl3OfSXYwNE9A4InBVJVtQ2hBME8G4XdE0UBmIkw6zmXQopb3nZvl
         RAegea7Ns9xlzl3FP6n8uD1rQ147CoOvS0YDQzxFQHIYZwu8eM/lE5CsaH+sUjytcC0Q
         hRbe6ITaWxO5ucZXzbP8MRGBCI6KY0jdE/dhcbPcstmfCKsmCYn0txwECnqRhkHvAros
         dZnDTkFFgJIjys/1ezVuqQvpMqAlXgU/NOs2Z12n+URjjeZ2eD9k429YZtNC+IAGBhG2
         4jIU/UXfCPXINNK3wCBIqckQw5C7DENrRjU0+lB30e57Ad32EZThMTGcherxmi2ftSi4
         mQ4g==
X-Gm-Message-State: AOAM532+IV2vfummXJGq8DDOxjxzElrHT6UV0wDgNrsQ9sokgg1zECeY
        BMkPEHK+U0FVZ4cpm3qEINp62AJSg3kBtTK//DFQTLxHoEWWyj+7NRQEvks6tGa25q/fWz9rLTB
        zvCZnJL8UqZvRfQX92w3gsVbP
X-Received: by 2002:a63:ff19:0:b0:403:7c60:ae96 with SMTP id k25-20020a63ff19000000b004037c60ae96mr5581538pgi.466.1655233308296;
        Tue, 14 Jun 2022 12:01:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0/yOlBlVpAjgAT0lLPDbPxws5cMgkxTruGHAuqHHujxe+ske9BuknPn+Zqn64BRk4zuXORQ==
X-Received: by 2002:a63:ff19:0:b0:403:7c60:ae96 with SMTP id k25-20020a63ff19000000b004037c60ae96mr5581514pgi.466.1655233308009;
        Tue, 14 Jun 2022 12:01:48 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a8b0500b001ead2406552sm221754pjn.46.2022.06.14.12.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:01:47 -0700 (PDT)
Date:   Tue, 14 Jun 2022 12:01:45 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Message-ID: <20220614190145.dkdwjnqnd7lv6y4n@cantor>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613205734.3x7i46bnsofzerr4@cantor>
 <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
 <CALzcddsXciFgKOLSkXxx4Rv_rwh21qe8hkyiEET280D8orP6Vw@mail.gmail.com>
 <9c943703-0c2f-b654-a28b-f594bf90bec9@linux.intel.com>
 <CALzcdduU-baVF9VV-NnYD2rKn0YC5hzS_F9udExRE7guvMqXWg@mail.gmail.com>
 <616dc81c-dfc6-d6c6-1eab-de0e9ba4411f@linux.intel.com>
 <Yqi7L9A/ADXpIvN6@swahl-home.5wahls.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqi7L9A/ADXpIvN6@swahl-home.5wahls.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 11:45:35AM -0500, Steve Wahl wrote:
> On Tue, Jun 14, 2022 at 10:21:29AM +0800, Baolu Lu wrote:
> > On 2022/6/14 09:54, Jerry Snitselaar wrote:
> > > On Mon, Jun 13, 2022 at 6:51 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
> > > > 
> > > > On 2022/6/14 09:44, Jerry Snitselaar wrote:
> > > > > On Mon, Jun 13, 2022 at 6:36 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
> > > > > > On 2022/6/14 04:57, Jerry Snitselaar wrote:
> > > > > > > On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> > > > > > > > To support up to 64 sockets with 10 DMAR units each (640), make the
> > > > > > > > value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> > > > > > > > CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> > > > > > > > set.
> > > > > > > > 
> > > > > > > > If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> > > > > > > > to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> > > > > > > > allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> > > > > > > > remapping doesn't support X2APIC mode x2apic disabled"; and the system
> > > > > > > > fails to boot properly.
> > > > > > > > 
> > > > > > > > Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
> > > > > > > > ---
> > > > > > > > 
> > > > > > > > Note that we could not find a reason for connecting
> > > > > > > > DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> > > > > > > > it seemed like the two would continue to match on earlier processors.
> > > > > > > > There doesn't appear to be kernel code that assumes that the value of
> > > > > > > > one is related to the other.
> > > > > > > > 
> > > > > > > > v2: Make this value a config option, rather than a fixed constant.  The default
> > > > > > > > values should match previous configuration except in the MAXSMP case.  Keeping the
> > > > > > > > value at a power of two was requested by Kevin Tian.
> > > > > > > > 
> > > > > > > >     drivers/iommu/intel/Kconfig | 6 ++++++
> > > > > > > >     include/linux/dmar.h        | 6 +-----
> > > > > > > >     2 files changed, 7 insertions(+), 5 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> > > > > > > > index 247d0f2d5fdf..fdbda77ac21e 100644
> > > > > > > > --- a/drivers/iommu/intel/Kconfig
> > > > > > > > +++ b/drivers/iommu/intel/Kconfig
> > > > > > > > @@ -9,6 +9,12 @@ config DMAR_PERF
> > > > > > > >     config DMAR_DEBUG
> > > > > > > >        bool
> > > > > > > > 
> > > > > > > > +config DMAR_UNITS_SUPPORTED
> > > > > > > > +    int "Number of DMA Remapping Units supported"
> > > > > > > Also, should there be a "depends on (X86 || IA64)" here?
> > > > > > Do you have any compilation errors or warnings?
> > > > > > 
> > > > > > Best regards,
> > > > > > baolu
> > > > > > 
> > > > > I think it is probably harmless since it doesn't get used elsewhere,
> > > > > but our tooling was complaining to me because DMAR_UNITS_SUPPORTED was
> > > > > being autogenerated into the configs for the non-x86 architectures we
> > > > > build (aarch64, s390x, ppcle64).
> > > > > We have files corresponding to the config options that it looks at,
> > > > > and I had one for x86 and not the others so it noticed the
> > > > > discrepancy.
> > > > 
> > > > So with "depends on (X86 || IA64)", that tool doesn't complain anymore,
> > > > right?
> > > > 
> > > > Best regards,
> > > > baolu
> > > > 
> > > 
> > > Yes, with the depends it no longer happens.
> > 
> > The dmar code only exists on X86 and IA64 arch's. Adding this depending
> > makes sense to me. I will add it if no objections.
> 
> I think that works after Baolu's patchset that makes intel-iommu.h
> private.  I'm pretty sure it wouldn't have worked before that.
> 
> No objections.
> 

Yes, I think applying it with the depends prior to Baolu's change would
still run into the issue from the KTR report if someone compiled without
INTEL_IOMMU enabled.

This was dealing with being able to do something like:

make allmodconfig ARCH=arm64 ; grep DMAR_UNITS .config

and finding CONFIG_DMAR_UNITS_SUPPORTED=64.

Thinking some more though, instead of the depends being on the arch
would depending on DMAR_TABLE or INTEL_IOMMU be more appropriate?

Regards,
Jerry

> --> Steve
> 
> -- 
> Steve Wahl, Hewlett Packard Enterprise

