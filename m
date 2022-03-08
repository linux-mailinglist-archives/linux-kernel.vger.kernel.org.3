Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D714D1ECE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349016AbiCHRWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348919AbiCHRVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:21:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6836141FA7;
        Tue,  8 Mar 2022 09:19:46 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228Gms25004827;
        Tue, 8 Mar 2022 17:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ELeL/OSrSMtNGcAJLaSZEUiEG59PgkgBzNJkJFRroVM=;
 b=O5iwSmZ6RFE1/DITGH9CvohZ4k/kqwWEj9vWIvkOgPVGwyujpKxGVIYty6v7JQPXNCSI
 s3kRemhjqiwrdq+dOjnMQVT2oPBTDisAIREuA09ilfwFB1GdWCb2q/KBbEuLnXk2P18X
 Bq3pde0hHst9pybMmMjJjyNHpA8wcuI6IiH/XWoYSOLiukhb8h72slYmKQlDJeUbbCKm
 Px5vo2wRkjTddLUEHLUvMkp/cToa+C7I5uZH2yRpgX1ZXtAdNXP3qUUfBhbzOCoRIqGn
 R4ZTT8KNKNg6RNXSG4ZzWZszMdE0jAG+0WE8vatYVW78lYEVueJaYANdEP/QIE5Bqd9j dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyfsfnns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 17:19:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 228HIxq1034506;
        Tue, 8 Mar 2022 17:19:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by userp3020.oracle.com with ESMTP id 3envvkrhag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 17:19:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbtFrwrQPOU05XxkDiz5TeNFjH7v/zhRWnWnVQDY2t7p3drJwnhYKiRhPL+toBxPUstE5q/Y+Ol54l0OeYVRNUuSx8EZkonwhsqbKjkLKXyDq7Mzk/qX9UBVu9RnYS/Rurr4Mv/FPLAfRH8+0ucu1KEU6qaGPNAy5GSX3C8eabX4MAtlgfnRdt8SrV7AfWajeA4XZxwFllAdkSY1uq1Xldto0+jU/qmHH4NvZSIrC/X3xYWQIyDumXFIDyecElTiP6wtUgTnRzYCjRdRl8+ZYjgtpzJVumXZl9dcaK0vr6dzIKh4fPLWinjUJq4jbXWefMr0goJSm3AxVjuc2OLvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELeL/OSrSMtNGcAJLaSZEUiEG59PgkgBzNJkJFRroVM=;
 b=FFdERoqnaH+jhvfV+lDycwArUI5iDuaZrCU0jqs4P68ks3M7z/LtiO80iznAZLJyTiNCw3lNBY6cwPCzkAgsG5Leydzb630xxaFyMlMSreq7zVQiI88vs8992wGJtwkbom6acO1VCFJ+O9Iaj22foZav0OjFmw0CJ1Y7Vtnm0otIG1L7fLzmZr5w7972eW/CctqNGDmYPqgwW//bvSQ1upRRagQtk3eSDT720j56ChdcDBKuDgLwYnNty0leEfcualYmHGfR0BEnXNWXoP2zEExrI5Nmgb3WwX4orznYIe61u+t4VjIbGYF+fL3mjbOASyEuu0gCmLdbSgWFh/KDLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELeL/OSrSMtNGcAJLaSZEUiEG59PgkgBzNJkJFRroVM=;
 b=STn6IdkIXkUW2FV6zuzIruUChC/mbb6+G7GFLmGcy8zJWJN1Wgj/FChRxs+jBjxfUPvqwlr77EOsZ/vXk7ykOajUCW6G5SYqZvOxjVMNH7wbIldH3AdXbhuPo6z0Hb84rOdmo8/KR6hCadlqIyuiqIGXWyl1GXVCSVLtYsfOalc=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BY5PR10MB4132.namprd10.prod.outlook.com (2603:10b6:a03:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 17:19:29 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2%12]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 17:19:29 +0000
Message-ID: <8183661b-a513-9b04-b289-3707704084b2@oracle.com>
Date:   Tue, 8 Mar 2022 11:19:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/3] scsi: iscsi: Add helper functions to manage
 iscsi_cls_conn
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        linfeilong@huawei.com
References: <20220309030916.2932316-1-haowenchao@huawei.com>
 <20220309030916.2932316-2-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20220309030916.2932316-2-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR19CA0034.namprd19.prod.outlook.com
 (2603:10b6:3:9a::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42117663-0c88-4c27-b969-08da0127cd80
X-MS-TrafficTypeDiagnostic: BY5PR10MB4132:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB41320A001BF6E4B26C8B3F58F1099@BY5PR10MB4132.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZ01MvaBxQVIluZsh/GrKjcx+Ya/TU5uUNBjtn+B5ouRjLN8lUckUE7tMHjmYsxeCGIwgKHF3aTbxmt2JOAtSyx2rCtNeQ49IUrE9urrZeqJPBLgzwdyjuNkUauOytapzfiLzEmRyzRYpqNMkzwFUhKAIr2yV/4kQjqHSwrtxg8wAaGGB5JlGnWpgo9UFUSw6Q4NqHYH8P9k2DwSrfyoTcCu6g6ECeI8lMCUZJxOFhY4xw/dS42Z4nc/q5st+cO0YOW5uEwG+SyGsgsdPepzhC1ICuw8aeVVYLb1QJo3gH5IJvqIiV4MUpAiKIDUqMYlyugEdEQgnNM1Gc1G5+TDwgPiTjf9KkEb7C7vwNsnA8aR8Gg6/mt7SK6u7qyKhjvEahZSCHoEOZ//QshrpOIKibxYmB3GoIkBIqPD9gFVLsgsyHD790+0vT6ZSYu54M686yKjz2hzMyE2hLMjaBHNgcG0zOjcj6EQK8ddji15cEkWTmEZC8SbHy2swEJRNrfLWiD/LFmQXv5ChL0ZhBkfg7Cv4P3302qWeodDTZVXVxX6YTcd13tRhIHfTKcFnfBz8PZ3lu03TWmaWT2rLScOJuJRBIzsDbsAWao0a4/2FVJBwxdCXtFtlZ+we9+ZB0Dvm16rJb7pB9ZF9fGj6SJB58GDT3j1vJ90MXp6bSYiKsBdDguF8hnSGGcqqAy2ta9gS81/OctWM6uT8Do4vC68fgT0d0yRKTEpinCjuFi2Ak1zjdpyYSUhevgH9Cpy64Qy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6512007)(6506007)(6486002)(26005)(186003)(36756003)(31686004)(83380400001)(110136005)(53546011)(54906003)(66946007)(38100700002)(8676002)(4326008)(66556008)(316002)(8936002)(7416002)(2616005)(2906002)(5660300002)(31696002)(86362001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFCVHQvNTYxWE9iS3hRUUlwcE1HcmdnNXhndDhTaXArNTE4RWtBeUF4d0lp?=
 =?utf-8?B?cXJHc3U0OWJ5NThHc3h0MjBIMXVZM1F6R0c2ZFVGSFBqUmhZV1lvbFpacU9W?=
 =?utf-8?B?MEwyaENUVFZ2Q2tFck9EMHo3M0pTMHMxdnYzRG5TRmJ0cm80cjF6NjVmYjNK?=
 =?utf-8?B?T2ZJWTlJN1Y0Vy9Ra3ZKSHBSRUhBVFQ2dkZ2UFVLZ1RaaUJ4bnU0Y3Nzd3l5?=
 =?utf-8?B?dW5OYzRlUHFnUVZycDVWMm9zZGpxSVhRem5sVXJZdmtGak56Qnhxa1hoVllC?=
 =?utf-8?B?aVV5L3Q2V1dsVXlYK09ZazJTVm5JWWtmTTdzME1YaldLUDRaUnJESEtUeVpJ?=
 =?utf-8?B?bi9uQ0Z1dWRQemp5VFlWamE0STRiY1pwQ2tNTXdvK2ZZNlQweEh2UFF6SFhj?=
 =?utf-8?B?ZDY1T2pPVkFzbHdDUXQ2QXZBMWQ3SEY2K25OUzBNMWM5WXNOSmR5eXJUcDky?=
 =?utf-8?B?ZXl6YWFEM2I5R2dXM2FhK0tzSy8yaHZqV3JmNHBIbFhXSFJlWWw0aGtCd1Iy?=
 =?utf-8?B?OWhiQy9MQ21EK2JsazRXQ0xMMFZmWVF2dTQ4U0xtenl5M0NQQk9rdFN1WWJu?=
 =?utf-8?B?TVcyc2lHSHhqaTZGbmNLNDlHYWxqZDR1bWNqTktMRUJKd3hyZ3lwM292QjJ1?=
 =?utf-8?B?Wk55UDRNVXJGV2ZabmUwTGlsRG9nUVVGK1RPU0ZlYzk3WndRQmZFeEFka2NM?=
 =?utf-8?B?VkFFMVlRL1ZLb09Zc0VJc1ZpaVduMFJ1MVlWOVBtT2xrSzF0MTQ2a05RaHBB?=
 =?utf-8?B?aTJkajBoZ0N2RFBJTXVzNkZ0QU9uSmlKdXRjUlpqRy85UDVYdEVoR0lXQlE0?=
 =?utf-8?B?aEozRXpZUnE0bWZOMytUZ2VtTVdzYnpLQ3hkbnpMQXIxQXdXOExXNlRuN3k0?=
 =?utf-8?B?Q1BjOGJGZlJuQWR3dFRWK1VUZVdEcUFacEpFTTA1L1BlNGFQSW53dk5NQzEw?=
 =?utf-8?B?Z29tOEQvR1ZGNXZnYkRHK05pY04rank2dmVzMzZTSm9jWmhUeUhZRERmZlNn?=
 =?utf-8?B?cFRsazhwbS9kUzBZaCtZMXlFOUEyTGRESmdxRTF3cmhFZW5aYXNwQTNpSXpw?=
 =?utf-8?B?SkgrVFdMVGNlM3YzVjBxYUh0K0JyZzdpcytnNXdhZG9RdVNMUlQzNG85R3dN?=
 =?utf-8?B?QnF0WHlMUHBRdWxoUmdoblJLZkxGSHg3ekduSmJBZzdVc0pNQlcwUWhORlp4?=
 =?utf-8?B?aHJudk5IOWV3NzFUQzZ3QTI0MWJwTG9hWEhoWndINUdZQVk1SGZJdEZYTDRm?=
 =?utf-8?B?N2c0cVhpc1ZPbE4xMTdoSXZXUytRalV4aTRBVmoyd2NZYzBicVk4V2tEQWN6?=
 =?utf-8?B?aVBoSkFrRHlLYk9iWEptalViQTRtdTFMSlRBaXR0RTl5UWVoeklwa25JcmQz?=
 =?utf-8?B?OS9uS0E0bGF1RGt1NkRBMUxtWVZIL1FWM3B6VDAyM2Y3RldFYXU4aWVxMmxZ?=
 =?utf-8?B?UVpnekRIKzVqOG53djZpY01xTlhsNGE3Q3E3YzJKNnNCbmFZMVlHWnRzMmRK?=
 =?utf-8?B?QklBTkhxS3V4TDYrUEtBN3VHWEtxUjQxNm0rZ05VMFo2OEtKUnEySmgrK1Nh?=
 =?utf-8?B?YkNZQ1lnK3dHVWN1S2w0NnZ0ak9aeFBHYS9lbnF4b2dyWnVtMW4vSmdLazY4?=
 =?utf-8?B?MDdUTEFIMmZXanV2dTNrNXFheEJNR0Fkd1dBbHNUOWMrbmx4a1l2NDg3THk1?=
 =?utf-8?B?R2trK3ZSR29XS0NGM2xYc243Z1ZRMUNVallvdk1QMzA1dmg2Q3MrUVd2cEFk?=
 =?utf-8?B?b2J3VlVreWU3MTJTNThrRmlPTUExSUU4OEljUVl0MTA2WFV0WEh2YzJrWGJs?=
 =?utf-8?B?REczSmEvdTBqcWFLU1hsVlhiZ0VDZThDQzl6R0hlZWtvay9EUXl6bG5pV1Rw?=
 =?utf-8?B?VVUwQ3JET2IzeEZsOW1JeWgvSEdJZmpGa1BGZGFvcXpJU3ZKVmFHMGIwRHM1?=
 =?utf-8?B?NXBDTkNVNGlFMy8ycm1tWGpKWDBIeW1BS0ljVjBoNGllcmQwdkRXN3djOElh?=
 =?utf-8?B?TTQ0NGdQUzY3aWlrTHNuUmZnKzc4QkJWRE45blE4Y0hwTlc3RkdZSWVhMkQ3?=
 =?utf-8?B?VWRoNlNVZG5DZUNPQkk3eUJzSHdUQS9nUkZGOHZoTFU0enJ3d05GazBsdGdx?=
 =?utf-8?B?QlpQYVFSZGNNWWE4ZXE0TTlFbWE1dno4M3RCSlp5eXg2akR3cXpXV3NsNzhO?=
 =?utf-8?B?VUsvOXF0QjY4Uk9NcGpWWlcxNnUyN3hsWVdpSnl0TEI4LzVjQUlseU5lQWZ6?=
 =?utf-8?B?NTdhOU1ZeC9OSnVyTUlzN2Jtc2tnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42117663-0c88-4c27-b969-08da0127cd80
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 17:19:29.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3891phWqByaeFxyVMUnZvxDBa6IPRG4PNwNBtLwmBv14kL9dwg7r0EZwpDMUzE0M7sDbNEDsBkFAxdI/nYgPtjzyQjFJPsbgMzl3+DYQld4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4132
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080090
X-Proofpoint-GUID: 3T7wX9Bwj57_clQFllPNtZnZgDi45BIV
X-Proofpoint-ORIG-GUID: 3T7wX9Bwj57_clQFllPNtZnZgDi45BIV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 9:09 PM, Wenchao Hao wrote:
> iscsi_alloc_conn(): alloc and initialize iscsi_cls_conn
> iscsi_add_conn(): expose iscsi_cls_conn to userspace's via sysfs.
> iscsi_remove_conn(): remove iscsi_cls_conn from sysfs
> iscsi_free_conn(): free iscsi_cls_conn
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  drivers/scsi/scsi_transport_iscsi.c | 107 ++++++++++++++++++++++++++++
>  include/scsi/scsi_transport_iscsi.h |   5 ++
>  2 files changed, 112 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
> index 554b6f784223..8e97c6f88359 100644
> --- a/drivers/scsi/scsi_transport_iscsi.c
> +++ b/drivers/scsi/scsi_transport_iscsi.c
> @@ -2340,6 +2340,113 @@ void iscsi_free_session(struct iscsi_cls_session *session)
>  }
>  EXPORT_SYMBOL_GPL(iscsi_free_session);
>  
> +/**
> + * iscsi_alloc_conn - alloc iscsi class connection
> + * @session: iscsi cls session
> + * @dd_size: private driver data size
> + * @cid: connection id
> + *
> + * This can be called from a LLD or iscsi_transport. The connection
> + * is child of the session so cid must be unique for all connections
> + * on the session.
> + *
> + * Since we do not support MCS, cid will normally be zero. In some cases
> + * for software iscsi we could be trying to preallocate a connection struct
> + * in which case there could be two connection structs and cid would be
> + * non-zero.

Is that with the upstream iscsi tools or your version? I don't think the comment
is needed or is needed somewhere else.

If this happens then they will have the same sysfs/device name so when we do the
device_add it will spit an error about duplicate names.


> + */
> +struct iscsi_cls_conn *
> +iscsi_alloc_conn(struct iscsi_cls_session *session, int dd_size, uint32_t cid)
> +{
> +	struct iscsi_transport *transport = session->transport;
> +	struct iscsi_cls_conn *conn;
> +
> +	conn = kzalloc(sizeof(*conn) + dd_size, GFP_KERNEL);
> +	if (!conn)
> +		return NULL;
> +	if (dd_size)
> +		conn->dd_data = &conn[1];
> +
> +	mutex_init(&conn->ep_mutex);
> +	INIT_LIST_HEAD(&conn->conn_list);
> +	INIT_WORK(&conn->cleanup_work, iscsi_cleanup_conn_work_fn);
> +	conn->transport = transport;
> +	conn->cid = cid;
> +	conn->state = ISCSI_CONN_DOWN;
> +
> +	/* this is released in the dev's release function */
> +	if (!get_device(&session->dev))
> +		goto free_conn;
> +
> +	dev_set_name(&conn->dev, "connection%d:%u", session->sid, cid);
> +	device_initialize(&conn->dev);
> +	conn->dev.parent = &session->dev;
> +	conn->dev.release = iscsi_conn_release;
> +
> +	return conn;
> +
> +free_conn:
> +	kfree(conn);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(iscsi_alloc_conn);
> +
> +/**
> + * iscsi_add_conn - add iscsi class connection
> + * @conn: iscsi cls connection
> + *
> + * this would expose iscsi_cls_conn to sysfs, so make sure the related
> + * resources when access sysfs attributes are initialized before calling this.
> + */
> +int iscsi_add_conn(struct iscsi_cls_conn *conn)
> +{
> +	int err;
> +	unsigned long flags;
> +	struct iscsi_cls_session *session = iscsi_dev_to_session(conn->dev.parent);
> +
> +	err = device_add(&conn->dev);
> +	if (err) {
> +		iscsi_cls_session_printk(KERN_ERR, session,
> +					 "could not register connection's dev\n");
> +		put_device(&session->dev);

I would call iscsi_free_conn. instead of put_device.

> +		return err;
> +	}
> +	err = transport_register_device(&conn->dev);
> +	if (err) {
> +		iscsi_cls_session_printk(KERN_ERR, session,
> +					 "could not register transport's dev\n");
> +		device_del(&conn->dev);
> +		put_device(&session->dev);


Is for the get_device(&session->dev) in iscsi_alloc_conn? If so you don't need to
do it because when the last put is done on the conn->dev, it will call
iscsi_conn_release which does the put on the session when it does "put_device(parent).

Or did you mean to call put_device on the conn->dev?

I would do device_el(&conn->dev) then do a goto free_conn at the bottom which
does iscsi_free_conn. The place above should do the goto as well.


> +		return err;
> +	}
> +
> +	spin_lock_irqsave(&connlock, flags);
> +	list_add(&conn->conn_list, &connlist);
> +	spin_unlock_irqrestore(&connlock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iscsi_add_conn);
> +
> +/**
> + * iscsi_remove_conn - remove iscsi class connection from sysfs
> + * @conn: iscsi cls connection
> + *
> + * this would remove iscsi_cls_conn from sysfs, and wait for previous
> + * read/write of iscsi_cls_conn's attributes in sysfs finishing
> + */
> +void iscsi_remove_conn(struct iscsi_cls_conn *conn)
> +{
> +	device_del(&conn->dev);

This should have the guts of iscsi_destroy_conn which reverses what
the iscsi_add_conn did:

        spin_lock_irqsave(&connlock, flags);
        list_del(&conn->conn_list);
        spin_unlock_irqrestore(&connlock, flags);

        transport_unregister_device(&conn->dev);

	device_del(&conn->dev).

You can then kill iscsi_destroy_conn.


> +}
> +EXPORT_SYMBOL_GPL(iscsi_remove_conn);
> +
> +void iscsi_free_conn(struct iscsi_cls_conn *conn)
> +{
> +	put_device(&conn->dev);
> +}
> +EXPORT_SYMBOL_GPL(iscsi_free_conn);

Sorry I made a mistake with this suggestion. Kill this and just have
the user do iscsi_put_conn.


> +
>  /**
>   * iscsi_create_conn - create iscsi class connection
>   * @session: iscsi cls session
> diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
> index c5d7810fd792..346f65bc3861 100644
> --- a/include/scsi/scsi_transport_iscsi.h
> +++ b/include/scsi/scsi_transport_iscsi.h
> @@ -441,6 +441,11 @@ extern struct iscsi_cls_session *iscsi_create_session(struct Scsi_Host *shost,
>  						unsigned int target_id);
>  extern void iscsi_remove_session(struct iscsi_cls_session *session);
>  extern void iscsi_free_session(struct iscsi_cls_session *session);
> +extern struct iscsi_cls_conn *iscsi_alloc_conn(struct iscsi_cls_session *sess,
> +						int dd_size, uint32_t cid);
> +extern int iscsi_add_conn(struct iscsi_cls_conn *conn);
> +extern void iscsi_remove_conn(struct iscsi_cls_conn *conn);
> +extern void iscsi_free_conn(struct iscsi_cls_conn *conn);
>  extern struct iscsi_cls_conn *iscsi_create_conn(struct iscsi_cls_session *sess,
>  						int dd_size, uint32_t cid);
>  extern void iscsi_put_conn(struct iscsi_cls_conn *conn);

