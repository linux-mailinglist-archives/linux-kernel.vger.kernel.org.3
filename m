Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3846D530537
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 20:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbiEVSh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 14:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiEVSh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 14:37:56 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E7938D9F;
        Sun, 22 May 2022 11:37:55 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id i66so15562557oia.11;
        Sun, 22 May 2022 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HgD4/UV0T4CMdJdyNWhiVY1tdpZnMQ26PVn3Eujh3Yc=;
        b=WvehMKF8LnI95IfxYZ3GUOdQRX5ypxSVD5hkUqgbmXIFNBWFP/viptKfu6hDaxaHvP
         ixG+aK2pOylKSsacX4PUSPQcVe6aNVmFNTDTPg+uH5VBsHLhXvcLMVm/SFlPBaWUc1NF
         vGtw8fm+Wyt5a2xeEneYdi3N0E4AcTVFCmmVYznxN4dx0Vkuqzj3mllAUaFlCaLvnih8
         xKHTb9d8Dex4JryrA4EXUSb4nwAJMlQ8dPPkoVR4VPjKERGCHbP94TTVcBzZI4MjaWCk
         Yz91uOaOnvnsVXodugamnNWQdoqy5XkwSBs6QxgNKGblJgfMiFx6+MuX3YBEY9xvCF1Z
         t17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HgD4/UV0T4CMdJdyNWhiVY1tdpZnMQ26PVn3Eujh3Yc=;
        b=VerQskb1RzOGpTmMxWQuPtugZkOtopqYfVjZBxK6WsBOvEu8qCaTgyyhKHQuzQBJcm
         fxHQGA0iFBgWDYBEVMn6r7nBbOLMg8pne9Vt/tbwlXAuG5hkXo20iidC/Cq5vcwuNhpS
         ARMEoWT8+XsxWBOOQ3P/eM610zr1BWecam1FeUxcVJtXRMzYcWltYczCiEe4o9LBTDEv
         O0kV5iuJwrvLUt2uzjS+3yzjz9sxGLqVkUrYrsbofdEFV0d6cEMYn11lZ8SzuCeRREFR
         9jGz1cNi1YELSgtwx7MyX1yeoYhpObcn2iO7tOd7ZX2nOH/Gk4I7AKMNXcnNmkXJu6o3
         tq6Q==
X-Gm-Message-State: AOAM531s/AFKZ55VfOq2nxrZAvSg/t+6EUL2oY95E9qg5eBZFxOjYFOo
        84XxVpULVOqojFbY4CCHod0=
X-Google-Smtp-Source: ABdhPJxO3FfL9cUMqhzrHkeyOF9WvfIKh2UANKhgd3xSmIY9DYKejRkV3FdAm6ee7Cqf50OhiFkJfA==
X-Received: by 2002:a05:6808:1189:b0:322:3293:4b30 with SMTP id j9-20020a056808118900b0032232934b30mr9512923oil.277.1653244675086;
        Sun, 22 May 2022 11:37:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2-20020a056870920200b000f2776dd2acsm82709oaf.27.2022.05.22.11.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 11:37:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e2a64cca-add2-7fcd-0327-5d217f1d3762@roeck-us.net>
Date:   Sun, 22 May 2022 11:37:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Fix an error handling path
 in aqc_probe()
Content-Language: en-US
To:     Aleksa Savic <savicaleksa83@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.carpenter@oracle.com, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <be6b955d50de140fcc96bd116150b435021bf567.1653225250.git.christophe.jaillet@wanadoo.fr>
 <YoqCKdfYQKyrFtxN@DESKTOP-A98GP49>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YoqCKdfYQKyrFtxN@DESKTOP-A98GP49>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/22 11:34, Aleksa Savic wrote:
> Thank you Christophe!
> 
> Aleksa

A Reviewed-by: tag would be useful.

Thanks,
Guenter
