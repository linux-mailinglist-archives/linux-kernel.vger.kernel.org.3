Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE9508915
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378915AbiDTNVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242970AbiDTNVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:21:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4757F42A11;
        Wed, 20 Apr 2022 06:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650460740; x=1681996740;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=E9RTNBXOoMcT8m9LfR3nKt3g7nqLHXacsFd0iJAtk8s=;
  b=grYJ0Elp/nDOrtMJNahoNH5gOm4UvEE5UIRTpAm+hsuzH8o374d2QS7t
   5RBVUlimRkf3t2IuTfZ2NB9DAEDmYelFFlWDKJicuRHl+BQPKtXjRGIQA
   3WRaVoCBESt71M/MfGf1urQL3fIypaQAGeqTBI5+QF0DiqdksVPw2bNZA
   IZ4NA0EcnfDxY0/6WhM8CgUSEyPR+UXbS20dCizRW9bWZNEMtAFDXgwUb
   7z2QzTupUepR55uS/6h+tPLpZpZnF6MlZS666udkKN5cCjHTMI+x+miCB
   Ivk6YQbvGUHIfpx/TABFBV2CwSKWhiCNCRJLO0x11qblui8XsNFxnqvqX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="243954024"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="243954024"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 06:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="727490441"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 20 Apr 2022 06:18:55 -0700
To:     "Sandeep Maheswaram (Temp) (QUIC)" <quic_c_sanm@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pavan Kumar Kondeti (QUIC)" <quic_pkondeti@quicinc.com>,
        "Pratham Pratap (QUIC)" <quic_ppratap@quicinc.com>,
        "Krishna Kurapati PSSNV (QUIC)" <quic_kriskura@quicinc.com>,
        "Vidya Sagar Pulyala (Temp) (QUIC)" <quic_vpulyala@quicinc.com>
References: <1649323888-12420-1-git-send-email-quic_c_sanm@quicinc.com>
 <DM6PR02MB4857A0ADCDA1558DE58E103ADFF29@DM6PR02MB4857.namprd02.prod.outlook.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v3 0/2] Skip phy initialization for DWC3 USB Controllers
Message-ID: <4b34735f-8e1f-bf37-398f-9b4a8aa2e939@linux.intel.com>
Date:   Wed, 20 Apr 2022 16:20:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DM6PR02MB4857A0ADCDA1558DE58E103ADFF29@DM6PR02MB4857.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.4.2022 13.17, Sandeep Maheswaram (Temp) (QUIC) wrote:
> Hi Mathias, Felipe,
> 
>> -----Original Message-----
>> From: Sandeep Maheswaram (Temp) (QUIC) <quic_c_sanm@quicinc.com>
>> Sent: Thursday, April 7, 2022 3:01 PM
>> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Felipe Balbi
>> <balbi@kernel.org>; Stephen Boyd <swboyd@chromium.org>; Doug
>> Anderson <dianders@chromium.org>; Matthias Kaehlcke
>> <mka@chromium.org>; Mathias Nyman <mathias.nyman@intel.com>
>> Cc: linux-arm-msm@vger.kernel.org; linux-usb@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Pavan Kumar Kondeti (QUIC)
>> <quic_pkondeti@quicinc.com>; Pratham Pratap (QUIC)
>> <quic_ppratap@quicinc.com>; Krishna Kurapati PSSNV (QUIC)
>> <quic_kriskura@quicinc.com>; Vidya Sagar Pulyala (Temp) (QUIC)
>> <quic_vpulyala@quicinc.com>; Sandeep Maheswaram (Temp) (QUIC)
>> <quic_c_sanm@quicinc.com>
>> Subject: [PATCH v3 0/2] Skip phy initialization for DWC3 USB Controllers
>>
>> Runtime suspend of phy drivers was failing from DWC3 driver as runtime
>> usage value is 2 because the phy is initialized from
>> DWC3 core and HCD core.
>> Some controllers like DWC3 and CDNS3 manage phy in their core drivers.
>> This property can be set to avoid phy initialization in HCD core.
>>
>> v3:
>> Coming back to this series based on discussion at below thread
>> https://patchwork.kernel.org/project/linux-arm-msm/patch/1648103831-
>> 12347-4-git-send-email-quic_c_sanm@quicinc.com/
>> Dropped the dt bindings PATCH 1/3 in v2
>> https://patchwork.kernel.org/project/linux-arm-msm/cover/1636353710-
>> 25582-1-git-send-email-quic_c_sanm@quicinc.com/
>>
>> v2:
>> Updated the commit descriptions.
>> Changed subject prefix from dwc to dwc3.
>> Increased props array size.
>>
>> Sandeep Maheswaram (2):
>>   usb: host: xhci-plat: Add device property to set XHCI_SKIP_PHY_INIT
>>     quirk
>>   usb: dwc3: host: Set the property usb-skip-phy-init
>>
>>  drivers/usb/dwc3/host.c      | 4 +++-
>>  drivers/usb/host/xhci-plat.c | 3 +++
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> --
>> 2.7.4
> 
> Please let me know your opinion about this series.

Otherwise looks good but wondering if we should document that new device
property somewhere. 

Couldn't find a standard way how those device properties excluded from
Documentation/devicetree/binding are documented

Thanks
-Mathias

