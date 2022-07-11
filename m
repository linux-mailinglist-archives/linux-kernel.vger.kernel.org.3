Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1192B568C70
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiGFPNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiGFPNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:13:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC5220F8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:13:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a39so18835701ljq.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QPBPWEhV2Vykab+FuRAUO/iMibCW6th1rjVx2QzcAa8=;
        b=UBbtQKARyXdeKvpy36Jm9Brb7tYCsu9XKOsYXl/ZtvqvVAjIq8VXpxsok1OC1mY2nA
         6YLnt8juwlycbIx5FPOGcYcwx0EPXnASDpuISFAB2W2ezCsq+r4d0Pj4FvNchlPQfEbk
         TWpLIDW6JUcN7/zexsDF2KDjsSh7J0SD7G+CC0TuYcn1PDmmwQaD5JiBahL3fYqNEkKW
         6gULkxdgME0KjGjeQPDevv1RDHFzMdnFhSff58WuP02EMTRkwH2H36/LA2cW6n98exC0
         voMeuPrAwXFHK9JHTRnLnuTD3v0bm7p+vugqa8MtOFt1vDe6uRc7vbG/6/bIuu7Hbyjk
         KeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QPBPWEhV2Vykab+FuRAUO/iMibCW6th1rjVx2QzcAa8=;
        b=Jiu7Cp/jEG3JhQdORzd2SdC3R9QsWuiFeYOrWNY3enWfg1Zz5J/tp4nsIrLLPO3CT8
         f3JIF38WX5ezt2pfGJr1S6ROGjX4LviOaqiqc2o5rQOSKbLhRQyTD6DbMOMRyacCEFD3
         hFOZgrB/rBom1/25sj3fbNqB6miH5nXecn3vy/0er9sdFbYQ7S02EIIvz7VKuNxGbK3Q
         j70d+I6E464wFToc6GE5lZobz1A5EEp6mrYXn2DgXw8Y94yfrBOtu/dz1EDWryzAvQRJ
         I3h5pf9mDiQh6d2mWLlnWTk0yN15526wlwGtejaAV0+c34paDsxngO+i+09EcQ6x7sBx
         fgCA==
X-Gm-Message-State: AJIora/09TE79oGDDlGtE2WWJERWBE+/X1v62t8HC6jlHRSigt6xz676
        f6GH7J8OAm8yWlIJaukaUSYQxw==
X-Google-Smtp-Source: AGRyM1tH2oqsonL2G0A+++kLBn/3Imc+sqCOv8q++5fgWtIHiQlb9L3zrzfCr7LvxU1WmGk40HbeQg==
X-Received: by 2002:a2e:b55a:0:b0:25d:485e:5d86 with SMTP id a26-20020a2eb55a000000b0025d485e5d86mr1561320ljn.194.1657120425306;
        Wed, 06 Jul 2022 08:13:45 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e18-20020ac25472000000b0047fa941066bsm6313329lfn.96.2022.07.06.08.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 08:13:44 -0700 (PDT)
Message-ID: <ceaca6d7-958d-ade6-9ee5-5e70bc57bbd7@linaro.org>
Date:   Wed, 6 Jul 2022 18:13:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/2] PCI: Restrict pci transactions after pci suspend
Content-Language: en-GB
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org
References: <1656684800-31278-1-git-send-email-quic_krichai@quicinc.com>
 <1657118425-10304-1-git-send-email-quic_krichai@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1657118425-10304-1-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 06/07/2022 17:40, Krishna chaitanya chundru wrote:
> If the endpoint device state is D0 and irq's are not freed, then
> kernel try to mask interrupts in system suspend path by writing
> in to the vector table (for MSIX interrupts) and config space (for MSI's).
> 
> These transactions are initiated in the pm suspend after pcie clocks got
> disabled as part of platform driver pm  suspend call. Due to it, these
> transactions are resulting in un-clocked access and eventually to crashes.
> 
> So added a logic in qcom driver to restrict these unclocked access.
> And updated the logic to check the link state before masking
> or unmasking the interrupts.

Please do not send new versions as replies to previous ones. This breaks 
threading for the reviewers.

> Krishna chaitanya chundru (2):
>    PCI: qcom: Add system PM support
>    PCI: qcom: Restrict pci transactions after pci suspend
> 
>   drivers/pci/controller/dwc/pcie-designware-host.c |  14 ++-
>   drivers/pci/controller/dwc/pcie-qcom.c            | 121 +++++++++++++++++++++-
>   2 files changed, 131 insertions(+), 4 deletions(-)


-- 
With best wishes
Dmitry
