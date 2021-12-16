Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4030476A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhLPGRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:17:04 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:46669 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhLPGRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:17:03 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211216061701epoutp04efccb5a02692ef33005381f877e3ddb6~BJ7qa3A0c1456314563epoutp04G
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 06:17:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211216061701epoutp04efccb5a02692ef33005381f877e3ddb6~BJ7qa3A0c1456314563epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639635421;
        bh=vozwc/DCHfEkzOgKi/yoWyZjpKFFde3C0LlhIOuPKo4=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=pDzNLonZ2hWNy0OkXpvzL+bzIKnuJ5UpqwIpQuwOkMUJczdyJkKWfXynzoBzy2A2R
         a2YD/aeTidFP6oyIWSOHA6hnli0B/2w72VduvF1H/sw3k6lm3f4qyCyw+Amod2C7A8
         cCPPiR8ux4sMNmfZ1FGaz1t7I95N7HGWgk7X8HPE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211216061701epcas1p298768056c73fd031f78b0168791c15d4~BJ7p6-vJb1573815738epcas1p2-;
        Thu, 16 Dec 2021 06:17:01 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.235]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JF22G3y7Rz4x9QJ; Thu, 16 Dec
        2021 06:16:54 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.F6.64085.5D9DAB16; Thu, 16 Dec 2021 15:16:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211216061645epcas1p31af8f90a37617fcda7ea6dd0ced0a37e~BJ7bqhIJb2515325153epcas1p3a;
        Thu, 16 Dec 2021 06:16:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211216061645epsmtrp22bc23d79c6074a7a1666ea7854d8d12f~BJ7bpqVSz0074200742epsmtrp2S;
        Thu, 16 Dec 2021 06:16:45 +0000 (GMT)
X-AuditID: b6c32a35-9adff7000000fa55-6d-61bad9d55a3a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.FB.08738.DC9DAB16; Thu, 16 Dec 2021 15:16:45 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211216061645epsmtip2a861342427123840bb771f000920afbe~BJ7bae5Gp1591415914epsmtip2L;
        Thu, 16 Dec 2021 06:16:45 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2] extcon: fix extcon_get_extcon_dev() error handling
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <562b12ff-e395-c818-787e-7fd6ee6d53fb@samsung.com>
Date:   Thu, 16 Dec 2021 15:39:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211123083925.GA3277@kili>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmru7Vm7sSDaZckrY41vaE3eL1v+ks
        Fs2L17NZvDk+ncmia/VOFoutt6QtLu+aw2Yxe0k/i8Xn3iOMFouWtTJbPFl4hsniduMKNovT
        u0ssfh46z+TA57Hh0WpWj02rOtk85p0M9Ng/dw27x8ent1g83u+7yuax83sDu0ffllWMHp83
        yQVwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzlh2cT9TwTyfihsz17A3MO6062Lk5JAQMJG49+kLWxcjF4eQwA5GidPTW6GcT4wS2xu2
        s4JUCQl8ZpRomZAM0zF99QVWiKJdQPGdn5khnPeMEhd+32IBqWIT0JLY/+IGG4gtLOAl0TX7
        EJgtIlAt0T51LVg3s0AHs8T/fevAVvALKEpc/fGYEcTmFbCTuDbnHTOIzSKgKnHx7BuwoaIC
        YRInt7VA1QhKnJz5BCzOKaAp8b95MVicWUBc4taT+UwQtrzE9rdzwK6TEHjDIbH1YB8bxA8u
        Ev2TO5ghbGGJV8e3sEPYUhKf3+1lg2hYxijxa3InE4SznlHi5axOqA5jif1LJwMlOIBWaEqs
        36UPEVaU2Pl7LtQVfBLvvvawgpRICPBKdLQJQZQoS1x+cJcJwpaUWNzeyTaBUWkWkn9mIflh
        FpIfZiEsW8DIsopRLLWgODc9tdiwwBAe38n5uZsYwQlby3QH48S3H/QOMTJxMB5ilOBgVhLh
        fRKxK1GINyWxsiq1KD++qDQntfgQoykwhCcyS4km5wNzRl5JvKGJpYGJmZGxiYWhmaGSOO8L
        /+mJQgLpiSWp2ampBalFMH1MHJxSDUz9QTmJCz5HxbLN+OOS9PmZpZLKjBytjRcY3wlk/r85
        73XNUjnphn99uSVTM/9rG+9+96dKhjf14cXTvbxPpoWG5xzwivl+lPXx1N7obd9mOrGfyXXt
        uzfzVihX0rebcz8uNBZRXs0ne+GlsO0NueWBxspn7nplVp1T6DmrkrrI6k9TWEMRw5pcr1sH
        /Zj+dixyPBq4vPxByPuzs7MqV0y+3P77dnTbu/9hvrWH6vews3Ls/Zf+Rfdu99PQxS+uHJbm
        OuqQIS+R8OCffFSo4v/Xj3MmLJ2yUWiD5WMZll6VK4zz3vP66q8RmHVT5d+5uTYbqvhOPJGW
        8F/i8OlB+0/zMlF+8bMpzYZPrac6RnYosRRnJBpqMRcVJwIAVQmD7WEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCSvO7Zm7sSDXafN7Q41vaE3eL1v+ks
        Fs2L17NZvDk+ncmia/VOFoutt6QtLu+aw2Yxe0k/i8Xn3iOMFouWtTJbPFl4hsniduMKNovT
        u0ssfh46z+TA57Hh0WpWj02rOtk85p0M9Ng/dw27x8ent1g83u+7yuax83sDu0ffllWMHp83
        yQVwRnHZpKTmZJalFunbJXBlLLu4n6lgnk/FjZlr2BsYd9p1MXJySAiYSExffYG1i5GLQ0hg
        B6PEtBl32SESkhLTLh5l7mLkALKFJQ4fLoaoecsoMevvKhaQGjYBLYn9L26wgdjCAl4SXbMP
        gdkiAtUSy1bNZAJpYBboYpbY9OI+2FAhgRqJmScWMYHY/AKKEld/PGYEsXkF7CSuzXnHDGKz
        CKhKXDz7BmyBqECYxM4lj5kgagQlTs58AhbnFNCU+N+8GKyXWUBd4s+8S8wQtrjErSfzmSBs
        eYntb+cwT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93
        EyM4brW0djDuWfVB7xAjEwfjIUYJDmYlEd4nEbsShXhTEiurUovy44tKc1KLDzFKc7AoifNe
        6DoZLySQnliSmp2aWpBaBJNl4uCUamBKl1s44ZGopcqi04m1Bx9V8V39dUFjzaTep9OFM7fL
        mGncTV+cGHxhoccq7YbdxsIcjyYdnNx86pBKjvOfbzHue+Yr1h5JfVNd4/tG9FZj6IRfBrce
        u01ed+KDxE0BLeGDE1WWbZ34Nm1Jb4+UeGj3k+nMr6oPrAlfveoMu6NKJleqbVrJjMe7Ff+1
        T7NMXh56NMb1/4e429ttjDf9tWsWsmaddcK1e21Gjbzos70n/S8fvXdf/Zpk5rvfsqWbl9rN
        jdbdn13ZwjhHNXj1npL2jwzP6/hn8M3QuZi5/nUFW6XducQH56ZNebTE19bdfomGc/y/ZZqF
        B7wcDq1T4ZxttfEth6pp3Mx3XJ8Kqz88VWIpzkg01GIuKk4EAEsuT1lKAwAA
X-CMS-MailID: 20211216061645epcas1p31af8f90a37617fcda7ea6dd0ced0a37e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211123084357epcas1p14833147710153f9606f14941ac8b0d96
References: <CGME20211123084357epcas1p14833147710153f9606f14941ac8b0d96@epcas1p1.samsung.com>
        <20211123083925.GA3277@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

First of all,  sorry for late reply.

There is one issue. About this issue, I already discussed on patch[1]
[1] https://lore.kernel.org/lkml/5BEB63C3.1020504@samsung.com/

extcon_get_extcon_dev() is used for anywhere except for probe step.
But EPROBE_DEFER is only used on probe step.

So that it is not clear to return EPROBE_DEFER from extcon_get_extcon_dev()
because extcon_get_extcon_dev() never know either call it on probe function
or not.


On 11/23/21 5:43 PM, Dan Carpenter wrote:
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
> 
> If we apply this patch, it might be a good idea to send it to -stable
> so that backported code that relies on handling error pointers does
> not break silently.
> 
>  drivers/extcon/extcon-axp288.c         |    4 ++--
>  drivers/extcon/extcon.c                |    2 +-
>  drivers/power/supply/axp288_charger.c  |   17 ++++++++++-------
>  drivers/power/supply/charger-manager.c |    7 ++-----
>  drivers/power/supply/max8997_charger.c |   10 +++++-----
>  drivers/usb/dwc3/drd.c                 |    9 ++-------
>  drivers/usb/phy/phy-omap-otg.c         |    4 ++--
>  drivers/usb/typec/tcpm/fusb302.c       |    4 ++--
>  include/linux/extcon.h                 |    2 +-
>  9 files changed, 27 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index e7a9561a826d..a35e99928807 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -876,7 +876,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
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
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
