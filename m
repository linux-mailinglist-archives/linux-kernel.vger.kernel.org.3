Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333C45955E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiHPJGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiHPJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:06:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438FC39BA0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660634499; x=1692170499;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lf8Gzgsl23fdMCmzFEjEuR2nNJJ1YMbA03UdGEAPq74=;
  b=biEVvVh8DwjyIj8ZpLi5eKJ628VjbKZfX1QlfvTCaKtCzolcXCYibqvn
   dYmlWNDvykC0YkMY6rk7TENwEOjXFbWMGRWm5hcplm6bDEkJ+Wc4aVRD7
   PolnnCH57EcKU8ElFevZiQBLRyn5r/hNtGXCrKDk14jdVQA9zcH0Lgup2
   omS6Vot3ZYmnN09Pm/haU+FtvqES42T9GaKCyzApkdVzcMl/eNtH+R4KH
   FMaJRds+ie5sCLAY43WXicBFjMmGT2TYNpecIG3WbRel1vbEgnICZITmQ
   hB75xMIf34jaQPDGY8DpHTNaMjklZROsriMFXZT9NAAdSUY5yMSXUyyxN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="279108733"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="279108733"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 00:21:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="666992566"
Received: from tturcu-mobl1.ger.corp.intel.com ([10.252.51.153])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 00:21:36 -0700
Date:   Tue, 16 Aug 2022 10:21:30 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kernel@axis.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: Fix lookahead_buf crash with serdev
In-Reply-To: <20220816071142.1128001-1-vincent.whitchurch@axis.com>
Message-ID: <27efed7a-6e1e-e151-35d5-6b4b8b9d2e8@linux.intel.com>
References: <20220816071142.1128001-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022, Vincent Whitchurch wrote:

> Do not follow a NULL pointer if the tty_port_client_operations does not
> implement the ->lookahead_buf() callback, which is the case with
> serdev's ttyport.
> 
> Fixes: 6bb6fa6908ebd3 ("tty: Implement lookahead to process XON/XOFF timely")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/tty/tty_buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 9fdecc795b6b..a1c97d4a45fb 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -493,7 +493,8 @@ static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
>  		if (~head->flags & TTYB_NORMAL)
>  			f = flag_buf_ptr(head, head->lookahead);
>  
> -		port->client_ops->lookahead_buf(port, p, f, count);
> +		if (port->client_ops->lookahead_buf)
> +			port->client_ops->lookahead_buf(port, p, f, count);

While this works, I'd put the preceeding calculations of p and f into the 
same block as they just prep parameters for the call.

>  		head->lookahead += count;
>  	}
>  }
> 

-- 
 i.

