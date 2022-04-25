Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510BB50EB0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 23:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245536AbiDYVLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiDYVLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:11:32 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7C66D3B5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:08:26 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g19so28493881lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HeAipw4zYNeia12j7XYVHYU9J94Bm4xqgnpreAQ+Qzk=;
        b=bJuLeSOBykWi8VGrKRwylfeefE2eR9q7qefiHN/24sOZYASDOB9zymZS0eZbwAsheU
         Gn4212dpt17MZcEosVxxHQ1QU71XN3nv/dW+3Sgz+L/ZmBsC+H8kYSSCGKgVux/H0RZJ
         OlHI/3SxclyA+rX2bf47Vrd+l8jqMnjmfHjFL8evdEp77DNfVFCA6pbb7dQy/DGPXKYD
         nwXorNKIEOk5/vOMCoxziHmqaFKWA8YpmSxLjZ6iywDpExXO33x6Yq1p/nXkMzvdwhtS
         +Gf4v9krns0rCYdVYEaZ+LAnv+gS0yE48Kitf0Icp0BbyPAXL+1aXCkrteqcXE8WlyRA
         ZNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HeAipw4zYNeia12j7XYVHYU9J94Bm4xqgnpreAQ+Qzk=;
        b=y4nVdUDZb4T845x3A2+nrq5158xYApzCjJ5xnOGc3Mydg91f92kwV2SLuysmzd79Lx
         oEbjiDjxod8L1DfFE9Kl7SYF3ch++Z/EDl/+GEr1JuDaLidfuPE0T4p3YvzPZLvik6ko
         NlKn/cqfIYCGFhj2xLmed+ra5Iao+i+hpVzA4kIxutj+dlh/u/IFRwDADKAsCTmEjlKv
         fl3vZhEvjrORkXRmqGinTL7EOlrMb6e2Js3nfDcQDCSAHwCLwX6/7Uu5Ey+FGW58q07c
         Lobl1kJIiWPApk5+cHhMap6q0nKAt83Q4tsVwpkMlyCugAEySGYJ2HtvHm8pKM8XQM0B
         oKgA==
X-Gm-Message-State: AOAM533k6CgMFa3DNVs54C5PLsy07CbFmYZsiuE0MIR662s+mZQk4XXt
        aBYnVO8cG7S5TYRne5/FIK9n+w==
X-Google-Smtp-Source: ABdhPJwa4PWVY0l1RBVql9YpM5TgtmLWxVWf1CxtDSxCxju9pLQGfESguxQXkIRMvWAE98kugzeAgw==
X-Received: by 2002:a05:6512:239c:b0:472:3d5:7e77 with SMTP id c28-20020a056512239c00b0047203d57e77mr5600455lfv.448.1650920904365;
        Mon, 25 Apr 2022 14:08:24 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q3-20020a19f203000000b0044aef0e60d5sm1528696lfh.210.2022.04.25.14.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 14:08:23 -0700 (PDT)
Message-ID: <517db2b8-6be0-2f2b-f98e-ca5ca27d0603@linaro.org>
Date:   Tue, 26 Apr 2022 00:08:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/msm/dpu: fix error check return value of
 irq_of_parse_and_map()
Content-Language: en-GB
To:     Stephen Boyd <swboyd@chromium.org>, cgel.zte@gmail.com,
        robdclark@gmail.com, sean@poorly.run
Cc:     quic_abhinavk@quicinc.com, airlied@linux.ie, daniel@ffwll.ch,
        bjorn.andersson@linaro.org,
        angelogioacchino.delregno@somainline.org, tiny.windzz@gmail.com,
        architt@codeaurora.org, jsanka@codeaurora.org,
        skolluku@codeaurora.org, ryadav@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
References: <20220425090947.3498897-1-lv.ruyi@zte.com.cn>
 <CAE-0n50fs1fFQcwMCq_x_UG8ZJKprjcYKwcy1+1ckD--XE28+g@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAE-0n50fs1fFQcwMCq_x_UG8ZJKprjcYKwcy1+1ckD--XE28+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 23:10, Stephen Boyd wrote:
> Quoting cgel.zte@gmail.com (2022-04-25 02:09:47)
>> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>>
>> The irq_of_parse_and_map() function returns 0 on failure, and does not
>> return a negative value anyhow, so never enter this conditional branch.
>>
>> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
>> ---
> 
> Question still stands why we can't use platform device APIs.

Let's do a separate pass and replace all of functions with platform 
device API.

> Reviewed-by: Stephen Boyd <swboyd@chromium.org>


-- 
With best wishes
Dmitry
