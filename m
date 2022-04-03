Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C624F094B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 14:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357571AbiDCMQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 08:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350377AbiDCMQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 08:16:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2896333A01
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 05:14:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k23so11209793ejd.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qglcsoM2Fho7Dk85XWKMBB8jz/JatTseCQx1G8rPXYw=;
        b=Es/ROWpqvIeaQFC2S730hGopo726Jc77/JIfyPyezax5/kHNN/5yLAVtb67xqtPrxw
         DKH3fpvO/Od6gv1fj+OAE7ad0WUGDLjX1GcMblJOOh1Brbr1Ecrvp0dJ8AXRXOXQp3sd
         N6AHqTsbEX0//Wtga2agcrPRAlYd0HiDdihvRUKuVw1XOEUKdTpG2wWYM84zOa9S56fI
         apx78cfMCHn5cdOgL5pZHohrqRN7wiy5Bo8UFcbZSTkgURlmdOAQWKd3oVmbzCK8R3bP
         111ztmDolDvRgqjswqWt+almaCrsROdiXzXONAqBXAd3WLpkFMSXx9Egj1GsznIdbGLT
         6lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qglcsoM2Fho7Dk85XWKMBB8jz/JatTseCQx1G8rPXYw=;
        b=Pnr9ppwi9CQ+dmU6LzFE2CtV/43m0PBqwrJAedfFlx+1AoOS/wt44bVNOX9xP0rxKu
         dtdzXdLyw/jqyAao0ltr4S7xvlXjfrTUwlUehIsMiwOHP2mAoJ4ohZX0vvNyPqTIyeK0
         /nVhg5UXqbineQ/fEMu9farU5LDTlNMpus6lUNyob9ZHSTuIHeVsFiK3GqbQ4HVNxBti
         whtoBbs3PDyDX+aOZoi5fuX823ccafZ5WBX2zbVXYxwcBEZMfw1HbqjS6DkCPEfcoq6w
         fGJwQ9mdhDho10HjIwEUWG4TCtiXeenJlY8cSstsHIAgqdY8i+JAEONlowPqZLk6ntkd
         rJHg==
X-Gm-Message-State: AOAM532nnmb/ziBDsm0APuGPaQ0OxJV3wTtYzcPtwDFIZ6ziF+53vhaV
        vmZWRLxIGw/Da0X+WODUalmoO06Cqis=
X-Google-Smtp-Source: ABdhPJyClDCQpBerYT11UHE5FcWiHNho6NKGMcBQuUVLs5FD+eC1TPxra3ME5EnRjcZKzwthwXh2yA==
X-Received: by 2002:a17:907:60d3:b0:6db:8b59:1564 with SMTP id hv19-20020a17090760d300b006db8b591564mr6837459ejc.228.1648988060750;
        Sun, 03 Apr 2022 05:14:20 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id nb6-20020a1709071c8600b006e02910f818sm3245154ejc.157.2022.04.03.05.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 05:14:20 -0700 (PDT)
Message-ID: <46a63481-d2e8-6c9d-b00d-a0e384e3f2af@gmail.com>
Date:   Sun, 3 Apr 2022 14:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <bf1137fa-5051-a834-0c1f-042c5a8074a3@gmail.com>
 <3fb13fee-a605-7f2e-81ad-45148082a733@gmail.com> <1817830.CQOukoFCf9@leap>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <1817830.CQOukoFCf9@leap>
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

On 4/3/22 13:56, Fabio M. De Francesco wrote:
> On domenica 3 aprile 2022 13:48:31 CEST Pavel Skripkin wrote:
>> Hi Michael,
>>
>> msleep() cannot be called in atomic context:
>>
>> drivers/staging/r8188eu/core/rtw_pwrctrl.c:379
>>
>>    	if (pwrpriv->ps_processing) {
>>    		while (pwrpriv->ps_processing && rtw_get_passing_time_ms(start) <= 3000)
>>    			msleep(10);
>>    	}

Ah, just another issue...

> 
> I wanted to use mdelay() (allowed under spinlocks because it does not
> sleep) but Dan said to leave it as it is. You might easily find this
> discussion on this list. I cannot remember why Dan was against replacing
> msleep() with mdelay(). Please try to find that thread.
> 

I'll take a breath and look further into it later. Seems a solution like
the one Larry mentioned is reasonable here.

Thank you both,
Michael
