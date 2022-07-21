Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B647A57CDA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiGUO3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiGUO3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:29:40 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C238484EED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:29:37 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id u19so872133ilk.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=dv5Xa3sw79SKXhsKD0ky5VXyt/Mi380ArH09DvLLu8Y=;
        b=1C7Jn5oEOCUSUrknL+Aia81kMhNerZHzhQ/ugPmRb8IiJ5sklVKgQ9M98aigtTU8yN
         eywP/b4dHJfbilEyHZ2I2bNQCoGbB/ZU9rvnjfV715QEnkPCDhcQQWw+Gr2aZD4Ju+Az
         IbbWFbc6LRNXamSm3AQF3DUjsg1bqFN9rnpbOFH9wYMMF3qtxexCnbedtPVP669T5c3G
         5HdbSYo/kPzxiEU/LNQdVFJ3noo+IidPjjwI9kxF28yChhJB3plcD9LCDBblmaMlH4uY
         soFq+1tTkfNLFdBSr9fQqSYHvga/CJRhL5ePJZZaFsxRHdctPHetRfaNaetbiWhLiRa5
         zDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=dv5Xa3sw79SKXhsKD0ky5VXyt/Mi380ArH09DvLLu8Y=;
        b=66S7bQ9mHGscaoOuYKVp2pQtZwryXd0kRtHAEATQCAzW5Hs7Ik+0/zy+saAk+g8S9r
         3jdUyfS4EuL3pj/L3bYE/2qiEIuGv92TOgDFAYGGl7zdoMjtk41KgZ5VV43TJszLpLlw
         XWYOo0xl/pdlyT+dpgH1r8rx5Q71f2cRoIXvor4lTDKSXpqlTa4x9gjZrcEG3Gougf/X
         sTiUmqd64MpUKBoutK7iMwMnV2r9fl8SRjH8tc8DWzjSnwhyfVLSDDMhMrzGqcN4qXuF
         BqJxxEBLa+weVUWO7eLdrxNBkxaItsj/xlo40+Ez7aj3A9agKEt2cSh7lFLn/yL7v7xA
         ZYHw==
X-Gm-Message-State: AJIora9har6q1Peb6h4asbCI6hjhtNX4Fx+x1PeRzvKv5Tphhv85oVSE
        rp/6mWTIDJrbgvPUC2Jr7e+jow==
X-Google-Smtp-Source: AGRyM1tTwb9Uc51X/JBwgiwuTs/fv8uITklVuIU49soA7CMiAzlJW6SnkT7kJxdJY4GiwMG+UiL0oA==
X-Received: by 2002:a05:6e02:152a:b0:2dc:3984:196e with SMTP id i10-20020a056e02152a00b002dc3984196emr20553813ilu.228.1658413777054;
        Thu, 21 Jul 2022 07:29:37 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a18-20020a92c712000000b002dd16300beasm381381ilp.51.2022.07.21.07.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 07:29:36 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, dylany@fb.com, asml.silence@gmail.com
Cc:     Kernel-team@fb.com, linux-kernel@vger.kernel.org,
        mail.dipanjan.das@gmail.com
In-Reply-To: <20220721110115.3964104-1-dylany@fb.com>
References: <20220721110115.3964104-1-dylany@fb.com>
Subject: Re: [PATCH] io_uring: fix free of unallocated buffer list
Message-Id: <165841377614.7746.5269980516216984960.b4-ty@kernel.dk>
Date:   Thu, 21 Jul 2022 08:29:36 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 04:01:15 -0700, Dylan Yudaken wrote:
> in the error path of io_register_pbuf_ring, only free bl if it was
> allocated.
> 
> 

Applied, thanks!

[1/1] io_uring: fix free of unallocated buffer list
      commit: ec8516f3b7c40ba7050e6b3a32467e9de451ecdf

Best regards,
-- 
Jens Axboe


