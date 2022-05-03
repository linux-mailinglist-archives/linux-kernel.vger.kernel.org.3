Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBBD518438
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiECM2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbiECM2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:28:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C83A344EC;
        Tue,  3 May 2022 05:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651580672; x=1683116672;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ezDP8VhxvFVapCaHLcnpQwxSE8jZ53x6V8Z6T9fWMdc=;
  b=RI3YRcIAE6o8G9PIPKa+pIAiZr3ZSl4L/IGdqL/ANr+RSgBL+h0wJZUD
   ZM4HkPOSSSrdqen3cjCFvI8W/c8Sv+QVTJdCm4PAj7OT7UATzmSl9BV4P
   P88PVdJqwW0W+RPcqIg//Rf3Ybb22picmjLR8RQdLFoWXypukeau34FuA
   GyfHqcfYeRenL0reR4/2VhfRG9A8+OhGeK9d+u7NZ/LcqBjmnAMgTg/kZ
   9Jds+oMgajnvAnr2r2RafTORUU5ADMJtj7PoV0tFDQ0AbzV8tBny692ja
   nEXeJvIDmnrduo/ODoJNQ8l/9IYQp7awzzrMqkyNFcdSRl7Uwovy+uzYd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="328004739"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="328004739"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 05:24:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="584176810"
Received: from oelagadx-mobl2.ger.corp.intel.com ([10.252.60.48])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 05:24:29 -0700
Date:   Tue, 3 May 2022 15:24:23 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] serial: 8250: core: Remove unneeded
 <linux/pm_runtime.h>
In-Reply-To: <2545eaa7fc552013a5d04c4df027255204e64834.1651494971.git.geert+renesas@glider.be>
Message-ID: <c0144ed6-811e-bc2d-7bff-91e7c4ba855@linux.intel.com>
References: <2545eaa7fc552013a5d04c4df027255204e64834.1651494971.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2022, Geert Uytterhoeven wrote:

> The last calls into Runtime PM were moved to 8250_port.c a long time
> ago.
> 
> Fixes: b6830f6df8914faa ("serial: 8250: Split base port operations from universal driver")

Does this really "fix" something or is it just a useful cleanup? To me it 
looks the latter.

-- 
 i.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/8250/8250_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 01d30f6ed8fb5931..cfbd2de0ca6e4bcd 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -32,7 +32,6 @@
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/io.h>
>  #ifdef CONFIG_SPARC
>  #include <linux/sunserialcore.h>
> 
