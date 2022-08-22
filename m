Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3859B7C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiHVCol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiHVCoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:44:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA70623144;
        Sun, 21 Aug 2022 19:44:36 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M2hMBX001449;
        Mon, 22 Aug 2022 02:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=juDtttnpY2hfPKZF/E8PLl8zJqyste3Yxw9/njPotaw=;
 b=Wn9R1CFoYozli/U6/LCtkbCv5RjrCWzXJ3piXwPgUYxD/+S/LAG4apO+DgD68Ds0UbUW
 PD3I9Jpjec3oKsZORYzQWhMBKbmnMP++VdO+qjg0EoZPGyb4itGWrt9rts3x/4sny8iR
 3j7dtnbaEx633NEaiYWrtTat3411DhyW5l68aNi7c0QKr8lPys/gVo742fIHY4Xstlnw
 VoAKHLcVXCgtXVRWvYN+SrPoroL0/CK2fEFTvd3v5a8TDzm3Tmn842bRpF9K+QJ6k+xC
 eydSbSj9yFhON1YVdtrl5l4lr72i4c7OdUAVNP9qsRD+bdIpNjx30xPjKmiDRdjbzuqi dw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j2vwhtw2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 02:44:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27M2iUmx016393
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 02:44:30 GMT
Received: from [10.233.21.232] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 21 Aug
 2022 19:44:28 -0700
Message-ID: <09f1204c-1256-e737-b769-be899870c946@quicinc.com>
Date:   Mon, 22 Aug 2022 10:44:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [REGRESSION 5.19] NULL dereference by ucsi_acpi driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <87r11cmbx0.wl-tiwai@suse.de> <YwEqtGB2WldUeiEN@kroah.com>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <YwEqtGB2WldUeiEN@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7dKK149XDcHG2CAxVHBkKLxMWlyGVQe0
X-Proofpoint-GUID: 7dKK149XDcHG2CAxVHBkKLxMWlyGVQe0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-21_17,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220013
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/21/2022 2:40 AM, Greg Kroah-Hartman wrote:
> On Fri, Aug 19, 2022 at 06:32:43PM +0200, Takashi Iwai wrote:
>> Hi,
>>
>> we've got multiple reports about 5.19 kernel starting crashing after
>> some time, and this turned out to be triggered by ucsi_acpi driver.
>> The details are found in:
>>    https://bugzilla.suse.com/show_bug.cgi?id=1202386
>>
>> The culprit seems to be the commit 87d0e2f41b8c
>>      usb: typec: ucsi: add a common function ucsi_unregister_connectors()
> Adding Heikki to the thread...
>
>>      
>> This commit looks as if it were a harmless cleanup, but this failed in
>> a subtle way.  Namely, in the error scenario, the driver gets an error
>> at ucsi_register_altmodes(), and goes to the error handling to release
>> the resources.  Through this refactoring, the release part was unified
>> to a funciton ucsi_unregister_connectors().  And there, it has a NULL
>> check of con->wq, and it bails out the loop if it's NULL.
>> Meanwhile, ucsi_register_port() itself still calls destroy_workqueue()
>> and clear con->wq at its error path.  This ended up in the leftover
>> power supply device with the uninitialized / cleared device.
>>
>> It was confirmed that the problem could be avoided by a simple
>> revert.
> I'll be glad to revert this now, unless Heikki thinks:
>
>> I guess another fix could be removing the part clearing con->wq, i.e.
>>
>> --- a/drivers/usb/typec/ucsi/ucsi.c
>> +++ b/drivers/usb/typec/ucsi/ucsi.c
>> @@ -1192,11 +1192,6 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
>>   out_unlock:
>>   	mutex_unlock(&con->lock);
>>   
>> -	if (ret && con->wq) {
>> -		destroy_workqueue(con->wq);
>> -		con->wq = NULL;
>> -	}
>> -
>>   	return ret;
>>   }
>>   
>>
>> ... but it's totally untested and I'm not entirely sure whether it's
>> better.

this part is original code, yes, but when I make the change you mentioned,

as in the function ucsi_unregister_connectors(),  just use con->wq to 
represent which connector initialized previous,

indeed if we clear it in ucsi_register_port(), something will left unclear.

please send a patch to fix it.

I think your change is good.

> that is any better?
>
> thanks,
>
> greg k-h
