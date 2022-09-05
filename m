Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512955ACFD3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiIEKTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbiIEKSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:18:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CD55464C;
        Mon,  5 Sep 2022 03:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662373044; x=1693909044;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PbFMApXZgw+38bgGm8dKdd9ii/xxRNRjkKs3anjHN+g=;
  b=mQGKsPu4pnN6i1n5bwLFpr4dRZjSusptueuU7pIP5jf+pM1ZIS0pWMyc
   P9em7OEOrjMsOq9xXdOQnO/WEckpGQrBbPrdBKUyev00obq5+xvzq52H1
   y7CKoJRjfcaPoNT4HKxkGCFfRmaEz9RMmxWpoGOFlPVJLSf1zLrkDQ10d
   kaxPOTetcHQpc/oo0X1BkMwbbFLsh5DGzVxVOmY6SOKzSn9R4JrGD68fq
   9bBB9EZ7r8tIGwO3LASM27MA/sa9Jjej7N3tV8EPC9gFDmabOlj4X48m/
   ecLoCUcriePf7f+/GN7yyX2g5DMeR+SLww0Pfj0YXAlLz+wjAeFZonAQu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="358073048"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="358073048"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 03:17:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="675231205"
Received: from lpontegg-mobl.ger.corp.intel.com ([10.249.45.111])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 03:16:51 -0700
Date:   Mon, 5 Sep 2022 13:16:46 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Li Zhong <floridsleeves@gmail.com>
cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Subject: Re: [PATCH v3] drivers/tty/serial: check the return value of
 uart_port_check()
In-Reply-To: <20220904004524.2281227-1-floridsleeves@gmail.com>
Message-ID: <acf3b04e-14f7-030-bdf9-3427bbb688@linux.intel.com>
References: <20220904004524.2281227-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Sep 2022, Li Zhong wrote:

> uart_port_check() will return NULL pointer when state->uart_port is
> NULL. Check the return value before dereference it to avoid
> null-pointer-dereference error

> because the locking does not guarantee the return value is not NULL.

Please include also the answer to the "Why it doesn't guarantee?"
question.

In addition, it's expected you'll keep the people who have expressed 
interest in your patch among the receipients for any new version you 
send out. Thank you.

-- 
 i.

> Here we do not need unlock in the error
> handling because the mutex_unlock() is called in callers.
> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
> 
> v3: Add the reason why we need to check the NULL value in the commit
> message.  The bug is detected by static analysis.
> 
> ---
>  drivers/tty/serial/serial_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 12c87cd201a7..760e177166cf 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -194,6 +194,9 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
>  	unsigned long page;
>  	int retval = 0;
>  
> +	if (!uport)
> +		return -EIO;
> +
>  	if (uport->type == PORT_UNKNOWN)
>  		return 1;
>  
> @@ -498,6 +501,8 @@ static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
>  	struct ktermios *termios;
>  	int hw_stopped;
>  
> +	if (!uport)
> +		return;
>  	/*
>  	 * If we have no tty, termios, or the port does not exist,
>  	 * then we can't set the parameters for this port.
> @@ -1045,6 +1050,8 @@ static int uart_get_lsr_info(struct tty_struct *tty,
>  	struct uart_port *uport = uart_port_check(state);
>  	unsigned int result;
>  
> +	if (!uport)
> +		return -EIO;
>  	result = uport->ops->tx_empty(uport);
>  
>  	/*
> 

