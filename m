Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8370C4A7ECC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 06:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiBCFBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 00:01:06 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:42403 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiBCFBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 00:01:04 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220203050101epoutp0408f0138b5f0ce7842d625a9314233b56~QLgS7rQJ90829108291epoutp04N
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 05:01:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220203050101epoutp0408f0138b5f0ce7842d625a9314233b56~QLgS7rQJ90829108291epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643864461;
        bh=8XvnV2Mkl0hOdDYKendZBIwA3+7vI8GAe2K3SpQZ4I4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NSKzkAjpQmVkfrBmkOzG4qw/IIUUqCo6CcVyC0d0iDeg9ymcn/Ge3Q2vJdev1rnTS
         A+EqFmU/XoXJqpiVakzA5X1zNKcbLbmjK/AGK5OpeUO8lNYIntcIMFOC58/tZCTYBb
         K3+jjjSkkQmAVdJY0KkMoSujhTVloLks0cVmXnqQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220203050100epcas1p16d6022c0c7d42f92ea47ffb34f2fbb3f~QLgSEnIFh0763407634epcas1p1z;
        Thu,  3 Feb 2022 05:01:00 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.136]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jq6206Qbcz4x9QF; Thu,  3 Feb
        2022 05:00:56 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.AB.64085.4816BF16; Thu,  3 Feb 2022 14:00:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220203050052epcas1p432db506877cceb9e743a2514ad481c8d~QLgKV3BNv1519315193epcas1p4N;
        Thu,  3 Feb 2022 05:00:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220203050052epsmtrp2890620513c19d25a262926e21f49e943~QLgKU2vaI1154811548epsmtrp2p;
        Thu,  3 Feb 2022 05:00:52 +0000 (GMT)
X-AuditID: b6c32a35-9adff7000000fa55-f7-61fb6184976a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.83.08738.4816BF16; Thu,  3 Feb 2022 14:00:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220203050052epsmtip1e528462c4a34560aef3f43247c47a8e6~QLgKDhBAQ0813808138epsmtip1j;
        Thu,  3 Feb 2022 05:00:52 +0000 (GMT)
Subject: Re: [PATCH v3] extcon: fix extcon_get_extcon_dev() error handling
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <978e3529-512a-3fc6-3a9f-5f34d5fd6ce7@samsung.com>
Date:   Thu, 3 Feb 2022 14:24:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <e0adc445-ede3-171a-0c1b-8667792d4c3e@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwTZxzH81yP45C3s8B4YMPBaQiSgRQBjw2YmzArOmUzw4wtwQtcoKNv
        6xU3zZYUK+VNYB0LSAsKsyIry5CmYwKjELAQIpmKwS0wF62FICgOOwLYbFnb043/Pt/n9/3l
        93yfF5zHv4GF4yKpklFIaTGJbUF7R3fGx52hnXTCrc43qDGN3Zta+qcJpdQXuzHq0XgTQlV3
        9aHUjzMvU7f7WzBKb6hHKUftNUB921HOo+ztkwg1W9aJUdcHlNTGyA1kb4Dwiq3LS2gyVmHC
        8xPvCYdav/cWrszNoMInlmlM2Lem8hbWmY1A6DBty/HJK0krZuhCRhHJSAtkhSJpUTp58Gj+
        vvzklARBnCCV2kNGSmkJk05mHsqJe0ckdm2djDxBi0tdSzk0y5K7MtIUslIlE1ksY5XpJCMv
        FMuT5fEsLWFLpUXxUkb5uiAhITHZZTxeUnzaNgrkC0c+V92rw1Rg8q1q4INDIgkaGupBNdiC
        84mrAHbY5rw48RRAx5KexwkHgLWqYa8XLXOjZShX6AdwsedrhBNPAKz8pQtzu4KIbLgxY/Uw
        RsTCoYXfPBxMbIffrGs8DTzCxoP6tg7EXQgkouD0+gPgZn8iA86PVXm7GSV2wIk76x4OIXLh
        RO+Z556tcKLZjrrZh3gTXnjW6GEeEQpn7BcQjl+FPz1u8WSAxCMcXrZrnmfIhLMNY4DjILg4
        bvbmOBw6lgcxrkENoGphFnDiLIDW+TqUc+2GQ5caXCNw14idsLt/F7ccBfucrYCbHACXV896
        uS2Q8IeVGj5n2Q5v37uLcBwGL1ZUYV8BUrcpj25TBt2mDLr/h7UB1AheYuSspIhhBXLBfxde
        IJOYgOdlxyZfBdrHf8aPAAQHIwDiPDLYf7B9jeb7F9InTzEKWb6iVMywIyDZdcJaXnhIgcz1
        NaTKfEFSakJSSuLuJEqQIiBD/Y2N12k+UUQrmRKGkTOKF30I7hOuQurnm1rRmLQTlMpw847E
        dyD7ymhz2/iAvOdvA2LNs1UM0YFO3yW1OsxZ+cfBD+6vWKwPTV+0y7TOjN7OybVEa/Dg/qlx
        P+ee+AC/8s/KVn+Yff+0VZf6XbR5bvrdS04TW2tQ0NHDwVMdMcYP67a1ikby/NDytD6Hhe0U
        L4nkG8eaumsicosnPjo2Rl77tCJr7nB0BXi2LIhC6SDS12YJPJr1IFS9cvm4enXR1hyhiJ4K
        Snzak/fatMSi1dcc3gu+zP0VP3m/6/eHR9QRW/9qv2Wb1/Dzoz7B7uJd54e1mQey7T+/vV9j
        PtBYIw77uNmcdarlpgKDPSHSc/qYQxmvkChbTAtieQqW/hdkNC+WYgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSnG5L4u9EgxXXpC2OtT1ht3j9bzqL
        RfPi9WwWb45PZ7LoWr2TxWLrLWmLy7vmsFnMXtLPYvG59wijxaJlrcwWTxaeYbK43biCzeL0
        7hKLn4fOMznweWx4tJrVY9OqTjaPeScDPfbPXcPu8fHpLRaP9/uusnns/N7A7tG3ZRWjx+dN
        cgGcUVw2Kak5mWWpRfp2CVwZTY8OMxa88K9oeNDH1sB4xrGLkZNDQsBE4unhRpYuRi4OIYEd
        jBJ3Nk9jhUhISky7eJS5i5EDyBaWOHy4GKLmLaPEjY0z2EFqhAW8JH7eOsoGYrMJaEnsf3ED
        zBYRUJaY8qONCaSBWeAJs8TFe8dYIbo3MUrM2PGPBaSKX0BR4uqPx4wgNq+AncSzY51gU1kE
        VCROXvsBZosKhEnsXPKYCaJGUOLkzCdgvZwC9hLzf00Ds5kF1CX+zLvEDGGLS9x6Mp8JwpaX
        2P52DvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcx
        giNXS2sH455VH/QOMTJxMB5ilOBgVhLh3bvwe6IQb0piZVVqUX58UWlOavEhRmkOFiVx3gtd
        J+OFBNITS1KzU1MLUotgskwcnFINTF4rmwt/VD94pvG4up/D/RdzX96+p61WP+SOd5l09zz/
        lfD19nH3JffXnnjH+dMoMPPDSab2k8pnKv95uR631wue+oD/dfaZjpOnf72qf7JCSPsdn0L5
        ++W+UZ8Pmm3c7LR2nR3LBNPXTH5LFbdtFrU33nMkomTJPy+JFdYr36/y5j1xf1oIp1qwEN/H
        exsWawRctOV87diRv/kw46qSObe41pzRUNt8e1bBHZ6583ZzFmWvf+h+fXXhwQX9Pn8FPryM
        efG+PT0/doqKQy/zztr5PcuVn1x6L85x51fL/O6Fszc/dfo6xypOe84+t1nnrjps9dJ07bOR
        CVkUemODQZXm9BaVCdw/fDWibNUdJZWVWIozEg21mIuKEwFYIjutSwMAAA==
X-CMS-MailID: 20220203050052epcas1p432db506877cceb9e743a2514ad481c8d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211217062932epcas1p1b262f3dd17607f5e42b85c169729ce63
References: <CGME20211217062932epcas1p1b262f3dd17607f5e42b85c169729ce63@epcas1p1.samsung.com>
        <20211217062846.GA26548@kili>
        <e0adc445-ede3-171a-0c1b-8667792d4c3e@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

Gently Ping.

Best Regards,
Chanwoo Choi

On 12/20/21 10:20 AM, Chanwoo Choi wrote:
> Hi Sebastian and Felipe,
> 
> If Sebastian and Felipe don't have any additional opinion,
> could you please reply the review for this patch?
> 
> And if Sebastian and Felipe agree, I'll merge it to extcon tree.
> 
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> On 12/17/21 3:28 PM, Dan Carpenter wrote:
>> The extcon_get_extcon_dev() function returns error pointers on error,
>> NULL when it's a -EPROBE_DEFER defer situation, and ERR_PTR(-ENODEV)
>> when the CONFIG_EXTCON option is disabled.  This is very complicated for
>> the callers to handle and a number of them had bugs that would lead to
>> an Oops.
>>
>> In real life, there are two things which prevented crashes.  First,
>> error pointers would only be returned if there was bug in the caller
>> where they passed a NULL "extcon_name" and none of them do that.
>> Second, only two out of the eight drivers will build when CONFIG_EXTCON
>> is disabled.
>>
>> The normal way to write this would be to return -EPROBE_DEFER directly
>> when appropriate and return NULL when CONFIG_EXTCON is disabled.  Then
>> the error handling is simple and just looks like:
>>
>> 	dev->edev = extcon_get_extcon_dev(acpi_dev_name(adev));
>> 	if (IS_ERR(dev->edev))
>> 		return PTR_ERR(dev->edev);
>>
>> For the two drivers which can build with CONFIG_EXTCON disabled, then
>> extcon_get_extcon_dev() will now return NULL which is not treated as an
>> error and the probe will continue successfully.  Those two drivers are
>> "typec_fusb302" and "max8997-battery".  In the original code, the
>> typec_fusb302 driver had an 800ms hang in tcpm_get_current_limit() but
>> now that function is a no-op.  For the max8997-battery driver everything
>> should continue working as is.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> v2: return NULL when CONFIG_EXTCON is disabled
>> v3: Add a note to extcon_get_extcon_dev() to say that it may only be
>>     called from probe().
>>
>>  drivers/extcon/extcon.c                |  4 +++-
>>  include/linux/extcon.h                 |  2 +-
>>  drivers/extcon/extcon-axp288.c         |  4 ++--
>>  drivers/power/supply/axp288_charger.c  | 17 ++++++++++-------
>>  drivers/power/supply/charger-manager.c |  7 ++-----
>>  drivers/power/supply/max8997_charger.c | 10 +++++-----
>>  drivers/usb/dwc3/drd.c                 |  9 ++-------
>>  drivers/usb/phy/phy-omap-otg.c         |  4 ++--
>>  drivers/usb/typec/tcpm/fusb302.c       |  4 ++--
>>  9 files changed, 29 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
>> index e7a9561a826d..9eb92997f3ae 100644
>> --- a/drivers/extcon/extcon.c
>> +++ b/drivers/extcon/extcon.c
>> @@ -863,6 +863,8 @@ EXPORT_SYMBOL_GPL(extcon_set_property_capability);
>>   * @extcon_name:	the extcon name provided with extcon_dev_register()
>>   *
>>   * Return the pointer of extcon device if success or ERR_PTR(err) if fail.
>> + * NOTE: This function returns -EPROBE_DEFER so it may only be called from
>> + * probe() functions.
>>   */
>>  struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>>  {
>> @@ -876,7 +878,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>>  		if (!strcmp(sd->name, extcon_name))
>>  			goto out;
>>  	}
>> -	sd = NULL;
>> +	sd = ERR_PTR(-EPROBE_DEFER);
>>  out:
>>  	mutex_unlock(&extcon_dev_list_lock);
>>  	return sd;
>> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
>> index 0c19010da77f..685401d94d39 100644
>> --- a/include/linux/extcon.h
>> +++ b/include/linux/extcon.h
>> @@ -296,7 +296,7 @@ static inline void devm_extcon_unregister_notifier_all(struct device *dev,
>>  
>>  static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>>  {
>> -	return ERR_PTR(-ENODEV);
>> +	return NULL;
>>  }
>>  
>>  static inline struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
>> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
>> index 7c6d5857ff25..180be768c215 100644
>> --- a/drivers/extcon/extcon-axp288.c
>> +++ b/drivers/extcon/extcon-axp288.c
>> @@ -394,8 +394,8 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>>  		if (adev) {
>>  			info->id_extcon = extcon_get_extcon_dev(acpi_dev_name(adev));
>>  			put_device(&adev->dev);
>> -			if (!info->id_extcon)
>> -				return -EPROBE_DEFER;
>> +			if (IS_ERR(info->id_extcon))
>> +				return PTR_ERR(info->id_extcon);
>>  
>>  			dev_info(dev, "controlling USB role\n");
>>  		} else {
>> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
>> index ec41f6cd3f93..4acfeb52a44e 100644
>> --- a/drivers/power/supply/axp288_charger.c
>> +++ b/drivers/power/supply/axp288_charger.c
>> @@ -848,17 +848,20 @@ static int axp288_charger_probe(struct platform_device *pdev)
>>  	info->regmap_irqc = axp20x->regmap_irqc;
>>  
>>  	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
>> -	if (info->cable.edev == NULL) {
>> -		dev_dbg(dev, "%s is not ready, probe deferred\n",
>> -			AXP288_EXTCON_DEV_NAME);
>> -		return -EPROBE_DEFER;
>> +	if (IS_ERR(info->cable.edev)) {
>> +		dev_err_probe(dev, PTR_ERR(info->cable.edev),
>> +			      "extcon_get_extcon_dev(%s) failed\n",
>> +			      AXP288_EXTCON_DEV_NAME);
>> +		return PTR_ERR(info->cable.edev);
>>  	}
>>  
>>  	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
>>  		info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
>> -		if (info->otg.cable == NULL) {
>> -			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
>> -			return -EPROBE_DEFER;
>> +		if (IS_ERR(info->otg.cable)) {
>> +			dev_err_probe(dev, PTR_ERR(info->otg.cable),
>> +				      "extcon_get_extcon_dev(%s) failed\n",
>> +				      USB_HOST_EXTCON_NAME);
>> +			return PTR_ERR(info->otg.cable);
>>  		}
>>  		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
>>  	}
>> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
>> index d67edb760c94..92db79400a6a 100644
>> --- a/drivers/power/supply/charger-manager.c
>> +++ b/drivers/power/supply/charger-manager.c
>> @@ -985,13 +985,10 @@ static int charger_extcon_init(struct charger_manager *cm,
>>  	cable->nb.notifier_call = charger_extcon_notifier;
>>  
>>  	cable->extcon_dev = extcon_get_extcon_dev(cable->extcon_name);
>> -	if (IS_ERR_OR_NULL(cable->extcon_dev)) {
>> +	if (IS_ERR(cable->extcon_dev)) {
>>  		pr_err("Cannot find extcon_dev for %s (cable: %s)\n",
>>  			cable->extcon_name, cable->name);
>> -		if (cable->extcon_dev == NULL)
>> -			return -EPROBE_DEFER;
>> -		else
>> -			return PTR_ERR(cable->extcon_dev);
>> +		return PTR_ERR(cable->extcon_dev);
>>  	}
>>  
>>  	for (i = 0; i < ARRAY_SIZE(extcon_mapping); i++) {
>> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
>> index 25207fe2aa68..634658adf313 100644
>> --- a/drivers/power/supply/max8997_charger.c
>> +++ b/drivers/power/supply/max8997_charger.c
>> @@ -248,13 +248,13 @@ static int max8997_battery_probe(struct platform_device *pdev)
>>  		dev_info(&pdev->dev, "couldn't get charger regulator\n");
>>  	}
>>  	charger->edev = extcon_get_extcon_dev("max8997-muic");
>> -	if (IS_ERR_OR_NULL(charger->edev)) {
>> -		if (!charger->edev)
>> -			return -EPROBE_DEFER;
>> -		dev_info(charger->dev, "couldn't get extcon device\n");
>> +	if (IS_ERR(charger->edev)) {
>> +		dev_err_probe(charger->dev, PTR_ERR(charger->edev),
>> +			      "couldn't get extcon device: max8997-muic\n");
>> +		return PTR_ERR(charger->edev);
>>  	}
>>  
>> -	if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
>> +	if (!IS_ERR(charger->reg)) {
>>  		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
>>  		ret = devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_work, charger);
>>  		if (ret) {
>> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
>> index d7f76835137f..a490f79131c1 100644
>> --- a/drivers/usb/dwc3/drd.c
>> +++ b/drivers/usb/dwc3/drd.c
>> @@ -454,13 +454,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>>  	 * This device property is for kernel internal use only and
>>  	 * is expected to be set by the glue code.
>>  	 */
>> -	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>> -		edev = extcon_get_extcon_dev(name);
>> -		if (!edev)
>> -			return ERR_PTR(-EPROBE_DEFER);
>> -
>> -		return edev;
>> -	}
>> +	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
>> +		return extcon_get_extcon_dev(name);
>>  
>>  	/*
>>  	 * Try to get an extcon device from the USB PHY controller's "port"
>> diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
>> index ee0863c6553e..6e6ef8c0bc7e 100644
>> --- a/drivers/usb/phy/phy-omap-otg.c
>> +++ b/drivers/usb/phy/phy-omap-otg.c
>> @@ -95,8 +95,8 @@ static int omap_otg_probe(struct platform_device *pdev)
>>  		return -ENODEV;
>>  
>>  	extcon = extcon_get_extcon_dev(config->extcon);
>> -	if (!extcon)
>> -		return -EPROBE_DEFER;
>> +	if (IS_ERR(extcon))
>> +		return PTR_ERR(extcon);
>>  
>>  	otg_dev = devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
>>  	if (!otg_dev)
>> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
>> index 72f9001b0792..96c55eaf3f80 100644
>> --- a/drivers/usb/typec/tcpm/fusb302.c
>> +++ b/drivers/usb/typec/tcpm/fusb302.c
>> @@ -1708,8 +1708,8 @@ static int fusb302_probe(struct i2c_client *client,
>>  	 */
>>  	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>>  		chip->extcon = extcon_get_extcon_dev(name);
>> -		if (!chip->extcon)
>> -			return -EPROBE_DEFER;
>> +		if (IS_ERR(chip->extcon))
>> +			return PTR_ERR(chip->extcon);
>>  	}
>>  
>>  	chip->vbus = devm_regulator_get(chip->dev, "vbus");
>>
> 
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
