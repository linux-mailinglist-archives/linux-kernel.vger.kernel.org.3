Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA7351286E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbiD1BFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiD1BFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:05:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A53AE70
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:02:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bd19-20020a17090b0b9300b001d98af6dcd1so6321995pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGGuSc0LSBpuNtbaK3b654kpekt8+afyXub7g//oygQ=;
        b=lfN+Nhqc2aJ4rKKRp29t9F072aKzevhDma4KY5PS1Z/oIl/YgaJt1bXV+Qghxx6s0e
         dXntgAWGVNC6Y4bxz9ls0y/VdHGaZ9PgdmVNvcdsvCfWV4w4bV4pS43+dT3k6bq0N97q
         mn2BLHfNh93NYHcrOtUbs3g370CwDKhkNY0xqKp6HDoIMf0MohHESw8owRmF56Q1KJZl
         tKwh+sE3tnkwAPlIfglLpZZjQFx2vx+2GBqiLJqdln9Ji4yMbzZqIJ3Akk2OMeGLcJHg
         +0kHO5wjo5AlS2L0n6lBNDuccRTU0SzPLtNB7HBzNcvetMpbt+rN8Xsy+uwFbXD5Tkyc
         xBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGGuSc0LSBpuNtbaK3b654kpekt8+afyXub7g//oygQ=;
        b=48i/MW+lFP1MARPSoU4T+8ekXkNXff97QKMWj+rp66MBK6zGrfxROqRph02PeQ+K+7
         addZHYFRtW37eE2NnyADrw2V5L1eJxpTH1RnKrmEkApOpJfyCuaMEN222GrgBgLzc6TE
         syqOdSIdlX03Ua2ugIBw1mNiwJfNjUsKTVc6aPAEgzjILtNCLeFu/n4TEvqCqIHhOkB0
         RJBCO/WugTIxhocgMq264bLGAVOttQurHQ8i7OWdWgNLD0fxeIEyfAtdb0YuwdPeeYSi
         n5hSTlfdOBBl1b0xO+xCddFLIPjpcBKWTG2KRSBNtoc0DY9pzC8jHFWeyIbqHF+8oBIq
         mrbw==
X-Gm-Message-State: AOAM531XrFndMbBOcoleUnXmpahK8YMMq2oiLzrc7nCTtla2zYpeMG8t
        I6VNtc21mwLEzjiBAj3CNv/hvofVa8JoRHQ/ty4a6g==
X-Google-Smtp-Source: ABdhPJzjke2ZEb+yF7GVfe3sX27nyy/kmsf+yglPd7alvwRgx2AoojnzZ+0Ix57E6s7+ew5bxxyRUl/ZtqkXCCwM560=
X-Received: by 2002:a17:902:da81:b0:15d:37b9:70df with SMTP id
 j1-20020a170902da8100b0015d37b970dfmr10897086plx.34.1651107724585; Wed, 27
 Apr 2022 18:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1649219184.git.kai.huang@intel.com> <522e37eb-68fc-35db-44d5-479d0088e43f@intel.com>
In-Reply-To: <522e37eb-68fc-35db-44d5-479d0088e43f@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Apr 2022 18:01:53 -0700
Message-ID: <CAPcyv4g5E_TOow=3pFJXyFr=KLV9pTSnDthgz6TuXvru4xDzaQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/21] TDX host kernel support
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kai Huang <kai.huang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 1:10 PM Dave Hansen <dave.hansen@intel.com> wrote:
[..]
> > 3. Memory hotplug
> >
> > The first generation of TDX architecturally doesn't support memory
> > hotplug.  And the first generation of TDX-capable platforms don't support
> > physical memory hotplug.  Since it physically cannot happen, this series
> > doesn't add any check in ACPI memory hotplug code path to disable it.
> >
> > A special case of memory hotplug is adding NVDIMM as system RAM using

Saw "NVDIMM" mentioned while browsing this, so stopped to make a comment...

> > kmem driver.  However the first generation of TDX-capable platforms
> > cannot enable TDX and NVDIMM simultaneously, so in practice this cannot
> > happen either.
>
> What prevents this code from today's code being run on tomorrow's
> platforms and breaking these assumptions?

The assumption is already broken today with NVDIMM-N. The lack of
DDR-T support on TDX enabled platforms has zero effect on DDR-based
persistent memory solutions. In other words, please describe the
actual software and hardware conflicts at play here, and do not make
the mistake of assuming that "no DDR-T support on TDX platforms" ==
"no NVDIMM support".

> > Another case is admin can use 'memmap' kernel command line to create
> > legacy PMEMs and use them as TD guest memory, or theoretically, can use
> > kmem driver to add them as system RAM.  To avoid having to change memory
> > hotplug code to prevent this from happening, this series always include
> > legacy PMEMs when constructing TDMRs so they are also TDX memory.

I am not sure what you are trying to say here?

> > 4. CPU hotplug
> >
> > The first generation of TDX architecturally doesn't support ACPI CPU
> > hotplug.  All logical cpus are enabled by BIOS in MADT table.  Also, the
> > first generation of TDX-capable platforms don't support ACPI CPU hotplug
> > either.  Since this physically cannot happen, this series doesn't add any
> > check in ACPI CPU hotplug code path to disable it.

What are the actual challenges posed to TDX with respect to CPU hotplug?

> > Also, only TDX module initialization requires all BIOS-enabled cpus are

Please define "BIOS-enabled" cpus. There is no "BIOS-enabled" line in
/proc/cpuinfo for example.
