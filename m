Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4388B50063F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 08:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbiDNGlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 02:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiDNGlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 02:41:18 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA2F31DFB;
        Wed, 13 Apr 2022 23:38:52 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220414063850euoutp013d3a81c830570d4e44c36506643ddb5e~lr-rAXsDP0823308233euoutp01a;
        Thu, 14 Apr 2022 06:38:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220414063850euoutp013d3a81c830570d4e44c36506643ddb5e~lr-rAXsDP0823308233euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649918330;
        bh=iZJ0s+Xj2eet3xX8TAKGb2899dU+i00esTWn1QUmUaE=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=swaPJwNZ/dok3lpu7CKnLpFvMNK66+bsViY0NWvnGzO+i3Cx4SIh+69lzQr7kPluQ
         WkXXWLFmS4+SS65FURorJUHhid6/2/Pq0bG6fb3BkREkY6gcKzwO+HLKX0H4YpJafb
         oJfgPJwWyNflwR107wF/yAHK00ENO85PcPDV2yZI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220414063849eucas1p2edb867a5d82f16c3ecd193c3c5253ca1~lr-quG01i2885528855eucas1p2J;
        Thu, 14 Apr 2022 06:38:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 27.72.09887.971C7526; Thu, 14
        Apr 2022 07:38:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220414063849eucas1p126e41b53ff0d342f5c48408994b704e9~lr-qSAv_c3094930949eucas1p1_;
        Thu, 14 Apr 2022 06:38:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220414063849eusmtrp1feb8830483e8f0c8cc09abb606d918bc~lr-qQt94F1095910959eusmtrp1f;
        Thu, 14 Apr 2022 06:38:49 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-36-6257c1797257
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 19.B3.09404.971C7526; Thu, 14
        Apr 2022 07:38:49 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220414063847eusmtip12bd90501637cb3e6303ce2fd8295e5d3~lr-oxFH-51804918049eusmtip1m;
        Thu, 14 Apr 2022 06:38:47 +0000 (GMT)
Message-ID: <3a24ef01-3231-1bee-7429-dce5680c5682@samsung.com>
Date:   Thu, 14 Apr 2022 08:38:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v4 11/13] pinctrl: meson: Replace custom code by
 gpiochip_node_count() call
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220401103604.8705-12-andriy.shevchenko@linux.intel.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfVCTdRy/3/M8e56xbvrwUvykDBtpV54ggne/3hQ6iCf/iouLkg7b3HNs
        8nqbM3ERyiEYhw5RYYw5Xsx4iUq28bLlCJCck3JFB6Ix4oqlEAScWm4n0MaDxX+f7+f7/Xy+
        L/fl40E3yTC+POcgq8gRZ4lIAdF51XNjW35fqmR7Y0ME8kxVATRh6CSR09WPo5NF1RjyVJ/C
        kNY2gSPrhC/xR4+GROdrKwHSN+ejmd8GcOQpNWPI6bxEobOPmjBUX/sEMv4+wkOmukcA/WzV
        k6hj6i+fh7MHQ2Ujkzx0tdFBIIvewUOGxS95qP9UGrpefJdArvFrBLJ5fZZXZkp5aM4Tj6y9
        xyjkNU8D1Gr1udl62wlU4v2cjItgBtq+AMzc6HGKuTDyC48xtKkZt6aDYk7/sI2x6FwUU29U
        Me6KMxRjbP2UZMZGLpOMwZHMmD4rZJzaBsBYuu9hjGZx+9vBewWvSdks+SFWEbXrQ4FsvmuZ
        ypt/6vBwXdhRYAsqAwF8SMfCJacNlAEBP4huBvDa5XMEF9wH8ErfAM4F9wC82ViMPZac/mZp
        NdEE4HDXhVXJAoDOi2Okv0pI74Kdy+WUHxP0Zmi+O4dzfCB01EwSfvwkLYHne8ZX+GBaDIsm
        ZlZ4nA6FtyfrML9pCP09AYvsxyh/gNNOEs4Pcx1IOhqWzZat4AA6CXqNOopTh8OuWf3KfJCe
        EcCWKi3BDZ4A62YvkhwOhtN2M8XhZ+DgmXJfDd+Hc+GiNoajD8ORP9twDr8Kx254SX8JTr8I
        v7ZGcXQ8HNLVkJxyHRydDeQmWAcrO6txjhbCEyWrt94Cdfav/uvZ9+MQXgFEujVX0a3ZXrdm
        F93/fesB0QpCWZUyO4NV7shhP4pUirOVqpyMyP252Ubg+/3BJfv9btA0vRDZDzA+6AeQj4tC
        hLc0qZIgoVScf4RV5O5TqLJYZT94mk+IQoX75ZfEQXSG+CCbybJ5rOJxFuMHhB3FykffKc2v
        fPfWwORguOMhDLmzszfh7z17LUndTa3rqQQoO2dIkbRo3HBo0+5wd7q8QntWujF4Uzxb+lPK
        cnPlBvMHjslBvalkxx55mv2tcY09/OVl12JlS7r6nxfEb2SrEjOj1d9GifriTMkD+u6tSYZD
        cQdqAtUWSrevIeZN03cF6Ynlue89V6vfYNKeTMQjyY8pT2ceMot7xqSCSE2yUf5r1WY13+O2
        SAseeHdmbixP6b0jWaiJ6IiZKnq++sC4tb3koWXaeCKK9r7vEu6ueEU2lXa9ME8EjhTLFh3t
        D3i1z1bdrm2J3aLtWv86CmAlqbGuAuknsoythXVLx3NEhFImjn4JVyjF/wJe+8E9agQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsVy+t/xu7qVB8OTDHZuYrP4+XIao8WDedvY
        LM7fPcRs0ds0ncni5/Q+JosZex8wW+x6AJR4tq+fzWLu7EmMFnNWVFq8eXSE2eJn+xYmi/Pn
        N7BbTPmznMliwWxui02Pr7FabJ7/h9Hi8q45bBZbX74DmnF+H5NF17UnrBbHFp1ksdg55ySr
        xby/a1ktDvVFW5xqecFicffeCRaLvb+ARh5+085q8f6no8WuA43sFr+2vGK0WLULaNreAxtZ
        LNp+LWNzUPY4smY1o8f7G63sHouv3Wb1mLem2uNp/1Z2j4lndT12zrrL7rFgU6nH0wmT2T02
        repk87hzbQ+bx7yTgR6bl9R7nJ+xkNFj547PTB79fw0ChKP0bIryS0tSFTLyi0tslaINLYz0
        DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mj5s/89e8EGs4up8qQbGvUJdjJwcEgIm
        EhN3/2PuYuTiEBJYyihx70sHK0RCRuLktAYoW1jiz7UuNoii94wSF7qOs4EkeAXsJLb972EH
        sVkEVCW2vHjPDBEXlDg58wkLiC0qkCTxYttzRhBbWCBRounBG7A4s4C4xK0n85lAhooInGOR
        uHCulxXEYRa4yCYxedcKqJuaGCX2PnwFNpZNwFCi620X2GpOAXeJX5tmsUOMMpPo2trFCGHL
        S2x/O4d5AqPQLCSXzEKycRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQITHbb
        jv3csoNx5auPeocYmTgYDzFKcDArifDe7A9PEuJNSaysSi3Kjy8qzUktPsRoCgyOicxSosn5
        wHSbVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXA5HZNZmJ915EU
        zk8a4k5mYjuWb77+1mpFYYPKuqenVt8Pdv4hMt/blndi0WtHpcZbbWqPnSZHxyV/q16pWrV5
        bVL59uOrj1et19XQmfqO779z9arVR/f0v9asaNV5cie09O1n8cqzG+S/tFe7bNn1/djKraIV
        5VNYw96oBZ1q4zPyZOzaXWb7bYWbjoqH65EI/mcNfAUbPzxgOfPEJjLWP/ZCyHn1/rSTjFdu
        7eqfuN98mtBDeVblbb8Oyi9WcZgWo3NaZntotPTyttnl1zqeX53Uf27u2TTnB8Jr1h+R9KlT
        6rP70Ld2Vm7EjHl1Fk4HGppLOT7kneFOeF+8YFXMNO1NS221OSsSNWdP4Us6qcRSnJFoqMVc
        VJwIAKE4crP/AwAA
X-CMS-MailID: 20220414063849eucas1p126e41b53ff0d342f5c48408994b704e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220414063849eucas1p126e41b53ff0d342f5c48408994b704e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220414063849eucas1p126e41b53ff0d342f5c48408994b704e9
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
        <20220401103604.8705-12-andriy.shevchenko@linux.intel.com>
        <CGME20220414063849eucas1p126e41b53ff0d342f5c48408994b704e9@eucas1p1.samsung.com>
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 01.04.2022 12:36, Andy Shevchenko wrote:
> Since we have generic function to count GPIO controller nodes
> under a given device, there is no need to open code it. Replace
> custom code by gpiochip_node_count() call.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

This patch landed in linux next-20220413 as commit 88834c75cae5 
("pinctrl: meson: Replace custom code by gpiochip_node_count() call"). 
Unfortunately it breaks booting of all my Amlogic-based test boards 
(Odroid C4, N2, Khadas VIM3, VIM3l). MMC driver is no longer probed and 
boards are unable to mount rootfs. Reverting this patch on top of 
linux-next fixes the issue.

> ---
>   drivers/pinctrl/meson/pinctrl-meson.c | 28 ++++++++++++---------------
>   1 file changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index 5b46a0979db7..1b078da81523 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -49,6 +49,7 @@
>   #include <linux/pinctrl/pinctrl.h>
>   #include <linux/pinctrl/pinmux.h>
>   #include <linux/platform_device.h>
> +#include <linux/property.h>
>   #include <linux/regmap.h>
>   #include <linux/seq_file.h>
>   
> @@ -662,27 +663,22 @@ static struct regmap *meson_map_resource(struct meson_pinctrl *pc,
>   	return devm_regmap_init_mmio(pc->dev, base, &meson_regmap_config);
>   }
>   
> -static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
> -				  struct device_node *node)
> +static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc)
>   {
> -	struct device_node *np, *gpio_np = NULL;
> +	struct device_node *gpio_np;
> +	unsigned int chips;
>   
> -	for_each_child_of_node(node, np) {
> -		if (!of_find_property(np, "gpio-controller", NULL))
> -			continue;
> -		if (gpio_np) {
> -			dev_err(pc->dev, "multiple gpio nodes\n");
> -			of_node_put(np);
> -			return -EINVAL;
> -		}
> -		gpio_np = np;
> -	}
> -
> -	if (!gpio_np) {
> +	chips = gpiochip_node_count(pc->dev);
> +	if (!chips) {
>   		dev_err(pc->dev, "no gpio node found\n");
>   		return -EINVAL;
>   	}
> +	if (chips > 1) {
> +		dev_err(pc->dev, "multiple gpio nodes\n");
> +		return -EINVAL;
> +	}
>   
> +	gpio_np = to_of_node(device_get_named_child_node(pc->dev, "gpio-controller"));
>   	pc->of_node = gpio_np;
>   
>   	pc->reg_mux = meson_map_resource(pc, gpio_np, "mux");
> @@ -751,7 +747,7 @@ int meson_pinctrl_probe(struct platform_device *pdev)
>   	pc->dev = dev;
>   	pc->data = (struct meson_pinctrl_data *) of_device_get_match_data(dev);
>   
> -	ret = meson_pinctrl_parse_dt(pc, dev->of_node);
> +	ret = meson_pinctrl_parse_dt(pc);
>   	if (ret)
>   		return ret;
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

