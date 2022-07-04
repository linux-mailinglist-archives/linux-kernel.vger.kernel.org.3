Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEEF565491
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiGDMLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiGDMKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:10:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7F012AC9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:09:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so3226011pjn.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L3s7MTtQ+37mYaPsVyfqQKMNllwlxopGUK6y9ZwY5+E=;
        b=qp7i48jxUwsTrAPfumImho5NNYkKE6TLsOMVx1WAFbStyAN7FX4XNDUbBKl5arAD3H
         VhGwfhUW+P+LU8uwaMjw+qfuWXbpv4NIdplkdFlgXEkQiX7TUytlcqfXGuIp/waT2DaT
         igDiYePmA79UeMNYr7GLzJqqr2Ni7aXrCzesSxhl/vl9BWu1bB/Mz7eCmQkHTYvwszHE
         okjy/b8QsXG9WiLJu4VZARj76yLq0+YrU0HzfaDznYuTPTpS23pODKXpt+qn2ocYgsDH
         67hch7G4WT/bVGjExuybiN893D0FJNwHHHiGvxbsafxPjR3WPck7wPXluElzRkfe+9Vh
         Q6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L3s7MTtQ+37mYaPsVyfqQKMNllwlxopGUK6y9ZwY5+E=;
        b=RKXq106FrWGgtWqEFvsEHFB7tJ2YQifkwn1W2KIi3JKKxgfdsw5yD1NrCfPabIvFM+
         BNAp2KmbTrSiENKGWt+SdcFGUz6rvx6LLgdA13SozvhsplgypQls2an8sHjucbfAXjD9
         7Z55RjQ8B6DjjT6RKTm8pdOhbOENfH0tLqw4ik3KbinvFk5XOa5rSWQ8m9IOU2GuQYbP
         VMBjjMQvyM8QQ4mm/81eD2ZgrLjOo5XSsC7oR9HXPaDIZkJbTgcr8A/XJEa3uB4n0Zqf
         sijA39wHRTJ7Olv4RWs9ko2RsDBqRf1NPy2yQ1VSI8we4YSvdmAGwE9QLhXxc7znFFJ/
         YsBA==
X-Gm-Message-State: AJIora/HJUxNGhl6nZVPhD/WNqbF6okDgZHOdlwXG0Q9Zjhr910feBVD
        /kcynJ/ObUNwQCLzwkW0QFQMYg==
X-Google-Smtp-Source: AGRyM1srfQeMbT7RKSvocdoskMlrrLTplUGMbAePMCkIF4/ElRn63bIAwLus2lRO48dCtNHmO0F3QA==
X-Received: by 2002:a17:902:ce83:b0:16a:4a3e:4f8b with SMTP id f3-20020a170902ce8300b0016a4a3e4f8bmr37297749plg.41.1656936557118;
        Mon, 04 Jul 2022 05:09:17 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id ik24-20020a170902ab1800b0016bdf0032b9sm2832408plb.110.2022.07.04.05.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:09:16 -0700 (PDT)
Date:   Mon, 4 Jul 2022 17:39:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Message-ID: <20220704120915.s3ermueulcofg7nj@vireshk-i7>
References: <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
 <55623c12-dda3-613f-5bc9-80b3b6fec5f9@nvidia.com>
 <20220622141511.yzg5itkdwirpavfj@vireshk-i7>
 <40e616eb-22f9-19c2-8d77-20cd3c7c518b@nvidia.com>
 <c6f100e4-8a35-ebf0-f833-06ff0d8a2fb6@collabora.com>
 <20220630005028.fddtcbkoksbygwc5@vireshk-i7>
 <8367c38b-8cd3-cde1-5833-874769ef3350@collabora.com>
 <20220630095245.otvo53ezd4avoujw@vireshk-i7>
 <b899ff5f-b424-5f44-7c94-deb013ff6bbc@collabora.com>
 <20220630101540.5dafkegrmcattt2c@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630101540.5dafkegrmcattt2c@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-06-22, 15:45, Viresh Kumar wrote:
> On 30-06-22, 12:57, Dmitry Osipenko wrote:
> > The set_freq_table() gets available freqs using
> > dev_pm_opp_find_freq_ceil() iteration.
> > 
> > The first dev_pm_opp_find_freq_ceil(freq=0) succeeds and returns ceil
> > freq=1.
> 
> I don't see how this can possibly happen. One possibility is that freq
> is set to 0 and one the next loop you do freq++, which can make it 1.
> 
> > The second dev_pm_opp_find_freq_ceil(freq=1) fails with -ERANGE.
> 
> Even if we send freq = 1, I don't see how we can get ERANGE if the OPP
> table is properly initialized.
> 
> > I haven't looked yet at why freq is set to 1.
> 
> Thanks, but I would need some help to get it debugged.

Hi Dmitry,

I am looking to send another version of this now and soon merge this
in for 5.20-rc1. Can you please help figure out what's going on here ?

Thanks.

-- 
viresh
