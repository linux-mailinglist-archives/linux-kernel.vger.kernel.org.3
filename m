Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBF54B921C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiBPUJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:09:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiBPUJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:09:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C82243121;
        Wed, 16 Feb 2022 12:09:32 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GK8GS8030613;
        Wed, 16 Feb 2022 20:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=eSWTTXSEJyiw9ZzT+BZ/pD5Pj09opHDFvBiwAFYH+QY=;
 b=o1RD9i2cP9xzap8gkAWHs7zUErh0fzDCp6F632QBUVMCi6pBiyszh+T359OjV8lzk81q
 NmpsKagiyN/nEJlSnSWMknKO/36ke9YBEn7RmewMl46JEQJf/qXxk5T+efLBUSxP/Ocq
 QyBDIzsrcsuJQQ6yQMEciEyBA8PuHTXVFiI4rfxmzrwTPyrHjOBYFvHOWjPeCKxKNrPS
 9tOJSmyLPW/TsBt0zG0XnvI+et4yWDp9Gldm9Z/6cZcmBfbdGgdgqXXVdjNisIpwvhQY
 8nx2Mh403bP4LtuxhoS0Zk6B2KUAX5xGUaw9oPKRyQqCoyIshpZQ4FR7ujHNog/ABUp8 ag== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e95hykq8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 20:09:17 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21GK2DmH018666;
        Wed, 16 Feb 2022 20:09:16 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 3e64hbquqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 20:09:16 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21GK9FHj32834038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 20:09:15 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8294AE071;
        Wed, 16 Feb 2022 20:09:15 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D4B6AE066;
        Wed, 16 Feb 2022 20:09:15 +0000 (GMT)
Received: from [9.211.63.35] (unknown [9.211.63.35])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 16 Feb 2022 20:09:15 +0000 (GMT)
Message-ID: <19ac1b85-842f-dfcf-93db-489ab6598ff8@linux.ibm.com>
Date:   Wed, 16 Feb 2022 14:09:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] hwmon: (occ) Add soft minimum power cap attribute
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <20220215151022.7498-1-eajames@linux.ibm.com>
 <20220215151022.7498-5-eajames@linux.ibm.com>
 <CACPK8Xe+M97Covu0+Qc9M-8vdCc9pTXfZjJ9y6_Xm-j1E4GUPQ@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CACPK8Xe+M97Covu0+Qc9M-8vdCc9pTXfZjJ9y6_Xm-j1E4GUPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Gi6UGGVu4auYO_b-mzz8tI279musCwPx
X-Proofpoint-GUID: Gi6UGGVu4auYO_b-mzz8tI279musCwPx
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_09,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/16/22 00:33, Joel Stanley wrote:
> On Tue, 15 Feb 2022 at 15:11, Eddie James <eajames@linux.ibm.com> wrote:
>> Export the power caps data for the soft minimum power cap through hwmon.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/hwmon/occ/common.c | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
>> index 0cb4a0a6cbc1..f00cd59f1d19 100644
>> --- a/drivers/hwmon/occ/common.c
>> +++ b/drivers/hwmon/occ/common.c
>> @@ -674,6 +674,9 @@ static ssize_t occ_show_caps_3(struct device *dev,
>>          case 7:
>>                  val = caps->user_source;
>>                  break;
>> +       case 8:
>> +               val = get_unaligned_be16(&caps->soft_min) * 1000000ULL;
>> +               break;
>>          default:
>>                  return -EINVAL;
>>          }
>> @@ -835,12 +838,13 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>>          case 1:
>>                  num_attrs += (sensors->caps.num_sensors * 7);
>>                  break;
>> -       case 3:
>> -               show_caps = occ_show_caps_3;
>> -               fallthrough;
>>          case 2:
>>                  num_attrs += (sensors->caps.num_sensors * 8);
>>                  break;
>> +       case 3:
>> +               show_caps = occ_show_caps_3;
>> +               num_attrs += (sensors->caps.num_sensors * 9);
> How do we know this changed from 8 to 9?


Well we made the structure change a while back when adding P10 support, 
but didn't bother to export the "soft min" field. Now it's needed.


>
> We should start adding links to the occ source code, or a similar
> reference, when making these changes so they can be reviewed.


I would but it doesn't appear to be public for P10 yet... at least, no 
one has updated the P9 OCC spec hosted in the open-power repo: 
https://github.com/open-power/docs


Thanks,

Eddie


>
>> +               break;
>>          default:
>>                  sensors->caps.num_sensors = 0;
>>          }
>> @@ -1047,6 +1051,15 @@ static int occ_setup_sensor_attrs(struct occ *occ)
>>                          attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
>>                                                       show_caps, NULL, 7, 0);
>>                          attr++;
>> +
>> +                       if (sensors->caps.version > 2) {
>> +                               snprintf(attr->name, sizeof(attr->name),
>> +                                        "power%d_cap_min_soft", s);
>> +                               attr->sensor = OCC_INIT_ATTR(attr->name, 0444,
>> +                                                            show_caps, NULL,
>> +                                                            8, 0);
>> +                               attr++;
>> +                       }
>>                  }
>>          }
>>
>> --
>> 2.27.0
>>
