Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0095B2647
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiIHSxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiIHSxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:53:08 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606FA103045;
        Thu,  8 Sep 2022 11:52:57 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288IJ9Mq020173;
        Thu, 8 Sep 2022 11:52:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pEQOF8zvmnPTzkp6NonXoLshpMmZVpfeykp4ZYe6gys=;
 b=EHVXqFva/b1Nf33XOSi2cZTtNDkv+x0LHQ1egmrpVs84wFDdnaqBYAVSAheOM+DoD6to
 m/+wcvQvE7r1z3qsDcjD+SemRkfXgHLSXEoxzYL70exhFbROBx0Z1SGkzFfNIjWCv7AK
 JV+aK/ZuS2HIiItFi+MJ8S51BLOP8rX6k/g= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jfbqx4cqd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 11:52:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WT/k9TUZPoEvdYk/Rn91W5gK0a6GLPq0/8VIqtqnNYiEjVkmWeTENg1OL5AQZjPa/IX5hIn9DID35X/EQDSRhw0BOm/TVVsVWBuZwEDSjK/313LEX973eGlTg4zt+KFcZf5p8HRxaCafd0Ao2KLcHpDtK619Rm4uXXaDXg0U6A6j3tHoe6GlLxHSMic56jAeHddQbnA+jx5W8AYcskKD1ZVnho8l4XN+babVJIc7FOs0wSxXtetlK0j5SMa3fJqEoPX4Pumgy0s4UPh5lh4OKQ76vUOu5PLTYJN/n3JUIVjOs5ygDcpXIma47BaN+hvRTUZhaP7L3d7isIXyid1dww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEQOF8zvmnPTzkp6NonXoLshpMmZVpfeykp4ZYe6gys=;
 b=Grn1SpixB/9i4gMd4MNOJaW5IfJiF2vWxrIjiiTZwyEkQHT+EyBhirSgBuv8qtEtjkZZBpL0IH8dbMHG6p+FEr1KWqUuVhNuAVArkB/9npffRZcqibTrouADHt+pG8Yu+XCNXnqxLWXMUXduIKxJ5Lhy0FNYN27rWwpQ21LmTKQXY3rB3wVx+3nCXo2B8zeRttQd/NxWEmdsBRKaBfc7gFNJDhzz4Zv1FjFej0CnlFaMZT/hD/5ZwyPtBA/LH71vaHxndF3GIOLjUcgxomI9rwFVQj9pedPI+UOj0NlkFSdex8CRT5HwDfe5WuBX5PNyjcSoAI/Rwg7wM5x9lfeRgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB4969.namprd15.prod.outlook.com (2603:10b6:303:e4::23)
 by BN8PR15MB2961.namprd15.prod.outlook.com (2603:10b6:408:84::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 18:52:46 +0000
Received: from CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f5e:6caf:40a6:ce10]) by CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f5e:6caf:40a6:ce10%7]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 18:52:46 +0000
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
Subject: Re: [PATCH 00/15] cxl: Add support for Restricted CXL hosts (RCD
 mode)
Thread-Topic: [PATCH 00/15] cxl: Add support for Restricted CXL hosts (RCD
 mode)
Thread-Index: AQHYvRILPgGvtGLjek2fcCbQeRsbya3VEbGAgADciQA=
Date:   Thu, 8 Sep 2022 18:52:46 +0000
Message-ID: <17F02AD3-D68A-4E6A-A549-A47611B335E7@fb.com>
References: <20220831081603.3415-1-rrichter@amd.com>
 <631980ff90319_58016294cc@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <631980ff90319_58016294cc@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR15MB4969:EE_|BN8PR15MB2961:EE_
x-ms-office365-filtering-correlation-id: da4af6c3-713a-4b28-c540-08da91cb520a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0tSYhaTfyXks4c01Tj2eTVEyCuJ9f7lpIGB4pZcCQrPXVz49R1TFp8L60Mue4qgH4YM/ITiMoDbnZ53/STCAH0GB1/UV2L8aWw2XDbqxATVSkW/Ccf3+Stml3oSN48Gn1wIYN7PN2TeMLrecr53iiJwMHwhexJdZ0OQcV/8qBLYqPgu3kEeVJ/V0Eh2u4MQgY9GPIMVPFYZPthHRsRmGUO+XFvmN/Jyr/0bphQK6DFkkNljgCac98P3PZfh4hIOissPtGgBuflXID47GTAudAtAuAI8j2PQ2XjOKjBKrOSlgXerKmeovI3PDRN96r+smGlSHfp73tOkJF5mlG6kEJRr7DmuOp4SoU0V60hxBANgdW7cpAYGoZOGqr6ZPDVjdpwXVLlSHHGyn/haBiV87tiXl5mIcM8hGlpoIls0sprqVNnZcVtA1jJpsabwU6DRwC5yfyekcGz/LKDS2uBw6OXr2B2mW/mjXR9XkFpzjbpq5ZursBmaF8OLrcxXHHAWm8O2tnZDt36fjWtoeh7fVaLopJX9gc/b/9tGkEGCFT7I3PBd5Ai5D2QjW7jW8FPe2sYoNDG63aOYjaPfItgId1GIJQWDUcCV3HV9i+5f2RHQkD1sZOO+p8Z+TiGKZapU2dHMe9Snx2FBbaJQRuCXYcQSoeje4fcnfPFU4ICsUG47ogKUS/ER/jeUmrK18k2c2NDyz7sYRvekq/Gq4piToD7ehtmmaafqcArspezoopdJUMYK2Ui6QNgM41hxEgwOR2MamxUfLVLQpaW4XghxeJHScnumq/PyVPv6NcIdo3z7Qfwg4e/mtStBPFFDqh4BuhFIwvLIAO2+P2uZEh1C/Xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4969.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(966005)(53546011)(5660300002)(4326008)(91956017)(7416002)(8676002)(64756008)(2906002)(66476007)(66556008)(8936002)(66446008)(2616005)(66946007)(76116006)(6512007)(33656002)(36756003)(6506007)(86362001)(41300700001)(186003)(478600001)(6486002)(83380400001)(38100700002)(38070700005)(54906003)(316002)(6916009)(122000001)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWF4RElvM0s3b0plejY2Uy9yODVvN3lJeDlGKzJhQmJJS2IyRlNvdlZRZE8r?=
 =?utf-8?B?ZFlMbHlBd09pbkVpMlV1OVJXdU5ydHFQV1N5V3JZSzM5TkJpY2dmRzFTQnVZ?=
 =?utf-8?B?cmVlNVNBVUl1N2pOVWhYUU5YdzhRRTREN2FORDhTN0FvbXNNNlJWaUw2enNu?=
 =?utf-8?B?YmJVbmUydUZaNENmOUt4MnhWeWFDdHlXQXpJajBIZlArc0trVTFwWHJyUjlT?=
 =?utf-8?B?aFJlNktBNFFtRGpDVG8xQlJxb0Y2bHVPWWkxSFpJbE14NHp2WFN1cDFqUWE2?=
 =?utf-8?B?QTg2ZkNzd1RJeXRsdzF2SXVQSEZNckdseVBlZ1JxbVZMQkRIQXpKazN2dlpq?=
 =?utf-8?B?S0dINmVmYm53VzBOWFNUQmdwRjJSMGkyS0pNZWdUeVAxLzA1QVo5UmhaZGNS?=
 =?utf-8?B?cmZFSmlKOW95cnRrWElPM2xtaDgwQmRocWV1eWNkTXo1ZVpxSEd6MzV3blZo?=
 =?utf-8?B?ZjNVTVRhSDkwL09sNDQyVEp1RjFmTCsrQVBaUzVPd0VuZGpTWmozb29SWGN4?=
 =?utf-8?B?b1pqN25ub2NWc2hZTTFDV3JwL1Z1UlZFNitZUjJXM1V1UENsWVU3YmVmMGpV?=
 =?utf-8?B?c0tiNGJxMysxL0NheE5iaDFiTVhDS3JVVEFkMmw5ekp5amxFUzh6d3ZsNGd1?=
 =?utf-8?B?RjMzN1JvMks4bE0vWUpEWlVIL2xoeUJ1VEgxV0RSd1JPekZ5OG5IVzZES3R1?=
 =?utf-8?B?a2trRUFRMVRJck8vcUdDVXpRMlFMalM1NEU2L3l6dDJUWjV2dnFtOU9FVlJC?=
 =?utf-8?B?bkJUelUzbzZxTDVRNDluRVVSbVJDUDdEK1Zlc1Y1a2VvNDU2LzVOS214Vjlu?=
 =?utf-8?B?SmIrVDBPNTY4VVlmMkVlM0Z3SUNWYkVLaVRlYytmY0JxbXJ4aFRHR0l4eklK?=
 =?utf-8?B?eEtpNkd2aVNFaGpXRExoa2xkTWhiK1k5TGdXb3ZWT3hvMzk2K0haSWd4R1pV?=
 =?utf-8?B?cVl0Z3QyWmljUlFIRkI4TnR1WXRTR3JmbDVmMmRrN01PUS8yTFpYa0pUQ2w0?=
 =?utf-8?B?ZDhRcVVNemZpOUNuZWIxSGhFZGRrOWNUdlFGa0NSd3oraXdYNXozVHFiQ1V6?=
 =?utf-8?B?WGhVRTF4YWN0VTAxQ0NjbDZmVE5CaW9JdDQ5TzQyWDBFZ0ZxdmUrMlhkSUlx?=
 =?utf-8?B?ZVEyQjdzbTMrdVB0SENWa3l0ZklsbnA0c2dLVjRBSjFNb1Nmc1BjNEVMTEZs?=
 =?utf-8?B?Y09hblNDbHpubVM1elVDYldOb2dGbThDbjNWU2VrYmxKMGhkYnBHNkVnNEpn?=
 =?utf-8?B?czRqWHR0dUFjRVRDTExQeUZSNXJobzMxR0kxdEIrRXB0SXJQMnR2cFpZU3pU?=
 =?utf-8?B?aG9uZmI3WE91a1RDM2c1dE4vVVdrVElkQ2FZU3ZJakQ3Ui9OeENHS3E5Q1pP?=
 =?utf-8?B?RDYrN2VzcGtIWjR3ZDRPNnVCZlBnbVM2cktWRFJ5OFBYcWtFM0JoQWxlemNo?=
 =?utf-8?B?MzdWUm9JNCtCSFVLUUd4TkNGZEJHZ2QzL2xtYnRQM0FGdURRRTlkV3hMU0p3?=
 =?utf-8?B?R1FzQjhkcWx5ZWhoYTk0cHgvZHpScS91d084VU0xNS9JcFF2bHJtNUFMZVRu?=
 =?utf-8?B?RVUyWjNEenpiamVmVGp4RFBWUGhwMC9hSk1zcmNubjM0eURaeTJKclYzQmxB?=
 =?utf-8?B?NXdvekU2L3RiWGxGMkxJb1FmT0djVExhb2hjblFUYXFGVk04akZUZ3B6aENx?=
 =?utf-8?B?V1dNZHlrb0RsM2cwc2NnTE1yd3ZsKzhmM2FhL2dtVFlmUm8zZFFaQUlzU2po?=
 =?utf-8?B?a1JBRzRCVVY3T2hHOFRpbGdsc2hYaWxoY2ZGRFI3MGpCOFJUdnY0ODd0WEZB?=
 =?utf-8?B?K3oyN2ZlaUtIc2dxTTl0UmFnVU1DMWsza01xcFdSRCtrUi9tK2l1VmJicTZP?=
 =?utf-8?B?QVhyT1M5UytLVzdIS0lGMUN1U2srem1PanNVOFhQbVRYVTFiaHBTdThKYmhm?=
 =?utf-8?B?TVc3S3ZRYlVNUXpEdEEzalpkTjVXU0FSRlJXdnBaQ21xNnhFNXpFU2JrZEhw?=
 =?utf-8?B?Mm1ibTh1ZFNvUkpPMGExbjl4RzQ0a1FxTXJoUE9wYnZVNCtLMytqZnhESmRD?=
 =?utf-8?B?bkdNRHMybXJiRnhOSjRlOVZ2T1RFTzJBT3Q5NFVWaXI2L2hHdnAvTSt0RU5w?=
 =?utf-8?B?YnBOWDJNN1o0M0RTdkFOVmU5elRCM21tRUNyMnp0NnlYR2RzMEtnYitBeFpH?=
 =?utf-8?Q?OjnlnXkp+vFeiD1KL2Sbq1A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7427760197E1845B5C492609DB26D20@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4969.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4af6c3-713a-4b28-c540-08da91cb520a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 18:52:46.7016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vq+neGdwH9aW90lJEbvkba1MPyRchP7ZgiMWW+rodzgbeN6j6SkPVfSY3/4FQbAb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2961
X-Proofpoint-GUID: 64FsdUpb5XT11IUlyrr_SZusVEPyVN2y
X-Proofpoint-ORIG-GUID: 64FsdUpb5XT11IUlyrr_SZusVEPyVN2y
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_11,2022-09-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU2VwIDcsIDIwMjIsIGF0IDEwOjQzIFBNLCBEYW4gV2lsbGlhbXMgPGRhbi5qLndp
bGxpYW1zQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBBcG9sb2dpZXMgZm9yIHRoZSBkZWxheSBp
biBnZXR0aW5nIHRvIHRoaXMgSSBoYWQgaG9wZWQgdG8gYmUgYWJsZSB0bw0KPiBmaW5pc2ggdXAg
c29tZSBvdGhlciBEQVggd29yayB0byBmb2N1cyBvbiB0aGlzLCBidXQgdGltZSBpcyBnZXR0aW5n
DQo+IHNob3J0IHNvIEkgd2lsbCBuZWVkIHRvIGRvIGJvdGggaW4gcGFyYWxsZWwuDQo+IA0KPiBS
b2JlcnQgUmljaHRlciB3cm90ZToNCj4+IEluIFJlc3RyaWN0ZWQgQ1hMIERldmljZSAoUkNEKSBt
b2RlIChmb3JtZXJseSByZWZlcnJlZCB0byBhcyBDWEwgMS4xKQ0KPj4gdGhlIFBDSWUgZW51bWVy
YXRpb24gaGllcmFyY2h5IGlzIGRpZmZlcmVudCBmcm9tIENYTCBWSCBFbnVtZXJhdGlvbg0KPj4g
KGZvcm1lcmx5IHJlZmVycmVkIHRvIGFzIDIuMCwgZm9yIGJvdGggbW9kZXMgc2VlIENYTCBzcGVj
IDMuMDogOS4xMQ0KPj4gYW5kIDkuMTIsIFsxXSkuIFRoaXMgc2VyaWVzIGFkZHMgc3VwcG9ydCBm
b3IgUkNEIG1vZGUuIEl0IGltcGxlbWVudHMNCj4+IHRoZSBkZXRlY3Rpb24gb2YgUmVzdHJpY3Rl
ZCBDWEwgSG9zdHMgKFJDSHMpIGFuZCBpdHMgY29ycmVzcG9uZGluZw0KPj4gUmVzdHJpY3RlZCBD
WEwgRGV2aWNlcyAoUkNEcykuIEl0IGRvZXMgdGhlIG5lY2Vzc2FyeSBlbnVtZXJhdGlvbiBvZg0K
Pj4gcG9ydHMgYW5kIGNvbm5lY3RzIHRoZSBlbmRwb2ludHMuIFdpdGggYWxsIHRoZSBwbHVtYmlu
ZyBhbiBSQ0gvUkNEDQo+PiBwYWlyIGlzIHJlZ2lzdGVyZWQgYXQgdGhlIExpbnV4IENYTCBidXMg
YW5kIGJlY29tZXMgdmlzaWJsZSBpbiBzeXNmcw0KPj4gaW4gdGhlIHNhbWUgd2F5IGFzIENYTCBW
SCBob3N0cyBhbmQgZGV2aWNlcyBkbyBhbHJlYWR5LiBSQ0RzIGFyZQ0KPj4gYnJvdWdodCB1cCBh
cyBDWEwgZW5kcG9pbnRzIGFuZCBib3VuZCB0byBzdWJzZXF1ZW50IGRyaXZlcnMgc3VjaCBhcw0K
Pj4gY3hsX21lbS4NCj4+IA0KPj4gRm9yIENYTCBWSCB0aGUgaG9zdCBkcml2ZXIgKGN4bF9hY3Bp
KSBzdGFydHMgaG9zdCBicmlkZ2UgZGlzY292ZXJ5DQo+PiBvbmNlIHRoZSBBQ1BJMDAxNyBDWEwg
cm9vdCBkZXZpY2UgaXMgZGV0ZWN0ZWQgYW5kIHRoZW4gc2VhcmNoZXMgZm9yDQo+PiBBQ1BJMDAx
NiBob3N0IGJyaWRnZXMgdG8gZW5hYmxlIENYTC4gSW4gUkNEIG1vZGUgYW4gQUNQSTAwMTcgZGV2
aWNlDQo+PiBtaWdodCBub3QgbmVjZXNzYXJpbHkgZXhpc3QgDQo+IA0KPiBUaGF0J3MgYSBicm9r
ZW4gQklPUyBhcyBmYXIgYXMgSSBjYW4gc2VlLiBObyBBQ1BJMDAxNyA9PSBubyBPUyBDWEwNCj4g
c2VydmljZXMgYW5kIHRoZSBDWEwgYXNwZWN0cyBvZiB0aGUgZGV2aWNlIG5lZWQgdG8gYmUgMTAw
JSBtYW5hZ2VkIGJ5DQo+IHRoZSBCSU9TLiBZb3UgY2FuIHN0aWxsIHJ1biB0aGUgY3hsX3BjaSBk
cml2ZXIgaW4gdGhhdCBjYXNlIGZvciBtYWlsYm94DQo+IG9wZXJhdGlvbiwgYnV0IGVycm9yIGhh
bmRsaW5nIG11c3QgYmUgZmlybXdhcmUtZmlyc3Qgd2l0aG91dCBBQ1BJMDAxNy4NCkZpcm13YXJl
LWZpcnN0IG9yIE9TLWZpcnN0IGFwcGxpZXMgdG8gQ1hMIHByb3RvY29sIGVycm9yIGhhbmRsaW5n
LiBGb3IgQ1hMIA0KbWVtb3J5IGVycm9yIGhhbmRsaW5nLCB0aGUgZGV2aWNlIGdlbmVyYXRlcyBh
IERSQU0gZXJyb3IgcmVjb3JkLCB0aGUgT1MNCnBhcnNlcyBzdWNoIHJlY29yZCBhbmQgYWN0IGFj
Y29yZGluZ2x5LiBBY2NvcmRpbmcgdG8gQ1hMIHNwZWMgKHNlY3Rpb24NCjguMi45LjIuMS4yIERS
QU0gRXZlbnQgUmVjb3JkKSwgRFBBIGJ1dCBub3QgSFBBIGlzIGluIHN1Y2ggcmVjb3JkLiBUaGUg
T1MNCm5lZWRzIHRvIHRyYW5zbGF0ZSBzdWNoIERQQSBpbnRvIEhQQSB0byBhY3Qgb24uIEkgYW0g
dGFraW5nIHRoaXMgYXMgYW4gZXhhbXBsZQ0KdG8gc2hvdyB0aGF0IE9TIENYTCBzZXJ2aWNlcyBp
cyBuZWVkZWQuDQpJbnN0ZWFkIG9mIHVzaW5nIEFDUEkwMDE2IHRvIHRlbGwgd2hldGhlciB0aGUg
c3lzdGVtIGlzIHVuZGVyIFJDSCBtb2RlLA0KSSBzdXBwb3NlIG9uZSB3YXkgaXMgdG8gY2hlY2sg
4oCcQ1hMIHZlcnNpb27igJ0gZmllbGQgb2YgQ0hCUyBzdHJ1Y3R1cmUgaW4gQ0VEVD8NCg0KPiAN
Cj4+IFBDSWUgaG9zdCBicmlkZ2UgUE5QMEEwOCBJRCwgdGhlcmUgYXJlbid0IGFueSBDWEwgcG9y
dCBvciBzd2l0Y2hlcyBpbg0KPj4gdGhlIFBDSWUgaGllcmFyY2h5IHZpc2libGUuIEFzIHN1Y2gg
dGhlIFJDRCBtb2RlIGVudW1lcmF0aW9uIGFuZCBob3N0DQo+PiBkaXNjb3ZlcnkgaXMgdmVyeSBk
aWZmZXJlbnQgZnJvbSBDWEwgVkguIFNlZSBwYXRjaCAjNSBmb3INCj4+IGltcGxlbWVudGF0aW9u
IGRldGFpbHMuDQo+PiANCj4+IFRoaXMgaW1wbGVtZW50YXRpb24gZXhwZWN0cyB0aGUgaG9zdCdz
IGRvd25zdHJlYW0gYW5kIHVwc3RyZWFtIHBvcnQNCj4+IFJDUkJzIGJhc2UgYWRkcmVzcyBiZWlu
ZyByZXBvcnRlZCBieSBmaXJtd2FyZSB1c2luZyB0aGUgb3B0aW9uYWwgQ0VEVA0KPj4gQ0hCUyBl
bnRyeSBvZiB0aGUgaG9zdCBicmlkZ2UgKHNlZSBDWEwgc3BlYyAzLjAsIDkuMTcuMS4yKS4NCj4+
IA0KPj4gUkNEIG1vZGUgZG9lcyBub3Qgc3VwcG9ydCBob3QtcGx1Zywgc28gaG9zdCBkaXNjb3Zl
cnkgaXMgYXQgYm9vdCB0aW1lDQo+PiBvbmx5Lg0KPj4gDQo+PiBQYXRjaGVzICMxIHRvICM0IGFy
ZSBwcmVyZXF1aXNpdGVzIG9mIHRoZSBzZXJpZXMgd2l0aCBmaXhlcyBuZWVkZWQgYW5kDQo+PiBh
IHJld29yayBvZiBkZWJ1ZyBtZXNzYWdlcyBmb3IgcG9ydCBlbnVtZXJhdGlvbi4gVGhvc2UgYXJl
IGdlbmVyYWwNCj4+IHBhdGNoZXMgYW5kIGNvdWxkIGJlIGFwcGxpZWQgZWFybGllciBhbmQgaW5k
ZXBlbmRlbnRseSBmcm9tIHRoZSByZXN0DQo+PiBhc3N1bWluZyB0aGVyZSBhcmUgbm8gb2JqZWN0
aW9ucyB3aXRoIHRoZW0uIFBhdGNoZXMgIzUgdG8gIzE1IGNvbnRhaW4NCj4+IHRoZSBhY3R1YWwg
aW1wbGVtZW50YXRpb24gb2YgUkNEIG1vZGUgc3VwcG9ydC4NCj4+IA0KPj4gWzFdIGh0dHBzOi8v
d3d3LmNvbXB1dGVleHByZXNzbGluay5vcmcvc3BlYy1sYW5kaW5nDQo+PiANCj4+IFJvYmVydCBS
aWNodGVyICgxNSk6DQo+PiAgY3hsL2NvcmU6IFJlbW92ZSBkdXBsaWNhdGUgZGVjbGFyYXRpb24g
b2YgZGV2bV9jeGxfaW9tYXBfYmxvY2soKQ0KPj4gIGN4bC9jb3JlOiBDaGVjayBwaHlzaWNhbCBh
ZGRyZXNzIGJlZm9yZSBtYXBwaW5nIGl0IGluDQo+PiAgICBkZXZtX2N4bF9pb21hcF9ibG9jaygp
DQo+PiAgY3hsOiBVbmlmeSBkZWJ1ZyBtZXNzYWdlcyB3aGVuIGNhbGxpbmcgZGV2bV9jeGxfYWRk
X3BvcnQoKQ0KPj4gIGN4bDogVW5pZnkgZGVidWcgbWVzc2FnZXMgd2hlbiBjYWxsaW5nIGRldm1f
Y3hsX2FkZF9kcG9ydCgpDQo+PiAgY3hsL2FjcGk6IEFkZCBwcm9iZSBmdW5jdGlvbiB0byBkZXRl
Y3QgcmVzdHJpY3RlZCBDWEwgaG9zdHMgaW4gUkNEDQo+PiAgICBtb2RlDQo+PiAgUENJL0FDUEk6
IExpbmsgaG9zdCBicmlkZ2UgdG8gaXRzIEFDUEkgZncgbm9kZQ0KPj4gIGN4bC9hY3BpOiBDaGVj
ayBSQ0gncyBQQ0llIEhvc3QgQnJpZGdlIEFDUEkgSUQNCj4+ICBjeGwvYWNwaTogQ2hlY2sgUkNI
J3MgQ1hMIERWU0VDIGNhcGFiaWxpdGllcw0KPj4gIGN4bC9hY3BpOiBEZXRlcm1pbmUgUENJIGhv
c3QgYnJpZGdlJ3MgQUNQSSBVSUQNCj4+ICBjeGwvYWNwaTogRXh0cmFjdCB0aGUgUkNIJ3MgUkNS
QiBiYXNlIGFkZHJlc3MgZnJvbSBDRURUDQo+PiAgY3hsL2FjcGk6IEV4dHJhY3QgdGhlIGhvc3Qn
cyBjb21wb25lbnQgcmVnaXN0ZXIgYmFzZSBhZGRyZXNzIGZyb20gUkNSQg0KPj4gIGN4bC9hY3Bp
OiBTa2lwIGRldm1fY3hsX3BvcnRfZW51bWVyYXRlX2Rwb3J0cygpIHdoZW4gaW4gUkNEIG1vZGUN
Cj4+ICBjeGwvYWNwaTogUmV3b3JrIGRldm1fY3hsX2VudW1lcmF0ZV9wb3J0cygpIHRvIHN1cHBv
cnQgUkNEIG1vZGUNCj4+ICBjeGwvYWNwaTogRW51bWVyYXRlIHBvcnRzIGluIFJDRCBtb2RlIHRv
IGVuYWJsZSBSQ0hzIGFuZCBSQ0RzDQo+PiAgY3hsL2FjcGk6IFNwZWNpZnkgbW9kdWxlIGxvYWQg
b3JkZXIgZGVwZW5kZW5jeSBmb3IgdGhlIGN4bF9hY3BpIG1vZHVsZQ0KPj4gDQo+PiBkcml2ZXJz
L2FjcGkvcGNpX3Jvb3QuYyAgICAgIHwgICAxICsNCj4+IGRyaXZlcnMvY3hsL2FjcGkuYyAgICAg
ICAgICAgfCAzMTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+IGRyaXZl
cnMvY3hsL2NvcmUvcGNpLmMgICAgICAgfCAgMjIgKystDQo+PiBkcml2ZXJzL2N4bC9jb3JlL3Bv
cnQuYyAgICAgIHwgMTAzICsrKysrKysrLS0tLQ0KPj4gZHJpdmVycy9jeGwvY29yZS9yZWdzLmMg
ICAgICB8ICAgMyArDQo+PiBkcml2ZXJzL2N4bC9jeGwuaCAgICAgICAgICAgIHwgICAyIC0NCj4+
IGRyaXZlcnMvY3hsL21lbS5jICAgICAgICAgICAgfCAgIDEgKw0KPj4gdG9vbHMvdGVzdGluZy9j
eGwvdGVzdC9jeGwuYyB8ICAgOCArLQ0KPj4gOCBmaWxlcyBjaGFuZ2VkLCA0MDAgaW5zZXJ0aW9u
cygrKSwgNTEgZGVsZXRpb25zKC0pDQo+PiANCj4+IC0tIA0KPj4gMi4zMC4yDQo+PiANCj4gDQo+
IA0KPiANCg0K
