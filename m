Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B88E4D3A86
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbiCITpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbiCITpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:45:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4ACD31FA;
        Wed,  9 Mar 2022 11:44:36 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229JOksk017381;
        Wed, 9 Mar 2022 19:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CHo2XS6oMCg+M6GfowRK0h0ayzk+z/m5t6cqnhIT4M0=;
 b=YPz3Cgfro3SshC3Csq3QnrjquaCe3uvDju6mBtPfODsZC4i5vvtDkNciTvHcQ10GD6wa
 JWRXwVgwzMQfnLMv3CBgJLZzJrlwMJ1V2deZlecMmcURr+63b2AYOStuJiMBZTHBooNR
 sZjzKSNe6pMUyKvJYtifDoVlEe6Hz3pTeWsqno0VEA36kPlTmEI7CpksldKeFLye+hyn
 IqlK0UcETErO6tRnRk2iR12dDzu6jUK//lAXK0YTvqDaoxreRJflCiUBdh0NiXbISdA3
 JOktBaFK/6ZXRWJ1z+BU+Gsyg0QVjp8EddWP3UzGDDDOPQ42bnhVx379DEL4HY/IwDBi Sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3em0du3ajf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 19:44:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229JRMIk191511;
        Wed, 9 Mar 2022 19:44:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by aserp3020.oracle.com with ESMTP id 3ekyp34vc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 19:44:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7j7rdWG/vZCsvW9VLUOEswRgzg3uGVeI22knGlN6IATFPVePdrYWUHQRvH/oQiDcE4w+l3c2a56sulVBLFMpP2WfPaH63kk+3dkNeKi8XLUmgj5J2ZaIdifEzPgjwJaOEywg3bS8LPDSwDpSEga/OTgh4sK1hXAjSLCWopvIysLdofrZMyr+cxONh8Km94qtTbIOp6C4W2x1uPOKRwjdCUhfcmBxESRF8zX8NdZmxCMwAHryP7iVjKvpH/r3w8E4097z4KyoOl0WSXwHZSzoUABjANPGN8+pHoob/T1vA9tWjdNm5t0mRraRIW4y+rThmcLuEOg4aNnI5weA7h32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHo2XS6oMCg+M6GfowRK0h0ayzk+z/m5t6cqnhIT4M0=;
 b=V7ApwNnk/RMWTBkTqesMciH9sQJPOfMr8CPwLAPizW6+cdTBmHVxWzhgKne8qExmpI3t6b8hft40+5fycN8vlNqD3JMOwPGY3IH2CPtp3qwevBPLySOa2Jviv91nCzoq+ueLwskkUT1TPWCLkgzsqnvnDERtjF9iOdet5jkoZcTHM4XgKsCsodmuvo7nqHUNOof1lt/28BafBC0zsQCOWV4HOhHB7BwN6IMf6R004NLc71kyHnBWNYWTw4Ju3MofAMn40lAAF7cVJQo0YYpNwBZKlq3d1Jrh6lDyLcs6dmTxrCMuIDiCL5ptio6ej9Y+csFYRgX3ULCUdmASech/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHo2XS6oMCg+M6GfowRK0h0ayzk+z/m5t6cqnhIT4M0=;
 b=rnAJ0MDkiFVxpR5LSFEASXLYJ8R67hcYYvr5SWd8KXwKWqetpbgSXYxn9f/5lx/UKJtX33+I1c9borQv/c9qmqTchJu8XgM9cJfMWQ+hyIQMowwZqHZUYTxxhgot+whP51yrX9wtCYFP1gJjCknMZo5Elm2QuOeEfJhK1+wK/OE=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CH0PR10MB4986.namprd10.prod.outlook.com (2603:10b6:610:c7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 9 Mar 2022 19:44:15 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2%12]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 19:44:15 +0000
Message-ID: <823b30ce-c95e-4fc4-e634-f49c4433bcc9@oracle.com>
Date:   Wed, 9 Mar 2022 13:44:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 0/3] scsi:iscsi: handle iscsi_cls_conn device with
 sysfs correctly
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        linfeilong@huawei.com
References: <20220310015759.3296841-1-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20220310015759.3296841-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM3PR12CA0137.namprd12.prod.outlook.com
 (2603:10b6:0:51::33) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc6b8ba1-1fe0-4444-ab1f-08da0205314f
X-MS-TrafficTypeDiagnostic: CH0PR10MB4986:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB4986295B6D63B22BE1631B88F10A9@CH0PR10MB4986.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68kt/fLSujDRWvY4eoLri4AhB4Yf9pknL0WBmC7ZUjgo9WZMgDBDSHh3qsgdeKUdcshdDjEDSYYelzjpRe7Icb25vgv/aFzqqWML0ejvILTmAB2yVhGmmVXaQCjN7FCQvgXodC/DW4I8W5z4t8EtlDyVz4OF2Nh2SlD/fdT0lUcYgvaNDsKYA9V9vJSqhLdU66KgzuCbJ9t4MoVzBkcYDvb/LG7Pubn6LVWyIXNLwbvJ9RI4m74xQq0uKR3RoRp1cIDEZz/go24ddkZmVHTEN3fsESuR6xxOGlhS1MZ63vlMddNgcq9E+ZACAQHGZ3GnfiNASWYKSDv+nJ2KFbNBjPd9YEruqHBHpD9QK/LKOMRZ2qZiBTunyi/G/B7sQWPT08+9TFpZ1suH2u/pc6YRo/gKD6ogoP+yn5vQgABsuKPODt81ArPH+8pffJTP+ZS4NaFAHziGBmZT0gePXT8GlhNqaA0Wwkt7Wds8xPF8UxYhDi0xPWqcoZUrmkOeHghiKntMgYVDAY3MWGGyqIkrw71xpiNL5/hPEk6Oy77QNROf2DC5yGNxlk2/AJ7OjPbRbWWuuz4et9yNF+fu+dwXEdt+X+VgLMN9N97Zj3NcpqVZVtDukkdvxaHy9tg8f8TGoqD2W0shVeVgeMq+e/36yBs5dO6JJZz8FwxeSfpo+OTD9exB9zCht4xUgU7XKUQS1The9gujIxrdmnvDR9rN9cqJYD11GVFXrPROUDis8n6NZr0G5m3tH68sWbMNqgSj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(508600001)(66476007)(6512007)(38100700002)(2616005)(7416002)(53546011)(186003)(26005)(83380400001)(6506007)(8936002)(31696002)(36756003)(316002)(54906003)(110136005)(31686004)(6486002)(4326008)(66556008)(8676002)(86362001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnh1RkdUMVNOdGMwVldsOFpMNE5aVld4K09wc3NyL1lBVjlvYVZSemY2S1FS?=
 =?utf-8?B?OUl3dTl5SHBQU3h1Um85d29qNS9mTkFpNncvYnR2cFVpY3lmZTB0RUR0Mksw?=
 =?utf-8?B?eXNKNkdoUWxrMDBxSFB4N0xjTXRqNkFBaFZ5RFRjZTNtcVcyeVB1SVlza01C?=
 =?utf-8?B?SFFqUVNIR1pHQkV3bWF3Um5HZ0ZlOEgyQ3J4U2lPUjVMWGIyUk5NYkhKY21J?=
 =?utf-8?B?MzBBRlVjZFdQdWM2U083QjFaN3M2ZkNPQmVzUXArWGhwbjBITUgzL29tbFBT?=
 =?utf-8?B?c0pkRlZYMGxPTFNCMWNjdUZyS3kxdFByYTY1UTd0U2t0S0FzQ1B2QndObTd1?=
 =?utf-8?B?T3Y3cHZTODVRVWNzU1NTdnRqeGxpSXdCRkhIc2MwZk5lZ29CQTBJUHEzcWZY?=
 =?utf-8?B?UktJUHZqVEgwWXV4UVhTWGNTdGg2WjJSbW5pMFRrQkFpVUZnaWwrd002Mkdn?=
 =?utf-8?B?bW96UitjNHEvVzdoUk9Wc0pKeElGT1lpWlNzS0lyQ1hRcDJYQ2VQbE1YY2ht?=
 =?utf-8?B?V1VCK3FWWmpMUUwzNVM2Y2hCRDVEOEUzVkRGSEovd3VhRHRYaXQwVXRkR0c3?=
 =?utf-8?B?K3Y5K3NHVGQzWm5vZnNvZTJLNnAzYUtsUTUvV29mWWdSTGNDaFhEd0hwSGta?=
 =?utf-8?B?alZwb1hXMHUwMW5Scyt5T2daYys1M01mZmNGT2k0SVM4SmpIaU5QRGJlL3c3?=
 =?utf-8?B?bTdMOFhwTWtPa1paYlZJZmprdWNaTFZVbHdLWDB2QkJjZFJ1OS9UR0t0WExD?=
 =?utf-8?B?U2pGQWlDa0ovSGcxQ1V1NU1HUE10dERROXBCSCtQUys5bENJQnlFMDdUYUEy?=
 =?utf-8?B?VFdpTlNIV0JQa0JUcWVBaFBOeTRaeUF6Q3pORXhzZVlYUU1zWHNEQmJBU0Np?=
 =?utf-8?B?OG5NUTJwVmt3ZE4yTDZTdHBZUWdxR1IxQjZoaEY3ZE13MXFPQ0lOcU1Wb25N?=
 =?utf-8?B?YldqbHpXTTJ6eW5aNTVtQVRaVXgyNVRzSG0wUHVUNm42SFlHblVUcTBPeDla?=
 =?utf-8?B?WGJQS3QvbEVHUkh0YmpUbklmakNiZFFFdWhXK0pBaW13d2MrbWF0eGd6OC9N?=
 =?utf-8?B?ZWtvZ1c3cmxKYlpDOFdOYUNUQVFIcUp5c2tta2QwZTBkTnlldFkwQzVvbHdM?=
 =?utf-8?B?NTNuWDFNMWd6N1J4Tk9NL2xLdGhRVjMwa3lZd3F0YjRraXFPSG9nNWNOZjlT?=
 =?utf-8?B?enB6bWh3VXhlcFpBVllTMnNNbHBSOXRkT0RUaVk2YVNmZkpXTGJBbVQvUElC?=
 =?utf-8?B?OG93SXcvWDhZeE1tdVFpRnZEd3F6b2VtZWl5cGNZcmUxdmtjOVJxWGd5VjdZ?=
 =?utf-8?B?em16dXF0a01WSDR3WDBueTA4aUZZT2hIeGxaSlkyS1A3VGhvdmRVVHBDclJi?=
 =?utf-8?B?eFprUEo5MkxkamJycVhuRUIzaTJadFlKd0tFbkxYcUovcnhvQzBYRW5KNFZt?=
 =?utf-8?B?aXJDRzFtT2lrM2NMOXgxNld1Q2NoM2srSGNyUkM1dUxVbXVrVHY4R20wLzg5?=
 =?utf-8?B?U0owbGYxUy9WSW1wSEFHOVVoQ3N4VXljZTl1V29ZdFF0b1Bna1BjZnBaSWN6?=
 =?utf-8?B?ZGQ2dzZCWWQvSUp3TUJUc0FYQldNMTNDc3VLbDRkRExLeU5ocWJITTd2bXJO?=
 =?utf-8?B?Ty9nUGVrelh1eEtxd0c4Q1RPMFJGaXdIeU9VK05FY0lWblZMSkJjc2tIWTJv?=
 =?utf-8?B?K3B0dDdOM1VUNDRSSzR0bm5jTXNlNlBwQWd5b3FrNXozZGIrYTZpUVBsd2tp?=
 =?utf-8?B?Y3MrcHNZN0RhV3ZaTjdUdUNYMFV3dDRic0Q0aDUyTkw0ZGtjak9QOHdrRnd2?=
 =?utf-8?B?V2pyWEk1bm1DMEo5Sm1zODZuR056Rkpydm53RG83Vk1sazBHZW5GOHgrTVND?=
 =?utf-8?B?d0lJSFZMZ0hJTmUxNk9iZWpRZnpjSG5VK2J0Qm9Kd0p3VWU4ZTVEL1ZDdWtN?=
 =?utf-8?B?NnNsNGpSaC83dXVwYzVLQURLWHN5RWk0WDEzbkR2d1V4S2dYaUtMcW1saWRr?=
 =?utf-8?B?MlBJU0U2WTVSSlczYVRGcXVnbG5hQWpoc1J5UUY0eUJnd21qKy9JZmhRSHNU?=
 =?utf-8?B?a0ZSUmlrNEowd3F0d0tab3ZlY2FkeUVpb0FodTlPZzRQQWIvYWVSWVBTcm1I?=
 =?utf-8?B?VC9GWVNhYUMvakV5MVdIeEpOMnprbzI5cDh2MzM3c1BlL1dXYkhrNEc3ZFZu?=
 =?utf-8?B?c04yZFZwcXJyR2VxQ3ZkaitnYUdHVHdsSmFrc3BMNEpud0wvV0dtbFljdk43?=
 =?utf-8?B?d3hXQ2ZpMmZ4d05nR2VSOFJzMTlnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6b8ba1-1fe0-4444-ab1f-08da0205314f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 19:44:15.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERdhnNtlz8JQV92yG6gH2H56Psnpupt3bUJfEzbP2CChROlaw/tBAXyt1S4qN+ZF3L0gDYAQNOAtZ/ugmymixEieiDQvwir2wwQBvFa2cyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4986
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090104
X-Proofpoint-ORIG-GUID: T49dovCJ4EFS3ebarIk4qbYZugSHhwF-
X-Proofpoint-GUID: T49dovCJ4EFS3ebarIk4qbYZugSHhwF-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 7:57 PM, Wenchao Hao wrote:
> We found a NULL pointer dereference in iscsi_sw_tcp_conn_get_param(),
> the root reason is we did sysfs addition wrong.
> 
> The origin implement do device setup in iscsi_create_conn() which
> bind the alloc/init and add in one function; do device teardown in
> iscsi_destroy_conn() which bind remove and free in one function.
> 
> This implement makes it impossible to initialize resources of device
> before add it to sysfs during setup.
> 
> So this patchset splict both the setup and teradown of iscsi_cls_conn to
> 2 steps.
> 
> For setup flow, we should call iscsi_alloc_conn() and initialize some
> resources, then call iscsi_add_conn().
> 
> For teradown flow, we should call iscsi_remove_conn() to remove device
> and free resources which related to iscsi_cls_conn, then call
> iscsi_put_conn() to free iscsi_cls_conn.
> 
> V2 -> V3:
>   * Fix some bugs and optimization the code implement.
> 
> V1 -> V2:
>   * add two more iscsi_free_conn() and iscsi_remove_conn() than V1
>   * change the teardown flow of iscsi_cls_conn
> 
> Wenchao Hao (3):
>   scsi: iscsi: Add helper functions to manage iscsi_cls_conn
>   scsi:libiscsi: Add iscsi_cls_conn to sysfs after been initialized
>   scsi:libiscsi: teradown iscsi_cls_conn gracefully
> 
>  drivers/scsi/libiscsi.c             | 23 +++++---
>  drivers/scsi/scsi_transport_iscsi.c | 90 +++++++++++++++--------------
>  include/scsi/scsi_transport_iscsi.h |  5 +-
>  3 files changed, 66 insertions(+), 52 deletions(-)
> 

Nice. Thanks.

Reviewed-by: Mike Christie <michael.christie@oracle.com>
