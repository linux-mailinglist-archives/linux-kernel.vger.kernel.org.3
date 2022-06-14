Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B26954B6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244068AbiFNQq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbiFNQqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:46:14 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6B52873A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:46:13 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EERFwO016304;
        Tue, 14 Jun 2022 16:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=c/mGQYyH64LdoDFhU05O3rfDC3bitl+utkDc5Vh3EII=;
 b=IHQX2r8mZrORY+cTNxPEAllFkdka8hZs2cs6AhjK1lWaxLeTw5QhLsDYV6QaeOQxHn+1
 xFqyDZFGwkqBfvksfpMFhaIfOSOF7rNO/XwcjuMVlZBxz0OeGpEQuUYZskxVB8Z5vNT2
 SyqevsYxlNGqy7bNN7GAzyV2j5mXTshp2JOshTejUnrcrldgEFWVLzuC2iC6JwkllZTu
 LWdc+wUNX8qFe0iJDgTa2VfYfTGVTvRbLCcAUi2rFcJF8EfQ6Pt+age+dnVq2bzf69f6
 4+5njFUWWZslEkjhXozBscw3cinTBRbDKI4t1drtBkMCQktgwa92mNgCGExipn5322a5 sg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3gpv3yhanw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 16:45:40 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 1DC951305C;
        Tue, 14 Jun 2022 16:45:40 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id BFF91809406;
        Tue, 14 Jun 2022 16:45:37 +0000 (UTC)
Date:   Tue, 14 Jun 2022 11:45:35 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>,
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
Message-ID: <Yqi7L9A/ADXpIvN6@swahl-home.5wahls.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613205734.3x7i46bnsofzerr4@cantor>
 <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
 <CALzcddsXciFgKOLSkXxx4Rv_rwh21qe8hkyiEET280D8orP6Vw@mail.gmail.com>
 <9c943703-0c2f-b654-a28b-f594bf90bec9@linux.intel.com>
 <CALzcdduU-baVF9VV-NnYD2rKn0YC5hzS_F9udExRE7guvMqXWg@mail.gmail.com>
 <616dc81c-dfc6-d6c6-1eab-de0e9ba4411f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <616dc81c-dfc6-d6c6-1eab-de0e9ba4411f@linux.intel.com>
X-Proofpoint-GUID: Mnk8mUUTJERwXg3WxPeW3Aw3D2E_RuVw
X-Proofpoint-ORIG-GUID: Mnk8mUUTJERwXg3WxPeW3Aw3D2E_RuVw
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_06,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140063
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:21:29AM +0800, Baolu Lu wrote:
> On 2022/6/14 09:54, Jerry Snitselaar wrote:
> > On Mon, Jun 13, 2022 at 6:51 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
> > > 
> > > On 2022/6/14 09:44, Jerry Snitselaar wrote:
> > > > On Mon, Jun 13, 2022 at 6:36 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
> > > > > On 2022/6/14 04:57, Jerry Snitselaar wrote:
> > > > > > On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> > > > > > > To support up to 64 sockets with 10 DMAR units each (640), make the
> > > > > > > value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> > > > > > > CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> > > > > > > set.
> > > > > > > 
> > > > > > > If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> > > > > > > to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> > > > > > > allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> > > > > > > remapping doesn't support X2APIC mode x2apic disabled"; and the system
> > > > > > > fails to boot properly.
> > > > > > > 
> > > > > > > Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
> > > > > > > ---
> > > > > > > 
> > > > > > > Note that we could not find a reason for connecting
> > > > > > > DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> > > > > > > it seemed like the two would continue to match on earlier processors.
> > > > > > > There doesn't appear to be kernel code that assumes that the value of
> > > > > > > one is related to the other.
> > > > > > > 
> > > > > > > v2: Make this value a config option, rather than a fixed constant.  The default
> > > > > > > values should match previous configuration except in the MAXSMP case.  Keeping the
> > > > > > > value at a power of two was requested by Kevin Tian.
> > > > > > > 
> > > > > > >     drivers/iommu/intel/Kconfig | 6 ++++++
> > > > > > >     include/linux/dmar.h        | 6 +-----
> > > > > > >     2 files changed, 7 insertions(+), 5 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> > > > > > > index 247d0f2d5fdf..fdbda77ac21e 100644
> > > > > > > --- a/drivers/iommu/intel/Kconfig
> > > > > > > +++ b/drivers/iommu/intel/Kconfig
> > > > > > > @@ -9,6 +9,12 @@ config DMAR_PERF
> > > > > > >     config DMAR_DEBUG
> > > > > > >        bool
> > > > > > > 
> > > > > > > +config DMAR_UNITS_SUPPORTED
> > > > > > > +    int "Number of DMA Remapping Units supported"
> > > > > > Also, should there be a "depends on (X86 || IA64)" here?
> > > > > Do you have any compilation errors or warnings?
> > > > > 
> > > > > Best regards,
> > > > > baolu
> > > > > 
> > > > I think it is probably harmless since it doesn't get used elsewhere,
> > > > but our tooling was complaining to me because DMAR_UNITS_SUPPORTED was
> > > > being autogenerated into the configs for the non-x86 architectures we
> > > > build (aarch64, s390x, ppcle64).
> > > > We have files corresponding to the config options that it looks at,
> > > > and I had one for x86 and not the others so it noticed the
> > > > discrepancy.
> > > 
> > > So with "depends on (X86 || IA64)", that tool doesn't complain anymore,
> > > right?
> > > 
> > > Best regards,
> > > baolu
> > > 
> > 
> > Yes, with the depends it no longer happens.
> 
> The dmar code only exists on X86 and IA64 arch's. Adding this depending
> makes sense to me. I will add it if no objections.

I think that works after Baolu's patchset that makes intel-iommu.h
private.  I'm pretty sure it wouldn't have worked before that.

No objections.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise
