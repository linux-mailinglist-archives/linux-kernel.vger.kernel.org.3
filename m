Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132AB5982D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbiHRMBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244468AbiHRMAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:00:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A1E277
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660824054; x=1692360054;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nUnatOEBHqllCBfKymhIxJyn7mqSpTnHv+/D+9S6usw=;
  b=CWdrDw43Q2xvCE7IOV34ci77PrZkwSX3Be3vISTLQJGWE1EdjNQNQ7wN
   fiGzvIz5TicuggmKR1ucdKNWrvIwGPPk+YUgUA6w8qVgZkb9bbm4A6W+1
   YAhnpNLi7jOYSvJxy29vRXb9ZDzg+pQQb5966rlbrMKxb8UKu20/xEYrj
   uw5RS6CM3AljvblcDLyKkZK9OQCqQb9t8bwr0xUigPJtPeITSTEdDrbZ8
   vQptWJXFdkzEOrIKGqeQJJOvFP/JN61pShfKf4YnK5PNMZMLteZ6itIxG
   2wSglbyPirbdNTyVey8jwRAmPiQvicyAJ80aTIy8oOACBRbZd39FaV5Af
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="292737985"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="292737985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 05:00:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="668074960"
Received: from dursu-mobl1.ger.corp.intel.com ([10.249.42.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 05:00:52 -0700
Date:   Thu, 18 Aug 2022 15:00:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kernel@axis.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tty: Fix lookahead_buf crash with serdev
In-Reply-To: <20220818115026.2237893-1-vincent.whitchurch@axis.com>
Message-ID: <67bee157-5aa9-213b-e7b8-38956a3884d9@linux.intel.com>
References: <20220818115026.2237893-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1539636719-1660824053=:1604"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1539636719-1660824053=:1604
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 18 Aug 2022, Vincent Whitchurch wrote:

> Do not follow a NULL pointer if the tty_port_client_operations does not
> implement the ->lookahead_buf() callback, which is the case with
> serdev's ttyport.
> 
> Fixes: 6bb6fa6908ebd3 ("tty: Implement lookahead to process XON/XOFF timely")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> ---
> 
> Notes:
>     v2: Move more stuff into if block.
> 
>  drivers/tty/tty_buffer.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 9fdecc795b6b..5e287dedce01 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -470,7 +470,6 @@ static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
>  
>  	while (head) {
>  		struct tty_buffer *next;
> -		unsigned char *p, *f = NULL;
>  		unsigned int count;
>  
>  		/*
> @@ -489,11 +488,16 @@ static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
>  			continue;
>  		}
>  
> -		p = char_buf_ptr(head, head->lookahead);
> -		if (~head->flags & TTYB_NORMAL)
> -			f = flag_buf_ptr(head, head->lookahead);
> +		if (port->client_ops->lookahead_buf) {
> +			unsigned char *p, *f = NULL;
> +
> +			p = char_buf_ptr(head, head->lookahead);
> +			if (~head->flags & TTYB_NORMAL)
> +				f = flag_buf_ptr(head, head->lookahead);
> +
> +			port->client_ops->lookahead_buf(port, p, f, count);
> +		}
>  
> -		port->client_ops->lookahead_buf(port, p, f, count);
>  		head->lookahead += count;
>  	}
>  }
> 

--8323329-1539636719-1660824053=:1604--
