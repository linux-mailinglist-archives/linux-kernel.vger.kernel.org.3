Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBA14D5A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiCKFCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiCKFCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:02:32 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60751AAFF7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:01:27 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220311050121epoutp028c4b003c20286988e780d33583c770e1~bOu2-5dNh2170521705epoutp02H
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:01:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220311050121epoutp028c4b003c20286988e780d33583c770e1~bOu2-5dNh2170521705epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646974881;
        bh=+59sJV9cSMvjPyOkvqv4pGAyNeXUmdaNbqejXC9+ehU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jbOX0UYImNy59sJdrt4j57gnOGzS5iSB860TtTxtw9dmPYZv7OQxLI6tdgSol8s3D
         CLIw3khr5m8yPoTbImbFs1ZO1mk5hCtyE+G7BvG1nC0iXalSh0BAHdnynfRL421iM0
         vInCQ4zAyy27FpXsVWl+QN5EN5LDS/1sn29NDRcg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220311050120epcas1p170f3e6e10551a472c5916531a4ebd4dd~bOu2ecVFH0422304223epcas1p1J;
        Fri, 11 Mar 2022 05:01:20 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.234]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KFDKk6ycTz4x9QC; Fri, 11 Mar
        2022 05:01:14 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.74.08277.697DA226; Fri, 11 Mar 2022 14:01:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220311050109epcas1p481408b3da1a1ecb860b0ee5f964e87e6~bOuru_CxM3089030890epcas1p4G;
        Fri, 11 Mar 2022 05:01:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220311050109epsmtrp1f8f8281f5047c193569c9b472e714d71~bOuruDap90504105041epsmtrp1C;
        Fri, 11 Mar 2022 05:01:09 +0000 (GMT)
X-AuditID: b6c32a36-1edff70000002055-90-622ad79605ab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.45.03370.597DA226; Fri, 11 Mar 2022 14:01:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220311050109epsmtip1a6ddfbae51b2ab3ffd63457bfc67ced8~bOurfxOPW1780817808epsmtip10;
        Fri, 11 Mar 2022 05:01:09 +0000 (GMT)
Subject: Re: [PATCH V1] extcon/usb: Remove disable irq operation in system
 sleep.
To:     Roger Quadros <rogerq@kernel.org>,
        Bruce Chen <brucechen251@gmail.com>, bruce.chen@unisoc.com,
        myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     orsonzhai@gmail.com, gengcixi@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <0c8047d5-e171-2953-be50-b9a21c4b22d8@samsung.com>
Date:   Fri, 11 Mar 2022 14:26:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <32165383-5ccf-e6a1-92ef-cde14c401eaa@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmvu6061pJBpfauCzmPbnEarGx8SGT
        xauvE9gtVj5gsVjUvoTF4vKuOWwWtxtXsFlM/zCb0eLcvXWsFv/PfmC3WP5gF7sDt8fOWXfZ
        PTat6mTz6NuyitHj+I3tTB6H28+ye3zeJBfAFpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9q
        ZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0npJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1
        ICWnwLRArzgxt7g0L10vL7XEytDAwMgUqDAhO+Prvn9MBQuFK85cWcbawLicv4uRk0NCwERi
        +/5ZzF2MXBxCAjsYJeZM38MK4XxilLg/sZ8ZpEpI4DOjxMTHCjAd87r+QhXtYpQ4PekeC4Tz
        nlHi1pEnTCBVwgLBEie6nzGCJERAEje37mABSTALREusPfeVHcRmE9CS2P/iBhuIzS+gKHH1
        x2NGEJtXwE6i6eBHsDiLgKrEzPcrWUFsUYEwiZPbWqBqBCVOznwCNpMTqP7u+b3sEPPFJW49
        mc8EYctLbH87B+w5CYEDHBKzl+1nhvjBReL+gSvsELawxKvjW6BsKYmX/W3sEA3NjBINL24z
        Qjg9jBJHn/WxQFQZS+xfOhloBQfQCk2J9bv0IcKKEjt/z2WE2Mwn8e5rDytIiYQAr0RHmxBE
        ibLE5Qd3mSBsSYnF7Z1sExiVZiH5ZxaSH2Yh+WEWwrIFjCyrGMVSC4pz01OLDQuM4PGdnJ+7
        iRGceLXMdjBOevtB7xAjEwfjIUYJDmYlEd6mUI0kId6UxMqq1KL8+KLSnNTiQ4ymwBCeyCwl
        mpwPTP15JfGGJpYGJmZGxiYWhmaGSuK8q6adThQSSE8sSc1OTS1ILYLpY+LglGpg8nfQqZ/v
        e1WnbRZbmHnpbV2/xwcCdvxY3D3niv8pzTRBUeWgz2xfHDUiX+pej7tc+Gn+0zcJCwPW8xZ7
        lr0JFjxplJke+Yd7VS7z0sPvD9veY/l96tTB0GJb88rlP3433Y0smuTR2P5HI8xjW5HSeyHe
        71N7j3v6L21kjFw1cW30bvET+tvPT70wrarotay54Z79szUKdlxRPiK61vb3m5Aq3zn5s9q1
        302ZulrH3cjs/MfpZRd+P7xvYpMXYrrireKKzb9/am/myg92VGj7Ij0h/MYkRje2BCPOirf/
        eU5zKiXFGd7bIJfP+UXjrl+CT8OmYMuQF79u+nbLLpninL395inpD3vlFh9657ayVImlOCPR
        UIu5qDgRAH7/mt5FBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnO7U61pJBqdPiljMe3KJ1WJj40Mm
        i1dfJ7BbrHzAYrGofQmLxeVdc9gsbjeuYLOY/mE2o8W5e+tYLf6f/cBusfzBLnYHbo+ds+6y
        e2xa1cnm0bdlFaPH8RvbmTwOt59l9/i8SS6ALYrLJiU1J7MstUjfLoEr4+u+f0wFC4UrzlxZ
        xtrAuJy/i5GTQ0LARGJe11/WLkYuDiGBHYwS3ae/M0IkJCWmXTzK3MXIAWQLSxw+XAxR85ZR
        YuWTxUwgNcICwRInup8xgiREBN4zStzr+cwKkmAWiJa4/+wu2CAhgXOMEsvW5oHYbAJaEvtf
        3GADsfkFFCWu/ngMVsMrYCfRdPAjWJxFQFVi5vuVYHNEBcIkdi55zARRIyhxcuYTFhCbE6j+
        7vm97BC71CX+zLvEDGGLS9x6Mp8JwpaX2P52DvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuK
        c9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxguNPS2sH455VH/QOMTJxMB5ilOBgVhLhbQrVSBLi
        TUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBieuy6ZmQ50LT
        S0LMfDS3NF3Ia79RF2Q92/GNd8LUbD3JC+e/qZq/OiL7V1H6av+LluK4CdKFjLqPFJkbfi6a
        /IS1n3cv2942X+smxpkZk6xsXuVyngvN87/8NU5r/i+V8wlm92/12eaZZDt1XJ8cFTZXQP8I
        i61C6PJzzRNWxcXvvSqfcWFKSXPz/oxNLCkr/jJc/DQ1/vMRC/WchhTJopnHDRUCLPx89LaW
        yLtttLml9f/dmaszn/JpfNr89pHQj/oSl7vJotfadr7xW+53pUviwrmfH79tnrokdn9jUtC2
        efml0zb/2Gov4W1dbLb7JpNsz6ejk+asubQhvXp3E7tpafR/m8+XP4S+maKzQImlOCPRUIu5
        qDgRAILTleAuAwAA
X-CMS-MailID: 20220311050109epcas1p481408b3da1a1ecb860b0ee5f964e87e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220303092051epcas1p4a6ec4cff37a8f266a584d8d90aa9eac0
References: <1646292963-20570-1-git-send-email-brucechen251@gmail.com>
        <CGME20220303092051epcas1p4a6ec4cff37a8f266a584d8d90aa9eac0@epcas1p4.samsung.com>
        <32165383-5ccf-e6a1-92ef-cde14c401eaa@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/22 6:20 PM, Roger Quadros wrote:
> +TI folks Aswath & Vignesh.
> 
> Hi Bruce,
> 
> On 03/03/2022 09:36, Bruce Chen wrote:
>> From: Bruce Chen <bruce.chen@unisoc.com>
>>
>> If disable vbus/id irq, it will lead to wakeup system fail
>> in unisoc platform. In unisoc platform, Irq enable and irq
>> wakeup are the same interrupt line. So remove disable vbus/id
>> irq operation is a way to solve the issue> 
>> Signed-off-by: Bruce Chen <bruce.chen@unisoc.com>
>> ---
>>  drivers/extcon/extcon-usb-gpio.c | 15 ---------------
>>  1 file changed, 15 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
>> index f2b65d9..40d967a 100644
>> --- a/drivers/extcon/extcon-usb-gpio.c
>> +++ b/drivers/extcon/extcon-usb-gpio.c
>> @@ -226,16 +226,6 @@ static int usb_extcon_suspend(struct device *dev)
>>  		}
>>  	}
>>  
>> -	/*
>> -	 * We don't want to process any IRQs after this point
>> -	 * as GPIOs used behind I2C subsystem might not be
>> -	 * accessible until resume completes. So disable IRQ.
>> -	 */
> 
> I think the reason this was added was that if USB cable is plugged/unplugged
> while system was suspending it was causing some faults on TI DRA7 EVM
> at usb_irq_handler()/usb_extcon_detect_cable() when it tries to read GPIO status
> when I2C based GPIO controller was used but already suspended.
> But looks like disabling the IRQ is not the right approach either so your patch
> is right.
> 
> However I'm not sure if the above issue will still exist on DRA7 and other TI EVMS
> using ID/VBUS GPIO over I2C device.
> 
> Let's wait for Aswath/Vignesh to confirm. If no issues I'm OK with this patch.
> 
>> -	if (info->id_gpiod)
>> -		disable_irq(info->id_irq);
>> -	if (info->vbus_gpiod)
>> -		disable_irq(info->vbus_irq);
>> -
>>  	if (!device_may_wakeup(dev))
>>  		pinctrl_pm_select_sleep_state(dev);
>>  
>> @@ -267,11 +257,6 @@ static int usb_extcon_resume(struct device *dev)
>>  		}
>>  	}
>>  
>> -	if (info->id_gpiod)
>> -		enable_irq(info->id_irq);
>> -	if (info->vbus_gpiod)
>> -		enable_irq(info->vbus_irq);
>> -
>>  	queue_delayed_work(system_power_efficient_wq,
>>  			   &info->wq_detcable, 0);
>>  
> 
> cheers,
> -roger
> 
> 

Applied it after editing the patch title as following: Thanks.

- extcon: usb-gpio: Remove disable irq operation in system sleep


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
