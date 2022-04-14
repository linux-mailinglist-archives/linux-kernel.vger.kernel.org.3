Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78085002DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 02:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiDNAET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 20:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiDNAEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 20:04:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E098F3700C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 17:01:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DN6wh2031505;
        Thu, 14 Apr 2022 00:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ObCk2E0nf9nOp8AspLjAUY9d/MWMtxv2VqU76J4dOXQ=;
 b=BEwknwpTvrhM0NRqeO0rYCA0pYwdpSMk/MLYP0+xoJ4l0PKCwtK5rgM/Xz7j/CjAz3vL
 X4J2s7eDxNaKrD/eEf9YAMx67xafXK2/OIK7BWEgZ+IYGftWSMDi7c6StnxqME3trnau
 MMJxxgokOZ1LxFSnzZOl+A3rLxhVLNpLaRTyMKoRD/MgkwqyxFFER+JUQYNekDSwFJks
 QopclQH5m8ex7f2JrPSfp9fp6p1xtpgVRw0Bgf/zNd7+ZH44VXUuexFOtjAbHd/RwR+B
 +OdMTQ20O0R2vDLC4zLs5zH+QlX3/zpkVsERsteavYJBgGw6n/tsvtit96yiFtlbwxmK Rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rsbgaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 00:01:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23E01UqW008873;
        Thu, 14 Apr 2022 00:01:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k4wwgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 00:01:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsiBxu8tmO4KypsjYNbW6aKPi415NZO5UN4x3T2YrpDMJASQvzurvYka0vzkHOzdOlZy903IEgAiD/Ex6d/MvpK9TD2/4CPrnXiE3iK2VCbA2IFRKsOxrDSEH3g8V/PPdOOT2H73nPaRcpr9mzVzkWtYNjsOqEBfr0r7w93dZQwRIlLMBsi5vhEuiYK/8UEg/Jt47ao9MXiTCT+MuW2KC51EHcKTp6SFaxt8vAWDh1MqgGqF6e9XmeJ1Jy+pK8G0HFJJfViAcK168tVg3k0ckTsStUhBfCLhE1fmY87yZnQhRPtuavi6z0eHb8LGB4p8ri91WDATvuUh+S+EQ7FlcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObCk2E0nf9nOp8AspLjAUY9d/MWMtxv2VqU76J4dOXQ=;
 b=E2yogfLZIyk4PptdhZrA0vVclIbKelMWyJnapP5rZ9+X+FzxScX4muX9DeZ9AnD0eD/w2vcZHE/vHJTZdYEAHF5xZDUHILb+8yW+Mk7LWaSA0TbZCUbHF4PJMoZOkffSo5D23aE3I2pHSFJiRXr2sbuDHJoxrebTNUHg59iY7WQbBMw5IE3cXS7lYlVwNMLjIzoSOS0u2062RLAUhuVez/TIrcKB0XgOYS86nkzkRjpu0Iq5B03AP980nHMsw73z6i7gKqus1l9nQ6y1j8X4Srwoi9InJxogvnDe0xQsgrZcbxCsZMFcsntmdNxk8e3C28PJoGRJ318GahXrbs3GDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObCk2E0nf9nOp8AspLjAUY9d/MWMtxv2VqU76J4dOXQ=;
 b=ZOrmWk5xlzIOpcqB+PIFsSVFRy4ZAznfYZstfQS5ghvLFTUn+ULZYGhcVeMwQFc70EdMoOTBMPom6jmIHz+QXtl/Ib5lxMGTRWXtDtBkNfs65Et1apBLNKz049MWTcWngdzaNmP68uo3d92w2mY19KjbTimOXClb5d/p+nPwRJc=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by SA2PR10MB4441.namprd10.prod.outlook.com (2603:10b6:806:11d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 00:01:45 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::78d7:18ae:804d:45e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::78d7:18ae:804d:45e0%3]) with mapi id 15.20.5164.018; Thu, 14 Apr 2022
 00:01:45 +0000
Message-ID: <61000bfd-7778-1d59-4aef-678eb0583b0c@oracle.com>
Date:   Thu, 14 Apr 2022 10:01:35 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH v7 1/8] kernfs: Introduce interface to access
 global kernfs_open_file_mutex.
Content-Language: en-US
From:   Imran Khan <imran.f.khan@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>, tj@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-2-imran.f.khan@oracle.com>
 <YjOpedPDj+3KCJjk@zeniv-ca.linux.org.uk>
 <10b5d071-7f69-da59-6395-064550c6c6cb@oracle.com>
 <YkxRDJ2ynEHGdjeT@zeniv-ca.linux.org.uk>
 <0dfe1056-3dc5-4d31-698e-e2c075ffd6ee@oracle.com>
In-Reply-To: <0dfe1056-3dc5-4d31-698e-e2c075ffd6ee@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYXPR01CA0101.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::34) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d82ec50d-b0cf-41ea-f7c0-08da1da9f6b6
X-MS-TrafficTypeDiagnostic: SA2PR10MB4441:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB44418D7EB62861050B0A9309B0EF9@SA2PR10MB4441.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OnEqPWrVYlwHCeUrwTy/40Zq06Oo96p2rT9RQWmuQAl+X5wi1Cd9ULgdsDlATi9OlgxfcQD5/iwKxAnj32xhcT4wIGWnKCRkjMDTtOPz2PS6LvnWQx+aCiZarfZya3fupratHCNyupxGc7YgnfSnQqc21XKCYO4hBepXSGlxaw8062/50IK5o6AHP6rpxjfrscuXAlJCjQvin5M2EH2ebiytZhp/QRPqOPt1rpii92Ba9zEroDa7Y3/zUmJgWL7VsRHRgObOxRKRl6iFDjCctBZYtHAcUqOS5Odz6I+7xNuqHZrmQnJKoruMXh50SzIsBmmn1N2YVOBcReBOMoT0rh37B7Ml7phVtRyF0Gffsnks+dke0HSno5QoNWEDrCEKSkmovKsNLU6UKNxojHhsGL8s77qO58TrVvGG5KuNrhDwRdWs5gcXmc3uK+KsGINDlzLTyOKH/HQHZGT0xmVGqNCvvTtkQo9PIMaZj/cwFXLC/wTADzF5prhGXBtGhvOekQU8M9EaCkS7DwZjkfzWekvppkYxjX6sjs90HmXui7gf45rWl5TpzHA7GraMksksfH4kBO5LChLDGwP3974K6GEI8C2iBNSt8BipshXy+nQOc/+IG8SbNOEvFXa1yIGagdhsHOCSMKB3OBIdZ2N1PYrtA+ul1UQfjsREQaS90zFLOpvo8tDmPEZIdy2nrE6WXsH2uGxDFXiYlXAU9LtoKN7Td/85rKIb1n4GnvUi1sSNFlpKTqTPU3BFjm4H+sIFTW6Xz8ZCYOuOBUj6DQg+VLaeyuvyp50V0UG3Rz6xVK2g6nIm70WE9wy4vEEmcOLGcH95X0E98noe0c6wavcLOHaNIVYjLu7R2B8hfKjXVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(6666004)(5660300002)(6512007)(316002)(8936002)(2906002)(38100700002)(36756003)(66946007)(53546011)(2616005)(6506007)(26005)(186003)(66476007)(4326008)(86362001)(8676002)(83380400001)(966005)(6486002)(31696002)(508600001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHpXODVpak1QejZ1MmRXdzNFRmhndE9MODZoZXJtdVBxRUhSK004bGdvaG9U?=
 =?utf-8?B?aU84SVU4bUNwUzVPRUUrdG1UY2JFaXJ3anZtSmoySXgyeWhQOEV6U0JseXQ1?=
 =?utf-8?B?UEllL0R5UzU1ZklOZFprSWdqUlRCdE5SVmVsL05OcFMyOHJMb1UyVGgxb3c5?=
 =?utf-8?B?b2ZrYm9GU21kSy9BRVA0SjBhY3NCdzd4b3lZdWl4WDNES3dCYXI5a3ROUDJR?=
 =?utf-8?B?QkxDTGl3WmxPK2FDVE9zSlNSMm1XbFZRWHYrM2lHeUd3Sy9FYXFkM2szTFRa?=
 =?utf-8?B?OFk1Ri9Ra0xpZk9McTB0Sys3VkpIeVpkV2JmWjRlK2xvcGlOM0M1UmlQSEhI?=
 =?utf-8?B?cEl5elpibFluTm5IUDBFRXBDNHROMlY2d0lTcXhESCtvZ2Z4bEJsZEJpajF5?=
 =?utf-8?B?NHRmY1R5UWJiRkNzN1V6OGNhUk8velovSTF3ZXNVVVdobXJhaENKSXlYb0dO?=
 =?utf-8?B?VWNjR3JiNGFFSnlTWC9odjZITGt1dkl4aXIwcjRBd0FBTDA1RGVqcWRoMzRD?=
 =?utf-8?B?cjZLaHhwTmFPVFE0WklpWlk2UXNtL1JKZU5haHIvOG9qdjZsOHJocUZLSEdK?=
 =?utf-8?B?WC9MT0NIbTJNVkhTYzNsb1lINnVSZkREWG1WMklRTHh6YUsxZlJpeGxkSlk2?=
 =?utf-8?B?c0VjY29qSmRTaGcwajE4eVM0YVkxWXFEaTRlQzdFa3l0N3F4VUk1andUeUp4?=
 =?utf-8?B?TWxSSnhpdmN3eDkrcFU3Qnl2M1RmdE9TcWcrQVl1UEdBMWJ4NTV6QjgwRFBE?=
 =?utf-8?B?N3U0dU4xR01mU3RBQVlIRFc2bWY2eFlSWDFvMncvSW9ncnNacEFsanhZVGIv?=
 =?utf-8?B?TUlTSTBvS0tNdzZVTkdNWUtrUkVhczZuS1hLaDRSN0VCclpiVnZzdEVPQzVJ?=
 =?utf-8?B?bzhwZFk0UnZuT25BSm1ST292TG1NRGJWMmp0d3ZCQXZPc3FwMmc2Qnp4Ym0y?=
 =?utf-8?B?THR0by9xcCtPM2w5azFGWmZKTVY0RFFlaUZCTWFZcG5CanJoWDA0WEs3dk55?=
 =?utf-8?B?YnV1NlVJbEJXLytPQWNQS2VPTkZkT3lJZHB4WjJJRVdSVmprSGtHa3lNeVhl?=
 =?utf-8?B?ZnBaWHpYUndWT1Ewa2VrMW1YWUZsT1o2bXFWSzhNOVhrdkJSUlVBWDRSNnVm?=
 =?utf-8?B?aVBwUXZRVTVwTkNHNkhxK2F3bXUzTTVLbEFuMjhxMjd0Mlh3YTkrOWh2RzJv?=
 =?utf-8?B?YlNHdm55cHhTVzcwNVRDQnV5N3daSEM0U1RleDd2c094czUyclVEODdaaUc3?=
 =?utf-8?B?T2VFd1kwVVNYcDByZDRHbU1lTy9ka2xFTEdSNEtsYTlJMEpUNzAyMDZZWis0?=
 =?utf-8?B?cXVyeUg5ZERSNFpDK0NsZVFjWjEvZ3hzVVp4S09Edms5NnRrTGxEZU5GRXkx?=
 =?utf-8?B?MVpOU2xxMW1SbytGLzJqeG9DOUZzaG1iak5UL3pmdmxESkFoejYyVWlzempT?=
 =?utf-8?B?cS9xRjdkUG1Wc3ZQZ2hCMThxQWg3L2xpekJGVWJpZHNYOFl2RmhHVkFiU3Aw?=
 =?utf-8?B?MUkvb3Rta2VPMHNQUm1kV1JwVzdBdGFpTDNBSS9KYlBTeDhWSDdPN0lWQjIx?=
 =?utf-8?B?UXJQbVFwK1F1YTV3YzV4NEhYY2V0c0dyVDFUQkREdmdTNWk5azMrRmtDVDBt?=
 =?utf-8?B?U0Y1aHNmY01TSDJPRVNlM0U0MzNGa1A3L3RjampyLzBmSld2UUdKemRyYmJs?=
 =?utf-8?B?SlJ0UWdKdEtyaTQ4Q3dHQmJOSHUxTTU1UkRCenA3VXhQb1hBU1QrRWhUSW1u?=
 =?utf-8?B?SFFXUEl0SzBQZlY5RWd3SHIzVzBNOTNwNGhoYzUyYWV6T1YxbkJzcVdFMGtl?=
 =?utf-8?B?aVR6UG9vVlVUQzY0Q0NRaVlTRkRrWXViajBGVUppYW1kMk1wVHBrNjFhS0ZK?=
 =?utf-8?B?RTM2bXFYU2hldTdtdUpxaVNvV0paZUZCTzgvSEZFMlVVeEo0NllyQ3hZMmh1?=
 =?utf-8?B?MXovK2NmNE10UThYeXhuelhGaTZGMnlFRXBaNGszV2hOa1ZtWUU5MzdWa1Vu?=
 =?utf-8?B?d1ArUWg5Z0c3V3VOK1grVkk0NzUyVklNb09IQlVWeUZRckVNVkxxQU4rNGNR?=
 =?utf-8?B?WmNDWlZmT1FmNDB2VDhkNHh3RWhzOCt4UUhWNFdmZThOVkdvUFB3cGlva0kw?=
 =?utf-8?B?WURFdkRrZytyMDlQY245YVIzd2pkTm41cno2QmN6REkvb1owU1Zrc25kb01N?=
 =?utf-8?B?QjgrcGpnM1ViSlZiaE13WVJVaC9mYzhiSUVraytHWDFoYVBCNW9lUTBKQ2FE?=
 =?utf-8?B?bEVsYVdNYXhpZ0IwLzlQL1RYNHk0alZVbHAyckQ4d1J6dFRSM3JSS2tGTlZZ?=
 =?utf-8?B?VEtOUU04bHRibEN3QmJvVHVWYjVxemN1NFk2dkJzQWpvcnhiK2VHTkp2bGJs?=
 =?utf-8?Q?NH3My5VThr2IJpJQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82ec50d-b0cf-41ea-f7c0-08da1da9f6b6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 00:01:45.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1VnYhZMUNTPxvPd6NkgaiI23NLVJ19ur+oA5+YL6ALL9dXPBTBzb8+cOqHB9fv+Bnyk/EndQQ7zDceUAzPITw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4441
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_04:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130114
X-Proofpoint-ORIG-GUID: OUy23_8Jy2Jjj70f7NM2LPyaaELbzZvL
X-Proofpoint-GUID: OUy23_8Jy2Jjj70f7NM2LPyaaELbzZvL
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Al, Hello Tejun,

I have sent v8 of the patchset at [1]. I have incorporated your
suggestions and have also addressed the issue of not locking correct
nodes during kernfs_walk_ns.
I have not yet make the changes to make kernfs_find_ns use qstr because
this part is not clear to me. My understanding is that kernfs_find_ns
is looking for node of given name under a parent, so we need a buffer
in kernfs_walk_ns to hold the full path and then use strsep to take each
path component and look for it under parent (the node obtained during
previous iteration). For sure I am missing something from your
suggestion, about using qstr and removing strsep, but not sure what.

Could you please have a look at current version and let me know your
feedback?

Thanks
-- Imran

[1]
https://lore.kernel.org/lkml/20220410023719.1752460-1-imran.f.khan@oracle.com/

On 6/4/22 2:54 pm, Imran Khan wrote:
> Hello Al,
> 
> On 6/4/22 12:24 am, Al Viro wrote:
> [...]
>>
>> What for?  Again, have kernfs_drain_open_files() do this:
>> {
>>         struct kernfs_open_node *on;
>> 	struct kernfs_open_file *of;
>>
>> 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
>> 		return;
>> 	if (rcu_dereference(kn->attr.open) == NULL)
>> 		return;
>> 	mutex_lock(&kernfs_open_file_mutex);
>> 	// now ->attr.open is stable (all stores are under kernfs_open_file_mutex)
>> 	on = rcu_dereference(kn->attr.open);
>> 	if (!on) {
>> 		mutex_unlock(&kernfs_open_file_mutex);
>> 		return;
>> 	}
>> 	// on->files contents is stable
>> 	list_for_each_entry(of, &on->files, list) {
>> 		struct inode *inode = file_inode(of->file);
>>
>> 		if (kn->flags & KERNFS_HAS_MMAP)
>> 			unmap_mapping_range(inode->i_mapping, 0, 0, 1);
>>
>> 		if (kn->flags & KERNFS_HAS_RELEASE)
>> 			kernfs_release_file(kn, of);
>> 	}
>> 	mutex_unlock(&kernfs_open_file_mutex);
>> }
>>
> 
> I did something similar in in [1], except that I was traversing
> on->files under rcu_read_lock and this was a source of confusion.
> 
>> What's the problem?  The caller has already guaranteed that no additions will
>> happen.  Once we'd grabbed kernfs_open_file_mutex, we know that
>> 	* kn->attr.open value won't change until we drop the mutex
>> 	* nothing gets removed from kn->attr.open->files until we drop the mutex
>> so we can bloody well walk that list, blocking as much as we want.
>>
>> We don't need rcu_read_lock() there - we are already holding the mutex used
>> by writers for exclusion among themselves.  RCU *allows* lockless readers,
>> it doesn't require all readers to be such.  kernfs_notify() can be made
>> lockless, this one can't and that's fine.
>>
> 
> Thanks for explaining this. I missed the exclusiveness being provided by
> kernfs_open_file_mutex in this case.
> 
>> BTW, speaking of kernfs_notify() - can calls of that come from NMI handlers?
>> If not, I'd consider using llist for kernfs_notify_list...
> 
> I see it gets invoked from 3 places only: cgroup_file_notify,
> sysfs_notify and sysfs_notify_dirent. So kernfs_notify should not be
> getting invoked in NMI context. I will make the llist transition in next
> version.
> 
> Thanks,
> -- Imran
> 
> [1]
> https://lore.kernel.org/lkml/20220324103040.584491-3-imran.f.khan@oracle.com/
