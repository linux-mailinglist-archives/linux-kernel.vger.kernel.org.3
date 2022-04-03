Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB53F4F0925
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357175AbiDCLuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238327AbiDCLua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:50:30 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3768F2B0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:48:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d5so12412582lfj.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oOTGeK/fBBSylHFUjJjIrij7LyMZ635R4iqHI9V3GZY=;
        b=J7RUYuRuK3gLqIL3lh93xMbkwaevjEZCFPh6ZVQKhFkbS40MZZZ7DhyVXYQvRe4QF8
         awH8zLfUYrbRhS3brpLGDloe6rXsr9oQcniBE2HEib4md7GR5OsIqqqS1CH2OnvRxkJ5
         F/BOGASxXEe2QMwzKx1zRDlUojaMiqXeGkIp58F6Fti68zsaj5Q6x6oZoFveBnwDQ0Li
         FOm011adxpyaK+qvC+aGqxc6WQkTRdA6ZYEQmEpr7XRvL2++R6VOO3RqZ85JxDJd97nt
         YjGpIYcv57m3au5DE47p05yfhJTyNzLoEiYz9lEGOyyEtHVbVXWIDTTlrZUeT9DMk6zA
         fE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oOTGeK/fBBSylHFUjJjIrij7LyMZ635R4iqHI9V3GZY=;
        b=DnF3MmQchImtntXgrNRrSZndhLxyJ01bx2S+9XjRj+vuv1VSE4QPpLlZ8zCuG8MBrd
         hQEtG/Jmd+ySrRqnbqSqtfyItZy6s5zmHLkRT9NwYochcin+pYMhKZHw5+kBBlrUzvF1
         J3TsN1W+A/BNPIp96lmwAPi2QoTmcj38VVrKs/v29cVf2S4uxZGhZyreA4mIDBfG8/pH
         v2rZVwSr1IodkzwvlXfhbZqQybzqI6nTTwJ1QljrE+jgYUf04rhozL0qdi7ThK/xaR9x
         df7HVLIk/QYlu29/4vn5PdJEeLG7V3UckVHwuznM+db2TapxWKyjU74XcL8d2Md5y7v3
         stUA==
X-Gm-Message-State: AOAM5310FJS9680pzaluurciXIyvnYb3XmXwqahIcfhDeS4cCjOBEJF6
        iAl063VIgP+n4fNk0gSPnwk=
X-Google-Smtp-Source: ABdhPJyNdDN6cJki6ehM3psvSt8BFf2cT0dipYkWjWJ45k7HSVuu2g4N8PpbG+NTdOXnrrOLTPyIQA==
X-Received: by 2002:a05:6512:3b81:b0:44a:d39c:6c7f with SMTP id g1-20020a0565123b8100b0044ad39c6c7fmr9929114lfv.129.1648986513458;
        Sun, 03 Apr 2022 04:48:33 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id 11-20020a2e154b000000b0024967cd674esm757347ljv.35.2022.04.03.04.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 04:48:32 -0700 (PDT)
Message-ID: <3fb13fee-a605-7f2e-81ad-45148082a733@gmail.com>
Date:   Sun, 3 Apr 2022 14:48:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <1813843.tdWV9SEqCh@leap> <942bbcb6-725d-9b47-5dfe-f105d30ea6b7@gmail.com>
 <7365301.EvYhyI6sBW@leap> <bf1137fa-5051-a834-0c1f-042c5a8074a3@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <bf1137fa-5051-a834-0c1f-042c5a8074a3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 4/3/22 14:41, Michael Straube wrote:
> 
> Hi Fabio,
> 
> wait..
> 
> rtw_set_802_11_disassociate() calls rtw_pwr_wakeup() only if
> check_fwstate(pmlmepriv, _FW_LINKED) is true.
> 
> 
> 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> 		rtw_disassoc_cmd(padapter, 0, true);
> 		rtw_indicate_disconnect(padapter);
> 		rtw_free_assoc_resources(padapter, 1);
> 		rtw_pwr_wakeup(padapter);
> 	}
> 

msleep() cannot be called in atomic context:

drivers/staging/r8188eu/core/rtw_pwrctrl.c:379

  	if (pwrpriv->ps_processing) {
  		while (pwrpriv->ps_processing && rtw_get_passing_time_ms(start) <= 3000)
  			msleep(10);
  	}




With regards,
Pavel Skripkin
