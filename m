Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8CC4D95E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345694AbiCOIIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiCOIIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:08:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCED4BFCC;
        Tue, 15 Mar 2022 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647331609; x=1678867609;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GjBivfhHIJhsgzEOzZeFiFsGAkpj8zbSUCNkNd1Dkro=;
  b=P3PZ20BxdzBycbBffqRVLoKaSteYlgsUr1X6TFynoJRjnzLB5GM+rQ3J
   HPbdi1mE+7OiJTWgEkCUj3yIat4cPvGOJdPYn94/+LF7nu1Hy6uebLRRP
   +APHboU64ZzwbNv9bDMKgZTTepoXtCKiZ+o4RdZf/19CZqoHHN1LeZzKg
   GpTQedTIQrTWye1T/imyJiT6Pfe8mIQw0qb87BXrtkMzwupVyEdgdjSNQ
   qcwJoIAyC/PXxuUtFEpDNxpt9OcUUPpe3CN7J7DvROVg+Z1WqPc6CBZP9
   WtAAw/MY6zrfWlXB/HFARsYVOQWV+VzyK0sLLB0C7x0nUE85eJTWdC4fb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255071587"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="255071587"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 01:06:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="646132539"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2022 01:06:46 -0700
To:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, tonywwang@zhaoxin.com,
        weitaowang@zhaoxin.com
References: <3c576edf-89c3-ccf3-a43f-4ce2c1ced18d@zhaoxin.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] USB: Fix xhci ERDP update issue
Message-ID: <261420fb-28b4-0def-a9e1-9c011bab7912@linux.intel.com>
Date:   Tue, 15 Mar 2022 10:08:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3c576edf-89c3-ccf3-a43f-4ce2c1ced18d@zhaoxin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.3.2022 9.25, WeitaoWang-oc@zhaoxin.com wrote:
> On some situations, software handles TRB events slower than adding TRBs,
> xhci_irq will not exit until all events are handled. If xhci_irq just
> handles 256 TRBs and exit, the temp variable(event_ring_deq) driver records in xhci irq is equal to driver current dequeue pointer. It will cause driver not update ERDP and software dequeue pointer lost sync with ERDP. On the next xhci_irq, the event ring is full but driver will not update ERDP as software dequeue pointer is equal to ERDP.
> 
> [  536.377115] xhci_hcd 0000:00:12.0: ERROR unknown event type 37
> [  566.933173] sd 8:0:0:0: [sdb] tag#27 uas_eh_abort_handler 0 uas-tag 7 inflight: CMD OUT
> [  566.933181] sd 8:0:0:0: [sdb] tag#27 CDB: Write(10) 2a 00 17 71 e6 78 00 00 08 00
> [  572.041186] xhci_hcd On some situataions,the0000:00:12.0: xHCI host not responding to stop endpoint command.
> [  572.057193] xhci_hcd 0000:00:12.0: Host halt failed, -110
> [  572.057196] xhci_hcd 0000:00:12.0: xHCI host controller not responding, assume dead
> [  572.057236] sd 8:0:0:0: [sdb] tag#26 uas_eh_abort_handler 0 uas-tag 6 inflight: CMD
> [  572.057240] sd 8:0:0:0: [sdb] tag#26 CDB: Write(10) 2a 00 38 eb cc d8 00 00 08 00
> [  572.057244] sd 8:0:0:0: [sdb] tag#25 uas_eh_abort_handler 0 uas-tag 5 inflight: CMD
> 
> Fixed this issue by update software record temp variable when handles 128 TRB events.> 
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>

Thanks

Solution itself looks good but patch has some minor format issue:


It would also be interesting to know if the full event ring was triggered in a real
life usecase?
If that is the case I might need to look more into it.

Bigger event ring, more rings, faster handler, avoid irqoff time...

Thanks
Mathias 
