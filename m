Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DAA578F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiGSA00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiGSA0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:26:24 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DDE33355
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:26:23 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id v5so10055945qvq.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5WGojSzYNyuicqU/p82Pg5ZIp68x6TVpfTqklv6NcTA=;
        b=qExX/S0T+JQdPWcspHh/S4Km/TLwmfZ5Rp64akVCmZG1V6mUGcaiStB6knxGY21J8n
         OlreIiLTm7/PmKIXHh/sJwRSHHKqtjN6/zL7m9twE9RFK/RKGBj56bJo+csH/yUX8nXh
         LIbRyvAtT+fH+gu6msaBVwtKCkLXvdH1X4GVmDaKBVcLjjxNGRFxVWebKxFJQ5g2jehZ
         MDIQS7QQULfAl6I/UtB+la3ba2gAzjtENLSu0+vjAQeuCnSJ1KcKePjA8sNCvRy0tp/T
         0to/nm182Alx3urrkI7gNBwSwiW4Lz/k2lhwyOlM5WtLhoabTiKNSyZ72z7nX0Q/r0Iv
         DWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=5WGojSzYNyuicqU/p82Pg5ZIp68x6TVpfTqklv6NcTA=;
        b=Q8LDZOlSP3xOJlcR+RLDc0zArN/bgKSI5kg6LZ2NquqnbFGYe+OqNdFvaRuWKu35eF
         LhycSKZpKb4IKblnaqf5mFdOHOf5E/skBDSYXlbVadESdtB/9atI5D1KkAHDUe0Jzi6M
         8JeUlWi3SDe9CXnCDXeb/GoLukBJNIh2xnGlbEiv3AOmPSiB+wrNQ+7bYZ+nqYtYVSXu
         Baj0mzxCqUbTrENNdaoGMJxcpxl4ofhN5UOH+xVdlXIizT/6HR9tIMmQCE3FNPLczXAg
         LQSfRrKJWgnoptdUC62mtWDOXjj45pS/zhBa8GyyZ4TqwT6nVPqHVg7fOarA/+oO1BhJ
         vEig==
X-Gm-Message-State: AJIora+nbXI6rWKpVp3FdPb3DjI3HXEW5St4uEQ+DDygIzebHQbZw2wU
        JBBpvcdUlqcBkFEQbjNpCQ==
X-Google-Smtp-Source: AGRyM1sLWVwk38OJ0szHXdslhKy0W8avKB3g365xeQzNPL+RqzJbCCOdv7yuNr7VPoQGKZ2pc/bP7w==
X-Received: by 2002:a05:6214:624:b0:473:27e8:95d6 with SMTP id a4-20020a056214062400b0047327e895d6mr22907776qvx.109.1658190382969;
        Mon, 18 Jul 2022 17:26:22 -0700 (PDT)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id bt14-20020ac8690e000000b0031ef0081d77sm3097587qtb.79.2022.07.18.17.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 17:26:22 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8d92:f4cf:23d:d106])
        by serve.minyard.net (Postfix) with ESMTPSA id 699321800D9;
        Tue, 19 Jul 2022 00:26:21 +0000 (UTC)
Date:   Mon, 18 Jul 2022 19:26:20 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: Fix comment typo
Message-ID: <20220719002620.GC40038@minyard.net>
Reply-To: minyard@acm.org
References: <20220715054156.6342-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715054156.6342-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 01:41:56PM +0800, Jason Wang wrote:
> The double `the' is duplicated in line 4360, remove one.

Applied, thanks.

-corey

> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 703433493c85..c8a3b208f923 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -4357,7 +4357,7 @@ static int handle_oem_get_msg_cmd(struct ipmi_smi *intf,
>  
>  			/*
>  			 * The message starts at byte 4 which follows the
> -			 * the Channel Byte in the "GET MESSAGE" command
> +			 * Channel Byte in the "GET MESSAGE" command
>  			 */
>  			recv_msg->msg.data_len = msg->rsp_size - 4;
>  			memcpy(recv_msg->msg_data, &msg->rsp[4],
> -- 
> 2.35.1
> 
