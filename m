Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1C74FE417
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356722AbiDLOq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbiDLOqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:46:55 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F6BA183
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:44:36 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e2a00f2cc8so11525836fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rY6b4Cha+4+tNB8Pe5EB9gbUIN/2B2C73pXkmyewtts=;
        b=h52PHqsVBf6x5MwcgRmqywyRnHupk7jLRhBbSS3EiExbZLToXqg8TsoZFRyY3acwjn
         0guxxFmbhbRecywCbpVLvlbUzlf9oUvl8N0Ww5B4wVJCr0HX/FU0/VvHTQObkC3o/tHV
         wZPWtPc70D+JeGBUNbAE2Ph8zJg9+oH/n8q+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rY6b4Cha+4+tNB8Pe5EB9gbUIN/2B2C73pXkmyewtts=;
        b=xKgdAXHDpPlvUodc51D8GMEAOIEmXfdTjawKB0qhKkUvBX2rdmrT1jkk9P4ZbOaCuU
         GU3Xz5JOkknqkxIwg4fah01TWYVnlrKyP2QNQbFj8Yq85FT/prCBzq6aITxlSNMOdhw1
         hnZD2HA1EpCb6OgxUtur3owY/ePn0K1GCkvMw9e4VUrZewvSOi2oTMiEVtpvtY0h9AWN
         pa9tayqvq01MeZDk+iFR8xzpVQihsc7SkfdYWkBxXEM027uU+ursLhn9OjBPUVnwLnmF
         QvjPkEMUBbkMH8wNsXvex4khIgv0SGEjU2wT+rBZNPOHuXamc/TssEHWXFO5jFAGCyOi
         X/9Q==
X-Gm-Message-State: AOAM5303p1Iybu/Swgup6SVOJNDLlIHEDxe5+QDTJFxrJugRvwiEawrY
        CMNce3KvblJHFmSqVANll41XCQ==
X-Google-Smtp-Source: ABdhPJzSYxgWK/tMScpDbAL/LJ5qvKr7lSz6bmGGfa3TUcEKF57oHtGN4oa3mRYTV2St+sOzvNrW+g==
X-Received: by 2002:a05:6870:8907:b0:e2:a4fd:7539 with SMTP id i7-20020a056870890700b000e2a4fd7539mr2271798oao.56.1649774676113;
        Tue, 12 Apr 2022 07:44:36 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b188-20020aca34c5000000b002da579c994dsm12364497oia.31.2022.04.12.07.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 07:44:35 -0700 (PDT)
Subject: Re: [PATCH v3] usb: usbip: fix a refcount leak in stub_probe()
To:     Hangyu Hua <hbh25y@gmail.com>, valentina.manea.m@gmail.com,
        shuah@kernel.org, gregkh@linuxfoundation.org, khoroshilov@ispras.ru
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220412020257.9767-1-hbh25y@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7d8a7ae5-9553-bcf3-55d8-57d5df6375f4@linuxfoundation.org>
Date:   Tue, 12 Apr 2022 08:44:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220412020257.9767-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 8:02 PM, Hangyu Hua wrote:
> usb_get_dev() is called in stub_device_alloc(). When stub_probe() fails
> after that, usb_put_dev() needs to be called to release the reference.
> 
> Fix this by moving usb_put_dev() to sdev_free error path handling.
> 
> Find this by code review.
> 
> Fixes: 3ff67445750a ("usbip: fix error handling in stub_probe()")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> 
> v2: add more description of this patch.
> 
> v3: add how to find the problem.
> 

Thank you.

Greg, Please pick this patch up.

thanks,
-- Shuah
