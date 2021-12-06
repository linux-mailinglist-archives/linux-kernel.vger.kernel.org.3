Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515BE46A28E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhLFRRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbhLFRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:15:05 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAA7C0613F8;
        Mon,  6 Dec 2021 09:11:37 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bk14so22610109oib.7;
        Mon, 06 Dec 2021 09:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jR+IG2U4mkMhx5akXz2gzfXjHYaCWbKYf+pbbhKTCu8=;
        b=VVrq5X6DYvJX02JLRTN+QLoLQpPqSC4maDQwr1T/CdEC/dR8CLDIWjMwJfOgM9q3GB
         PxwnYsDnDLw60SUtJpxj7jMEsvwUiFqees9twfHS2Awprrbw8XO7VfpsU9yFkZ+rGKlQ
         WDur/NM7pUzHaaWgLaID+i8KTwK9TjYfQTyWSdIs3c4uWN78oxU1SPnMdpS6KZ5Z/8fM
         946G91GmczWmU7oahx0+gWL19fmbEpDH+Nt/ZJY/6dJ1x5AvionlT22IXPKpovHw28nL
         yGItb3WPv89oiwzXRk7SabSm+wjBcYPMudvvwE5PZBYTXsTvVPk0b3FxntpVd66ZeAID
         NVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jR+IG2U4mkMhx5akXz2gzfXjHYaCWbKYf+pbbhKTCu8=;
        b=FGTaYL1xitL1FGXAlrOLnItwqhPsnd9ONBrUc0wekMtnAsp4Yo4TP1MQkdhIreTknp
         bcWoKwsegBFt3dbdyA3PpaHooL/gpZyKydqPOWvXBz72bUhBXUzPQGuygiUIePX7d4f0
         uV71sJBCoC1ajbfnsp4ZIUwTV+MG0W+DDHFv0QCy1AgJHhZlSR5zHrrNo7dfsvwAXgGf
         4r/bff1fkbPSYoOEIbpCpDH3jz8gVy6yRzClMPkq3qhp8gfIoJAL2iExwXC7yx+M4ZyH
         HnrLiYFg1b4/d7oKt3GRKVB2r0XVJpTUIu7YtNdlQMfL97YMqTf5K3f/ICWdK3et7zI8
         b/cw==
X-Gm-Message-State: AOAM53388Q2l1Vk5uH3eivul7KBEUAt/h7Tfe35HwsSqofVK2GL3HKBR
        W1zIRHy+zkq3+ZMN4CYPams=
X-Google-Smtp-Source: ABdhPJxeg1Y1eg6p6YeFfy/FXfQbSCdboIVwbGEJ9GwE/0243+TQ0FQKvqnc54B3l0dWsj10I3D4PQ==
X-Received: by 2002:a05:6808:e8e:: with SMTP id k14mr25359749oil.25.1638810696168;
        Mon, 06 Dec 2021 09:11:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b22sm2672604oib.41.2021.12.06.09.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 09:11:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Andrej Picej <andrej.picej@norik.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>
References: <20211206064732.280375-1-andrej.picej@norik.com>
 <DB9PR10MB4652F10355222D5DD1A65E50806D9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 1/5] mfd: da9062: make register CONFIG_I writable
Message-ID: <83fad886-541c-987c-1f38-7029aca41892@roeck-us.net>
Date:   Mon, 6 Dec 2021 09:11:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DB9PR10MB4652F10355222D5DD1A65E50806D9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 8:46 AM, Adam Thomson wrote:
> On 06 December 2021 06:47, Andrej Picej wrote:
> 
>> From: Stefan Christ <s.christ@phytec.de>
>>
>> Make the config register CONFIG_I writable to change the watchdog mode.
>>
>> Signed-off-by: Stefan Christ <s.christ@phytec.de>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> 
> I've already provided 'Reviewed-by' tags for the other patches in this set. In
> the future you can add any received tags on to patch re-submissions where
> nothing has changed since last review.
> 
> Anyway, thanks for the work on this, and for the patch set:
> 
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> 

In this context:

I expect that tags are present in patchwork. If a submitter drops tags
in a new revision of a patch series, those will get lost. The underlying
assumption is that the submitter had a reason to drop tags, such as
substantial changes in an affected patch. I can not assume that the
submitter dropped a tag accidentally and re-apply it, unless the reason
was explicitly provided (obviously that is typically not the case since
people don't usually add "accidentally dropped Reviewed-by: tags" to
change logs).

Also, I do not look into one patch of a series and apply tags to other
patches of that series. Similar reason, only here it is worse because Wim
may pull a patch from patchwork, from an e-mail, or from my watchdog-next
branch. We can't have all of them have different tags, so I take what is
in patchwork and nothing else (and your updated Reviewed-by: tag will
not apply to other patches of the series because it isn't in patchwork
for those).

I also see that my own Reviewed-by: tag (or tags, I didn't check all
of them) was/were dropped in v5 of this series. That means I'll have to
re-review the series to see what changed, which will take time and means
that the series will end up at the bottom of my review queue.
Please keep that in mind when dropping tags.

Guenter
