Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474F04B225B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbiBKJnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:43:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbiBKJno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:43:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64119BAA;
        Fri, 11 Feb 2022 01:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644572623; x=1676108623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Eh9Z93+yZv5XOHb7IgsvkTr/sEayd5z0XxqtOJiX+Zs=;
  b=Qg0ciy6tfvNAox27F16h4kAxRaCJqg7Yeqh/R+gooXswh63KpKOJyV3z
   lmJxOWP0sT+Ewe0omWQltAZQbfkPyfUrM6COPqns1mwTdECRZSB3HKRWR
   T/B+5IZGNR0eAKA5dKqAxVye8V0lWuUoFysEc4+gz6BxmDmtPYfehQGxU
   rnf0TcmHd3dBltJhxmv9liBJNV/bosns2b1/c1gCCLBl5xewv1bNyJNN2
   QcyPkpXMt1P5DCDsaL7SIE0SVGoAb502K8W5U2kdkZujyu4JxzuBGq1Wz
   0FJor//O7ybgqP4E9EQz+kfPZbooMRx0CLJgo2NSaEhdQlOktANcK6nqa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="274257827"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="274257827"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 01:43:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="542023981"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 01:43:40 -0800
Date:   Fri, 11 Feb 2022 09:43:32 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Wojciech Ziemba <wojciech.ziemba@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com
Subject: Re: [PATCH 0/3] Introduce support for QAT Dynamic Power Management
Message-ID: <YgYvxEwX7k5MOsqm@silpixa00400314>
References: <20220203135434.584967-1-wojciech.ziemba@intel.com>
 <YgYt5tFt+0CD/0V3@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgYt5tFt+0CD/0V3@gondor.apana.org.au>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Fri, Feb 11, 2022 at 08:35:34PM +1100, Herbert Xu wrote:
> On Thu, Feb 03, 2022 at 01:54:31PM +0000, Wojciech Ziemba wrote:
> > This patch set consist of following updates:
> > 1. Add misc workqueue for general purpose usage.
> > 2. Move error source related CSRs from 4xxx to the wider GEN4 header
> > file.
> > 3. Add support for HW QAT Power Management (PM) feature.
> > 	This feature is enabled at init time (1) by sending an admin
> > message to
> > 	the firmware, targeting the admin AE, that sets the idle time
> > before
> > 	the device changes state and (2) by unmasking the PM source of
> > 	interrupt in ERRMSK2.
> > 
> > 	The interrupt handler is extended to handle a PM interrupt which
> > 	is triggered by HW when a PM transition occurs. In this case,
> > the
> > 	driver responds acknowledging the transaction using the HOST_MSG
> > 	mailbox.
> > 
> > 
> > Wojciech Ziemba (3):
> >   crypto: qat - add misc workqueue
> >   crypto: qat - move and rename GEN4 error register definitions
> >   crypto: qat - enable power management for QAT GEN4
> > 
> >  .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.c    |  21 +--
> >  .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.h    |  24 ---
> >  drivers/crypto/qat/qat_common/Makefile        |   1 +
> >  .../crypto/qat/qat_common/adf_accel_devices.h |   2 +
> >  drivers/crypto/qat/qat_common/adf_admin.c     |  37 +++++
> >  .../crypto/qat/qat_common/adf_common_drv.h    |   4 +
> >  drivers/crypto/qat/qat_common/adf_ctl_drv.c   |   6 +
> >  .../crypto/qat/qat_common/adf_gen4_hw_data.h  |  14 ++
> >  drivers/crypto/qat/qat_common/adf_gen4_pm.c   | 137 ++++++++++++++++++
> >  drivers/crypto/qat/qat_common/adf_gen4_pm.h   |  44 ++++++
> >  drivers/crypto/qat/qat_common/adf_init.c      |   6 +
> >  drivers/crypto/qat/qat_common/adf_isr.c       |  42 ++++++
> >  .../qat/qat_common/icp_qat_fw_init_admin.h    |   1 +
> >  13 files changed, 306 insertions(+), 33 deletions(-)
> >  create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_pm.c
> >  create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_pm.h
> 
> All applied.  Thanks.
I think this set needs to be reverted. Wojciech provided a v2 that fixed
a few regressions.

Thanks,

-- 
Giovanni
