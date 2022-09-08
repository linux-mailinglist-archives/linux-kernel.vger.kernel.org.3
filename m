Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EE35B2987
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiIHWl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiIHWly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:41:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B62F3BC5;
        Thu,  8 Sep 2022 15:41:52 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 288Lqs03011539;
        Thu, 8 Sep 2022 15:41:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=IMugtwgKRoAz9tYzezuIz0ZGvROrbEeSAGZ5mC90yME=;
 b=NmfIyaR9iMrBFSXarLlnqIAoBwkqbZSfQbGpnVP7wiyX66eAsiONICeP2MsB+PGg5QGi
 u7Vb0JQgbNqqIHCxdraRv6sgmnem8Ehf83GhPI+VokFOqYHcpKK5JlT1P6YBOkehm96b
 +ost2rc/wIELJJcVWxtxmFhVbfLL8DEicNs= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by m0001303.ppops.net (PPS) with ESMTPS id 3jevdakjy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 15:41:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyZxbYFL81ot+QaLoXwhzIGFy1vw+BTJ5I6C60TcuLwSM3BAXV0OMimav48lBBe4rJgDAr3/n8ZehaVIEPGDsRFFCX44p6v/XkaoR4/zyyRUTtZN7KhGNYPOhbLTcSrsXjm7SmU2f9u4S3NmOw1j5jEWOXhRJhrenClPNoTkmiSBHqa4OA7WUv87STsGuOFEbcPx4i6G20lvNfKoXG4RrXLqLMtlW1jkeOCqglRI040oLUWfEsGswMIk8rLCWGqzqWsrudJt/PjJ71q7fQGTYgpm4/nhNye9A1GM1Pw1MB7Jk1sQyyx8VotAlONtZBYXHVc+Qe5arCpD2EIpbkVsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMugtwgKRoAz9tYzezuIz0ZGvROrbEeSAGZ5mC90yME=;
 b=VKfHra55jiLRh0ojjVpSYq51oW6oIcIbdP2JrQeQFHOw3vcLEBP1shnZc5fSEjlua+mKayGwsQraPj3H/sJ1IkHbJT0gf1ZZEMI/ZhWqMxAyxKL5RiRljHZJ401Hf8beHudImz/r/0DaBRTSJHBFuKlpkfSm1xZJyZpTzizyucQRFNRPCHj+ZgwEwoYdvk14e+WbojgrLj0T4lRES1hcj8LyLRkZ0ccrsAHGQJyLTFMFgCIINqhs/4xhbSiARe2Pl3iT+IFfr7vhykTmbqfY4kxcuQTDgHhn63ip7brttaphSZI4QHUYiSBzLwmYdqhNUf8gZQZTo/bZVVVb5EjwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB4969.namprd15.prod.outlook.com (2603:10b6:303:e4::23)
 by CY5PR15MB5392.namprd15.prod.outlook.com (2603:10b6:930:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 22:41:48 +0000
Received: from CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f5e:6caf:40a6:ce10]) by CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f5e:6caf:40a6:ce10%7]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 22:41:48 +0000
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
Thread-Index: AQHYvRIwy8rOqcA1b0qGSKl7IMSeNq3WDjSAgAAGXQCAAAcUAIAAD6eAgAAC6wA=
Date:   Thu, 8 Sep 2022 22:41:48 +0000
Message-ID: <A142D5A2-9EA0-4B1D-85A0-51C47656A0BA@fb.com>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-10-rrichter@amd.com>
 <DE840F3C-0CBA-49A5-B9B9-9D279FFAAFFA@fb.com>
 <631a5a27f22ac_166f29479@dwillia2-xfh.jf.intel.com.notmuch>
 <485824AC-DCEA-4DE2-A331-CAC5DE901600@fb.com>
 <631a6d394b4ef_166f2947c@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <631a6d394b4ef_166f2947c@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR15MB4969:EE_|CY5PR15MB5392:EE_
x-ms-office365-filtering-correlation-id: f3238d6e-f1b2-48a9-9c76-08da91eb50e7
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eFAuZEeWVBnDdVinmtLnP024W2ofcPRDPd66ioyZlkGdRBOjYXYL3RyAR+cIqC08FmHASL1MWFwovXDy7wB+vRyrjQWBtKObn42gsEX1VncVDvV7XUbmkn3DIhetUQe5wG7otEm78k5hmJ4h1A/sHvGCejjIkxRFWuLawJJ7A6t3cXNMTjvZQS0qb8YUvsOw/c6olirLVgxChldCrpaoqBqwaTZEr7ZcjFlRIeIROZRfKbRlsbjjaEJSSmVXVxCwYiJI3bb6SVXKxqINmxE4nc+3mTlgze53BvIQdY9Exy9uupkP88AB5aWo9pR/EW+6xpQpO3Zjoa6GU2dpJmD5/LZBZZcXuNasHi3KgVnVDVskHCPsCkdWSaF1csZFEwlEiiNYXvLI/T8+pyMeJ1PUG1ZpbxXhMM2HJjo+msLPEIZLPwYna1sjSfVATaJJsznKfg6LIsqebT53lm2KK2o2yiyWTmyvpL2I+cTN1MXW6KgOnOjWl4aRoQo5XqmJRSFeTN++uUazB0KC9Kp1ozuf+JuoMOn1rqgXiDdmH58z/iF6+hIFCTd+keujMoWKqYCSZRK5Fj3T5EnnsugpduVkO9/lz+rrG4DoXQVJ2auTPfAyzzvxDaXKCPz0zq555HoiGOJH8Lb7MKVKGKevn3JX7ZJV/goD7og2D1hr9pbdPGRbN/2KquQHhroVHAwm0ftSkbCca8N9WDcmm/vKxDZUgis2vTCl08sXNMfeOisjUvd19RFZDmEeGM+/AZjOVBbE5nDDs/ZkLBf+n5WwjKJfcKNEVRmlywrgUkhHuvOe7a4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4969.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(91956017)(66946007)(83380400001)(38100700002)(316002)(122000001)(76116006)(66476007)(66556008)(8676002)(6916009)(2906002)(38070700005)(66446008)(64756008)(54906003)(4326008)(7416002)(2616005)(8936002)(86362001)(6506007)(53546011)(186003)(5660300002)(6486002)(6512007)(41300700001)(478600001)(71200400001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjRyL09wa2xMdE1PL2pWcXRIaEhyd2pFWitCTkwxVmVZcjhrRHdlc1VSdmEz?=
 =?utf-8?B?RnVjZkhHWm50T3ZldGRneFlEMXVBN2lmRWxFMzVJalhHN0k5SzZWYjh3d1Uv?=
 =?utf-8?B?ZWNkQXJNd2FLT0h5T0tPZUU0eTA4MGtqNmZiaVl6UE1oanlURnBrTGFXZmRM?=
 =?utf-8?B?TjFxMURKMlNqbFBNRDhlZGtUZSt6bjRncDNGVzRQS2pLQzdJNko2dE5NV3Qr?=
 =?utf-8?B?eVZITUk3djQwbnRSTGRUZWdxbGg5b0FOVEE4NVZGWEkzQVFkeTRrUHpPMFZV?=
 =?utf-8?B?TjYzZWRrYTBiNVVEK0tIblJSMm1DWEh4YnZSSXdYSXBHajJxSi9YcW45S1Bk?=
 =?utf-8?B?YThHNTQxek5DVGhkVkNJSXlJRlZ5WDBpSkpkOG9xcnlKdHFMY3NJYVpTOUtZ?=
 =?utf-8?B?S0hhUHpJWWExQ0VLcXMveFNiQ1VBRERhMzcyMlZOdHhkVDJrUFkvejR2U0R2?=
 =?utf-8?B?WEMrMnpBeUtjM0RoTGs0TUhJZjZSVmROSmg1aklVTkZWdE1kSDVGb0VMcnI2?=
 =?utf-8?B?VW8wOWt1bVA1YVFsWTJwWkJsS1hzZFZuUzVSQUlpUXl0MnRvN1dnazY3WG93?=
 =?utf-8?B?K1I3Y0o5UExoOFVTUCtjWUxwU0swTHhpRlhlaXlQbUZ5Q1NHUVJQeXcxZ1NL?=
 =?utf-8?B?Y0F1Q1F2SHQxNEphUzBIY3FCQS9WaDBmMlFUY1laY0VRNytJTEVMZmg2UldP?=
 =?utf-8?B?TWFpcy9sZmozM0NiaWdzeUg1UlF4YmpTSURzT3VXMnovUHF1cHUxYURYMkRS?=
 =?utf-8?B?WlB4Ylc4RTYyT3p1Zm83V1VFd01CMG5OZlE0akV0Rmo0dmlUcHgzOUZvZnYr?=
 =?utf-8?B?YlJDS2R0NGNLQ2VBMktCaDBlMkw4TjRIc0tkVnVpVHVBRFoza0ExZFVDMHhK?=
 =?utf-8?B?cFJGdmRBZFpPQzZUR25vUXU2TThuOVh4L2NZWGlxREp0TkFDWTVhVHN4MWY3?=
 =?utf-8?B?VUtkd0xsazJQL3o0UXFDbWM1b2x4TWpmN3hwK1BubFhXRkxlNmVmNEZidHlG?=
 =?utf-8?B?VStaSjlZM0tFejRKN0hOVTZFYkxOeUlSMk9BWCtnZXIyWUc2WXZjRXl3b3dl?=
 =?utf-8?B?eDdESUo5S0ZkdURMSTVYenVHSEdSSDNSWCtsSnpjK040aTUzbGNsemF4UEdj?=
 =?utf-8?B?aWlUaHM0Qi96VFlialRIZEJsTnhrVTdRenIvMFV3V1BTY3ZiZUZnNkREVWFZ?=
 =?utf-8?B?M0Ird0dpWFZGMlVCZk5JSXQxZkpFVGwvS2lLc0tjU2xoeGJ0aDBRVVZGNDQv?=
 =?utf-8?B?MUJRcFdpeEgzQTRSMjNrRk9NZUZUUnRvKzkwL0d5bXlMdFU0b3E5YTU0UUgz?=
 =?utf-8?B?ZGdPOHVGSEpTS0Y1cXFDZkZuVXNYSGU4NUFJTGkvNWRUSnJIZlFheDdJL3N3?=
 =?utf-8?B?aGUxMDZjRlpEM1ZnOWFGQVJpT3Fudlo4L3ZCYzVWRThxWmNYcVVKMXkrT3lq?=
 =?utf-8?B?bzJFcFF0WXlnMkoyVXIrQlV6YlZYd21remZZL2xRRG1LeWlXRmwwajNlNE5m?=
 =?utf-8?B?SzArRXZTTFFGTmVJaGUvZXJzcHF4SHFVM2lUZnB2aXBlLzZraGtsejdudTFy?=
 =?utf-8?B?bjB1UkxLblRmYWpzTUN5ZWYxTnZLdExBTjNFTElFc1VPV2dvc1ZGbkMyc0Nl?=
 =?utf-8?B?RkZ0VVB0WWZ4UWwyZXJML2RUdXp5YWp2SnVWMUt0b0hkNmUxYmIvS2J5UklC?=
 =?utf-8?B?WStYSitTaVJKYWRWcUJSM3V0alFKdFRtTXBiNTVLNDBzVmQxZU0wbGVLVGZj?=
 =?utf-8?B?RjZVeDFTeElEbUFNUDRGeUJOdUFvTmRTNnR5Qnc4NWxPOVowK0NaUFV5S0ZJ?=
 =?utf-8?B?NzA3SnY1ZkRHcThRazNMVDdjejRDS2pJaUN4Vm5yeERTUkR0eFg4T1l3V0JV?=
 =?utf-8?B?eEVENzlzbit6RjdaTVkrMit2OThKMmpTTnJCR1oxUGIrdjZaelNxS0ROQXdD?=
 =?utf-8?B?TVVWQUVQaGMvb2x2amVGZDB0VWQ1QTY0YzlyWFdxUmlzTG9MVnRlZitPdWho?=
 =?utf-8?B?TnRtNTBwRHc4K0l4VUljSXhXazY4N0dDYWRGNFJQVDZXQjQyNjAyNkFxd1FM?=
 =?utf-8?B?TWl3YmNCc2NuaEp2MDJEVWY3cmRLL0U4TXBGTEkzVEcvaHpQQytiOGFZV3pH?=
 =?utf-8?B?cXR0RllqWUFJN1R1MjB5YWRTWmYzelhzTFdpY283T1hMUkZZc3hsdmVpWVYr?=
 =?utf-8?Q?3bxr8yh0c/k/0xb+LMfIQlA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <820F5F02B21E844CA83F1B3EFD65F1BC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4969.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3238d6e-f1b2-48a9-9c76-08da91eb50e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 22:41:48.6419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PF1EXAdy0R8219Xuq1kFGDWtbTpNmM3HQijTLsnQHp2iibAoi7j41T4yAhWYsz7a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR15MB5392
X-Proofpoint-GUID: 1vlNCElJEhu0ytBjiWOwzZCDslo6COdo
X-Proofpoint-ORIG-GUID: 1vlNCElJEhu0ytBjiWOwzZCDslo6COdo
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

DQoNCj4gT24gU2VwIDgsIDIwMjIsIGF0IDM6MzEgUE0sIERhbiBXaWxsaWFtcyA8ZGFuLmoud2ls
bGlhbXNAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgVGhpcyBNZXNz
YWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+
IEpvbmF0aGFuIFpoYW5nIChJbmZyYSkgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIFNlcCA4LCAy
MDIyLCBhdCAyOjEwIFBNLCBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4g
d3JvdGU6DQo+Pj4gDQo+Pj4gIS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+Pj4gVGhpcyBNZXNzYWdlIElzIEZyb20g
YW4gRXh0ZXJuYWwgU2VuZGVyDQo+Pj4gDQo+Pj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+Pj4gDQo+Pj4gSm9u
YXRoYW4gWmhhbmcgKEluZnJhKSB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4gT24gQXVnIDMx
LCAyMDIyLCBhdCAxOjE1IEFNLCBSb2JlcnQgUmljaHRlciA8cnJpY2h0ZXJAYW1kLmNvbT4gd3Jv
dGU6DQo+Pj4+PiANCj4+Pj4+IFRoZSBVSUQgaXMgbmVlZGVkIHRvIHJlYWQgdGhlIFJDSCdzIENF
RFQgZW50cnkgd2l0aCB0aGUgUkNSQiBiYXNlDQo+Pj4+PiBhZGRyZXNzLiBEZXRlcm1pbmUgdGhl
IGhvc3QncyBVSUQgZnJvbSBpdHMgQUNQSSBmdyBub2RlLg0KPj4+Pj4gDQo+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBSb2JlcnQgUmljaHRlciA8cnJpY2h0ZXJAYW1kLmNvbT4NCj4+Pj4+IC0tLQ0KPj4+
Pj4gZHJpdmVycy9jeGwvYWNwaS5jIHwgMTIgKysrKysrKysrKysrDQo+Pj4+PiAxIGZpbGUgY2hh
bmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4gDQo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jeGwvYWNwaS5jIGIvZHJpdmVycy9jeGwvYWNwaS5jDQo+Pj4+PiBpbmRleCBmOWNkZjIzYTkx
YTguLmIzMTQ2YjdhZTkyMiAxMDA2NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMvY3hsL2FjcGkuYw0K
Pj4+Pj4gKysrIGIvZHJpdmVycy9jeGwvYWNwaS5jDQo+Pj4+PiBAQCAtMzY4LDggKzM2OCwyMCBA
QCBzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpjeGxfZmluZF9uZXh0X3JjaChzdHJ1Y3QgcGNpX2hv
c3RfYnJpZGdlICpob3N0KQ0KPj4+Pj4gc3RhdGljIGludCBfX2luaXQgY3hsX3Jlc3RyaWN0ZWRf
aG9zdF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+Pj4gew0KPj4+Pj4g
CXN0cnVjdCBwY2lfaG9zdF9icmlkZ2UgKmhvc3QgPSBOVUxMOw0KPj4+Pj4gKwlzdHJ1Y3QgYWNw
aV9kZXZpY2UgKmFkZXY7DQo+Pj4+PiArCXVuc2lnbmVkIGxvbmcgbG9uZyB1aWQgPSB+MDsNCj4+
Pj4+IA0KPj4+Pj4gCXdoaWxlICgoaG9zdCA9IGN4bF9maW5kX25leHRfcmNoKGhvc3QpKSAhPSBO
VUxMKSB7DQo+Pj4+PiArCQlhZGV2ID0gQUNQSV9DT01QQU5JT04oJmhvc3QtPmRldik7DQo+Pj4+
PiArCQlpZiAoIWFkZXYgfHwgIWFkZXYtPnBucC51bmlxdWVfaWQgfHwNCj4+Pj4+ICsJCQkoa3N0
cnRvdWxsKGFkZXYtPnBucC51bmlxdWVfaWQsIDEwLCAmdWlkKSA8IDApKQ0KPj4+PiBUaGUgVUlE
IGZpZWxkIGhvbGRzIDQgYnl0ZXMgb2YgQVNDSUkgY2hhcmFjdGVycy4ga3N0cnRvdWxsKCkgd291
bGQgZmFpbA0KPj4+PiBpZiB0aGUgVUlEIGZpZWxkIGhhcyB2YWx1ZSBzdWNoIGFzIOKAmENYMDPi
gJkuDQo+Pj4gDQo+Pj4gVGhlIFVJRCBmaWVsZCBpcyBub3QgNCBBU0NJSSBjaGFyYWN0ZXJzLg0K
Pj4+IA0KPj4+IFdlIHdlbnQgdGhyb3VnaCB0aGlzIGJlZm9yZSBpbiB0aGUgb3JpZ2luYWwgY29k
ZSBpbg0KPj4+IGRyaXZlcnMvY3hsL2FjcGkuYzo6YWRkX2hvc3RfYnJpZGdlX2Rwb3J0KCkuDQo+
Pj4gDQo+Pj4gVGhlIENFRFQuQ0hCUyBkZWZpbmVzIF9VSUQgYXMgYW4gaW50ZWdlciBzbyB1c2Ug
YWNwaV9ldmFsdWF0ZV9pbnRlZ2VyKCkNCj4+PiB0byByZXRyaWV2ZSB0aGUgVUlEIHRvIHBlcmZv
cm0gdGhlIGNvbXBhcmlzb24uIEkgdGhvdWdodCB0aGVyZSB3YXMgYW4NCj4+PiBlcnJhdGEgZmls
ZWQgdG8gY2xhcmlmeSB0aGlzLCBidXQgaXQgc2VlbXMgdGhlIGN1cnJlbnQgc3BlYyBzdGlsbCBq
dXN0DQo+Pj4gc2F5cyAidmFsdWUiLiBUaGUgQ0ZNV1MgYWxzbyBwbGFjZXMgX1VJRCB2YWx1ZXMg
aW4gdGhlIHRhcmdldCBsaXN0LA0KPj4+IHRob3NlIGFyZSBhbHNvIGhhbmRsZWQgYXMgaW50ZWdl
cnMuDQo+PiANCj4+IEFDUEkgNi40IHNwZWMgc2VjdGlvbiA2LjEuMTIgZGVzY3JpYmVzIF9VSUQs
IGl0IHNheXMgdGhlIHJldHVybiB2YWx1ZSBpczoNCj4+IEFuIEludGVnZXIgb3IgU3RyaW5nIGNv
bnRhaW5pbmcgdGhlIFVuaXF1ZSBJRC4NCj4+IA0KPj4gSW4gdGhlIEJJT1MgSSBzZWUsIHRoZSBf
VUlEcyBvZiBQQ0llIGRldmljZXMgaG9sZCBBU0NJSSBjaGFyYWN0ZXJzIChub3QgTlVMTA0KPj4g
dGVybWluYXRlZCkuIA0KPiANCj4gQVNDSUkgY2hhcmFjdGVycyB3aXRob3V0IE5VTEwgdGVybWlu
YXRpb24gbWVhbnMgdGhhdCBkYXRhIGNhbiBiZQ0KPiB0cmVhdGVkIGFzIGJpbmFyeSBkYXRhIHdo
aWNoIGlzIHdoYXQgY3VycmVudCBDRk1XV1MgcGFyc2luZyBjb2RlIGNob29zZXMNCj4gdG8gZG8u
IEkgdGhpbmsgYSBzcGVjIGNsYXJpZmljYXRpb24gaXMgbmVlZGVkIHRvIG1ha2UgcmVzb2x2ZSB0
aGUNCj4gYW1iaWd1aXR5Lg0KDQpBZ3JlZWQuIEluIHRoaXMgY2FzZSwgQUNQSSBzcGVjIHNob3Vs
ZCBiZSByZWZlcnJlZCB0by4gDQoNCg==
