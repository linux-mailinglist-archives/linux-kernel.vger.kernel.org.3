Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645F35AC578
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiIDQkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiIDQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:40:06 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA42219C02
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 09:40:05 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g14so4805400qto.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=NTA+zunzSlCxrnVf2AHRDc12WKM2hdVoPjm1WQ2RHkA=;
        b=U8WIwLsOpTbpEgLwzWY4IMVI4cWimZ9XiAzgCxW/L2hv696AKIanVSS4y2yTzIh4bT
         LRtQFPGjQClljre0Q9/2OljT5kLyaSh6OsCzrQWBsquEeroCj05/PHPB/LN+gI3Oji82
         2jfjv7daAE4a0uyHjF+8agbRYA+/3sEFet9iHpUG4wNvCSgAHVJh9q9g1XuPMNkqH9oZ
         2tAINimA3kAwxWQre6Se9LUNPJAdMk5vMi1mE3wHHCvjxo8JK5i5pdvwk1xSoejafkL/
         sqXiWn7TwCeELbJRpXQPxON60AQ68LhVIv9QkJfUSUrwEiopFh31+K8j15bv58n21pg6
         LvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=NTA+zunzSlCxrnVf2AHRDc12WKM2hdVoPjm1WQ2RHkA=;
        b=soteMozKfPHgxNyVM8kfnrJgCS3ePABnqzcgLjVaijgP7l5S8M8ldYCLzJD4BbG7El
         VZeInIioKEzLBG1tBS8bBlf4B47NLdbmgoNC2peNXXhe8YNxKHH3kqiaOznva6khsl5M
         +5QBE8QKbTf6PntFR6q0PNX+JF5GgMgBNE3j1lraLVrTicNVWyddEk93sKxVw9nWaz32
         953qmEjWchdrHN2VoV+p1iiFio+7WFawLRitEF9FC19BxDm4jXmV0ETHfodD23/w/Cbl
         /1dtQH6tr1d07ywjl105syiTnDUXAExmtPZp0O2Z2XgL+1igKvuAl62XWmDHaubgyDCu
         2jkQ==
X-Gm-Message-State: ACgBeo2w9aHUmfEymv2L5MZLQduCt5C1ZPFRpRq56d8ONUalWoVgNIOZ
        xwTnI02GGtHLfkK8Ow9H51CmJ8WUZw==
X-Google-Smtp-Source: AA6agR4P4fN0ZQBisEk1U0415ydN1Sk9aqMskSMRjK0nrcQdEpuQG3HAd8xdtfTxdxjBjsurlQe8/Q==
X-Received: by 2002:a05:622a:181c:b0:344:6399:d8c0 with SMTP id t28-20020a05622a181c00b003446399d8c0mr36529566qtc.334.1662309604971;
        Sun, 04 Sep 2022 09:40:04 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id bl4-20020a05620a1a8400b006b9526cfe6bsm6244034qkb.80.2022.09.04.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 09:40:03 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:e25f:adca:563b:692])
        by serve.minyard.net (Postfix) with ESMTPSA id 5ABB81828A0;
        Sun,  4 Sep 2022 16:40:02 +0000 (UTC)
Date:   Sun, 4 Sep 2022 11:40:01 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi:ipmb: Fix double word in comments
Message-ID: <YxTU4WU3KRco14YL@minyard.net>
Reply-To: minyard@acm.org
References: <20220904160220.30513-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904160220.30513-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 12:02:20PM -0400, Shaomin Deng wrote:
> Delete the rebundant word "response" in comments.

That's not redundant.  That's a "response to a response".  It would be
easier to read as "response to the response".  I'll fix that and the
other obvious typo there.

-corey

> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  drivers/char/ipmi/ipmi_ipmb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
> index 25c010c9ec25..0966e95666ea 100644
> --- a/drivers/char/ipmi/ipmi_ipmb.c
> +++ b/drivers/char/ipmi/ipmi_ipmb.c
> @@ -219,7 +219,7 @@ static void ipmi_ipmb_send_response(struct ipmi_ipmb_dev *iidev,
>  	if ((msg->data[0] >> 2) & 1) {
>  		/*
>  		 * It's a response being sent, we needto return a
> -		 * response response.  Fake a send msg command
> +		 * response.  Fake a send msg command
>  		 * response with channel 0.  This will always be ipmb
>  		 * direct.
>  		 */
> -- 
> 2.35.1
> 
