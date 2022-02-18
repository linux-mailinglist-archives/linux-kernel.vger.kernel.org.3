Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E834BC037
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiBRTWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:22:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiBRTWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:22:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B18340F0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:22:35 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IIchS7007047;
        Fri, 18 Feb 2022 19:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=szXFPrfZ25w78CxLMzArJRcjvUZzpgd60ahDqJnhgSw=;
 b=cIJDjm81Sz4qpQM3JS4l47fjeLvtBnVRAmWnm7VQl9gCNg0juHGGrVHqEbHQ3DB2lZwv
 l/fi007Qy1oBIhAB5BqNmYrSqphOwtsS5KVlbKCyuhUjyO9uRt+HFguMo4E/2UFPJq6v
 DyrpldX9Du/iGCNGWrwyIHJJkKh7tW0XWYFyW1YI9SLyRWN+IhWsK7AYkekjDgsaokzp
 G1VEgjzOu82x0P22qHCM+QfUqYgHRHWEE9yjdAHrvu8ADxeVaAV7B0gnX+NeMevuqIRw
 vzdNsinlShqCiqDyiE8uvii/X95RxnnRdeRN+RAvVY32c7ngmJfCdtTbZvj46+oanM6B uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr9antb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 19:21:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IJGS2V189570;
        Fri, 18 Feb 2022 19:21:52 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by userp3020.oracle.com with ESMTP id 3e8n4xy4vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 19:21:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA66cwnuubr8avbQ+gIhXXopIs276RtEwqv5Ke/pCInscQRPrzx/nIgNY3R4JoCDB45Jji20/juuaq2p+z06fmIDk8ruNQzdYGhJKpfEa07gIW8hNERYFtjYyGfM2tBlyaVHTiEiWsAzoQEfwv26rkwFTlwLKG3frMv4qzYPlX61MVNBOHGvkmKT1y9ztt3MBD8XVdeZ4+D0uVIu/XbL35ivz7b53Hz5DuRhKshGUtLe/U0vwfpUDyoctXFq0LLRjhM7zaopHDK54jbU3nZzDgZhBX++r3dgghhISGgcwjEA3lOqW8RrjPp6FpJGoiHVNcZIeZqctHBGBaCAwMQ+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szXFPrfZ25w78CxLMzArJRcjvUZzpgd60ahDqJnhgSw=;
 b=dJSLhzcN8NOL483NdN3xh0q6ChtyKgJP4zlMc/TMmoi7HVvHyNKgbfj4MZV2HJ3k83e2cEjeVZ7VxglWeHwXNUCBEjYexNQMGyX188zql0lcYuInwZSqo4TsDBGvnikdMbiPzpxic+0K+3T07s70XU1nUF/32zQX+BgiGJEFAtxn6LuAFJA39qDsKy0c5f7a2dJK3C5NeahzMuYNqK5kDNpqLzHAeMGBNekxUz1skjx5XzFWtTpfnPKti6Y7hQ6ZrK74khCJ3ovl5sBUkrKSZLWmmSkbJ9GivNPxnxHGaYYBzJjfbNF6ESQCgnuv9qqM+ZwNUrwFKbzqHwOpLlL+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szXFPrfZ25w78CxLMzArJRcjvUZzpgd60ahDqJnhgSw=;
 b=DWWAZgIU79Rpgfhz0V+2BKMhcsQ7ITaYLX5aXQBr8EXd9HONu0Q1TJXA5WORg5w6BJUwgFOqgfcOQuGzectdaOglYxLQ28L8s4FuFp4SEucji0+kynPm3jnt5BUMD+mu7ER19RNZruj3QLduVoKXdDRpn81WGFECaDymsCWQQiU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3873.namprd10.prod.outlook.com (2603:10b6:a03:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 19:21:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4995.023; Fri, 18 Feb 2022
 19:21:49 +0000
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
Subject: Re: [RFC PATCH 0/4] Removing limitations of merging anonymous VMAs
Thread-Topic: [RFC PATCH 0/4] Removing limitations of merging anonymous VMAs
Thread-Index: AQHYJMIVB+iU2FnRZ0OtT1wm/ZCbV6yZsAGA
Date:   Fri, 18 Feb 2022 19:21:49 +0000
Message-ID: <20220218192143.jdqcf4igcjpezmrz@revolver>
References: <20220218122019.130274-1-matenajakub@gmail.com>
In-Reply-To: <20220218122019.130274-1-matenajakub@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7ba37d7-44ee-4251-4802-08d9f313e97b
x-ms-traffictypediagnostic: BY5PR10MB3873:EE_
x-microsoft-antispam-prvs: <BY5PR10MB387357B39D215381F5AC0B63FD379@BY5PR10MB3873.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JBPjAUCpy+z75kLoMalE4609nsT+PnM+ZiczX8SyrP0nvmDhlqenoONsziz5zmHUTNrvBYCIk0Bk3b5pqIrUHfto0FAK1Ny7ZaB4+/Qt66n8j5503BCwb8iLtYqnQiefaMy2dmLObO5trUTRGGfLy82ThPviSSXiCcfnLNAjz1xL0SbJTtekFlAw7h6tWV6y3L4UbFVC4R+BSj8ZlogcXxjk1sm18ZZ1Cz1fPS6KWasO7fhAjm/jNooV7j48wmMZgQOXOaf8+47eC3bdpFKXxLKPPvPmcppXjbYJ6Iis78iR+HkMdFSDXwX0RBi9xlWF5RDNU8p/0yTwgRAUbGhzVAIyqh0/1g85rvfUSr/2GdvqtIFcdGx7J3tZwT1klU4xSkfBAcv8ESwL66LzkvvD9jGf6wVDyMu7MHRp4a/tA1hOJKjvTPw3kuBpBdgsEJfT/9/hyF4jtJXotuL1nRORyYI3futW+tO1+Qce25eIbfmChaec7mH6u09Ez+ZDMBBRH/qhjWI2dTojMGRX0nHli6xmecUsD74v7Jbht0S30Vn7WNadtLG/MVY2mK+t7G66qqiwENhNfjt9aNd4UGRrKGC+iGxxjVPm1yqLLW1kl+86bqufK1NJuEHNLGPFZLHRd/ogx/jThJilbTlLZQx2Ld3paABnvp5fXX5x1NnakHFPRAgti/6/FR7I0h1O4gSCENHCT+OAarV9+k1ErMDHCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(86362001)(6486002)(508600001)(54906003)(44832011)(8936002)(76116006)(91956017)(66946007)(66556008)(64756008)(7416002)(66446008)(4326008)(8676002)(316002)(33716001)(6916009)(122000001)(66476007)(71200400001)(26005)(186003)(66574015)(38070700005)(83380400001)(1076003)(6506007)(38100700002)(6512007)(2906002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTcrK2dmUmkxbU1vWlh0RkVDQ0RkTXVWQkVxclphL05pclg5Qm1KSHQ0YlZl?=
 =?utf-8?B?eGxlUy9hQi9jZXpCODZxRkljeDlIdXg0UnFEMU9oWUprWG9uNHNvTnIyZTlJ?=
 =?utf-8?B?QlNFSno4NXYvNnRjd3JsK2crNFZnUEthMll6SDBwaTBNSWN0TEdCdk56VDJs?=
 =?utf-8?B?WGRKZHBrNVFCd01INzNlUlRrUVp6MHJLTDVib2VlemwwQlNJaVJXcCs4ZmN5?=
 =?utf-8?B?d09aTFkxYWFVRzB5VzZMU2JNbFlhMXNWVWRySlJEQTlNVGcwQ1VLZGtKWFNq?=
 =?utf-8?B?dFhoSFE5RjdvcFYvTWdQeDVIMmpoMkxrc09aRndsUTVKWVRGU3dtQWp4VTJm?=
 =?utf-8?B?SWtrTjRjd3o5MHdTV2J2VU41MERmWGovYmtXTzY5aHdPalZ0ektvYjE4RE9G?=
 =?utf-8?B?L1lkaXRJV2NBL0dxWnlOMS9WSDc3MVBEc3FuSjhnWFlOd1ZVQ0NGSGIwdmhm?=
 =?utf-8?B?eFF6SnZUV1ZaY1g0WjVVSTEvUzlWSjZGd0k4WVUrMUNkSVBRck8yWUJyVU1n?=
 =?utf-8?B?d2FDYmUwVkM5ZENycDFCR0ovRFBTZVJzOWhVQ29kcHF2UzRxVEFQSlE0azBN?=
 =?utf-8?B?VFFaMm84UVg5QzFnM0ZBdGpNUlIrSWdlMWFHL1JnRE5OemwreFlYaG5QMXdZ?=
 =?utf-8?B?Q21sV0o2azBZNzA4OVY3VGdZOHpzelYvR0d6TWVERlFmODViZXhidGRvZzVM?=
 =?utf-8?B?NHVxd2RQakpyMDBQZXRUU0FFNkF4eUlRQVYvOVY0NmV6dHZxSEkyOXRjL1Zl?=
 =?utf-8?B?STJURGVjbHlWR2hUTlgvaDdBTWQ2OUxlamthSDJmZkV5VkVYMy9GLzNCVXFN?=
 =?utf-8?B?eUxxZmp3VEp2eFZocks5Q21JUWorODhKa0gyU003Mis3WHlxK3NrYzRKaWJQ?=
 =?utf-8?B?TVZWZ1MyMjFYZ0tBRklUZ0U2NCtpcFpzMHpPNC9KSHlEdk5XeEZFNTZ4NFlZ?=
 =?utf-8?B?N1VHRXNiOWI4cnNaMFdyRXpyNHh3bEJKNnBRbjkrY1BQUUo0K3ZZdXlZaXBa?=
 =?utf-8?B?U0x6Z0hJdjg4N1V2K05HRmhwbEU0N0V2amU2UTVub2ltOTFzSG1aZ09NQ2Zj?=
 =?utf-8?B?aWFwN28zZXVmdmdVQzFsWFo5QUlDK1F1b3lQRFdyYWtqMGhHb3E5WlZqSzJG?=
 =?utf-8?B?eTFSdUxoK3k4N2plZk5qS3lvQjl3WWRsQ1Mxd1BFTS9nU2VvNzBLeVk2V1Ri?=
 =?utf-8?B?ZTltZ2Jydm83anFvQ0ZZa1NzS3NlQmpHdHNjS3lwVmdVMXhnRTNoQmR1QWxL?=
 =?utf-8?B?bkxRS2FGa1JIREcvNUNYSUhQVWFES1N4SENqWmtnUGVUNHJEaGV4VVhoNWJM?=
 =?utf-8?B?bmR6YTEyc2hQWmdQdWVTN0lLY01xQU9jdU9uQmR4QVlYdkNGS1BWd0Yrb2JZ?=
 =?utf-8?B?bTNoZVlsbWRwYmlsTGlvR3pZK3RKeDVuR1AyRUlPY0MrTmE0UzVGSWFTclZj?=
 =?utf-8?B?RUJwZ1pKQkVOdW83WDF6UjJqZktTRUR3clpRMENoT0dHK0JlL2hQZHhQSXQ2?=
 =?utf-8?B?OWxaVnVOUWFpZkd4M0xjNXYzL0dqRU1XZ0tNQjg5ekRsZ1NlM3lLbEpJdTB4?=
 =?utf-8?B?ZUNCaHZoTURqc3RiNG9qMnRqeEFxNHRVOEpTQnhLZ2FLRTVyL0sxOGZYYWo3?=
 =?utf-8?B?clovYzNDS2Z0NC9XNVMrRDRXellxK0NkeFprZytUdjZGK0FDSGUyUFRLU0du?=
 =?utf-8?B?T0hnbHVjdm9iSWl5bUZPRFIxalVsdmVnMzVHb3c3SnNiZ3NHaHhVK05WcURU?=
 =?utf-8?B?R0FqdlU4MlM4OGVHOXVjQjVSYUtlRFZLN2VxRGZIcm0yUGxxRUR2ajhFT0dt?=
 =?utf-8?B?M2h6cWp4YW9rckR6c2kvQnIwblg4ZHZWUFE1cnV4WStHdXpoNzBoU3hHREpY?=
 =?utf-8?B?WmVIbmplTVpTUk5icnhHbnVvNGxSZHMzeU9KSEs5M0RXMm96a3Y5Q0kreFV5?=
 =?utf-8?B?ekZVTWUrRjNyaXE0TWxMUHNRR1Z5SXBxdEVINFJIenpzb1crWktrREM0dVM2?=
 =?utf-8?B?MWxDdjdTeWQzZ2Y2RWVrdlJ1Mit6V3Y4N2RyUG5TY3BVN3BJNXJleVhhUlZx?=
 =?utf-8?B?T0NTYXhkSUtCNm9Lb1dIUUFoVkJMbGFRN1ZrK1NiR2JJYUVhTkZvbm5aVFZX?=
 =?utf-8?B?eWl5eUswVjFXdUpiVG5GdzdMQjZHTXFOL3IraFM2UUVIMEFOVjU5M0kwejlK?=
 =?utf-8?Q?srsJ9COdndCpfrw6YlXGpV8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3070952FCE12DA4EB6CB16834053E9B9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ba37d7-44ee-4251-4802-08d9f313e97b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 19:21:49.5797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22dxRU862LkbcJ4+fYjZQl2gQp5GcjXX7qhFobr6qFhajxEQZ7MUtuFnNFwFe7DnbFEVriRLkikJlA02dEkUHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3873
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10262 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=882 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180118
X-Proofpoint-GUID: uODnEK-5fZI84XL8FMhNUfvrefdZGJly
X-Proofpoint-ORIG-GUID: uODnEK-5fZI84XL8FMhNUfvrefdZGJly
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
PiBNb3RpdmF0aW9uDQo+IEluIHRoZSBjdXJyZW50IGtlcm5lbCBpdCBpcyBpbXBvc3NpYmxlIHRv
IG1lcmdlIHR3byBhbm9ueW1vdXMgVk1Bcw0KPiBpZiBvbmUgb2YgdGhlbSB3YXMgbW92ZWQuIFRo
YXQgaXMgYmVjYXVzZSBWTUEncyBwYWdlIG9mZnNldCBpcw0KPiBzZXQgYWNjb3JkaW5nIHRvIHRo
ZSB2aXJ0dWFsIGFkZHJlc3Mgd2hlcmUgaXQgd2FzIGNyZWF0ZWQgYW5kIGluDQo+IG9yZGVyIHRv
IG1lcmdlIHR3byBWTUEncyBwYWdlIG9mZnNldHMgbmVlZCB0byBmb2xsb3cgdXAuDQo+IEFub3Ro
ZXIgcHJvYmxlbSB3aGVuIG1lcmdpbmcgdHdvIFZNQSdzIGlzIHRoZWlyIGFub25fdm1hLiBJbg0K
PiBjdXJyZW50IGtlcm5lbCB0aGVzZSBhbm9uX3ZtYXMgaGF2ZSB0byBiZSB0aGUgb25lIGFuZCB0
aGUgc2FtZS4NCj4gT3RoZXJ3aXNlIG1lcmdlIGlzIGFnYWluIG5vdCBhbGxvd2VkLg0KPiBNaXNz
ZWQgbWVyZ2Ugb3Bwb3J0dW5pdGllcyBpbmNyZWFzZSB0aGUgbnVtYmVyIG9mIFZNQXMgb2YgYSBw
cm9jZXNzDQo+IGFuZCBpbiBzb21lIGNhc2VzIGNhbiBjYXVzZSBwcm9ibGVtcyB3aGVuIGEgbWF4
IGNvdW50IGlzIHJlYWNoZWQuDQoNCkRvZXMgdGhpcyByZWFsbHkgaGFwcGVuIHRoYXQgbXVjaD8g
IElzIGl0IHdvcnRoIHRyeWluZyBldmVuIGhhcmRlciB0bw0KbWVyZ2UgVk1Bcz8gIEkgYW0gbm90
IHJlYWxseSBzdXJlIHRoZSBWTUEgbWVyZ2luZyB0b2RheSBpcyB3b3J0aCBpdCAtIHdlDQphcmUg
dW5kZXIgYSBsb2NrIGtub3duIHRvIGJlIGEgYm90dGxlbmVjayB3aGlsZSBleGFtaW5pbmcgaWYg
aXQncw0KcG9zc2libGUgdG8gbWVyZ2UuICBIYXJkIGRhdGEgYWJvdXQgaG93IG9mdGVuIGFuZCB0
aGUgY29zdCBvZiBtZXJnaW5nDQp3b3VsZCBiZSBhIGdvb2QgYXJndW1lbnQgdG8gdHJ5IGhhcmRl
ciBvciBnaXZlIHVwIGVhcmxpZXIuDQoNCj4gDQo+IFNvbHV0aW9uDQo+IEZvbGxvd2luZyBzZXJp
ZXMgb2YgdGhlc2UgcGF0Y2hlcyBzb2x2ZXMgdGhlIGZpcnN0IHByb2JsZW0gd2l0aA0KPiBwYWdl
IG9mZnNldHMgYnkgdXBkYXRpbmcgdGhlbSB3aGVuIHRoZSBWTUEgaXMgbW92ZWQgdG8gYQ0KPiBk
aWZmZXJlbnQgdmlydHVhbCBhZGRyZXNzIChwYXRjaCAyKS4gQXMgZm9yIHRoZSBzZWNvbmQNCj4g
cHJvYmxlbSBtZXJnaW5nIG9mIFZNQXMgd2l0aCBkaWZmZXJlbnQgYW5vbl92bWEgaXMgYWxsb3dl
ZA0KPiAocGF0Y2ggMykuIFBhdGNoIDEgcmVmYWN0b3JzIGZ1bmN0aW9uIHZtYV9tZXJnZSBhbmQN
Cj4gbWFrZXMgaXQgZWFzaWVyIHRvIHVuZGVyc3RhbmQgYW5kIGFsc28gYWxsb3dzIHJlbGF0aXZl
bHkNCj4gc2VhbWxlc3MgdHJhY2luZyBvZiBzdWNjZXNzZnVsIG1lcmdlcyBpbnRyb2R1Y2VkIGJ5
IHRoZSBwYXRjaCA0Lg0KPiANCj4gTGltaXRhdGlvbnMNCj4gRm9yIGJvdGggcHJvYmxlbXMgc29s
dXRpb24gd29ya3Mgb25seSBmb3IgVk1BcyB0aGF0IGRvIG5vdCBzaGFyZQ0KPiBwaHlzaWNhbCBw
YWdlcyB3aXRoIG90aGVyIHByb2Nlc3NlcyAodXN1YWxseSBjaGlsZCBvciBwYXJlbnQNCj4gcHJv
Y2Vzc2VzKS4gVGhpcyBpcyBjaGVja2VkIGJ5IGxvb2tpbmcgYXQgYW5vbl92bWEgb2YgdGhlIHJl
c3BlY3RpdmUNCj4gVk1BLiBUaGUgcmVhc29uIHdoeSBpdCBpcyBub3QgcG9zc2libGUgb3IgYXQg
bGVhc3Qgbm90IGVhc3kgdG8NCj4gYWNjb21wbGlzaCBpcyB0aGF0IGVhY2ggcGh5c2ljYWwgcGFn
ZSBoYXMgYSBwb2ludGVyIHRvIGFub25fdm1hIGFuZA0KPiBwYWdlIG9mZnNldC4gQW5kIHdoZW4g
dGhpcyBwaHlzaWNhbCBwYWdlIGlzIHNoYXJlZCB3ZSBjYW5ub3Qgc2ltcGx5DQo+IGNoYW5nZSB0
aGVzZSBwYXJhbWV0ZXJzIHdpdGhvdXQgYWZmZWN0aW5nIGFsbCBvZiB0aGUgVk1BcyBtYXBwaW5n
DQo+IHRoaXMgcGh5c2ljYWwgcGFnZS4gR29vZCB0aGluZyBpcyB0aGF0IHRoaXMgY2FzZSBhbW91
bnRzIG9ubHkgZm9yDQo+IGFib3V0IDEtMyUgb2YgYWxsIG1lcmdlcyAobWVhc3VyZWQgZm9yIGlu
dGVybmV0IGJyb3dzaW5nIGFuZA0KPiBjb21waWxhdGlvbiB1c2UgY2FzZXMpIHRoYXQgZmFpbCB0
byBtZXJnZSBpbiB0aGUgY3VycmVudCBrZXJuZWwuDQoNCkl0IHNvdW5kcyBsaWtlIHlvdSBoYXZl
IGRhdGEgZm9yIHNvbWUgdXNlIGNhc2VzIG9uIHRoZSBtZXJnZXJzIGFscmVhZHkuDQpEbyB5b3Ug
aGF2ZSBhbnkgcmVzdWx0cyBvbiB0aGlzIGNoYW5nZT8NCg0KPiANCj4gVGhpcyBzZXJpZXMgb2Yg
cGF0Y2hlcyBhbmQgZG9jdW1lbnRhdGlvbiBvZiB0aGUgcmVsYXRlZCBjb2RlIHdpbGwNCj4gYmUg
cGFydCBvZiBteSBtYXN0ZXIncyB0aGVzaXMuDQo+IFRoaXMgcGF0Y2ggc2VyaWVzIGlzIGJhc2Vk
IG9uIHRhZyB2NS4xNy1yYzQuDQo+IA0KPiBKYWt1YiBNYXTEm25hICg0KToNCj4gICBtbTogcmVm
YWN0b3Igb2Ygdm1hX21lcmdlKCkNCj4gICBtbTogYWRqdXN0IHBhZ2Ugb2Zmc2V0IGluIG1yZW1h
cA0KPiAgIG1tOiBlbmFibGUgbWVyZ2luZyBvZiBWTUFzIHdpdGggZGlmZmVyZW50IGFub25fdm1h
cw0KPiAgIG1tOiBhZGQgdHJhY2luZyBmb3IgVk1BIG1lcmdlcw0KPiANCj4gIGluY2x1ZGUvbGlu
dXgvcm1hcC5oICAgICAgICB8ICAxNyArKy0NCj4gIGluY2x1ZGUvdHJhY2UvZXZlbnRzL21tYXAu
aCB8ICA1NSArKysrKysrKysNCj4gIG1tL2ludGVybmFsLmggICAgICAgICAgICAgICB8ICAxMSAr
Kw0KPiAgbW0vbW1hcC5jICAgICAgICAgICAgICAgICAgIHwgMjMyICsrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLQ0KPiAgbW0vcm1hcC5jICAgICAgICAgICAgICAgICAgIHwgIDQw
ICsrKysrKysNCj4gIDUgZmlsZXMgY2hhbmdlZCwgMjkwIGluc2VydGlvbnMoKyksIDY1IGRlbGV0
aW9ucygtKQ0KPiANCj4gLS0gDQo+IDIuMzQuMQ0KPiA=
