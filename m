Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDDC5882DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiHBTvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiHBTvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:51:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D87713F24;
        Tue,  2 Aug 2022 12:51:35 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272JkFWd010802;
        Tue, 2 Aug 2022 19:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rnivLeUSdP+wbl0isK8o6unZYPkNKv5qWeUBsBCvnxU=;
 b=ZRpJwdOKC8PNIgFjlClQhRhBQSQ8SctD39Zcy/n57Gn4lhC1aciElftZIDOgBgelAbYZ
 1RNVTHE9CYad5C7/WjUCRQZax1F5paaIiCp8HkId5tJdCLDbz1JZ+qYGMIdz7Uaz8FiT
 AcYFkb2/Sxy7GgFMP6KDhAi5tOVHYllJkb6uWDsBkp8JjFRt11JdJO+zQyIVj5fyIj3x
 vLgQ+X3e1h48e+Mz3IIzv0j6B/yIP8nkd1gGgYyJtrfyU7Ld4w1CKwWDIcb13CEruCJ6
 VyXYNcvy4UPXNagz3b9ePcBoLF02CRTwMYTK+o88fqZQa5Navxf1R1BMALXit7sw6Els 4A== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hqac7r2sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 19:51:20 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 272Jogxd009967;
        Tue, 2 Aug 2022 19:51:19 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3hmv99m12u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 19:51:19 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 272JpJrt10682934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Aug 2022 19:51:19 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F5AC12405B;
        Tue,  2 Aug 2022 19:51:19 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B328B124052;
        Tue,  2 Aug 2022 19:51:18 +0000 (GMT)
Received: from [9.77.144.23] (unknown [9.77.144.23])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Aug 2022 19:51:18 +0000 (GMT)
Message-ID: <78bb351e-37de-bf62-dd16-67b2df7528ff@linux.ibm.com>
Date:   Tue, 2 Aug 2022 14:51:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/1] hwmon: (occ) Replace open-coded variant of %*phN
 specifier
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>
References: <20220726143110.4809-1-andriy.shevchenko@linux.intel.com>
 <833d605d-0605-9439-6544-885e6f5f75b0@roeck-us.net>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <833d605d-0605-9439-6544-885e6f5f75b0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kE9cJc0-V4PZPiCi1P-jgcLmjX6Kt2la
X-Proofpoint-ORIG-GUID: kE9cJc0-V4PZPiCi1P-jgcLmjX6Kt2la
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_14,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208020092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/26/22 10:05, Guenter Roeck wrote:
> On 7/26/22 07:31, Andy Shevchenko wrote:
>> printf()-like functions in the kernel have extensions, such as
>> %*phN to dump small pieces of memory as hex bytes.
>>
>> Replace custom approach with the direct use of %*phN.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Email was acting up so I missed this at the time. Thanks Andy!


>
> Applied.
>
> Thanks,
> Guenter
>
>> ---
>>   drivers/hwmon/occ/common.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
>> index 157b73a3da29..45407b12db4b 100644
>> --- a/drivers/hwmon/occ/common.c
>> +++ b/drivers/hwmon/occ/common.c
>> @@ -729,18 +729,14 @@ static ssize_t occ_show_extended(struct device 
>> *dev,
>>               rc = sysfs_emit(buf, "%u",
>> get_unaligned_be32(&extn->sensor_id));
>>           } else {
>> -            rc = sysfs_emit(buf, "%02x%02x%02x%02x\n",
>> -                    extn->name[0], extn->name[1],
>> -                    extn->name[2], extn->name[3]);
>> +            rc = sysfs_emit(buf, "%4phN\n", extn->name);
>>           }
>>           break;
>>       case 1:
>>           rc = sysfs_emit(buf, "%02x\n", extn->flags);
>>           break;
>>       case 2:
>> -        rc = sysfs_emit(buf, "%02x%02x%02x%02x%02x%02x\n",
>> -                extn->data[0], extn->data[1], extn->data[2],
>> -                extn->data[3], extn->data[4], extn->data[5]);
>> +        rc = sysfs_emit(buf, "%6phN\n", extn->data);
>>           break;
>>       default:
>>           return -EINVAL;
>
