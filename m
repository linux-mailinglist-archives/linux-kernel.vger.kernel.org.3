Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6794EB2E0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbiC2RpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiC2RpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:45:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E685F267
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:43:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TFxfAF028437;
        Tue, 29 Mar 2022 17:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rnXO412ARWRumlhH1k9RNEi/7bi9lDDPKNyrqE2c1rc=;
 b=xeGrOvhQRcuOA68gM4ACbDJggZtKae7vG3YTASAH63eQrhUof1609Bzrqm1qJAa2ywj3
 RJj1x8viy2TekCZkss2PyjAEjDq2PxtVNP4OK9YpN1F5xcwVd1ALhqo/qH/OlfqO37wm
 5V9HzWqaLVJTsZLTBVgWfMt8eml8OsTKTqIrm/HJtaz3Dn1xPh6Zs0LKVZW9cyuBKXwy
 zMaJyplre0TdGkPpf+oLPT4/n094x0xrty7OsLVClLXbs/nw5hKFYgCambRDCjqVtvDQ
 cNbxXa5s0klADRMFJ9HBrxo+2BUKv/Vu6pYO+GyM3ZD4BE3z7iawPMkgNhv/IUEvbiJx Gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqb777w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 17:43:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22THbY4Z188452;
        Tue, 29 Mar 2022 17:43:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3030.oracle.com with ESMTP id 3f1qxqfbty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 17:43:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTcIOEHMO+qpfnDfHP56ZZM1oGQ2RKvWpLAPau3PgMzvFVaIirj2D8e9BGm2MR/Qa5iU482GNAXCN2x/7DTlrWhDVf3TqQOzOefrc20ZKoQzWYAk+cvHEWUKiM4H4gzxQ06zq/q+3jlmtxa4CZvvmkybtm8x1a64FNBOgqyo/5p88KZODkRBCOZV0Kk698+MROjCKrroLtrb2hGMw/hTl/AMkaXhK83G2yXM5F6s9To5jhqF1ajF4pYGcszwFCsu6+PqitVUV5o/DNeuwM6ycmEltirH/TVT3ilYsvW3vSC1Bj2Hymj3j2Uw5UPPqqgsLYqfFfXLCLjLcHU2ub9Caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnXO412ARWRumlhH1k9RNEi/7bi9lDDPKNyrqE2c1rc=;
 b=ZwJnw+ZY4xAYkgYebRmhypS0spXZDiPZmiz1zYeWxix4UgROKsSOmx7rBQdjRE/gctDETkLx0mnA/dGrQJEado+aQtSyoCDQd6k9CyFqRCB8S1EVFDfAsednlfyGZDUJMFLJAzBCCkhAF7Gq5wBZ7O170DwDlxNaVm/0yWJp+SjrKCWl53+wUcLHbQKbTakSR6UPgu6bHLswnUEaza+9PxqsvlKVJD8xNdYo55q1AxVFN5LEsLgL+xRr6QMhx6PeXSZxJgKf7E1qHjlhl4Jhbvlb3cK5SK4Rb83NrhqPJfv7qlfqfiReOileIOhqS/mdtkPhYUpNjoBRT/4fTuqqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnXO412ARWRumlhH1k9RNEi/7bi9lDDPKNyrqE2c1rc=;
 b=TlnTQDRst0XHH/8irWe1Ty7DLNHj0Ilj+FtW5/7lDEF3rNVz1QF8JfnM27aYqLr/4KnZH3wdt4boxcaVWEdmyxeOOx4XZkQkln0xOhVJ2JRyaAjo+fUX5Ch7ZsS91NTGnAESnXq5cKA+3/i3nXVxIptGPj5NCH8OXgnK+ne8fyA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB3418.namprd10.prod.outlook.com (2603:10b6:5:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Tue, 29 Mar
 2022 17:43:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%9]) with mapi id 15.20.5123.018; Tue, 29 Mar 2022
 17:43:12 +0000
Message-ID: <c33ab0c1-6b73-2489-efab-972c8d7fa80b@oracle.com>
Date:   Tue, 29 Mar 2022 10:43:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] hugetlb: Fix hugepages_setup when deal with pernode
Content-Language: en-US
To:     "liupeng (DM)" <liupeng256@huawei.com>, akpm@linux-foundation.org,
        yaozhenguo1@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20220324074037.2024608-1-liupeng256@huawei.com>
 <361111c6-921b-e129-edf3-367748f6497e@oracle.com>
 <ec312492-fea9-7130-8be4-1c362c2e84a6@huawei.com>
 <e94ea60f-9da7-98b7-7d47-1183c0fd2ddc@oracle.com>
 <d992f076-5eba-929b-e284-57bd5471cd85@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <d992f076-5eba-929b-e284-57bd5471cd85@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:303:8d::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d688868b-fb30-4e0e-eacb-08da11ab9860
X-MS-TrafficTypeDiagnostic: DM6PR10MB3418:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB341897BFEAE59C68A4C87277E21E9@DM6PR10MB3418.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+l76auLfITzD1z0y1njuCv/dFFENoB8duHh1bOpDS0As5WtUMMn5Ab6Uw3dBUvwrIamQY52UBYrhZME3LT59PBIbot+jyO0QHzgzB1EsCuKY0N41wxL8PQHcvzPtMNPigR7IZU14xWkCZDECZNSa5ZU2/v8zJ+cuPf86BcrUPJk8/Gtcx69VgQlvj690vCT7cbp1C/PFE3c5mBeJG/jQCqXuAdycdkR9jkxzIgnKyVSUIxan+9Lk0ykRZx5bHsAJTPAB2Bg9UQXUDgmLXtONB5e5sdFjpN6BNclJ2oGMTIvGEsKNKNE22CPCfCn5v6T6o6X1/KXONb66A/YY5uxIIZJHJA9X6LaDyW0n17tmz0gqG6xtqKt+s/KcgvP0T/NvUTX/kDweZzjA4fG+4ANOxgXq1g4HI0jE/QE/FroII+TwxcOL6+bQQI1bjKZRCcf7lMuuzt/VCNtdJd+5nE8KQ3OfwctfcRQz24rHw+GIM9o+3p7yT35ggf4do5VbRgLyQEkYKzoeZlS4/6pSJih3wZ6ZVu2a4eD7u1KdGtm0DbkaOMMEjmqIfFf2cRjipAbGVe0AfbWJ3b2kX7i9jsJ+Dcs/ZTzQ4F4ygPMqaFh7yMsclR7K8oMQise6IhH4PMWnucuRJ87chPLUqWsAyzDkhek1jNl2zVcqdnxim5A7a4apADc2pSB0o6tPjXIwvHTASEQDVHwt1uRzYquF/bZdvJAt0eWFKdeut8hmj4H+Rx+1dgLF49eboW8muVUpA+6pw7oiwJQnEwuUfjoAbA6lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(508600001)(6486002)(26005)(52116002)(2906002)(5660300002)(6512007)(8936002)(6506007)(53546011)(6666004)(186003)(316002)(38100700002)(38350700002)(44832011)(36756003)(8676002)(66946007)(66556008)(66476007)(31686004)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFRRSERsYmhxQ1BVQWVtajYrejEwcXZJa0RVckE2RDhEd05PL24yNnNQTy94?=
 =?utf-8?B?VXJIaXBYVTFKZHo5SlZiaStSNTJBeGRvRFFJK1lGY3JUOGpNOXlNMWg2NWlS?=
 =?utf-8?B?ZW1MOW5zYXdlUytnTDVrbFJ3dGtSaFJ1RnEyY3c0Qjg1RGpJKzd2MG5JT0N2?=
 =?utf-8?B?V2UrS3I1UXY1R2U5ck45UVI5bDhvZW5VemlVUG5TMlJ5UmpseGp3OFk1S0lR?=
 =?utf-8?B?WEFtbmduaFBXb0VWVlR5Vi9TSzFnWXZWWkNXUVB4M0J1cXRaWUEzQTF5dHlT?=
 =?utf-8?B?ai9RZ2o5QUFxM3hYcGlTeVRlOERPaXJNcm05NzZCMWwzZzUwRXU0c3RIaHlH?=
 =?utf-8?B?ZUViWWRpOUV1a2FnRFJla3NuSjF6aVcwRk9EWnQzU0I5aExVaWNSdHJBaDFX?=
 =?utf-8?B?amR1cyt2VkRpQzFMNHBwblM1elAycTlVYXM4c3VOSUxieHUxYUNMQk1NMTdt?=
 =?utf-8?B?L0VIelRjaXVyNTdVT0x4aFoyQTczNjA2dldrdXhjaWE2V0xCRkloYm5kODVG?=
 =?utf-8?B?ZzdGell4aHh6YWU3Y1pNK2ZTdnMwa1V4WGF2UmpXUG9vcFB5UGZpc2h2Umll?=
 =?utf-8?B?QU5WbkxobVlIWmYreEJCMGNqMkN0RC8rWDV6dWVpU0tpN1Zwc0ovQzlQeENy?=
 =?utf-8?B?dTdIdHBjTW9WNk1TeVVQVmcyeGppRUl6ZGxiRjNnTUhEUC92WUFuZFZ4SVJR?=
 =?utf-8?B?QjBMeEgvY3ZNSU0xNTBuMVRKd3FQS3l6cjFKMm5oQytGU2JhNWVpOGIrcXJQ?=
 =?utf-8?B?YnNvdUVVTEpYWGtjZkxpTXJ2VXZwVE9udUEveUZ3Sy9zRTlUOTF5VEVUcmZk?=
 =?utf-8?B?Wmt6RkJmYVBtcTFlTUNDb1VpTVhkOWJ6cmI1WkF2S0Z1WGxxbExaeWlVM3JK?=
 =?utf-8?B?TFN1RjhvZXN3L3BtZXJoaGZlWHBlTkwwUFpMcFZodElFYkx3SUI0V2lRd0tn?=
 =?utf-8?B?WElaTVZyZDdoVmRaSy9mT055RXdLSXdXbXFxR3hNaU9hcWRQQXQrblJ2ZHpj?=
 =?utf-8?B?YVpWZTEzNjVkMmR0a2wrYjZTbit2STdOMi9OQktVTUp5QzNYTXJrNUVlTSs0?=
 =?utf-8?B?MUg1azJBYmFoUGxJZnJjeUtjYUZ4M0xieGIyVVNyRGhyR1RMRGg5Vi85SzRt?=
 =?utf-8?B?QWpVVDFEN2dSaVRHVVBsSlNSWDRFMFpOeFdTckNQWVN4a1JjSHJ6NGt1eHlM?=
 =?utf-8?B?NEhTUi9wZFlrNDJoNkpmdmg4RmNzVlZwNzZKM1BpalZEWHNNbkU1NWtqdE0x?=
 =?utf-8?B?aEJOTWhNVEFaUzJqZk4remdjdi9URHZNTmQwY0NzWnUvOXdyTmQxZjVJalhC?=
 =?utf-8?B?RU9vSjFuVGxxdlFLVDk4QXo5UFVwZzIwbENwdUg0UjIzTE13dURKTmlUOUgz?=
 =?utf-8?B?NnI3QnNKVlZvZVJYdktnWmJmTHRVdTNZdktNZ1RhQ2o0QktkQThvMnhONUIx?=
 =?utf-8?B?M2pXZ0dhNTF2UGRFQzNiV3drK2FONnZFZXVGOVphM1VneXZwK0t5WkFIajZo?=
 =?utf-8?B?L3hjQnpZdVFvbStPSFJ3VklXSWdjNXl3eXBOYlZFdVVVQWc1RXBxWEhSVlFj?=
 =?utf-8?B?VzZSTWRTRnpGRlJEUmtwcTR6R0dYS0pwVnRubVNHZGN1SGVpdzI0bVN4bXA3?=
 =?utf-8?B?bndsSmQwaFE0cy9xV2NRYXZxLzVGeEJGdG8zK3JDSWVraDVYY21IcXpjSDVB?=
 =?utf-8?B?UHR0VEVwRWFpNG1yTENyN0JPZWhuRWtTTU44MWJZS1JHeFo3SFluV24xUklJ?=
 =?utf-8?B?dVYxbk1ad2dvTjY1bTlQOXVWVU5zTEFTeFFTVmJadkpsR0I3VEFxVGwxSkNm?=
 =?utf-8?B?c0tDOWZzNHBlWTE5T3ZyNGtyWHlEMm5kZXpob21NNWZPcEpMQTRIMTlBK3p6?=
 =?utf-8?B?SUlZTUpjVjQ2dmJuSUdlTGU3WDdoYlBmalJST1FaeUJRYVA1TndEYWorZXd4?=
 =?utf-8?B?blcwcjRLVFNPdEZyNjYxTGI3WmpZVnZzT3l4WEtBcGRSVFBBc09TMFkrci93?=
 =?utf-8?B?cEt6WTdYSE9Ed1dVL2NXbDhvNFZucDUwS09QSWZaaGFQcC9WeE8wWXNXT3lv?=
 =?utf-8?B?NGFVZWtuaHg5QW9TdUVYQ08wOVBhQ3ozT3dFSFJXOFNYZHZxWXRLakJjVXV3?=
 =?utf-8?B?akl2eFgxOFE1UVVKbVRhM0poc0pzMDZ0V0pGZTJlQWw4bUM0UFBwMXE0Zmpy?=
 =?utf-8?B?M09yT3E3eXlYaUpmMENJamhUWDVpUDgydmN6UVp6a1JScnVBdWhYVm5IcEtD?=
 =?utf-8?B?aDdPaVRtTlowbTZWNlYxa2sxRWNmVUcvZ2U5KzRxS0FaTm04Tkp6V25Gbldk?=
 =?utf-8?B?aFlaNnNMb2pkYzhMbEJtalA3VmJPR2hZUkdTcjNZS3QzZjZFOVpUY1hSd1Fa?=
 =?utf-8?Q?sHFN2uhSsHGE22wI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d688868b-fb30-4e0e-eacb-08da11ab9860
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 17:43:12.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoWpsueSrb+EkI++ReH3JjUBQmDNEl89PlT4Ct2Y+VGe5XV98xKFAH6+1Bk2GoM8pdQQkbTuUSiR9gO+DheKgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3418
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290100
X-Proofpoint-GUID: y7t6dxdTW8VEyhCirjkTtXlxhf5RxGnf
X-Proofpoint-ORIG-GUID: y7t6dxdTW8VEyhCirjkTtXlxhf5RxGnf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/22 20:59, liupeng (DM) wrote:
> 
> On 2022/3/29 10:46, Mike Kravetz wrote:
>> Yes, I agree that the change is needed and the current behavior is
>> unacceptable.
>>
>> One remaining question is the change from returning '0' to '1' in the case
>> of error.  I do understand this is to prevent the invalid parameter string
>> from being passed to init.  It may not be correct/right, but in every other
>> case where an invalid parameter in encountered in hugetlb command line
>> processing we return "0".  Should we perhaps change all these other places
>> to be consistent?  I honestly do not know what is the appropriate behavior
>> in these situations.
> 
> Thank you for your carefulness and question.
> 
> I have checked default_hugepagesz_setup and hugepages_setup will both print
> some information before return '0', so there is no need to print again in
> "Unknown kernel command line parameters".
> 
> Should I send another patch to repair the rest "return 0" in hugetlb?

I would suggest two patches:

1) Fix the issue with invalid nodes specified.  However, leave the "return 0"
   behavior in hugepages_setup to be consistent with the rest of the code.
   This patch can be sent to stable with "Fixes: b5389086ad7b" tag as it
   addresses an existing issue.
2) Clean up the places where we return 0 and it would be better to return 1.
   No cc stable here and just let the changes target future releases.

-- 
Mike Kravetz

> 
> Some other tests for current linux-master:
> 
> cmdline:
> hugepagesz=1G hugepages=1 hugepagesz=1G hugepages=2
> dmesg:
> HugeTLB: hugepagesz=1G specified twice, ignoring
> Unknown kernel command line parameters " hugepagesz=1G hugepages=2"
> 
> cmdline:
> hugepagesz=1Y hugepages=1
> dmesg:
> HugeTLB: unsupported hugepagesz=1Y
> HugeTLB: hugepages=1 does not follow a valid hugepagesz, ignoring
> Unknown kernel command line parameters "hugepagesz=1Y hugepages=1"
> 
> -- 
> Peng Liu
> .

