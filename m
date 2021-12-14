Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946AB474675
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhLNPbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhLNPbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:31:16 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6F9C061574;
        Tue, 14 Dec 2021 07:31:16 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id l22so37469522lfg.7;
        Tue, 14 Dec 2021 07:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cew1bsVh+uPPxFCPvivLMvnMySnBo7QVXMyLf4NUogc=;
        b=EIBs/m05yVAVjNZxKsVu8Oh0Ra+ssLFinvG7LKfMOy1Tb+DDQFa83JoEpSp/kyJ20f
         vtvaLZfleYaQEdO83kKRrCP8Y1G2P1VVBd1C8H/rC2FEvRABY4qZuLZF9MfzdbRNDmow
         cGRJTZrbJmdGnvJe7MN8XhbpvUlkpK10PBqiVAoE8HuxHw13OwKud0XkPDg5fcAHJYnV
         DUKRpnGNMPgJ7sbEiuJYUCWQTbbeQh0lDx39iMitKSXkglOeja3j0JlYaUtRccSzzC+C
         igtqlbPFWaGY1CMcs+PW8sdRnRh3ONs1rCgNZ4xxe4sqUVtqBu0PNS8azfyALy+nPF5r
         Y88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cew1bsVh+uPPxFCPvivLMvnMySnBo7QVXMyLf4NUogc=;
        b=knUKAk8uNV1lprw14Hcbr+/SH7nj2mX79QYgu5IXDG+cS4xDfLWGZMzAQDnisXF4A7
         EcmhOZR6dXQqDeFD5jW0KKfjn5dKSp729GaWjW4rwb9QkzTfIvl7vYLqKSVSLfSttntj
         PaSW+tRscTHylXhvf03Z5FCY96FAJHZxs5yzHECKOslRV9JnBFgsCJ/t9SnS/7uSyXXT
         t+ytQUOSyc3Wm/YEN9xMOMMETEFlqz1x7+UWm5kOl7F7XDV9POuq1E0PMnas7evl103y
         htUaLF6lgb0hAXPRjCMQnBlcRLYzRxNtOAPSr5prmRFL06LKLCCkfU0DFWs5NP02H5qz
         /wpA==
X-Gm-Message-State: AOAM533WmYXJVtY4muqPeDaqCwhDkClne8DZySmmmRqVLhCmAbEFwssS
        i0vpfllNr1f25y5/Au29aDE=
X-Google-Smtp-Source: ABdhPJxmQNB9Dr/Fnytdwhc2WP3yKSVRtKMT+07lahidhyWpm3qWdRsLiGLH2I4Htvoh4G+FR0Ibzw==
X-Received: by 2002:a05:6512:3053:: with SMTP id b19mr5387718lfb.276.1639495874691;
        Tue, 14 Dec 2021 07:31:14 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id s4sm11501lfp.198.2021.12.14.07.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 07:31:14 -0800 (PST)
Subject: Re: [PATCH v2 0/8] Host1x context isolation support
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Jon Hunter <jonathanh@nvidia.com>, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thierry.reding@gmail.com
References: <20210916143302.2024933-1-mperttunen@nvidia.com>
 <10de82cf-27a5-8890-93a5-0e58c74e5bcc@kapsi.fi>
 <c382fb0e-6b73-5ca0-7f63-d2843351325e@nvidia.com>
 <91dddccd-a6c1-21b3-34d6-6a8082a386e7@nvidia.com>
 <a507b10b-395b-1f6d-87b9-7c7c436cab0e@gmail.com>
 <a62602df-91f6-783d-60f3-d9eba10da543@kapsi.fi>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <be8aec02-8651-0b12-ff13-237c75a5b29d@gmail.com>
Date:   Tue, 14 Dec 2021 18:31:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a62602df-91f6-783d-60f3-d9eba10da543@kapsi.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.12.2021 17:53, Mikko Perttunen пишет:
> On 12/14/21 16:35, Dmitry Osipenko wrote:
>> 14.12.2021 11:05, Jon Hunter пишет:
>>> Hi all,
>>>
>>> Still no response on this :-(
>>
>> I see only two patches on Tegra ML and others on DRI ML. Might be good
>> to start with re-sending this whole series and CCing MLs properly.
>>
> 
> All patches should have been sent to the same set of addresses. At least
> LWN's archive seems to agree..

Indeed, I see that Tegra ML was CCed and I see all patches on Tegra
patchwork, but I don't see them all on lore and gmane.
