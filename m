Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF3A47D0FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244656AbhLVL25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:28:57 -0500
Received: from relay03.th.seeweb.it ([5.144.164.164]:45671 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhLVL2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:28:55 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2492120220;
        Wed, 22 Dec 2021 12:28:53 +0100 (CET)
Subject: Re: [PATCH v2 2/2] drm/msm/dpu: Fix timeout issues on command mode
 panels
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, abhinavk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20210911163919.47173-1-angelogioacchino.delregno@somainline.org>
 <20210911163919.47173-2-angelogioacchino.delregno@somainline.org>
 <b325fc8d-e06b-36de-b40a-b5ffbcebb1c5@linaro.org>
 <94bedea3-0e5f-5ae8-79d1-ceb17ccdea23@somainline.org>
 <20211211213528.uroqfdksvokspbxf@SoMainline.org>
 <CAA8EJprT5gcWOsS5jJk8egUpxutBpUdW2Pnh-8FFXhgOd3hr=A@mail.gmail.com>
 <20211211215718.pe675o5wvculxavc@SoMainline.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <33d44631-f0d7-83cc-569d-d6d6f82d6808@somainline.org>
Date:   Wed, 22 Dec 2021 12:28:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211211215718.pe675o5wvculxavc@SoMainline.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/12/21 22:57, Marijn Suijten ha scritto:
> On 2021-12-12 00:49:09, Dmitry Baryshkov wrote:
>> On Sun, 12 Dec 2021 at 00:35, Marijn Suijten
>> <marijn.suijten@somainline.org> wrote:
>>> [..]
>>> On this note, does it perhaps make more sense to call the "internal"
>>> _dpu_encoder_phys_cmd_wait_for_idle function directly, instead of going
>>> through the "public" dpu_encoder_phys_cmd_wait_for_tx_complete which
>>> seems solely intended to handle the wait_for_tx_complete callback?
>>
>> Either one would work. The main difference is the error message. Do
>> you want to see it here if the wait times out or not?
> 
> I prefer calling _dpu_encoder_phys_cmd_wait_for_idle directly and
> optionally adding our own error message.  IIRC DRM_ERROR prints source
> information such as the function this originated from, and that makes it
> impossible to distinguish between the wait_for_tx_complete callback or
> the invocation through dpu_encoder_phys_cmd_wait_for_commit_done anyway.
> 
> - Marijn
> 

I wouldn't be happy to find myself in a situation in which I get strange
display slowness without any print to help me; for this reason, I find
having the print in place useful for debugging of both perf and fault.

Cheers,
- Angelo
