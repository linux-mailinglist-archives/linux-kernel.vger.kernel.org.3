Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF6468511
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345187AbhLDNiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhLDNiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:38:13 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5474EC061751;
        Sat,  4 Dec 2021 05:34:46 -0800 (PST)
Received: from [192.168.1.101] (83.6.167.217.neoplus.adsl.tpnet.pl [83.6.167.217])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B1BC320153;
        Sat,  4 Dec 2021 14:34:41 +0100 (CET)
Message-ID: <f0ae3d36-8317-b297-cc99-645adca1f25c@somainline.org>
Date:   Sat, 4 Dec 2021 14:34:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/3] thermal: qcom: lmh: Add support for sm8150
Content-Language: en-US
To:     Thara Gopinath <thara.gopinath@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211202223802.382068-1-thara.gopinath@linaro.org>
 <20211202223802.382068-2-thara.gopinath@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211202223802.382068-2-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02.12.2021 23:38, Thara Gopinath wrote:
> Add compatible to support LMh for sm8150 SoC.
> sm8150 does not require explicit enabling for various LMh subsystems.
> Move this piece of code under condition that it is executed only
> for sdm845 SoC.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/thermal/qcom/lmh.c | 61 ++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 29 deletions(-)

[...]


> -		return ret;
> +	if (of_device_is_compatible(np, "qcom,sdm845-lmh")) {
> +		if (!qcom_scm_lmh_dcvsh_available())
> +			return -EINVAL;

I don't believe this is the correct approach, as different SoCs may

require different sequences of these writes (for example SDM660/MSM8998

seems to only enable the thermal algorithm), and there will (hopefully) be interest

in adding LMH support for more platforms, so perhaps separating this somehow

could keep this a bit cleaner and easier to work with for the next person..



Konrad

