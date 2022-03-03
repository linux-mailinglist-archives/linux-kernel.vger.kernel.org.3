Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB64CC07D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiCCPA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiCCPAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:00:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63210DE2F8;
        Thu,  3 Mar 2022 06:59:34 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223C094w028870;
        Thu, 3 Mar 2022 14:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NdTOJvEPuVWz7NT6CQ3oHJj3AAdJcYuXcEu5GoiwbKU=;
 b=k2A4DJsEBFtW3PwiWhpsJCQf6D42beL8wZxEMtc0/3R+T3MBDurjyRzxqqAsVqGV/nxk
 E+960Zgb8YzjO+Hg8Os/Qg18yqzuV1pttYX9ejYkG+baRV7MNDsUHCbdMGNKR8zlEtXX
 tPbSg2Iq9bSVgwx5iahnlPVSsRUFQeHwOF+Pm31J4yg5cy7010NannFIPW/9XhMnXWgw
 lIkNGq+TRPgqazIdDPhiZyhDYWVVjzjG3l+Gz3Jot6bRFd194g7kEb2Dp6xJkX/t18iS
 7DD4fEKR97o0bhZ7F3oSprZFGvqJVLK+XvOVx/OKJNXWNTGEns14Hm3KZ8M9iIBo63yv mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh14c1376-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 14:59:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223Eu7aO164498;
        Thu, 3 Mar 2022 14:59:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3030.oracle.com with ESMTP id 3ef9b3k7yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 14:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGDuo4xppngLzfmyrBY3RtbpHfqwbOJBLmmxNViiNiiCfr/9wDuX3cREPE1v//2V6In9CYdp9Sieq90H+s3pOOO2Kg6ObBll6hyOpeJNfB8TPc20BIEIh7F89+VcmMoqsyRRtHr4aAa/0dr535EyWh+0/9GHUvWU3d6LU1b8UiwL7alnNDvYGmy9l1gF1b8WQ9RBnJdweFeJUdwlkreM4x+MvZwKVkS4jjUmUS2BO17o6DSsjRXl3eGMnHDJPs8w9OtLe8XvsPfiaJSugf3nBxx7u2E2Hq/iHL2G0b88fS022B6p4gnPLJUdNIuwQbECEHKdJHLExLEYnF9F4pPxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdTOJvEPuVWz7NT6CQ3oHJj3AAdJcYuXcEu5GoiwbKU=;
 b=J/s60wyLMX4vEfk0lgvpRr7QyfooYiStB4hG67Gm8Z6PATPvFEs4xGjaa9umXC4M5DdAgBA8axhN89Nq9wTenhl+NtPx4rrlq1kGS1nCxidYxmvdiSCS6euYyjX4meHqN+rJQb3C11w/cM36Yz9sw5HDSqkOy2u5/EaHZpkX56Rf2lbSPELR1xhrG0Bvv+a7F8nvl9rvgLw34QvRhUIPBcrBaoJ+cArs5KQS6YxF3cTLK2rsN3s2/FLz87cM1E/xutQshBDeJAphQ3yVOiyMTcBBd9rDYTbD935ccJToWw9kgyiet+Pv2IS+MAjU+zIUnt0VsUDqX77A2WPE/dtygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdTOJvEPuVWz7NT6CQ3oHJj3AAdJcYuXcEu5GoiwbKU=;
 b=WuwEY2PIgUJ3tFK0T2YZAB7uuDwU1YX+1rhyTrv6+zWVEMKXNqZWOvs/u1hpAWyYCHNXBxu0h1o1ZGgg5qaGxqnvVAzGdWoUZSpCY7ewGQKvA0dT79OaH1GtWXqrtDjXfUldQPfs7/7pHV+uvYmJc3ujpyxtbeSA5HwYD/3wUZ0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB2811.namprd10.prod.outlook.com (2603:10b6:5:61::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Thu, 3 Mar 2022 14:59:08 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2%12]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 14:59:08 +0000
Message-ID: <85a64450-99c8-268d-1ac7-86e70cbb3562@oracle.com>
Date:   Thu, 3 Mar 2022 08:59:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] iscsi_tcp: Check if tcp_conn is valid in
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        linfeilong@huawei.com
References: <20220304025608.1874516-1-haowenchao@huawei.com>
 <20220304025608.1874516-2-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20220304025608.1874516-2-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:4:ad::48) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d8a0adc-e33c-4519-dbf6-08d9fd265e69
X-MS-TrafficTypeDiagnostic: DM6PR10MB2811:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB281172971BDE0C13CC3B3F4BF1049@DM6PR10MB2811.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/18VjN8mSy1R5sEZzUJsGJWFzb2EGhzastWLlxL0M+XWlkT5I6MNOCLk3DYNvIj+/Zas5M/WwWuRnciwVjer4+Cf4sgy/o0xwdDTY06WneDEhQjUh7oaC+mk8ON6EVat7oZatJoTIQU6RQCTHduWUe0RmYmzW1cUrHkgjzcXNp0juMkRERZR+wMEutl1rA7OBvOGSYvGe5OBoE2n8zk3O4LxoHGAMx5y+AljzG2EJH3FvK4fPIMzxIXbfi9YdOB7GAFNgBYurWaTaJb/iCahLC5bdM93KcH4F7Je6XkAykujudTpUGns9Ly8LBttMT2EoNKPE9KXDxm2WWASFNbL5L5OHBk7T8Kd5Cq3JvOb6anW7nHguANEl7bD9EhQdJ7ROzHA4D4KE3Jl/NLytKuTgu1r9FbFgrKiK20JDp0VWWt26fZ7taBJteoQAGwnw2Hbz88JTXTteN3dgZzkWjm0CxVUU1EEH1rDbPUppayIZnl73ljq6QxN2ow4PMMLP7jpcXPWKjEacHHYVJn5IO3AXgvAegtV2XNg7mTlJjfILZC9zAcSYoGbbnbrQyCVxF1KoWZaUDxOXFg888bZdgJzuiXoA6Dim0quR9+IKqM4dnTPh4Bzc7tEbcT7jEqR9DZX5RvrYWsjKY/+81ZpCZbdYNcnvjdRU/0pBB7XMdF0vGnOGcbpoTkFJLKmEmhlyhohUzDV+8+qSEWzAj3PYBjiTkjVOJNP3qBbvCPc/chi/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(31686004)(316002)(83380400001)(8936002)(86362001)(6486002)(54906003)(36756003)(31696002)(26005)(186003)(7416002)(6506007)(2616005)(5660300002)(38100700002)(66946007)(4326008)(508600001)(66476007)(66556008)(8676002)(2906002)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2V3S2l6eTJXKzZHMXBuVTdqcWw5NGVIWFBwSWhkb2ptdWwrVjdFZERrWk1I?=
 =?utf-8?B?NE9KOGI2bDNtOFVsRzVJU3VESGRoWDhpZW9OZ093WDl1b2tRcStNVmVUTXQz?=
 =?utf-8?B?d2FmVmVFS2cxUnhuejd2WVFBL3FjYTNEWkVyVkVkbTd3cUg3Nng0VDB6M05p?=
 =?utf-8?B?OWV1RWpxVXRZWC9wK21JTC9vSzhlNlBUeXZOUUdsd0VVQXF4cXdDdS81L2ZM?=
 =?utf-8?B?TGdBUXNsbmJ5M1V2RU9qb0E1OUprQnN6NUtocWlIR2xrK2NxVm9yQkd4R0cv?=
 =?utf-8?B?eldQUS9SV2huSjBRMTZkZG1obTlGeUgwOUJqTllPOWwwcGZSeW1OMnRCb3My?=
 =?utf-8?B?VHhTTGlwcGF6dVNzV1l6S1o0cklYKzlRaENMaU5XZFkyV1JsOFlhWDEyMUd1?=
 =?utf-8?B?d3pXWjVLWkVOczJaNDI5dUpXL29BaEgyZGJ1RVdOZFFsQmpxbWo4T1hXb3lx?=
 =?utf-8?B?Y3J1N1c4Ri9odkFjdy95YzlRQVhDVHFBQUVFdWN6bXpYbDU4ZE5jcEsybHBa?=
 =?utf-8?B?clVIOWViVm1iVU9mNnRxL1o2NHdTL00vd29sNHZjSzUvSEdtT2tIbGFnTmti?=
 =?utf-8?B?UWR6UDV0SzBCcnE4T1JYOWZHSXNYUjFaSWNLWk90Q1N5RUpCTnZnVGVEL1VI?=
 =?utf-8?B?QmswUUJacTZRMm9YM2locStZMWsyaFVQWmtLbStyVjRIczJrV2pCdGx3cUt5?=
 =?utf-8?B?dFk3bXVLN1RrdkFoR1IvQTZ3T2lhRk1RaUpCRmZsMTdjZ3pScldraVhreDdz?=
 =?utf-8?B?TkVxL1pZeVJ0OHo1Wkt2RVRLbG42Q0dESTJ4V3MydU1sbzZCNTZrRUNZQlVx?=
 =?utf-8?B?OFJQOVFjZWpRWG9MNnVTRzZ2WWhBWExwdFFaVlhvUmdsYjhEUHY4TUZ4YUVk?=
 =?utf-8?B?bzZndVJ2M0ZPb2pZQzZRcVQrWXpNK2pzVWpJeEFXNWt4b2dpSHZidWt1M1lD?=
 =?utf-8?B?dkQzdnVGTEhFQ0JzaWJITmlOSzk5bTRidGxXRVp1VUllOU1KbzhabUJOOGFJ?=
 =?utf-8?B?RVV2dHpDY0FaeEVNZFVxVHMyK1lyZlp0Nm4wQnpNTHMxZjVRWnhkWTczT2kx?=
 =?utf-8?B?SWdLbVpqcTY1bVVVRFZKbWp1YVY4a2Jpd0VmaXN4RzFqcVFGWEhGTXZ1dVNI?=
 =?utf-8?B?eWJMZ1JaSGdmMHVvcWtXUExSYUhERHR1bm95K2FSb2d2aE4yY1hXdGd1elV2?=
 =?utf-8?B?TUR4bnJNa1crUkZ3WTJSekFzbG5TRU1lR3ZpTy9OVklQQUozZEkveXpZUFl5?=
 =?utf-8?B?b2QvaUhyQi9uVlkvQXU3MzZjMUdybWlwS0VCUVh4aGF3UVh5L25VTWZFY2lH?=
 =?utf-8?B?UG5jd3JRRlJ2Z1QwZXlsUzZSQkIxOG1TMGhoMGNBOGZEUnVxOEtiMjhOYUth?=
 =?utf-8?B?VW1kN2N5QUd2Wm55aGxCOXdTVC9qWnVZdlF4UEFNWjJROHMyYWVSNWNHcm9y?=
 =?utf-8?B?MnJXOEhEOHNBdE5kc3RJTndHUEdtdUFCdFRvVEJ2WElzN0F3TktJY0xUY1lC?=
 =?utf-8?B?OThXZXlVNlRTbG9rYVVMUEYxWFR6Qkcra1JZQUtVWUtBTnNoWEFzL2tBeG9U?=
 =?utf-8?B?ekNxVWIrbXFjcGtZYkJaSy93QXNQNmhCR1Q3VzdMM3NHTnpBZFp0YkFyWSty?=
 =?utf-8?B?OWhBOXZPRGhDN0lTdE9odG9nd1VKbENZYk13UE5KclQ4WjF2Q1FueExNTEJX?=
 =?utf-8?B?RTB3V0QvaHFjdU1QeFo1YkxwRnlxa1VlcGQ1QVlRdVlWWUY2ZlhHL0ltaUxW?=
 =?utf-8?B?UGhmUjh6a01FUmtUdGhBbGJ0R3Z3UGRXNW13Z0l6OG5GQzJ4RUN1TEpveDlY?=
 =?utf-8?B?MHFFc25ZT1Z3RS9oemFGd0pUOFMxczEwUVZlQU5MZEREM2h0dEJLdDdFU1FB?=
 =?utf-8?B?YjJ0TjBYdlZ2QTdpeFBiekJXYStkRmlxdGl2UCtlM2UrMDZqaitYbTdHamxM?=
 =?utf-8?B?MnI0K0NIWHZ0TUw1d2ltOUpSOTlxOEdreUYxQjRaUVFnUXBBa01PajUvQjQx?=
 =?utf-8?B?alNRRnE5dFV2aWJwV1BMQ3Z6cnZ6UkROQzBBVmdwOHowRW83LzBQb05WY0Y1?=
 =?utf-8?B?MU0wRnhSRDJ3dmF0SDRXQ2IwdGhZWEpXbFBwcERYQnpaSm9qSHg1VjhIUEZy?=
 =?utf-8?B?TC83L0pFY1B0YlY1MVZSU3BYdjdFYWhVL2pMcG8zMkRGK2swdklEaTlObVBJ?=
 =?utf-8?B?Nlo5YSt5VUpnTHpOY0ZSMTd6djJNTHhQWVRDMmU4S2FNSUlaMjZPMW9IRm1z?=
 =?utf-8?B?dUZTNUwvdTV0cXpJdk42VnlQS093PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8a0adc-e33c-4519-dbf6-08d9fd265e69
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 14:59:08.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pa8ucy6G4b2A+xAutUytPd3Beoc7AdcHmMbyeEg5NZPrY9v84EM70u+Ms1s89B17Tj/JkOZq5/sM+vIdQMa9Cj7Pdjxo1jtiOaHhBbm36L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2811
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030072
X-Proofpoint-GUID: QBmCLm0Op-ixg7FgvjCo84tk_Bq9UHIf
X-Proofpoint-ORIG-GUID: QBmCLm0Op-ixg7FgvjCo84tk_Bq9UHIf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/22 8:56 PM, Wenchao Hao wrote:
> iscsi_create_conn() would add newly alloced iscsi_cls_conn to connlist,
> it means when userspace sends ISCSI_UEVENT_SET_PARAM, iscsi_conn_lookup()
> would found this iscsi_cls_conn and call the set_param callback which is
> iscsi_sw_tcp_conn_set_param(). While the iscsi_conn's dd_data might not
> been initialized.
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  drivers/scsi/iscsi_tcp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> index 14db224486be..a42449df6156 100644
> --- a/drivers/scsi/iscsi_tcp.c
> +++ b/drivers/scsi/iscsi_tcp.c
> @@ -716,13 +716,17 @@ static int iscsi_sw_tcp_conn_set_param(struct iscsi_cls_conn *cls_conn,
>  {
>  	struct iscsi_conn *conn = cls_conn->dd_data;
>  	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
> -	struct iscsi_sw_tcp_conn *tcp_sw_conn = tcp_conn->dd_data;
> +	struct iscsi_sw_tcp_conn *tcp_sw_conn;
>  
>  	switch(param) {
>  	case ISCSI_PARAM_HDRDGST_EN:
>  		iscsi_set_param(cls_conn, param, buf, buflen);
>  		break;
>  	case ISCSI_PARAM_DATADGST_EN:
> +		if (!tcp_conn || !tcp_conn->dd_data)
> +			return -ENOTCONN;
> +
> +		tcp_sw_conn = tcp_conn->dd_data;
>  		iscsi_set_param(cls_conn, param, buf, buflen);
>  		tcp_sw_conn->sendpage = conn->datadgst_en ?
>  			sock_no_sendpage : tcp_sw_conn->sock->ops->sendpage;

Is this something you hit or from code review?

We have those state checks:

if ((conn->state == ISCSI_CONN_BOUND) ||
    (conn->state == ISCSI_CONN_UP)) {
	err = transport->set_param(conn, ev->u.set_param.param,

so we don't call set_param until after we have bound the
connection which will be after ISCSI_UEVENT_CREATE_CONN has returned.

Also for this specific bug iscsi_if_recv_msg is called with the
rx_queue_mutex, so set_param can only be called after the
ISCSI_UEVENT_CREATE_CONN cmd has returned.
