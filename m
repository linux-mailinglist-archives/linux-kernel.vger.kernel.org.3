Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349BD5840C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiG1OMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiG1OMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:12:34 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D7C1AA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:12:32 -0700 (PDT)
Received: from [192.168.1.101] (abxi232.neoplus.adsl.tpnet.pl [83.9.2.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id A5AD91F740;
        Thu, 28 Jul 2022 16:12:28 +0200 (CEST)
Message-ID: <b5df1acd-d92d-782f-8fb7-41842611c788@somainline.org>
Date:   Thu, 28 Jul 2022 16:12:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 5/5] thermal: qcom: tsens: Add reinit quirk support for
 sm6375 controller
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220724122424.2509021-1-bhupesh.sharma@linaro.org>
 <20220724122424.2509021-6-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220724122424.2509021-6-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.07.2022 14:24, Bhupesh Sharma wrote:
> tsens controller(s) on Qualcomm sm6375 SoC might start in
> an unknown state or start with TSENS_EN indicating
> a 'disabled' state when they enter linux world.
> 
> In such cases, it is useful to try and reinit them via
> trustzone [via scm call(s)], at the very start.
> 
> Add hooks for the same in the qcom tsens driver.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
This sadly doesn't work.. the issue on 6375 is that the controller
is in some weird state at boot and this bit that's higher up:

        ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
        if (ret)
                goto err_put_device;
        if (!enabled) {
                dev_err(dev, "%s: device not enabled\n", __func__);
                ret = -ENODEV;
                goto err_put_device;
        }

does not succeed.

Moving the code added in the patch up or calling
qcom_scm_tsens_reinit() or qcom_scm_tsens_reinit() and 
tsens_reenable_hw_after_scm(priv) directly before this enable
check also fails. In fact, the latter crashes the platform..

I don't want to block this series, so I suggest the 6375 part can
be dropped for now.

Konrad
