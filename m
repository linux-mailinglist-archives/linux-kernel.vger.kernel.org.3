Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48589559FED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiFXRpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiFXRpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:45:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4B6369DB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:45:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u15so6103377ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vid9EyiKW5fi5NiF/3GzqIJASK/b1lC3A+ghV6jx3bQ=;
        b=KoDlk9NmxHGFOQ9BhPF6ashZ3rQlBt/WKIZsAntoZZ44L6s43bRgxqcsKWC+p0d++h
         Q+fdGXPIY1cyq231FLTWqs80HpRzS5+AGP/V/J2otL9Qag2RZB2vWK8jNpHPP2o1AYal
         04DwtDCXzwYOExAAQ0eu1h0pF4xn+Elj1USW0qCG9BYtO2PhBlXygaqHdDWosDmqsefB
         Tqa9O2EuKquB8dEhLAH63yzwonUW6qRn+xVVK5y26YUmSV/bibOhPFSQH4TFiEIXHSzj
         nIoD7h15FK7RU0O80tx/DHYXq+DInbEvo5GSZRawS+Steoz8Iq3n4TcWygx7hGgPmyxU
         3VTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vid9EyiKW5fi5NiF/3GzqIJASK/b1lC3A+ghV6jx3bQ=;
        b=w8HtxSzcrkKF/w6xd7icE1Q9bxP/5rzczmiUoyWmFVlvVPLOU1E4798ka5Kl/oUsMH
         SzLByB9icB+dIV2WpIQfDFjiMQsKdGfAVCLBaYounOL/7h52kqJyU6+rBPgnGr9Uns0/
         h76xnB1wwP6JZxmemPRe5aQ67W1GTT7qo0iMsK0DGvggi1pbWm4vuLZWLQ2Psa2gfOx9
         RXa6m47vRNQsHz7SOKLCJW1X62ThCPfZGn4LJRBIbAwsBk3z29B+2tDOc2UsVRl/rnhH
         mExU0nkXHKgKqi1E206cBaPoPuSGkfx3OM27kJrpiB2neho9iimHn3ZZETpU+zvZ7Z4k
         1sfA==
X-Gm-Message-State: AJIora90x+G9kOBc0myCuChDX7n4smgNdO+kqF5uzf/McdFj7V4aUDsC
        fYGEypX7lmbXfTk7p/HuriLr+P7Yz3FCuw==
X-Google-Smtp-Source: AGRyM1u4saXcWiEr+oSyJ9/A9r9G/cl/yHKKlvWiO4KgC5/qg78ZCsuaXacEThOxeaGQ0Ux+4fuBdQ==
X-Received: by 2002:a17:906:b294:b0:726:2a95:7e1a with SMTP id q20-20020a170906b29400b007262a957e1amr157372ejz.404.1656092709457;
        Fri, 24 Jun 2022 10:45:09 -0700 (PDT)
Received: from [192.168.0.237] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906545000b006feb20b5235sm1489562ejp.84.2022.06.24.10.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 10:45:08 -0700 (PDT)
Message-ID: <47db0cd8-c940-6e74-f8dc-8e3931e13d80@linaro.org>
Date:   Fri, 24 Jun 2022 19:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] rpmsg: fix possible refcount leak in
 rpmsg_register_device_override()
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Hangyu Hua <hbh25y@gmail.com>
Cc:     bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220624024120.11576-1-hbh25y@gmail.com>
 <20220624173621.GC1736477@p14s>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624173621.GC1736477@p14s>
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

On 24/06/2022 19:36, Mathieu Poirier wrote:
> On Fri, Jun 24, 2022 at 10:41:20AM +0800, Hangyu Hua wrote:
>> rpmsg_register_device_override need to call put_device to free vch when
>> driver_set_override fails.
>>
>> Fix this by adding a put_device() to the error path.
>>
>> Fixes: bb17d110cbf2 ("rpmsg: Fix calling device_lock() on non-initialized device")
> 
> This is funny... Neither Bjorn nor I have reviewed this patch...

It was a fix for commit in Greg's tree and Greg's pick it up after a
week or something. I am not sure if that's actually funny that Greg has
to pick it up without review :(

Best regards,
Krzysztof
