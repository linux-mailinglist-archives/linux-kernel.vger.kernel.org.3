Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8354851465E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357265AbiD2KOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347972AbiD2KOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:14:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9E5522C6;
        Fri, 29 Apr 2022 03:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651227064; x=1682763064;
  h=from:to:cc:references:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5F+CvvFbQQEgAbWmyaDZMgf2egBra8v2iQ+XBITVM2E=;
  b=EGFlpe+0tjosVJ0qSFA+jbBfN5eS9lrQkR7XHEDJJlKGWeAdkQpSvDhc
   Rho0/sMHiP7pHJ5khFMM9W+Gawm1HHpVF6we58bXtFLJnFgQMPgHWQzoC
   Gyd7ZmwTroZPsVMaIORCzEdEh6X6i0WGQa9j6c7/WnynK01aq3JD6ihUa
   Cv57iCN+U6EH9A+QHf7nWGSmksgO6/ALw15u2Tkkk5qF6mF4sdbWlVKci
   sOx8zDYFKRcGoBgNGEVR+OsxCbecZbwaoOOqvS5zaO7+EPYWbTuxeUo6x
   cshmU2FHzipnryE7C7qijLuHGLImKL/Z3zZO58R2InriMgcAhVKA7WBdv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="291768859"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="291768859"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 03:11:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="880680647"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2022 03:11:02 -0700
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
To:     Mayank Rana <quic_mrana@quicinc.com>, peter.chen@kernel.org,
        balbi@kernel.org, stern@rowland.harvard.edu,
        chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <1651172688-21439-1-git-send-email-quic_mrana@quicinc.com>
 <71347c81-3887-d80e-707b-c0f1018b1a50@linux.intel.com>
Subject: Re: [PATCH RESEND] xhci: Use xhci_get_virt_ep() to validate ep_index
Message-ID: <06d5e94f-1c3b-9ab1-b4ff-79007026585a@linux.intel.com>
Date:   Fri, 29 Apr 2022 13:13:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <71347c81-3887-d80e-707b-c0f1018b1a50@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.4.2022 12.49, Mathias Nyman wrote:
> On 28.4.2022 22.04, Mayank Rana wrote:
>> ring_doorbell_for_active_rings() API is being called from
>> multiple context. This specific API tries to get virt_dev
>> based endpoint using passed slot_id and ep_index. Some caller
>> API is having check against slot_id and ep_index using
>> xhci_get_virt_ep() API whereas xhci_handle_cmd_config_ep() API
>> only check ep_index against -1 value but not upper bound i.e.
>> EP_CTX_PER_DEV. Hence use xhci_get_virt_ep() API to get virt_dev
>> based endpoint which checks both slot_id and ep_index to get
>> valid endpoint.
> 
> ep_index upper bound is known to be in range as EP_CTX_PER_DEV is 31,
> and ep_index = fls(u32 value)  - 1 - 1; 
> 
> We can change to use xhci_get_virt_ep(), but this would be more useful
> earlier in xhci_handle_cmd_config_ep() where we touch the ep before
> calling ring_doorbell_for_active_rings()
> 

After a second look I would appreciate if you could clean up
ep_index checking in xhci_handle_cmd_config_ep()

It currenty does some horrible typecasting.
ep_index is an unsigned int, so the fls() -1 operation might wrap it around.
Checking this was solved by typecasting a -1 to an unsigned int.

if (ep_index != (unsigned int) -1)

Thanks
Mathias


