Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4A9567575
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiGERVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiGERVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:21:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51A71F2D0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:21:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y16so21669103lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 10:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LBrUJU1OxaLc3a1NUAUniiflOroxzr7h0e1+YimfCmc=;
        b=yHU8071L/Dc1Dd5xMXJPKAl6QgqMp9H8ecbHxLqyBFhLDAAXAizmd6gA0Sz415y2Wz
         r17h2IFKHZQliQu6WCCCDlIxyQH+aSqafDedO1eHPUA7skiA3dlUfRdWWTwMw5e5cAs4
         nmS5UAbt75r289sZj8S4BLqVW8vXCwF2ah4oMHiBmDanJfg+/XT0S0ppNBYrhoE3lhfE
         uAf8hyHXPDTo7+kd0ePEJmvN+4P5pzaam6VArfO93mK1FShxWW+CvmmW6sJQsONGDEbK
         vt0f8HFTwtp59Ik4A3gCaVUjLOuWjLFYm+caTVgX4a7Up9AWtJd+slBOCWDYXJGLeUUy
         ZfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LBrUJU1OxaLc3a1NUAUniiflOroxzr7h0e1+YimfCmc=;
        b=fzMPANeRUVOgepJVR2jwol+v7+qfQnICPbOdbs6fVzkTBQoEXiMVNdA19G07DbdHDj
         0JjfeTfZmDfvLR/sCo3aciJDkgoppT0MaOB1rgUl6cPIZgT9TcFVqHhPNz1vfvObNmip
         58JhXmNRaS9fDoOvSTTPwQUPwZD1+Y1/Xx76hlxwqArB/zh5nL6+pudw0fyIPO56YSRa
         4/UWlBJzV4AVAZbxdkRgOtpcBJq+1jW0v0UQS33fzxpz/zlrtKlgJdUm+WI5g/MgwmM7
         zT0HJ2uCUrKM2MRjDB0cxh4R/+Mt3dvKbiSKtKzQ/zRBZsuz4fiBYMJUSLpY+MvAnp88
         W6Fw==
X-Gm-Message-State: AJIora8vbqEj2kSQXD5AkZavRX1GYMkVZVBjZWjv9AFWcJDQeWavpcrs
        u4cKgZCtqA1Xtbxnhpwiz4SzrQ==
X-Google-Smtp-Source: AGRyM1srO23IxMNPr3M+wSImTNYHEpYUX54PkoZGBWDlguJDCbU2Eod7/q8lRXytKxURFIU+HfTmkA==
X-Received: by 2002:a05:6512:3d11:b0:47f:8fe3:8e98 with SMTP id d17-20020a0565123d1100b0047f8fe38e98mr22634217lfv.53.1657041663194;
        Tue, 05 Jul 2022 10:21:03 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id f9-20020a05651c03c900b0025a79b7fb7dsm5683463ljp.93.2022.07.05.10.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 10:21:02 -0700 (PDT)
Message-ID: <df997015-df77-2bcb-1551-6e8da4acb36a@linaro.org>
Date:   Tue, 5 Jul 2022 19:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 09/13] OPP: Assert clk_count == 1 for single clk
 helpers
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
References: <cover.1657003420.git.viresh.kumar@linaro.org>
 <f039572f213ee49125d3d1ea4e64a94b79778426.1657003420.git.viresh.kumar@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f039572f213ee49125d3d1ea4e64a94b79778426.1657003420.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 09:00, Viresh Kumar wrote:
> Many helpers can be safely called only for devices that have a single
> clk associated with them. Assert the same for those routines.
> 

Where is the safety problem with multiple-clocks case? And how users of
PM OPP API are supposed to iterate/find OPPs they want if the API now
throws WARN?

Best regards,
Krzysztof
