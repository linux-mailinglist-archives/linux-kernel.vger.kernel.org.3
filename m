Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5111A50B209
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445064AbiDVHyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445055AbiDVHyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:54:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED63A17077;
        Fri, 22 Apr 2022 00:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650613883; x=1682149883;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+KCrvW2z8lWJkXBe8aezktIGhnAcOO2jOGN6FQ83m3w=;
  b=kRTcD0YRMTAxeuNpNu+N2El8Lsd1Bo4fee621gg5PaAKr713aPNnWx8k
   2Cky25i7QdDD3LjhMY95SJA6dYV61QgxWdPQvU0fH9F/qVkRuvpRSMeeR
   99bEuuPjETldLGtHYWsv9UPJiDusDxDdGYbHeuqcoHaGLf9uZGooMP0BQ
   H9qQpzmjxYU3RU2c/6Kdkx2cLuDczdyAtRopCImY9VNNP1gtlo4i8cIDZ
   zyTuINsewAkPWLsuolD9XCPWLcGPCCoi1vHHeGY03R7i5M1GnNIt3SVza
   upBpWz+9axxskE9UQFf5z7Vyy1bq+GPtXry1jcNoe0Hd7tcMGprKhIVL/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264082084"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="264082084"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 00:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="867284575"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 22 Apr 2022 00:51:20 -0700
To:     surong pang <surong.pang@gmail.com>
Cc:     mathias.nyman@intel.com, Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson.Zhai@unisoc.com, yunguo.wu@unisoc.com
References: <20220412122524.26966-1-surong.pang@gmail.com>
 <610871b2-1707-dfba-868f-4ddecc4d554d@linux.intel.com>
 <CAEDbmAT=fZ-kpn13sW4KjB9RuFb_6T4j_eripR54NZ3UciZfqA@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH V1 1/1] usb/host: Let usb phy shutdown later
Message-ID: <d6df23a0-6539-f955-5241-5cdfcaa4eca4@linux.intel.com>
Date:   Fri, 22 Apr 2022 10:53:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAEDbmAT=fZ-kpn13sW4KjB9RuFb_6T4j_eripR54NZ3UciZfqA@mail.gmail.com>
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

On 22.4.2022 5.10, surong pang wrote:
> shared_hcd might be freed already here, but hcd should not be freed
> here, because "usb_put_hcd(hcd)" is called later.

To me it still looks like this patch calls usb_phy_shutdown(hcd->usb_phy) _after_
usb_put_hcd(hcd):

>>> @@ -398,6 +397,7 @@ static int xhci_plat_remove(struct platform_device *dev)
>>>       clk_disable_unprepare(clk);
>>>       clk_disable_unprepare(reg_clk);
>>>       usb_put_hcd(hcd);
>>> +     usb_phy_shutdown(hcd->usb_phy);


shared hcd was freed even earlier, before disabling the clocks.

Thanks
Mathias
