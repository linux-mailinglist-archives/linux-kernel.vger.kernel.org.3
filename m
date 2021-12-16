Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2094A477568
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbhLPPJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbhLPPJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:09:26 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0097EC061574;
        Thu, 16 Dec 2021 07:09:26 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id l7so38997740lja.2;
        Thu, 16 Dec 2021 07:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1qfd395IYWj+B/UdbiFiPVdCXFHwSx1zWwQl0BrdIvo=;
        b=Ztghiy1SxXBJ21k5EHGfOxtkLitrM3pminuWlLG7d35vrjB9Ud0njt3RXd7DzwIITZ
         9R0EkJ7CKk02W2fvI21ouo0VeL6rB583kIEbWMEJRVT8A0/t+WPpMSzI3xaPKP35qMpZ
         JA7LtaXd3Oyb5P3Aemn/pGmzOhomhGHP5nEzGdUjqx1vfeu9WJzgBTXxK8wSx9CgzlkL
         Foj6WyQjz8rD+0rl31WtPDh2E8RXfdQJrk1/o3HRcZ00MmtPLClv2KN61TS7NOqsRuXG
         HCL+NipbTzGoPbcY/ZkN0ILJZx1FSSQeRvrURn3C/Jo2USIuwwi6BZXYvHDckU/wkwlx
         hufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1qfd395IYWj+B/UdbiFiPVdCXFHwSx1zWwQl0BrdIvo=;
        b=W3i5/E/lOYlp9eIE9AkPZRaANeOLCLoTwLx5ySavQNpwnEkBHBwog4ZQ4CSWmtfeQC
         XvwGLwl8/2u49JLUrU2aitmjiPCzv4O7iDoeQA1xF6p+hGwW+zRO5oGjkxZhJLFhriHL
         7zy8hi6M4/5Rq6Iw0oPtjJ1s9gbl/fN517KJSQON1jAtKjOA6JM7u1tfDwUW3hSZmFwX
         nkZCvmCQ8DqxIdfGO+w337p23aE0EtIwxqbmkU0i+z+lDWuL24iDb7y2FMlao5YLTsn4
         5PJXmaiURjhe96F/aqsfil6c6xeqE6Uugtq9S0ocvQlP2aYVV4QS+8oZ7JzGpcxmpKCT
         v4dg==
X-Gm-Message-State: AOAM531GHy5cCbqW+kgIJE0hLkR0MsMTEHsEAzKPe6UhLGKySoc4yhUH
        S44gUpx02LNAD7MA+Thx0Lw=
X-Google-Smtp-Source: ABdhPJzSYtr+35JjMyfwDiGDowXvrdjIoh3vwsMwh7YTEgoBMb3070lHBDEXydaKeMXVufN4FZEHmw==
X-Received: by 2002:a05:651c:b11:: with SMTP id b17mr15513775ljr.272.1639667364213;
        Thu, 16 Dec 2021 07:09:24 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id s9sm910898lfr.304.2021.12.16.07.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 07:09:23 -0800 (PST)
Subject: Re: [PATCH v4 00/22] Support HDMI audio on NVIDIA Tegra20
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20211204143725.31646-1-digetx@gmail.com>
 <Ybo6tsnQM6OacoZs@sirena.org.uk>
 <26af30a6-9606-72d0-9258-cf9627ddfe77@gmail.com> <YbtFXcteESF0nLZz@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <03ede0df-e86e-798e-e2c7-c0ed3dc81fca@gmail.com>
Date:   Thu, 16 Dec 2021 18:09:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbtFXcteESF0nLZz@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.12.2021 16:55, Thierry Reding пишет:
> On Wed, Dec 15, 2021 at 10:19:07PM +0300, Dmitry Osipenko wrote:
>> 15.12.2021 21:57, Mark Brown пишет:
>>> On Sat, Dec 04, 2021 at 05:37:03PM +0300, Dmitry Osipenko wrote:
>>>
>>>> I based S/PDIF patches on Arnd's Bergmann patch from a separate series [1]
>>>> that removes obsolete slave_id. This eases merging of the patches by
>>>> removing the merge conflict. This is a note for Mark Brown.
>>>
>>> That's not in my tree so I'll need either a pull request with the series
>>> or a resend after the merge window.
>>
>> This patch is included as a part of this series, please see the patch #6.
>>
>> I saw that Vinod Koul already merged it into his DMA tree [1] a day ago,
>> but there is no stable branch there.
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next
>>
>>>  It's also not clear what to do
>>> about the DRM bits, I guess it's probably easiest to just apply them
>>> along with the ASoC patches.
>>
>> I already asked Thierry Reding to take a look at this patchset. He will
>> let to you know how the DRM bits should be handled. Hopefully this
>> should happen tomorrow.
>>
>> We will know how to move forward if Vinod and Thierry will reply ASAP.
>> Otherwise this series will have to wait for the next cycle.
> 
> I've applied the DRM patches to the drm/tegra tree and pulled in the ARM
> device tree changes into the Tegra tree. I think the rest can go through
> ASoC. Well, provided you can sort out the patch 6 issue with Vinod.

Thank you!
