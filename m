Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EA552EE4E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350362AbiETOha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350377AbiETOh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:37:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527BD170F1F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:37:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j6so7905536pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Ft39s9YnF4jUcvzq1w5kbMMaYHzsE+zHP2eH0w8U0EY=;
        b=PVRBBNJUqNpXpWS52H3xdQX/P/MsjRNLghetF/hCiTEM1OrfqCQ4sAJYhw3z7UTA3c
         16lmT+qKKEvTZ6VaUC7metHid/flN6WI2MAb7AU6Fho9hczvIGMcj5iakR0ucHw4ERbm
         B/6w+59k5md5YG7Za1rgmfh95+7R1jpCagZ6ERhbFO+7kZnppj4E732JK/73xnYbXRrX
         NlfBAsX2E66S5YJcDOlG4l2z4Xn8Bye2VHjP18nLGqmkKjTbkATYh5bM1WTsTTiHHWxT
         pAfHkDnLJTlG7YUkv82iNsDMhG1CFCgDEptTBO1TnA3tjFkTxNAPR5O5eoiiDxrYz7G0
         7z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ft39s9YnF4jUcvzq1w5kbMMaYHzsE+zHP2eH0w8U0EY=;
        b=thsp5zJt4sUX988gwWYDxbZynnJVLDd1CDAFxqeMzgjAwkewu9uKmXwKQxUHWrXKBS
         7GSPGOEabNgFaNttZU73DDFutX7iCvK8iWQI6EK0fyZfCaFyM8sT0MhXSwgUDKf5HllY
         dsQ03gdfbtV7RwWgc90Vq8Bp8n4ABAM9zzZLqpHqIDtqFDPEi7mG3qyOZnE2ulSg0c/v
         MK+H1NmYG3EA374sMCi3IKTfq64LU5vSD2Riq6G9M8APH16FnLT7aD+/KHgMgAgOlYDW
         l6SrCVzgIYZ7Kh3Ad9GbL/oojA73oWw72DfgQ7ONsgoKNizFPmqF5SP8uIKg2ZltTFuR
         J4YQ==
X-Gm-Message-State: AOAM5322XkvluMPmj2G7laqv0TFRWYHDxubZ6vqdTWZ3O11vFHTVSDTt
        RR/ZHuYHvH7yaoGgivYhQUa4Cg==
X-Google-Smtp-Source: ABdhPJygloC7AYK6iNI8gFmXE42/H9Z2I8/vO+Kho3jD0oUSnd0bkZGt2GgWiKM+vJndd8l/vE8sFA==
X-Received: by 2002:a63:d90c:0:b0:3c6:4ab4:fbfe with SMTP id r12-20020a63d90c000000b003c64ab4fbfemr8819887pgg.499.1653057445575;
        Fri, 20 May 2022 07:37:25 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r19-20020a63fc53000000b003f60a8d7dadsm5195525pgk.15.2022.05.20.07.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:37:25 -0700 (PDT)
Message-ID: <aa51432c-7d23-5758-6dd1-a7f364a0cd89@kernel.dk>
Date:   Fri, 20 May 2022 08:37:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] fs: prefer read_iter over read and write_iter over write
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
References: <20220520135103.166972-1-Jason@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220520135103.166972-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 7:51 AM, Jason A. Donenfeld wrote:
> Most kernel code prefers read_iter over read and write_iter over write,
> yet the read function pointer is tested first. Reverse these so that the
> iter function is always used first.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

