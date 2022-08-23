Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDD659CE85
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiHWC1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbiHWC1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:27:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE5F5B071;
        Mon, 22 Aug 2022 19:27:39 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27N0m8Bl013225;
        Tue, 23 Aug 2022 02:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MBPgM0Td3/UPNs3gmbkx0u9Y1bdXdEo6f1g9EVBkOJM=;
 b=An2EF9fuWPwpz9AXi0pmwYg+QFPXegOsCROR/wq7NlGbM9TJpjeBBCEPWaftsOoT6eUo
 HmAVTKw+jE3Kv22tvZieJojTim/ruTM/9PvlBXBOBEu332rnnraK/d4l7QxL6bjZ5oLL
 +/MYNcou3phTlqM2Up46fybnurF5Gv0bkaL07/SQFrwyWR0gIO5+ic/tBWRpDRqMbMQP
 65WwB/vNUtTtDuMGQWWy80SEdJ/UqsAkQtJcJ1sAEyPuxhXbHgjTVwta+vRslGfn044C
 WyLkMIIB1lFu3m9aqRyBwaGTFgqCOzgCqvbKeGI1V/O66F7nrSkHvz+qyMr9G85DrJ7Z kQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j4gu88kpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 02:27:07 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27N2R6JB031296
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 02:27:06 GMT
Received: from [10.233.21.232] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 22 Aug
 2022 19:27:05 -0700
Message-ID: <5e17fc89-6056-076c-0c4e-dac7f312792c@quicinc.com>
Date:   Tue, 23 Aug 2022 10:26:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [REGRESSION 5.19] NULL dereference by ucsi_acpi driver
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Takashi Iwai <tiwai@suse.de>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <87r11cmbx0.wl-tiwai@suse.de> <YwEqtGB2WldUeiEN@kroah.com>
 <YwODjnYQD/KjxXdw@kuha.fi.intel.com>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <YwODjnYQD/KjxXdw@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 01akvCyaRmuKlDJYQzWDNuMPva07HzWh
X-Proofpoint-ORIG-GUID: 01akvCyaRmuKlDJYQzWDNuMPva07HzWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_16,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230007
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/22/2022 9:24 PM, Heikki Krogerus wrote:
> Hi,
>
> On Sat, Aug 20, 2022 at 08:40:52PM +0200, Greg Kroah-Hartman wrote:
>> On Fri, Aug 19, 2022 at 06:32:43PM +0200, Takashi Iwai wrote:
>>> Hi,
>>>
>>> we've got multiple reports about 5.19 kernel starting crashing after
>>> some time, and this turned out to be triggered by ucsi_acpi driver.
>>> The details are found in:
>>>    https://bugzilla.suse.com/show_bug.cgi?id=1202386
>>>
>>> The culprit seems to be the commit 87d0e2f41b8c
>>>      usb: typec: ucsi: add a common function ucsi_unregister_connectors()
>> Adding Heikki to the thread...
>>
>>>      
>>> This commit looks as if it were a harmless cleanup, but this failed in
>>> a subtle way.  Namely, in the error scenario, the driver gets an error
>>> at ucsi_register_altmodes(), and goes to the error handling to release
>>> the resources.  Through this refactoring, the release part was unified
>>> to a funciton ucsi_unregister_connectors().  And there, it has a NULL
>>> check of con->wq, and it bails out the loop if it's NULL.
>>> Meanwhile, ucsi_register_port() itself still calls destroy_workqueue()
>>> and clear con->wq at its error path.  This ended up in the leftover
>>> power supply device with the uninitialized / cleared device.
>>>
>>> It was confirmed that the problem could be avoided by a simple
>>> revert.
>> I'll be glad to revert this now, unless Heikki thinks:
>>
>>> I guess another fix could be removing the part clearing con->wq, i.e.
>>>
>>> --- a/drivers/usb/typec/ucsi/ucsi.c
>>> +++ b/drivers/usb/typec/ucsi/ucsi.c
>>> @@ -1192,11 +1192,6 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
>>>   out_unlock:
>>>   	mutex_unlock(&con->lock);
>>>   
>>> -	if (ret && con->wq) {
>>> -		destroy_workqueue(con->wq);
>>> -		con->wq = NULL;
>>> -	}
>>> -
>>>   	return ret;
>>>   }
>>>   
>>>
>>> ... but it's totally untested and I'm not entirely sure whether it's
>>> better.
>> that is any better?
> No, I don't think that's better. Right now I would prefer that we play
> it safe and revert.
>
> The conditions are different in the two places where the ports are
> unregistered in this driver. Therefore I don't think it makes sense
> to use a function like ucsi_unregister_connectors() that tries to
> cover both cases. It will always be a little bit fragile.
>
> Instead we could introduce a function that can be used to remove a
> single port. That would leave the handling of the conditions to the
> callers of the function, but it would still remove the boilerplate.
> That would be much safer IMO.
>
> But to fix this problem, I think we should revert.

but revert will happen on several stable branch, right ?

i think simple fix is good, from my view there is no big differences to 
create a function for a single port.


>
> thanks,
>
