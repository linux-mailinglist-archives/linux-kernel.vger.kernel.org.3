Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25A9489587
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbiAJJqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243074AbiAJJqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:46:19 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0F4C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:46:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t28so18812875wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+abZjbadrthkxAndrqLQ/y+060FFMnMwVyalc3ssY1Y=;
        b=sO2E/PaXEhSg08nvq/BCgxO8/eqxz7kYQykOe29ZAMGqlz4RjZiVUTmKtkK4J+qI6B
         FHSGBoGhMWSscRNeJOBxhZXeQhcZ6InnvUpjexCThxUsMuG2bYJfqoh84D0VfH+pxv0F
         TQsxMrKdSyMTSok4d+LNJ2ki7L6oJ4cCQcdb9ZnNqa3m0g4plEsiLJkHZB+uXtOX2/ep
         0b0X/KT4oa9N/SstNfh5gD8g7Da74iLwCk2nxP3+RdIK3cQRbMJTjiiZNthu6yIT7VCM
         qoZ23WmUA6bTE75sPMRidBuaPMUS8NEMoasXzRkI+vktnP0TwK8SyKZjKJALt2slE8Y9
         yovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+abZjbadrthkxAndrqLQ/y+060FFMnMwVyalc3ssY1Y=;
        b=Ds5IkqVTQ09MxBPthUzuzhTqWdTbNXZNnlBiE5I9rTLM3oTMwEN7LiaLD1KbLBajzE
         Xmr5DuVCqk1HeE0IaWkyiMD7qP1lhBGaZsVmj1olFAnqoRB/dpZCO2EK1+1RFOWUA89g
         o5IBfLDTQpeD8iR2Wtrs+y/lSSpVOxLIbMHob5vcyKbKuWIXQMa0Qf/ayHNde5f5CDtg
         vG6XHvHKB3ErknaOLH+oaD6/ccC51pCPLAtg7XeTjnd9JyZzVHiFvbG8rmzCwkdmko84
         rFGEOyVfRvFBxXxGjB0mm0AGqNoktxAInFl/E5oQ+D9Y5QNMl+Eicf2xbVaDCUBxqr/E
         6bgg==
X-Gm-Message-State: AOAM532INv8VwKjsyfb0YbCyg7b+P8+VP8qMrbR4aLCPsbw1pXojqJ6K
        dcN5hToLJupNFcW+p6kbX0QB+sLm2F9byQ==
X-Google-Smtp-Source: ABdhPJz1VFZkwqr2BXYdj3OFdBaCpkLg0P2ezfDFiTjGjOlfKUP0TggZS0l0V/6zvUk0jNJegfFt3A==
X-Received: by 2002:adf:fc0f:: with SMTP id i15mr5742743wrr.467.1641807977299;
        Mon, 10 Jan 2022 01:46:17 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:94e5:2e36:6bcc:a9f1? ([2001:861:44c0:66c0:94e5:2e36:6bcc:a9f1])
        by smtp.gmail.com with ESMTPSA id u14sm6078840wrf.39.2022.01.10.01.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 01:46:16 -0800 (PST)
Subject: Re: [PATCH 5/6] drm/meson: add DSI encoder
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220107145515.613009-1-narmstrong@baylibre.com>
 <20220107145515.613009-6-narmstrong@baylibre.com>
 <CAFBinCCR4zftkvJWgX4T068BRsjVp9YhRbzgdBOR+tuMcGSZ3w@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <b0200846-0346-a65b-ed98-c0c778040cd9@baylibre.com>
Date:   Mon, 10 Jan 2022 10:46:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCCR4zftkvJWgX4T068BRsjVp9YhRbzgdBOR+tuMcGSZ3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 23:35, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Fri, Jan 7, 2022 at 3:57 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> 
> [...]
>> +       writel_bits_relaxed(BIT(3), BIT(3), priv->io_base + _REG(ENCL_VIDEO_MODE_ADV));
> see my comment on patch #3 from this series for BIT(3)
> 

Yep, thanks,

Neil

> 
> Best regards,
> Martin
> 

