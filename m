Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962814C8F69
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbiCAPs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiCAPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:48:26 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748B511C1F;
        Tue,  1 Mar 2022 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646149665; x=1677685665;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=JxXFUePodsBN9xSpWPsW6lcDWvOaOTxGzcBRFGSPs/E=;
  b=TiEI3Z9NvY1KkuBUHuikNTYgFLVyspn0lsOpk9+ZiDOZ9a+ABT27NQnX
   Kn0d8HWh4uYTOFHWoRWHhxn2ZT9l5gh0ixj2pbFXbjxUuwSsmaOwCfytJ
   oMbPCLqb1Q4RzXQD9tDgGZ7f3IZ8/OOhbqW0km6eMjzXQLzuWMKQub0ws
   wRLtyp4WqTeUo87UiwpQHPEvQRxus6QDp+tXEi7d5eTEWL9ZeJ+rnFulw
   asodlXYAa2ZfMoBaW73gP675K7xX76WLrUtKFR/nOKaIL8UMH7QLgVJsu
   54VOGjtgmzt+iA9LElYa21KQQURTPy45fp2XQv4ElFAPEgAmumOKEqrIM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="250739086"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="250739086"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:47:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="575739145"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2022 07:47:41 -0800
To:     Henry Lin <henryl@nvidia.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220225055311.92447-1-henryl@nvidia.com>
 <20220225071506.22012-1-henryl@nvidia.com>
 <2ef7da52-d8ad-05ca-bcb6-06bd6bb6f9d3@linux.intel.com>
 <CH0PR12MB50892722DB1E7ECA5BAC629AAC029@CH0PR12MB5089.namprd12.prod.outlook.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2] xhci: fix runtime PM imbalance in USB2 resume
Message-ID: <2e5f4998-71bc-1fd5-8a82-b7392e4f7615@linux.intel.com>
Date:   Tue, 1 Mar 2022 17:49:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CH0PR12MB50892722DB1E7ECA5BAC629AAC029@CH0PR12MB5089.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.3.2022 12.28, Henry Lin wrote:
>>> USB2 resume starts with usb_hcd_start_port_resume() in port status
>>> change handling for RESUME link state. usb_hcd_end_port_resume() call is
>>> needed to keep runtime PM balance.
> 
>> For normal usb2 port resume the usb_hcd_end_port_resume() is called when resume
>> has been signaled for long enough in xhci_handle_usb2_port_link_resume().
>>
>> This is also where driver directs the port to go from Resume state to U0.
>> Port can't do this without driver directing it.
>>
>> If there's a failure during resume signaling (disconnect, reset, error) then
>> stale resume variables are detected in xhci_get_port_status() and
>> usb_hcd_end_port_resume() is called.
> 
>> I do now see a231ec41e6f6 ("xhci: refactor U0 link state handling in get_port_status")
>> does change order of checking and clearing stale resume variables, but this should
>> only happen if the first port state we read is a fully enabled functional U0 state after
>> a failed resume.
> 
>> Could you expand a bit how this was detected?
> We observed the racing issue when usb2 device-initiated resume occurs in system resume.
> If usb2 host-initiated resume for system resume directs U0 before xhci_get_usb2_port_status()
> see RESUME state, xhci_get_usb2_port_status() will not finish resume process in
> xhci_handle_usb2_port_link_resume(). Its scenario is as follows:
> 
> 1. System resume starts. All driver system resume callbacks get called in order. XHCI controller
>     is resumed by xhci_resume().
> 2. USB2 root hub is resuming. hcd_bus_resume() is being executed.
> 3. Before xhci_bus_resume() is finished, XHCI driver receives a port status change event for 
>     an USB2 port with RESUME link state in xhci_irq(). XHCI driver starts the process to resume
>     HS port for device-initiated resume.
> 4. In xhci_bus_resume(), host-initiated resume (direct U0) is performed on the same port that is
>     resuming in step 3 in below loop:
> 
>                 if (bus_state->bus_suspended) {
>                         spin_unlock_irqrestore(&xhci->lock, flags);
>                         msleep(USB_RESUME_TIMEOUT);
>                         spin_lock_irqsave(&xhci->lock, flags);
>                 }
>                 for_each_set_bit(port_index, &bus_state->bus_suspended,
>                                  BITS_PER_LONG) {
>                         /* Clear PLC to poll it later for U0 transition */
>                         xhci_test_and_clear_bit(xhci, ports[port_index],
>                                                 PORT_PLC);
>                         xhci_set_link_state(xhci, ports[port_index], XDEV_U0);
>                 }
> 5. Then, link state of the resuming port is observed as U0 in following
>     xhci_get_usb2_port_status(). xhci_handle_usb2_port_link_resume() has
>     no chance to get called on the resuming port.
> 

True, thanks for the explanation.
If there's a race between system resume and device-initiated resume, and port is resumed
in xhci_bus_resume() then yes I see how this could happen.

Maybe only call usb_hcd_end_port_resume() if xhci_irq() detected the device-initiated
resume. i.e. set a value to resume_done[portnum] and called usb_hcd_start_port_resume()
something like: 

@@ -1088,6 +1088,8 @@ static void xhci_get_usb2_port_status(struct xhci_port *port, u32 *status,
                if (link_state == XDEV_U2)
                        *status |= USB_PORT_STAT_L1;
                if (link_state == XDEV_U0) {
+                       if (bus_state->resume_done[portnum])
+                               usb_hcd_end_port_resume(&port->rhub->hcd->self, portnum);
                        bus_state->resume_done[portnum] = 0;
                        clear_bit(portnum, &bus_state->resuming_ports);

Also xhci_bus_resume() only resumes ports that were forcefully suspended to U3 in xhci_bus_suspend().
Could be worth checking why that device wasn't already in U3 when suspend reached xhci_bus_suspend().

Thanks
Mathias

