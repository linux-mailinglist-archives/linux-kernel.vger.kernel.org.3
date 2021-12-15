Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEE447518A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 05:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbhLOEB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 23:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbhLOEB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 23:01:28 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7CDC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 20:01:28 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so5524038ooj.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 20:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3p21cZX6VTVJfDbT+xtRQs4392W+Wmz3Ks+mLBHxP7M=;
        b=BZq61RILd+nULFwvm2GxQkU9S8LWIa1H1hgca+PB0mf2Kjj0r9PNv1LUepCNPM8jUj
         E2aTNbha2RqV+ObUt5CMqXgcv/g2s4rGeAPRsIptcmJPndDWCBC73VZXl1c2EvfAdcAC
         dn1zJ5P83Gr1PNFHtSjU0MfvNCNUUbTIAXUxsrmzPpzsmVYz+ch6b/xMQyS7xYkLYTQN
         bNNoa9VWPcyTQA2CioVbpG4bIFFWQvGGMRKKXItdwVD0XX9KhOrWsAjLHdMOLJNq0YKP
         MYp6flmUJnmy+gGxCXwB9eowL/p86IzLO+LQBDq7RTXMfOexqccg//UvfDhiV1RwSUk6
         l+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3p21cZX6VTVJfDbT+xtRQs4392W+Wmz3Ks+mLBHxP7M=;
        b=cpzmBHX0y/k6fwAnKJZs5erxB/QhPBfHNRandp1nTN5FYxvW7taubQSFdMtJK3cuH8
         X3vvHXm4l24qYcq0PWMqPbpbtsMS75+9IxtjtOq5AaBNIq8QRBybxFS2yqLq8EVCf6ND
         XgGZNs02szipOLge1KVG6wxsndQ0owFhYZa5DhNgywU8mCMj6c+tnTPCJjHqAEqwFYvz
         f79IKdx1zuGPohxEDtwXzbjZRjmYk+ELG//zg4iRJM5EU7c6WbcOOYdZ+sCVHPXy4XIU
         bpIWsvCBTG840tz4bBWHyUluDPj2FgpgxqkhRG0eyxOXS8EmgVeTiH78IRb8wyKkic6D
         Edpg==
X-Gm-Message-State: AOAM533WH2TwMs2nRFBO6Er/qoSOQDfRNVwaLmjsM1mqFDhlZ9tnhNvE
        ptPtfmoe2d1QR/qmFaJ/jxtDzA==
X-Google-Smtp-Source: ABdhPJylGahtXNpt8ZT81qnmWmURXAJa8/4nDbCQ3NP/HgyFvMAjCgzGr2/TKK0vAKV08Kyhp6HyTw==
X-Received: by 2002:a4a:3110:: with SMTP id k16mr6030549ooa.64.1639540887319;
        Tue, 14 Dec 2021 20:01:27 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p6sm221765oof.0.2021.12.14.20.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 20:01:26 -0800 (PST)
Date:   Tue, 14 Dec 2021 22:01:23 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Deepak Kumar Singh <deesin@codeaurora.org>
Cc:     clew@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH V3 0/2] smem partition remap and bound check changes
Message-ID: <Yblok/6vHI0Zv9he@builder.lan>
References: <1633426371-4827-1-git-send-email-deesin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633426371-4827-1-git-send-email-deesin@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Oct 04:32 CDT 2021, Deepak Kumar Singh wrote:

> Addressed pointer conversion error in previous set and devm_iounmap
> code reordering. Corrected code for calculating global partition size,
> added code inside hardware mutex p_size = avilable + free.
> 

Hi Deepak,

Sorry for taking my time reviewing and testing this series. I think it
looks good and was hoping to just merge it, but it no longer applies.

Could you please help me rebase it ontop of linux-next?

Thanks,
Bjorn

> Deepak Kumar Singh (2):
>   soc: qcom: smem: map only partitions used by local HOST
>   soc: qcom: smem: validate fields of shared structures
> 
>  drivers/soc/qcom/smem.c | 317 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 245 insertions(+), 72 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
