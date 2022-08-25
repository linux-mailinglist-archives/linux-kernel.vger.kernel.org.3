Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EECF5A0F21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbiHYLdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiHYLdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:33:01 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478FADCD4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:32:57 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220825113252euoutp02c4ba78fd1f4b9ec27a9ffb5dfbab682c~OkzXp9FJH2269822698euoutp023
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:32:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220825113252euoutp02c4ba78fd1f4b9ec27a9ffb5dfbab682c~OkzXp9FJH2269822698euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661427172;
        bh=J7dA541CLYmoZvzF4cBvt/d86azDSBvoz8iVVlgUCIQ=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=NiPMMrcP0RD7zwu01TbB6TsmoIcknd/2EbNAgzA0ECFy+i93bgc1fCpb/t0IArbni
         6lY+UTxp26UAAxydTeo6pnUFFD/BkuyTkUNRtQWzeD1tX5qAc4ehoI+e+4fLlcugYR
         Tc5ZW7JV7jwbPopU2dVWSulrHQj0M7vsY+Q7C5YE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220825113251eucas1p23f3b30dc92986e0816b9c895932975ee~OkzXT6PzB1620116201eucas1p2F;
        Thu, 25 Aug 2022 11:32:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 76.48.19378.3ED57036; Thu, 25
        Aug 2022 12:32:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220825113251eucas1p247c3d57de823da148ca4790975a4aba8~OkzWr3z3E0261102611eucas1p2_;
        Thu, 25 Aug 2022 11:32:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220825113251eusmtrp15fb6d44dd517ae1005f707009c26306f~OkzWrIfAC0372003720eusmtrp1X;
        Thu, 25 Aug 2022 11:32:51 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-3c-63075de3688d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1F.61.10862.3ED57036; Thu, 25
        Aug 2022 12:32:51 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220825113250eusmtip26abdfd37fec4c29ee6c778f48f9221cb~OkzWEueQ22576825768eusmtip2_;
        Thu, 25 Aug 2022 11:32:50 +0000 (GMT)
Message-ID: <58b92e75-f373-dae7-7031-8abd465bb874@samsung.com>
Date:   Thu, 25 Aug 2022 13:32:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v4] regulator: core: Resolve supply name earlier to
 prevent double-init
Content-Language: en-US
To:     =?UTF-8?Q?Christian_Kohlschu=cc=88tter?= 
        <christian@kohlschutter.com>, broonie@kernel.org
Cc:     heiko@sntech.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        m.reichl@fivetechno.de, robin.murphy@arm.com,
        vincent.legoll@gmail.com, wens@kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220818124646.6005-1-christian@kohlschutter.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djPc7qPY9mTDR5eM7GY+vAJm8X2Q8/Z
        LP4/es1q8e1KB5PFpsfXWC0u75rDZnHkfz+jxacH/5ktXh75wWhx8MMTVovja5+xWcyae53N
        gcdjzbw1jB637tR77Jx1l91j06pONo9Jk3cxeWxeUu+x/do8Zo/Pm+QCOKK4bFJSczLLUov0
        7RK4Mu4fe8xc8MG8YvmnDuYGxqN6XYycHBICJhItt74wg9hCAisYJf7/5u5i5AKyvzBKHFq3
        hAXC+cwo8XHeNzaYjrfz5zJCJJYzSvx41cYM4XxklNhwfQUjSBWvgJ3Em3XzgGwODhYBVYnu
        XewQYUGJkzOfsIDYogLJEs/+LwaLCwvESnRN3w4WZxYQl7j1ZD4TiC0iEC9x+91usPnMAj1M
        EseevwVLsAkYSnS97QK7iFPAXmLR1omMEM3yEs1bZzNDXDqdU+LhU2MI20Xi5MrXUB8IS7w6
        voUdwpaROD25hwXkTgmBfIm/M6DKKySuvV4DNcZa4s65X2wgJcwCmhLrd+lDVDtK9OxihTD5
        JG68FYTYzycxadt0Zogwr0RHmxDEDDWJWcfXwa08eOES8wRGpVlIQTILyeuzkHwyC2HtAkaW
        VYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIFp7PS/4193MK549VHvECMTB+MhRgkOZiUR
        XqtjLMlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUamKYc
        PW7zlf/9O0a2r/6KN7PVNA20zOfv+a0uOz8ucrauzwoZvYXPdhfve8ESVLRlmSrHrDkRdlw1
        l+dZ8P/bzWUUZuB7IXpVuMLX1Lz/m05+fn5veYvBNJ9IlX0fpz8KW/I7YnJhFc+15HXNKjWv
        +w+9sQmY6Nk2QUVtd1zTqcXmnwocJh3znCmd3bVK5iGvYsDOV8v8V/U8YuQL3hIz5dcm2Y96
        pe9kz5oFrFG5ESa106qw5M3Onw9ffTy1dDHrNz4TrlcnuCxi+XNu1qR3LuPpXqawWy6xsHbD
        rjg9iXwlz/tvTWxPb/bdyX5TjG+JSqLBjK6XxfVrM2P8f07Q4D2QzGjfe0K/XO1W+tHnIkos
        xRmJhlrMRcWJABNJWNbSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7qPY9mTDS585baY+vAJm8X2Q8/Z
        LP4/es1q8e1KB5PFpsfXWC0u75rDZnHkfz+jxacH/5ktXh75wWhx8MMTVovja5+xWcyae53N
        gcdjzbw1jB637tR77Jx1l91j06pONo9Jk3cxeWxeUu+x/do8Zo/Pm+QCOKL0bIryS0tSFTLy
        i0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mu4fe8xc8MG8YvmnDuYG
        xqN6XYycHBICJhJv589l7GLk4hASWMoosWdKGzNEQkbi5LQGVghbWOLPtS42iKL3jBJLV11n
        B0nwCthJvFk3D6ibg4NFQFWiexdUWFDi5MwnLCC2qECyxIJDS8FsYYFYia7p28FsZgFxiVtP
        5jOB2CIC8RITzzWyg8xnFuhhkpjy5QhYkZBAosSB+XPAjmATMJToegtyBCcHp4C9xKKtExkh
        BplJdG3tgrLlJZq3zmaewCg0C8kds5Dsm4WkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1
        kvNzNzECI3jbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEV6rYyzJQrwpiZVVqUX58UWlOanFhxhN
        gWExkVlKNDkfmELySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqY
        Ity7NVSbjq7nNWCLZ1I/++zfnbhlGqcu/WvgfivIebXyr3b8S8vrj9a2L58Rr5VnszHeNXC7
        end4VQPv6bL7j167plWc2jOTX6iR512wwf+tN7+5GN48mJf8XWDu7YSyRuvnQjGBn+5uTs1d
        I+VZkTp778kdfUWq/6crvXtSseDFTYWrjaGpi7fPEzo6V+LfyX1lTP9bks9P4sxalm/xUyqr
        3pcvICn3hmnC9Nnr7EsfaOo83Gr5dPbzWy0N39XlOZn7G1RnHOf0nH4mT/52+0WtZ5HSrrEv
        yzv1uffrc2rcuBJ6227qid/vE7edWBApW9mc8aLkvyzjjyeFk++tFbrWt0B5l3bHv77zF6q+
        KrEUZyQaajEXFScCAPU6caRpAwAA
X-CMS-MailID: 20220825113251eucas1p247c3d57de823da148ca4790975a4aba8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220825113251eucas1p247c3d57de823da148ca4790975a4aba8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220825113251eucas1p247c3d57de823da148ca4790975a4aba8
References: <YvorNPDQQr2SH/NF@sirena.org.uk>
        <20220818124646.6005-1-christian@kohlschutter.com>
        <CGME20220825113251eucas1p247c3d57de823da148ca4790975a4aba8@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 18.08.2022 14:46, Christian Kohlschütter wrote:
> From: Christian Kohlschütter <christian@kohlschutter.com>
>
> Previously, an unresolved regulator supply reference upon calling
> regulator_register on an always-on or boot-on regulator caused
> set_machine_constraints to be called twice.
>
> This in turn may initialize the regulator twice, leading to voltage
> glitches that are timing-dependent. A simple, unrelated configuration
> change may be enough to hide this problem, only to be surfaced by
> chance.
>
> One such example is the SD-Card voltage regulator in a NanoPI R4S that
> would not initialize reliably unless the registration flow was just
> complex enough to allow the regulator to properly reset between calls.
>
> Fix this by re-arranging regulator_register, trying resolve the
> regulator's supply early enough that set_machine_constraints does not
> need to be called twice.
>
> Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>

This patch landed recently in linux next as commit 8a866d527ac0 
("regulator: core: Resolve supply name earlier to prevent double-init"). 
Unfortunately it breaks booting of Samsung Exynos 5800 based Peach-Pi 
(arch/arm/boot/dts/exynos5800-peach-pi.dts) and Peach-Pit 
(arch/arm/boot/dts/exynos5420-peach-pit.dts) Chromebooks. The last 
message in the kernel log is a message about disabling 'vdd_1v2' 
regulator. This regulator is not used directly, however it is a supply 
for other critical regulators.

In the kernel log I also noticed lots of the following warnings, which 
were not present before this patch:

[    2.977695] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    2.987715] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    2.997524] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.007560] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.017240] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.026765] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.036501] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.045809] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.055497] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.064765] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.074549] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.085336] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.094815] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.104282] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.113755] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.124446] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.135298] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.144788] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.154562] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!
[    3.164340] debugfs: Directory '(null)-SUPPLY' with parent 
'reg-dummy-regulator-dummy' already present!

They are printed when the main PMIC is being probed and registered. This 
shows that the supplies for some regulators are not properly found, 
probably due to the circular dependencies there ('vdd_1v2' is provided 
by the same PMIC, which use it as a supply for other regulators).

Let me know if I can help debugging this issue further, but for now I 
would suggest reverting this change.

> ---
>   drivers/regulator/core.c | 52 +++++++++++++++++++++++++---------------
>   1 file changed, 33 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index d8373cb04f9..a5033c6ba01 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5496,7 +5496,39 @@ regulator_register(const struct regulator_desc *regulator_desc,
>   	BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
>   	INIT_DELAYED_WORK(&rdev->disable_work, regulator_disable_work);
>   
> -	/* preform any regulator specific init */
> +	/* set regulator constraints */
> +	if (init_data)
> +		rdev->constraints = kmemdup(&init_data->constraints,
> +					    sizeof(*rdev->constraints),
> +					    GFP_KERNEL);
> +	else
> +		rdev->constraints = kzalloc(sizeof(*rdev->constraints),
> +					    GFP_KERNEL);
> +	if (!rdev->constraints) {
> +		ret = -ENOMEM;
> +		goto clean;
> +	}
> +
> +	if (init_data && init_data->supply_regulator)
> +		rdev->supply_name = init_data->supply_regulator;
> +	else if (regulator_desc->supply_name)
> +		rdev->supply_name = regulator_desc->supply_name;
> +
> +	if ((rdev->supply_name && !rdev->supply) &&
> +			(rdev->constraints->always_on ||
> +			 rdev->constraints->boot_on)) {
> +		/* Try to resolve the name of the supplying regulator here first
> +		 * so we prevent double-initializing the regulator, which may
> +		 * cause timing-specific voltage brownouts/glitches that are
> +		 * hard to debug.
> +		 */
> +		ret = regulator_resolve_supply(rdev);
> +		if (ret)
> +			rdev_dbg(rdev, "unable to resolve supply early: %pe\n",
> +					 ERR_PTR(ret));
> +	}
> +
> +	/* perform any regulator specific init */
>   	if (init_data && init_data->regulator_init) {
>   		ret = init_data->regulator_init(rdev->reg_data);
>   		if (ret < 0)
> @@ -5522,24 +5554,6 @@ regulator_register(const struct regulator_desc *regulator_desc,
>   		    (unsigned long) atomic_inc_return(&regulator_no));
>   	dev_set_drvdata(&rdev->dev, rdev);
>   
> -	/* set regulator constraints */
> -	if (init_data)
> -		rdev->constraints = kmemdup(&init_data->constraints,
> -					    sizeof(*rdev->constraints),
> -					    GFP_KERNEL);
> -	else
> -		rdev->constraints = kzalloc(sizeof(*rdev->constraints),
> -					    GFP_KERNEL);
> -	if (!rdev->constraints) {
> -		ret = -ENOMEM;
> -		goto wash;
> -	}
> -
> -	if (init_data && init_data->supply_regulator)
> -		rdev->supply_name = init_data->supply_regulator;
> -	else if (regulator_desc->supply_name)
> -		rdev->supply_name = regulator_desc->supply_name;
> -
>   	ret = set_machine_constraints(rdev);
>   	if (ret == -EPROBE_DEFER) {
>   		/* Regulator might be in bypass mode and so needs its supply

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

