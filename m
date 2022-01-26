Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1F49CDC3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbiAZPRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:17:42 -0500
Received: from smtp-fw-80007.amazon.com ([99.78.197.218]:9303 "EHLO
        smtp-fw-80007.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242657AbiAZPRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1643210261; x=1674746261;
  h=references:from:to:cc:date:in-reply-to:message-id:
   mime-version:subject;
  bh=rbZmqkJk3vkuCsTBRrPDjVNqrBC9mOsn8Oh+RWvJ8Fk=;
  b=I3EDarDX4X+GWNSrdh518xf6YJRrBB8dYQX466ixNSNfo1Ju/CnrlhWV
   bqbqOU2X7SWWX4Hg4myMTW+8KBEvc/RhgsJRqD/a4xMz0JIvtFh/6mZdK
   gtZUtMNDYEPLSkoLdGgEaOR+x0VmgHTd7NZM849eVhLJqhzPkfWiTmHi4
   E=;
X-IronPort-AV: E=Sophos;i="5.88,318,1635206400"; 
   d="scan'208";a="58196395"
Subject: Re: [PATCH v2] net: ena: Do not waste napi skb cache
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 26 Jan 2022 15:17:27 +0000
Received: from EX13D28EUC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com (Postfix) with ESMTPS id 141D941A80;
        Wed, 26 Jan 2022 15:17:26 +0000 (UTC)
Received: from u570694869fb251.ant.amazon.com.amazon.com (10.43.162.8) by
 EX13D28EUC001.ant.amazon.com (10.43.164.4) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Wed, 26 Jan 2022 15:17:18 +0000
References: <20220123115623.94843-1-42.hyeyoo@gmail.com>
 <YfFJuQQBLJRxIJR+@ip-172-31-19-208.ap-northeast-1.compute.internal>
User-agent: mu4e 1.7.5; emacs 28.0.50
From:   Shay Agroskin <shayagr@amazon.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     <jwiedmann.dev@gmail.com>, Arthur Kiyanovski <akiyano@amazon.com>,
        "David Arinzon" <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        "Saeed Bishara" <saeedb@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Sameeh Jubran" <sameehj@amazon.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Lorenzo Bianconi" <lorenzo@kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Jan 2022 17:16:35 +0200
In-Reply-To: <YfFJuQQBLJRxIJR+@ip-172-31-19-208.ap-northeast-1.compute.internal>
Message-ID: <pj41zlilu61q85.fsf@u570694869fb251.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Originating-IP: [10.43.162.8]
X-ClientProxiedBy: EX13D30UWC001.ant.amazon.com (10.43.162.128) To
 EX13D28EUC001.ant.amazon.com (10.43.164.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hyeonggon Yoo <42.hyeyoo@gmail.com> writes:

> CAUTION: This email originated from outside of the 
> organization. Do not click links or open attachments unless you 
> can confirm the sender and know the content is safe.
>
>
>
> By profiling, discovered that ena device driver allocates skb by
> build_skb() and frees by napi_skb_cache_put(). Because the 
> driver
> does not use napi skb cache in allocation path, napi skb cache 
> is
> periodically filled and flushed. This is waste of napi skb 
> cache.
>
> As ena_alloc_skb() is called only in napi, Use napi_build_skb()
> and napi_alloc_skb() when allocating skb.
>
> This patch was tested on aws a1.metal instance.
>
> [ jwiedmann.dev@gmail.com: Use napi_alloc_skb() instead of
>   netdev_alloc_skb_ip_align() to keep things consistent. ]
>
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>

Thank you for this work

Acked-by: Shay Agroskin <shayagr@amazon.com>
