Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDB55B1DCA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiIHNAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiIHNAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:00:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC115AC62;
        Thu,  8 Sep 2022 06:00:14 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MNfJ52X97z688pK;
        Thu,  8 Sep 2022 20:56:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:00:12 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 8 Sep
 2022 14:00:12 +0100
Date:   Thu, 8 Sep 2022 14:00:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Davidlohr Bueso <dave@stgolabs.net>, <x86@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <akpm@linux-foundation.org>,
        <dave.jiang@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <a.manzanares@samsung.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <20220908140011.000003e8@huawei.com>
In-Reply-To: <6319916ba0f9d_5801629437@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220829212918.4039240-1-dave@stgolabs.net>
        <YxjBSxtoav7PQVei@nazgul.tnic>
        <20220907162245.5ddexpmibjbanrho@offworld>
        <6318cc415161f_166f2941e@dwillia2-xfh.jf.intel.com.notmuch>
        <YxlxAFgW65w8wgPy@nazgul.tnic>
        <6319916ba0f9d_5801629437@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2022 23:53:31 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Borislav Petkov wrote:
> > On Wed, Sep 07, 2022 at 09:52:17AM -0700, Dan Williams wrote:  
> > > To be clear nfit stuff and CXL does run in guests, but they do not
> > > support secure-erase in a guest.
> > > 
> > > However, the QEMU CXL enabling is building the ability to do *guest
> > > physical* address space management, but in that case the driver can be
> > > paravirtualized to realize that it is not managing host-physical address
> > > space and does not need to flush caches. That will need some indicator
> > > to differentiate virtual CXL memory expanders from assigned devices.  
> > 
> > Sounds to me like that check should be improved later to ask
> > whether the kernel is managing host-physical address space, maybe
> > arch_flush_memregion() should check whether the address it is supposed
> > to flush is host-physical and exit early if not...  
> 
> Even though I raised the possibility of guest passthrough of a CXL
> memory expander, I do not think it could work in practice without it
> being a gigantic security nightmare. So it is probably safe to just do
> the hypervisor check and assume that there's no such thing as guest
> management of host physical address space.

Agreed.  Other than occasional convenience of doing driver development
in a VM (they reboot quickly ;) can't see why a product system would need
to pass a CXL type 3 device through and as you say security would be 'interesting'
if it were done.  Might be GPU usecases down the line but I'm doubtful on that
as well.

Jonathan
