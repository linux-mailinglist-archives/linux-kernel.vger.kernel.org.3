Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164B447A32A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 01:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbhLTA6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 19:58:08 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:43797 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbhLTA6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 19:58:06 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20211220005803epoutp0224fc8bb9c227c1035214d9e674f2cfad~CUKTjHAnn1865118651epoutp02a
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 00:58:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20211220005803epoutp0224fc8bb9c227c1035214d9e674f2cfad~CUKTjHAnn1865118651epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639961883;
        bh=PfEF0NEowvhw7cuL2KLvpyJZ9rHxoweha2ZlVBIqHS0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KgszIMuiObmNt76sC7AlBZb6G13PGqoeSTv9CMsvQYxKxV6OWvWsOPxDq0EO3o1Oc
         tQeXNvs5H15O7Pu2KMVb9zgNqNGjpaq2fACp1Co5DEoEKX/APtKDxQ3Z2rD468s/zU
         KaB6OSJvwytUtfM4J8X23kZZNvUoqjbQ7iQfuPNE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211220005802epcas1p4a4253499bc47b6fa0e087424b36f8531~CUKTD0UGC0055000550epcas1p4S;
        Mon, 20 Dec 2021 00:58:02 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.236]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JHLmP0ft0z4x9Pw; Mon, 20 Dec
        2021 00:57:57 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.D3.08277.215DFB16; Mon, 20 Dec 2021 09:57:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211220005753epcas1p185cd04f933356e594959cf7a12aa56dc~CUKKEIYMS1037610376epcas1p1X;
        Mon, 20 Dec 2021 00:57:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211220005753epsmtrp1a11ce64468792212539138bc3947a339~CUKKDHLjQ0168801688epsmtrp1a;
        Mon, 20 Dec 2021 00:57:53 +0000 (GMT)
X-AuditID: b6c32a36-203ff70000002055-d0-61bfd512faf3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.82.29871.115DFB16; Mon, 20 Dec 2021 09:57:53 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211220005752epsmtip1bb20a189882ec8c765e94a10e3243901~CUKJu3sD01217712177epsmtip1j;
        Mon, 20 Dec 2021 00:57:52 +0000 (GMT)
Subject: Re: [PATCH v3] extcon: fix extcon_get_extcon_dev() error handling
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e0adc445-ede3-171a-0c1b-8667792d4c3e@samsung.com>
Date:   Mon, 20 Dec 2021 10:20:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211217062846.GA26548@kili>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmnq7Q1f2JBqe2CFoca3vCbvH633QW
        i+bF69ks3hyfzmTRtXoni8XWW9IWl3fNYbOYvaSfxeJz7xFGi0XLWpktniw8w2Rxu3EFm8Xp
        3SUWPw+dZ3Lg89jwaDWrx6ZVnWwe804Geuyfu4bd4+PTWywe7/ddZfPY+b2B3aNvyypGj8+b
        5AI4o7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BO
        V1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBboFSfmFpfmpevlpZZYGRoYGJkC
        FSZkZ9x/c5yt4JRPxeW2DUwNjE/tuhg5OCQETCTmPLTuYuTiEBLYwSjxbepqdgjnE6PEywVz
        mboYOYGcb4wSyyawgdggDTMXfWCBKNrLKHHz7GdGCOc9o8Suvz9YQKqEBbwkft46ygaSEBE4
        xCjRs3Qp2FxmgYNMEtdmNjGCVLEJaEnsf3EDbC6/gKLE1R+PweK8AnYS74/9A5vEIqAqMWv3
        LnYQW1QgTOLkthaoGkGJkzOfgNVwAs05/us2WA2zgLjErSfzmSBseYntb+cwQ9z9hkPi4aJo
        CNtFYm7PAXYIW1ji1fEtULaUxMv+NrBDJQSWMUr8mtzJBOGsB4bGrE6oScYS+5dOZgIFH7OA
        psT6XfoQYUWJnb/nMkIs5pN497WHFRLCvBIdbUIQJcoSlx/cZYKwJSUWt3eyTWBUmoXknVlI
        XpiF5IVZCMsWMLKsYhRLLSjOTU8tNiwwgkd3cn7uJkZwutYy28E46e0HvUOMTByMwNDnYFYS
        4d0ye3+iEG9KYmVValF+fFFpTmrxIUZTYABPZJYSTc4HZoy8knhDE0sDEzMjYxMLQzNDJXHe
        F/7TE4UE0hNLUrNTUwtSi2D6mDg4pRqYYo3ayxIW3D6x8FHUygV7JaP2ZjUlfzbU41/zMHna
        xaez8/gr12yblx+3YY7B12nB/RIvtj/xckx4cPDdKz2t0+ujFvjqpCsZluRExkufiHQo/rLb
        w7ZtWcX0ny/S753+zGZ+QOupwiFJ2ZZdRk/WiH5e8+niqyJB2Q0Lue8V7+mYM8dag9/t8fci
        q8wvRSXbxEM7f4TG/zs88XxSc33n/bf71Z4bBEyeHleyne/6HmbBRYtjuL5r9s5Yd7E9fOKL
        Q9smvLtZ8v7c68eNLbNu2htW993c8OF17+aCb7+zlePWuIisXB+4wCgm+rvwRc4Sr/5AuXWL
        LR3VEi9VlfOUOwU+L/GYqLP36lTe6OzNxUosxRmJhlrMRcWJAOhHFeJgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSnK7g1f2JBt8OSVsca3vCbvH633QW
        i+bF69ks3hyfzmTRtXoni8XWW9IWl3fNYbOYvaSfxeJz7xFGi0XLWpktniw8w2Rxu3EFm8Xp
        3SUWPw+dZ3Lg89jwaDWrx6ZVnWwe804Geuyfu4bd4+PTWywe7/ddZfPY+b2B3aNvyypGj8+b
        5AI4o7hsUlJzMstSi/TtErgy7r85zlZwyqfictsGpgbGp3ZdjJwcEgImEjMXfWDpYuTiEBLY
        zSjRNaePGSIhKTHt4lEgmwPIFpY4fLgYouYto8SFj+vZQWqEBbwkft46ygaSEBE4xChx+MQi
        sEnMAoeZJB7//w02SUigVuJDyyQwm01AS2L/ixtsIDa/gKLE1R+PGUFsXgE7iffH/rGA2CwC
        qhKzdu8C2yAqECaxc8ljJogaQYmTM5+A1XACzTn+6zZYDbOAusSfeZeYIWxxiVtP5jNB2PIS
        29/OYZ7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZG
        cORqae5g3L7qg94hRiYORqDvOZiVRHi3zN6fKMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJ
        eCGB9MSS1OzU1ILUIpgsEwenVAPTHG/uxnNTpyx4Kpo0bc3MqROz9Uz2iyxdfv8wyxsltgr+
        lbuYTi/j4p9pcivezoXhkmvVJfNOr1PGc2ymrUzbq/huRWfRmukfRW4tudPLo8XY/v3+pBeF
        yirb5q/4ekP+kHnahO9rph7O5OZm/hGfInjgKJfuLcaJ/7Y07dk24W9haPzZpryZHH71b6Zl
        HH9068r3YKab1/j3CL84qbI4b4LA2Wxm5Z6mzdf0Jx11Zi75HpXkZvt31sYSGz/XdYtNY68+
        NtRIF2+aqMKv+rbt+mSzmRUPLHazS3UnHHjZHXTDTK7oxYMfX3K7tx7h53V7q+TkzL49nsvN
        b+70f09Kve3XCLy8tWjPrtNep37NzVBiKc5INNRiLipOBAAs5fDaSwMAAA==
X-CMS-MailID: 20211220005753epcas1p185cd04f933356e594959cf7a12aa56dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211217062932epcas1p1b262f3dd17607f5e42b85c169729ce63
References: <CGME20211217062932epcas1p1b262f3dd17607f5e42b85c169729ce63@epcas1p1.samsung.com>
        <20211217062846.GA26548@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian and Felipe,

If Sebastian and Felipe don't have any additional opinion,
could you please reply the review for this patch?

And if Sebastian and Felipe agree, I'll merge it to extcon tree.


Best Regards,
Chanwoo Choi


On 12/17/21 3:28 PM, Dan Carpenter wrote:
> The extcon_get_extcon_dev() function returns error pointers on error,
> NULL when it's a -EPROBE_DEFER defer situation, and ERR_PTR(-ENODEV)
> when the CONFIG_EXTCON option is disabled.  This is very complicated for
> the callers to handle and a number of them had bugs that would lead to
> an Oops.
> 
> In real life, there are two things which prevented crashes.  First,
> error pointers would only be returned if there was bug in the caller
> where they passed a NULL "extcon_name" and none of them do that.
> Second, only two out of the eight drivers will build when CONFIG_EXTCON
> is disabled.
> 
> The normal way to write this would be to return -EPROBE_DEFER directly
> when appropriate and return NULL when CONFIG_EXTCON is disabled.  Then
> the error handling is simple and just looks like:
> 
> 	dev->edev = extcon_get_extcon_dev(acpi_dev_name(adev));
> 	if (IS_ERR(dev->edev))
> 		return PTR_ERR(dev->edev);
> 
> For the two drivers which can build with CONFIG_EXTCON disabled, then
> extcon_get_extcon_dev() will now return NULL which is not treated as an
> error and the probe will continue successfully.  Those two drivers are
> "typec_fusb302" and "max8997-battery".  In the original code, the
> typec_fusb302 driver had an 800ms hang in tcpm_get_current_limit() but
> now that function is a no-op.  For the max8997-battery driver everything
> should continue working as is.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: return NULL when CONFIG_EXTCON is disabled
> v3: Add a note to extcon_get_extcon_dev() to say that it may only be
>     called from probe().
> 
>  drivers/extcon/extcon.c                |  4 +++-
>  include/linux/extcon.h                 |  2 +-
>  drivers/extcon/extcon-axp288.c         |  4 ++--
>  drivers/power/supply/axp288_charger.c  | 17 ++++++++++-------
>  drivers/power/supply/charger-manager.c |  7 ++-----
>  drivers/power/supply/max8997_charger.c | 10 +++++-----
>  drivers/usb/dwc3/drd.c                 |  9 ++-------
>  drivers/usb/phy/phy-omap-otg.c         |  4 ++--
>  drivers/usb/typec/tcpm/fusb302.c       |  4 ++--
>  9 files changed, 29 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index e7a9561a826d..9eb92997f3ae 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -863,6 +863,8 @@ EXPORT_SYMBOL_GPL(extcon_set_property_capability);
>   * @extcon_name:	the extcon name provided with extcon_dev_register()
>   *
>   * Return the pointer of extcon device if success or ERR_PTR(err) if fail.
> + * NOTE: This function returns -EPROBE_DEFER so it may only be called from
> + * probe() functions.
>   */
>  struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>  {
> @@ -876,7 +878,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>  		if (!strcmp(sd->name, extcon_name))
>  			goto out;
>  	}
> -	sd = NULL;
> +	sd = ERR_PTR(-EPROBE_DEFER);
>  out:
>  	mutex_unlock(&extcon_dev_list_lock);
>  	return sd;
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index 0c19010da77f..685401d94d39 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -296,7 +296,7 @@ static inline void devm_extcon_unregister_notifier_all(struct device *dev,
>  
>  static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>  {
> -	return ERR_PTR(-ENODEV);
> +	return NULL;
>  }
>  
>  static inline struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index 7c6d5857ff25..180be768c215 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -394,8 +394,8 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>  		if (adev) {
>  			info->id_extcon = extcon_get_extcon_dev(acpi_dev_name(adev));
>  			put_device(&adev->dev);
> -			if (!info->id_extcon)
> -				return -EPROBE_DEFER;
> +			if (IS_ERR(info->id_extcon))
> +				return PTR_ERR(info->id_extcon);
>  
>  			dev_info(dev, "controlling USB role\n");
>  		} else {
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index ec41f6cd3f93..4acfeb52a44e 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -848,17 +848,20 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	info->regmap_irqc = axp20x->regmap_irqc;
>  
>  	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
> -	if (info->cable.edev == NULL) {
> -		dev_dbg(dev, "%s is not ready, probe deferred\n",
> -			AXP288_EXTCON_DEV_NAME);
> -		return -EPROBE_DEFER;
> +	if (IS_ERR(info->cable.edev)) {
> +		dev_err_probe(dev, PTR_ERR(info->cable.edev),
> +			      "extcon_get_extcon_dev(%s) failed\n",
> +			      AXP288_EXTCON_DEV_NAME);
> +		return PTR_ERR(info->cable.edev);
>  	}
>  
>  	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
>  		info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
> -		if (info->otg.cable == NULL) {
> -			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
> -			return -EPROBE_DEFER;
> +		if (IS_ERR(info->otg.cable)) {
> +			dev_err_probe(dev, PTR_ERR(info->otg.cable),
> +				      "extcon_get_extcon_dev(%s) failed\n",
> +				      USB_HOST_EXTCON_NAME);
> +			return PTR_ERR(info->otg.cable);
>  		}
>  		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
>  	}
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
> index d67edb760c94..92db79400a6a 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -985,13 +985,10 @@ static int charger_extcon_init(struct charger_manager *cm,
>  	cable->nb.notifier_call = charger_extcon_notifier;
>  
>  	cable->extcon_dev = extcon_get_extcon_dev(cable->extcon_name);
> -	if (IS_ERR_OR_NULL(cable->extcon_dev)) {
> +	if (IS_ERR(cable->extcon_dev)) {
>  		pr_err("Cannot find extcon_dev for %s (cable: %s)\n",
>  			cable->extcon_name, cable->name);
> -		if (cable->extcon_dev == NULL)
> -			return -EPROBE_DEFER;
> -		else
> -			return PTR_ERR(cable->extcon_dev);
> +		return PTR_ERR(cable->extcon_dev);
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(extcon_mapping); i++) {
> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
> index 25207fe2aa68..634658adf313 100644
> --- a/drivers/power/supply/max8997_charger.c
> +++ b/drivers/power/supply/max8997_charger.c
> @@ -248,13 +248,13 @@ static int max8997_battery_probe(struct platform_device *pdev)
>  		dev_info(&pdev->dev, "couldn't get charger regulator\n");
>  	}
>  	charger->edev = extcon_get_extcon_dev("max8997-muic");
> -	if (IS_ERR_OR_NULL(charger->edev)) {
> -		if (!charger->edev)
> -			return -EPROBE_DEFER;
> -		dev_info(charger->dev, "couldn't get extcon device\n");
> +	if (IS_ERR(charger->edev)) {
> +		dev_err_probe(charger->dev, PTR_ERR(charger->edev),
> +			      "couldn't get extcon device: max8997-muic\n");
> +		return PTR_ERR(charger->edev);
>  	}
>  
> -	if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
> +	if (!IS_ERR(charger->reg)) {
>  		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
>  		ret = devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_work, charger);
>  		if (ret) {
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index d7f76835137f..a490f79131c1 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -454,13 +454,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>  	 * This device property is for kernel internal use only and
>  	 * is expected to be set by the glue code.
>  	 */
> -	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> -		edev = extcon_get_extcon_dev(name);
> -		if (!edev)
> -			return ERR_PTR(-EPROBE_DEFER);
> -
> -		return edev;
> -	}
> +	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
> +		return extcon_get_extcon_dev(name);
>  
>  	/*
>  	 * Try to get an extcon device from the USB PHY controller's "port"
> diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
> index ee0863c6553e..6e6ef8c0bc7e 100644
> --- a/drivers/usb/phy/phy-omap-otg.c
> +++ b/drivers/usb/phy/phy-omap-otg.c
> @@ -95,8 +95,8 @@ static int omap_otg_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  
>  	extcon = extcon_get_extcon_dev(config->extcon);
> -	if (!extcon)
> -		return -EPROBE_DEFER;
> +	if (IS_ERR(extcon))
> +		return PTR_ERR(extcon);
>  
>  	otg_dev = devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
>  	if (!otg_dev)
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 72f9001b0792..96c55eaf3f80 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1708,8 +1708,8 @@ static int fusb302_probe(struct i2c_client *client,
>  	 */
>  	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>  		chip->extcon = extcon_get_extcon_dev(name);
> -		if (!chip->extcon)
> -			return -EPROBE_DEFER;
> +		if (IS_ERR(chip->extcon))
> +			return PTR_ERR(chip->extcon);
>  	}
>  
>  	chip->vbus = devm_regulator_get(chip->dev, "vbus");
> 


