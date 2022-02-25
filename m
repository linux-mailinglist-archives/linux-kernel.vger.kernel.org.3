Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7CE4C4764
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiBYO0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiBYO0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:26:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D320F1F981D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:25:42 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PDdKhH018157;
        Fri, 25 Feb 2022 14:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=56MZ0bQkCT1KW4gWtVKrpD0PJk63Kt3qYvW38gb/ZsU=;
 b=h6lwIJEyWbLy5DcjLxDJhrk+im/kzRL3cNniRnXGHGmAoU72U4DQCfyE54vK5Arb8gpx
 vr+GfWgRSy9nJQc/PXeVQcj0VOQFzr6zjHmNSz/rktPv8dv2XIDYPZKSiGFxEDH+/zTo
 s5VCthwcQvjaxlAS/NglhJ7VZgzyM8KxthyIEGZFFVl89YO/MHlg1LDEj9gZmEN9IeCP
 juhzTKolf0ZTaNWZRpUjLbHKSCM62fw2jaFoWS5r8jeYo98+N9YtPyFjNF6bLc1jrYkp
 xYco4q/YiY5pKIkzeEZO247K8HKZC7m+g7f4aavHNhY+KHjcs/mxuuNTR0kljPigUWGK AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ef06b0ahk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 14:25:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PEAaaZ002242;
        Fri, 25 Feb 2022 14:25:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3020.oracle.com with ESMTP id 3eb484wxty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 14:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCaHnD6ZNbka6kwXyMimfxlNHIo65bz7RntjORXeehLywBrBUr2CVOpcuqF3wkn5rNMn7PBK3JH/KiopB5XNLLNdtFgvVZT0jJWps071OFLsPTEc3TNoRofQJWQz4VjTIB+aN9znJRGZqloyWVYOofuBCqcxBem18jmcPsxlQQgxjWhdFC0VP7rJfT9mrmAeE7+z+3QbZHdboD3Dufa4dXwraiKIswhHYtMrAPnWD0G24fDvA6cc5vFhUagAX87bhDj94ufQNridC7uFc3QY33mH5a29tGSg0hI6WcsFSsWF+ckWOqixDRLOPG+HLhiVeMsgemJTy9UH9aRoCKAGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56MZ0bQkCT1KW4gWtVKrpD0PJk63Kt3qYvW38gb/ZsU=;
 b=EwIoBZAcPEoZ0fL4beI0gp1OYtQnhNy1ax+V2FZ9EMZ69eys5ykM84PXEL3Q9UI3D0tKt6ByS3BLGvNbW8DN9j/9ECR3aPHuJ7YH0f0xsZ9Pd0HBdB1OZi4DZNit1F1FBhorCdO602EiLnICXcIykoOvO0lSGcQdZiQ7wi85zxZ/Gw1bJ/3hJmLQdeiIS2+HVjjy6Ui3rNOOESR8FiI5QRAf5FtgTmXgmQDPTj6ZYmp5j6NnIUpysjLzX2ufj0MKa7QSjESNVIzkqdy0VckR1VqBaT6/ZvAdKJbfS/+0sKv2rbnhIF9ANiHQnT/jmxozKbKvoQLck9CppuWsSlDMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56MZ0bQkCT1KW4gWtVKrpD0PJk63Kt3qYvW38gb/ZsU=;
 b=pDpf+2z475enE00O5rHhHQ2afjwA8DNYlDQ0u3Vtp4ntpaSqU/VAFkcvHYMKU8X3sIZvZZERkoJERsuTh378MgxnPbAF3/4ZJ+/q+H/+PpY4rS3Uw+QJyyWDYhbABAj1wu2kWyWXhnOTHNToQ6Q0CSlCbilUVAlJTP568ECxnDU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4249.namprd10.prod.outlook.com (2603:10b6:5:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 14:24:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 14:24:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     =?utf-8?B?SmFrdWIgTWF0xJtuYQ==?= <matenajakub@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "riel@surriel.com" <riel@surriel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/4] Removing limitations of merging anonymous VMAs
Thread-Topic: [RFC PATCH 0/4] Removing limitations of merging anonymous VMAs
Thread-Index: AQHYJMIVB+iU2FnRZ0OtT1wm/ZCbV6yZsAGAgApsFYCAAEFJgA==
Date:   Fri, 25 Feb 2022 14:24:57 +0000
Message-ID: <20220225142449.akjqp5zja2cpvy4j@revolver>
References: <20220218122019.130274-1-matenajakub@gmail.com>
 <20220218192143.jdqcf4igcjpezmrz@revolver>
 <cf1f5f29-2be3-f9c9-f4d6-78a1bccf6e31@suse.cz>
In-Reply-To: <cf1f5f29-2be3-f9c9-f4d6-78a1bccf6e31@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 237386c1-ec0f-4e46-169a-08d9f86a99ca
x-ms-traffictypediagnostic: DM6PR10MB4249:EE_
x-microsoft-antispam-prvs: <DM6PR10MB424915E4F8C1C12D239F9528FD3E9@DM6PR10MB4249.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZdbSxzz8Zt4K6lLEh7uyh2etquCG4iqaU54IRbtdF7XXbZYKU+lJz6woLbKZG2y1YsIpyF9HiJDF/bY7IKLYgpr38F9eRTjAcBlw9mfFI8jwcJvQYxSkd3P7zfyFh5YajEJ3W4vFHaP1eYMVUT+CFhdjmsyV5UONlAibJ4fuxV2jngYgaCiIoPxhC/5EYPaCaRCGsPbDkohDm4OfppVvcueEj1N4ZWDbhx3UxagG2WD43YrsHQxdaBwM3IEjhxe3FTtk2z07hac3ncwSHvq78lqtSj7xhjGRKggnsWyvdGv9XqCZK/K7YXq7TIk27EHsuChYCTWuQRlN7+YDMzFgN/wZR2fsste5kwcOScdpAS6W2dci2N/4OK7XcQ0kNXpDXaEyPQS2FV8KG5p638s7a+PVJaANn6larCQyctdTVdVNWkxt7TmEC+0Uz0jODRhksNpv+yaW7kKIrYYfeoaj1FTvQnSlfEaRVzBDxN4TNV+DVwG+10Cxhkn0baRuJp0P5Ah6dtqGKjCiSmeUPiSzOT8ZCcwR6OvVJ65VH5sbwS70FZuF5dVJbPrYnRkBNQjce6Xr63wOxso/+EWGzBPVKm5ckju0JTIl83XluW/t/gCgbd7HtqXXgNc+A3I20yXd9eXx7FG7S2bKvoJ+LpJl00uYG6WxZKNBn0miDjFdFPGOumflDfEzEV577mgtJHc3Xq0NDjm35/oecRXcXHJ1uA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(64756008)(66446008)(5660300002)(66556008)(76116006)(66946007)(66574015)(6486002)(38070700005)(4326008)(8676002)(33716001)(66476007)(508600001)(6916009)(54906003)(316002)(44832011)(8936002)(91956017)(86362001)(7416002)(53546011)(2906002)(9686003)(71200400001)(1076003)(186003)(26005)(6506007)(6512007)(38100700002)(83380400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0VqZW1GMlpmOVRCTG9uUGwwbWZBM1FsNnI2eURYMVRUdC8xRUZkdTNUYmVw?=
 =?utf-8?B?SFdLdUJEMVNPT0VGNzZuVVErVXpLaFR2Q1l5ZzZ6NDVQdXpkbXhYbjVab0lZ?=
 =?utf-8?B?SE9CTVQyOG90NllENTVVb3JCeHJQOEZUUmxycGVQWUcrcmU2Z0VNdW5Nb1VK?=
 =?utf-8?B?eXZGZkdoWEtMTDlxK0d5VXEvNUtVTGdyTDBYdHdMbGkzV2FvZU9Qc1ZIczBH?=
 =?utf-8?B?VWFLNGRkUXZJZjJ0MisxN05IVVZQT3JtaHBJdisvaWNoQ1NnMTB2VHB2MWNr?=
 =?utf-8?B?L29yQ2dnZlAxRWh5RkF0ampPb1dmdTNnNmNHYnMvS0VVb0NhbnpvRW9ldVM1?=
 =?utf-8?B?MjNRb3VmQ1dISWQ3aUxVSmRNVWNEeGx1dzEweXY2YmRiRWNDREc4bVlEdDJt?=
 =?utf-8?B?NUhvUklWRnhFME1vV3V2Q040TWdybnJaVWM3K3BYVkQrU054N2VCVVYzSW91?=
 =?utf-8?B?aDBMZFhIM3A4WTY4cEpyTW5GVEZMemRyL0g0WlhySGxoWkw5UHFGanJtVjNa?=
 =?utf-8?B?OHNWdVpITWdyckdkMDloajY3cFpVNWFESWUxK2sybllsZXRleE5VN3Vsb1VZ?=
 =?utf-8?B?dStyOXV0bFNxSGFXQ1NqbVN1cHNYVzFMa1pHMTZNZTZDalc3b0N5UmdrQ2NL?=
 =?utf-8?B?QXBhS1JyWEEvZnhQMDBKOC9CSFBaakhPM3hjS1BIU0xDQXQyWFUrdlZoSjlE?=
 =?utf-8?B?OENKRzNwRmh3QlFmZE5CQ3IvRUpHOVhuU3dNUU51WjZreitTUjZUOTdvNC9B?=
 =?utf-8?B?R2JpUFYxaDY1bkM3WktLcld1bW9VS2RhS0VzZWpKa3VrQlpSanNDS1pHY3Jj?=
 =?utf-8?B?a05RbndwRTNSeS9rQUNZbVl4RlBsM0s1RTkzZnFGRmg0OUVMcHhENU45NzRn?=
 =?utf-8?B?SnNWUEhwZjF2aGtVaXpFbEpTa2hwY0hWQXZkNUp6WW5TUnhGYXJ4Zm9VdlJB?=
 =?utf-8?B?Y0w3U3JOTEFYd2d2RVdjVjdiZXVWMWR3LzRCTWN3SnlRWlR3MzZlQ3BMK0Zy?=
 =?utf-8?B?a21uK2FiSkZlOFhNdU1FRVkvZ3o5VlpCZWNKdW85SzdsWnNGbDFTYTM4MVlT?=
 =?utf-8?B?eURPUGhjMjdqYjZyM0N5YmxXSmhWN0JrVEl6b1BiY05KbmFCcW1BZkJvK0F0?=
 =?utf-8?B?OW5Cam1yL0JudE9Zd3pXOW50RE1tQUJoVmJDdi9SR1NRdGFIZzVnMlJxcGJy?=
 =?utf-8?B?Y3FxSWFUNmEwcFEzckFwQk55c09wN2FvaHplZStBSVlzSlF3QloyZmx0bFcr?=
 =?utf-8?B?RHY3SWdqOVhjNUZWcXRxeTVXQUM2YURMZWM5NWRidm1WR1F4ZmtJbXBRRjdq?=
 =?utf-8?B?d2toZmFwRFljd0RYUmJkM0xBSkRiSllOWUxNelJJUEh5Wms0ZGlQWkF6OHJ6?=
 =?utf-8?B?L0xFd090amo2WmJHdGgycVRHdHBpcm9HeVZ5YVFjc1lJT2pFem5ka0lVKzVF?=
 =?utf-8?B?L1k0OGtHOFpZYlZVZ2E4ZkExTTJnNloxUjFqeStFaG4rNGpYU0p1VWMxdncr?=
 =?utf-8?B?QVdtSjhCdklSd0pMTWFwZHpLSDVZb0dvTitRdDhRZk1QOXhLTy84ckg4cG9s?=
 =?utf-8?B?aFBmdm1sT0V2YkVsbXUrdU9FVEZmRGVJdzd1TmhLMGxSYTI3ZlYxRUN4dGx4?=
 =?utf-8?B?ajQ3bmc2SFZiQy9ac0E5TkhPOENDdkUwYkhFMXRrZGJEMng1SWtpcWtVOUl1?=
 =?utf-8?B?a1NZY01OMW9yRmlQeUhSM2hVT3VSa2REMHNjT1BEcmd3L0hBbEVIMXYwVElL?=
 =?utf-8?B?UEtsdUhvL290Q3k2Smw1TkJnK3gyblR5VmVjMnp2TW5meGI1MVoyYjFDTmw1?=
 =?utf-8?B?aG5TeHpnVTQ3elVNSXZ2K0V4SXBYZUxJSTI4d0VhUmM4aFErT2F3ZXRNSGJY?=
 =?utf-8?B?RXpDYUxhM2ZnQmF3dEsra3BhZDUxL2xBWUU4MnQ5WW52dXRqTEFGcU56dW05?=
 =?utf-8?B?SkNCb0RLZVVwUGVQL2hpNGZYalZSMVhzS3ZxV3plNVR4MUJyaUNaZUQzU2tH?=
 =?utf-8?B?LzBhdi8yZGJ2RnIvaTV3c1FxWk5ERG5TcjJudnp6SEVzV1QyUTltM1J5WUR0?=
 =?utf-8?B?anJ5ZVVOaXpKN05mVEphc3VOZCtNeFRoUkRDbzcwdnYrUTk2YXNrcDltcGhF?=
 =?utf-8?B?U3o1L1NCUHpDZ240RXc5bFVHelVXa0o0TmF4OWlnTlNjTlh0VGhYSmxyZjNz?=
 =?utf-8?Q?3jPZIR7F0/zvgIOHNxnCHYg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD924BE3E8E98546826CF13D90C125CA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237386c1-ec0f-4e46-169a-08d9f86a99ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 14:24:57.9390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfyusYAlmKPQ5gGEtcJ5ZPEHnxhhAJUOh/TF0odKuKcQu5Rs2FN/bZiBSPhkbPTnoA9yZzNLb3B7tks31Zxqeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4249
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=835 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250083
X-Proofpoint-ORIG-GUID: _4BMOumKpmDXlfdTDCWuoVoeP7Qp4Mzw
X-Proofpoint-GUID: _4BMOumKpmDXlfdTDCWuoVoeP7Qp4Mzw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6PiBbMjIwMjI1IDA1OjMxXToNCj4gT24g
Mi8xOC8yMiAyMDoyMSwgTGlhbSBIb3dsZXR0IHdyb3RlOg0KPiA+ICogSmFrdWIgTWF0xJtuYSA8
bWF0ZW5hamFrdWJAZ21haWwuY29tPiBbMjIwMjE4IDA3OjIxXToNCj4gPj4gTW90aXZhdGlvbg0K
PiA+PiBJbiB0aGUgY3VycmVudCBrZXJuZWwgaXQgaXMgaW1wb3NzaWJsZSB0byBtZXJnZSB0d28g
YW5vbnltb3VzIFZNQXMNCj4gPj4gaWYgb25lIG9mIHRoZW0gd2FzIG1vdmVkLiBUaGF0IGlzIGJl
Y2F1c2UgVk1BJ3MgcGFnZSBvZmZzZXQgaXMNCj4gPj4gc2V0IGFjY29yZGluZyB0byB0aGUgdmly
dHVhbCBhZGRyZXNzIHdoZXJlIGl0IHdhcyBjcmVhdGVkIGFuZCBpbg0KPiA+PiBvcmRlciB0byBt
ZXJnZSB0d28gVk1BJ3MgcGFnZSBvZmZzZXRzIG5lZWQgdG8gZm9sbG93IHVwLg0KPiA+PiBBbm90
aGVyIHByb2JsZW0gd2hlbiBtZXJnaW5nIHR3byBWTUEncyBpcyB0aGVpciBhbm9uX3ZtYS4gSW4N
Cj4gPj4gY3VycmVudCBrZXJuZWwgdGhlc2UgYW5vbl92bWFzIGhhdmUgdG8gYmUgdGhlIG9uZSBh
bmQgdGhlIHNhbWUuDQo+ID4+IE90aGVyd2lzZSBtZXJnZSBpcyBhZ2FpbiBub3QgYWxsb3dlZC4N
Cj4gPj4gTWlzc2VkIG1lcmdlIG9wcG9ydHVuaXRpZXMgaW5jcmVhc2UgdGhlIG51bWJlciBvZiBW
TUFzIG9mIGEgcHJvY2Vzcw0KPiA+PiBhbmQgaW4gc29tZSBjYXNlcyBjYW4gY2F1c2UgcHJvYmxl
bXMgd2hlbiBhIG1heCBjb3VudCBpcyByZWFjaGVkLg0KPiA+IA0KPiA+IERvZXMgdGhpcyByZWFs
bHkgaGFwcGVuIHRoYXQgbXVjaD8gIElzIGl0IHdvcnRoIHRyeWluZyBldmVuIGhhcmRlciB0bw0K
PiANCj4gTGV0IG1lIHBlcmhhcHMgY2xhcmlmeS4gTWF5YmUgbm90IGluIGdlbmVyYWwsIGJ1dCBz
b21lIG1yZW1hcCgpIGhlYXZ5DQo+IHdvcmtsb2FkcyBmcmFnbWVudCBWTUEgc3BhY2UgYSBsb3Qs
IGhhdmUgdG8gaW5jcmVhc2UgdGhlIHZtYSBsaW1pdHMgZXRjLg0KPiBXaGlsZSB0aGUgb3JpZ2lu
YWwgbW90aXZhdGlvbiB3YXMgYSBwcm9wcmlldGFyeSB3b3JrbG9hZCwgdGhlcmUgYXJlIGUuZy4N
Cj4gYWxsb2NhdG9ycyBzdWNoIGFzIGplbWFsbG9jIHRoYXQgcmVseSBvbiBtcmVtYXAoKS4NCj4g
DQo+IEJ1dCB5ZXMsIGl0IG1pZ2h0IHR1cm4gb3V0IHRoYXQgdGhlIGJlbmVmaXQgaXMgbm90IHVu
aXZlcnNhbCBhbmQgd2UgbWlnaHQNCj4gY29uc2lkZXIgc29tZSB3YXlzIHRvIG1ha2UgbW9yZSBh
Z2dyZXNzaXZlIG1lcmdpbmcgb3B0LWluLg0KPiANCj4gPiBtZXJnZSBWTUFzPyAgSSBhbSBub3Qg
cmVhbGx5IHN1cmUgdGhlIFZNQSBtZXJnaW5nIHRvZGF5IGlzIHdvcnRoIGl0IC0gd2UNCj4gPiBh
cmUgdW5kZXIgYSBsb2NrIGtub3duIHRvIGJlIGEgYm90dGxlbmVjayB3aGlsZSBleGFtaW5pbmcg
aWYgaXQncw0KPiANCj4gSSdkIGJlIGFmcmFpZCB0aGF0IGJ5IHNjYWxpbmcgYmFjayBleGlzdGlu
ZyBtZXJnaW5nIHdvdWxkIGJyZWFrIHNvbWUNCj4gdXNlcnNwYWNlIGV4cGVjdGF0aW9ucyBpbnNw
ZWN0aW5nIGUuZy4gL3Byb2MvcGlkL21hcHMNCg0KSXMgdGhhdCBhIHJpc2sgY29uc2lkZXJpbmcg
aG93IG1hbnkgdGhpbmdzIHN0b3AgdGhlIG1lcmdpbmcgb2YgVk1Bcz8gIFdlDQpqdXN0IGFkZGVk
IGFub3RoZXIgKG5hbWVzKS4gIE5vdCBhbGwgdGhlIGluZm9ybWF0aW9uIGNhbiBiZSBpbg0KL3By
b2MvcGlkL21hcHMgLSBvdGhlcndpc2UgdGhlIHRyYWNpbmcgcGF0Y2ggd291bGRuJ3QgcmVhbGx5
IGJlDQpuZWNlc3Nhcnk/DQoNCj4gDQo+ID4gcG9zc2libGUgdG8gbWVyZ2UuICBIYXJkIGRhdGEg
YWJvdXQgaG93IG9mdGVuIGFuZCB0aGUgY29zdCBvZiBtZXJnaW5nDQo+ID4gd291bGQgYmUgYSBn
b29kIGFyZ3VtZW50IHRvIHRyeSBoYXJkZXIgb3IgZ2l2ZSB1cCBlYXJsaWVyLg0KPiA+IA0KPiA+
PiANCj4gPj4gU29sdXRpb24NCj4gPj4gRm9sbG93aW5nIHNlcmllcyBvZiB0aGVzZSBwYXRjaGVz
IHNvbHZlcyB0aGUgZmlyc3QgcHJvYmxlbSB3aXRoDQo+ID4+IHBhZ2Ugb2Zmc2V0cyBieSB1cGRh
dGluZyB0aGVtIHdoZW4gdGhlIFZNQSBpcyBtb3ZlZCB0byBhDQo+ID4+IGRpZmZlcmVudCB2aXJ0
dWFsIGFkZHJlc3MgKHBhdGNoIDIpLiBBcyBmb3IgdGhlIHNlY29uZA0KPiA+PiBwcm9ibGVtIG1l
cmdpbmcgb2YgVk1BcyB3aXRoIGRpZmZlcmVudCBhbm9uX3ZtYSBpcyBhbGxvd2VkDQo+ID4+IChw
YXRjaCAzKS4gUGF0Y2ggMSByZWZhY3RvcnMgZnVuY3Rpb24gdm1hX21lcmdlIGFuZA0KPiA+PiBt
YWtlcyBpdCBlYXNpZXIgdG8gdW5kZXJzdGFuZCBhbmQgYWxzbyBhbGxvd3MgcmVsYXRpdmVseQ0K
PiA+PiBzZWFtbGVzcyB0cmFjaW5nIG9mIHN1Y2Nlc3NmdWwgbWVyZ2VzIGludHJvZHVjZWQgYnkg
dGhlIHBhdGNoIDQuDQo+ID4+IA0KPiA+PiBMaW1pdGF0aW9ucw0KPiA+PiBGb3IgYm90aCBwcm9i
bGVtcyBzb2x1dGlvbiB3b3JrcyBvbmx5IGZvciBWTUFzIHRoYXQgZG8gbm90IHNoYXJlDQo+ID4+
IHBoeXNpY2FsIHBhZ2VzIHdpdGggb3RoZXIgcHJvY2Vzc2VzICh1c3VhbGx5IGNoaWxkIG9yIHBh
cmVudA0KPiA+PiBwcm9jZXNzZXMpLiBUaGlzIGlzIGNoZWNrZWQgYnkgbG9va2luZyBhdCBhbm9u
X3ZtYSBvZiB0aGUgcmVzcGVjdGl2ZQ0KPiA+PiBWTUEuIFRoZSByZWFzb24gd2h5IGl0IGlzIG5v
dCBwb3NzaWJsZSBvciBhdCBsZWFzdCBub3QgZWFzeSB0bw0KPiA+PiBhY2NvbXBsaXNoIGlzIHRo
YXQgZWFjaCBwaHlzaWNhbCBwYWdlIGhhcyBhIHBvaW50ZXIgdG8gYW5vbl92bWEgYW5kDQo+ID4+
IHBhZ2Ugb2Zmc2V0LiBBbmQgd2hlbiB0aGlzIHBoeXNpY2FsIHBhZ2UgaXMgc2hhcmVkIHdlIGNh
bm5vdCBzaW1wbHkNCj4gPj4gY2hhbmdlIHRoZXNlIHBhcmFtZXRlcnMgd2l0aG91dCBhZmZlY3Rp
bmcgYWxsIG9mIHRoZSBWTUFzIG1hcHBpbmcNCj4gPj4gdGhpcyBwaHlzaWNhbCBwYWdlLiBHb29k
IHRoaW5nIGlzIHRoYXQgdGhpcyBjYXNlIGFtb3VudHMgb25seSBmb3INCj4gPj4gYWJvdXQgMS0z
JSBvZiBhbGwgbWVyZ2VzIChtZWFzdXJlZCBmb3IgaW50ZXJuZXQgYnJvd3NpbmcgYW5kDQo+ID4+
IGNvbXBpbGF0aW9uIHVzZSBjYXNlcykgdGhhdCBmYWlsIHRvIG1lcmdlIGluIHRoZSBjdXJyZW50
IGtlcm5lbC4NCj4gPiANCj4gPiBJdCBzb3VuZHMgbGlrZSB5b3UgaGF2ZSBkYXRhIGZvciBzb21l
IHVzZSBjYXNlcyBvbiB0aGUgbWVyZ2VycyBhbHJlYWR5Lg0KPiA+IERvIHlvdSBoYXZlIGFueSBy
ZXN1bHRzIG9uIHRoaXMgY2hhbmdlPw0KPiA+IA0KPiA+PiANCj4gPj4gVGhpcyBzZXJpZXMgb2Yg
cGF0Y2hlcyBhbmQgZG9jdW1lbnRhdGlvbiBvZiB0aGUgcmVsYXRlZCBjb2RlIHdpbGwNCj4gPj4g
YmUgcGFydCBvZiBteSBtYXN0ZXIncyB0aGVzaXMuDQo+ID4+IFRoaXMgcGF0Y2ggc2VyaWVzIGlz
IGJhc2VkIG9uIHRhZyB2NS4xNy1yYzQuDQo+ID4+IA0KPiA+PiBKYWt1YiBNYXTEm25hICg0KToN
Cj4gPj4gICBtbTogcmVmYWN0b3Igb2Ygdm1hX21lcmdlKCkNCj4gPj4gICBtbTogYWRqdXN0IHBh
Z2Ugb2Zmc2V0IGluIG1yZW1hcA0KPiA+PiAgIG1tOiBlbmFibGUgbWVyZ2luZyBvZiBWTUFzIHdp
dGggZGlmZmVyZW50IGFub25fdm1hcw0KPiA+PiAgIG1tOiBhZGQgdHJhY2luZyBmb3IgVk1BIG1l
cmdlcw0KPiA+PiANCj4gPj4gIGluY2x1ZGUvbGludXgvcm1hcC5oICAgICAgICB8ICAxNyArKy0N
Cj4gPj4gIGluY2x1ZGUvdHJhY2UvZXZlbnRzL21tYXAuaCB8ICA1NSArKysrKysrKysNCj4gPj4g
IG1tL2ludGVybmFsLmggICAgICAgICAgICAgICB8ICAxMSArKw0KPiA+PiAgbW0vbW1hcC5jICAg
ICAgICAgICAgICAgICAgIHwgMjMyICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LQ0KPiA+PiAgbW0vcm1hcC5jICAgICAgICAgICAgICAgICAgIHwgIDQwICsrKysrKysNCj4gPj4g
IDUgZmlsZXMgY2hhbmdlZCwgMjkwIGluc2VydGlvbnMoKyksIDY1IGRlbGV0aW9ucygtKQ0KPiA+
PiANCj4gPj4gLS0gDQo+ID4+IDIuMzQuMQ0KPiA+PiANCj4g
