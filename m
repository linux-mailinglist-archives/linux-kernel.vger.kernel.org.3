Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DBD463405
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbhK3MUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhK3MUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:20:33 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69105C061574;
        Tue, 30 Nov 2021 04:17:14 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bi37so53226053lfb.5;
        Tue, 30 Nov 2021 04:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=trRzexDm92sVJlThyj/04+7SN11dBJi8qOdq95CaO5g=;
        b=VzMywNNj2yxWLL2z9DxwtUGbmUnA8iIr6NjgbGU0BU9wo16PrbqrOBttuCtLYiQZai
         X+logj3jzyHag+GMsJF4KQdBhQD3+3jB7QDDAma0ktWI+bf/ktIfuuEnGeoLSuUJZAZx
         tjU2bXEV65OCbmjlAZMLxwS8vITLUaNz+WJ5dPsUgUsMcWPhvZcVjZsmib+HuHOqrmhR
         pZ+OnM2u7Wycjl06k9VcvBZ/H5jk+IeKppVz4NFng/diLaWdERct8E2mmukQYPNkKLIP
         1zCPwhmSG74DXdpH3jJlCJvUDkYOioGXD941Ri+Mi1eHc/ZLnWx0fWDEb20f7EbPXc9o
         19oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=trRzexDm92sVJlThyj/04+7SN11dBJi8qOdq95CaO5g=;
        b=obaj7A4coCxUJDQyRHD59vwnou8hCIyRVOcWpQv1SjsK1xZBGproLrzzw5+w9scGq/
         whf87xoJnh065bpzmb2KPOFExTLX8oh7WMvAfIF5+WqhWT1n02p7I6OxR40gHj2T78Ng
         sYb0R3yFgn6BFIpVkpcyxpNT6DekQHHoGClR+mdsP/7ivdDGDFpvlvA7CZCK2AbjEQFr
         WVITL2Sv9FqKKCx/OM9ZSRpp5LuWT21XIqFRZReKtslYd1rcjYO+4ox5WGCp6XTNg1cr
         DTJiD4HpuYdP1Zfso/EQJNR2VDFQc0raUKxXi8tr2XzHpEc+GOT7eefTSaAvdsKsJsWP
         T+jQ==
X-Gm-Message-State: AOAM531jYx9qATmV9PufGQ/cZjI/d/CQbTYOgR0heSIm21DB/rPtLRIq
        7/d8KDfeyFBYBQ49Si/ayk5WP+PIfjc=
X-Google-Smtp-Source: ABdhPJyeb69zs1klG9kPMwoTkQRV81S9ZqywFuLxMLusvHux/rRMMtdRtxrotgsIHc3R8AfBdeyY8A==
X-Received: by 2002:a05:6512:3b2b:: with SMTP id f43mr55139476lfv.629.1638274632435;
        Tue, 30 Nov 2021 04:17:12 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id f23sm1708689ljg.90.2021.11.30.04.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 04:17:11 -0800 (PST)
Subject: Re: [PATCH] serial: tegra: Fixes lower tolerance baud rate limit for
 older tegra chips introduced by d781ec21bae6
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Patrik John <patrik.john@u-blox.com>, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathan@nvidia.com,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
References: <sig.096060f39c.20211122124425.74031-1-patrik.john@u-blox.com>
 <0165046b-c8bc-ec8e-05c7-bf9aea14339b@gmail.com>
 <727044f2-12d4-0de4-f6b8-ef3ee75d3630@gmail.com>
Message-ID: <d906ed7f-c507-e5b0-3d46-2750d62414a4@gmail.com>
Date:   Tue, 30 Nov 2021 15:17:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <727044f2-12d4-0de4-f6b8-ef3ee75d3630@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.11.2021 15:36, Dmitry Osipenko пишет:
> 29.11.2021 15:32, Dmitry Osipenko пишет:
>> 3. Use "Link" tag and put all http links here, before the Signed-off-by
>> tag, like this:
>>
>> Link:
>> https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/commit/drivers/tty/serial/serial-tegra.c?h=for-next&id=d781ec21bae6ff8f9e07682e8947a654484611f5
>> Link:
>> https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/tree/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi?h=for-next
>> Link:
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/serial/nvidia%2Ctegra20-hsuart.txt
> 
> Actually, it should be like this:
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/commit/drivers/tty/serial/serial-tegra.c?h=for-next&id=d781ec21bae6ff8f9e07682e8947a654484611f5
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/tree/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi?h=for-next
> Link: https://www.kernel.org/doc/Documentation/devicetree/bindings/serial/nvidia%2Ctegra20-hsuart.txt
> 
> I turned off line wrapping for this email.
> 

For the reference, I just found that there was v3 already on the list:

https://patchwork.ozlabs.org/project/linux-tegra/patch/sig.19614244f8.20211123132737.88341-1-patrik.john@u-blox.com/
