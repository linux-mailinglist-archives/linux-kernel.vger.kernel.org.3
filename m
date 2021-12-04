Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83511468373
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384390AbhLDJKq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 4 Dec 2021 04:10:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4194 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbhLDJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:10:45 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J5kLY3p0cz67gsl;
        Sat,  4 Dec 2021 17:05:41 +0800 (CST)
Received: from lhreml712-chm.china.huawei.com (10.201.108.63) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 4 Dec 2021 10:07:15 +0100
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 lhreml712-chm.china.huawei.com (10.201.108.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 4 Dec 2021 09:07:14 +0000
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2308.020;
 Sat, 4 Dec 2021 17:07:12 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Brice Goglin <Brice.Goglin@inria.fr>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        Len Brown <len.brown@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: RE: [PATCH v2 0/3] topology/sysfs: only export used sysfs attributes
Thread-Topic: [PATCH v2 0/3] topology/sysfs: only export used sysfs attributes
Thread-Index: AQHX5SHRAlmFSCd89Uy1sBtsuCn0LqwaA1gAgAS8PoCAAAFFAIADT7Qw
Date:   Sat, 4 Dec 2021 09:07:12 +0000
Message-ID: <60d13e6233df4aa78494bb51a2792bbe@hisilicon.com>
References: <20211129130309.3256168-1-hca@linux.ibm.com>
 <YaTdpsVCDQMlscON@hirez.programming.kicks-ass.net> <YajWjasdqnibSRJm@osiris>
 <YajXnjVGEWeUmEqA@kroah.com>
In-Reply-To: <YajXnjVGEWeUmEqA@kroah.com>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.91]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> Sent: Friday, December 3, 2021 3:27 AM
> To: Heiko Carstens <hca@linux.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>; Rafael J . Wysocki
> <rafael@kernel.org>; Andrew Morton <akpm@linux-foundation.org>;
> linux-kernel@vger.kernel.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
> Len Brown <len.brown@intel.com>; Thomas Richter <tmricht@linux.ibm.com>; Ian
> Rogers <irogers@google.com>
> Subject: Re: [PATCH v2 0/3] topology/sysfs: only export used sysfs attributes
> 
> On Thu, Dec 02, 2021 at 03:22:05PM +0100, Heiko Carstens wrote:
> > On Mon, Nov 29, 2021 at 03:03:18PM +0100, Peter Zijlstra wrote:
> > > On Mon, Nov 29, 2021 at 02:03:06PM +0100, Heiko Carstens wrote:
> > > > v2:
> > > > As requested by Greg KH: avoid negative logic and use uppercase defines.
> > > >
> > > > v1:
> > > > Create die and cluster cpu topology sysfs attributes only if an
> > > > architecture makes uses of it, instead of creating them always for all
> > > > architectures with bogus default values.
> > > > Also change the book and drawer cpu topology macros so they match all
> > > > all other topology macros.
> > > >
> > > > v1:
> https://lore.kernel.org/lkml/20211128212221.1069726-1-hca@linux.ibm.com/
> > > >
> > > > Heiko Carstens (3):
> > > >   topology/sysfs: export die attributes only if an architectures has
> support
> > > >   topology/sysfs: export cluster attributes only if an architectures has
> support
> > > >   topology/sysfs: rework book and drawer topology ifdefery
> > > >
> > > >  Documentation/admin-guide/cputopology.rst | 33 +++++++++++------------
> > > >  drivers/base/topology.c                   | 28 ++++++++++++++-----
> > > >  include/linux/topology.h                  | 25 +++++++++++++++++
> > > >  3 files changed, 62 insertions(+), 24 deletions(-)
> > >
> > > Seems entirely reasonable to me,
> > >
> > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > Since there seem to be no objections, who should pick this up?
> > I'd assume the s390 tree would not be appropriate.
> >
> > Andrew, Greg, Peter?
> 
> I will take it, thanks.

Could you give me one minute?

+Brice

I'd like to hear some feedbacks from hwloc if there
is a chance to break userspace and if userspace depends
on the existence of sysfs even though the topology
doesn't exist.

If no, I feel it is safe to take.

> 
> greg k-h

Thanks
Barry
