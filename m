Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380A24794B2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbhLQTUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhLQTUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:20:03 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2692AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 11:20:03 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 207so4867527ljf.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 11:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=avniy9qb4J011EGRN+LaM7W8paozVJQP0KxTT2YMfaI=;
        b=MmZZ46PcYUUcsjmI/6xOuddxmuVgQ6bMgQ0ASaTyyLNeKGdg9ol6X343+95usrqR75
         H4KcFPS2cQArCZfqlpcoIOIV3uhcxJa2ClF8JD61FYZjPxF+HMsg6+8y/3e4mye3hgkW
         oD25yg67te8Tr2gjxgmNiAOND35jg195cag2g103GmdxE73fC9AUDaaBEEehYiWWvL0E
         /FFHnTk5Qt3WL7s24klLc2g5qpcHEvOfz1XEHcC2PCufm47sgIjZG1Fw/Mat7Bs8sd9v
         9bf2N6AzMn4fP9DoS8aH0zsi1xRARwwqm0Jj+K0Dpp9llPi2H61rgYWfPAoaaDnCrjxy
         +62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=avniy9qb4J011EGRN+LaM7W8paozVJQP0KxTT2YMfaI=;
        b=jbS9kRY1/zdYl0VtqFxcFJHiTJ3/LWr7KDDpQld+j7/18NlO4NZTQhaQJ51nu32GY0
         zYa10eIzpEIc2qLOFSxX5LxWNOKnkRK5uEJu97PWo8lfN183SBML3yN/CY+XKJlfXx24
         k5SGalafZIzJLlZjQZbk0PSWwm97//ADANw23nZwJForCINUevi7Io+ZZRStWoSO5SqC
         5/RezVNf6iZv5/m96mT8yUN6Fe9qlvl150FV3Rz5FCsm2gBNwhPzVFY1B2fLXktVkHCk
         QUSiBNhETZ7kobTw7RFCMQsGIqGkSyFHNuMn5j7AcK2tqqyLPx5ePKhstKnYnxRjarHJ
         spCg==
X-Gm-Message-State: AOAM530UOcgnBufDbLs4R3YH71adI3lN40BkkWkLlKv4mjjJj4d1eMvH
        /OQ4P/Q8Wlmixauu30fMOMo=
X-Google-Smtp-Source: ABdhPJy7CxY1qWp/EPeAjEl66DV9k+C/gmL7Ac9Rt9DdSeaIt1InGxFiQfFj9ED1FOvrVTa+NN711Q==
X-Received: by 2002:a2e:b169:: with SMTP id a9mr4031507ljm.369.1639768801238;
        Fri, 17 Dec 2021 11:20:01 -0800 (PST)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id a24sm339941lff.207.2021.12.17.11.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 11:20:01 -0800 (PST)
Subject: Re: [PATCH V4 0/6] xen: Add support of extended regions (safe ranges)
 on Arm
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
 <1428a0be-b80c-f996-1f72-6545dd66c1bf@gmail.com>
 <81c97e6a-f5e3-3f5d-c9ae-a35933cf4e61@oracle.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <4cc296cc-c7d5-1bce-4074-b708a18d9304@gmail.com>
Date:   Fri, 17 Dec 2021 21:19:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <81c97e6a-f5e3-3f5d-c9ae-a35933cf4e61@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17.12.21 21:13, Boris Ostrovsky wrote:

Hi Boris

>
> On 12/16/21 5:02 PM, Oleksandr wrote:
>>
>> On 09.12.21 22:05, Oleksandr Tyshchenko wrote:
>>
>>
>> Hello Juergen, Boris
>>
>>
>> May I please ask, are you happy (or otherwise) with current patch 
>> series (I assume, especially with commits #3-4)?
>
>
> I think I mentioned last time, in patch 4:
>
>
> +    if (target_resource != &iomem_resource) {
> +        tmp_res = kzalloc(sizeof(*tmp_res), GFP_KERNEL);
> +        if (!res) {

Yes, this is already fixed in V4 of patch [1]



>
>
> Other than that --- LGTM.
Thank you!


[1] 
https://lore.kernel.org/xen-devel/1639080336-26573-5-git-send-email-olekstysh@gmail.com/


>
>
> -boris
>
-- 
Regards,

Oleksandr Tyshchenko

