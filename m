Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735DC5B289A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiIHVf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiIHVfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:35:25 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D64D245;
        Thu,  8 Sep 2022 14:35:24 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288LHZaC007048;
        Thu, 8 Sep 2022 14:35:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=DujO/ReJkIEMlcwxS+XW1dKb7EcpT+AKe4SytBYDtx0=;
 b=WsPjU26AXNWtPmEi/dS+bY43USUuQK3RjW3d4innFYu6cedr4Cw5OKNvknq6d0EGzTbT
 5u5ZQA2lpzBpAMyiIZqZnuyA5eiTc9hoSb3pH6+N7U0GFRpjC41KLscFU3D7qnRS2fLa
 AAM87uiZ40KOQwUIMBzsXG78Cbp8wFFjMAI= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jfk74jnru-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 14:35:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkPlY5ODpfmRmCBLvF4z/MZ3F4mmU0fNlNRYMK8o95VoAKlmMSmfynEe7zPRGHsjDkCSepCMoq/NQnpjMT5E2WkPwqysIMrUTVTJuCSkzOhi/erNoq9FOfbtLw5J49yDQ4NtlqL4EUvxeZBXsKvFfomKKqu3M6NIV9diA8L5CLNht9t1bvjeTQIyHTYe8glai3StxmZ/CB5PkhyO39y06WPXVPUhMtqUP78/yA/pAGgJJMJsviFQbgcAselZsFRqzCyEOgmlB2AtWpYVBbpzjNLKfsX+pqwPXm7dSOrnFyu64lhBba16PQh1Xiaq0IYA7+Z3LJtL8lIvBA+WuCOGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DujO/ReJkIEMlcwxS+XW1dKb7EcpT+AKe4SytBYDtx0=;
 b=HuukEj7cKsZ+pinnXgdsg+uMeMYNEy7ixvjULkmGnp0sprMsY5WCUw6bb0kjPHPEESVvKrAXwA0+TJm4AxunD04OLu9o+Mlk4/K4dqn2z78Hto4FSS4YBU58flhhjOOneTGKzCYcQovLYQaADxKTC3EQjazWWuL8UdQj4bqsuv0X9At64iP/DPMtAbLcdPNfyTjwUlBwxhDUny3gVowii2cSXDiplhMRLPn7liYuMTe22nKcY58hxnnI2xmnQ8Zcb21MZ+DpqQbmE6+HL9eZqLooxeXATcKlmE7I3OPAwAVChO8x64X9/fj2f4gKoZfnJgPXjkKkVd2EhAU9BBA3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB4969.namprd15.prod.outlook.com (2603:10b6:303:e4::23)
 by SJ0PR15MB4470.namprd15.prod.outlook.com (2603:10b6:a03:373::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 8 Sep
 2022 21:35:21 +0000
Received: from CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f5e:6caf:40a6:ce10]) by CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f5e:6caf:40a6:ce10%7]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 21:35:21 +0000
From:   "Jonathan Zhang (Infra)" <jonzhang@fb.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 09/15] cxl/acpi: Determine PCI host bridge's ACPI UID
Thread-Topic: [PATCH 09/15] cxl/acpi: Determine PCI host bridge's ACPI UID
Thread-Index: AQHYvRIwy8rOqcA1b0qGSKl7IMSeNq3WDjSAgAAGXQCAAAcUAA==
Date:   Thu, 8 Sep 2022 21:35:21 +0000
Message-ID: <485824AC-DCEA-4DE2-A331-CAC5DE901600@fb.com>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-10-rrichter@amd.com>
 <DE840F3C-0CBA-49A5-B9B9-9D279FFAAFFA@fb.com>
 <631a5a27f22ac_166f29479@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <631a5a27f22ac_166f29479@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR15MB4969:EE_|SJ0PR15MB4470:EE_
x-ms-office365-filtering-correlation-id: 7ffd1f13-e8ac-4137-70d0-08da91e2085c
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3qzfSnlFVtMkd5g+CVnk33S0j8KCAKFIqO+zia6gUNCfeN4ngqMTSAVLaB4dC4pO7fCJ7wPnYgXCsuiFXZuqVAc1pRPH0GdAiAdFf4fjOf9aUrZlQxJ8WlWx0GPLFjKkXIQ8WQeCQuOfNHO0fV+BjBroPqbK5DIbh/PIOlsd6Qf9Uzo8XngrnNxpTBGjcdORif+36p+aVHMpN7Es8SLIT9WoEMLis1wQ3fbq8ropSQVJFNjfHlDMFdRcw/lrERP2h9hep3J98YKEtP/IifTxfii7il/nFfUgjSJqfZTKbXmA6WFgIikGCRHkcHxL0Id6NPOKRaAFterlYvUZ5y6mRnBMSG/rzke6zbIw3fp1rwm0JMWw+wKgUXCmU38zKdyrH7g10liqzJni1UL8zse0Jodk1U5Z2jw349HtvrWkEhs9eAyxCcmnvtrPGV3GjKVCtnIJAHkczy235BLU+ZE+YKSBbqnivojq4+R41VCSCghkUDpyUVW/Aoc4y8kTCmB1WVH05A32QrBss0RcuO7Dpe30HlVq/uEgw1neMsGC7kJoH+vjdBLHmQVHXs3qVUnX4Q3yQqtUT/+kv/+hJFGWxsQhPU+lvG4rZGPYQsNI+QZqbbxy0cx7TJvHszyEjgLgDXwJ6eZgLAOw010DmJge75KMyQ/CIxmii576Z6LIyEttUO2CiJYBfw6LcP+xs8Pffio0IXsHz3ZYz4lgkW9lQVH0BtH4Ewjn+3PMlwLDHd/21XTjEqMbjnTuVwllnJSk6PdtwzXfPT7Oifd/njgQqK7r7rGag1VseuZchiX559A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4969.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(6916009)(83380400001)(54906003)(76116006)(6512007)(478600001)(53546011)(6506007)(316002)(91956017)(33656002)(36756003)(86362001)(186003)(66946007)(66476007)(66556008)(2616005)(8676002)(4326008)(66446008)(64756008)(5660300002)(2906002)(8936002)(7416002)(6486002)(41300700001)(38070700005)(71200400001)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDg3Y1U0cGU3aGV0eUVBSVNyVlg3VmVLSVNyOW9YNGZ2UWNkZWRVbllSTXQx?=
 =?utf-8?B?VWR0ZWlRRzFGS3RraXZkY1dhRHdjMytiYStEMEc1dXozZDZZSFp6cU9lT2N3?=
 =?utf-8?B?QkdrL2VxUU0xRDR5WGtBVHN1QWUzYjQ2SzZGaFducDlaN3BvUjgwMTJRSHZv?=
 =?utf-8?B?TWUyRkJFNmhjTGdhcmdRbmFvMUd5RXI4SUJEVC9kZHJYS21RRTkwd2JXWVRR?=
 =?utf-8?B?VDgyOFZUU0R1QVZHK0dWTDRLcXdyQzA1cE12WFNMNEJIUiswMUxnd3UvNnBP?=
 =?utf-8?B?ZFNJVm9RenZiN0J6UXk5eWJscUdTRlhMakVPMllyNjIzVjNMc3dYS0d3bzNw?=
 =?utf-8?B?eXBvM2orT01jbkt6aWFEZS9RZ0lQKzJGNHVpVlB3UlUzRkt3QTU4V2o2eVM3?=
 =?utf-8?B?ODJRVDhNd1VwR2F6SnltWVhud2FBWCtLTXFzR3BYQnNFOFNHM01DSDFsSGkz?=
 =?utf-8?B?RndOSFVkdmxLS3dGVGYyd09McGl2Q0dtWUJjWjliK20zc1owT0JxdXE5STRD?=
 =?utf-8?B?Sk5OcHNaNDlIaUNRK1NDRGh6Y2VjZzZQTHpBb2ZTUi9nTllKTmttKzVXN1JC?=
 =?utf-8?B?cUF2ZHNDbkdLT2UrL1ZTSlA1dEVmTVNlc2xzUmd0MzdyN1pNVzF5NmZIT2Jn?=
 =?utf-8?B?SFUzV213T2ZoMmFPMHpLSG0zaXgrcFNTaDBybUpwUjhlTHJiVUxVcWJ4RktG?=
 =?utf-8?B?NVdaOFk1cDhoZ29TbGNNZmwrT3VEY2JkRlhTWTFkZC96WS9McWEwYXJxQlJN?=
 =?utf-8?B?L3J5RzI1c1JRQnVsR3p2c1RkS1hSQXRCY2xWODIzTVl5cjhPOEh1M3BaSzBq?=
 =?utf-8?B?YThEdVZXRCtsdzF4Wm1TVitGNlRRdFJUQk5EeXY0VVB6clViQnUyd0xaRFZB?=
 =?utf-8?B?OUFPS2R4L3RFU2dzZkdHNjdoc0pBZ2FhajlNZzhkbGVDampzaE9Sb2VhNWJI?=
 =?utf-8?B?d0FJS2xGWDdEUkxZSklHWGRPeWE5VXkyU2FoVHRtcUIwRU9hRDE2VzF0WVNJ?=
 =?utf-8?B?dCs4WjI1eFM1Q3UwWFd4WCsyNk1ZbEt2NDBLNEpLZlNGZVdSOGhJRzFlcGRh?=
 =?utf-8?B?Z2VKY3ZBK2Z4QjErYVhtOFkwVWV5NWhsY2pnRUI3WHdPVlBRUWZ6bUJQNlRp?=
 =?utf-8?B?NnJPQ1dKU1pmRk1NRitQZ0xTL25JN1RGV202cjUrQi9MeTkxV0hPS2VObExo?=
 =?utf-8?B?VnBYam9Nb2VBL2E5K1JnYWlSc1BmYmhIcnBkalJJOXBvS3dPZkR4U09yWHg5?=
 =?utf-8?B?TWZJalJ1c3paNVBmaWoyOVJhUCtweWpKRnJ5OWpnejN6OEVjVVFKQXNYYS94?=
 =?utf-8?B?cmIxaDltUklOKzJtQWhUcEtwK0VqR3NwZ0t3K3ZsL3VhZ0NGaEVOZmd3SFB1?=
 =?utf-8?B?OEEyWndRT1hJV0lxU0J6NDh4M05rb2MrUTVYVHArMEo1MTljbkRRNGlnZ0tE?=
 =?utf-8?B?K0ZLbEduNjdWOXlBV1NUQ0JKbHhXUm5yTGJjN1hMQnY5S25pdllzQnJ6OFlh?=
 =?utf-8?B?MkFHSHFaZGlpM1hoQjM0SjNJaVpFSy8yNjRBWlkyaFBIZmlDdzhDSVlEZUxX?=
 =?utf-8?B?KzEyMTA5bnA1aCtjeEN0VWdlVDR5enJkRTNaMXF0aWx4bUw3TWVGdVIrSW5C?=
 =?utf-8?B?U09Kam5DUUxXWk9nTlBEaUZoN0RQbU5HbHlrWWN1aXhEVGtNWVdZR3ZyWGlK?=
 =?utf-8?B?cEJXMWpCb21wMkdnUUFMMCtHTy80eEE4QUhCRnR0UUc5dHNjU2p5dzZ0ZEcv?=
 =?utf-8?B?YTRQbThnbEltY2pQUzhyM082dG8rMHlKd2lzYm9PZmpKeXVSZDlsWnlIOXJW?=
 =?utf-8?B?Wk9EaVVrM2wvUW9jdm9OdjJKSk40Y2ZvYXFzOEJWT25lN2ljNWdvTTZSK2tK?=
 =?utf-8?B?Mys2RG1HV2pDMkFGSEprRGMzTGNrMW43eDNvRXBZbDlCTEFDcUpkQjNLb3ZL?=
 =?utf-8?B?M3FrUWtvVWlvYXpFVEExTEwvZHhjL2orckt4VGxhVmxrdkM0M0l3Z0NVU2Q4?=
 =?utf-8?B?SGtncjUwMVN3THFnYlcwZ3JQaVhlalJJSkZFRklHSUNYVUNBK0NQckdxcUpI?=
 =?utf-8?B?T0tNQzFJRWtjL3ZlMnhKSllreGc4cU8waFN1WC9PaHcvbDJ4TlZyYmFNTkx0?=
 =?utf-8?B?L2h1WVZ6dmI1ZnBBR0ZvcjFhUE5PaStCRzdHcFhTcXNlQlNsZkpGajM1SXZY?=
 =?utf-8?Q?aODaUGybxHZbRqc9ip1JhVk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51372A40E0358C4C953BC04F7F9C533F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4969.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffd1f13-e8ac-4137-70d0-08da91e2085c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 21:35:21.4633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8hMz5szrJARX9FGWkUdC1fQD7t3EMDPBMl3/y6g5ozzQedvUxiLWNqg2Smc6XDH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4470
X-Proofpoint-ORIG-GUID: cdgoCfLbRVFbU3RjN-p1XWeLLCWtwWl9
X-Proofpoint-GUID: cdgoCfLbRVFbU3RjN-p1XWeLLCWtwWl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU2VwIDgsIDIwMjIsIGF0IDI6MTAgUE0sIERhbiBXaWxsaWFtcyA8ZGFuLmoud2ls
bGlhbXNAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgVGhpcyBNZXNz
YWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+
IEpvbmF0aGFuIFpoYW5nIChJbmZyYSkgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEF1ZyAzMSwg
MjAyMiwgYXQgMToxNSBBTSwgUm9iZXJ0IFJpY2h0ZXIgPHJyaWNodGVyQGFtZC5jb20+IHdyb3Rl
Og0KPj4+IA0KPj4+IFRoZSBVSUQgaXMgbmVlZGVkIHRvIHJlYWQgdGhlIFJDSCdzIENFRFQgZW50
cnkgd2l0aCB0aGUgUkNSQiBiYXNlDQo+Pj4gYWRkcmVzcy4gRGV0ZXJtaW5lIHRoZSBob3N0J3Mg
VUlEIGZyb20gaXRzIEFDUEkgZncgbm9kZS4NCj4+PiANCj4+PiBTaWduZWQtb2ZmLWJ5OiBSb2Jl
cnQgUmljaHRlciA8cnJpY2h0ZXJAYW1kLmNvbT4NCj4+PiAtLS0NCj4+PiBkcml2ZXJzL2N4bC9h
Y3BpLmMgfCAxMiArKysrKysrKysrKysNCj4+PiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKQ0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9hY3BpLmMgYi9kcml2ZXJz
L2N4bC9hY3BpLmMNCj4+PiBpbmRleCBmOWNkZjIzYTkxYTguLmIzMTQ2YjdhZTkyMiAxMDA2NDQN
Cj4+PiAtLS0gYS9kcml2ZXJzL2N4bC9hY3BpLmMNCj4+PiArKysgYi9kcml2ZXJzL2N4bC9hY3Bp
LmMNCj4+PiBAQCAtMzY4LDggKzM2OCwyMCBAQCBzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpjeGxf
ZmluZF9uZXh0X3JjaChzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpob3N0KQ0KPj4+IHN0YXRpYyBp
bnQgX19pbml0IGN4bF9yZXN0cmljdGVkX2hvc3RfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4+PiB7DQo+Pj4gCXN0cnVjdCBwY2lfaG9zdF9icmlkZ2UgKmhvc3QgPSBOVUxM
Ow0KPj4+ICsJc3RydWN0IGFjcGlfZGV2aWNlICphZGV2Ow0KPj4+ICsJdW5zaWduZWQgbG9uZyBs
b25nIHVpZCA9IH4wOw0KPj4+IA0KPj4+IAl3aGlsZSAoKGhvc3QgPSBjeGxfZmluZF9uZXh0X3Jj
aChob3N0KSkgIT0gTlVMTCkgew0KPj4+ICsJCWFkZXYgPSBBQ1BJX0NPTVBBTklPTigmaG9zdC0+
ZGV2KTsNCj4+PiArCQlpZiAoIWFkZXYgfHwgIWFkZXYtPnBucC51bmlxdWVfaWQgfHwNCj4+PiAr
CQkJKGtzdHJ0b3VsbChhZGV2LT5wbnAudW5pcXVlX2lkLCAxMCwgJnVpZCkgPCAwKSkNCj4+IFRo
ZSBVSUQgZmllbGQgaG9sZHMgNCBieXRlcyBvZiBBU0NJSSBjaGFyYWN0ZXJzLiBrc3RydG91bGwo
KSB3b3VsZCBmYWlsDQo+PiBpZiB0aGUgVUlEIGZpZWxkIGhhcyB2YWx1ZSBzdWNoIGFzIOKAmENY
MDPigJkuDQo+IA0KPiBUaGUgVUlEIGZpZWxkIGlzIG5vdCA0IEFTQ0lJIGNoYXJhY3RlcnMuDQo+
IA0KPiBXZSB3ZW50IHRocm91Z2ggdGhpcyBiZWZvcmUgaW4gdGhlIG9yaWdpbmFsIGNvZGUgaW4N
Cj4gZHJpdmVycy9jeGwvYWNwaS5jOjphZGRfaG9zdF9icmlkZ2VfZHBvcnQoKS4NCj4gDQo+IFRo
ZSBDRURULkNIQlMgZGVmaW5lcyBfVUlEIGFzIGFuIGludGVnZXIgc28gdXNlIGFjcGlfZXZhbHVh
dGVfaW50ZWdlcigpDQo+IHRvIHJldHJpZXZlIHRoZSBVSUQgdG8gcGVyZm9ybSB0aGUgY29tcGFy
aXNvbi4gSSB0aG91Z2h0IHRoZXJlIHdhcyBhbg0KPiBlcnJhdGEgZmlsZWQgdG8gY2xhcmlmeSB0
aGlzLCBidXQgaXQgc2VlbXMgdGhlIGN1cnJlbnQgc3BlYyBzdGlsbCBqdXN0DQo+IHNheXMgInZh
bHVlIi4gVGhlIENGTVdTIGFsc28gcGxhY2VzIF9VSUQgdmFsdWVzIGluIHRoZSB0YXJnZXQgbGlz
dCwNCj4gdGhvc2UgYXJlIGFsc28gaGFuZGxlZCBhcyBpbnRlZ2Vycy4NCg0KQUNQSSA2LjQgc3Bl
YyBzZWN0aW9uIDYuMS4xMiBkZXNjcmliZXMgX1VJRCwgaXQgc2F5cyB0aGUgcmV0dXJuIHZhbHVl
IGlzOg0KQW4gSW50ZWdlciBvciBTdHJpbmcgY29udGFpbmluZyB0aGUgVW5pcXVlIElELg0KDQpJ
biB0aGUgQklPUyBJIHNlZSwgdGhlIF9VSURzIG9mIFBDSWUgZGV2aWNlcyBob2xkIEFTQ0lJIGNo
YXJhY3RlcnMgKG5vdCBOVUxMDQp0ZXJtaW5hdGVkKS4gDQoNCg0K
