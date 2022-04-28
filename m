Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995F4513401
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346527AbiD1MqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346403AbiD1Mpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:45:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8205631D;
        Thu, 28 Apr 2022 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651149752; x=1682685752;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=10NxDxRtq67xm2RzbqaoZqNSZgxkaEYpYv/by8QfknU=;
  b=HhD4vBm3ElNid5/G0DoODGs33bmp1VubGGagpVsfhvXv92Em3N23f/vE
   7kZ/pSGzDnxPwyAMtDHD2a30OiWocBhFL02I5i9tyB0qr7MMBoR8jc4il
   RQK+tH56ocDFknDg/HgsWde+/d1Hv8gzWbjbIHFar7WmFJT9coUdHKsZQ
   zuhpfIjySkFKXZCtFPoPIgxGXEQGGRZF9JRYvA7OyEGy/+WtOkIz50KiF
   SLCrLY3PNBiSXUz3vNdI7iezL9xdWGk9p2XjfFv0Bq/g2VeK+71hLUWyq
   5RjLia46gEOpPdJGO2ZvGcnnyE0GXp+pGWWetdIO667Gnbx+nat6ur8JU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="266090828"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="266090828"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 05:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="878612539"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 28 Apr 2022 05:42:30 -0700
To:     Zixuan Fu <r33s3n6@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
References: <20220428092321.3011983-1-r33s3n6@gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2 resend] drivers: usb: host: fix NULL pointer
 dereferences triggered by unhandled errors in xhci_create_rhub_port_array()
Message-ID: <eb417aeb-92f2-8910-378f-00031fbbcae5@linux.intel.com>
Date:   Thu, 28 Apr 2022 15:44:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220428092321.3011983-1-r33s3n6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.4.2022 12.23, Zixuan Fu wrote:
> In xhci_create_rhub_port_array(), when rhub->num_ports is zero, 
> rhub->ports would not be set; when kcalloc_node() fails, rhub->ports
> would be set to NULL. In these two cases, xhci_create_rhub_port_array()
> just returns void, and thus its callers are unaware of the error.
> 
> Then rhub->ports is dereferenced in xhci_usb3_hub_descriptor() or 
> xhci_usb2_hub_descriptor().

As it turned out this dereference is only an issue if kcalloc_node() failed,
not if rhub->num_ports is zero.

So this is more of a theoretical issue. Not urgent, not for stable.

So as Greg suggested its probably better to add this fix on top of
the one roothub support series it conflicts with.


Thanks
Mathias
