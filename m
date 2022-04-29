Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F393D51460C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357267AbiD2Jxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357069AbiD2Jxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:53:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF97DC7497;
        Fri, 29 Apr 2022 02:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651225682; x=1682761682;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VhfUkWHnu8Wpl9LIPDT743PMT/ebUxApn3Gvd8a2njk=;
  b=D4JzHOhwol3EIUyEyINMotJYDw/q2Mc4a2VntpMtWHMwWCCbUIrDgVOy
   5JrVXVHohZKTFbhO2Am5Ccitog/UG+0TIMnoyfNZCV0O5PWSuIGYqRS8d
   GwtJpZgVdWMa5aQ3i2e5mN14oj0dr4s9vUWjl1Rww7zyhXwfIBwzNyCQO
   MqLi8w37Z/qD04G6k5rswU3rKjh7fsoNLJJzFLlIcvfH/azYjys9VBZbg
   zSGbuHrLk1uqdv95EIQpN1QJVF7eWQBURP5d4DHAc3074+etYsqMrmhKw
   3FWNHyU++7s2giUYkIYc0bPte3MY21b0Z+8kLOp20QWjzi8VxVQtYBEYH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266751874"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="266751874"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 02:48:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="880639035"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2022 02:48:00 -0700
To:     Mayank Rana <quic_mrana@quicinc.com>, peter.chen@kernel.org,
        balbi@kernel.org, stern@rowland.harvard.edu,
        chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <1651172688-21439-1-git-send-email-quic_mrana@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH RESEND] xhci: Use xhci_get_virt_ep() to validate ep_index
Message-ID: <71347c81-3887-d80e-707b-c0f1018b1a50@linux.intel.com>
Date:   Fri, 29 Apr 2022 12:49:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1651172688-21439-1-git-send-email-quic_mrana@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.4.2022 22.04, Mayank Rana wrote:
> ring_doorbell_for_active_rings() API is being called from
> multiple context. This specific API tries to get virt_dev
> based endpoint using passed slot_id and ep_index. Some caller
> API is having check against slot_id and ep_index using
> xhci_get_virt_ep() API whereas xhci_handle_cmd_config_ep() API
> only check ep_index against -1 value but not upper bound i.e.
> EP_CTX_PER_DEV. Hence use xhci_get_virt_ep() API to get virt_dev
> based endpoint which checks both slot_id and ep_index to get
> valid endpoint.

ep_index upper bound is known to be in range as EP_CTX_PER_DEV is 31,
and ep_index = fls(u32 value)  - 1 - 1; 

We can change to use xhci_get_virt_ep(), but this would be more useful
earlier in xhci_handle_cmd_config_ep() where we touch the ep before
calling ring_doorbell_for_active_rings()

Also note that this codepath is only used for some prototype
xHC controller that probably never made it to the market about 10 years ago. 

Thanks
Mathias
