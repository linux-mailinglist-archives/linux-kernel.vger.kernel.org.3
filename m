Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75FE5AF651
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiIFUrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiIFUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:47:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C06E92F5A;
        Tue,  6 Sep 2022 13:47:46 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286JuuvQ017372;
        Tue, 6 Sep 2022 20:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OLZbukH3qSiuuXcos743VoQvDRex9q2vckW6C/pLSOY=;
 b=ZWC+kzw+xbqg64duub2hR38fDp3R3pQhrnMSXyxdhcRQTGd+fUUd00dASl9FyG8yN0aT
 IF4b/Q3l7ccOCIV677EMbQlKikqZ3NkeP/YU2xrBf4N+lgk1UpdUvL+80Rl+LNi2bT/L
 14d0+CHeO5f5hvkWKi40/BPI6tLX56jEUu7EEmyNJifpBKjT8oKdSGeSnP5GWkspdh4X
 WxzFPqyie3GKvJ8Rqj837KvFtXNsj+MIl2eylv+JaAAxlaEpPden3KpaS/hezv6mN15D
 aBzfFGIa6lbnaaNy/RPCyVS0g3AKTnEPEgutq7kO1Bz9bGBo+NmUA/8uR6czS/jJcn+/ mA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jecthhbm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:47:42 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286KaUXL018260;
        Tue, 6 Sep 2022 20:47:41 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3jbxja37kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 20:47:41 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286Klfj68061674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 20:47:41 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11A3AAC05B;
        Tue,  6 Sep 2022 20:47:41 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1225AC059;
        Tue,  6 Sep 2022 20:47:40 +0000 (GMT)
Received: from [9.160.74.237] (unknown [9.160.74.237])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 20:47:40 +0000 (GMT)
Message-ID: <f0f3a8c5-113c-7070-4613-150cc0cd20a6@linux.ibm.com>
Date:   Tue, 6 Sep 2022 15:47:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] leds: Ensure hardware blinking turns off when requested
Content-Language: en-US
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220520171134.31415-1-eajames@linux.ibm.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220520171134.31415-1-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9soKK_2NuCqcwXO7oO9e-cu66r1Wvgd0
X-Proofpoint-GUID: 9soKK_2NuCqcwXO7oO9e-cu66r1Wvgd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=770
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060095
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any update on this?


Thanks,

Eddie


On 5/20/22 12:11, Eddie James wrote:
> If an LED is blinking through the hardware and the trigger is deactivated,
> the driver will set the brightness to 0 to disable blinking. However, if
> the LED driver doesn't support non-blocking operations, the request for
> setting brightness to 0 will get queued. Then if a user requests a new
> non-zero brightness before the request for 0 brightness is executed, the
> LED blinking will not get disabled since the brightness will simply be
> updated.
> Fix this by flushing the workqueue before updating the requested
> brightness.
>
> Fixes: 4d71a4a12b13 ("leds: Add support for setting brightness in a synchronous way")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>   drivers/leds/led-class.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 6a8ea94834fa..861a1cb5df5b 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -55,6 +55,8 @@ static ssize_t brightness_store(struct device *dev,
>   
>   	if (state == LED_OFF)
>   		led_trigger_remove(led_cdev);
> +	/* flush out any request to disable blinking */
> +	flush_work(&led_cdev->set_brightness_work);
>   	led_set_brightness(led_cdev, state);
>   	flush_work(&led_cdev->set_brightness_work);
>   
