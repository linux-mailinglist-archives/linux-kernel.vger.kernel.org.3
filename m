Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7928848A3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242786AbiAJXmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:42:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26870 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242645AbiAJXmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:42:44 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJlemw026231;
        Mon, 10 Jan 2022 23:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=byI9fxx/7g7jCbqukRc88AahNkdfKg/+C/zq+bTSmvA=;
 b=g16hoY/F/WtGSZaY3zDIQoOVKCvj/uEOTR6zI/v8j+3yyliYE+rtoVvrbJ4DhaP4ngug
 m/v/dgd9n4DPiDwxTXAaGRtJQw3L8+6WBF9QJyl73AR6Tr/wGRm08vmeLFcBI7cQRIgX
 8unAX0tN7xyhamZKqcO+FedhBTkzxvAQRWWEx8lHlBVv33+IF5TgIIquIc6zMqqTUnMs
 k/9md4Q97Qw4XeHGHy7lXu/ynESMKHRc5WTPuxbaP2HyvmxjZzp6cqwEJ5sMFbaQRRli
 SnCHQlFzKJJYCBw9LBZeIjJhtd671QZbE19OUS8HXAKeBnVy5P5+jrEMFpofTBDVxHp0 ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtg9xps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 23:42:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ANUPRw083595;
        Mon, 10 Jan 2022 23:42:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3030.oracle.com with ESMTP id 3df0nd8md7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 23:42:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/PnU0KtfXKVhsdOSL13z7kMn79lfhN7z3Z3klOmH0KcqPHNFqAX59trSkbM6K0QWHjLd+OoNwDF49z4ZJX/ZVYpIzDHUgD2+YPceaWyLIn9dOMYBZTHukbCXf+P/hJ/oKWUMUJtN7JFwr6dbl+zM4RBXJOBQ3yS1qBQ9c05kEQl43FXxCQnzDK5U/2zm8X23R2/uxv9jiEjyzfM30CA57SDspwJ+gvzDZu615eldb/4YgfndBVnE8FGOYIa+5t/UlGnaM0jnIzeArv0KR8/KekcI8i3YUhboebW16Ur048huSPBcY/EP2jN2qf3PWvZ0xPcFh9ES4iD3PzN/mnCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byI9fxx/7g7jCbqukRc88AahNkdfKg/+C/zq+bTSmvA=;
 b=QsXMwBAkcBvs1EetfoXmgj5NfgL8pOD1UZgzw6C567NzSFsU9nUFjt69M5GBJ/5UbOpf7q1NIF9wSgBThsOavcTQ59TGOYjElJ+imnm0GOZFM82eR7Gy2Boi+rKzAyfXkp2EN4ztDeJZDDpxQucu7DBM/j44PF8U7wt+dIDiahWFh52uegNVDX6v9ZP2G87lkA5Fkpud4r4lb5L4TU5bRjNHkuhz86XGUiGVMs15YViHfde+6hOnaOgQ2RsFSIK1E2tQdAVbSCSTcBr5ScdvJ8/GU00sreg4R4TojEGYl8alJRhwV3g2FCHG5IoNfan7bUcrGiQE3c80B3fAn8fr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byI9fxx/7g7jCbqukRc88AahNkdfKg/+C/zq+bTSmvA=;
 b=V4GTwl27KPwVyP2mx/JlL3KuelW9O/esEgXAguzTvPjQC6qRYk6gCdcgo0VjoUOVabS8X9JUWIAE0INA7bnUa9i/p1S3rS6B7SJ2y2PWENr0QAWYXy/W4xezVnLBHa3Qc9dx1246VNeKEwGvTClAZj8+iaHqxKWqrORI06CKlCY=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MW4PR10MB5752.namprd10.prod.outlook.com (2603:10b6:303:18d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 23:42:38 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a%6]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 23:42:38 +0000
Message-ID: <989749c4-bae9-8055-39b4-ffc1cb6fc20b@oracle.com>
Date:   Tue, 11 Jan 2022 10:42:31 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [RFC PATCH v2 1/2] kernfs: use kernfs_node specific mutex and
 spinlock.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
 <20220103084544.1109829-2-imran.f.khan@oracle.com>
 <YdLH6qQNxa11YmRO@kroah.com>
 <719eb5d2-680c-e596-1446-3ca8f47c3aea@oracle.com>
 <YdP57ij4JxahpdnC@kroah.com> <YddRVH4r6uNHt3xa@slm.duckdns.org>
 <03cb9939-efbb-1ce8-42f5-c167ac5246da@oracle.com>
 <YdivuA12i3VU8zO/@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YdivuA12i3VU8zO/@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0181.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::6) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23713194-2af3-49cb-d428-08d9d492e282
X-MS-TrafficTypeDiagnostic: MW4PR10MB5752:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5752B38DF2B95CBF7C85C268B0509@MW4PR10MB5752.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpiEGKwZcs48xcTtQLP0ES6PXZ972DQm9NAqjp8uWvBJLswr9kdI03me2l5wKPmrj7hwV5kHJkQ75a/VJmvNpjAGczZUfzBv8KZlf8xhFennUQxYSVGxMoeUO+zMs26xtedBP7JkyhuTZCA7ySvZ80xrKdd9lk2pAlQ4YXpgvx6y/NVdcGUF/twqkjUz08YejrhkNBajf/LA3euk9WZEI3PZ0iFTm2bbfz/crnLetLxEQpM4WrScFNZW4uw73l1T9hcVIdTlq584mqqpi0C+I+s731lsUaqoggAPUTbJAilAj2A1CTiI/ZHY/Xk3ZH6FnP/2tqZkpPSYEdd2WFqMJWZgNqvF3AmTKYniKl+6VagoJzF0PpGZjikNPtC4SdneJ4/gSAMw9IbAuEvDhMBlghq4I1LeChS/zl1W87ay+gTXe1+VpYxBBrqwrRia+UAGzodol8E/rP69G/atffulfnY79tJrqNWU9QR1l5NXnuVf47b93SFaPTTPqVOmW6VlaRAvBTgRwMqwCElTKGd1s5RLXimGsVvYyfPUR6JPZ9Jv8buPEffbRortuBsOqltJMBrxRRM5EthTxmEmC5rMdTZ6LInZ6zAe9AgfwK683tF7/RH47oJuHcteo5ELlXzq7muJYArJLDSQ1WVlUBYONq4AZ98CWj4zL0afNDd+7K4rB8dB2GwQ/1WJABXqI5gP7rM7V7C/Fuv+EnKfhabVw9+d4D7K2XKB+0zJLcxsK3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(508600001)(186003)(6506007)(53546011)(316002)(6916009)(83380400001)(66946007)(8676002)(6512007)(2906002)(36756003)(6486002)(26005)(38100700002)(66476007)(2616005)(8936002)(4326008)(6666004)(86362001)(66556008)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmtaSmMyZzU1cjByYU5pZ3d6ZFVwMFBkNExGcmpCVGlwS21kc3F0Y0p3czFN?=
 =?utf-8?B?MjVaVTVKUEFzKzBsWjI3VWxTay9jS3lVdi9ZWTBPbTkwT2dPbzYxMXNwTk96?=
 =?utf-8?B?TjQwNStSbncyQ2dCbDR0UUpvc1ZCeGRGNURGYTR4bkFHV2ZHWVN4YXVOWGVZ?=
 =?utf-8?B?QWNKQzlaUlFGQ2tzRlo0Q2p6dUxTZkhCQjRHT0JTREpTQnBnTHE2VnhpKzlF?=
 =?utf-8?B?em8xRUg0S1ljS1BqYlg0akRJbXpiNTJVNndXaXNQVForZnlEN040cGtVakNo?=
 =?utf-8?B?NVp4N0djZ3luRDJZS0laUFFZVmR6RksxV3RsM0wwK1JUckNWS1BoWUFTd29D?=
 =?utf-8?B?S1F1aWVKTDMxUlY5NWVDTm5KOTNjemtjR0VSWlJRTkVBZ0gxYUFMYWdORWRF?=
 =?utf-8?B?cWgxZkZVdU94ZW1RRXd2VTViWlR2ZkRPWTJrZGh3dU1ocjZmR0UwbXVHRWNL?=
 =?utf-8?B?N3dWMmFIVXFUVmhCTkt3VVVKNHUwUEpUZU0zQjdtbFRneXlHMHJEa2orbndG?=
 =?utf-8?B?Y0RKMDZobjVzSG0yZUdYaXplZXhwUEdCNXFUcHlSK0VNNXAvOFRFL3pVUjk3?=
 =?utf-8?B?VFpMam5GUzMyaDFvamZDd1ZoQ0ZxdkRpWEtudFdaLzAzeXdLNVVqYUIxZHFv?=
 =?utf-8?B?bnpycnpsWE5oVkVJZ2VkRXBSM0lFcW9sYk1EejFubnI5ajVhdC9ZMVlHcENF?=
 =?utf-8?B?VjBybVdFQUJqZG5GMUV6dnVvcjhSYVN4MHBSMW40cTk0djN5V01VVWVWWW1N?=
 =?utf-8?B?MVlKTm9FcnhlNkxLcFdDSlpYdnJTU0JreWpJSWdnQXNYakliOVR1RnRNNFNF?=
 =?utf-8?B?YWJJZndpRkdSR0xUbUo0aUVhbTgwR1NNVWh0NHNGd1dXQ0lRSk0rbUIzN2lw?=
 =?utf-8?B?NWMvb0FiTEY4NGNjTDRXaGFJUkQ5THZHTm84UzZteEVrNHNuWG9QT3F2bXpv?=
 =?utf-8?B?REQ0NUI2QmtRMmtCblIyUFhWMnVQS2MxT2VPVldSeFMyQkVIMVBIcmJTblJt?=
 =?utf-8?B?RStTR0dlMDFPL0NNYmxRNTlFUVlLZm9FUmY0OWx3SUQ1N2tmSkg0M0VEb2VE?=
 =?utf-8?B?ZFUxdDFwN2lUQUp0RDRXWHcxdWVucU1GeEtCOTNlcXNPL3hUUyt4SUEvQjh3?=
 =?utf-8?B?T2M0Wk5YQmZPYllySnovc2NYaytoRlUvMmF5UXpaaHJFM3ZOa1JuMnJqdWtH?=
 =?utf-8?B?S3dCMC9hSU56RGx5RHEvVXo2eGowbUlxWnNoVUY1dDlwUGhuU3o4YkFrMFlQ?=
 =?utf-8?B?cnhKR01udC9Ram8yYkpXQWFBM3k0RGhDNXFobjdNSUhlblN2ajlLM3lUSmJx?=
 =?utf-8?B?SlovcG9sR0tnS3JqMW1nRmI1anJDTGY3NXVLakxZYkRVOHZKK0t6R3c3MkRj?=
 =?utf-8?B?MGV0VXRUUCtlNWZrN2dwZ3FPVTlDSHFmNlIvWm9pN0FkYnBMTGZRYW1sRFR5?=
 =?utf-8?B?eHc0RjN2S1FhMzBRcjFESE5zbWJ5d1o2S0xKUnl1TFB6L0hZVDRZeUV3d0dl?=
 =?utf-8?B?R2pHNFdUemRmdTRXMThqcnFDS0swN0R2aG11a3A5NGozOXFUTDNmb1NVbnBQ?=
 =?utf-8?B?VUVFbVd5L2NHaklwU0U1Um5ISGhiMHg5QlpiNVpGWTZCWW1sbWhLdllRUlFD?=
 =?utf-8?B?YUhrSFJlbGlmV1QweWZpY3BJVEIrS25GNGw0VGJRcFFzTkNDc2R3dmt6VENk?=
 =?utf-8?B?UURFUWRUdVhVc2pEazlKY3J2aE8vUzQ4S0cxalk2aGlJSjJYb011Mjd6bGs2?=
 =?utf-8?B?YzdVbzlCTjZOcUliQzRlbUVOcjdUdnp5eUM2UStFQ3JGb3l1aHFvTWcyaGUw?=
 =?utf-8?B?Um9ZaU9kaEFLdnVYRkZMRmQvNDlXTCs3V1FKTjYreXJnTURNUmZ4YVlpRXNh?=
 =?utf-8?B?TlRBQjJaUUQ5cmlTbWVDZTU2K3JkK0d5cWpVVlIzSWRmRldxMVFia0t0V3Zk?=
 =?utf-8?B?a1dwZFpIbGdvalVBU21ESEZLc0U3N3ZyZ2p2UTBkbnpiZlhMSUpPUEtObFRt?=
 =?utf-8?B?dVQ1dkJTc0ptNzh6bHZ3cVhnWktnWG9IQy9OV2lqM1RwNFpEcDZPZkN2V2xy?=
 =?utf-8?B?VXVxYnQ3NGdXZVN0MzBSZkZLUjhKSXM4NDEvaWViWW1SWE1FSkcwZmc4UVFC?=
 =?utf-8?B?d0JJMzV4N1A3bVlIWUE5WHhMc29WZ3l5RGxmVmlGYjJtOGZhZVJMbGNoRnA2?=
 =?utf-8?Q?wCLsUalmcUabF6EEmMLmFFI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23713194-2af3-49cb-d428-08d9d492e282
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 23:42:38.3467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymhegclBh1hR3iGD9cheTOjkSoIeiiSjUKbHKNCbTA7A2qJK1dCMK/8XtNXXNuNgKpqXeRnPTPm+5FBeKq6UfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5752
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100150
X-Proofpoint-GUID: -rkI6abyS14dFPGFo1SSZ1reUJr7L466
X-Proofpoint-ORIG-GUID: -rkI6abyS14dFPGFo1SSZ1reUJr7L466
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On 8/1/22 8:25 am, Tejun Heo wrote:
> Hello,
> 
> On Fri, Jan 07, 2022 at 11:01:55PM +1100, Imran Khan wrote:
>> Could you please suggest me some current users of hashed locks ? I can
>> check that code and modify my patches accordingly.
> 
> include/linux/blockgroup_lock.h seems to be one.
> 

Thanks for this.

>> As of now I have not found any standard benchmarks/workloads to show the
>> impact of this contention. We have some in house DB applications where
>> the impact can be easily seen.  Of course those applications can be
>> modified to get the needed data from somewhere else or access sysfs less
>> frequently but nonetheless I am trying to make the current locking
>> scheme more scalable.
> 
> I don't think it needs to show up in one of the common benchmarks but what
> the application does should make some sense. Which files are involved in the
> contentions?
> 

The database application has a health monitoring component which
regularly collects stats from sysfs. With small number of databases this
was not an issue but recently several customers did some consolidation
and ended up having hundreds of databases, all running on the same
server and in those setups the contention became more and more evident.
As more and more customers are consolidating we have started to get more
occurences of this issue and in this case it all depends on number of
running databases on the server.

I will have to reach out to application team to get a list of all sysfs
files being accessed but one of them is
"/sys/class/infiniband/<device>/ports/<port number>/gids/<gid index>".

Thanks
-- Imran

