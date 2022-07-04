Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBC5565164
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiGDJyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiGDJyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:54:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411ABD12F;
        Mon,  4 Jul 2022 02:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656928447; x=1688464447;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lSh2EbbxhUgUat8Nrxc/d9fNoMjhwQg9R6qR3jGL+Ug=;
  b=etdLVxMjDFb/UKPjtQGcTIFJFAjSwOPkNzXL8uLd++krQc0HvSKUpAVL
   WaSf//U9/U223LyZcJ0gMTpv6au4MAdy2wgxb0SQbya7bKqrNR9l82DKO
   Ae5ZyD02T1Bq6IOXT7C5ZLND3zBgs6bxnu/WOkHad1Gh6ltRnx59I8xHt
   eSFb1XwNwW0YGJtqHRof36MocKARPSJcoLsIbzg1mCIQWh4PpUSW9NPTW
   rjS3+So51Dv+0UUT0OKKboYPO0CCSY7kajBmoJQJfQE0WKD+DLleUHSqY
   dgYc0c9hh+h/NjVr1+MBPDIzZKHy3EeX+pNHj7fxnyf/fsKxNjDB1LXw4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="263511023"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="263511023"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 02:54:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="649512912"
Received: from bclindho-mobl.ger.corp.intel.com ([10.252.49.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 02:54:01 -0700
Date:   Mon, 4 Jul 2022 12:53:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v2 7/9] serial: ar933x: Fix check for RS485 support
In-Reply-To: <e000058a-0f19-a598-9fba-b745a2f2bca5@gmx.de>
Message-ID: <f7c9acb6-ce8c-bd3-df12-f240115c6dbb@linux.intel.com>
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de> <20220703170039.2058202-8-LinoSanfilippo@gmx.de> <CAHp75VfTYv51ZcBJHR3Ms9HQWjPccigrjUxHUq4NixKXdvm5Ew@mail.gmail.com> <e000058a-0f19-a598-9fba-b745a2f2bca5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2022, Lino Sanfilippo wrote:
> On 03.07.22 20:39, Andy Shevchenko wrote:
> > On Sun, Jul 3, 2022 at 7:02 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:
> >>
> >> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >>
> >> Without an RTS GPIO RS485 is not possible so disable the support
> >> regardless of whether RS485 is enabled at boottime or not. Also remove the
> >
> > boot time
> >
> >> now superfluous check for the RTS GPIO in ar933x_config_rs485().
> >>
> >> Fixes: e849145e1fdd ("serial: ar933x: Fill in rs485_supported")
> >
> > Is it an independent fix? If so, it should be the first patch in the
> > series, otherwise if it's dependent on something from previous patches
> > you need to mark all of them as a fix.
> >
> 
> The fix is independent, patch 8 depends on the fix however. I was not
> aware of this fixes-first rule for series with patches that are independent
> from each other. I will change the order accordingly in the next version of the series.

While at it, you could separate just the fix to own patch and the 
->rs485_config() cleanup to own patch (or move it all to patch 8).

Not that this fix is expected to go anywhere else besides tty-next.

-- 
 i.

