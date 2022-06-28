Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29F255DE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbiF1Ks6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344462AbiF1Ksw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:48:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E39658A;
        Tue, 28 Jun 2022 03:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656413331; x=1687949331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ptcD6+9L6Uc64INfHZb7G/54OdogEMb3mGD+2gOtS3A=;
  b=LXdVu/hneuejkoY8rzFlOY/oxLv2j8mtxjjk75bz8zWSLSUss0BOvCAk
   gaqT8cSzuJwE7NBLQzNV4gdrrGyJFFACBu5xH0wPIVS2ISgwLRaONORpT
   0rMZvAs86EaOhpYhlaDcpQAX5MBC5ZuN+4XK+D3I+D326fqLbc+QNDBXl
   02ew6lu96qPTMoCMudImwQJqO2qb67UPZv0P6sDRSV7fuIpDbK2x2iAbW
   1sH5/08OG3oeofxBhYpUrd3EyE0AiyBK//EkxxYRD821puT2ilVgQql3K
   3H+HpIJFmkaGU4SOXb5F8TNaDpYX3IvXbAdVb5VhcI6kOp2MXuQxNioEV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="261510549"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="261510549"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="732706109"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 28 Jun 2022 03:48:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 28 Jun 2022 13:48:47 +0300
Date:   Tue, 28 Jun 2022 13:48:47 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v12 3/3] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <Yrrcj5rnP8y4mjqQ@kuha.fi.intel.com>
References: <20220628044843.2257885-1-xji@analogixsemi.com>
 <20220628044843.2257885-3-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628044843.2257885-3-xji@analogixsemi.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 28, 2022 at 12:48:42PM +0800, Xin Ji wrote:
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> new file mode 100644
> index 000000000000..76e4b5fc0d9e
> --- /dev/null
> +++ b/drivers/usb/typec/anx7411.c
> @@ -0,0 +1,1564 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright(c) 2022, Analogix Semiconductor. All rights reserved.
> + *
> + */

Could you also add a line to that comment that tells what this driver
is? So something like this:

/*
 * Driver for Analogix ANX7411 USB Type-C and PD controller
 *
 * Copyright(c) 2022, Analogix Semiconductor. All rights reserved.
 */

thanks,

-- 
heikki
