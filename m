Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2F04C8053
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiCABZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiCABY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:24:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018801C11A;
        Mon, 28 Feb 2022 17:24:13 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SLnRfp010129;
        Tue, 1 Mar 2022 01:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WP1QTQiPTnxY3hTSdwfKg7ebLQYsCIpfnpAQmCwWe18=;
 b=AaF52TTs4YBIg1CTueAlJa5RaBxH5/KRnoUsIgHu5SqokGxX61EARJY6aMfdcfd8DF5/
 +RW2OcTDkBbTrCd44B9rpjecP5ANOIqe6CoK2qHYMJtIEPMCHXQaxi8gwUErSbrv6sPV
 V5+sxu2FkFfj47f/tZop/jtgpFfh7svuYxnY6NjhdfUbkBFJOBXl3Qe8jcSVMqQY3kXh
 LK3D6c5V8MpX/4dcyAeBLH9+RFR8eBI2LZ9GT9w3pd9SlgRlZzUxd1MFd2w+tpxFFakU
 Glse+tEyjLMPq42DS+T0qx6/fh36LsJcnO9SnxttMZHs8oQXFVEGnl2mudCixZOp8DGg Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k418pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 01:24:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2211L1uE151095;
        Tue, 1 Mar 2022 01:24:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3020.oracle.com with ESMTP id 3efc13mu3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 01:24:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdzrQkPWqwrsMA6x2Zm+1S9umKUBVXWzfH76uNVXLqPMpMjYb4gxcqusxXyTyZZyC42aLKotJ29r3giKljLu0DfRZzyM/CDPgEls4E5gLbEpsjL6K0/EJlC1zlu4eif11xfrqODZTSjISqa3lnX4/GAmQIs9wSk++7/voxRvaIvX+HDB8qgCzVGeLQZ1mojDMI90bsC7X2iRgsrsiHnJafYx7fq+5chL1SueB2vltTvfKTWhsD+SUpDCDdcaHhMw/90c3+uk80y4YBGzMl6Wyq4dvK8imtuBnsjOdnAnLrcwlaO2t+2g2sPKy4cY+vkfB7qdV11QzRQ67iB5MjGdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP1QTQiPTnxY3hTSdwfKg7ebLQYsCIpfnpAQmCwWe18=;
 b=O4oUh7kZk5SkfiC8caoit9jlbdkyIYYK8T47/nsZCWCdsCcl5Uk7N38Cvcg6nj+pUm57cjVuptWn/mgY3eLMrDUPXRMjdcHCgZWwdMv0WZAdUq3BofeBdFArw+ypi1RIeL/tjHk6+hLQV1v/ubHzrXkRgx/Ea0PdfsMRnnXwBVAXBsSvmfiPyhrniOzU6HaF2kWedZTt1oyoixHZkb/XkhIMpPINIyCM+wmzvOY0AKn7Q8Mo14zca+E0Xjh0boITDChr0h3vt5tz5nXfXrVet/9G6yWd5YBXrqkONTD45ixt/yVxh9It2KEdpX/YxCtnd+em3NMwGZS4vI9SxhDDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP1QTQiPTnxY3hTSdwfKg7ebLQYsCIpfnpAQmCwWe18=;
 b=qB8LY+4UUKkUPRv8cOAMdhruatJ7H3RFT8vS+9kpcOOiZEzQ++OAJIVNKiHvyrO54WZtqTaB/6AiX3g2y3Csqvs8D6PfMxAx2c3hKJmVC1xR8HzXkwEcnEiU7NhMwD22YIhqbfxpVt8GkB53FJFt5naUpnSwTlTJbuSWmOCpTIQ=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 01:24:02 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2%12]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 01:24:01 +0000
Message-ID: <a7e1f13e-326f-fdba-5272-9cbc7ba2a3cf@oracle.com>
Date:   Mon, 28 Feb 2022 19:23:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] target/iscsi: Fix detection of excess number of login
 exchanges
Content-Language: en-US
To:     Petr Pavlu <ppavlu@suse.cz>, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
References: <20220222124217.21715-1-ppavlu@suse.cz>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20220222124217.21715-1-ppavlu@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:3:16::14) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acae97d6-5d6a-4fe6-a232-08d9fb22290b
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB5764B8E37549F91024DA6783F1029@MW5PR10MB5764.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjSSN3lXWI+TQ7ZqQB7zDegqpk5faBovEhKaMetTKME+fb7gb+SPE3b1tfsV92oHe1lOBqAxu2VFH8USdLkrW3YCh3HdKFrsP7N6PkmQVDefgG9YykNBg4ExvvuuV1G0CDSZ4T9bLkrM6AoBi+1Dd327iMhZ0Dw/jn5MrR/gwp+R7HpP7b4mggbXsv3VbHwSa4g9wtiKaNI7wmIX2SIXzi4T5NDkgtPayHQH5WLyU6bRrS/fh2PXrTODmRd+O5s6lb5wNn2Gp1D7bdQcd54NS0wK4Bb/p1Trmtr/KW4x5+yLYfG4zIpynig7uuITIGUiC2Dp2DRvbhvmlNKYjl+0WJkYOXcBhr48PI7xY3lEEgpyx3p4WNkgsAZoutDfsuMNbgscUXYVvD1cXuQ9eRGmldRpGBQWwy5any0LpeHZh/gcUQ7FC6Mp9cpiFWu77sBJK/670CMiHD7nau+eMEWhXXNiup+94Zlk8jZfeqJIWFWkJBVrCP7Uaz0vbPVmpdvGSuyuZeIOzfZPDow2t4Rb2pq5eW0iehnGvkP2xKgHMYBdS/k98o5C1ouD06VWz5sraJUj3nYPmW0cyW8keEViEwZ8cAs13aicRlprsjwZvIEnwHWY+PaRF4HuaddK9TMVl30qyvgZKzAMETbAQsA5/pnQE1ebPdrvvy/kvkik0N89Vs8EKUVDKwB2Ko4h3oFrxQ7wo2j4dgvG0iDGlyrb16NEufLHczRrlec5P//ILs50UKVYcUG3PHZKlYWeCMET
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(36756003)(2906002)(316002)(31696002)(6636002)(31686004)(6486002)(4326008)(86362001)(38100700002)(26005)(66556008)(66946007)(66476007)(8936002)(2616005)(6506007)(6666004)(6512007)(53546011)(5660300002)(83380400001)(8676002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWlrQXJqUy9CSW5CdncrMFFVNzFNbWlqT0FTSnk3cWJLUHdqZk5yVjdFUXNH?=
 =?utf-8?B?NE13bElhekZNS0hxQXRyTHVIVEJ0WHNyMHdGVm1xNUw2L245d0dkTDB5UXl1?=
 =?utf-8?B?UzZnaEU3TjI3bDVxckQyR0x3R0grV2kvWU1vRkFVemowQ1M3SDE1THA3bjRy?=
 =?utf-8?B?MXpDODUxcEQ4eFZ0SXo3ZUQxbjlSdjVud1lSdHhFanAzWWRFRSt3ZWlUbGY2?=
 =?utf-8?B?Qnd3V3Q4RGtLa0U5M3JaVDNBUGh0V1ZSWGFHelpoamtlRGJGMWhxOHNENVhm?=
 =?utf-8?B?a29ORDZwQzV2VjNPdUd3bmtvMWdSTjIyTm42N3Q3VWQwaDdlRDRVUzJndUd1?=
 =?utf-8?B?bHVPYWQ5eVdsWnl1YisxLzV1TERYUVFuMGxCQVlyK3Z4ejF6Qy9lazZwMWxI?=
 =?utf-8?B?RjdjYjRsYjFialpWN2wrTmpBR1gxY3ZBZ2xWYjlPbVB2eGQ5blFqcWNYTi9V?=
 =?utf-8?B?djVqWHlvVDh4N2czY21iSnJWQVh5UWhCMGtiZ0VXUnB3VFltVW8xdUtROW5z?=
 =?utf-8?B?a05xbTg5Q2JxWTJySkpxNmo5VXFwL0wvOWxXM2VmNFJJcTQ0UTFGZ0lBWUxo?=
 =?utf-8?B?czZmMnlrVmY3blpnTWhiamdDZHA4V2RmdkV5S0tSZU5OTTFOUHZ5TkZNQmUw?=
 =?utf-8?B?eWp1Zk44ck9IdmpRYkVndlUxakIyTG9Zc2svaERWSDJieEhiMmlENGFBVFJM?=
 =?utf-8?B?SjQ5VE93em01RUFGbmV3R0dzMk9WOTNseGJLaWlFcFVvVjJ5c2h1Qmp3ZUp6?=
 =?utf-8?B?VURISEhOMHRVMjZsa2hJd1VmV1YxM25yd3NMdXQ3T2NzYm4wTjNWdVhOZzZH?=
 =?utf-8?B?dXJ6SzJWSERxKytsV2luRURTQUlaWkN5eDg1bmV2VkdFVlc1alF1TG92Tmpa?=
 =?utf-8?B?NTRzS3VXYWxrejZIZ1hrREk2WXZreUhPbzNaSWY3ZkFmcVpJRHdKV2tHakNB?=
 =?utf-8?B?bGpxdjA3ZTJTeGF1cWVyNVZURC9samc1SXFhKzY2ejFpOUNSdk05RENHWnd5?=
 =?utf-8?B?UUVtZHlJSUdDZkduQU1LMzVKeldMSVJzREY4TUYwRTdrWHpzdnJpSjhCMXA3?=
 =?utf-8?B?NkxjUUZlZ2hSbDZMaGVKV0VzenJvemRNSkF0b3BLNlJoQ1Zib0JuN3NIN25y?=
 =?utf-8?B?dzcvT1hjRGNzc0ZXcjY3ZFYzZVFOWXdxRE16N1dSbU5ydzh2eHJrRzFKU3JH?=
 =?utf-8?B?amhMZjFybXZ5RU9GdkFvVjBxbUNVdmhhS1dzWWdCSVVkV0I0SC95NzN3bUVx?=
 =?utf-8?B?ZVhQMkZMd3hBeGpRTGp0a0JmTXNPc3dSb3cySzNhdnF1dm1vVmxKcUNhNjNP?=
 =?utf-8?B?aFRHUm9md1N6T05hT2lQMnlCai9ZQlRkbmhrd2orZkkyTjVHaGE4SDl5MG9p?=
 =?utf-8?B?Z3ZkRld5eGZ3bW8rR09oZFByeFFhN0JzSUwxS3hmYVlwblBIbit1Wnd4S0Ns?=
 =?utf-8?B?cytvUDA0VHJHUjNNd1c1SVBLejZ6VHZ4NEpNN01pdzlZanVPcE9adU83bVp4?=
 =?utf-8?B?M0JzUWg5eDMzWFhSUlVJVm9sakFCeXZMeEtoSVd6WjhBa0dRNGo2UFJRQmM4?=
 =?utf-8?B?NmpCQ1lCMStZMnQyU0k5Nno3bzhZbm5TaGhibk9mTkRBNDVnSEtRdXFMSkxC?=
 =?utf-8?B?MEs3NDBjMElDT0VzVWpabjg5MzRoQjJCOERrSkhnSW83VUVGc1dNL2lvWitD?=
 =?utf-8?B?OEN6M0JmbUpXc09aWGRsazh3eDV2WE5YaTlkZlp3NVZiQ1lxVWs1aDZTM1Bo?=
 =?utf-8?B?MVhJQXRLekZ4bThOcEZRMXIyU2VWMlQ4ZFk4L0FYVFVMNjRwL2NPVllsTG9F?=
 =?utf-8?B?VGR3MWhnSXhQOFpqT2NIc0xOeDA1L25BWkZPTmtOcnFCaWI0aGcwMGhkTG1p?=
 =?utf-8?B?MHIxdUp6N3ZtNlZrTi9DOFZ0d2lOczVFSUNkMGJrTFNkbWhqL3RzUUxGaUtz?=
 =?utf-8?B?QWNHdlBGVS9Ib1dqa3FuWlFNeEJFSUxsOThYODhKR0U2LzRnOHlKZzNpMzFM?=
 =?utf-8?B?TUJuMUJ6MWhUUmFvN1F0a0Q1eDI1NmJwUDdVbklUUEdpTEkwQ0hNNzZXNXRU?=
 =?utf-8?B?N1hQcWd1UklPKy96dWNUWEU4eFRTcWhXUkY2ZmVDVzIyL3N0bUhxTWhEYVpG?=
 =?utf-8?B?bmU3emhlbUd6V0paUG1oQ1QrVFZXdlpqU1JnM2pTWCthNHQ3cjVtMmFVREp4?=
 =?utf-8?B?d1BvSnJySms0SFVqMW51UUphRmhYeU1KalFneXRET1NZc2NRY3RmZDlGMnRn?=
 =?utf-8?B?cjJLd3dUdFlrSlpTdTVjUm9WVjVRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acae97d6-5d6a-4fe6-a232-08d9fb22290b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 01:24:01.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7l96HLv8YVDcU51WAO0gKPLOeqyRYguU2f9tPbybPmqs8BAaTP9ziASQCO2dqJylWfdqgZD+kHpvlwGga59usl/J7nDu1papnXT2cTZNltQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5764
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010005
X-Proofpoint-ORIG-GUID: xCFpVwBfAIY20h0q6TQGpsdW0OdkrPPf
X-Proofpoint-GUID: xCFpVwBfAIY20h0q6TQGpsdW0OdkrPPf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/22 6:42 AM, Petr Pavlu wrote:
> From: Petr Pavlu <petr.pavlu@suse.com>
> 
> Function iscsi_target_do_login() attempts to cancel a connection when
> a number of login exchanges reaches MAX_LOGIN_PDUS (7). This is done by
> having a local counter and incrementing+checking it as the function
> processes requests in a loop. A problem is that since the login rework in
> back in 2013, the function always processes only a single request and the
> loop is terminated at the end of the first iteration. This means the
> counter reaches only value 1 and any excess number of login requests is
> never rejected.
> 
> Fix the problem by introducing iscsi_login.negotiation_exchanges counter
> and update the logic to count exchanges per each login phase as described
> in RFC 7143:
>> 6.2. Text Mode Negotiation:
>> [...]
>> In the Login Phase (see Section 6.3), every stage is a separate
>> negotiation. [...]
>> [...]
>> An iSCSI initiator or target MAY terminate a negotiation that does
>> not terminate within an implementation-specific reasonable time or
>> number of exchanges but SHOULD allow at least six (6) exchanges.
> 

It wasn't clear to me what this fixes. Today, are initiators sending more
than 6 exchanges and if so what happens to the target? Is it crashing or
annoying to user or cause some sort of endless login so we run out of
resources? Or is this more of code cleanup?

When does this happen and with what initiators?
