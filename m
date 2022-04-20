Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3B650853A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377337AbiDTJxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377341AbiDTJxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:53:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0500E23BC9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:50:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f17so1555908edt.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5oleVQqlVAls/QcPWdNVa/ueQJKc67SDbhMoShNCOBo=;
        b=N3yp5HL3GWoR1Qmro6GLP/4j7TqvgW3N+7zwMp/Wl+A/JwuhVpFuN5ECa5vkaAkfKm
         zBQX7cKObP2dBvB+JxN3TxUwz62ck9mMY5yAh1YG3pQcm92ZyZlqHzJNl/s2FWB8cOHx
         aWEa/uQ0yI8iMmRVSOME8DPBBkhrkgIGIXtDYmWaUskf+7xlCPk8HR1CObrYdgckXux4
         akCf7RdOGKGNhezl1G+yPKsM+U6s/QKfpuxZ9jZ4SvqmPHwUXYmT8CwrEROGf7eV6pK2
         exayC8V7nPPJIXK6FxhhYbFt/xXsnKH44HDaZRTj/nppL5EfXl5p2BHPbnRN/rrH7Hdc
         yV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5oleVQqlVAls/QcPWdNVa/ueQJKc67SDbhMoShNCOBo=;
        b=qY5jeJm1GKgGV3Viha/XAN0tXnUxM5McUR9eoIgHFrgHuYsTmNKk5rfhqjPGKD9zbm
         O0warSOHe7TWUeep8VsDSK4EurfoJeMIJWcqMpO8M5q/Hlo44VkdYBmbvg4V44BEdpnh
         KaEThZ07bfipsjszVtYDg6YTtX7t1bPAbRalDaMSwkGIZn2tjiTx55S4Iyv5pgSbts04
         BqBnpMaUUNQ/KIKFEDg0seQuF9se6rGEwJ62+8WTwbSd3snBN7zs1g5wP0JuwuLj9Q7k
         EiyObfAPiCgwSZaTQG+4Asp9vYDMKMkFSU3c70tzq9G7PI/SW5tYtfFPBgs3/bKNGNOE
         k1GQ==
X-Gm-Message-State: AOAM5307TiVi3SzVlPoDODgAQwenH3FOWpOJj2fflYREJ4ErcLZE9vEy
        qLYsvH/eCZ5wWZnl+GuagAB69w==
X-Google-Smtp-Source: ABdhPJwkUS/EaCFgHzpBmxF7K0ILv85mIBEXQdEheR4kjcVv/flyMCnblRPkzPkR/ji2jbEIR4IiUA==
X-Received: by 2002:a05:6402:1107:b0:416:439a:6a9e with SMTP id u7-20020a056402110700b00416439a6a9emr21732533edv.382.1650448220852;
        Wed, 20 Apr 2022 02:50:20 -0700 (PDT)
Received: from [192.168.0.223] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h22-20020a056402281600b004206bd9d0c6sm10002943ede.8.2022.04.20.02.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 02:50:20 -0700 (PDT)
Message-ID: <cc7e93d3-0900-0381-76af-d7438d822cce@linaro.org>
Date:   Wed, 20 Apr 2022 11:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/3] genirq: Always limit the affinity to online CPUs
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>
References: <20220405185040.206297-1-maz@kernel.org>
 <20220405185040.206297-3-maz@kernel.org>
 <CGME20220413145922eucas1p2dc46908354f4d2b48db79978d086a838@eucas1p2.samsung.com>
 <4b7fc13c-887b-a664-26e8-45aed13f048a@samsung.com>
 <878rs8c2t2.wl-maz@kernel.org>
 <5dcf8d22-e9b3-f306-4c5f-256707e08fbf@samsung.com>
 <877d7sar5k.wl-maz@kernel.org>
 <39f69dfe-32e5-4cb3-118b-5c02b28cbcff@samsung.com>
 <70123e98-046f-f10e-1032-8d112edd3ecf@linaro.org>
 <9e2306a9-8181-ba43-e331-b3b70c1a72eb@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9e2306a9-8181-ba43-e331-b3b70c1a72eb@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2022 11:47, Marek Szyprowski wrote:
>> Instead of silent fail there is now "Unable to handle kernel paging
>> request at virtual address f0836644", so it is slightly different.
> 
> This is yet another issue (related to all ARM 32bit boards) introduced 
> in next-20220413, see:
> 
> https://lore.kernel.org/all/20220405014836.14077-1-peterx@redhat.com/T/#m6137721ae1323fdf424cee0f8ea1a6af5a3af396

Thanks, Marek!


Best regards,
Krzysztof
