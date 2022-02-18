Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434FB4BC0ED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiBRT7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:59:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239040AbiBRT7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:59:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5962F2C13E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:58:24 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IIr1YF023666;
        Fri, 18 Feb 2022 19:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hjl87c2+NC+8djn6u9YGCKcN7lWhhZYJ+IapYZ/5iJw=;
 b=PFvRHZyc1s3hMlVaeSlGBu5fLBPIr/+UUSipIrhmSKTKmGnXyGKVLU4rvc0oN10MsUxD
 7RgH1eWPL0/tcN5v6rHBg8A/Y11STB967ugUnS/124GAZPfFSbWkePgSfWAvSprbaOVu
 0VcZWd1qoKkaBYB8GwUm2s24gUL2oA2QS5XYtFpLSnB1JR9kOtb3P3WjW2Or4tQ+zLTB
 ksf/wcNSdArqe9dgCFnoTGqG3wWj1Yg4Uteu249gMcQ8cJRjvyM/OIfFLAxxksPgLUh2
 GTcefs6DpA0Oxow3GZA3+yC+D4lELoNG+KsYGHC/j6ywGqjhCC2ASCS58dPXKhMDEnXa ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nb3t29a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 19:57:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IJudtG162267;
        Fri, 18 Feb 2022 19:57:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3030.oracle.com with ESMTP id 3e9brea4un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 19:57:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahois7Dpn+BwOZLqBOmB7TWBeRSqqyKMJ5rUgOWdhXkGbntiVT2upc82FScBMR/6d0haBuJX1KeHr2cnjLBTCZCCEzhMHVjVfeSTKV8ckzqiWWnWMtaMcnWWKbaUzgNcL0IJyX87W3AgsFvMUG/hDYMBG/PxvAD2LVxCt+IOsHhsIcZp67IxhM8UiSXcdoCoEGyDUbxTSA5FthMRbFlA+5Xt+opK5yHp2bVEooCjRPwW2unzuRFt508KoSXs2KPXS4ss91qU8uVyUL737e/fqlVZ4e6uu3gicZQ5oHljMysoehenA88hVjhIsaU2UrQo6e71WttzLkjclxDlQMZ3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjl87c2+NC+8djn6u9YGCKcN7lWhhZYJ+IapYZ/5iJw=;
 b=Z7nDciKRXDJ1hCNg/p7bH/33WZ6iw7cY1d5zGJ7vnxSPrExkPg5ut0srMuYbk7LSwSmj2aobILkoZUL+MhCI8BoPMHeZhRMoRJl/pFbJLPCyurc48cgZK9dKQyTHfPY+/pUqonALbD45zS7J/9XgqXpRykYFZdsxsjYwj6q9fpQhSCtM+jK60a/6ZnPz6ZrU+yzvWPAstq7dzbIcREh4jXfubXWpV23Y5c/hPJxvgaksUhL/dJ+RAbS4fcUNuQkA+Yp0hWTt+RGQgG6Y5+UqiEmHhrH5QYMMtyPQLeRSggagx8KR+Vqk86w/QUFyxgovuPdOQzQfbdDyABnCRs0pGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjl87c2+NC+8djn6u9YGCKcN7lWhhZYJ+IapYZ/5iJw=;
 b=XbS36oGlDPuLZ+3DAoJNQ0iG3VIQ9AWZ3fFle2TZAhaJ7zhS9PpZ2gv9LBNbt1gMRWjC2fBgSim+mxvzxjVy9jaaJYoq5DBl2nREtLC33H6lyme63MwfOIF6ALKm0C449XDUOzEydbAPUIfMxB7JdZBiBKD3RDZoIFbJ8vpAvG0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB2583.namprd10.prod.outlook.com (2603:10b6:a02:b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 18 Feb
 2022 19:57:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4995.023; Fri, 18 Feb 2022
 19:57:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     =?utf-8?B?SmFrdWIgTWF0xJtuYQ==?= <matenajakub@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "riel@surriel.com" <riel@surriel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [RFC PATCH 4/4] [PATCH 4/4] mm: add tracing for VMA merges
Thread-Topic: [RFC PATCH 4/4] [PATCH 4/4] mm: add tracing for VMA merges
Thread-Index: AQHYJMIWwUhFsrN60kOTfTd4C42Vf6yZugmA
Date:   Fri, 18 Feb 2022 19:57:39 +0000
Message-ID: <20220218195729.oa5olrcsq6yox7hp@revolver>
References: <20220218122019.130274-1-matenajakub@gmail.com>
 <20220218122019.130274-5-matenajakub@gmail.com>
In-Reply-To: <20220218122019.130274-5-matenajakub@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcd48313-d6cf-47bb-deeb-08d9f318eadd
x-ms-traffictypediagnostic: BYAPR10MB2583:EE_
x-microsoft-antispam-prvs: <BYAPR10MB2583EDD88A356D02B42563D2FD379@BYAPR10MB2583.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KqeFzBAkj7G6OrkgUjpjW0KHfY5CjP23fxm10+0FlbfiyoeHga0u1gleiQ1TUl37iNelOgffcfcli92Atl11US6VM9McsmV7fFULyVCCmJNKWF/y4DaylesJ1NPpct7Cj1spXUp9FGD87te7i9VFhGjvSW0+LTmRs+DNh1yFhmjo/dM39c7td5R9UXdrptLmdrG1fF+XnPQ7AeNry76Z6iBiMIBE0Ef5TT0PCg9elawBRUPCwZtzfXQUleAvkoay4rvnX0rKnTFX48DvbfJwhEhwfreL0fvmBubiltp0riRZ9plxWFEWZ5cMIUtI2edBWKGJJB8TjlQSATWE7qhk5q5GB92wipRp6Q4MMs1V/5/q6gJQi2hI4iljLGFqE6q4Ek9tJffsQsX0onIV+aLqc+NFqrbOcuoAzOrOVYuT6IWCy6nKTj+qmLm+jmJddnShWETCNfmPF2G3ssDXqxayjK/2DEz05VHajebGox1kEPsPj8jxUN3ZZO3yd+dv33nthKdz4QFxzxtueBjU7LwJJE2sBkCkF7Ow0hyjkGbO0+ELgMpyuxIz5cNk2OosJ5SHJeJwLK6RBeRawilPkrocn55o8Rx+NKqq4MUHbHcy9jQH22YRa+QE33mnnbUuMGrEMTfJZ1/whn/zUYiGc6WNAA1Jrk93L9gkEGAdgDSvHnFhbkj/U+BCj6erxhdfnznoRhittkO7hxiUjeH3p2yrtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(71200400001)(9686003)(7416002)(186003)(6512007)(83380400001)(44832011)(508600001)(6486002)(66446008)(86362001)(26005)(8936002)(6506007)(5660300002)(76116006)(38100700002)(66946007)(4326008)(66476007)(8676002)(66556008)(64756008)(91956017)(1076003)(38070700005)(122000001)(54906003)(33716001)(66574015)(316002)(6916009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHQvWDRoVElkcHhDSUw3RkM5Wk8yWkZVTUl6VHF6bkJTdDJrdzUxR1hXcW53?=
 =?utf-8?B?VGRyWHZnOVliUVRCTUdFVS9XcHovdEJ2TnNWOGhWWmp0L0gvSnNjdjNEc0VC?=
 =?utf-8?B?bHRIVGJpbzN6WjVZbVVqNDJodnY2YkpPeW9UU1pLb3FZYWh6YTZqcm0ybGdE?=
 =?utf-8?B?QlY1a3FpcDFBdVBkMzZJb0hZU1hGZ0xvZGE5aDNjbWdtbmVtMnJyMHlGYU5m?=
 =?utf-8?B?TXhqdnZWZnJzdXFUaCtVY0tZaEVwRGtuM2s2dXRVUnVwLzNIdlBQb2U3MXhm?=
 =?utf-8?B?TW5SRVUvTEswb2RMTnR1a1Nkbjg1MmlVbkhhL2NQSzVIK0VWaW90ekVDRUFB?=
 =?utf-8?B?SFQ2bCs5WnpRUGp1anVBZ2pGWitMVUdneDRCZEtkNXNYN2hKN0RwcjlXK0Fl?=
 =?utf-8?B?OGxNWUxqU05Ram8xdXJLeFh6NThsZzJMVGtPUWVnZnFiZ0dWak1OS1A4cXl6?=
 =?utf-8?B?STVxWTVoZmU5aDFwWWxDTzUyNHUvbWFiaExDL0p0cXdnK0EwM0NDWUhLMHlu?=
 =?utf-8?B?V1l6bXJHTllmTU00anFPZS9LbDRWMXNVSDFPYlJHM2FnbGdFYzZvQ1d4OGNF?=
 =?utf-8?B?akFBejRyQzFmMWNjRlR4RUxmWGN0cXEwOGhSWXFaZmMwR1k1ZFdsdkxhOHNS?=
 =?utf-8?B?ckEvRUQzbHcyZzRBMjN5VHNZcHZnSDcrSGVpV2Q0UGpxVGEraFRhUWhJVjRS?=
 =?utf-8?B?TnNFdjF6ZU5IL2EzMFNsRHB1VHZucXlDeHU3Mi9QUjlubHpjYUFwWElrNHRo?=
 =?utf-8?B?WlAzdzRZeEFWand6Szg0aHRPK0pGK3FUUVUxQllmQldRYnlKTlZINGVFWGtI?=
 =?utf-8?B?QXQvQjJPeXd0Q1lkTU9PNDBhQUIyNnNBR0NwUWIwbkVYN2g3YnFHZ1hxNnhv?=
 =?utf-8?B?c0lsQWhNaWNuSGtYNy9xV25ycHFOckV3UjE3OWlvYVBZWVZXSTFQbEhwanlW?=
 =?utf-8?B?SUh1eStMbzZVMVpTdFJuZHRGU0FzYVVHbjJibUl6ZVViQTZWblIyUVNXZ1Nk?=
 =?utf-8?B?ZHlSTjF5b3hnZkNBc3hzOXM1K3NhdEZSdUt6Q3JUTGFCWWdzM3BwOEs4c0t5?=
 =?utf-8?B?ejc1Tk9VZmh0bWZGekxNVlA2UXpPRTNZbkY2LzlldzlFM210YnhRVnRUbVJy?=
 =?utf-8?B?andiVU5ETEdPaEtuZ2JBRXdGNTJ3OU1BdWtpOWFUa2dnWlloNWRwM21Qc29o?=
 =?utf-8?B?dFpjM0g2QUpBaWhjNitCMVNOL3F5OFFRV1VUOXhsK0RXejJ6eGxEV2o2ay9l?=
 =?utf-8?B?QmE3dXhCbXNYT2dwVDhPUDhwS3BvaFN6UGh2dVU3YjBBNVVCNDN2VUZCSkMv?=
 =?utf-8?B?SVNHRFVZWTBsSkJMclBVTk5HY3pFSkZ4MlkrZEU3OEFnSnE1bW5rYUhpNHdq?=
 =?utf-8?B?U3d5L0lGMzRTZlVGaENreTZJRVhHcm1wOUdhTkJFVDFnL202QTEvUkN4SnF0?=
 =?utf-8?B?MGhLaWhsOFcybG5BUUo4TVlndURnRGtWMmdzYXVFci9nNXVZK09Zck9vaXdy?=
 =?utf-8?B?SjFOMERsY1B6YUlaRi9ONGUzR0JxaS9mOE1kWWtGMmZLN1ZmQ3dRVWpSaklz?=
 =?utf-8?B?SjJzWkd1dmZtWVAvV2xWSHIvdE9GNkxhVFlIdEZLYW5RUlVhVlRTMTZMbGh0?=
 =?utf-8?B?V2VuZ1NFQzNaSkdTZVZvWHl2c21kV3lPa2pYVGNLMzh4ODJ3SXVKNzJURjUw?=
 =?utf-8?B?WkprcXBuVWY0SG1FZUZPTzltUlVzTTBhK3NrUXd0eXRBanQzdFlTYVV5bmNp?=
 =?utf-8?B?RUJCNkFhTEdFWllNdzQ0ZGNzb0tFNnVacXVBNWJKVmVlMlk5NHZreGw5UE1o?=
 =?utf-8?B?Q1I2WU45UE9IUUhRWXd0ZE5EMUZqYno1RDdKMGY1WVU5WFNVVGN2UlUwUUNs?=
 =?utf-8?B?M2FKMmdqc0hkNlphWVY4TXpnckVPTlJIYUV1RTg0d3FPSXZWMDZYS0MyQWFk?=
 =?utf-8?B?MGxQV1JUeHh0aURobUJreE14ZTNIRktXVW1nV2J0NGQ4RmdpNjJEd3FPWkVS?=
 =?utf-8?B?cUtocnNEM2I1b1ZVRGRTcDIvaW5jVHZqTkE1RmRiTVVFYjY2OGxXa3BrbldE?=
 =?utf-8?B?bUEycCt6QTNiUGx4dmErb3ZWaVBoS0k4OEdLVWNtNUE3aXFSdVFiaTZrUzlD?=
 =?utf-8?B?M0ZoVlg4eUVaTEFaZXQvWU9CUEo0UXpkem9VeVUwdXJaa1FXU1JBVTBMQkJV?=
 =?utf-8?Q?6uSfUGfM7MIgVNK+08x/mY4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27AAB29B0F222D479918062B2AEFC48C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd48313-d6cf-47bb-deeb-08d9f318eadd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 19:57:39.3872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gc8VIlhNhzXq7jqDmcpenOg6sP+vX7fDa0CzqsmMme21NSh00Ifc3D5tlgSfi9GlhXiz3DC2FS17BR9jguLy9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2583
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10262 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180122
X-Proofpoint-GUID: RnSPh7ofShrX2M-iZJUDZvK09Q8VcCcQ
X-Proofpoint-ORIG-GUID: RnSPh7ofShrX2M-iZJUDZvK09Q8VcCcQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KiBKYWt1YiBNYXTEm25hIDxtYXRlbmFqYWt1YkBnbWFpbC5jb20+IFsyMjAyMTggMDc6MjFdOg0K
PiBBZGRzIHRyYWNlIHN1cHBvcnQgZm9yIHZtYV9tZXJnZSB0byBtZWFzdXJlIHN1Y2Nlc3NmdWwg
YW5kIHVuc3VjY2Vzc2Z1bA0KPiBtZXJnZXMgb2YgdHdvIFZNQXMgd2l0aCBkaXN0aW5jdCBhbm9u
X3ZtYXMgYW5kIGFsc28gdHJhY2Ugc3VwcG9ydCBmb3INCj4gbWVyZ2VzIG1hZGUgcG9zc2libGUg
YnkgdXBkYXRlIG9mIHBhZ2Ugb2Zmc2V0IG1hZGUgcG9zc2libGUgYnkgYSBwcmV2aW91cw0KPiBw
YXRjaCBpbiB0aGlzIHNlcmllcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpha3ViIE1hdMSbbmEg
PG1hdGVuYWpha3ViQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRlL3RyYWNlL2V2ZW50cy9t
bWFwLmggfCA1NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgbW0vaW50ZXJu
YWwuaCAgICAgICAgICAgICAgIHwgMTEgKysrKysrKw0KPiAgbW0vbW1hcC5jICAgICAgICAgICAg
ICAgICAgIHwgNjMgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMyBm
aWxlcyBjaGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS90cmFjZS9ldmVudHMvbW1hcC5oIGIvaW5jbHVkZS90cmFjZS9l
dmVudHMvbW1hcC5oDQo+IGluZGV4IDQ2NjFmN2JhMDdjMC4uOWY2NDM5ZTJlZDJkIDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL3RyYWNlL2V2ZW50cy9tbWFwLmgNCj4gKysrIGIvaW5jbHVkZS90cmFj
ZS9ldmVudHMvbW1hcC5oDQo+IEBAIC02LDYgKzYsNyBAQA0KPiAgI2RlZmluZSBfVFJBQ0VfTU1B
UF9IDQo+ICANCj4gICNpbmNsdWRlIDxsaW51eC90cmFjZXBvaW50Lmg+DQo+ICsjaW5jbHVkZSA8
Li4vbW0vaW50ZXJuYWwuaD4NCj4gIA0KPiAgVFJBQ0VfRVZFTlQodm1fdW5tYXBwZWRfYXJlYSwN
Cj4gIA0KPiBAQCAtNDIsNiArNDMsNjAgQEAgVFJBQ0VfRVZFTlQodm1fdW5tYXBwZWRfYXJlYSwN
Cj4gIAkJX19lbnRyeS0+bG93X2xpbWl0LCBfX2VudHJ5LT5oaWdoX2xpbWl0LCBfX2VudHJ5LT5h
bGlnbl9tYXNrLA0KPiAgCQlfX2VudHJ5LT5hbGlnbl9vZmZzZXQpDQo+ICApOw0KPiArDQo+ICtU
UkFDRV9FVkVOVCh2bV9hdl9tZXJnZSwNCj4gKw0KPiArCVRQX1BST1RPKGludCBtZXJnZWQsIGVu
dW0gdm1hX21lcmdlX3JlcyBtZXJnZV9wcmV2LCBlbnVtIHZtYV9tZXJnZV9yZXMgbWVyZ2VfbmV4
dCwgZW51bSB2bWFfbWVyZ2VfcmVzIG1lcmdlX2JvdGgpLA0KPiArDQo+ICsJVFBfQVJHUyhtZXJn
ZWQsIG1lcmdlX3ByZXYsIG1lcmdlX25leHQsIG1lcmdlX2JvdGgpLA0KPiArDQo+ICsJVFBfU1RS
VUNUX19lbnRyeSgNCj4gKwkJX19maWVsZChpbnQsCQkJbWVyZ2VkKQ0KPiArCQlfX2ZpZWxkKGVu
dW0gdm1hX21lcmdlX3JlcywJcHJlZGVjZXNzb3JfZGlmZmVyZW50X2F2KQ0KPiArCQlfX2ZpZWxk
KGVudW0gdm1hX21lcmdlX3JlcywJc3VjY2Vzc29yX2RpZmZlcmVudF9hdikNCj4gKwkJX19maWVs
ZChlbnVtIHZtYV9tZXJnZV9yZXMsCXByZWRlY2Vzc29yX3dpdGhfc3VjY2Vzc29yX2RpZmZlcmVu
dF9hdikNCj4gKwkJX19maWVsZChpbnQsCQkJZGlmZl9jb3VudCkNCj4gKwkJX19maWVsZChpbnQs
CQkJZmFpbGVkX2NvdW50KQ0KPiArCSksDQo+ICsNCj4gKwlUUF9mYXN0X2Fzc2lnbigNCj4gKwkJ
X19lbnRyeS0+bWVyZ2VkID0gbWVyZ2VkID09IDA7DQo+ICsJCV9fZW50cnktPnByZWRlY2Vzc29y
X2RpZmZlcmVudF9hdiA9IG1lcmdlX3ByZXY7DQo+ICsJCV9fZW50cnktPnN1Y2Nlc3Nvcl9kaWZm
ZXJlbnRfYXYgPSBtZXJnZV9uZXh0Ow0KPiArCQlfX2VudHJ5LT5wcmVkZWNlc3Nvcl93aXRoX3N1
Y2Nlc3Nvcl9kaWZmZXJlbnRfYXYgPSBtZXJnZV9ib3RoOw0KPiArCQlfX2VudHJ5LT5kaWZmX2Nv
dW50ID0gKG1lcmdlX3ByZXYgPT0gQVZfTUVSR0VfRElGRkVSRU5UKQ0KPiArCQkrIChtZXJnZV9u
ZXh0ID09IEFWX01FUkdFX0RJRkZFUkVOVCkgKyAobWVyZ2VfYm90aCA9PSBBVl9NRVJHRV9ESUZG
RVJFTlQpOw0KPiArCQlfX2VudHJ5LT5mYWlsZWRfY291bnQgPSAobWVyZ2VfcHJldiA9PSBBVl9N
RVJHRV9GQUlMRUQpDQo+ICsJCSsgKG1lcmdlX25leHQgPT0gQVZfTUVSR0VfRkFJTEVEKSArICht
ZXJnZV9ib3RoID09IEFWX01FUkdFX0ZBSUxFRCk7DQo+ICsJKSwNCj4gKw0KPiArCVRQX3ByaW50
aygibWVyZ2VkPSVkIHByZWRlY2Vzc29yPSVkIHN1Y2Nlc3Nvcj0lZCBwcmVkZWNlc3Nvcl93aXRo
X3N1Y2Nlc3Nvcj0lZCBkaWZmX2NvdW50PSVkIGZhaWxlZF9jb3VudD0lZFxuIiwNCj4gKwkJX19l
bnRyeS0+bWVyZ2VkLA0KPiArCQlfX2VudHJ5LT5wcmVkZWNlc3Nvcl9kaWZmZXJlbnRfYXYsIF9f
ZW50cnktPnN1Y2Nlc3Nvcl9kaWZmZXJlbnRfYXYsDQo+ICsJCV9fZW50cnktPnByZWRlY2Vzc29y
X3dpdGhfc3VjY2Vzc29yX2RpZmZlcmVudF9hdiwNCj4gKwkJX19lbnRyeS0+ZGlmZl9jb3VudCwg
X19lbnRyeS0+ZmFpbGVkX2NvdW50KQ0KPiArDQo+ICspOw0KPiArDQo+ICtUUkFDRV9FVkVOVCh2
bV9wZ29mZl9tZXJnZSwNCj4gKw0KPiArCVRQX1BST1RPKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hLCBib29sIGFub25fcGdvZmZfdXBkYXRlZCksDQo+ICsNCj4gKwlUUF9BUkdTKHZtYSwgYW5v
bl9wZ29mZl91cGRhdGVkKSwNCj4gKw0KPiArCVRQX1NUUlVDVF9fZW50cnkoDQo+ICsJCV9fZmll
bGQoYm9vbCwJZmF1bHRlZCkNCj4gKwkJX19maWVsZChib29sLAl1cGRhdGVkKQ0KPiArCSksDQo+
ICsNCj4gKwlUUF9mYXN0X2Fzc2lnbigNCj4gKwkJX19lbnRyeS0+ZmF1bHRlZCA9IHZtYS0+YW5v
bl92bWE7DQo+ICsJCV9fZW50cnktPnVwZGF0ZWQgPSBhbm9uX3Bnb2ZmX3VwZGF0ZWQ7DQo+ICsJ
KSwNCj4gKw0KPiArCVRQX3ByaW50aygiZmF1bHRlZD0lZCB1cGRhdGVkPSVkXG4iLA0KPiArCQlf
X2VudHJ5LT5mYXVsdGVkLCBfX2VudHJ5LT51cGRhdGVkKQ0KPiArKTsNCj4gICNlbmRpZg0KPiAg
DQo+ICAvKiBUaGlzIHBhcnQgbXVzdCBiZSBvdXRzaWRlIHByb3RlY3Rpb24gKi8NCj4gZGlmZiAt
LWdpdCBhL21tL2ludGVybmFsLmggYi9tbS9pbnRlcm5hbC5oDQo+IGluZGV4IGQ4MDMwMDM5MmEx
OS4uYjNlNDgyMTc1NTE4IDEwMDY0NA0KPiAtLS0gYS9tbS9pbnRlcm5hbC5oDQo+ICsrKyBiL21t
L2ludGVybmFsLmgNCj4gQEAgLTM0LDYgKzM0LDE3IEBAIHN0cnVjdCBmb2xpb19iYXRjaDsNCj4g
IC8qIERvIG5vdCB1c2UgdGhlc2Ugd2l0aCBhIHNsYWIgYWxsb2NhdG9yICovDQo+ICAjZGVmaW5l
IEdGUF9TTEFCX0JVR19NQVNLIChfX0dGUF9ETUEzMnxfX0dGUF9ISUdITUVNfH5fX0dGUF9CSVRT
X01BU0spDQo+ICANCj4gKy8qDQo+ICsgKiBGb2xsb3dpbmcgdmFsdWVzIGluZGljYXRlIHJlYXNv
biBmb3IgbWVyZ2Ugc3VjY2VzcyBvciBmYWlsdXJlLg0KPiArICovDQo+ICtlbnVtIHZtYV9tZXJn
ZV9yZXMgew0KPiArCU1FUkdFX0ZBSUxFRCwNCj4gKwlBVl9NRVJHRV9GQUlMRUQsDQo+ICsJQVZf
TUVSR0VfU0FNRSwNCj4gKwlNRVJHRV9PSyA9IEFWX01FUkdFX1NBTUUsDQo+ICsJQVZfTUVSR0Vf
RElGRkVSRU5ULA0KPiArfTsNCj4gKw0KPiAgdm9pZCBwYWdlX3dyaXRlYmFja19pbml0KHZvaWQp
Ow0KPiAgDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgKmZvbGlvX3Jhd19tYXBwaW5nKHN0cnVjdCBm
b2xpbyAqZm9saW8pDQo+IGRpZmYgLS1naXQgYS9tbS9tbWFwLmMgYi9tbS9tbWFwLmMNCj4gaW5k
ZXggZWQ5MWQwY2QyMTExLi4xMGM3NmM2YTMyODggMTAwNjQ0DQo+IC0tLSBhL21tL21tYXAuYw0K
PiArKysgYi9tbS9tbWFwLmMNCj4gQEAgLTEwNjQsMjEgKzEwNjQsMjEgQEAgc3RhdGljIGlubGlu
ZSBpbnQgaXNfbWVyZ2VhYmxlX2Fub25fdm1hKHN0cnVjdCBhbm9uX3ZtYSAqYW5vbl92bWExLA0K
PiAgCSAqLw0KPiAgCWlmICgoIWFub25fdm1hMSB8fCAhYW5vbl92bWEyKSAmJiAoIXZtYSB8fA0K
PiAgCQlsaXN0X2lzX3Npbmd1bGFyKCZ2bWEtPmFub25fdm1hX2NoYWluKSkpDQo+IC0JCXJldHVy
biAxOw0KPiArCQlyZXR1cm4gQVZfTUVSR0VfU0FNRTsNCj4gIAlpZiAoYW5vbl92bWExID09IGFu
b25fdm1hMikNCj4gLQkJcmV0dXJuIDE7DQo+ICsJCXJldHVybiBBVl9NRVJHRV9TQU1FOw0KPiAg
CS8qDQo+ICAJICogRGlmZmVyZW50IGFub25fdm1hIGJ1dCBub3Qgc2hhcmVkIGJ5IHNldmVyYWwg
cHJvY2Vzc2VzDQo+ICAJICovDQo+ICAJZWxzZSBpZiAoKGFub25fdm1hMSAmJiBhbm9uX3ZtYTIp
ICYmDQo+ICAJCQkoYW5vbl92bWExID09IGFub25fdm1hMS0+cm9vdCkNCj4gIAkJCSYmIChyYnRf
bm9fY2hpbGRyZW4oYW5vbl92bWExKSkpDQo+IC0JCXJldHVybiAxOw0KPiArCQlyZXR1cm4gQVZf
TUVSR0VfRElGRkVSRU5UOw0KPiAgCS8qDQo+ICAJICogRGlmZmVyZW50IGFub25fdm1hIGFuZCBz
aGFyZWQgLT4gdW5tZXJnZWFibGUNCj4gIAkgKi8NCj4gIAllbHNlDQo+IC0JCXJldHVybiAwOw0K
PiArCQlyZXR1cm4gQVZfTUVSR0VfRkFJTEVEOw0KPiAgfQ0KPiAgDQo+ICAvKg0KPiBAQCAtMTA5
OSwxMiArMTA5OSwxMCBAQCBjYW5fdm1hX21lcmdlX2JlZm9yZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyB2bV9mbGFncywNCj4gIAkJICAgICBzdHJ1Y3Qgdm1fdXNl
cmZhdWx0ZmRfY3R4IHZtX3VzZXJmYXVsdGZkX2N0eCwNCj4gIAkJICAgICBjb25zdCBjaGFyICph
bm9uX25hbWUpDQo+ICB7DQo+IC0JaWYgKGlzX21lcmdlYWJsZV92bWEodm1hLCBmaWxlLCB2bV9m
bGFncywgdm1fdXNlcmZhdWx0ZmRfY3R4LCBhbm9uX25hbWUpICYmDQo+IC0JICAgIGlzX21lcmdl
YWJsZV9hbm9uX3ZtYShhbm9uX3ZtYSwgdm1hLT5hbm9uX3ZtYSwgdm1hKSkgew0KPiArCWlmIChp
c19tZXJnZWFibGVfdm1hKHZtYSwgZmlsZSwgdm1fZmxhZ3MsIHZtX3VzZXJmYXVsdGZkX2N0eCwg
YW5vbl9uYW1lKSkNCj4gIAkJaWYgKHZtYS0+dm1fcGdvZmYgPT0gdm1fcGdvZmYpDQo+IC0JCQly
ZXR1cm4gMTsNCj4gLQl9DQo+IC0JcmV0dXJuIDA7DQo+ICsJCQlyZXR1cm4gaXNfbWVyZ2VhYmxl
X2Fub25fdm1hKGFub25fdm1hLCB2bWEtPmFub25fdm1hLCB2bWEpOw0KPiArCXJldHVybiBNRVJH
RV9GQUlMRUQ7DQo+ICB9DQo+ICANCj4gIC8qDQo+IEBAIC0xMTIxLDE0ICsxMTE5LDEzIEBAIGNh
bl92bWFfbWVyZ2VfYWZ0ZXIoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxv
bmcgdm1fZmxhZ3MsDQo+ICAJCSAgICBzdHJ1Y3Qgdm1fdXNlcmZhdWx0ZmRfY3R4IHZtX3VzZXJm
YXVsdGZkX2N0eCwNCj4gIAkJICAgIGNvbnN0IGNoYXIgKmFub25fbmFtZSkNCj4gIHsNCj4gLQlp
ZiAoaXNfbWVyZ2VhYmxlX3ZtYSh2bWEsIGZpbGUsIHZtX2ZsYWdzLCB2bV91c2VyZmF1bHRmZF9j
dHgsIGFub25fbmFtZSkgJiYNCj4gLQkgICAgaXNfbWVyZ2VhYmxlX2Fub25fdm1hKGFub25fdm1h
LCB2bWEtPmFub25fdm1hLCB2bWEpKSB7DQo+ICsJaWYgKGlzX21lcmdlYWJsZV92bWEodm1hLCBm
aWxlLCB2bV9mbGFncywgdm1fdXNlcmZhdWx0ZmRfY3R4LCBhbm9uX25hbWUpKSB7DQo+ICAJCXBn
b2ZmX3Qgdm1fcGdsZW47DQo+ICAJCXZtX3BnbGVuID0gdm1hX3BhZ2VzKHZtYSk7DQo+ICAJCWlm
ICh2bWEtPnZtX3Bnb2ZmICsgdm1fcGdsZW4gPT0gdm1fcGdvZmYpDQo+IC0JCQlyZXR1cm4gMTsN
Cj4gKwkJCXJldHVybiBpc19tZXJnZWFibGVfYW5vbl92bWEoYW5vbl92bWEsIHZtYS0+YW5vbl92
bWEsIHZtYSk7DQo+ICAJfQ0KPiAtCXJldHVybiAwOw0KPiArCXJldHVybiBNRVJHRV9GQUlMRUQ7
DQo+ICB9DQo+ICANCj4gIC8qDQo+IEBAIC0xMTg1LDkgKzExODIsMTQgQEAgc3RydWN0IHZtX2Fy
ZWFfc3RydWN0ICp2bWFfbWVyZ2Uoc3RydWN0IG1tX3N0cnVjdCAqbW0sDQo+ICAJcGdvZmZfdCBw
Z2xlbiA9IChlbmQgLSBhZGRyKSA+PiBQQUdFX1NISUZUOw0KPiAgCXN0cnVjdCB2bV9hcmVhX3N0
cnVjdCAqYXJlYSwgKm5leHQ7DQo+ICAJaW50IGVycjsNCj4gLQlpbnQgbWVyZ2VfcHJldiA9IDA7
DQo+IC0JaW50IG1lcmdlX2JvdGggPSAwOw0KPiAtCWludCBtZXJnZV9uZXh0ID0gMDsNCj4gKwkv
Kg0KPiArCSAqIEZvbGxvd2luZyB0aHJlZSB2YXJpYWJsZXMgYXJlIHVzZWQgdG8gc3RvcmUgdmFs
dWVzDQo+ICsJICogaW5kaWNhdGluZyB3aGVhdGhlciB0aGlzIFZNQSBhbmQgaXRzIGFub25fdm1h
IGNhbg0KPiArCSAqIGJlIG1lcmdlZCBhbmQgYWxzbyB0aGUgdHlwZSBvZiBmYWlsdXJlIG9yIHN1
Y2Nlc3MuDQo+ICsJICovDQo+ICsJZW51bSB2bWFfbWVyZ2VfcmVzIG1lcmdlX3ByZXYgPSBNRVJH
RV9GQUlMRUQ7DQo+ICsJZW51bSB2bWFfbWVyZ2VfcmVzIG1lcmdlX2JvdGggPSBNRVJHRV9GQUlM
RUQ7DQo+ICsJZW51bSB2bWFfbWVyZ2VfcmVzIG1lcmdlX25leHQgPSBNRVJHRV9GQUlMRUQ7DQo+
ICANCj4gIAkvKg0KPiAgCSAqIFdlIGxhdGVyIHJlcXVpcmUgdGhhdCB2bWEtPnZtX2ZsYWdzID09
IHZtX2ZsYWdzLA0KPiBAQCAtMTIxMCwzOCArMTIxMiwzOSBAQCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKnZtYV9tZXJnZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwNCj4gIAkgKiBDYW4gd2UgbWVyZ2Ug
cHJlZGVjZXNzb3I/DQo+ICAJICovDQo+ICAJaWYgKHByZXYgJiYgcHJldi0+dm1fZW5kID09IGFk
ZHIgJiYNCj4gLQkJCW1wb2xfZXF1YWwodm1hX3BvbGljeShwcmV2KSwgcG9saWN5KSAmJg0KPiAt
CQkJY2FuX3ZtYV9tZXJnZV9hZnRlcihwcmV2LCB2bV9mbGFncywNCj4gKwkJCW1wb2xfZXF1YWwo
dm1hX3BvbGljeShwcmV2KSwgcG9saWN5KSkgew0KPiArCQltZXJnZV9wcmV2ID0gY2FuX3ZtYV9t
ZXJnZV9hZnRlcihwcmV2LCB2bV9mbGFncywNCj4gIAkJCQkJICAgIGFub25fdm1hLCBmaWxlLCBw
Z29mZiwNCj4gLQkJCQkJICAgIHZtX3VzZXJmYXVsdGZkX2N0eCwgYW5vbl9uYW1lKSkgew0KPiAt
CQltZXJnZV9wcmV2ID0gdHJ1ZTsNCj4gKwkJCQkJICAgIHZtX3VzZXJmYXVsdGZkX2N0eCwgYW5v
bl9uYW1lKTsNCj4gIAl9DQo+ICsNCj4gIAkvKg0KPiAgCSAqIENhbiB3ZSBtZXJnZSBzdWNjZXNz
b3I/DQo+ICAJICovDQo+ICAJaWYgKG5leHQgJiYgZW5kID09IG5leHQtPnZtX3N0YXJ0ICYmDQo+
IC0JCQltcG9sX2VxdWFsKHBvbGljeSwgdm1hX3BvbGljeShuZXh0KSkgJiYNCj4gLQkJCWNhbl92
bWFfbWVyZ2VfYmVmb3JlKG5leHQsIHZtX2ZsYWdzLA0KPiArCQkJbXBvbF9lcXVhbChwb2xpY3ks
IHZtYV9wb2xpY3kobmV4dCkpKSB7DQo+ICsJCW1lcmdlX25leHQgPSBjYW5fdm1hX21lcmdlX2Jl
Zm9yZShuZXh0LCB2bV9mbGFncywNCj4gIAkJCQkJYW5vbl92bWEsIGZpbGUsIHBnb2ZmK3BnbGVu
LA0KPiAtCQkJCQl2bV91c2VyZmF1bHRmZF9jdHgsIGFub25fbmFtZSkpIHsNCj4gLQkJbWVyZ2Vf
bmV4dCA9IHRydWU7DQo+ICsJCQkJCXZtX3VzZXJmYXVsdGZkX2N0eCwgYW5vbl9uYW1lKTsNCj4g
IAl9DQo+ICsNCj4gIAkvKg0KPiAgCSAqIENhbiB3ZSBtZXJnZSBib3RoIHByZWRlY2Vzc29yIGFu
ZCBzdWNjZXNzb3I/DQo+ICAJICovDQo+IC0JaWYgKG1lcmdlX3ByZXYgJiYgbWVyZ2VfbmV4dCkN
Cj4gKwlpZiAobWVyZ2VfcHJldiA+PSBNRVJHRV9PSyAmJiBtZXJnZV9uZXh0ID49IE1FUkdFX09L
KSB7DQoNCldoYXQgaGFwcGVuZWQgdG8gbWFraW5nIHZtYV9tZXJnZSBlYXNpZXIgdG8gcmVhZD8g
IFdoYXQgZG9lcyA+IE1FUkdFX09LDQptZWFuPyAgSSBndWVzcyB0aGlzIGFuc3dlcnMgd2h5IGJv
b2xlYW5zIHdlcmUgbm90IHVzZWQsIGJ1dCBJIGRvbid0IGxpa2UNCml0LiAgIENvdWxkbid0IHlv
dSBqdXN0IGxvZyB0aGUgZXJyL3N1Y2Nlc3MgYW5kIHRoZSB2YWx1ZSBvZg0KbWVyZ2VfcHJldi9t
ZXJnZV9uZXh0PyAgSXQncyBub3QgbGlrZSB0aGUgY29kZSB0cmllcyBtb3JlIHRoYW4gb25lIHdh
eQ0Kb2YgbWVyZ2luZyBvbiBmYWlsdXJlLi4NCg0KPiAgCQltZXJnZV9ib3RoID0gaXNfbWVyZ2Vh
YmxlX2Fub25fdm1hKHByZXYtPmFub25fdm1hLCBuZXh0LT5hbm9uX3ZtYSwgTlVMTCk7DQo+ICsJ
fQ0KPiAgDQo+IC0JaWYgKG1lcmdlX2JvdGgpIHsJIC8qIGNhc2VzIDEsIDYgKi8NCj4gKwlpZiAo
bWVyZ2VfYm90aCA+PSBNRVJHRV9PSykgewkgLyogY2FzZXMgMSwgNiAqLw0KPiAgCQllcnIgPSBf
X3ZtYV9hZGp1c3QocHJldiwgcHJldi0+dm1fc3RhcnQsDQo+ICAJCQkJCW5leHQtPnZtX2VuZCwg
cHJldi0+dm1fcGdvZmYsIE5VTEwsDQo+ICAJCQkJCXByZXYpOw0KPiAgCQlhcmVhID0gcHJldjsN
Cj4gLQl9IGVsc2UgaWYgKG1lcmdlX3ByZXYpIHsJCQkvKiBjYXNlcyAyLCA1LCA3ICovDQo+ICsJ
fSBlbHNlIGlmIChtZXJnZV9wcmV2ID49IE1FUkdFX09LKSB7CQkJLyogY2FzZXMgMiwgNSwgNyAq
Lw0KPiAgCQllcnIgPSBfX3ZtYV9hZGp1c3QocHJldiwgcHJldi0+dm1fc3RhcnQsDQo+ICAJCQkJ
CWVuZCwgcHJldi0+dm1fcGdvZmYsIE5VTEwsIHByZXYpOw0KPiAgCQlhcmVhID0gcHJldjsNCj4g
LQl9IGVsc2UgaWYgKG1lcmdlX25leHQpIHsNCj4gKwl9IGVsc2UgaWYgKG1lcmdlX25leHQgPj0g
TUVSR0VfT0spIHsNCj4gIAkJaWYgKHByZXYgJiYgYWRkciA8IHByZXYtPnZtX2VuZCkJLyogY2Fz
ZSA0ICovDQo+ICAJCQllcnIgPSBfX3ZtYV9hZGp1c3QocHJldiwgcHJldi0+dm1fc3RhcnQsDQo+
ICAJCQkJCWFkZHIsIHByZXYtPnZtX3Bnb2ZmLCBOVUxMLCBuZXh0KTsNCj4gQEAgLTEyNTIsNyAr
MTI1NSw3IEBAIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hX21lcmdlKHN0cnVjdCBtbV9zdHJ1
Y3QgKm1tLA0KPiAgCX0gZWxzZSB7DQo+ICAJCWVyciA9IC0xOw0KPiAgCX0NCj4gLQ0KPiArCXRy
YWNlX3ZtX2F2X21lcmdlKGVyciwgbWVyZ2VfcHJldiwgbWVyZ2VfbmV4dCwgbWVyZ2VfYm90aCk7
DQo+ICAJLyoNCj4gIAkgKiBDYW5ub3QgbWVyZ2Ugd2l0aCBwcmVkZWNlc3NvciBvciBzdWNjZXNz
b3Igb3IgZXJyb3IgaW4gX192bWFfYWRqdXN0Pw0KPiAgCSAqLw0KPiBAQCAtMzM1OSw2ICszMzYy
LDggQEAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICpjb3B5X3ZtYShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKip2bWFwLA0KPiAgCQkvKg0KPiAgCQkgKiBTb3VyY2Ugdm1hIG1heSBoYXZlIGJlZW4gbWVy
Z2VkIGludG8gbmV3X3ZtYQ0KPiAgCQkgKi8NCj4gKwkJdHJhY2Vfdm1fcGdvZmZfbWVyZ2Uodm1h
LCBhbm9uX3Bnb2ZmX3VwZGF0ZWQpOw0KPiArDQo+ICAJCWlmICh1bmxpa2VseSh2bWFfc3RhcnQg
Pj0gbmV3X3ZtYS0+dm1fc3RhcnQgJiYNCj4gIAkJCSAgICAgdm1hX3N0YXJ0IDwgbmV3X3ZtYS0+
dm1fZW5kKSkgew0KPiAgCQkJLyoNCj4gLS0gDQo+IDIuMzQuMQ0KPiA=
