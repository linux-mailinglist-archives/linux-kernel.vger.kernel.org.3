Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7804AD2BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348790AbiBHIG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbiBHIGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:06:53 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F6BC0401F5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:06:51 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 762E540049
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644307610;
        bh=KVZRFJpOLq0nJlympEs/FkK7jhyWuVYQ80mNAdiqYeg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=fGUMGxaBSDHrm518WGlou4jev1vsra8HOpEq+FCMTpDLGALdcaUn7Jds0faHIJc/x
         HCvCn3TXM7qFZBxeYpHO2Cg+M4TWle0VNW7wGaUeDiJIIzoXAcHneTUQik84YAiC+Q
         NXZygCPfmwQT17y3CkbTXFUzVySJZd81x+DG0UVe+hOlQa8qwkCmFlpstP6b09cIE6
         OiPCnfkCfMTcoN3KoPvuDBObkeexQ4fkIuQqlFXmTF5HI5tlTW44FWv6vEvxY4ausv
         /f+b9ZQcbZ80ROv5NVKYhW9HLDDyTarTeUsh1UwJT64rEiq/T5ZeR59YBrJteR70x5
         QsQWZvyh//rFQ==
Received: by mail-ed1-f69.google.com with SMTP id dn20-20020a05640222f400b0040f8cdfb542so1788838edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KVZRFJpOLq0nJlympEs/FkK7jhyWuVYQ80mNAdiqYeg=;
        b=6bXZvPkz/E8y/2mF1fkNtzYj12ldYu4n2odjtLbzgzEi/amSZAb784vy+AjoYVQwz8
         K1ihK9T4vDepEOSZrazl7Ad9Ehodnm0jGnKzMxLVZmu4DZetOzH4idJNk7hPCcwCaHvd
         OSrL5xOt/5vzunmXUpkTN74sSuPDR0+P4W6SxwOuWD74Gd16JLUN8DBHeb+vg4NP9JP7
         NSukdsN96u+5BaCpuCNSZFct7Kl7dVWF2UiAROiR9l87foNan+0MdG0HUgDYWMcu9RU1
         dsQw6jNnLFE3f9jTlnFt9qO7paS/qZmbJ24ZXDpZDpx0I/Z2J+b4enUXMMS628B1MeCI
         0LKQ==
X-Gm-Message-State: AOAM533ot4aU+uk+wJdVgy0i7G8GOQk77llimXyMRmrkYPdXIIMcjRF1
        QCVPptyw4P0fFlN9XmAcbpweHc6AxDUf7uOy13KvbLNnp05miaUOKwVqL6vClF5hP4AH68xreMa
        lH2uWo4cNaMEV0NdzYrKhMd8OrMnPqyoI8MCvsQbA9g==
X-Received: by 2002:a05:6402:370:: with SMTP id s16mr3231820edw.63.1644307610260;
        Tue, 08 Feb 2022 00:06:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/LVHny9HM/vF8Zn5IwddFLoJjtpqc+jRpeSQ7higUone+y1NwT4iZ3bw86X890cbGVMwA9g==
X-Received: by 2002:a05:6402:370:: with SMTP id s16mr3231807edw.63.1644307610155;
        Tue, 08 Feb 2022 00:06:50 -0800 (PST)
Received: from [192.168.0.92] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r22sm6266673edt.51.2022.02.08.00.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 00:06:49 -0800 (PST)
Message-ID: <7c6fe5de-19db-3fe9-daa0-279e50865481@canonical.com>
Date:   Tue, 8 Feb 2022 09:06:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 1/4] dt-bindings: mailbox: imx-mu: add i.MX93 MU
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220208063046.2265537-1-peng.fan@oss.nxp.com>
 <20220208063046.2265537-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220208063046.2265537-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2022 07:30, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add bindings for i.MX93 MU which derived from i.MX8ULP
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
