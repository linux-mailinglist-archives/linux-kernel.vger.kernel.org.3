Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41B05127AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 01:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiD0Xqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 19:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiD0Xq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:46:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA7F63511
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:43:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RJYl9X025784;
        Wed, 27 Apr 2022 23:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0XgXjsvv0d5XdKcmqtqq8H1VmvzOav6HjgRXVcYDjNo=;
 b=X/PLxUdlpp+5yEBv9nTVr+wnSCjbkzv6fb4cTfDEuFUU83U96TT01uY+ZIkD42MVQIsz
 Gv4dURf4QQkJFmem302AcsqufNrrZp9lOdOeQoWAyNpFkQunMp6Z8VnSwl78cK4BknDI
 xN1ryNG1DD9BYTMGQbTfxDYiC+srJLVUgWVk8SelPMbjn3Z57a3z89RULe1dNXuyDV/a
 zFTlQhW7qJHs7sAjQIcf9jLKYUMz5+hKnicDUArUy4doxzl47UGF7y9G5kZqntoCdrwH
 rjLFANE6UlGXgUFOutJrF9Qx7sYxUt4KnJ1bmbtycmTIoe+PMHlJiryUMtmi4yBdYbki /A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mtmkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 23:42:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RNa8NP036776;
        Wed, 27 Apr 2022 23:42:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w5p7tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 23:42:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRwM36rxOnTH0kTtxvIXhYbgEEuYqAvOTfa9d98icRdhfQGME0sRd98rqaXw5ffJnBjuPBlo4bA2WSK70Luu9mnbJucxtK4VNtgndUiFSQKdSKGyH+GOtuy4/+M8xHyPR5SJHiTGJRbB0AMJJPDK25OWhwYKuJWBX57JkmoVFAnqmv/nEUPVmg+11wPoEdwCaXV5nfyRP3U4u/CPTQs9WMV5uiUymvoOnAt1tgYRXjFQsyebXCNSnthsc0qWqD31D05jKnehZctXfxQ37BIAODChVhtFSia89YsGFQtPL0jd1fvr/92qLewx0xEevpH+oIlKzrplY6CNt118awAChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XgXjsvv0d5XdKcmqtqq8H1VmvzOav6HjgRXVcYDjNo=;
 b=fDsORboGJ4hCeEjLR9F7EJ0Q3Dl6ppMzxk8RvoyVRhgO8zYvqnt63NesTl6MIXDWQ6UEPBYUcwhfi47d5L5TMGe4Le8bnd7FWMO+f7wDzFrvfcBcuEHCJnqlBN82j9VAvz1XV+H9oCPUbtP0UQrHvYHO89u33OitFVJVCK9cdP41O3dwV39yJz3/i+vYOkKDisnBpE07qqCGgPZ3FffoNysTjCuY2CWcTS19AVvacbTQzEpSciQtPy7G7rSDj0bjwdKC0hERybdZiyU5If0qYalVcqQAp/+Q66YMYDKjE6MRXF/MUR6hhq5GA4xA9A0JnhcZU+MmGVF86yShxP07Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XgXjsvv0d5XdKcmqtqq8H1VmvzOav6HjgRXVcYDjNo=;
 b=O3ClWRm+qDYBg8hqC8lUl/F9dan5iht831NIj7cWuWFpme+FT1jmkeZQ7vvC6n3Y6GfrU1Qd5wKjrbAsPElOztrilyA16mary8XxHqvIR7IOnyphKejzkkDJ9mR14fWppqO2Kgyb/ZDEol5RQruDYRRoSM9xP//hczCP/V39wPo=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by PH0PR10MB5643.namprd10.prod.outlook.com (2603:10b6:510:fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 23:42:49 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::69a4:385a:1e8a:453%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 23:42:49 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [PATCH] ipc: Update semtimedop() to use hrtimer
Thread-Topic: [PATCH] ipc: Update semtimedop() to use hrtimer
Thread-Index: AQHYU5ANovQbEo/TBUSYkrXc/cSry60EXucAgAAa+QA=
Date:   Wed, 27 Apr 2022 23:42:49 +0000
Message-ID: <B8775ABA-892E-40FE-BA0D-A72B635D33A9@oracle.com>
References: <1650333099-27214-1-git-send-email-prakash.sangappa@oracle.com>
 <87k0baw59j.ffs@tglx>
In-Reply-To: <87k0baw59j.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd83945d-1be6-4534-043d-08da28a7a350
x-ms-traffictypediagnostic: PH0PR10MB5643:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5643D53E5E25C6863A272620E4FA9@PH0PR10MB5643.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pv2WfqzP1PSY3Bpq9iprdMbr5n+YKjXIwiwZdt1Prl7aVLQR5+GMULe1r9+IqVubHxdqb59LZkSpZNvsnN4Do/Vg+WyM/PwovYjRykfzY0vbmZyG2p9Tz1lApefL6HylkGLDQWi2kVkXOT9++FcWFJX0fAqRmWAMS+oUgnuvAexedWrIH9B5cbOg9Kq2CQzJeEn0VV+ztS9ZZw/OURKkiR+RqjlU8jKT8e8/FgRe0w7I5LHgC5UyjWctEiMHRve8VCgofcgnwDkG9EZZvgdfqjQolCtRKb9JSh51vyWy4hulutaQoZeOgeFcP21NTTp+WEacCHWYIbsXmmZmj0ZMeqXNzPC9WGJqYemraY0dJ0M/EUSqY2xs0M7/wxA4dtsBgHTURxaudvLOFnlZPXCzxhSYkfnlZ05hUQb1eCjAVMvwObNXF3r1CeGBAJ9rgL8RFhwxgjXVS+RUt1SIX5eFMUf+y387nF9GmDUgSCbhzEgN7TVdG0M26IS2NfThNpQpca0k/VP+WYQunnJ6ewmfIsAQ1FVDgBPMUjEeGcIReqNqpfV7710THr1QuoGSyIF+3G2Ba2vX6thPfFyHFoRxj6w2E8DUrRxhwi/cAExz+nZA5yoiwggUR1zCCKFJKvQTyj1+/s5PFuqAj6FlTz2e4ZCxMIAo0p+bC1DwYxOC6v0ljYdzl5cBC07jhyslW1GbrfDcprrQq+3oIh4eGguKTNQnf7Bae3BNnfg/Eq/qS2/UqWYXswnFtEFHiFHh739X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(4326008)(15650500001)(122000001)(6512007)(186003)(8676002)(2906002)(66476007)(66946007)(44832011)(91956017)(33656002)(66556008)(5660300002)(36756003)(76116006)(316002)(54906003)(6916009)(66446008)(8936002)(64756008)(83380400001)(38100700002)(38070700005)(53546011)(6506007)(508600001)(86362001)(6486002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWV6Ynh0cjVZYTE0Ky9UZ0dhL1hFd2thYVg2WXdhM2Myc05aUmxzb0RXalFF?=
 =?utf-8?B?SzN3aEFXOWR1eDViODkyeHZCRFJ2MVN4UE9mdFpUTGQwRUlUZjkxYkd3SHNG?=
 =?utf-8?B?WUVGcENBc0RabTNuWWo0dkZkTm5icXZYQ1pWMEtHUEpTbU5nVk9ZNzR0VXJj?=
 =?utf-8?B?YmwxYldkbFVXd3BUVUtQUEJmZjVaOTRxeG9PbUhSVGpmckw0dDdWS1hLZHVM?=
 =?utf-8?B?aFI3ejZpaWdXWWNZdXp0cVZaQlVEcDRRUzdmV0QrdVdTeDBpdFczV203UW54?=
 =?utf-8?B?TXE1REkvYkFhNFhzdk5XMmhkRXd5ZE9nRkxXVDZHTmpGWlNuQWY5WjdObDZp?=
 =?utf-8?B?VCtGVWNab2N6ME5QcHEzaWllRlZHT0s2dGVFajFDaGFtcmIzcW5FeVFFd29W?=
 =?utf-8?B?Tmd0T0prT3NiM3ByUGNwcVZVbjFXdmozUWpNd251cHFvSzVPWkV5dnlnWFFU?=
 =?utf-8?B?RWdHNm13UjRZY0VDWkpBVmpiZm5xZ0FJKzRBYkdSd2ozREFvcnBQOWh5YUJh?=
 =?utf-8?B?VG54TVp4NEZ5Y1pZTTlxMzYyRW11RjNBZUNoZVRtMGhpSmQyVGFWRW5qUndS?=
 =?utf-8?B?cS9ra0plS2xJVldiejRjQ29mc2d1UG1Vd215UjlDdFJXS2t5aDdlY3k0Sk5k?=
 =?utf-8?B?ampna1ZNM3JucTRGQ2pBWkxtcUVzeEtlTE1FMnNzT21jOS84K2JOSTBPbmlS?=
 =?utf-8?B?ZDNpbER5TVk2YmFIeWRaS3c1QmUvUFVIU0tSaWYvMXRtaks1SFNIWTVBWGw2?=
 =?utf-8?B?NmdZcU5mQnl3SVordzZkM3YrcHBDWWd0MTd0Nm1yK2dBWkVHcWw5R0hQUUM3?=
 =?utf-8?B?SE16cUZtdGRxOFZTVTdPckZTMkIwaGo1QnJ6UkNsVXJ4VmFObzZtOWFaQ2c2?=
 =?utf-8?B?MmxZdUxCZlVPU1FtR3FiZ3EveWNwbnBhQmNCSjgvVFBIYUxZVUoxaWQrTFBw?=
 =?utf-8?B?YVI0OFJJQkF6WE53M1NVVzI4aXdCMkE4UjVRWGRPVXJMcnlKRGFBL3ArSm1u?=
 =?utf-8?B?R2ExbW9CN3VpRDJOMXBQK1g3UUxrcFN2S0RKa21RaDBwVTdlWHdnVGFPc3dn?=
 =?utf-8?B?UnlITHhKdzM0b3hUOVJJNU9nNzU2L0RRTTZLMEJGYnl6ZnU4bzFBRGRmR0Qy?=
 =?utf-8?B?YVZ1cDRqa0MxN2N1amdUd0xXeU9IZmppVGNPM2RIS2tOQ2FBQk4yekYzRThj?=
 =?utf-8?B?aXY3WDVzb2JBVVo4Ym80T2dvSGs4MFBpeDFHdThJdXhGK0xJYUxac1ZkWFB1?=
 =?utf-8?B?STVVZGZuR0dNV0RHYmJ1NzNPUklsa2doOHNINEpVUUpueHlOK3hEYjFFQkR6?=
 =?utf-8?B?VWpCdW0yRkhIRDY3K2dwK2tmYmNnRVpUSGdwa1pqajdVQWFYZVlEWjYvQ2w4?=
 =?utf-8?B?akU4Ui91UFUrWDVqaS96dXVOZmxkNTZOazhLOXBLRXVmb3lLTHBPbjZqWDFN?=
 =?utf-8?B?QXBwSUx4M2dmNTI3L0dyaXRGazIwRjlWSjNweUdqYVNYY1ZESDlYMmhBMXV1?=
 =?utf-8?B?MU1sNmt6anZKSUUwMlhMaHpOeWh2L3Aybi9yZTJiQUVCYkp5QUpHV2dyZGpw?=
 =?utf-8?B?S1g5b0V1T0h4c0R1WDVPK1orekI0VUFnelF2MXNkdGd0ZVdzM1ZqemNmR1A2?=
 =?utf-8?B?WW9GbWZ2Njc2WitWRmVzb1BXcVlGUHRQdUlJdmpHcWdSbUlEZnRqVmZSR3Q2?=
 =?utf-8?B?QXNZc3FCMXI2VVZuMmZxTVFHclZ0anZjQ3NEdmFldGgyZ1RpeGJpaFZyc2xI?=
 =?utf-8?B?dHYrbXVuVkhoT1VPWHBwL0NibXlYVHFPWjlMWXc2NWd3b0ZSYnJ2c0xvcmFN?=
 =?utf-8?B?aWtwVkx4R1pVMzNJVEpuQm9OSzluV25obk95ZjlNaytIYkJkYkJ2ZUxpdHcr?=
 =?utf-8?B?NlREdG9mN3FUVVdJRWlsNTZxM1VLRzVGRDhjelRtdjVrN2RQdVR4dlB1eEJB?=
 =?utf-8?B?eDB1djEzdmZpYmR6ZHVDa1lqMzBGU3dYUnVKOCtPQ0lHb2Y2SE5YMW5VeVEy?=
 =?utf-8?B?clhEd21zb3dlL2dQMGNrcTBuTkg5MFI1elRlSzRjWGU0a01qbkVhRnlZWGtz?=
 =?utf-8?B?SmczYWwvMnpWcEhkZnJHTUJYUTFSYkJFTFdyM2xmUkxZUGwxR0FYTTRhSkc5?=
 =?utf-8?B?WkpwZU9od2xNeTYzaVAzOWZrUTRvNXRSQzFUSjRaYlYxbFlWVjZBY0VQcC9K?=
 =?utf-8?B?UUFFeHZ2cUd1eWlzTjJLOXl4dG1HVTBhcnFSU0wyWGR1aFVqU1M1blo4T0Yv?=
 =?utf-8?B?bGs1bWdhL0gxbDh6T1ZocHc3bTZtc25ERWNEazkrVUcrOEEwblNPWkJKTE40?=
 =?utf-8?B?UEFZc29xTDVvZ0sxb21QSXA2aWpmdmkxd3dLZlBKZGJpMDZKZUhGc0g1ZjhU?=
 =?utf-8?Q?RhBcO+PHr5vr6GPWxkKgQCJXyb2WzinfE49tlris0fAAr?=
x-ms-exchange-antispam-messagedata-1: kZfBSQmsmVVi1Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3AFD75B2E31904B95FBD7DFD7B92D6D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd83945d-1be6-4534-043d-08da28a7a350
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 23:42:49.0613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x1oOGuBKe4+vBI8iOKyD+0yYbFzonSRWHN/R/9h+Hv8KdBaZS+6vHBzonNEz8H9v3LFGTyumGjKCLHVmPUDLSF9p77oGy0m837dbohqcAwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5643
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270138
X-Proofpoint-GUID: iTYopX4Aax6GFmbbo0_gx8HywQsf0gvA
X-Proofpoint-ORIG-GUID: iTYopX4Aax6GFmbbo0_gx8HywQsf0gvA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXByIDI3LCAyMDIyLCBhdCAzOjA2IFBNLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhA
bGludXRyb25peC5kZT4gd3JvdGU6DQo+IA0KPiBQcmFrYXNoLA0KPiANCj4gT24gTW9uLCBBcHIg
MTggMjAyMiBhdCAxODo1MSwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+IEBAIC0xOTk1LDcg
KzE5OTUsMTAgQEAgbG9uZyBfX2RvX3NlbXRpbWVkb3AoaW50IHNlbWlkLCBzdHJ1Y3Qgc2VtYnVm
ICpzb3BzLA0KPj4gCWludCBtYXgsIGxvY2tudW07DQo+PiAJYm9vbCB1bmRvcyA9IGZhbHNlLCBh
bHRlciA9IGZhbHNlLCBkdXBzb3AgPSBmYWxzZTsNCj4+IAlzdHJ1Y3Qgc2VtX3F1ZXVlIHF1ZXVl
Ow0KPj4gLQl1bnNpZ25lZCBsb25nIGR1cCA9IDAsIGppZmZpZXNfbGVmdCA9IDA7DQo+PiArCXVu
c2lnbmVkIGxvbmcgZHVwID0gMDsNCj4+ICsJa3RpbWVfdCBleHBpcmVzOw0KPj4gKwlpbnQgdGlt
ZWRfb3V0ID0gMDsNCj4gDQo+IGJvb2wgcGVyaGFwcz8NCg0KU3VyZSwgd2lsbCBjaGFuZ2UgdGhh
dC4NCg0KPiANCj4+ICsJc3RydWN0IHRpbWVzcGVjNjQgZW5kX3RpbWU7DQo+PiANCj4+IAlpZiAo
bnNvcHMgPCAxIHx8IHNlbWlkIDwgMCkNCj4+IAkJcmV0dXJuIC1FSU5WQUw7DQo+PiBAQCAtMjAw
OCw3ICsyMDExLDkgQEAgbG9uZyBfX2RvX3NlbXRpbWVkb3AoaW50IHNlbWlkLCBzdHJ1Y3Qgc2Vt
YnVmICpzb3BzLA0KPiANCj4gV2hpbGUgYXQgaXQsIGNhbiB5b3UgcGxlYXNlIHJlcGxhY2UgdGhl
IG9wZW4gY29kZWQgdmFsaWRhdGlvbiBvZiB0aW1lb3V0DQo+IHdpdGggdGltZXNwZWM2NF92YWxp
ZCgpPw0KDQpXaWxsIGRvDQoNCj4gDQo+PiAJCQllcnJvciA9IC1FSU5WQUw7DQo+PiAJCQlnb3Rv
IG91dDsNCj4+IAkJfQ0KPj4gLQkJamlmZmllc19sZWZ0ID0gdGltZXNwZWM2NF90b19qaWZmaWVz
KHRpbWVvdXQpOw0KPj4gKwkJa3RpbWVfZ2V0X3RzNjQoJmVuZF90aW1lKTsNCj4+ICsJCWVuZF90
aW1lID0gdGltZXNwZWM2NF9hZGRfc2FmZShlbmRfdGltZSwgKnRpbWVvdXQpOw0KPj4gKwkJZXhw
aXJlcyA9IHRpbWVzcGVjNjRfdG9fa3RpbWUoZW5kX3RpbWUpOw0KPiANCj4gQ29udmVydGluZyB0
byBrdGltZSBmaXJzdCBtYWtlcyB0aGlzIGNoZWFwZXI6DQo+IA0KPiAgICAgICAgICAgICAgICBl
eHBpcmVzID0ga3RpbWVfZ2V0KCkgKyB0aW1lc3BlYzY0X3RvX25zKHRpbWVvdXQpOw0KDQpTaW5j
ZSB1c2VyIHByb3ZpZGVkIHRpbWVzcGVjIGlzIGFkZGVkIHRvIGN1cnJlbnQgdGltZSwgc2hvdWxk
buKAmXQgaXQgY2hlY2sgZm9yIG92ZXJmbG93Pw0KDQpTbywgcGVyaGFwcyANCg0KCQlleHBpcmVz
ID0ga3RpbWVfYWRkX3NhZmUoa3RpbWVfZ2V0KCksIHRpbWVzcGVjNjRfdG9fbnModGltZW91dCkp
Ow0KDQo+IA0KPiBMZXNzIGNvZGUgbGluZXMgYW5kIHNob3J0ZXIgZXhlY3V0aW9uIHRpbWUgYmVj
YXVzZSBhZGRpbmcgc2NhbGFycyBpcw0KPiBvYnZpb3VzbHkgY2hlYXBlciB0aGFuIGFkZGluZyB0
aW1lc3BlY3MuDQo+IA0KPiBOb3cgaWYgeW91IGFkZDoNCj4gDQo+ICAgICAgIGt0aW1lX3QgZXhw
aXJlcywgKmV4cCA9IE5VTEw7DQo+IA0KPiB0aGVuIHlvdSBjYW4gZG8gaGVyZToNCj4gDQo+ICAg
ICAgICAgICAgICAgIGV4cCA9ICZleHBpcmVzOw0KPj4gCX0NCj4+IA0KPj4gDQo+PiBAQCAtMjE2
Nyw3ICsyMTcyLDkgQEAgbG9uZyBfX2RvX3NlbXRpbWVkb3AoaW50IHNlbWlkLCBzdHJ1Y3Qgc2Vt
YnVmICpzb3BzLA0KPj4gCQlyY3VfcmVhZF91bmxvY2soKTsNCj4+IA0KPj4gCQlpZiAodGltZW91
dCkNCj4+IC0JCQlqaWZmaWVzX2xlZnQgPSBzY2hlZHVsZV90aW1lb3V0KGppZmZpZXNfbGVmdCk7
DQo+PiArCQkJdGltZWRfb3V0ID0gIXNjaGVkdWxlX2hydGltZW91dF9yYW5nZSgmZXhwaXJlcywN
Cj4+ICsJCQkJCQljdXJyZW50LT50aW1lcl9zbGFja19ucywNCj4+ICsJCQkJCQlIUlRJTUVSX01P
REVfQUJTKTsNCj4+IAkJZWxzZQ0KPj4gCQkJc2NoZWR1bGUoKTsNCj4gDQo+IGFuZCB0aGlzIGNh
biBiZSBzaW1wbGlmaWVkIHRvOg0KPiANCj4gICAgICAgICAgICAgICAgdGltZWRfb3V0ID0gIXNj
aGVkdWxlX2hydGltZW91dF9yYW5nZShleHAsIGN1cnJlbnQtPnRpbWVyX3NsYWNrX25zLA0KPiAJ
CQkJCQkgICAgICBIUlRJTUVSX01PREVfQUJTKQ0KPiANCj4gc2NoZWR1bGVfaHJ0aW1lb3V0X3Jh
bmdlKCkgZGlyZWN0bHkgaW52b2tlcyBzY2hlZHVsZSgpIHdoZW4gQGV4cCA9PSBOVUxMDQo+IGFu
ZCByZXR1cm5zICE9IDAgd2hlbiB3b2tlbiB1cCBpbiB0aGF0IGNhc2UuDQoNClN1cmUgdGhhdCBt
YWtlcyBpdCBjbGVhbmVyDQoNCj4gDQo+PiBAQCAtMjIxMCw3ICsyMjE3LDcgQEAgbG9uZyBfX2Rv
X3NlbXRpbWVkb3AoaW50IHNlbWlkLCBzdHJ1Y3Qgc2VtYnVmICpzb3BzLA0KPj4gCQkvKg0KPj4g
CQkgKiBJZiBhbiBpbnRlcnJ1cHQgb2NjdXJyZWQgd2UgaGF2ZSB0byBjbGVhbiB1cCB0aGUgcXVl
dWUuDQo+PiAJCSAqLw0KPj4gLQkJaWYgKHRpbWVvdXQgJiYgamlmZmllc19sZWZ0ID09IDApDQo+
PiArCQlpZiAodGltZW91dCAmJiB0aW1lZF9vdXQpDQo+IA0KPiBhbmQgdGhpcyBiZWNvbWVzDQo+
IA0KPiAgICAgICAgICAgICAgICBpZiAodGltZWRfb3V0KQ0KPiANCj4+IAkJCWVycm9yID0gLUVB
R0FJTjsNCj4+IAl9IHdoaWxlIChlcnJvciA9PSAtRUlOVFIgJiYgIXNpZ25hbF9wZW5kaW5nKGN1
cnJlbnQpKTsgLyogc3B1cmlvdXMgKi8NCj4gDQo+IEhtbT8NCj4gDQo+IERvbmUgcmlnaHQsIHlv
dSBzaG91bGQgZW5kIHVwIHdpdGggYSBuZWdhdGl2ZSBkaWZmc3RhdCA6KQ0KDQpUaGFua3MgZm9y
IHRoZSByZXZpZXcuDQpXaWxsIHNlbmQgb3V0IHVwZGF0ZSBwYXRjaC4NCg0KLVByYWthc2gNCg0K
DQo+IA0KPiBUaGFua3MsDQo+IA0KPiAgICAgICAgdGdseA0KDQo=
