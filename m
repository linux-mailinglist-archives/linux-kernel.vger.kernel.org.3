Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080F15958CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiHPKrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiHPKqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:46:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7399EEE6B2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:09:02 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id by6so10007798ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=N21IrFoF+c3Uz8gbDUqJNJKQFeftZ1grSPLtq6SWU6s=;
        b=dAE+Zn7Q6q2G9v+tf5/mblVh57atpAB6AzzHGn0zME2jXFSpJjfjNlRJRNFkNi1dya
         NUD3vhxtgCqrMz7vHX3+MMXQwTKnCD1kXjLE3+H/KJ4MrHTdrAzJafgGiFyMg1wz/hjb
         JdCVskrChS9leLIFnT1AUn160zF8iJQOej0RAqSf+6ZFttDlOUjySc+SwYZAAM2QDCL9
         2neNwhjkLK+LOZU72iKIFW1mv6huqUlUYVX48jjxuNlrsZm6M22cby9hKsE1l6Jdphv/
         h8DIKyycuQ0WyU0k0RVxsbW5fsfI4KcpZtgkv3gViTjirl2fA32X/o6O+CYA2IvXcAMG
         /b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=N21IrFoF+c3Uz8gbDUqJNJKQFeftZ1grSPLtq6SWU6s=;
        b=uNr3kv0sYLnUIR1GcccOuBPHMQ0o8hbyafMNtiBQzxxBzOfX8bhI4r5bKrKBh3rlA8
         gFJOr7btJeK4cV8NO2owMB6u+es58D9WUYvSttp9OcFoJlLoLmgKdCi/PS3+0aZmJPiV
         zxAopLvtOCeCTcdxK1q3zW06R1T7EAo9e+ROTvbc68DywB6cj+gXNo+Iln8EV52QLMOe
         nN/qyDxmkCL1gRu/xl66cR5sU0YbQSIP+8V2mj365nFAdCqy7cP4RKd2ifaR/XC1TIqJ
         hnVjh8L02SMgNTJ7pca8xqQf18L860OHrOePuFOLZl4m0mnoyACMVQh+s4l5NdBtG5a1
         UTPw==
X-Gm-Message-State: ACgBeo3hg0Aw0FeQY9+g80/7XyIPBRBRcng5zTx2VimP4L2Ty6Tu7IXU
        mixr+OhKF9O2B69tjCBFGkHtAw==
X-Google-Smtp-Source: AA6agR40m0D2CidnyS7bnmcP5XVt8y0iMYN1GPXTiBKv98Om8Y9kz6bF2mVjX/agj5jE1V3udzey1Q==
X-Received: by 2002:a2e:b8ca:0:b0:25f:df8b:f867 with SMTP id s10-20020a2eb8ca000000b0025fdf8bf867mr5970635ljp.269.1660644540627;
        Tue, 16 Aug 2022 03:09:00 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id v8-20020a2ea608000000b0026182c4a5c6sm954903ljp.120.2022.08.16.03.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 03:09:00 -0700 (PDT)
Message-ID: <265b2a5f-fcf7-53a0-5de0-1cb753581515@linaro.org>
Date:   Tue, 16 Aug 2022 13:08:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 3/3] gpio: imx-scu: add imx-scu GPIO driver
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        imx@lists.linux.dev
References: <20220812133012.7283-1-shenwei.wang@nxp.com>
 <20220812133012.7283-4-shenwei.wang@nxp.com>
 <CAMRc=MexvX_sZK6RdiAdjNQnvqAU_o_g7pCfUPDORHnQ4PcEMw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMRc=MexvX_sZK6RdiAdjNQnvqAU_o_g7pCfUPDORHnQ4PcEMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2022 12:06, Bartosz Golaszewski wrote:
> On Fri, Aug 12, 2022 at 3:31 PM Shenwei Wang <shenwei.wang@nxp.com> wrote:
>>
>> The SCU firmware on i.MX8 platforms provides a set of APIs to
>> control the GPIO PINs on the SCU domain. This patch implements the
>> standard GPIO driver interface to access those PINs on the
>> SCU domain over the SCU APIs.
>>
>> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
>> ---
> 
> This looks good to me - Krzysztof: do you have any other comments?
> Otherwise, I'll pick it up soon.

No, I acked/reviewed bindings, so entire set is for you. Thanks!

Best regards,
Krzysztof
