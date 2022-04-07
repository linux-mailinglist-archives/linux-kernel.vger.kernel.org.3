Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9819A4F850A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345744AbiDGQeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiDGQe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:34:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD3610E044
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:32:29 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id d3so4605750ilr.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 09:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JEVCSVa2kO7r3SGWX5+9u7hC5QkOYO/9mir7SA/IMv8=;
        b=JP1Z24SeYFtmRJmQyVEDHOrxgo7I14gpg6AYZSHXD2GVllfvfRXPPg6uf4etKITvGC
         b79hXfKkEiB5wXxJ0wKl2stMu+9hcqmzZ8crtCiamIoU/DXUwd4C7S7R++A4JdGBVp3Y
         LyzW0KvevdoDUXYJCA6/HyJwqIW6hyqHAoORM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JEVCSVa2kO7r3SGWX5+9u7hC5QkOYO/9mir7SA/IMv8=;
        b=QLOs6L/dtsveeQzH5KgYEy1eUZ9MD6ywp2CiaHWSmi86xVz/6DfHb4pmESECyeNGOe
         n2N2klTGYn95O7W8/IXcu94zXH0QCT0p0sRMo6YoWRP3ES4+olOKSe04mOKjj52yos3p
         UKTSx3m73FHkf/Kqlv3qSPgxrj1cgndW6tRPbvi70JOwf38ZhLwCMSFgCGLli5WFkhD/
         jHQBzhbgzi226xIZYogBRJczDkEr8SCibT3evIVreP69Y/xiwkZkQKncwxpmI6xYgJLX
         uVLizEX6xdYu5Z8q9MW+shbKB2sXUcW5sUR4UFlF0YD+rUAWV8bICkBdDjepppLFDHTr
         X7Iw==
X-Gm-Message-State: AOAM530KGzFS1QLS6hZMdl9ofkm8g288qy1zJE/gMZqD40frdfd3Hd+N
        ilc9uJoBAx1l02ZhT/OVCn8LRw==
X-Google-Smtp-Source: ABdhPJw/B+LhoLyzb+iIISTjuUpXRw8z3Ou7H+BpZLFL9iNh8XrCuhiBhK2YtxDtLaBrdZYuzXpAxg==
X-Received: by 2002:a05:6e02:12ce:b0:2ca:3c80:3abc with SMTP id i14-20020a056e0212ce00b002ca3c803abcmr6991714ilm.47.1649349116808;
        Thu, 07 Apr 2022 09:31:56 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d14-20020a056602184e00b00649673c175asm13433057ioi.25.2022.04.07.09.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 09:31:56 -0700 (PDT)
Subject: Re: [PATCH v2] usb: usbip: fix a refcount leak in stub_probe()
To:     Hangyu Hua <hbh25y@gmail.com>, valentina.manea.m@gmail.com,
        shuah@kernel.org, gregkh@linuxfoundation.org, khoroshilov@ispras.ru
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220407022204.10730-1-hbh25y@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7c584e2d-1c23-3df9-7e4e-c4d9a9014224@linuxfoundation.org>
Date:   Thu, 7 Apr 2022 10:31:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220407022204.10730-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 8:22 PM, Hangyu Hua wrote:
> usb_get_dev() is called in stub_device_alloc(). When stub_probe() fails
> after that, usb_put_dev() needs to be called to release the reference.
> 
> Fix this by moving usb_put_dev() to sdev_free error path handling.
> 
> Fixes: 3ff67445750a ("usbip: fix error handling in stub_probe()")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> 
> v2: add more description of this patch.

Still missing details on how this problem was found. Please add them
to the commit log.

thanks,
-- Shuah
