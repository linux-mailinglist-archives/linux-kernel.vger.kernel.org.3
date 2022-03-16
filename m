Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7774DBAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiCPWYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 18:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiCPWYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:24:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867A113F76
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647469409; x=1679005409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4l2wtAnqIaSrxTx4a8Iz1qlZB3MxdUypqpSLj9uN4UI=;
  b=dG9QCxYDCWzYt8VlxFUwACji0+tmUUImMp34pFJL8av/OoH9OeeXaPUO
   xpcBV7U7ZNYsyFxwDVMiPEX7ZLQfR2xpVcDG2f0YAjH0Yd0qFAONIktjW
   7HIzOmAmZgiJS7LeIMhKr5x3ZjuocWyYiZJ2//6iepU3x996wgFXwIzA9
   DPl/0rfuLI0Ymq8YNfPwxw0IycQawgTDD4y/Xv/bo+QLVu98q7MJ0PFI8
   85OjYdA0qnrtsnl8G07jovW6FcmD3NmDrKdqMw5E0cLRzEo9bAVrMYd6Z
   vc7rCn58ByLxy+B7HLmEt9C6EL49KQA3/5M/KolscT1EtmvlUaIqCNgot
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256452652"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256452652"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="498609298"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 16 Mar 2022 15:23:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 15:23:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 15:23:27 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.021;
 Wed, 16 Mar 2022 15:23:27 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Topic: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Index: AQHYOCoVItg7zFudxUWnMbj/fRutSKzA+EIAgACG8QCAAAf/gIABbKUAgAAX9gD//4u9gA==
Date:   Wed, 16 Mar 2022 22:23:26 +0000
Message-ID: <17d73d88e08047f09636cf39edd69892@intel.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com> <20220315153620.710a30fa@jacob-builder>
 <20220315230457.GO11336@nvidia.com> <20220316135004.61ae1611@jacob-builder>
 <20220316221550.GS11336@nvidia.com>
In-Reply-To: <20220316221550.GS11336@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I would expect real applications will try to use the same PASID for
> the same IOVA map to optimize IOTLB caching.

On Intel a ring3 application only gets to use one PASID.

The ENQCMD instruction pick up the PASID for the process
from the IA32_PASID MSR (set by OS when first access,
and on context switches thereafter).

Kernel users (ring0) can supply any PASID when they use
the ENQCMDS instruction. Is that what you mean when you
say "real applications"?

-Tony
