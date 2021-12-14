Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F525474538
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhLNOfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhLNOfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:35:42 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0965C06173E;
        Tue, 14 Dec 2021 06:35:41 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 207so28554922ljf.10;
        Tue, 14 Dec 2021 06:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bTETz2h6nLGm7FFtGoJfUkWZ0HDEaBtcfd+0ZBKXMvc=;
        b=n/QGO+OnyCitcGbUPZx3Pj35kVxNPf9kyMvy5oC1xVP14DSmebuH3o1n1RLUTmhZNW
         jM6Hftd6+0Vw9w4QOrJtPqLzTr6Galg4yDzcKYkvVGep2YoWV8jo/pooFE9d3VXAsAeF
         yR8llmpsTF1yiyeK5dPv57cq4YatfdGdOUADCthaLZrBFNY+FGxjlBcyBM4UMIPgm1VE
         xO5mVpHRw1w/fsdZ80+HXEBsv3ylsxaYXCUIGJ3CbSYDXio9oI3K/lT2Gnio7jEzV6RB
         F/2VutcgJBnB2y0ChlsbRGZk0BEevFPcQuz/5M4fXccj1+qPIonzL3cgfU4xjqAc6dnv
         rUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bTETz2h6nLGm7FFtGoJfUkWZ0HDEaBtcfd+0ZBKXMvc=;
        b=twugRWzVb3xvyzC4+euMC7QfoV0BdvJ4YiiMoLbG5f8MH7O7mjCk/5aJn5mH0Krr4t
         xv1h8TQ3iSrTHb5KG6XXm/4pwDHr5GQLhgntcX/UKdxcPP/5VpZIurw83I+NrCA4DdXK
         InLj+obQWWklrsGjohXNr30VnPYsRdvlwxLG2oXBvCb5HRTvFIzgBdpQb0OmJGzWbglj
         RYgnYVCfrS3ydRR94EQgpWKVaQM70nV7p5Dd5I90q+AEhogmLBhTjk86VdSNZBnRLRsY
         3QR0axExuFKLLJ11PrHnxks+z38LKhuATBxPZcgO26MCJXiwsOLHPR6yX52YviQZ9BpO
         b+iQ==
X-Gm-Message-State: AOAM531IU22cnjNrmTdKHPBOo0NdARApjb9zi3j383EvdUOCZ8gTEg3I
        GeHiN0nu3HPj/REUdz+kAiE=
X-Google-Smtp-Source: ABdhPJxqBfOFfSpR6YQ9B8RrJ36CJEZUGHdsdWYWe/w8s6TzwBrY0PsUZf7c0DtQQSei90WL5dPVtA==
X-Received: by 2002:a2e:91ca:: with SMTP id u10mr5429166ljg.414.1639492540268;
        Tue, 14 Dec 2021 06:35:40 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id g36sm1857154lfv.16.2021.12.14.06.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 06:35:39 -0800 (PST)
Subject: Re: [PATCH v2 0/8] Host1x context isolation support
To:     Jon Hunter <jonathanh@nvidia.com>, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mikko Perttunen <cyndis@kapsi.fi>, thierry.reding@gmail.com
References: <20210916143302.2024933-1-mperttunen@nvidia.com>
 <10de82cf-27a5-8890-93a5-0e58c74e5bcc@kapsi.fi>
 <c382fb0e-6b73-5ca0-7f63-d2843351325e@nvidia.com>
 <91dddccd-a6c1-21b3-34d6-6a8082a386e7@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a507b10b-395b-1f6d-87b9-7c7c436cab0e@gmail.com>
Date:   Tue, 14 Dec 2021 17:35:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <91dddccd-a6c1-21b3-34d6-6a8082a386e7@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.12.2021 11:05, Jon Hunter пишет:
> Hi all,
> 
> Still no response on this :-(

I see only two patches on Tegra ML and others on DRI ML. Might be good
to start with re-sending this whole series and CCing MLs properly.

