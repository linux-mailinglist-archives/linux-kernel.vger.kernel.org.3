Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C105199AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346206AbiEDI0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245607AbiEDI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:26:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD30237CC
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:22:52 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i24so583074pfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SdK0VTClXf0YNc37VM3s8fuaeXHi8SET3pp3ZISSadQ=;
        b=kI3XGnNupu3SzP3j+gsgoUyARk2Wrt2S+bwMeFoftnnsUUT/IKfAPwJBbymvvv7sKI
         MtZiTor/k7fZWZr/pOd91PQ32xe8gk7O8UluhjaoD80iCQq5KR0ElvLOv/+jc5Sk3mTp
         f97GhVWt/tC5JoVDdHJkcpwOFJU+HmA1gUkCOkTFU/nEj4A1jik9+4unIxwkoLU3AM4U
         sB9N2gr+d+eo/1Yc/QkRtRvFlPcxYxsL1WUXNERbUCluf9OeiK43keT2zDGB8ybGKtnJ
         dxk67XdrwEwuYFABcrd90pMCJDxKfIwcmp0BVvmdZgG32cqOH4V+rcUsOte9Mo8V12Mb
         xaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SdK0VTClXf0YNc37VM3s8fuaeXHi8SET3pp3ZISSadQ=;
        b=w0mHZjri2iMxPAvObJu/u/jZ1bEUDxI7Qc1BSy9zihU+I4Ckg2lZhat7lR5ctKeelc
         ScSx6/ew8lujFqj9kab+1uYQL+eDBKNghyK7G6PTgv0SR6RFUQv+DnAmsFgzJfdGsWM2
         0cUj9jpTriUBYVW6RyPcYD/vklR+OR5d/nbn55yvDP4hLjtyAu+WIhUYnbQkf0PXmJ5C
         iUhMYXmtvoy/pjtAo17zVuXToXmd+eiN0DYq8OCAYOlddroi1CNW4M+nwgVyjWHmaQ+K
         Bm6tUjRpx3wZ9BwGT6NgxB0zBp4qIjhhtZif0rPSMbp/l9OvASxsSLhenzRo0jIDiyRb
         vJHg==
X-Gm-Message-State: AOAM530h6NeGK/lY8xxXGlUd/G4Cx0aUW0Plr45cOXP8jpFwoIA4yYau
        ijJtF4VRaellUiiLr76gjpzo4w==
X-Google-Smtp-Source: ABdhPJwfha0ZWyhE1MyC7JONGEsucCB5kCwPDXSeGpREJK9mLcP9oTgoHlBBtf6lTMLv8gsdZ0zvRQ==
X-Received: by 2002:aa7:82d9:0:b0:4fa:2c7f:41e with SMTP id f25-20020aa782d9000000b004fa2c7f041emr20107812pfn.1.1651652571708;
        Wed, 04 May 2022 01:22:51 -0700 (PDT)
Received: from localhost ([122.162.207.161])
        by smtp.gmail.com with ESMTPSA id az12-20020a170902a58c00b0015e8d4eb27esm7653617plb.200.2022.05.04.01.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:22:51 -0700 (PDT)
Date:   Wed, 4 May 2022 13:52:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V4 07/14] cpufreq: mediatek: Add .get function
Message-ID: <20220504082249.anrvkf2ssbxyzz5m@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-8-rex-bc.chen@mediatek.com>
 <20220425053548.72w2jh2g6lpzgz6g@vireshk-i7>
 <64c690e8edf493ec0a4a14e0fdaad2d8e88e6da7.camel@mediatek.com>
 <20220425100058.4kbvmpi63ygni6k5@vireshk-i7>
 <078b1f9b39690da98cbd3c4528ba28374a097083.camel@mediatek.com>
 <20220427031141.or2owu5wrh2cadfo@vireshk-i7>
 <346736a339bed576817179ded3795d61f71fa06a.camel@mediatek.com>
 <20220428114835.3ktimyz2tzzqdcbg@vireshk-i7>
 <27a5dddd91b3dcbd69f08c10108cdec808237ace.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a5dddd91b3dcbd69f08c10108cdec808237ace.camel@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-05-22, 19:33, Rex-BC Chen wrote:
> Our observation tells us cpufreq_online is setting only once at boot
> for one cpu cluster.
> But we can see the problem repeatly occurs once cpufreq_get is invoked.
> 
> e.g.
> [ 71.154560] cpufreq: Warning: CPU frequency out of sync: cpufreq and
> timing core thinks of 500000, is 499999 kHz
> [ 71.155880] cpufreq: notification 0 of frequency transition to 499999
> kHz
> [ 71.156777] cpufreq: notification 1 of frequency transition to 499999
> kHz
> [ 71.187241] cpufreq: target for CPU 0: 500000 kHz, relation 0,
> requested 500000 kHz
> [ 71.188246] cpufreq: target_freq/policy->cur: 500000/499999 kHz

Lemme know if this helps:

https://lore.kernel.org/lkml/39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org/

-- 
viresh
