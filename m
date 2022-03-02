Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F67B4CA064
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbiCBJPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiCBJPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:15:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEABEAD139;
        Wed,  2 Mar 2022 01:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646212490; x=1677748490;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=C5LMruo8BLbuP0C5+2OgoMCHK0E8sfbsi+OabOpXTzE=;
  b=I7AqbMAYOVcpnfTpnq1ribohmsCbr5d/vcdirXauaO8lmtncP9BafIj0
   2cnU+aifrKoSAlNXA+9LiDfoSaqnzkiI4KAA6f9BR4IwRt9B8EKA8Qwpy
   Os57W3C3f2Ew5bWdTEv71lf3qhWUBdeXPLgqdsKv/YSkK/m2dFRMQCdbf
   6TDVXieYhZNBdVEHovJ6JynM13t3NYkznuAGcnpti7IhINkP3kkHaEMBD
   PX3lDjkGtRWhXKLE7H8D4G8eD3oudsQ4hmfIfp65/O1JFGxGPQh5UT+Lg
   cWYvChJKdJnKi0hMgrxnWxbxYsgxznyRxXXx6Y3iV+J8arW7oJNvsCe9x
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="316570330"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="316570330"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 01:14:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="576043355"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 02 Mar 2022 01:14:48 -0800
To:     Henry Lin <henryl@nvidia.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2e5f4998-71bc-1fd5-8a82-b7392e4f7615@linux.intel.com>
 <20220302065106.85021-1-henryl@nvidia.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v3] xhci: fix runtime PM imbalance in USB2 resume
Message-ID: <1c41cf52-df45-baba-fdfc-03545cefcbcf@linux.intel.com>
Date:   Wed, 2 Mar 2022 11:16:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220302065106.85021-1-henryl@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.3.2022 8.51, Henry Lin wrote:
> A race between system resume and device-initiated resume may result in
> runtime PM imbalance on USB2 root hub. If a device-initiated resume
> starts and system resume xhci_bus_resume() directs U0 before hub driver
> sees the resuming device in RESUME state, device-initiated resume will
> not be finished in xhci_handle_usb2_port_link_resume(). In this case,
> usb_hcd_end_port_resume() call is missing.
> 
> This changes calls usb_hcd_end_port_resume() if resuming device reaches
> U0 to keep runtime PM balance.
> 
> Fixes: a231ec41e6f6 ("xhci: refactor U0 link state handling in get_port_status")
> Signed-off-by: Henry Lin <henryl@nvidia.com>
> ---

Thanks, adding to queue

-Mathias
