Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72304B7C20
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbiBPA4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:56:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245197AbiBPAzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:55:47 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA4E6DA0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:55:36 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220216004843epoutp0480eef266e786e44f36bc1785d4cbaddf~UHctmq8aA0205202052epoutp04E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:48:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220216004843epoutp0480eef266e786e44f36bc1785d4cbaddf~UHctmq8aA0205202052epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644972523;
        bh=jdI+DVtJlAMnpAC+cOGymboOuWz7L5fNo/cvCj+vcus=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jRdmvMcPQc73Dk/UBdVq0fXfdSy3a9F3fBsOiPcMK3/jvsRqHL/DoWFywk74jvdJh
         +Fs7o+5Kvk+ILCwzp23HV6hh9XFgphgyGrKlKbAGOpQolMquHHolasbd0nGVD6tudU
         nCMb4mzc+cfpH3w1wgNhwmfRH4enY2ESuFWUlZI0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220216004842epcas1p4107fcbeaf6b04ae2cda7e47414517c2d~UHctKpSlS1250912509epcas1p4s;
        Wed, 16 Feb 2022 00:48:42 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.232]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Jyzps2tRHz4x9QQ; Wed, 16 Feb
        2022 00:48:37 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.5D.28648.DD94C026; Wed, 16 Feb 2022 09:48:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220216004828epcas1p271b774572ec32898d386b1de44f3df00~UHcgJaudi0032000320epcas1p28;
        Wed, 16 Feb 2022 00:48:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220216004828epsmtrp2556c52bbc4015942d2440d241790c3f3~UHcgITe0v0943109431epsmtrp2b;
        Wed, 16 Feb 2022 00:48:28 +0000 (GMT)
X-AuditID: b6c32a39-003ff70000006fe8-a3-620c49ddc10f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.11.29871.CD94C026; Wed, 16 Feb 2022 09:48:28 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220216004827epsmtip10cfa9ab01e285a4c32bcddd06f973ec8~UHce1Smaz1985719857epsmtip15;
        Wed, 16 Feb 2022 00:48:27 +0000 (GMT)
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
Message-ID: <55b71c05-ec2f-d01b-8472-989ce8240646@samsung.com>
Date:   Wed, 16 Feb 2022 10:12:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <978e3529-512a-3fc6-3a9f-5f34d5fd6ce7@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmnu5dT54kg2vr+S2OtT1ht3j9bzqL
        RfPi9WwWb45PZ7LoWr2TxWLrLWmLy7vmsFnMXtLPYvG59wijxaJlrcwWTxaeYbK43biCzeL0
        7hKLn4fOMznweWx4tJrVY9OqTjaPeScDPfbPXcPu8fHpLRaP9/uusnns/N7A7tG3ZRWjx+dN
        cgGcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCn
        KymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyB
        ChOyM9Z/nc9WMC2o4uDTq4wNjC+duxg5OSQETCSWrlvC3sXIxSEksINRYs2q9UwQzidGiZ/z
        2xkhnG+MEjt3zmKEadm89j1UYi+jROu/52wQzntGiR1rWlhBqoQFvCR+3jrKBmKzCWhJ7H9x
        A8wWEVCWmPKjDWwHs8AjZonZC5YxgST4BRQlrv54DLaCV8BOYtvmq+wgNouAqsTba01gQ0UF
        wiRObmuBqhGUODnzCUsXIwcHp4C9xJlL7iBhZgFxiVtP5jNB2PIS29/OYQbZJSHwhkPi+cP1
        TBAvuEg8232THcIWlnh1fAuULSXx+d1eNoiGZkaJhhe3GSGcHkaJo8/6WCCqjCX2L53MBLKZ
        WUBTYv0ufYiwosTO33MZITbzSbz72sMKUiIhwCvR0SYEUaIscfnBXagbJCUWt3eyTWBUmoXk
        nVlIfpiF5IdZCMsWMLKsYhRLLSjOTU8tNiwwhcd3cn7uJkZwwtay3ME4/e0HvUOMTByMhxgl
        OJiVRHjjznImCfGmJFZWpRblxxeV5qQWH2I0BQbwRGYp0eR8YM7IK4k3NLE0MDEzMjaxMDQz
        VBLnXTXtdKKQQHpiSWp2ampBahFMHxMHp1QDE0uZE/fRWVE+S5JvqE8p6BY4mFDkc/fCKjO9
        tg8nxbwjt+RfvVVcaq/59865Za6PRCPvcDq7zQhvbNV99Jdz4fXvN5+WsNYfe80fku+euGRx
        YsTBWyEV90Oubs985bxJ0Ednfpz+Rs1KwcvS/Rx3U2cov9wcdtNa4XqJ++HtQavW9OTv3nlB
        9cnPAh9DgQ8bb/4uzpvuZ+gh98mcr+DW8qV1M4LSbkr8spR48u7AkpiSrmTm07kyHnmlLa1Z
        haeZNt1vO+l+n41xDovR5O5pJvKKC6L+rtT54FvQVZp0aVsuY5m83tGD9dtXxYesMul/tfHg
        pVXRj5ZOWrtaWdna3+135h5Xm70Bmvo1nWYzlViKMxINtZiLihMBqp2dbmEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCSnO4dT54kg+/fNS2OtT1ht3j9bzqL
        RfPi9WwWb45PZ7LoWr2TxWLrLWmLy7vmsFnMXtLPYvG59wijxaJlrcwWTxaeYbK43biCzeL0
        7hKLn4fOMznweWx4tJrVY9OqTjaPeScDPfbPXcPu8fHpLRaP9/uusnns/N7A7tG3ZRWjx+dN
        cgGcUVw2Kak5mWWpRfp2CVwZ67/OZyuYFlRx8OlVxgbGl85djJwcEgImEpvXvmfsYuTiEBLY
        zSjR9P4fI0RCUmLaxaPMXYwcQLawxOHDxRA1bxkl3i3cwQJSIyzgJfHz1lE2EJtNQEti/4sb
        YLaIgLLElB9tTCANzAJPmCUu3jvGCtH9nFHi+IlesG5+AUWJqz8eg23jFbCT2Lb5KjuIzSKg
        KvH2WhMriC0qECaxc8ljJogaQYmTM5+wgFzEKWAvceaSO0iYWUBd4s+8S8wQtrjErSfzmSBs
        eYntb+cwT2AUnoWkexaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93
        EyM4brU0dzBuX/VB7xAjEwfjIUYJDmYlEd64s5xJQrwpiZVVqUX58UWlOanFhxilOViUxHkv
        dJ2MFxJITyxJzU5NLUgtgskycXBKNTBlFMXpphe9ue39etKaXxqT9VOm3w6eo2j5vW2q4Pve
        NX/fTw48L5o7+e9MqeO69XqVlzrfXglnrl5+V/GN5S7DkKn9z/dG3J1eyn6Nu7mPvWb6HxfW
        Qr8bXnN7/rO8fPR88bp92/znMn9mfxg9dcWXuZWaXo+PhXn9XzJX/4bwxeZpLAtVm9zrrjud
        afaLfTTP0JhPWfTnNLEMw9CJU2wcE5bYVLAGNZ76cth6ZtbU/BvKG1gtDrOZ55zg3T/F40NR
        Enuxwp4+vU1JU3mNGWQlXk+fYdmuv+hc9NdPnKI8E1gu+75vUf35d19rsezJUxa6yx/Om7DH
        064paQvnzINXTzD/dFx56mXvD8eIwCNsSizFGYmGWsxFxYkASWc3oUoDAAA=
X-CMS-MailID: 20220216004828epcas1p271b774572ec32898d386b1de44f3df00
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
        <978e3529-512a-3fc6-3a9f-5f34d5fd6ce7@samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

Applied it. Thanks.

Best Regards,
Chanwoo Choi


On 2/3/22 2:24 PM, Chanwoo Choi wrote:
> Hi Felipe,
> 
> Gently Ping.
> 
> Best Regards,
> Chanwoo Choi
> 
> On 12/20/21 10:20 AM, Chanwoo Choi wrote:
>> Hi Sebastian and Felipe,
>>
>> If Sebastian and Felipe don't have any additional opinion,
>> could you please reply the review for this patch?
>>
>> And if Sebastian and Felipe agree, I'll merge it to extcon tree.
>>
>>
>> Best Regards,
>> Chanwoo Choi
>>
>>
>> On 12/17/21 3:28 PM, Dan Carpenter wrote:
>>> The extcon_get_extcon_dev() function returns error pointers on error,
>>> NULL when it's a -EPROBE_DEFER defer situation, and ERR_PTR(-ENODEV)
>>> when the CONFIG_EXTCON option is disabled.  This is very complicated for
>>> the callers to handle and a number of them had bugs that would lead to
>>> an Oops.
>>>
>>> In real life, there are two things which prevented crashes.  First,
>>> error pointers would only be returned if there was bug in the caller
>>> where they passed a NULL "extcon_name" and none of them do that.
>>> Second, only two out of the eight drivers will build when CONFIG_EXTCON
>>> is disabled.
>>>
>>> The normal way to write this would be to return -EPROBE_DEFER directly
>>> when appropriate and return NULL when CONFIG_EXTCON is disabled.  Then
>>> the error handling is simple and just looks like:
>>>
>>> 	dev->edev = extcon_get_extcon_dev(acpi_dev_name(adev));
>>> 	if (IS_ERR(dev->edev))
>>> 		return PTR_ERR(dev->edev);
>>>
>>> For the two drivers which can build with CONFIG_EXTCON disabled, then
>>> extcon_get_extcon_dev() will now return NULL which is not treated as an
>>> error and the probe will continue successfully.  Those two drivers are
>>> "typec_fusb302" and "max8997-battery".  In the original code, the
>>> typec_fusb302 driver had an 800ms hang in tcpm_get_current_limit() but
>>> now that function is a no-op.  For the max8997-battery driver everything
>>> should continue working as is.
>>>
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>> v2: return NULL when CONFIG_EXTCON is disabled
>>> v3: Add a note to extcon_get_extcon_dev() to say that it may only be
>>>     called from probe().
>>>
>>>  drivers/extcon/extcon.c                |  4 +++-
>>>  include/linux/extcon.h                 |  2 +-
>>>  drivers/extcon/extcon-axp288.c         |  4 ++--
>>>  drivers/power/supply/axp288_charger.c  | 17 ++++++++++-------
>>>  drivers/power/supply/charger-manager.c |  7 ++-----
>>>  drivers/power/supply/max8997_charger.c | 10 +++++-----
>>>  drivers/usb/dwc3/drd.c                 |  9 ++-------
>>>  drivers/usb/phy/phy-omap-otg.c         |  4 ++--
>>>  drivers/usb/typec/tcpm/fusb302.c       |  4 ++--
>>>  9 files changed, 29 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
>>> index e7a9561a826d..9eb92997f3ae 100644
>>> --- a/drivers/extcon/extcon.c
>>> +++ b/drivers/extcon/extcon.c
>>> @@ -863,6 +863,8 @@ EXPORT_SYMBOL_GPL(extcon_set_property_capability);
>>>   * @extcon_name:	the extcon name provided with extcon_dev_register()
>>>   *
>>>   * Return the pointer of extcon device if success or ERR_PTR(err) if fail.
>>> + * NOTE: This function returns -EPROBE_DEFER so it may only be called from
>>> + * probe() functions.
>>>   */
>>>  struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>>>  {
>>> @@ -876,7 +878,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>>>  		if (!strcmp(sd->name, extcon_name))
>>>  			goto out;
>>>  	}
>>> -	sd = NULL;
>>> +	sd = ERR_PTR(-EPROBE_DEFER);
>>>  out:
>>>  	mutex_unlock(&extcon_dev_list_lock);
>>>  	return sd;
>>> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
>>> index 0c19010da77f..685401d94d39 100644
>>> --- a/include/linux/extcon.h
>>> +++ b/include/linux/extcon.h
>>> @@ -296,7 +296,7 @@ static inline void devm_extcon_unregister_notifier_all(struct device *dev,
>>>  
>>>  static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>>>  {
>>> -	return ERR_PTR(-ENODEV);
>>> +	return NULL;
>>>  }
>>>  
>>>  static inline struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
>>> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
>>> index 7c6d5857ff25..180be768c215 100644
>>> --- a/drivers/extcon/extcon-axp288.c
>>> +++ b/drivers/extcon/extcon-axp288.c
>>> @@ -394,8 +394,8 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>>>  		if (adev) {
>>>  			info->id_extcon = extcon_get_extcon_dev(acpi_dev_name(adev));
>>>  			put_device(&adev->dev);
>>> -			if (!info->id_extcon)
>>> -				return -EPROBE_DEFER;
>>> +			if (IS_ERR(info->id_extcon))
>>> +				return PTR_ERR(info->id_extcon);
>>>  
>>>  			dev_info(dev, "controlling USB role\n");
>>>  		} else {
>>> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
>>> index ec41f6cd3f93..4acfeb52a44e 100644
>>> --- a/drivers/power/supply/axp288_charger.c
>>> +++ b/drivers/power/supply/axp288_charger.c
>>> @@ -848,17 +848,20 @@ static int axp288_charger_probe(struct platform_device *pdev)
>>>  	info->regmap_irqc = axp20x->regmap_irqc;
>>>  
>>>  	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
>>> -	if (info->cable.edev == NULL) {
>>> -		dev_dbg(dev, "%s is not ready, probe deferred\n",
>>> -			AXP288_EXTCON_DEV_NAME);
>>> -		return -EPROBE_DEFER;
>>> +	if (IS_ERR(info->cable.edev)) {
>>> +		dev_err_probe(dev, PTR_ERR(info->cable.edev),
>>> +			      "extcon_get_extcon_dev(%s) failed\n",
>>> +			      AXP288_EXTCON_DEV_NAME);
>>> +		return PTR_ERR(info->cable.edev);
>>>  	}
>>>  
>>>  	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
>>>  		info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
>>> -		if (info->otg.cable == NULL) {
>>> -			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
>>> -			return -EPROBE_DEFER;
>>> +		if (IS_ERR(info->otg.cable)) {
>>> +			dev_err_probe(dev, PTR_ERR(info->otg.cable),
>>> +				      "extcon_get_extcon_dev(%s) failed\n",
>>> +				      USB_HOST_EXTCON_NAME);
>>> +			return PTR_ERR(info->otg.cable);
>>>  		}
>>>  		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
>>>  	}
>>> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
>>> index d67edb760c94..92db79400a6a 100644
>>> --- a/drivers/power/supply/charger-manager.c
>>> +++ b/drivers/power/supply/charger-manager.c
>>> @@ -985,13 +985,10 @@ static int charger_extcon_init(struct charger_manager *cm,
>>>  	cable->nb.notifier_call = charger_extcon_notifier;
>>>  
>>>  	cable->extcon_dev = extcon_get_extcon_dev(cable->extcon_name);
>>> -	if (IS_ERR_OR_NULL(cable->extcon_dev)) {
>>> +	if (IS_ERR(cable->extcon_dev)) {
>>>  		pr_err("Cannot find extcon_dev for %s (cable: %s)\n",
>>>  			cable->extcon_name, cable->name);
>>> -		if (cable->extcon_dev == NULL)
>>> -			return -EPROBE_DEFER;
>>> -		else
>>> -			return PTR_ERR(cable->extcon_dev);
>>> +		return PTR_ERR(cable->extcon_dev);
>>>  	}
>>>  
>>>  	for (i = 0; i < ARRAY_SIZE(extcon_mapping); i++) {
>>> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
>>> index 25207fe2aa68..634658adf313 100644
>>> --- a/drivers/power/supply/max8997_charger.c
>>> +++ b/drivers/power/supply/max8997_charger.c
>>> @@ -248,13 +248,13 @@ static int max8997_battery_probe(struct platform_device *pdev)
>>>  		dev_info(&pdev->dev, "couldn't get charger regulator\n");
>>>  	}
>>>  	charger->edev = extcon_get_extcon_dev("max8997-muic");
>>> -	if (IS_ERR_OR_NULL(charger->edev)) {
>>> -		if (!charger->edev)
>>> -			return -EPROBE_DEFER;
>>> -		dev_info(charger->dev, "couldn't get extcon device\n");
>>> +	if (IS_ERR(charger->edev)) {
>>> +		dev_err_probe(charger->dev, PTR_ERR(charger->edev),
>>> +			      "couldn't get extcon device: max8997-muic\n");
>>> +		return PTR_ERR(charger->edev);
>>>  	}
>>>  
>>> -	if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
>>> +	if (!IS_ERR(charger->reg)) {
>>>  		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
>>>  		ret = devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_work, charger);
>>>  		if (ret) {
>>> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
>>> index d7f76835137f..a490f79131c1 100644
>>> --- a/drivers/usb/dwc3/drd.c
>>> +++ b/drivers/usb/dwc3/drd.c
>>> @@ -454,13 +454,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>>>  	 * This device property is for kernel internal use only and
>>>  	 * is expected to be set by the glue code.
>>>  	 */
>>> -	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>>> -		edev = extcon_get_extcon_dev(name);
>>> -		if (!edev)
>>> -			return ERR_PTR(-EPROBE_DEFER);
>>> -
>>> -		return edev;
>>> -	}
>>> +	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
>>> +		return extcon_get_extcon_dev(name);
>>>  
>>>  	/*
>>>  	 * Try to get an extcon device from the USB PHY controller's "port"
>>> diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
>>> index ee0863c6553e..6e6ef8c0bc7e 100644
>>> --- a/drivers/usb/phy/phy-omap-otg.c
>>> +++ b/drivers/usb/phy/phy-omap-otg.c
>>> @@ -95,8 +95,8 @@ static int omap_otg_probe(struct platform_device *pdev)
>>>  		return -ENODEV;
>>>  
>>>  	extcon = extcon_get_extcon_dev(config->extcon);
>>> -	if (!extcon)
>>> -		return -EPROBE_DEFER;
>>> +	if (IS_ERR(extcon))
>>> +		return PTR_ERR(extcon);
>>>  
>>>  	otg_dev = devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
>>>  	if (!otg_dev)
>>> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
>>> index 72f9001b0792..96c55eaf3f80 100644
>>> --- a/drivers/usb/typec/tcpm/fusb302.c
>>> +++ b/drivers/usb/typec/tcpm/fusb302.c
>>> @@ -1708,8 +1708,8 @@ static int fusb302_probe(struct i2c_client *client,
>>>  	 */
>>>  	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>>>  		chip->extcon = extcon_get_extcon_dev(name);
>>> -		if (!chip->extcon)
>>> -			return -EPROBE_DEFER;
>>> +		if (IS_ERR(chip->extcon))
>>> +			return PTR_ERR(chip->extcon);
>>>  	}
>>>  
>>>  	chip->vbus = devm_regulator_get(chip->dev, "vbus");
>>>
>>
>>
>>
>>
> 
> 
