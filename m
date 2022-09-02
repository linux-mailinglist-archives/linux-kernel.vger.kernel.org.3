Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52075AAC4A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiIBKWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIBKW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:22:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AA1A407B;
        Fri,  2 Sep 2022 03:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662114145; x=1693650145;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qIRbLNMuUIbKjJMw4xI4Cjx59s1o6lUk5fVHdAfW1KE=;
  b=l5eghSFNXrbLkCWp7q0t71NwIK+rs9eA+S/2BizRJIopRIBAaDZWqcT8
   64X94wgEBhdNVSsUQRP+XoTJC5Hgvn1Pnw8vLzKOjuApN0RqTqu2by85k
   AGUSxcU3o2YKmWZUgnGqJlUgNGFlqhK2FdrTrR6K+Oybm8v6BE7zh55iD
   pEGfyz3541oF5BOZSRhiHHscb19whZEcvEy95JgZmK4/spGRPYQTvw4CE
   FuEic0UseXb5JnZMPaoGPLWl9MRCIqxIVJHJiDSgSJ17Ge6hxr7rbLzVU
   WPfq0G7C6Gt1xcSgL1sLNwuMp0YLL+vkNtB/TMXMP82uATOMtOPOH25m8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="275696333"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="275696333"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 03:22:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674302931"
Received: from vbykovni-mobl.ger.corp.intel.com ([10.252.53.17])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 03:22:22 -0700
Date:   Fri, 2 Sep 2022 13:22:17 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] tty: serial: introduce transmit helper
 generators
In-Reply-To: <20220901110657.3305-2-jslaby@suse.cz>
Message-ID: <61411321-285d-ec3e-2d92-e93b0e95631@linux.intel.com>
References: <20220901110657.3305-1-jslaby@suse.cz> <20220901110657.3305-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2022, Jiri Slaby wrote:

> Many serial drivers do the same thing:
> * send x_char if set
> * keep sending from the xmit circular buffer until either
>   - the loop reaches the end of the xmit buffer
>   - TX is stopped
>   - HW fifo is full
> * check for pending characters and:
>   - wake up tty writers to fill for more data into xmit buffer
>   - stop TX if there is nothing in the xmit buffer
> 
> The only differences are:
> * how to write the character to the HW fifo
> * the check of the end condition:
>   - is the HW fifo full?
>   - is limit of the written characters reached?
> 
> So unify the above into two helper generators:
> * DEFINE_UART_PORT_TX_HELPER_LIMITED() -- it performs the above taking
>   the written characters limit into account, and
> * DEFINE_UART_PORT_TX_HELPER() -- the same as above, except it only
>   checks the HW readiness, not the characters limit.
> 
> The HW specific operations (as stated as "differences" above) are passed
> as arguments to the macros. They are:
> * tx_ready() -- returns true if HW can accept more data.
> * put_char() -- write a character to the device.
> * tx_done() -- when the write loop is done, perform arbitrary action
>   before potential invocation of ops->stop_tx() happens.
> 
> Note that the above macros are generators. This means the code is
> generated in place and the above 3 arguments are "inlined". I.e. no
> added penalty by generating call instructions for every single
> character. Nor any indirect calls. (As in previous versions of this
> patchset.)
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
> 
> Notes:
>     [v2] instead of a function (uart_port_tx_limit()) in serial_core,
>          generate these in-place using macros. Thus eliminating "call"
>          penalty.
> 
>  Documentation/driver-api/serial/driver.rst |  3 +
>  include/linux/serial_core.h                | 86 ++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
> index 23c6b956cd90..25775bf1fcc6 100644
> --- a/Documentation/driver-api/serial/driver.rst
> +++ b/Documentation/driver-api/serial/driver.rst
> @@ -78,6 +78,9 @@ Other functions
>             uart_get_lsr_info uart_handle_dcd_change uart_handle_cts_change
>             uart_try_toggle_sysrq uart_get_console
>  
> +.. kernel-doc:: include/linux/serial_core.h
> +   :identifiers: DEFINE_UART_PORT_TX_HELPER_LIMITED DEFINE_UART_PORT_TX_HELPER
> +
>  Other notes
>  -----------
>  
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 6e4f4765d209..715778160ae1 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -646,6 +646,92 @@ struct uart_driver {
>  
>  void uart_write_wakeup(struct uart_port *port);
>  
> +#define __DEFINE_UART_PORT_TX_HELPER(name, port, ch, tx_ready, put_char,  \
> +		tx_done, for_test, for_post, ...)			  \
> +unsigned int name(struct uart_port *port __VA_OPT__(,) __VA_ARGS__)	  \
> +{									  \
> +	struct circ_buf *xmit = &port->state->xmit;			  \
> +	unsigned int pending;						  \
> +	u8 ch;								  \
> +									  \
> +	for (; (for_test) && (tx_ready); (for_post), port->icount.tx++) { \

> + * The functions in parameters shall be designed as follows:
> + *  * **tx_ready(port):** the function shall return true if the HW can accept
> + *    more data to be sent. This function can be %NULL, which means the HW is
> + *    always ready.

So if tx_ready can be NULL, how does that for() loop above work??

-- 
 i.

