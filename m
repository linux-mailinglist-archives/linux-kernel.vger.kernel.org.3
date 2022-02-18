Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15AF4BBEF4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbiBRSGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:06:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbiBRSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:06:09 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774FF1BA33D;
        Fri, 18 Feb 2022 10:05:52 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21IBEsoS018177;
        Fri, 18 Feb 2022 10:05:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=V/Exuiw6iSsGd3JEc92YnAQ4ePKe46mOB1u+CfhC6Zg=;
 b=eFfDX3iZtCQxhKbaDBoa5CTDAhkgqnHCzLd7ODJ1Lt3ZrHRRAeBqvteyKZjcui8O55Qr
 zaE7WZis6Gk5AkWOSae/9iIaawL8z4Q3ua5r8ACXl9YN5/p7z/zkE2x4V5sjaEkSi/4q
 mRv72D1G+w8ITCW+SJZ5M3qe9VTENgjAPMI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e9e7xcdhr-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Feb 2022 10:05:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 10:05:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMmj3Ux7w7EhatY3fmhcGDG57kTy2Ga92bxDZupdkRglpnfXDLQHAs/XELztxX41w2AseALZ/cRwyxvpSq6DvwDtzMd46pP1B/NiELlekJkeciJFrYSPJTFqqVlxVBiqIoPNJ8Sd7IEm9WR7lwhIvdLEau9dwIFz7Y5R32EaehFpR6xTuTwlThmKEbKo83pdkxcVQbFVwB+UfKHHz7MZ0PNddyorEhVVX3L6O01tbK/Uz0tGR4EXNSPNHwAARaCHaiblD7M4iILgTI2p3S4nHXU691YXbaTSOoyLnBnPtd+dFSASP4S0j6UtZGq6Up28GH3Zebdxh5UVh/g3KJw3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/Exuiw6iSsGd3JEc92YnAQ4ePKe46mOB1u+CfhC6Zg=;
 b=Dwx+H3E1OUM7sb9QAql1UoBCl5sucK44n0TTspIcRudQzXSWQv5R1KXgGUV2X1ylLXO9x4Vx+a40Fjm/I53gLLBKFux1F7/aHrpdTyeybkeu9BWwLGpU5SgZlUESJKXV0hhK/ulu4IsLwOdpMUrPZ/Bt46B5spEREBV9jbEj9FELcQfag079JTJCpQ6nu3tgLqP3LRb6K9ql866BkRQxLQ6n1UtXSxavxtAmHWr+WxU/tNsP/PWP7pHvOHvpxj4OJPpAywnl7h8al/kj6DCpkWE5WfKqahdxu0tkNwNveNaZ0ClpeZFaznCjOczbbxfFYeqZL/7KJZxDc9iUGt4Xaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by SA1PR15MB4657.namprd15.prod.outlook.com (2603:10b6:806:19c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 18:05:47 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::7cbb:e9df:5833:370e]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::7cbb:e9df:5833:370e%6]) with mapi id 15.20.4995.017; Fri, 18 Feb 2022
 18:05:47 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>, "greg@kroah.com" <greg@kroah.com>
CC:     Dmitrii Okunev <xaionaro@fb.com>,
        "qiaowei.ren@intel.com" <qiaowei.ren@intel.com>,
        "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>,
        "xiaoyan.zhang@intel.com" <xiaoyan.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gang.wei@intel.com" <gang.wei@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [discuss] Improve and merge a driver proposed in 2013: sysfs
 interfaces to access TXT config space
Thread-Topic: [discuss] Improve and merge a driver proposed in 2013: sysfs
 interfaces to access TXT config space
Thread-Index: AQHYI/QfaYkfdhkKB0GRGIMREhsvJayXrY4AgAAA5oCAAe3xAA==
Date:   Fri, 18 Feb 2022 18:05:47 +0000
Message-ID: <0cf678e0b01bf421f3db6693a15ac4060501a80a.camel@fb.com>
References: <1368465884-14779-1-git-send-email-qiaowei.ren@intel.com>
         <1368465884-14779-3-git-send-email-qiaowei.ren@intel.com>
         <20130516160311.GA12299@amd.pavel.ucw.cz>
         <4febd50da7e5007a2797e0f4c969fa5edd0bf725.camel@fb.com>
         <Yg5A4Mupue0V9diu@kroah.com> <20220217123753.GA21849@duo.ucw.cz>
In-Reply-To: <20220217123753.GA21849@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10a01dd2-8b35-46c4-b694-08d9f3094a42
x-ms-traffictypediagnostic: SA1PR15MB4657:EE_
x-microsoft-antispam-prvs: <SA1PR15MB46570D8DEBBBEE7ABDA679E7C1379@SA1PR15MB4657.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s2cWsJW3xiXdcgWNzzs+Uv1hGa3qk0NkRBJaz/XUxJ28ycMP6qxQXYsvhQGVhcxYxgxPLinnEcYS/NZH2zNo/lkVc7aOuzHs2n/6kLHeTbmaD52YIqU5b30z5LVxktFW/beoMPclIVADLO/rKLvjczmiK/PMsVm52lUqgDnNNSAix9jHKDWXTIujDkeDsxOSxGC82oFiJlO1eovRXu0K7QFKdcHy6u2JsaGnmGjla+57NA2vYAaRs+2lGKCteeQJyFQsryfTTDltcXkAghKM7+UA7EHWCj9iDyCV6lf5UrQyI4IbNQYiN1Ce0rYRZomwZH/ZATokMi6uHA6zXHHK59agKPiVF9R08mUd3P3D7RibU4zg6Ituaov+ocvKkGhH2SLwldmDxo1Mn8B0QkhFGPeqemcXKZdsXrAs8wPHUD5lz8NLQAqZoruix10KVXjfZBtuPyb2JwdeHdJAibNcm8lsl21KtTmwBCUz0CKeaW0iTfrr9D++rCsfXoalh9U7RsybGljqjAjkjnz3uXdGs7+IeyPQiF1CKqui9Cd81260ntlExP7J0rmL9XnzOiS/LiAx4mKnGwULrL7tKv8Tu6ELAoEHTOugv9SRXWG2su0FkQAN0hS5og+r6OLOSWXIje4llLkEimUeTUprXYC/KjwpUxqlqDk7dxBw5YjsswUxPE/BffdIyb9pZPvbr5XkebRybDgSFErOOuNQiDjy+5w4DOxwnIw+rK30pPc5c/8lkOUu4e92LhZssNTGhDrbR+U3YhcZWpL2uykBfDcdUXIr0TCi+ppiu9b7MXmtpWo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(186003)(6512007)(6486002)(71200400001)(6506007)(122000001)(508600001)(38100700002)(966005)(8936002)(316002)(66446008)(54906003)(2906002)(110136005)(91956017)(76116006)(2616005)(36756003)(38070700005)(66946007)(5660300002)(86362001)(8676002)(4326008)(66556008)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzJ1Y0QzOVVraC9FRUVHQ2ZJWDc5eFhveVpLS0ZteHpXalFIUEFYMmcxNmY0?=
 =?utf-8?B?T0daemN4dmM1TDY2cTFNYkpvQTFDeXlEM2xSc0xlOC9yemFsTjdMQ1FKbEN3?=
 =?utf-8?B?MlBtRG1YVXh3Sml6Sk5aNzVya1VlUCtaTFdNclNMWVdEcUdzUUdRaVRKblVu?=
 =?utf-8?B?Qk9iN1RXUjJIRXhTMTBKeDhNeHJ2eHA1RWxXeUdrVTUzdTBqT3F4bnJ5TWo2?=
 =?utf-8?B?WTB3RE81UWJpYmFpSHFTOU9vaE1nTURKdTFGU2cvN2QxWEUza2I1SEQvU3NX?=
 =?utf-8?B?RGJWQnI0ZEFKSFNPeVJGaVRKSDRXQWM1b1BmajJzSEZxTnJLSFluMFA4c0Rm?=
 =?utf-8?B?amdUbzQzMlNnUjYrbXVuT1lwTTErL1ZKbHRQRDVSc0ZzaldyN2RyTmo0TGVI?=
 =?utf-8?B?RmRCemJsd0JGZ2ZoSldlN1Q4U2h4YkNBM1BYS3VXUDc2eFNmb1NOMG96bE5F?=
 =?utf-8?B?S1RISDZKRE12ajFVT1VmZlhiYWcwNEVpM0JKZVF1ZlRwZmI2bmRkenRSU2s5?=
 =?utf-8?B?aXhFR1ZsOHM0VkkvMUlFN1FoMFVicE4wY0R6dURISzF3cmFNTitJMWNkZEFT?=
 =?utf-8?B?QzVrU29xbm1KclhZVjhoTHdXUFJBRm9VWEw2aGl2NlUvZmJHS0hYY2pOdStP?=
 =?utf-8?B?OGNPdW96bFhpeGsyZHFPLzBDRHo3TkcwQVdITTBhR3JxbUtLMDQyYTMxdEd0?=
 =?utf-8?B?RUZoK3BicGo3aVVWUUVjN3BOMUZOcTAvS25UZjRBWFRjR1hMOTNRVCtXQXF5?=
 =?utf-8?B?Y3p0V2Qzc29WUTJDa3pQb1BoRWU5RXl6WEN6bGZsT1RYT2NaZ0JGRkRwbXVP?=
 =?utf-8?B?SDNhSzZDTjlKQkNmbUFSTUd3WkgzK1JqdWxXci9ENjJFb3ByTmRqMkxoeEpX?=
 =?utf-8?B?N3NsOVpzTDRMN1RnOWtvS0tHU0djd0hrK2FqOGlITkt1NDJZRk5iQzF5UGt2?=
 =?utf-8?B?aEgvTnoxeldpNzRENlB0OS85YTJwQTVIZnl1RTJva3VDNGw2Q3FsQndsQ0tp?=
 =?utf-8?B?ako0d3hPM2VIMEdlVVlROXJKblhmVnFNeUN0cVdha2xDK3czNEdESmxzektQ?=
 =?utf-8?B?RHFiNEpSaHRhekUyU1pzNWVVSm04eWJlVEh5NzZTQURNY1JDekFEVTFsS3h1?=
 =?utf-8?B?QW5TK1U3aFZySld0b2ttVTh1cmpvM3RHOUpQd2ZUVldXendvM2xpd1pnMGYw?=
 =?utf-8?B?eDhQclB6UVBjSGJYZlc1czJMTlVTdEpUTnFzWGtJdjhXTHN6ek01NVhvQUQx?=
 =?utf-8?B?WGNvdDdVaDJzeTV5bG91cTJGYmR3bktKZjRzSi80VFJLT1dOODFEQnkyVmhr?=
 =?utf-8?B?TGt5Nm9uRitDS2Rid24yTmJZMmZpN3RuVjVkUFBraFNEeEtmRGF1WXNpOTNi?=
 =?utf-8?B?dmN1UHhFSVVXaVZxQXFhOEZiMDJvMVB3RUc5TllXc1ZieEZNa3Q5elE2TGhy?=
 =?utf-8?B?Y0YrSVpiaEFSMi94SFo5OXppYmpjMkFBZW9DQnZLZEgzZFVjZ0Q2Q2ZDUGhK?=
 =?utf-8?B?QU5wRkM0U3Nub3BFR0c2MkFVZzlJRlkwK1c5YlN6T0VrZzU3cU81Y1FBeTRt?=
 =?utf-8?B?RklGamZGOHlIY0tzR09oVDJWRlpLaTMxZkRXcHFLRWgwbENoaDVRa2taMy9G?=
 =?utf-8?B?MGIyQ2txdk51M2RBdVNpQlg3SzBCVFgwUDRpVCtlbWxHZkU1ZEYxNHpDamF0?=
 =?utf-8?B?Umo3QnFZR211VUtEd1I4MUo3NllnS0krdVppYWFydGpGbFgzZm5qbGxqSGxS?=
 =?utf-8?B?VFNnQndqQWpNdE4wbVhxOHpKaEV5YzY1aERhczVtYTl2U3dobXBoZDFrc3ZL?=
 =?utf-8?B?dFlOa2d6eTY2WFVFTWZwTnZsMUFybXRCdXk5eERUV1JtVGw4U2oxMDlMTnFh?=
 =?utf-8?B?M0NoaUxpNmpqTWxDNDcwcllwVzNINDRPWlFSR0xqMHNGWXZnUmlVdHRReXpF?=
 =?utf-8?B?NVU2bkZtaytCd3FJTFlCMTBsMmNjbUdZQm5LaWVMN2o0Z2JGZzhxYUErS25F?=
 =?utf-8?B?djlZNGZ0N1laNzFvZnovSy8zQkovT0JEbld4bml0S0xVV0pXZzZyOTlzYUw4?=
 =?utf-8?B?eG5JdFRpQy96bmRnaDhaUWRNU0VhL0lkekxHVDRZcjM3clM2QmNpc1dsdDZm?=
 =?utf-8?B?akdVMERwMmFFQ2RHa1pGSkpqWDVma0tKODk3Z011WXd3dWUzK1UxNkVUVy9G?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13930B42E3129444916D7A7026DE7C37@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a01dd2-8b35-46c4-b694-08d9f3094a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 18:05:47.4527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeKDbFsavjXSPRbDGcrU0HQAIqHb7STZP72+YdwUJBrsXZsjXLcaxDlgrXtbMIQR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4657
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 7TRrT8RBALcEkxZyC5kPi3Txh1p9L-93
X-Proofpoint-GUID: 7TRrT8RBALcEkxZyC5kPi3Txh1p9L-93
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_07,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 mlxscore=0 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180111
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTE3IGF0IDEzOjM3ICswMTAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6DQo+
IE9uIFRodSAyMDIyLTAyLTE3IDEzOjM0OjQwLCBncmVnQGtyb2FoLmNvbcKgd3JvdGU6DQo+ID4g
T24gVGh1LCBGZWIgMTcsIDIwMjIgYXQgMTE6NDc6MjFBTSArMDAwMCwgRG1pdHJpaSBPa3VuZXYg
d3JvdGU6DQo+ID4gPiBIZWxsbyENCj4gPiA+IA0KPiA+ID4gQXMgZmFyIGFzIEkgc2VlIHRoZSBw
YXRjaCB3YXNuJ3QgbWVyZ2VkLiBBbmQgSSBzZWUgdGhhdCB0aGlzIGlzDQo+ID4gPiB0aGUgb25s
eSB1bnNvbHZlZCB0aHJlYWQgaW4gdGhlIGRpc2N1c3Npb246DQo+ID4gPiANCj4gPiA+IE9uIFRo
dSwgMjAxMy0wNS0xNiBhdCAxODowMyArMDIwMCwgUGF2ZWwgTWFjaGVrIHdyb3RlOg0KPiA+ID4g
PiBPbiBUdWUgMjAxMy0wNS0xNCAwMToyNDo0MywgUWlhb3dlaSBSZW4gd3JvdGU6DQo+ID4gPiA+
ID4gVGhlc2UgaW50ZXJmYWNlcyBhcmUgbG9jYXRlZCBpbg0KPiA+ID4gPiA+IC9zeXMvZGV2aWNl
cy9wbGF0Zm9ybS9pbnRlbF90eHQvY29uZmlnLA0KPiA+ID4gPiA+IGFuZCBpbmNsdWRpbmcgdG90
YWxseSAzNyBmaWxlcywgcHJvdmlkaW5nIGFjY2VzcyB0byBJbnRlbCBUWFQNCj4gPiA+ID4gPiBj
b25maWd1cmF0aW9uIHJlZ2lzdGVycy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgbG9va3MgbGlr
ZSB2ZXJ5IHdyb25nIGludGVyZmFjZS4uLiBlcXVpdmFsZW50IG9mIC9kZXYvbWVtLg0KPiA+ID4g
DQo+ID4gPiBBcyBhbiBhY3RpdmUgdXNlciBvZiB0aGVzZSByZWdpc3RlcnMgSSBob3BlIGl0IHdp
bGwgYmUgbWVyZ2VkLCBzbw0KPiA+ID4gSSB3b3VsZCBsaWtlIHRvIGltcHJvdmUgdGhpcyBwYXRj
aCAob3IgcmV3cml0ZSBpdCBmcm9tIHNjcmF0Y2gpDQo+ID4gPiB0byBtYWtlIHRoYXQgaGFwcGVu
LiBPdGhlcndpc2Ugb25lIGhhdmUgdG8gZG8gaGFja2VyeSBhcm91bmQNCj4gPiA+IGAvZGV2L21l
bWAsIHdoaWNoIGFsc28gY3JlYXRlcyBwcm9ibGVtcyB3aXRoIHByb3BlciBhY2Nlc3MNCj4gPiA+
IGNvbnRyb2wuDQo+ID4gPiANCj4gPiA+IFRvIGJlIGFibGUgdG8gaW1wcm92ZSB0aGUgcGF0Y2gs
IGNvdWxkIHNvbWVib2R5IGNsYXJpZnkgd2h5DQo+ID4gPiBleGFjdGx5IHRoaXMgaXMgYSAidmVy
eSB3cm9uZyBpbnRlcmZhY2UiPw0KPiA+ID4gDQo+ID4gPiA+ID4gK1doYXQ6wqDCoMKgwqDCoMKg
wqDCoMKgwqAvc3lzL2RldmljZXMvcGxhdGZvcm0vaW50ZWxfdHh0L2NvbmZpZy9TVFNfcmENCj4g
PiA+ID4gPiB3DQo+ID4gPiA+ID4gK0RhdGU6wqDCoMKgwqDCoMKgwqDCoMKgwqBNYXkgMjAxMw0K
PiA+ID4gPiA+ICtLZXJuZWxWZXJzaW9uOsKgMy45DQo+ID4gPiA+ID4gK0NvbnRhY3Q6wqDCoMKg
wqDCoMKgwqAiUWlhb3dlaSBSZW4iIDxxaWFvd2VpLnJlbkBpbnRlbC5jb20+DQo+ID4gPiA+ID4g
K0Rlc2NyaXB0aW9uOsKgwqDCoFRYVC5TVFMgaXMgdGhlIGdlbmVyYWwgc3RhdHVzIHJlZ2lzdGVy
LiBUaGlzDQo+ID4gPiA+ID4gcmVhZC0NCj4gPiA+ID4gPiBvbmx5IHJlZ2lzdGVyDQo+ID4gPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlzIHVzZWQgYnkgQUMgbW9kdWxlcyBh
bmQgdGhlIE1MRSB0byBnZXQgdGhlDQo+ID4gPiA+ID4gc3RhdHVzDQo+ID4gPiA+ID4gb2YgdmFy
aW91cw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBJbnRlbCBUWFQg
ZmVhdHVyZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGlzIG5vdCBlbm91Z2ggdG8gYWxsb3cg
cGVvcGxlIHRvIHVuZGVyc3RhbmQgd2hhdCB0aGlzDQo+ID4gPiA+IGRvZXMvc2hvdWxkIGRvLCBu
b3IgZG9lcyBpdCBhbGxvdyAoZm9yIGV4YW1wbGUpIEFSTSBwZW9wbGUgdG8NCj4gPiA+ID4gaW1w
bGVtZW50IHNvbWV0aGluZyBjb21wYXRpYmxlLg0KPiA+ID4gPiANCj4gPiA+ID4gSXMgdGhlcmUg
c3BlY2lmaWMgcmVhc29uIHdoeSAiYmV0dGVyIiBpbnRlcmZhY2UgaXMgaW1wb3NzaWJsZT8NCj4g
PiA+IA0KPiA+ID4gSSB3b3VsZCBsb3ZlIHRvIHJldXNlIEludGVsJ3MgcHVibGljIGRvY3VtZW50
YXRpb24gWzFdIHRvIHByb3ZpZGUNCj4gPiA+IGEgcHJvcGVyIGRlc2NyaXB0aW9uICh3aXRoIGJp
dCBsYXlvdXQgb2YgdGhlIHZhbHVlKS4NCj4gPiA+IA0KPiA+ID4gWzFdIGh0dHBzOi8vY2RyZHYy
LmludGVsLmNvbS92MS9kbC9nZXRDb250ZW50LzMxNTE2OA0KPiA+ID4gDQo+ID4gPiA+IFsuLi5d
LCBub3IgZG9lcyBpdCBhbGxvdyAoZm9yIGV4YW1wbGUpIEFSTSBwZW9wbGUgdG8NCj4gPiA+ID4g
aW1wbGVtZW50IHNvbWV0aGluZyBjb21wYXRpYmxlLg0KPiA+ID4gDQo+ID4gPiBEbyBJIHVuZGVy
c3RhbmQgY29ycmVjdGx5IHRoYXQgYSBwcm9wZXIgZG9jdW1lbnRhdGlvbiBvZiB0aGUNCj4gPiA+
IHJlZ2lzdGVycyBzb2x2ZXMgdGhlIHByb2JsZW0/DQo+ID4gPiANCj4gPiA+ID4gSXMgdGhlcmUg
c3BlY2lmaWMgcmVhc29uIHdoeSAiYmV0dGVyIiBpbnRlcmZhY2UgaXMgaW1wb3NzaWJsZT8NCj4g
PiA+IA0KPiA+ID4gV2hhdCBhcmUgc3BlY2lmaWMgcHJvYmxlbXMgd2l0aCB0aGUgY3VycmVudCBp
bnRlcmZhY2U/DQo+ID4gDQo+ID4gV2hhdCBkbyB5b3UgbWVhbiBieSAiY3VycmVudCIgaGVyZT/C
oCBZb3UgYXJlIHJlZmVycmluZyB0byBhbiBlbWFpbA0KPiA+IGZyb20gMjAxMywgOSB5ZWFycyBh
Z28uDQo+ID4gDQo+ID4gSWYgeW91IHdhbnQgdG8gcHJvcG9zZSB0aGUgY2hhbmdlIGFnYWluLCBj
b3JyZWN0bHkgdXBkYXRlIHRoZSBwYXRjaA0KPiA+IGFuZCBzdWJtaXQgaXQgdGhhdCB3YXkuDQo+
IA0KPiBJIGRvbid0IGJlbGlldmUgdGFraW5nIGhhcmR3YXJlIHJlZ2lzdGVycyBhbmQgZXhwb3Np
bmcgdGhlbSAxLXRvLTEgaW4NCj4gc3lzZnMgaXMgdGhlIHdheSB0byBnby4NCj4gDQo+IFdlIHdv
dWxkIGxpa2Ugc2FtZSAvc3lzIGludGVyZmFjZSBvbiBkaWZmZXJlbnQgaGFyZHdhcmUsIGFuZCBz
aW1wbHkNCj4gZXhwb3NpbmcgSW50ZWwncyByZWdpc3RlcnMgaW4gL3N5cyB3aWxsIG5vdCBkbyB0
aGUgam9iLg0KDQpTbywgZm9yIG91ciBwYXJ0aWN1bGFyIHVzZSBjYXNlIHdoYXQgd2Ugd2FudCB0
byBiZSBhYmxlIHRvIHNlZSBpcyB0aGUNCnN0YXR1cyBvZiB0aGUgVFhUIGRldmljZSwgc28gd2hl
biBhdHRlc3RhdGlvbiBmYWlscyBpdCdzIHBvc3NpYmxlIHRvDQpkaWFnbm9zZSB3aGVyZSB0aGF0
IG1pZ2h0IGhhdmUgaGFwcGVuZWQuIEF0IGEgbWluaW11bcKgZGV0YWlscyBmcm9tIHRoZQ0Kc3Rh
dHVzIHJlZ2lzdGVyIGFyZSBmb2xkZWQgaW50byB0aGUgZmlyc3QgbWVhc3VyZW1lbnQsIGFuZCB0
aGUgZXJyb3INCnJlZ2lzdGVyIGNhbiBwcm92aWRlIHZhbHVhYmxlIGluc2lnaHQgYXMgdG8gd2hh
dCB0aGUgVFhUIGRldmljZSB0aGlua3MNCmZhaWxlZC4NCg0KQXQgcHJlc2VudCB0aGVzZSBkZXRh
aWxzIGFyZSByZXRyaWV2ZWQgZnJvbSAvZGV2L21lbSwgYnV0IHRoaXMgaXMgbGVzcw0KdGhhbiBp
ZGVhbCBhbmQgcHJldmVudHMgdGhlIHVzZSBvZiwgc2F5LCBrZXJuZWwgbG9ja2Rvd24uIEFzIGEg
cmVzdWx0DQp3ZSdkIGxpa2UgdG8gZXhwb3J0IHRoZSBhcHByb3ByaWF0ZSBkZXRhaWxzIHZpYSBz
eXNmcy4gVGhlc2UgYXJlIGxpa2VseQ0KdG8gYmUgZXh0cmVtZWx5IHNlY3VyaXR5IGJsb2NrIGlt
cGxlbWVudGF0aW9uIHNwZWNpZmljLCBzbyBJJ20gbm90DQpjbGVhciB0aGF0IGEgZ2VuZXJpYyBh
Z25vc3RpYyBpbnRlcmZhY2UgaXMgYXBwcm9wcmlhdGUgdG8gcmV0cmlldmUNCnRoZXNlIGRldGFp
bHMuDQoNCkRvIHlvdSBoYXZlIHRoZSBzYW1lIG9iamVjdGlvbiB0byBhIHJlYWQgb25seSBzZXQg
b2YgaW5mb3JtYXRpb24NCihyYXRoZXIgdGhhbiB0aGUgZnVsbCBjb250cm9sIG9mZmVyZWQgYnkg
dGhlIGluaXRpYWwgc3VibWlzc2lvbik/DQoNCkouDQo=
