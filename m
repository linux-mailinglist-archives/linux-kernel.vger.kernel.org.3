Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA343483983
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 01:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiADAos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 19:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiADAor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 19:44:47 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268FDC061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 16:44:47 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so39115098pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 16:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IgljEHbZCetta8CT31CEBSYSqzETaugD3UFSCq2QH7o=;
        b=UJEsL8bQw5v4c9MVoCsd1ApwL+rR84R5w+7vKF5f79iIl2qVwXjVJZdvZ02hm0sZii
         xSKmpyEc9UkrmomymHO+omzmlyljPsfZqbhTxUSuY+MsPLzMH3sEyXKMgoxcD8nC1tyk
         SyalraYi3eaKpHVpCeq1HWiDEop1/PafWWB/6Ee3W6MTEjsEj2ORP8i/S7zWgJ2L2z4b
         cbVa5NvTMWeGt6FhTobr5/xIxOgLDj+OFjgyVs9bfS90CszgWjZC+zwPpf8M5jpRHe/2
         JU7e/tiZm5Y1dJQYbppwOL5zgQBWL8QymFsWU/OEJbC39wAinEQ6m+FCSgnX1BANx2rk
         yjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IgljEHbZCetta8CT31CEBSYSqzETaugD3UFSCq2QH7o=;
        b=jdkQp/RC5SLeNC4ftti15BfOL13mHyG7Ny2gM/Z6UZvtntA/NgbvQ0YJ7h7tKAWtKl
         e9lo1qKSf2dzX4kRAamFoVdmwqN2+IWRxsPtpSakDNYgL+/HHoxdOCyjEIRA2cnWDBuF
         dSoJoo8T+hQRx1uBR8XGhOlK9UODzetWUw8mpk4u/VfASFpPqgOPd7auBTDjqJqEKwbp
         MlJhDV5wf9iJL1WOO4SSrypLP1AtXXAu9KyxZcIuESHYyNfykjmf07C6JIhXDntQXend
         syp3UQsNwFQETOd4niUz6u04zb3IXyQMgPxeQMTsPrr+Eg3dWXHonKylHihz4KSuVALs
         UyVg==
X-Gm-Message-State: AOAM530bO0Qeh088bqRiZ+VpmXM0l/4rOzTL7vX6qOrHt5HpnIRpcq7M
        +KIprlwA/mq5EK+tHFgTY63qFw==
X-Google-Smtp-Source: ABdhPJw/WbkX4DbW3YH3VcxMfHIQB2WPSJKGhF1WW5Aip2cCF1ti7+VV15g7jP9TO1KAZFC0bNa1Cw==
X-Received: by 2002:a17:90b:3ec4:: with SMTP id rm4mr55434086pjb.104.1641257086504;
        Mon, 03 Jan 2022 16:44:46 -0800 (PST)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id oa2sm41467687pjb.51.2022.01.03.16.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 16:44:46 -0800 (PST)
Date:   Mon, 3 Jan 2022 16:44:43 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] tcp: note that tcp_rmem[1] has a limited range
Message-ID: <20220103164443.53b7b8d5@hermes.local>
In-Reply-To: <20220104003722.73982-1-ivan@cloudflare.com>
References: <20220104003722.73982-1-ivan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Jan 2022 16:37:22 -0800
Ivan Babrou <ivan@cloudflare.com> wrote:

> The value of rcv_ssthresh is limited to tcp_rwin, which is limited
> to 64k at the handshake time, since window scaling is not allowed there.
> 
> Let's add a note to the docs that increasing tcp_rmem[1] does not have
> any effect on raising the initial value of rcv_ssthresh past 64k.
> 
> Link: https://lkml.org/lkml/2021/12/22/652
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 2572eecc3e86..16528bc92e65 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -683,7 +683,8 @@ tcp_rmem - vector of 3 INTEGERs: min, default, max
>  	default: initial size of receive buffer used by TCP sockets.
>  	This value overrides net.core.rmem_default used by other protocols.
>  	Default: 131072 bytes.
> -	This value results in initial window of 65535.
> +	This value results in initial window of 65535. Increasing this value
> +	won't raise the initial advertised window above 65535.
>  
>  	max: maximal size of receive buffer allowed for automatically
>  	selected receiver buffers for TCP socket. This value does not override

Why not add error check or warning in write to sysctl?
