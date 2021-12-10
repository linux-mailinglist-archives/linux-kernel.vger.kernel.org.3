Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBBD4701AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241864AbhLJNfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:35:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:8143 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235759AbhLJNfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:35:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="299132712"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="299132712"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 05:31:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="659578144"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 10 Dec 2021 05:31:38 -0800
Subject: Re: [PATCH] usb: xhci: skip re-check pending port event if hibernated
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Yun-Chien Yu <yun-chien.yu@mediatek.com>
References: <20211209072218.21651-1-chunfeng.yun@mediatek.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <c448da77-f2f3-8b79-fc4b-b9dcff727c6e@linux.intel.com>
Date:   Fri, 10 Dec 2021 15:33:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211209072218.21651-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.12.2021 9.22, Chunfeng Yun wrote:
> When xHCI controller hibernated, the root hub lost power, if controller
> support Port Power Control (PPC), PP is not set at xhci_resume() and
> set by hub_reset_resume() later, so no need check pending port event.
> If PPC is not supported, device is disconneced, seems do not send out
> U3 LFPS wake signal, no need re-check again and drop 120ms delay to
> save resume time.
> 
> Reported-by: Yun-Chien Yu <yun-chien.yu@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---

Thanks, adding

-Mathias
