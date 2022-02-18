Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E04BC087
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiBRTvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:51:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238098AbiBRTvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:51:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F387CE56
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:51:29 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IIhV6K007040;
        Fri, 18 Feb 2022 19:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=93eYvTambhsTOqKZ0+2tCjYYxsHrhW2ms+or6ohsOyg=;
 b=bn9tk2IQSLhctPOs7QJnv+zjSFaSWXqiTQ8iremRKseduWI3M4lKKRPV7nWzQKkayGgi
 ofc+ZgvvyzUK8A+QzcCKh2+Z7pIsuyWiZBFB57qb+B+mleLApyt20Y2IwXV1/VaMlJo8
 NIO/80fiBppt3p7ovpEXY/UjChNc+MW/NV6jA5NxaYDw3h4V+NiAZpb+THAVbmE0jaCI
 92bXf+hW36rnlko7/gmDP7IAURxEpV4+GHMKPVO6Me1FpETeaHb6O1P2HN7pREbpz+XK
 Um93ZhgLOmZ8qLN2XC/Fxp0ih4k4oMjKFgPpKBTVlNOMSoqRf819GWZ/NEDPb4e0QcTr FQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr9arpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 19:50:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IJoWUX023202;
        Fri, 18 Feb 2022 19:50:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3020.oracle.com with ESMTP id 3e8n4y045h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 19:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zno7SlbBXyvuRnhLHXgIWUn5y0ndLfl566VADzSGYq3ystEP3eMo/+A+yToc/BiSZocn6UboRR6y9ijBcGOkREkoGEuQ1/WPrUiO7FXAW26m2XcQtrRMecMAxx7yoJjWDJhoPY0/4x2uZ2UDvDurlll3/dxZkMGj7GnNDn11bwYLjn2ldYPt7sdsmughgRw7ulrHxo0lpbVX3VI0NgGQe6souQ61jSRiDf2D/46TKP5+qeZDRZSs7Q4Vix4u6kHlCa3d9CDuyEJhYMYEg6iwEw93/6tFpEv24WfZvOEd5URDEIpCyE7Fj3rcpZjlGSWZqLNg5KRggI3wa9LUo4uJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93eYvTambhsTOqKZ0+2tCjYYxsHrhW2ms+or6ohsOyg=;
 b=QsbXHFr88LhEHHHGqhy35NefbUQOZsjVXYgM7I/eNVxwYw8mmV8YdNxtOnOxZC8wk5eEh9sLBk6sbt4TzLVUIHqb7S5pBPFL/BrWiKV5QohKcgxz7pwGLj53hWKecCEKRqQo5CMzjOq6uwV1UadPfZU0gpS8ZrmoEG5i+9pDIO0tjsOyc9Pu/mLT6G/eN7ZVOvVWXQCb2Xs1ITl3lLMTS2f7rU7DSskDQAt3KjSu/zgm0Xkfwn2NLbzZZqS6hRk6R/UcCwjBs/fVU1dM7adADMuz4cbM42roIoCvEbqzOw9aiA3de6dwgBgqDqsEBosLcfIqxOefqGM1raSIU/3Qfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93eYvTambhsTOqKZ0+2tCjYYxsHrhW2ms+or6ohsOyg=;
 b=mz7A+HLJRXt722aOlRNjLdCqru9HuKfDHZheasqV8Btz8dgkAfQMtI9NflrX/to9s54ATOLLWfw8GLhWKjm//0WDQ41PGShREX3amgCJaeMYqVKhVoOL99DlxR9X3/ysViMbYYxt7qU2XeRa0nnjwhyy2ZdDmfO0OcNF6b7lcCo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB2757.namprd10.prod.outlook.com (2603:10b6:a02:aa::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 19:50:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4995.023; Fri, 18 Feb 2022
 19:50:49 +0000
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
Subject: Re: [RFC PATCH 2/4] [PATCH 2/4] mm: adjust page offset in mremap
Thread-Topic: [RFC PATCH 2/4] [PATCH 2/4] mm: adjust page offset in mremap
Thread-Index: AQHYJMIWiIlIrUz6+USIJo3iMxeubayZuCCA
Date:   Fri, 18 Feb 2022 19:50:49 +0000
Message-ID: <20220218195047.bplrholzx4h2id2i@revolver>
References: <20220218122019.130274-1-matenajakub@gmail.com>
 <20220218122019.130274-3-matenajakub@gmail.com>
In-Reply-To: <20220218122019.130274-3-matenajakub@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdc9e7fd-f661-4e15-0ac5-08d9f317f681
x-ms-traffictypediagnostic: BYAPR10MB2757:EE_
x-microsoft-antispam-prvs: <BYAPR10MB2757BD5E7CD0E2905806A522FD379@BYAPR10MB2757.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4cJ3khqn0OfJgLJvNJhYbeMRmfSodwXK+KGyf0sme/I4bt0wQfJ+nv1pyvjtH+sLK6+FTG+SoiA8IC74QfGvbWFxktxjUA1atRmcGBWHWCecXXs4PK2+Ps+ceiURsGjYtfmTW+EeIw59Lv/KT5Xl4e+1aIj/caX4QT7byX1DYcONdv9yPbyuqgBZDTo67TimRnzIiAYWlP72yvqI+QatLW7i0Dak3Tc7KTeiicvMRS+herdk0CK49IG84GGesNoO8kwqks6AIiEdABj7Fc1jZRIfZ+cmmluQoBsIRlo+6XpSszUHrh5vSFWQlFi1ErRXApsNHNDccjTbYzw8BPJj3unEbPd+Mw/u657Dr2W3Ppv6hT1nu83GF+zi4ticiz++NZ4TkWfGGr78J6pERg/1w/ZbwJCR2nJclVxR10miJey6dH+mWCShGNDfMbsjianJ6TZmHqF4XUarL/6cZTEg5tPxkT31KkQSYfQTN/btRQroYIaA5kd5NjV41epLjvW+txGp9ANiTCVrYwMHpku2Va6Sxp7lFt44iy2TCXnb26IUJlc9sZmNkbBBcPgmhau8jGwDJvcJ0seF8mLM4KWcqwrMzX9vmcMtR4CYA7MNd8hN6t86ksoG11SSOMcWTNzu7T4c8yPFW8uCxX7cgYc1CDce+Nz0sbjVaVQaI0Dwj/YefXnoyWlfZEoMAOM8ruqKERM8B+VKEqnHbAC7xzGzgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(6512007)(6506007)(91956017)(9686003)(66556008)(66446008)(4326008)(44832011)(66574015)(64756008)(66946007)(71200400001)(7416002)(66476007)(8676002)(33716001)(8936002)(5660300002)(508600001)(122000001)(1076003)(76116006)(83380400001)(54906003)(26005)(186003)(38070700005)(6916009)(6486002)(86362001)(316002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHdyTDBabHN6ajBtNURNd3R6MWpTOEVqeGZDWThaTnBFT0xxbFhwUnRSSkd5?=
 =?utf-8?B?SjY0aVByREcvd0V2cnY0TEo0VmZKZEJkOVgydUIwREVkeXFpSFcvSU1rTVBu?=
 =?utf-8?B?ZnoyZ1I4SHlyNGRtWTNUMW1rNng0T2pjR0dOWWQ3QUhMbnBjaGEyUnVjb2FW?=
 =?utf-8?B?VTYrMUhvTjVlR1Rpcks1YTUxenIxNWJzRGZ2TCtnVE9xVk4reFJzNFRFbEFi?=
 =?utf-8?B?MXkwWXZ4bWNNMWFhaG1HaCtVb3pFUEpPaDZtYlJiWElISitRTVdMaTdDSGFL?=
 =?utf-8?B?RFREMHNobHBDOVBuaTNoNzh6Y0NOcHVCZVozd2xhOVo3L2xOOGJtQzlWYm9S?=
 =?utf-8?B?V0FUam1wY21hTzJ0bmpSenZlVjQyNmVQSjN4RkgwOEVjMDVWK2p0WU5nZHZQ?=
 =?utf-8?B?Qmhaa3ljaTJzZFcwbnVZOTZ0bUF0WUxVaWV4VEpyMEpBY05kbVgwcWI5N01r?=
 =?utf-8?B?U3hSY1JwZWIyMnhSMVlFNFV4ZnpIZU92cXloU090clNzWmEzeUtOWWhjbERr?=
 =?utf-8?B?clUzd1o3bDFhWjNKVkplSk9vcDhpY2wwUGxDZmJURTdPc0xrUXgzbHBhVEE1?=
 =?utf-8?B?a3lZOTJXU2NYTTVianYxOEs2Zlo4clVQcGh4Z1JBWXVqUjRiRVJ0V3lBKzkz?=
 =?utf-8?B?MDN6SFVVdmZKck4vcURxNWU2TXNLQk5WUVhkSEJsT1VaREcxWVNwaURYT1lF?=
 =?utf-8?B?TTB1YkpLLy80TjZYSEdPOTlCNThwd2N0QTZtVHdYSUxJeFp6ZDlJMjJ6aUF0?=
 =?utf-8?B?cDFuR1dJK1lCSlVBdVMyb081WlIxdXJVMWVpdGw0VW56QXkrS01BWm9vb2pV?=
 =?utf-8?B?NUViZ3o2cUcvbGNqd01tMldsdmFvajBXYWZpaHJPQ25ZRk9IYlF5V3dmK3k2?=
 =?utf-8?B?Vld6T0o5TFFwVzVMaTRMSXcrbytUc2gvaUpmTmRvVmIxSWpLQnp2UWFEQ1pq?=
 =?utf-8?B?dUJxYUVOdDVMcWFkN0tub1gzcFFoNVdzOHJxZmN6SitUSm9zakRtc1U4TEVQ?=
 =?utf-8?B?eXVlRTJ3eDF5bkdRZVk4dUJYeGFuSVA1WjR2S3VvQm5XQUkvZEJMTUxxRjZH?=
 =?utf-8?B?elFDT2pjNFVWUWRweFRZTVVzWW9hSzI3eTloUjNuYnZQTDRQSG84cGJ5Vkpw?=
 =?utf-8?B?WmFMZlpmL2JoNjRpcUsxTjloRkhscnRkS012TDMwMEJ1RHJuUmdvWTl5dGZX?=
 =?utf-8?B?eU5vbGVOWnVrWTBnMHFzTXhudDc5ZFJuN0pKY1o4ZUhrZEJYNmZvL3NlZWMz?=
 =?utf-8?B?Z3BaSWliZlR4Z1pLZW9ZZ3paL1RHNnhzV1hyU2R0ejlyOGhVZEsrYUF2cS9D?=
 =?utf-8?B?ZFNsSVRQTW9NK2Z4MkxPbjRMY09ValNmUzcyUjZDTzR3WWtFL0hzTUM3OS82?=
 =?utf-8?B?K25rckFva05NMG5EYURKYm5vRGNCdmV4MHhFTmRLcEtyK0JMK2NXOHRUOVNy?=
 =?utf-8?B?WThEdDNROExMOEpwTGgzSmlPQklXWlFJUU5FbVowUkJpSkpZbjQwZWtkYnpz?=
 =?utf-8?B?NkNBSDlTM01hVmhKRUJTeXoxaitZQlJvaml2NnFrcE1ONEcrbm1INk1UVFdD?=
 =?utf-8?B?ODBTWWs2Yy95Q3VUSmVBdTJPdUlaTklEU29aN0dFQzF2dVpsMFBWKzBzdzNC?=
 =?utf-8?B?cWdIZXdidTB1V1pORDRPMHJiRUxEQXJ6aGU5bm1kWFljQVdjZ0h1aUlsY0VT?=
 =?utf-8?B?dCtWVDZ4MzlwQ0RQTkQ0TVRHbnZUVWhUZC9YUHFHWmdobnM1VTF2UThZZVRK?=
 =?utf-8?B?TnBFQ1RRNW0yeEpydDhDbkZtN2hScklxWnRSTitjZGRvVGVjRVVOVDJaOWRs?=
 =?utf-8?B?MVZTc21yN1FjRnUzT252bEVnTjBSZDQ3aDBPMzhSYXhnN2FWaTZRNDhNMnUx?=
 =?utf-8?B?bk9jMFJ6SDkyQ1FVRWdUTlM4MkRRMHErdG4wYmJHeFMrV09uc0VXQ1hnaWpP?=
 =?utf-8?B?ZWIyTTF2NFJZSVcvbUlRdTRLdUhjd3dKZG96NzNlSTRYOFdjc0R0akhrTUla?=
 =?utf-8?B?RlRMSmFCS0NGbVVUS09JbHhYanp4M2xkQUkzaWphSS9JUU4rMFM0OHE1OGFE?=
 =?utf-8?B?OEcvSTFsblUvUzR5OXBUV2pJS0RIVzA4WmN1L2hSbnV5WUJOMUpoSnZNUmJ2?=
 =?utf-8?B?YUhEdGN5Ni9iNFpKOGpzaFZvcHhoUFBUdGdac1AzRDRzTDduTGhmaGliaDQz?=
 =?utf-8?Q?4VcuYC+/w7yaf7jjzLXcHLQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <752AB105C5CF5A42BC2D5468FAE49C5E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc9e7fd-f661-4e15-0ac5-08d9f317f681
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 19:50:49.4304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m59GwRBRS9BR6L7tCCgjBOaf8omVAqM1FOkPLLIEoNbiEf9W9gveHDVWOWXj+QZXAhqEO31T6s8L+3NFOuBFYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2757
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10262 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180121
X-Proofpoint-GUID: _6HHY_92NX-L4tgmmqglDoMFeV_j6WT4
X-Proofpoint-ORIG-GUID: _6HHY_92NX-L4tgmmqglDoMFeV_j6WT4
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
PiBBZGp1c3QgcGFnZSBvZmZzZXQgb2YgYSBWTUEgd2hlbiBpdCdzIG1vdmVkIHRvIGEgbmV3IGxv
Y2F0aW9uIGJ5IG1yZW1hcC4NCj4gVGhpcyBpcyBtYWRlIHBvc3NpYmxlIGZvciBhbGwgVk1BcyB0
aGF0IGRvIG5vdCBzaGFyZSB0aGVpciBhbm9ueW1vdXMNCj4gcGFnZXMgd2l0aCBvdGhlciBwcm9j
ZXNzZXMuIFByZXZpb3VzbHkgdGhpcyB3YXMgcG9zc2libGUgb25seSBmb3Igbm90DQo+IHlldCBm
YXVsdGVkIFZNQXMuDQo+IFdoZW4gdGhlIHBhZ2Ugb2Zmc2V0IGRvZXMgbm90IGNvcnJlc3BvbmQg
dG8gdGhlIHZpcnR1YWwgYWRkcmVzcw0KPiBvZiB0aGUgYW5vbnltb3VzIFZNQSBhbnkgbWVyZ2Ug
YXR0ZW1wdCB3aXRoIGFub3RoZXIgVk1BIHdpbGwgZmFpbC4NCg0KSSBkb24ndCBrbm93IGVub3Vn
aCB0byBmdWxseSBhbnN3ZXIgdGhpcyBidXQgSSB0aGluayB0aGlzIG1heSBjYXVzZQ0KaXNzdWVz
IHdpdGggcm1hcD8gIEkgd291bGQgdGhpbmsgdGhlIGFub24gdm1hIGxvY2sgaXMgbmVjZXNzYXJ5
IGJ1dCBJDQptYXkgYmUgbWlzc2luZyBzb21ldGhpbmcuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEpha3ViIE1hdMSbbmEgPG1hdGVuYWpha3ViQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBtbS9tbWFw
LmMgfCAxMDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9tbWFwLmMgYi9tbS9tbWFwLmMNCj4gaW5kZXggYjU1
ZTExZjIwNTcxLi44ZDI1M2I0NmIzNDkgMTAwNjQ0DQo+IC0tLSBhL21tL21tYXAuYw0KPiArKysg
Yi9tbS9tbWFwLmMNCj4gQEAgLTMyMjQsNiArMzIyNCw5MSBAQCBpbnQgaW5zZXJ0X3ZtX3N0cnVj
dChzdHJ1Y3QgbW1fc3RydWN0ICptbSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpDQo+ICAJ
cmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gK2Jvb2wgcmJzdF9ub19jaGlsZHJlbihzdHJ1Y3QgYW5v
bl92bWEgKmF2LCBzdHJ1Y3QgcmJfbm9kZSAqbm9kZSkNCj4gK3sNCj4gKwlzdHJ1Y3QgYW5vbl92
bWFfY2hhaW4gKm1vZGVsOw0KPiArCXN0cnVjdCBhbm9uX3ZtYV9jaGFpbiAqYXZjOw0KPiArDQo+
ICsJaWYgKG5vZGUgPT0gTlVMTCkgLyogbGVhZiBub2RlICovDQo+ICsJCXJldHVybiB0cnVlOw0K
PiArCWF2YyA9IGNvbnRhaW5lcl9vZihub2RlLCB0eXBlb2YoKihtb2RlbCkpLCByYik7DQo+ICsJ
aWYgKGF2Yy0+dm1hLT5hbm9uX3ZtYSAhPSBhdikNCj4gKwkJLyoNCj4gKwkJICogSW5lcXVhbGl0
eSBpbXBsaWVzIGF2YyBiZWxvbmdzDQo+ICsJCSAqIHRvIGEgVk1BIG9mIGEgY2hpbGQgcHJvY2Vz
cw0KPiArCQkgKi8NCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArCXJldHVybiAocmJzdF9ub19jaGls
ZHJlbihhdiwgbm9kZS0+cmJfbGVmdCkgJiYNCj4gKwlyYnN0X25vX2NoaWxkcmVuKGF2LCBub2Rl
LT5yYl9yaWdodCkpOw0KPiArfQ0KPiArDQo+ICsvKg0KPiArICogQ2hlY2sgaWYgbm9uZSBvZiB0
aGUgVk1BcyBjb25uZWN0ZWQgdG8gdGhlIGdpdmVuDQo+ICsgKiBhbm9uX3ZtYSB2aWEgYW5vbl92
bWFfY2hhaW4gYXJlIGluIGNoaWxkIHJlbGF0aW9uc2hpcA0KPiArICovDQo+ICtib29sIHJidF9u
b19jaGlsZHJlbihzdHJ1Y3QgYW5vbl92bWEgKmF2KQ0KPiArew0KPiArCXN0cnVjdCByYl9ub2Rl
ICpyb290X25vZGU7DQo+ICsNCj4gKwlpZiAoYXYgPT0gTlVMTCB8fCBhdi0+ZGVncmVlIDw9IDEp
IC8qIEhpZ2hlciBkZWdyZWUgbWlnaHQgbm90IG5lY2Vzc2FyaWx5IGltcGx5IGNoaWxkcmVuICov
DQo+ICsJCXJldHVybiB0cnVlOw0KPiArCXJvb3Rfbm9kZSA9IGF2LT5yYl9yb290LnJiX3Jvb3Qu
cmJfbm9kZTsNCj4gKwlyZXR1cm4gcmJzdF9ub19jaGlsZHJlbihhdiwgcm9vdF9ub2RlKTsNCj4g
K30NCj4gKw0KPiArLyoqDQo+ICsgKiB1cGRhdGVfZmF1bHRlZF9wZ29mZigpIC0gVXBkYXRlIGZh
dWx0ZWQgcGFnZXMgb2YgYSB2bWENCj4gKyAqIEB2bWE6IFZNQSBiZWluZyBtb3ZlZA0KPiArICog
QGFkZHI6IG5ldyB2aXJ0dWFsIGFkZHJlc3MNCj4gKyAqIEBwZ29mZjogcG9pbnRlciB0byBwZ29m
ZiB3aGljaCBpcyB1cGRhdGVkDQo+ICsgKiBJZiB0aGUgdm1hIGFuZCBpdHMgcGFnZXMgYXJlIG5v
dCBzaGFyZWQgd2l0aCBhbm90aGVyIHByb2Nlc3MsIHVwZGF0ZQ0KPiArICogdGhlIG5ldyBwZ29m
ZiBhbmQgYWxzbyB1cGRhdGUgaW5kZXggcGFyYW1ldGVyIChjb3B5IG9mIHRoZSBwZ29mZikgaW4N
Cj4gKyAqIGFsbCBmYXVsdGVkIHBhZ2VzLg0KPiArICovDQo+ICtib29sIHVwZGF0ZV9mYXVsdGVk
X3Bnb2ZmKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHIsIHBn
b2ZmX3QgKnBnb2ZmKQ0KPiArew0KPiArCXVuc2lnbmVkIGxvbmcgcGdfaXRlciA9IDA7DQo+ICsJ
dW5zaWduZWQgbG9uZyBwZ19pdGVycyA9ICh2bWEtPnZtX2VuZCAtIHZtYS0+dm1fc3RhcnQpID4+
IFBBR0VfU0hJRlQ7DQo+ICsNCj4gKwkvKiAxLl0gQ2hlY2sgdm1hIGlzIG5vdCBzaGFyZWQgd2l0
aCBvdGhlciBwcm9jZXNzZXMgKi8NCj4gKwlpZiAodm1hLT5hbm9uX3ZtYS0+cm9vdCAhPSB2bWEt
PmFub25fdm1hIHx8ICFyYnRfbm9fY2hpbGRyZW4odm1hLT5hbm9uX3ZtYSkpDQo+ICsJCXJldHVy
biBmYWxzZTsNCj4gKw0KPiArCS8qIDIuXSBDaGVjayBhbGwgcGFnZXMgYXJlIG5vdCBzaGFyZWQg
Ki8NCj4gKwlmb3IgKDsgcGdfaXRlciA8IHBnX2l0ZXJzOyArK3BnX2l0ZXIpIHsNCj4gKwkJYm9v
bCBwYWdlc19ub3Rfc2hhcmVkID0gdHJ1ZTsNCj4gKwkJdW5zaWduZWQgbG9uZyBzaGlmdCA9IHBn
X2l0ZXIgPDwgUEFHRV9TSElGVDsNCj4gKwkJc3RydWN0IHBhZ2UgKnBoeXNfcGFnZSA9IGZvbGxv
d19wYWdlKHZtYSwgdm1hLT52bV9zdGFydCArIHNoaWZ0LCBGT0xMX0dFVCk7DQo+ICsNCj4gKwkJ
aWYgKHBoeXNfcGFnZSA9PSBOVUxMKQ0KPiArCQkJY29udGludWU7DQo+ICsNCj4gKwkJLyogQ2hl
Y2sgcGFnZSBpcyBub3Qgc2hhcmVkIHdpdGggb3RoZXIgcHJvY2Vzc2VzICovDQo+ICsJCWlmIChw
YWdlX21hcGNvdW50KHBoeXNfcGFnZSkgPiAxKQ0KPiArCQkJcGFnZXNfbm90X3NoYXJlZCA9IGZh
bHNlOw0KPiArCQlwdXRfcGFnZShwaHlzX3BhZ2UpOw0KPiArCQlpZiAoIXBhZ2VzX25vdF9zaGFy
ZWQpDQo+ICsJCQlyZXR1cm4gZmFsc2U7DQo+ICsJfQ0KPiArDQo+ICsJLyogMy5dIFVwZGF0ZSBp
bmRleCBpbiBhbGwgcGFnZXMgdG8gdGhpcyBuZXcgcGdvZmYgKi8NCj4gKwlwZ19pdGVyID0gMDsN
Cj4gKwkqcGdvZmYgPSBhZGRyID4+IFBBR0VfU0hJRlQ7DQo+ICsNCj4gKwlmb3IgKDsgcGdfaXRl
ciA8IHBnX2l0ZXJzOyArK3BnX2l0ZXIpIHsNCj4gKwkJdW5zaWduZWQgbG9uZyBzaGlmdCA9IHBn
X2l0ZXIgPDwgUEFHRV9TSElGVDsNCj4gKwkJc3RydWN0IHBhZ2UgKnBoeXNfcGFnZSA9IGZvbGxv
d19wYWdlKHZtYSwgdm1hLT52bV9zdGFydCArIHNoaWZ0LCBGT0xMX0dFVCk7DQo+ICsNCj4gKwkJ
aWYgKHBoeXNfcGFnZSA9PSBOVUxMKQ0KPiArCQkJY29udGludWU7DQo+ICsJCWxvY2tfcGFnZShw
aHlzX3BhZ2UpOw0KPiArCQlwaHlzX3BhZ2UtPmluZGV4ID0gKnBnb2ZmICsgcGdfaXRlcjsNCj4g
KwkJdW5sb2NrX3BhZ2UocGh5c19wYWdlKTsNCj4gKwkJcHV0X3BhZ2UocGh5c19wYWdlKTsNCj4g
Kwl9DQo+ICsJcmV0dXJuIHRydWU7DQo+ICt9DQo+ICsNCj4gIC8qDQo+ICAgKiBDb3B5IHRoZSB2
bWEgc3RydWN0dXJlIHRvIGEgbmV3IGxvY2F0aW9uIGluIHRoZSBzYW1lIG1tLA0KPiAgICogcHJp
b3IgdG8gbW92aW5nIHBhZ2UgdGFibGUgZW50cmllcywgdG8gZWZmZWN0IGFuIG1yZW1hcCBtb3Zl
Lg0KPiBAQCAtMzIzNywxNSArMzMyMiwxOSBAQCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKmNvcHlf
dm1hKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqKnZtYXAsDQo+ICAJc3RydWN0IG1tX3N0cnVjdCAq
bW0gPSB2bWEtPnZtX21tOw0KPiAgCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqbmV3X3ZtYSwgKnBy
ZXY7DQo+ICAJc3RydWN0IHJiX25vZGUgKipyYl9saW5rLCAqcmJfcGFyZW50Ow0KPiAtCWJvb2wg
ZmF1bHRlZF9pbl9hbm9uX3ZtYSA9IHRydWU7DQo+ICsJYm9vbCBhbm9uX3Bnb2ZmX3VwZGF0ZWQg
PSBmYWxzZTsNCj4gIA0KPiAgCS8qDQo+IC0JICogSWYgYW5vbnltb3VzIHZtYSBoYXMgbm90IHll
dCBiZWVuIGZhdWx0ZWQsIHVwZGF0ZSBuZXcgcGdvZmYNCj4gKwkgKiBUcnkgdG8gdXBkYXRlIG5l
dyBwZ29mZiBmb3IgYW5vbnltb3VzIHZtYQ0KPiAgCSAqIHRvIG1hdGNoIG5ldyBsb2NhdGlvbiwg
dG8gaW5jcmVhc2UgaXRzIGNoYW5jZSBvZiBtZXJnaW5nLg0KPiAgCSAqLw0KPiAtCWlmICh1bmxp
a2VseSh2bWFfaXNfYW5vbnltb3VzKHZtYSkgJiYgIXZtYS0+YW5vbl92bWEpKSB7DQo+IC0JCXBn
b2ZmID0gYWRkciA+PiBQQUdFX1NISUZUOw0KPiAtCQlmYXVsdGVkX2luX2Fub25fdm1hID0gZmFs
c2U7DQo+ICsJaWYgKHVubGlrZWx5KHZtYV9pc19hbm9ueW1vdXModm1hKSkpIHsNCj4gKwkJaWYg
KCF2bWEtPmFub25fdm1hKSB7DQo+ICsJCQlwZ29mZiA9IGFkZHIgPj4gUEFHRV9TSElGVDsNCj4g
KwkJCWFub25fcGdvZmZfdXBkYXRlZCA9IHRydWU7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQlhbm9u
X3Bnb2ZmX3VwZGF0ZWQgPSB1cGRhdGVfZmF1bHRlZF9wZ29mZih2bWEsIGFkZHIsICZwZ29mZik7
DQo+ICsJCX0NCj4gIAl9DQo+ICANCj4gIAlpZiAoZmluZF92bWFfbGlua3MobW0sIGFkZHIsIGFk
ZHIgKyBsZW4sICZwcmV2LCAmcmJfbGluaywgJnJiX3BhcmVudCkpDQo+IEBAIC0zMjcxLDcgKzMz
NjAsNyBAQCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKmNvcHlfdm1hKHN0cnVjdCB2bV9hcmVhX3N0
cnVjdCAqKnZtYXAsDQo+ICAJCQkgKiBzYWZlLiBJdCBpcyBvbmx5IHNhZmUgdG8ga2VlcCB0aGUg
dm1fcGdvZmYNCj4gIAkJCSAqIGxpbmVhciBpZiB0aGVyZSBhcmUgbm8gcGFnZXMgbWFwcGVkIHll
dC4NCj4gIAkJCSAqLw0KPiAtCQkJVk1fQlVHX09OX1ZNQShmYXVsdGVkX2luX2Fub25fdm1hLCBu
ZXdfdm1hKTsNCj4gKwkJCVZNX0JVR19PTl9WTUEoIWFub25fcGdvZmZfdXBkYXRlZCwgbmV3X3Zt
YSk7DQo+ICAJCQkqdm1hcCA9IHZtYSA9IG5ld192bWE7DQo+ICAJCX0NCj4gIAkJKm5lZWRfcm1h
cF9sb2NrcyA9IChuZXdfdm1hLT52bV9wZ29mZiA8PSB2bWEtPnZtX3Bnb2ZmKTsNCj4gLS0gDQo+
IDIuMzQuMQ0KPiA=
