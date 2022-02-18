Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE284BB184
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 06:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiBRFh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 00:37:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiBRFhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:37:52 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638F5113DA6;
        Thu, 17 Feb 2022 21:37:34 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nKvxT-0005Dm-5s; Fri, 18 Feb 2022 16:37:32 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Feb 2022 16:37:31 +1100
Date:   Fri, 18 Feb 2022 16:37:31 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Wojciech Ziemba <wojciech.ziemba@intel.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com
Subject: Re: [PATCH v2 0/3] Introduce support for QAT Dynamic Power Management
Message-ID: <Yg8wmyvL2f/UZJbu@gondor.apana.org.au>
References: <20220210133827.2366901-1-wojciech.ziemba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210133827.2366901-1-wojciech.ziemba@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 01:38:24PM +0000, Wojciech Ziemba wrote:
> This patch set consist of following updates:
> 1. Add misc workqueue for general purpose usage.
> 2. Move error source related CSRs from 4xxx to the wider GEN4 header
> file.
> 3. Add support for HW QAT Power Management (PM) feature.
>         This feature is enabled at init time (1) by sending an admin
> message to
>         the firmware, targeting the admin AE, that sets the idle time
> before
>         the device changes state and (2) by unmasking the PM source of
>         interrupt in ERRMSK2.
> 
>         The interrupt handler is extended to handle a PM interrupt which
>         is triggered by HW when a PM transition occurs. In this case,
> the
>         driver responds acknowledging the transaction using the HOST_MSG
>         mailbox.
> 
> Changes since v1:
> - Moved unmasking PM interrupts after PM interrupt source enable to
>   avoid a spurious interrupt
> - Fixed kbuild bot issue by moving adf_handle_pm_int() out of
>   CONFIG_PCI_IOV scope
> - Rename [..]_init_pm() functions to [..]_enable_pm() as the function
>   needs to be called inside adf_start()
> 
> 
> Wojciech Ziemba (3):
>   crypto: qat - add misc workqueue
>   crypto: qat - move and rename GEN4 error register definitions
>   crypto: qat - enable power management for QAT GEN4
> 
>  .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.c    |  21 +--
>  .../crypto/qat/qat_4xxx/adf_4xxx_hw_data.h    |  24 ---
>  drivers/crypto/qat/qat_common/Makefile        |   1 +
>  .../crypto/qat/qat_common/adf_accel_devices.h |   2 +
>  drivers/crypto/qat/qat_common/adf_admin.c     |  37 +++++
>  .../crypto/qat/qat_common/adf_common_drv.h    |   4 +
>  drivers/crypto/qat/qat_common/adf_ctl_drv.c   |   6 +
>  .../crypto/qat/qat_common/adf_gen4_hw_data.h  |  14 ++
>  drivers/crypto/qat/qat_common/adf_gen4_pm.c   | 137 ++++++++++++++++++
>  drivers/crypto/qat/qat_common/adf_gen4_pm.h   |  44 ++++++
>  drivers/crypto/qat/qat_common/adf_init.c      |   6 +
>  drivers/crypto/qat/qat_common/adf_isr.c       |  42 ++++++
>  .../qat/qat_common/icp_qat_fw_init_admin.h    |   1 +
>  13 files changed, 306 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_pm.c
>  create mode 100644 drivers/crypto/qat/qat_common/adf_gen4_pm.h

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
