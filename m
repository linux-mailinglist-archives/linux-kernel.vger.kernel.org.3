Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA204DEA6D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 20:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244046AbiCSTfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 15:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiCSTfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 15:35:10 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA41D2514;
        Sat, 19 Mar 2022 12:33:47 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v130so21480837ybe.13;
        Sat, 19 Mar 2022 12:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bd/GYmxSnWpEDUaDammlbdEhr4boXLzos6QsaB8Zkro=;
        b=ql/RSH5UOtUxSto+/R8XpZM1cH0qzPYK4hFTsOETo5ypzO5z+c35LiY0XDSaiaxCyG
         uyGtzdFPCK8TbzKZPlnbS5GY2Xn5fhmaXec1BhlOPQyVaNvLGYgQNAZsa2dD5OcB3FC8
         UeroReE42PXGnkZgydkluWxOHgWyeW5CWZNPDnNZYfbUUlTHeVTMmvSdtp1gxje8p2Mj
         jAKxWs9TWI8aiydWhpwgpmu4DEA70qVZ+dSS5GYiuvCsHSOyKRrzKzADVmPJRMDXX50t
         19rWfppy7NC88esviymKtCWkr8wTOZpSDR+3/VRsSZbX1bfqkY/Cm7C9NvOKJsbXVqsL
         pGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bd/GYmxSnWpEDUaDammlbdEhr4boXLzos6QsaB8Zkro=;
        b=x1TjB9DhhhW9aFNjCucXj40mciunMm93fupRVjBIzKmIJUaRHkHUNK+Zj1L17q9zRA
         /4mpOzZU8VFhhfPtDSL+4H5qVw3PZymVO5UfPCB+jaz9jU5OO8nWpfrU/SWvSGspwMB6
         8m2pSsTa/QMtLcYf1WfUzoqtc6qhBXqkEgwyITDjKrsQWX2dMAitGh1mUmgQEsV5KF56
         fuMuX9dNQIi18CUpgPjR83YNt9fAKT39igse2B40YkDnh8sqmIeb6e6JjeAss42uKXz1
         xafZcukLg0nASjmpWhcICI6HnXIv40ZsE04I2DQtkhxDMJtOkUYay+jF8bfFcDAnEsAI
         gSnw==
X-Gm-Message-State: AOAM530YnVIukkcd27MTcEVM5PyubY40OaoLVqRidr2cpWPKP4Zdt+pn
        E98MBo/7XU70FVMKYFYXeYLMzQam+kKCUUItI14=
X-Google-Smtp-Source: ABdhPJwC99xQJjRHGmcsKLKEnznbFGOA3bmdPGS5IuckxO1Gh7HRl3WCC2VomXO6fXScBehm3f6gREVyVgkmfuq8h2w=
X-Received: by 2002:a25:d504:0:b0:633:38b1:1d28 with SMTP id
 r4-20020a25d504000000b0063338b11d28mr15349978ybe.584.1647718427136; Sat, 19
 Mar 2022 12:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220318070900.2499370-1-ztong0001@gmail.com> <YjSTK4yun3kiulB1@smile.fi.intel.com>
 <20220319162006.13c60c1f@jic23-huawei>
In-Reply-To: <20220319162006.13c60c1f@jic23-huawei>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Sat, 19 Mar 2022 12:33:36 -0700
Message-ID: <CAA5qM4BDCCaz6X1pNaU-9+2OVSEnFnOX_Hqh_SSY=S0DfmkFpg@mail.gmail.com>
Subject: Re: [PATCH] iio:imu:bmi160: disable regulator in error path
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Jonathan and Andy. I will send v2 adding suggested fixes.
