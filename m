Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB914D8097
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbiCNLXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238920AbiCNLXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:23:00 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594C53A199
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:21:50 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5F8473FCA1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647256906;
        bh=W9VMt9fitOMhu9PbN4y31ZgV44fBSNG49uwM8HTR7CI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=C6eXvayj7U/WIeKlnazwo1Ju8ONqN2yw0jBJPDHDP+MSB8ggJad/EXesuuSTrRJNy
         6VYiQlzHNCxZlqFgGv0SxI11hIWb+Ts4H5JoE07GomrOYWQ0XhBMMbObFdDI/3M9/s
         WUi9cUcQKfQbkR7FeVkCioLc5CJvZlJWUnlH156VTtaSj4kZwatUczXXkVIfBNX+iz
         T6IUof1STRJGMiJKevZKiM+XJ1nVdJ9at97oioLPYFM56nsnVft/2aKlPXH0Xbk0re
         hwVYq/BRHrQcHimlAFZPoiJ58e+OO5T3Amezbx10nYXL2sxkcsKyFAc7dxBO/S1sOW
         l2IuhoToRj3yQ==
Received: by mail-ej1-f71.google.com with SMTP id jy20-20020a170907763400b006db62b6f4e0so7793779ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W9VMt9fitOMhu9PbN4y31ZgV44fBSNG49uwM8HTR7CI=;
        b=JrXUDtr67cXNGECkFMbMjQoa0eSIPiS4dEj7GZ0+mbfMT2e/p6lEgXm0hskVpQK6Kk
         m7DtlEJdQ0aHua3cccvX/04BXj/nKGhF8oOKxD8mknQw14Qq4kUT19vGa26qG3OuCqg9
         OhXp5LLxxmVQ96uNIG2ZNXkDdw5vNsT8tWReta4IsFhKNTsyCsM6X4BiMKGCw11e0F2x
         RiU9t/WsqP22qdWod6plLNnKynoMVMC9tZriwomxTtQyz/OOHfFzXbe9Pc5EwpjFmurH
         gIs88MTU8Eo8d8GJTD+txdYK/Krt8mIUrZWqRUtOoWORPiSZ8O18OorDpuuLKRhSWgSI
         QG3A==
X-Gm-Message-State: AOAM531s6CrOCWkHlyDS7uMvtaRkBNnTmlP0MOqh+6QITfhOoaJTL3z8
        aqSxo6o3Mh4KxI3B2bFful1m3OEgmbPIRDdXy0nr7OaK9Y7FffXmqnxg2F4xJhO5V2dcKarsYsm
        tASsvWLlJoSF7CD4I8baB3rxdQOZggRsCejvYTGJBOw==
X-Received: by 2002:a17:907:6da2:b0:6da:94a9:b7f3 with SMTP id sb34-20020a1709076da200b006da94a9b7f3mr18346501ejc.692.1647256904346;
        Mon, 14 Mar 2022 04:21:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznZeSz7ppOk/V81jFboc957xuTXOB6UgvnwgrPV/5NzFrdaVAXBT1SidK5IOuXKNsAyX8TzA==
X-Received: by 2002:a17:907:6da2:b0:6da:94a9:b7f3 with SMTP id sb34-20020a1709076da200b006da94a9b7f3mr18346474ejc.692.1647256904099;
        Mon, 14 Mar 2022 04:21:44 -0700 (PDT)
Received: from [192.168.0.152] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id y18-20020aa7ca12000000b0041677910461sm7859672eds.53.2022.03.14.04.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 04:21:43 -0700 (PDT)
Message-ID: <1a43277a-94b9-4f95-314a-876291227982@canonical.com>
Date:   Mon, 14 Mar 2022 12:21:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_kriskura@quicinc.com
References: <1646288011-32242-2-git-send-email-quic_c_sanm@quicinc.com>
 <b793195b-1d3d-63b2-19d2-72ae2aec8c0f@canonical.com>
 <20220314032952.GA27561@hu-pkondeti-hyd.qualcomm.com>
 <f1621a67-a0ff-f111-c4da-9401924e7f4a@canonical.com>
 <20220314081613.GA28402@hu-pkondeti-hyd.qualcomm.com>
 <c88396f4-4cfe-d375-1dcd-b34a6496cb06@canonical.com>
 <20220314094054.GB28402@hu-pkondeti-hyd.qualcomm.com>
 <b45b3b7e-e1c0-79b6-81c0-53c70427dd10@canonical.com>
 <20220314103045.GA31533@hu-pkondeti-hyd.qualcomm.com>
 <fadbc93f-8741-58c6-d0e5-dc740e0f0724@canonical.com>
 <20220314111313.GA6889@hu-pkondeti-hyd.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220314111313.GA6889@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2022 12:13, Pavan Kondeti wrote:
> Hi Krzysztof,
> 
> On Mon, Mar 14, 2022 at 11:41:27AM +0100, Krzysztof Kozlowski wrote:
>> On 14/03/2022 11:30, Pavan Kondeti wrote:
>>> Hi Krzysztof,
>>>
>>>>
>>>> Ah, I did not get it. That's not the solution for this case. defines in
>>>> dt-bindings are for constants which already can be in DT, e.g. IDs. Your
>>>> register values should not be stored in DT.
>>>>
>>> These are again not register definitions. These are encodings that dT and
>>> driver can use. These would be constants only, no?
>>
>> What do you mean it is not a register value? I don't have access to
>> datasheet/manual but I can clearly see code:
>>
>> +	if (or->hs_disconnect.override)
>> +		qcom_snps_hsphy_write_mask(hsphy->base,
>> +			USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0,
>> +			HS_DISCONNECT_MASK,
>> +			or->hs_disconnect.value << HS_DISCONNECT_SHIFT);
>>
>> You read the value from DT (e.g. "3" which means 6.3% for hs-disconnect)
>> and you write it to a register. Directly. 3 is a value for the hardware,
>> meaningless outside of it. It has meaning only in this one hardware
>> programming model. For humans it means nothing. For humans 6.3% means
>> something.
>>
> 
> Right, This is what I have been saying will change. we don't pass the direct
> register values anymore. Instead I am saying, we pass the percentage
> multiplied by 100. For 6.3%, user will be passing 630 in device tree. for
> -2.75% user will pass (-275).
> 
> Are we on the same page now?

Yes, it sounds good. Thanks!

Best regards,
Krzysztof
