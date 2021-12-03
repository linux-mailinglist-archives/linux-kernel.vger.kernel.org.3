Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25872467EB9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383061AbhLCUUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383056AbhLCUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:20:39 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B68C061751;
        Fri,  3 Dec 2021 12:17:15 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so6033232pja.1;
        Fri, 03 Dec 2021 12:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mnSnpOV3iUpweMKF/zZj+CKSpABDG2Pi7iODvdNpA9s=;
        b=Xxzwr7JpTy1FZtQ1e49ff1w/idHzZQdkDrvFmp6Pw8ObtyMFsRt+QqWKpGRFrw1LXL
         DHSgwUZqAvtl4iosG37yIXAS0ZWLXQPg8eQu5MtDMv9L81IZr3ld3aaswuBxxWyCh4hv
         GsN0wNT9c0CdWFOF1BMyFXimqlTEL8ND9ZQNkSN4iKzpwVl9ER1F2dyf5O7o/pYC2Yxx
         b6IP7cb8d7P11CvxYMdDlAma14i3VqKdEv2WL8p5RVbq6+VExnIKXiv56P1SRgsrEJLq
         BWFm7hE/WhudP7m9S6znORM+/PYH8wGQkkozfkD4DGNJ3tFvdcmurJxBWZebHccpxc+5
         uPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mnSnpOV3iUpweMKF/zZj+CKSpABDG2Pi7iODvdNpA9s=;
        b=kBNXwOTa4g+LG6z4YPRNDS5U+pyYgfww5wy15KLGPoDgqCRk2ktH6ebZFN7/ooGKqr
         MMX+tM1/fzdhdg+s+QpaK/4Cr5e6uogqbc+EPxNfqt5sZqS0qXs9cvGP19yhowqSCpGC
         nplrAb3VvFMaPzYK15f3FE2YJCaV+pDKvF3M3rJY0JOcePCoeSxLKWGS0QneqjchgjEp
         CPmX4/kcK9rHb/bXgTGNvSb7lCf9YzqxSGMGggSWBhfC4o9SOOEwJVkHMNIGqzLIzku7
         JmKd0BEs7Wj8meTm6e31G5Aw73858ntQLVjLZfCLA6qPC5hHNnJIlIeObaJoq8bOmURH
         94jw==
X-Gm-Message-State: AOAM532ppBUc4Tbq07Zxn3O8eIopa3+e8G/N1GjUbUerPTKdcB1+pnio
        F+iNFohV4lQTRRlRTkshz34yBM5TiN0=
X-Google-Smtp-Source: ABdhPJySJETDFPcP9hgu7LDYapZecYZAw5T7SZkaimQMZDrSjQ4ENsy8cwPJYUrgF0N+79DPo4Zl7g==
X-Received: by 2002:a17:902:dad2:b0:141:fbea:178d with SMTP id q18-20020a170902dad200b00141fbea178dmr25275454plx.78.1638562634673;
        Fri, 03 Dec 2021 12:17:14 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fs21sm5905275pjb.1.2021.12.03.12.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 12:17:14 -0800 (PST)
Subject: Re: [PATCH v7 16/16] clk: scmi: Support atomic clock enable/disable
 API
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-17-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a7372722-241c-be0c-0581-5446375cecdc@gmail.com>
Date:   Fri, 3 Dec 2021 12:17:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129191156.29322-17-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 11:11 AM, Cristian Marussi wrote:
> Support also atomic enable/disable clk_ops beside the bare non-atomic one
> (prepare/unprepare) when the underlying SCMI transport is configured to
> support atomic transactions for synchronous commands.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
