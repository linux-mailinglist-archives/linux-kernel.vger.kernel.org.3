Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F409C5B2734
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIHTzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiIHTzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:55:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8770A3AE79;
        Thu,  8 Sep 2022 12:55:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k17so11582474wmr.2;
        Thu, 08 Sep 2022 12:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ze639+PCW1w/1gzP9YrJsTcy8enh9M6YW+cBRHStBHM=;
        b=eI755+/JrHuVT4ZUClHcldAg3qKaDAIl8ZYYAjjL/iFC0VYHY/D6VN4Z7N+zZNsQe1
         8mBNw9wWVip4sybiJ5OmLV6lPSagGxbea2maGdvwG5LgnZxIzynrWXCznblZADSNOeBp
         4iXCde1WgUlinCzu792ngEaRVZ9wcYjConrodIm6PwfPtk8NeLovUJN7W2F+o6km1eWB
         fMyLSwg2gK6bTFWFY3SUVSx266ijChnkgL7J6zF+irSXh53W9vHV2dC+690LhNbVFPS8
         krkNWsEGNgglpDyJnvIqHe416220WU85RKcuO6PqqhR+wc9q/LnM5Nc04WWmfIAzWjI2
         BYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ze639+PCW1w/1gzP9YrJsTcy8enh9M6YW+cBRHStBHM=;
        b=rNwW8SC1FkfD82RPqDlcaaKkdKK+h0z3v6/owcmiqtYjWLjFamqV5ClwqIO4M3ryum
         Nhdj1slhbsaefVph459KAFZHsMCHl7pasmdEmfZOI27C06ba5RY6Qa7Lz9nxoxQcPBB/
         /1I8COi2jjLXxw4fURCYOS23Fp+L2eopaZZBNmYZoBGC3zFb3t6vTQK5HsTjT+Q0W9Fl
         HiFqkrlLYWmPYlq2DlPK4NsRiIltJ2p5JoGrI+eSamkni1/+7ZC0nei/NhqEpeDPv9is
         6Qu0Hlz63aDzuc1/m5lahgSu0Tqo3xpxPRl6GvZR8ELDBuCErSViDqVgr3/5zcO2cmLW
         cebQ==
X-Gm-Message-State: ACgBeo2Mq4JKc3O2cAjlwjPpL1LEWj0D/qyeKkBGXcdFC7quddhcQYu9
        /5lcPS2jz3nCCggc5a3stKQwJn9Jt5xfrg==
X-Google-Smtp-Source: AA6agR4uOK9Y+XgtBif61scKKj69FBQPUc6mobXPQibWu1bZU2IkD3ZcYROeOEjv2Eq3erchmhaVng==
X-Received: by 2002:a7b:c848:0:b0:3a5:41f6:4d37 with SMTP id c8-20020a7bc848000000b003a541f64d37mr3495955wml.23.1662666911070;
        Thu, 08 Sep 2022 12:55:11 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d4302000000b0021e51c039c5sm21346668wrq.80.2022.09.08.12.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 12:55:10 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, wens@csie.org
Subject: Re: [PATCH -next 1/3] clk: sunxi-ng: sun8i-de2: Use dev_err_probe() helper
Date:   Thu, 08 Sep 2022 21:55:09 +0200
Message-ID: <5296377.Sb9uPGUboI@kista>
In-Reply-To: <20220827094151.3323450-1-yangyingliang@huawei.com>
References: <20220827094151.3323450-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 27. avgust 2022 ob 11:41:49 CEST je Yang Yingliang napisal(a):
> dev_err() can be replace with dev_err_probe() which will check if error
> code is -EPROBE_DEFER.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied all three, thanks!

Best regards,
Jernej


