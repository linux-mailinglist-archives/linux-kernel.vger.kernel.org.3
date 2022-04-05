Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376F44F4DC6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583161AbiDEXv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457865AbiDEQxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:53:37 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12C1326E6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:51:37 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id s7so3870915qtk.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DZaRsWyX31QD4hA+oZZqyItqPWIM69HLGIh6hYg0oQE=;
        b=SKkJTRBQcHwyVWbzY1Q0fFJTZmB73lmVPAnSYhBqVVK1scWpN4Ob8A00UKCaM387r4
         AfciYNdmHkeH/JlcNCEIyV1xeDIc/xO8CTsUpaQ9Nfm8m45bDswB5zCngl2vpuILNw3p
         CQ1zD0Vrk72EXS9N1dpOrZ0cMsRqoFy9Avyd7aRjyfzieiSJVwJ72RCA3g7oJFF6OHxk
         gtWdCx9YOOio9pgRwfesVCtbshpogXUCTFcLuqPtNJmArFM1fFUWc0MMu7tetlaOELml
         FSV82Fy2929wV82QLNafqtOMhBmRY2JlpLyGnh5N53amH3Rg+Lv9Du2jfa44f15e9Vn8
         HFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DZaRsWyX31QD4hA+oZZqyItqPWIM69HLGIh6hYg0oQE=;
        b=FPZg31nTxT7NH6s+gczLIB42jwlhlXQ2qLkfYGXsPEwx19Tugr5UHw2OtIK9X5pjbt
         Q+QDi8DIj/TIDHpbO2W1sX+C6HLNB0QuYPGc1TMUY8IguK+lljcYM27siDWuTTCLOGgm
         rJBv6LuQ3xlwgnjvUiRX7DxFPbWsMSncFIysgVMfd8gVQvpEJn2Ugz9U3JKzdDn3lwqq
         vLnCUq5Nv5A5hgxHSAg18xftIsRlzi6H6Ns7yXR+geIoCLWSpoo4QyF8lM1fgtADRtHR
         4uslYSlv2L/HA/kohqE6ixhkE58DN/6PFgWlhchQutOZWccxNPESpDZNxo/pZrbFPFei
         socA==
X-Gm-Message-State: AOAM532StwFFdoeBGM7BvoUP1DQG0wILRJaArmdqzdvNFPP3nW1c+jPX
        aL2tVFVCVqQ/lt+pvUb0cpEfIHA4Q1xBXQ==
X-Google-Smtp-Source: ABdhPJyqiRVuBFpx9bRzvsG3XiF+NGW1XPncA04INZy3n5mHw4hVYOyIPXq4yrbKNu2ipSi3tYvOvg==
X-Received: by 2002:a05:622a:1d5:b0:2e1:a8b8:3ee8 with SMTP id t21-20020a05622a01d500b002e1a8b83ee8mr3675968qtw.346.1649177497004;
        Tue, 05 Apr 2022 09:51:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b0067afe7dd3ffsm9182055qki.49.2022.04.05.09.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 09:51:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nbmP0-00D9J9-QM; Tue, 05 Apr 2022 13:51:34 -0300
Date:   Tue, 5 Apr 2022 13:51:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Marc Zyngier <maz@kernel.org>
Cc:     xieming <xieming@kylinos.cn>, sashal@kernel.org,
        catalin.marinas@arm.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        will@kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] kvm/arm64: fixed passthrough gpu into vm on arm64
Message-ID: <20220405165134.GS64706@ziepe.ca>
References: <20220401090828.614167-1-xieming@kylinos.cn>
 <87tubcbvgk.wl-maz@kernel.org>
 <20220404132405.GQ64706@ziepe.ca>
 <87o81gc3dc.wl-maz@kernel.org>
 <20220404170202.GR64706@ziepe.ca>
 <87mtgzblez.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtgzblez.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 04:27:16PM +0100, Marc Zyngier wrote:
> On Mon, 04 Apr 2022 18:02:02 +0100,
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Mon, Apr 04, 2022 at 03:47:11PM +0100, Marc Zyngier wrote:
> > > > I'm guessing it will turn into a SBSA like thing where the ARM ARM is
> > > > kind of vauge but a SOC has to implement Normal-NC in a certain way to
> > > > be functional for the server market.
> > > 
> > > The main issue is that this equivalence isn't architected, so people
> > > can build whatever they want. SBSA means nothing to KVM (or Linux at
> > > large), and there is currently no way to describe which devices are
> > > safe to map as Normal-NC vs Device.
> > 
> > And people have, we know of some ARM SOC's that don't work fully with
> > NORMAL_NC for this usage. That is already a problem for baremetal
> > Linux, let alone KVM..
> > 
> > That is why I likened it to SBSA - if you want to build a server SOC
> > that works with existing server software, you have to support
> > NORMAL_NC in this way. Even if it isn't architected.
> 
> I see it the other way around. If it isn't architected (and in this
> case not even detectable in a scalable way), it simply isn't
> supportable by SW.

Except the software already supports it. Catalin decided NORMAL_NC
would be how Linux works in 2014 in commit de2db7432917 ("arm64: Make
DMA coherent and strongly ordered mappings not executable")

There are 47 places under drivers/ that call pgprot_writecombine()
already, and if you make a "server" kind of chip you are likely to
encounter these drivers and must support them. Linux has created a
de-facto spec here.

While I agree the current situation in ARM64 is not nice and could be
improved, it has been supported by SW this way for a long time
already.

> > I didn't quite understand your other remarks though - is there a
> > problem here? It seems like yes from the other thread you pointed at?
> 
> The main issue is that we have no idea what the behaviour is on a
> given implementation, and no way to even detect that for a given
> device, NORMAL_NC is a memory type that won't cause any issue.

I agree with this, but that is a driver problem for calling
pgprot_writecombine() not a KVM problem. vfio is just another driver
in this sense.

We already have arch_can_pci_mmap_wc() which is a half attempt to
solve this problem, but ARM64 doesn't wire it up.

We've also gone far enough down this path for long enough that we
can't break all the existing systems that are working this way
already. So I expect any future accomodation would be some FW
indication that NORMAL_NC doesn't work for pgprot_writecombine(),
probably in DT and probably for an embedded focused chip. Maybe
combined with a quirk list of non-working CPU IDs or something.

Wire it up to arch_can_pci_mmap_wc() and you hvae something reasonable -
except that none of the 47 drivers actually use this call
today. Sigh.

Thanks,
Jason
