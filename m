Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD86F50B6A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447226AbiDVMAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447214AbiDVL77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:59:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753863ED01;
        Fri, 22 Apr 2022 04:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650628626; x=1682164626;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=una0KHCh52R2HL+UriGbWNcELDP4ksfAOACMj6FtIPs=;
  b=kRseLUuWngxFvBJCbWGiM35dNTXkOKhkUrVXVTgVBZ/QQPoGv0jqgqp6
   hmi9dZ2KS83qD8uwC1Y6Z91ZbgqICtj9dfcxFh5pfj/oBzm6CmmhJCbbM
   Kr+RLADYQeDAeC9cftg3pwWNEmfPb9MiP9uTiiEhr6O6TAKfvMrfk9PCs
   H986E/mkaD/YlpHoHUAIkleJE7rj3UmF0hunziFAW3hEUPvRJyxZpYaK4
   vsBMQIyCvDwwLbn2VvuKsDUyCtWvpdUNp1f7B3bsAbEPzZWNMYfAp4TvQ
   qwkkJg6o32XmUwBkACT6AYfvYs0mNKKvrAO2dSNLXJuB50ypJk46aDzD2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264132747"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="264132747"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 04:57:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="867560850"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 22 Apr 2022 04:57:04 -0700
To:     surong pang <surong.pang@gmail.com>
Cc:     mathias.nyman@intel.com, Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson.Zhai@unisoc.com, yunguo.wu@unisoc.com
References: <20220412122524.26966-1-surong.pang@gmail.com>
 <610871b2-1707-dfba-868f-4ddecc4d554d@linux.intel.com>
 <CAEDbmAT=fZ-kpn13sW4KjB9RuFb_6T4j_eripR54NZ3UciZfqA@mail.gmail.com>
 <d6df23a0-6539-f955-5241-5cdfcaa4eca4@linux.intel.com>
 <CAEDbmAT3SoSsEmTkELSYoykGN+AuPgi2N11V2YwKuaC3nKMEmQ@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH V1 1/1] usb/host: Let usb phy shutdown later
Message-ID: <e05ec742-c3dc-df7c-c5d7-29358d0a7081@linux.intel.com>
Date:   Fri, 22 Apr 2022 14:59:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAEDbmAT3SoSsEmTkELSYoykGN+AuPgi2N11V2YwKuaC3nKMEmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.4.2022 13.43, surong pang wrote:
>>>> @@ -398,6 +397,7 @@ static int xhci_plat_remove(struct platform_device *dev)
>>>>       clk_disable_unprepare(clk);
>>>>       clk_disable_unprepare(reg_clk);
>>>> +    usb_phy_shutdown(hcd->usb_phy);
>>>>       usb_put_hcd(hcd);
> 
> Is it ok to put usb_phy_shutdown before usb_put_hcd(hcd)? hcd is
> released at usb_put_hcd.

yes, above looks good.

> 
> UNISOC DWC3 phy is not divided  USB 2.0/3.0 phy clearly.  Yes, it's
> UNISOC's issue.
> It UNISOC's dtsi: phys = <&ssphy>, <&ssphy>;
> If to shutdown phy too earlier,  it will cost 10s timeout to do xhci_reset.
> usb_remmove_hcd  --> usb_stop_hcd --> xhci_stop --> xhci_reset  -->
> xhci_handshake(&xhci->op_regs->command, CMD_RESET, 0, 10 * 1000 *1000)
> 
> I want to know this change is acceptable or not?
> 
> hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
> Why in xhci_plat_remove, just to shutdown "usb-phy"[0], not to
> shutdown "usb-phy"[1] ?

xhci-plat.c only takes one phy at index 0, so we only shutdowns that one.

Looks like usb core hcd code has better phy handling when adding and
removing hcds. It supports multiple phys.
If possible use that instead.

See drivers/usb/core/hcd.c usb_add_hcd()

Thanks
-Mathias
