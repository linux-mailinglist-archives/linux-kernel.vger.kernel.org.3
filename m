Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA93501C69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346143AbiDNUOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiDNUOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:14:47 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6C5E8843
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:12:22 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r18so7456044ljp.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C7Dpx8L5PzGi8MBDFzzJb1vldbU1zpGfPhld97bZSAs=;
        b=gmjchlWALI17UFCdID3TR9EBYjsHEeMNZLijEWhQIsluZarr/j6DhtUPjiBWXWLynk
         VRW3lL0sBBVPAPytXrHxMu/gBxYsB87pXHGYRigm3pP2hRtv508GdwYUFpMv1YWdJpSH
         3Satsf2u3iPdfj4mE3Q7NQ0KV1GvTUE6jmCpkjmQSGf8iySi/Y24Pi+YEkvfwwi7obmA
         SXnnWPM41VosqFZkbvMWQSqDKZ84bF632iriYGKNL/sEjxVLp6j7cDbxdrFakBOQvvOX
         nRy0//qbWYbkotnjB/de15PjyOuo74A/S2uluslNPMHmQTeiX3ea26xqqUoUmT4NX49t
         PgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C7Dpx8L5PzGi8MBDFzzJb1vldbU1zpGfPhld97bZSAs=;
        b=OpUWHX5tLMjbQdJD9RZd5y8GqFrLoZ08V5dxxALbRwq89FUMXbKePpGbd6ebqy5LX2
         DrzkECcMqXndWr9/AeiTSFvkHOLrASir0VQBngHSW5uqKD85u2owMkqCWsqg+wdRGGIg
         BEHPcioUwiiZ70zZY+nPhd6E2DysbT8pzcbpwSaVWWDMOs3n204P1texnXc5TpeOKTS8
         asRJAVLgOCvlmG3QxlVF7tbvPZtS2gRRaUCTME8Yo9Pc/9ynvFbwxYHFfRlpTaDaNXyU
         Qd6eKJRbyFVLJTRy2XdQgSyZp0kGcM4vGyoF86DJCLX8xbmp9i88UPV21Kya/7AzeQIF
         C9yw==
X-Gm-Message-State: AOAM530KIP2YzLePdreR5Fa2THsq5eWVOeWCMxSXtwdss5CXsA997t7p
        xdRKmuJyX3eE84jPgEWOgjY=
X-Google-Smtp-Source: ABdhPJyemqW4EyjQt67Jy4WtBGwGHgtgq6zSrJohnxe9v0EvhsP5qdKqIJxfQD/Q1yOorqLVmGSUfQ==
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id e10-20020a05651c090a00b002495d82fe9cmr2540794ljq.300.1649967140450;
        Thu, 14 Apr 2022 13:12:20 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id w27-20020ac2599b000000b004481e254f08sm95301lfn.240.2022.04.14.13.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 13:12:20 -0700 (PDT)
Message-ID: <68484555-f763-bc42-eb4c-9cea2ee8dadb@gmail.com>
Date:   Thu, 14 Apr 2022 23:12:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: rtl8712: fix uninit-value "data" and "mac"
Content-Language: en-US
To:     Wang Cheng <wanngchenng@gmail.com>, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220414141223.qwiznrwgjyywngfg@ppc.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220414141223.qwiznrwgjyywngfg@ppc.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On 4/14/22 17:12, Wang Cheng wrote:
> Due to the case that "requesttype == 0x01 && status <= 0"
> isn't handled in r8712_usbctrl_vendorreq(),
> "data" (drivers/staging/rtl8712/usb_ops.c:32)
> will be returned without initialization.
> 
> When "tmpU1b" (drivers/staging/rtl8712/usb_intf.c:395)
> is 0, mac[6] (usb_intf.c:394) won't be initialized,
> which leads to accessing uninit-value on usb_intf.c:541.
> 
> Reported-and-tested-by: syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com
> Signed-off-by: Wang Cheng <wanngchenng@gmail.com>

This patch will just hide the problematic API in that driver. Correct 
fix is changing usb_control_msg to usb_control_msg_{recv,send}.

IIRC this driver does not want read various length requests, so it 
should be fine




With regards,
Pavel Skripkin
