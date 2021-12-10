Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5874705AD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbhLJQcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240234AbhLJQcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:32:33 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151FDC0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:28:57 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2E8E31F69D;
        Fri, 10 Dec 2021 17:28:54 +0100 (CET)
Subject: Re: [PATCH 2/3] firmware: qcom: scm: Add function to set the maximum
 IOMMU pool size
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Alex Elder <elder@linaro.org>, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211208083423.22037-1-marijn.suijten@somainline.org>
 <20211208083423.22037-3-marijn.suijten@somainline.org>
 <b21686fc-3662-1ed4-8ba3-8ed5ca6eda13@linaro.org>
 <20211208234436.ktagmcfj6jl5jct5@SoMainline.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <fb1005b6-e610-407f-39bb-7cd6a198f9d6@somainline.org>
Date:   Fri, 10 Dec 2021 17:28:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211208234436.ktagmcfj6jl5jct5@SoMainline.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/12/21 00:44, Marijn Suijten ha scritto:
> On 2021-12-08 07:30:28, Alex Elder wrote:
>> On 12/8/21 2:34 AM, Marijn Suijten wrote:
>>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>>
>>> This is not necessary for basic functionality of the IOMMU, but
>>> it's an optimization that tells to the TZ what's the maximum
>>> mappable size for the secure IOMMUs, so that it can optimize
>>> the data structures in the TZ itself.
>>
>> Are there no users of this function?	-Alex
> 
> I should have probably mentioned in the cover letter that this function
> and the one introduced in patch 3/3 are going to be used in upcoming
> patches for IOMMUs found in msm8976, msm8974 and related SoCs (with the
> side-note that I don't see this particular set_cp_pool_size used in the
> branch that this was submitted from, but it's most likely used elsewhere
> or planned ahead to be used in the near future - I expect Angelo to be
> able to comment on that more accurately).
> 

This function is used in the secured iommu pagetable setup, but not for
all of the "SCM feature versions" (only for version >= 1.1.1, downstream
reads it with a call to scm_feat_version()).

It's not strictly necessary for functionality, hence why Marijn isn't
seeing any call to this in the branch that he was browsing: the spirit here
is to first introduce code that does a minimal (but, of course, working)
setup of the IOMMUs found in MSM8956/76 (which can be adapted with very
minimal changes to other SoCs), and *only then* to add these performance
enhancements to the mix.

...and this is why this commit is here :))

By the way, if my memory isn't failing me, that SCM call should be usable
on all AArch64 SoCs (so, 8956, 8994 and the rest).
