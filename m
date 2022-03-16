Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9584DB338
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356748AbiCPO2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356822AbiCPO1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:27:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DC639174;
        Wed, 16 Mar 2022 07:26:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GCnCEd009569;
        Wed, 16 Mar 2022 14:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KdNtNnI4QahbTvVrcNWzt9odwVrLNc8p/H6Oeg0P8sY=;
 b=kALe+cmp5vfkWeDS7ZTc3qy6+4YJPLeOUULqfyaNlb3op/DFxYhCsBu94P3hPGxCqVr5
 KIfgdmmvXsYYC0nQIz95l9FlbDOFR0TBh/AyXOuUVGwpwSXOzPb9063nWdg6ybsogFbL
 yTcw+/Udhb704OPF2TMvFh2dMJvx2VJeC7gEhJHwDCXLYO1dzeMXBV7o+PtC+b1hneN3
 not44ydtNkNXK42+QzW3yR3vZCeVNX3lab26MQqA/fsMqXtvpWoXAj81gupPIDHrUHkY
 Se4tI5A/MB2VbQnUi2zrGPP0ufNYkNZO84D6+GA2rhjKkYemjqeFB/bgsEgWIzQvC0r6 LA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rpbss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 14:26:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GEGwEi078518;
        Wed, 16 Mar 2022 14:26:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3030.oracle.com with ESMTP id 3et65pyqf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 14:26:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDQswnONAB0Owb14v7ljDvpJMgENaXoHBLuDytWzJVuX2WMe+nFxEX9BYP6KYnhyhJPiCo4Tlh3ErUXIAucVCNBZsMvO+9evi+qlXkPf4hriuPfpncScRSNc2c0tPf5KIl16WyFfTSSEzgovsU2m0U57khYV1VNilPbHDSft8CRfrDkOHXwiQZPlF4GlXdJwropjZc9BkvZK1SYslO2QKBSDU5QYEzCzU+G6gqaYQMqNKMhfGPcBZYcMSX+eoNa9m6zu7sZpWF3g7HSFK2s6U/OkLtxrohQyO/FKRgfuw24WqBb+0D7C8kRvntN11M8y6kaOROnwD8a32dXL8F91yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdNtNnI4QahbTvVrcNWzt9odwVrLNc8p/H6Oeg0P8sY=;
 b=aLAbK/AvpfL6d6xAx1AqPD0WAZSXJnmyg6mn9Om7xU2RI4ab0o2oCErp+VQJWTN6aS6mjhfJZmDvZEcAJ+0nDlz2Np/DdWZ3YOvi6Oe8OCoefl7A8WUfDKSzBPfbxomcK+jZJg2Iud2rKJ5U2HF+CBW3YfYiBGxLLlczVFtpkwGE4CktI8bwnZR/ehulRj8poUcHGYAuAIcKBEpTo1Yjkq5oxczpwFsCvEseJAFrfm8SAlv6XYDSGutzt/6ioLRrdba7Q8M/anHwh+1fpdc9XIq17MeXZ4KBsgejP/mKr7td7DUN/oSvEaf6vg5oaXtzDhJy5mdNCEdlUUO+JvIjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdNtNnI4QahbTvVrcNWzt9odwVrLNc8p/H6Oeg0P8sY=;
 b=AEVofQet04zfI/sZ6GM95ix+pNBmOvYkuyV1p62pjtit8CFdlQ2DNZ1dbKNaRqBDU75WPx49dQfCD/mtB3R8lwFKiEL0qwUQZsrfthtACHXAoqyjiU1t/uPJPn6x6kWtMymyaNyZoLlgyiW/wa7USVJz/9WfIPwMugdbQBkdeNg=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CH0PR10MB4955.namprd10.prod.outlook.com (2603:10b6:610:c2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Wed, 16 Mar 2022 14:26:22 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2%12]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 14:26:22 +0000
Message-ID: <7ac617f1-0187-c296-bc5a-f3e26ef21488@oracle.com>
Date:   Wed, 16 Mar 2022 09:26:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] scsi:libiscsi: remove unnecessary memset in
 iscsi_conn_setup
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Wu Bo <wubo40@huawei.com>, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Feilong Lin <linfeilong@huawei.com>
References: <20220316220936.191013-1-haowenchao@huawei.com>
 <44860f67-e626-411e-5ee6-9055ea2d5723@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <44860f67-e626-411e-5ee6-9055ea2d5723@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:5:74::47) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20cc759b-a132-408b-0158-08da0758f1e3
X-MS-TrafficTypeDiagnostic: CH0PR10MB4955:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB4955579AB00A98E5041BEA3CF1119@CH0PR10MB4955.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nl2BpHT7ePm6RvPyloW9SAs7X8yD04FLgljQt8Hwkh1KxjVqszy2kdZ6nwMyMoLeaeuz0UdHWbkGQxYMly6MceTLurE4ecooRqkAV+gbfV1Kih1/LrBInyBWfNiXe64Ip/kRxc44W6zzt19spqwZ1K8SrpjVkWfwc63kYRoCZdRhm9fVBwUa0LLMahTMQyk/KkNZkky4ynYnY+BG2uiWVuKt/631TBJKCyXDmfRnjnsfhEZ6uONwLakIa3SMN+pboBrIRY/6Ixz6zk+/3Gt6ZKqsyjm0WAp8S4nhC6Bxsq+zFkQODmh5glxw6orsBOxlKxZHaVA28L3P3nO1bZ1Vr+VdWpBZ9aI0f4U4K+EnpeOIKfDYrog9M3Hr+3g3JvdOmKK8MYZJ/UoR5G/lBtL3dzn/94NMxe2Xg7hygkSsk2VBaxH1izbDESYM2se+u9/uZtavsYyuHfv3VlEb/I5K6uMI/cKUx+T4xlqdMpPxscyAjJKcGkN2mqiGQzOLoGVsbm4caB7xzCn/vjsJtAqYesUt36sHST/vl2PuMN3seaZE0fHAD33PezO8utaxi1ErAh2abUKALPSQA4ZPjjF/8T0woQp4j8u++ruTYrxQyvn5F5aeMvOnnJFnhBeLJ6lVAkl5wArI/6jExwVdhuvVp5uvbRZW7xQc56MI8TYn9N9/WgMEyeha7VSBFihH4nsTrosUikv6NVhgkVBj6GQtYbNSb0QJEcotrBKE53mu6kk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(31696002)(66946007)(8676002)(86362001)(66556008)(26005)(186003)(66476007)(8936002)(6486002)(5660300002)(508600001)(38100700002)(7416002)(2906002)(6506007)(4326008)(2616005)(6636002)(110136005)(31686004)(83380400001)(6512007)(36756003)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky9lYkNKdUx6ZUpKazlJaG5BMXNsWU5KYU1BbWR5Q1lpaXVFMzBHNGdPS3Iz?=
 =?utf-8?B?T0YvTllsa3U1UkVJc1JhVXU0RE5XaE9kaHUzRTBMalR3bHhxNDYzc3hTQjFy?=
 =?utf-8?B?dnBUMDVacWJtME5XSW5XRysxTnptbVBYTldlbEo0ODVWSU5COHE3VkdyMEx0?=
 =?utf-8?B?QkYvRituSUhMSnVjYlN3aWF0NXZUc1ZyVjFVRVV4QytrVzZCWVZrd24vR0pv?=
 =?utf-8?B?Sm5WVyt3SEZQUFN2TVNBRllpRERPK2c1MTFpRStFN1NKNi8xWkdWZnc5MEV5?=
 =?utf-8?B?UHkyU1YrVkp5MG1TMGl3UHYwMWhjTkJFWkpSZWs3K09xWmR1SkZUdW5sc3N4?=
 =?utf-8?B?V2NUWU1qaGRNVFdqRDcrWU9abGVTeUNRNStwdVdnSmhjS3o3bGNISWhqSHpG?=
 =?utf-8?B?ZFUrejRVYndSZ1hldk5vaG5JMlVIMzVncGwyWlEzUEhHVkU1SWRrczJ3WDBy?=
 =?utf-8?B?V1l4YzBjOUt2NXJNTlhDa0dpUXJzbHpQalRrKy9YczFPdXduZXJkYkJaL0tB?=
 =?utf-8?B?YVgvaTdpbEJpVzVhMTVWYUtzMGI2dHlqeGRuelR3Zm1hSGRwYWhjSmVhL0t6?=
 =?utf-8?B?NEFVOTBDVFBZSGN4cC9SdFJNM0YzSVoycEMzWDdzOGlneVF1UHExTmlTWEVo?=
 =?utf-8?B?cXp0cG1JWUk2NEZydTJDM01hMzVBclk0c1ZyV21mR2NmczhMcXV3ekltejJB?=
 =?utf-8?B?Z1VST2g3ZS9MS3VpVGlZNFhhdHNabjNDaTZMSFBhWkM2Tm9DVllBNlAvWXdi?=
 =?utf-8?B?YW92UHJoVEJBWkxzTlNnNmcySG1XVE5icXFPU0RyQWhuZmxWT0JtZ2JUaTFn?=
 =?utf-8?B?ZHF2c0QyZHY3UDlUclJtYVFBd3dyWjVpUlNjSzAzNytGM0Y5amRjOTQ4NFgw?=
 =?utf-8?B?bHdQSjdrYU53dXJxM1podWtpa1UxRFZCU3JIZDVteFExL1BPNnBWbXdXcS9G?=
 =?utf-8?B?NkFtZi8zS1BVVEJvcE8vQ3VqZWxuQWhCMjNYcWJMYXpDTHVWdUwyaXZzT05r?=
 =?utf-8?B?WmpIQlR4VVhJWlFBa3UrYmhxcUJFc2pET1dXbUpMQzVRcVdSazRuUXZyNVZs?=
 =?utf-8?B?R1ZFNnRlK1d2b1lIV1I1dlBpUkwxb1JHN3Ryc014clF3MkRYVDRYd3ZhbTJm?=
 =?utf-8?B?NnVKMlRRczh0ZDVNbEw3ZDNsYjRzc0R6bXpjd2JXMG5TZ1dyOHVwVHQ1N1NF?=
 =?utf-8?B?OVlCK3U2VGVVMTZHeFB5Q21uc205QW1RNWdrcUQwTnZ2ZFFGaHluV2s0TSt4?=
 =?utf-8?B?UzVmOVVJUTQyZGJNV1Zhb1JCc28rdzNISnlVRUs1Vk92SzJtRTh0WExMUGRi?=
 =?utf-8?B?NmFyMUJtMC9KVWFmUnVBKzRVZksrcGt6aUNCUStEcVpoMHJBMzNnOGRFTUFX?=
 =?utf-8?B?bE9aSDdTU3B4RitxNUlsUDd2V1pCc3ZPWXB0QWJMWXJGQ2NBVFVJdnVKd08z?=
 =?utf-8?B?aWQwdE5VSUwxQXJHVXhIbnNOR09uOEJYZTFGOVEzUUN6emxJbmdzMkhQdFNL?=
 =?utf-8?B?cXQ5a2RFWFpHOTIxQ05CbENFSkt2KzI3NjhCRVc1eE5HL2Z3c0R3RExBYS9G?=
 =?utf-8?B?cmx1RmdRbGZyYTZFUGlpWWRtc0hJamdtNzY5UFkvdEN1WnFNdDFsMDhMRDY4?=
 =?utf-8?B?eUNrTUw4RXFYcURHa3dPUlB6L3VBNlBPNmpaakRMWlVqSWptWW54QStRdnI5?=
 =?utf-8?B?djlNRVZOY1B4aWpUSkdFMEhiRUY5ZUtNNDVHdGRxdWttOXM1UnFvVGVaVllr?=
 =?utf-8?B?anQyV1FhTzFzT3lVQkdpekNKSThObjFQRDl1NE9pZmhUeXI4cTE5RUd0UVQ1?=
 =?utf-8?B?N3lVWUcxSzVNOWhHT0M5clVTc0NkdFQ0TzFOUVp2TTdOdmVFRU1yWWpzSzc1?=
 =?utf-8?B?czZvMWE2TE5oNWN2ZkliQUNMdHdkYzlTUjlIZjJXUVRvQmJDTXByWDRsYldX?=
 =?utf-8?B?RDExS210bjBualA5UkRmVGcyY1JYcDAvZ3NpNUNobjNHTDRHQnhpYmUrRWpU?=
 =?utf-8?B?MGpTYTBBRE9nPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cc759b-a132-408b-0158-08da0758f1e3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 14:26:22.4923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdjMsm7iRVTLkU0daqBrgnQNSDvEEi6spHWVF3FIGTE11D2zcmRMHGvuK+3SUL1M93wmVBs2hZniSTbJm02nkkFQjY5rfmK38f4zmn+orwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4955
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=976 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160090
X-Proofpoint-ORIG-GUID: qiaz-3doKAGmGvVIvmC7bJPEKtTgxhap
X-Proofpoint-GUID: qiaz-3doKAGmGvVIvmC7bJPEKtTgxhap
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 4:02 AM, Wenchao Hao wrote:
> cc open-iscsi@googlegroups.com linux-scsi@vger.kernel.org
> 
> On 2022/3/17 6:09, Wenchao Hao wrote:
>> iscsi_cls_conn is alloced by kzalloc(), the whole iscsi_cls_conn is
>> zero filled already including the dd_data. So it is unnecessary to
>> call memset again.
>>
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>> Reviewed-by: Wu Bo <wubo40@huawei.com>
>> ---
>>   drivers/scsi/libiscsi.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
>> index d09926e6c8a8..cf4211c6500d 100644
>> --- a/drivers/scsi/libiscsi.c
>> +++ b/drivers/scsi/libiscsi.c
>> @@ -3045,7 +3045,6 @@ iscsi_conn_setup(struct iscsi_cls_session *cls_session, int dd_size,
>>       if (!cls_conn)
>>           return NULL;
>>       conn = cls_conn->dd_data;
>> -    memset(conn, 0, sizeof(*conn) + dd_size);
>>         conn->dd_data = cls_conn->dd_data + sizeof(*conn);
>>       conn->session = session;
>>
> 

The removal of the memset is ok, but you should resend the original
to the list because the formatting got messed up, and I think Martin
can't track this (The patch doesn't show up in patchwork/lore type of
things).

