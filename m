Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA4246CCC1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhLHFBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:01:38 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48054 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbhLHFBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:01:36 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B82mMm9029825;
        Wed, 8 Dec 2021 04:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Tpyb8EoNfj2Ul6H+BP3mICVYt/OYXrpIDWU7wA43HqU=;
 b=PpKklnb9s1To/Wtez3iJzn+z8HGs286OY7VcxYZ8m9rOXTVqXqJfE8GAlqb1Wlh+Vuqn
 GCu8zqZSQQp4rfOizLqYdis7oygXZEV02VfAtBq0ZOhPH2Zxj5AIBj22aMEPlWmqL1YZ
 5xA0po4CPuuQ3HiCLnQzAaqAMRCHW0liDQScMS210MhTFD3mNb+gqoH+v6fBBrNyATOf
 k2JGURrUQZax8O4oYWl9wfK/08rGvfrbGkleMjVGOPb3zYxPwKdAPRxLkRxySqYp8l8u
 z5zs6QpzGYyZgHTHrifKMmuWbm/yowr4MALLWpkWXmNYuS0wKCSZWZBXa9VY1ROia+Vy Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csctwq7u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 04:56:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B84ugbR077826;
        Wed, 8 Dec 2021 04:56:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by userp3020.oracle.com with ESMTP id 3cr1sq38fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 04:56:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKPELexpKG8zbFhDP2xl6K5biXOGPhSwSOrBNOEHXgYSizfXof/4J1JVEelJetlVx3XBYozmi6afHdnkIK+rhuVqx6sA40PtA/erHLtKw3widQai4BNivaRa10BzdBV+eHdgqSBkroVhYmPEepFAbCGfTno044nvxEbpfruiJi/4k+fI0hVD3/duyOIn04dXTemDOldsCXeqMGScjFHhYkJyOH5RG4/4PFTKujT3WcHJJMYZePV+7A4GtNQ9Ajf3Asl+Bxoa2/X62NGCAtRsqpDRYAj+breNsGGhE5ETY4BjvRlyFvUcCtT4W5QJekLvMNPpWlIx2+JfZaPITHTu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tpyb8EoNfj2Ul6H+BP3mICVYt/OYXrpIDWU7wA43HqU=;
 b=mDHhEN9y3Vxn0Tr5xn8uqezLue2Sscuzq6WbSPz8QX0Z8jXnSItTrSx3RXHASV6XsLUYY/TQrjvSuO/Ue6NEsbp9D5vVUivPl5hrFujhlVwOYsSQJb6HT+N7FfwxdRck2hxffM22X7IFUTyxx9mJ+ysMjT/R1xA3EUZXS5GxoempW2yw+cn6z2tuzuiqbdw8VXxfuwsN4mbBgFNm4o+l4rboqTmmene8ppyNXsaNrFR8KZF5+mEnbRuBuuVn6cNT36L0n4x0hHh9yj8eq7Y1A52Qs1dvuvEVVc8HT2F9FWiykMpkRiYLw/kMkGtckcjqhdU+33pjXWlpshIB510bJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tpyb8EoNfj2Ul6H+BP3mICVYt/OYXrpIDWU7wA43HqU=;
 b=lDWFyCiBgE47yOgr2WWPVgR7b+m7XKHfGVMvoMPL1MTa9J43LvuVoG+hqYoQ2WAT8IB2UALjiuHAx3rdrWuKkZtb+E8OjrUAkcIunq/aM1Jqbdc0HVjNZYFveLDfxDLGy55MDDDQ6HEc2f4oZ1pysAKyDr30JbbAuFe1JJ2IzJU=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MW5PR10MB5875.namprd10.prod.outlook.com (2603:10b6:303:19b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 04:56:54 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%6]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 04:56:53 +0000
Message-ID: <c8e76c03-6fae-4a9a-aa25-826327e9d5a5@oracle.com>
Date:   Tue, 7 Dec 2021 22:56:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when no
 managed pages
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, hch@lst.de, robin.murphy@arm.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, m.szyprowski@samsung.com,
        kexec@lists.infradead.org, rppt@linux.ibm.com
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207031631.GA5604@MiWiFi-R3L-srv>
 <01b4831f-7136-80af-a6cb-93698cb31fc4@oracle.com>
 <20211207203328.2cda72e37b8c944e4276554a@linux-foundation.org>
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <20211207203328.2cda72e37b8c944e4276554a@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::6) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
Received: from [192.168.1.106] (47.220.27.44) by YT3PR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:86::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Wed, 8 Dec 2021 04:56:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 719684a0-abd6-4e1d-3837-08d9ba072751
X-MS-TrafficTypeDiagnostic: MW5PR10MB5875:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB58757A274329232E44BE7506C76F9@MW5PR10MB5875.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfM4DjctAOiJv/0sUzHOktBHlCQi6xG1gva61+zn0tlwjJ40E8MG+slX5y1cequ66fCRus9iW08NS3XGFhpGLooLXtu9EcG059kCiRYh2sHX4OCELIcRgqS4HALwK54N1za4ym1Mh7IWxt3ctX479JIrG3PTz800j6YPhQFixbRS9nNiqZEaHmQk8uYGkgo5AywpjgaxmBV77pQAoOJFOyVXZTn3Gro5dkj95tHhI+xKOvOycHcpmDuZ+92xeM5KLSe3WYGxUXxsigE6tzInIO0Ft5f2pmTbRAYxZC3iAIQ6u3KewitcVlaAKhzFewT2AGEw5cKC8eghphskYNYoT+5XDBIbUv9eAYZtBOnvTfzrd/F7I+jKnmLSVHiH39raw98GjfjVHaziGNdCrnc+l/5YB9YVUpf9yTcHg7PBas6UKao2JQ0c/NydDSpr9atGHtnpO3iYH/Zvgj3MDNncNWUeWTbHJtZeJDqsApElKcLTK/rCSYpC82gcZeZeNMYC1sajf6pn5vcPt9YlHz/tKuyQaNkynuPNQ1vU/u/+MZZOOv9iBoDBQq1z7duwJO0xSl578mxSJVF0qclTiJCcg1ArPhkV4UcRF/8lDc4ksKKACoUwsbiu7df85mlnVFkwbd7z9DQOk1WZFSTP36tlAXk686xR9SshkiaoSgiNY5CviIbnnIjAzIApTCJxmh+J1uTfRXgnEncZqpwcrtLTpSzOHX92vSucddqS5X+bCNzlNSFdMzeRQn+pwMpwfaPp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(36756003)(31686004)(38100700002)(6916009)(8936002)(2616005)(16576012)(7416002)(316002)(53546011)(956004)(66946007)(86362001)(6486002)(2906002)(508600001)(4744005)(186003)(4326008)(5660300002)(31696002)(66476007)(8676002)(66556008)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEx6WWxkZVFRV1VZZFpCRFdjaTFLdU9HY1cvUmFyd3AybHlodXJjSDUwWnN2?=
 =?utf-8?B?WkZ0K1VGNEhCcnVPWGFRWnAyTGhPK2cyWVpjL2l1NENTNnkvQ0NUMWwwMnR1?=
 =?utf-8?B?cG8xc3pSVnN2TFNQa0xUQmRUdEU3Q3RmNjduZEpaWXY2aVpFOE5FRGNSRzdm?=
 =?utf-8?B?ckZTcXZnZmE1TUx3UDhiNVRFNmcrUUcwYkNpNEdQdElyZTdPaWlDRFF6eFJt?=
 =?utf-8?B?S0VVN21pU0c4ZFQ3U0NJY0VvTGRnb0I0M2NKcU03M0xUZGZwS2FhNWNzVm13?=
 =?utf-8?B?VUMyaytYK2U4RXJWcVlrYjlLOFJtV0RBRkc3RVYwRzQ4RkdEWXZxMjRhU2sy?=
 =?utf-8?B?dmloK0g4WHlLOGtpVzYwTWRzMkxLN1JUcVpvdjBSTEMvYWcyaWlNWTg5YWpz?=
 =?utf-8?B?TmQ2TmZOQ0c0Y3EvY0w3Q3VIakpDWG5NbnM0Z3JpcDg2K0twWXA2ZmllNURQ?=
 =?utf-8?B?SmJCK05haVZoY3VqL2dyN1BaOVlWWWRxY1ZBSml5Vm4xdDlDRWphV2pCNXMx?=
 =?utf-8?B?aDJOeTZqb2ZZbWx5cVdZVVE1Qk9YQjNKZ2FyR0dCTHdtMjBEbzFKdWxzOW5m?=
 =?utf-8?B?Ull6Y3pBWVhRRWIzVmhtQ2cwbnE0eVZMMHlXT09DdXBiN1dLZlh3Z2dQNGtw?=
 =?utf-8?B?S1lvWUNjNFZNNG9nNVhPSmdHaDVDc1F2Yy9hOUplVVZJR1pVMlJZVStOelRr?=
 =?utf-8?B?UlVNOEptT3dGWHR1QUtjaW5STklocDljK1RNTVRXeTV4QUNFTHFES2tIWlg2?=
 =?utf-8?B?VGpNZ3FjTzM0THdGQjRuNUk1L0JIVmwvYXk3TmlrNEZYSHM5TnB1QTlhMVFY?=
 =?utf-8?B?RFgwWVFRWHoyOVd6QktmV3g1NWpFMUw1WHdPem90U2NzNGUzWkt0RXE0OUJr?=
 =?utf-8?B?dGhtcWkrVnNpWm0rWjgxMEE1ZGsvK3BqVk9Fem1kdmVMR3hGbm8wazlzL252?=
 =?utf-8?B?YU93Qm9xN3l2eTI0RnpWRTArS0dVRDZmcGxKenlWLzFJeG9ETmFrQWlIU1RV?=
 =?utf-8?B?b2k3U0JLa0ZjSlhRWTdadkMrbnBkWS9BWGtLa1BEOVIrVm9yMTU0eEVzKzJ1?=
 =?utf-8?B?M3VGU2E5aC9uUlJTamtMYWFmK2lxbVhsQm5vZENtdGlLUGdQL3lmdUlxOTVK?=
 =?utf-8?B?MXFCS004cUlHWW8vZUc5YmtzVUFVeENVTTRSZEpHWEpDeXhpWFY3TEFISU9S?=
 =?utf-8?B?Q0JKUHJ1d3VFcDFoSVlMbisrMUhtUHFsQXczZFdQYVB6WU1lTjVCbWFMRmVj?=
 =?utf-8?B?WElPTFgyakl6WENuZXV0dkpkUzZITW8rZE9xQXZHSk9nN215QlR3bzVQbUtF?=
 =?utf-8?B?cE8vTVVYT2ExRDZ1amg1TG9mek5leVp1cjdTOENHRUxKaGw1aUhCeTkrbk55?=
 =?utf-8?B?b29HcnNZbXJHUit5eHMyTE9Ed0tPVHRNTVNXcXFqNUtGdTdyZUEyWXNVaklF?=
 =?utf-8?B?K1hJeVJENXRXY09Fcm5FcTVoM2dTeDNpKzVNVy8vVE9aVVdIeWlBVjM4RUor?=
 =?utf-8?B?SG9WS1RRL1VlT1ZWSi9YY1lQZmxNblVtTXJ0ZGJhbURWZ1Y4TTlCUllPak0y?=
 =?utf-8?B?eTlTSjFza2dBQkNqY3BQTzMxd0VMSndsakRGSFdzdGpxTmdUZDlMRGo2YlJk?=
 =?utf-8?B?WnlpR00rSGhjNWpoVkZKS3JTU3g5NFVsQ2Q4VjcvWC9iRERucWNGVDJJbTlp?=
 =?utf-8?B?MW9leFdlS0FMMmdlSldJOWQxdUVJV1JrNnI2clhXRUdJMzFSRnFqNjV1MUdC?=
 =?utf-8?B?MGVROFg4ckF0NVg1b0FUdDJrWkpOUG9RbmJheHNRR2s1cW92b25oajNNdFdz?=
 =?utf-8?B?ckt5ODhjQWhpZlFPeGljeTV6ekZ0Y3BUTFZNZkQvTjFudHVEeS9zV2VwMVVm?=
 =?utf-8?B?V1plQnFRVWdIQnI5ME5xZHdaWUoxVHh6eU5tWms4N3NzbzNXTldoWW04SlNG?=
 =?utf-8?B?Q3BNM3B5ODJjYWRPNFplN0VROWVBdHZBYzJQbEFUTzBLSyt2YUxCWnIxVDYz?=
 =?utf-8?B?RVJPTDJKb3k1andEU3pCRmk5ZlMyS1lUc3d2ZDRkeGxTbm9pd3FXRnhBTlJG?=
 =?utf-8?B?Tnl3SkNvZ0dFbTdZVnFEQUw1SGt2aVJIcGI3VG5wV09BV3ZjaXFuU0NkTTRx?=
 =?utf-8?B?V1RwOHBhd2xXM1JFLzlFTElJYTlhLzdUeGhqc2JENngyTWZRRk83bFBjMW1H?=
 =?utf-8?B?QW5uSnZoRjk1STNsUTgrdHJZUk5mL0VLRXZCNnZzaFdaalJVMmZGV2ZnY1Z4?=
 =?utf-8?B?RlZOcmJsK0tlalJvcVZieU5oQVF3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719684a0-abd6-4e1d-3837-08d9ba072751
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 04:56:53.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMec/rcz4XUAnN4KgRBjUhTKHRoheASI2kOQgS80uanpH1T9wpi0NQ4sPx5X14O3hEz5QTwlsuV6jxmwAeLMTJDomsFR4tlPaHITf76G2BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5875
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080033
X-Proofpoint-ORIG-GUID: M-8CXpc3pabVtT7NM7rD6oCS3uynJuLS
X-Proofpoint-GUID: M-8CXpc3pabVtT7NM7rD6oCS3uynJuLS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 22:33, Andrew Morton wrote:
> On Mon, 6 Dec 2021 22:03:59 -0600 John Donnelly <John.p.donnelly@oracle.com> wrote:
> 
>> On 12/6/21 9:16 PM, Baoquan He wrote:
>>> Sorry, forgot adding x86 and x86/mm maintainers
>>
>> Hi,
>>
>>     These commits need applied to Linux-5.15.0 (LTS) too since it has the
>> original regression :
>>
>>    1d659236fb43 ("dma-pool: scale the default DMA coherent pool
>> size with memory capacity")
>>
>> Maybe add "Fixes" to the other commits ?
> 
> And cc:stable, please.  "Fixes:" doesn't always mean "should be
> backported
>

Hi.


Does this mean we need a v3 version ?


