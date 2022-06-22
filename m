Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B960B554EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359302AbiFVPLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359153AbiFVPLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:11:40 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD173E0E1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:11:39 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MEiubJ001259;
        Wed, 22 Jun 2022 15:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=OedAOhst26QfWtP8BHOkw2gDpxpg/uYyrOKM+3cYtVw=;
 b=Y9gvDzQBmhf9mWP03Tvwl4wQrUBiDwOMrqNf4k0k9QVeTGlCcA+aKk5bfla2C8mtTc3j
 qUB4FiCcSTLf+w4VgTZp8zjNN5dlPF9IdCpvBywUqdXcg2FCBGzFzyjI77uNwwyERaeb
 7O3WPh5Zsz7XiNrB/jegQKnmXtsO7om5TxFASZAjiije5skbjsAKDOHpyAabbTgk0l5S
 vMljznYy1OvLpQ/ADiEWqONtPr7mHAJyTjjNXtksY9xfsQyrRWYWLSHYZG3I944JefH9
 nvDwYRjmw/V93PpawZKYwG3x0vPBCuu/dkl5P+RMaNIdCmNp28Q8OS2ahQ7h1snLKc4d Wg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3gv542889c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 15:11:07 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 5263812EA4;
        Wed, 22 Jun 2022 15:11:06 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 74E7E804D05;
        Wed, 22 Jun 2022 15:11:04 +0000 (UTC)
Date:   Wed, 22 Jun 2022 10:11:02 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Message-ID: <YrMxBt9ZUe+T+wXV@swahl-home.5wahls.com>
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
 <20220615183650.32075-1-steve.wahl@hpe.com>
 <96984350-3a04-812a-60f1-a09138014fac@linux.intel.com>
 <CALzcdduhpOebY18hiOpMcXLcH83bY_u4fZT09pBcoz2ObqXnGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzcdduhpOebY18hiOpMcXLcH83bY_u4fZT09pBcoz2ObqXnGg@mail.gmail.com>
X-Proofpoint-GUID: RMIDAG1JjmqcHeyGTgot2wm1c55FpcUd
X-Proofpoint-ORIG-GUID: RMIDAG1JjmqcHeyGTgot2wm1c55FpcUd
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_04,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220076
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 08:05:12AM -0700, Jerry Snitselaar wrote:
> On Wed, Jun 22, 2022 at 7:52 AM Baolu Lu <baolu.lu@linux.intel.com> wrote:
> >
> > On 2022/6/16 02:36, Steve Wahl wrote:
> > > To support up to 64 sockets with 10 DMAR units each (640), make the
> > > value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> > > CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> > > set.
> > >
> > > If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> > > to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> > > allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> > > remapping doesn't support X2APIC mode x2apic disabled"; and the system
> > > fails to boot properly.
> > >
> > > Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
> > > Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> > > ---
> > >
> > > Note that we could not find a reason for connecting
> > > DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> > > it seemed like the two would continue to match on earlier processors.
> > > There doesn't appear to be kernel code that assumes that the value of
> > > one is related to the other.
> > >
> > > v2: Make this value a config option, rather than a fixed constant.  The default
> > > values should match previous configuration except in the MAXSMP case.  Keeping the
> > > value at a power of two was requested by Kevin Tian.
> > >
> > > v3: Make the config option dependent upon DMAR_TABLE, as it is not used without this.
> > >
> > >   drivers/iommu/intel/Kconfig | 7 +++++++
> > >   include/linux/dmar.h        | 6 +-----
> > >   2 files changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> > > index 39a06d245f12..07aaebcb581d 100644
> > > --- a/drivers/iommu/intel/Kconfig
> > > +++ b/drivers/iommu/intel/Kconfig
> > > @@ -9,6 +9,13 @@ config DMAR_PERF
> > >   config DMAR_DEBUG
> > >       bool
> > >
> > > +config DMAR_UNITS_SUPPORTED
> > > +     int "Number of DMA Remapping Units supported"
> > > +     depends on DMAR_TABLE
> > > +     default 1024 if MAXSMP
> > > +     default 128  if X86_64
> > > +     default 64
> >
> > With this patch applied, the IOMMU configuration looks like:
> >
> > [*]   AMD IOMMU support
> > <M>     AMD IOMMU Version 2 driver
> > [*]     Enable AMD IOMMU internals in DebugFS
> > (1024) Number of DMA Remapping Units supported   <<<< NEW
> > [*]   Support for Intel IOMMU using DMA Remapping Devices
> > [*]     Export Intel IOMMU internals in Debugfs
> > [*]     Support for Shared Virtual Memory with Intel IOMMU
> > [*]     Enable Intel DMA Remapping Devices by default
> > [*]     Enable Intel IOMMU scalable mode by default
> > [*]   Support for Interrupt Remapping
> > [*]   OMAP IOMMU Support
> > [*]     Export OMAP IOMMU internals in DebugFS
> > [*]   Rockchip IOMMU Support
> >
> > The NEW item looks confusing. It looks to be a generic configurable
> > value though it's actually Intel DMAR specific. Any thoughts?
> >
> > Best regards,
> > baolu
> >
> 
> Would moving it under INTEL_IOMMU at least have it show up below
> "Support for Intel IOMMU using DMA Remapping Devices"? I'm not sure it
> can be better than that, because IRQ_REMAP selects DMAR_TABLE, so we
> can't stick it in the if INTEL_IOMMU section.
> 
> Regards,
> Jerry

I have no qualms with Jerry's suggestion.

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
