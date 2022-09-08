Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED0F5B27DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 22:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiIHUrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 16:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHUrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:47:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7C65851D;
        Thu,  8 Sep 2022 13:47:17 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288JKoUI013828;
        Thu, 8 Sep 2022 13:47:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5OYC+sw4XE1fK+Mmuj03mCcQW/ZGVu3MTmvOBSjztVQ=;
 b=PtuN1CvjIJ/DA+Lvb2+1QtP4pIsUae+9/vK8ZQs0hulZud1EUDTnujXjgieEzhODdRfC
 7uKvhp7pwRYWFYek2c4nn3cI/dGPuW6os1g1Q40m83c5k6fD7HETF2ae4eY+demg0Csa
 lhz/tHwp4NYVYzT96SQjq+SAmoQUsepbkLQ= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jfhthb4ex-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 13:47:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSPlv9WYOmh7CBUjx28Npv5hmGDDJmoX1nVaaEZdVK82rcmj7LuEN31gQC1ejXmqVSrmeFloWW6GmdBjabkKKvG+GbhrYyCHRCVmuIwrJC0kytXmcr2/rAZGj7tnSOQhNRKRg1IUZEA+Y2M9AIpinkgr5uwNp7zHE2hTs7RoTvjEgFzx29zIRJ8NY0EOejDq9IhUCDphb7O1/hC1mwuV/wBpam1AUL+muZY+lOiFM+LORHkDCVKZj1yQiu+md80xZLLbRa+R+T13eSeS0I91yQkORgyf4HfMGOkiIlDybETbfR3Aqg2SnAaredK4yHT+KR7aAGWdgkIPTvScitogig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OYC+sw4XE1fK+Mmuj03mCcQW/ZGVu3MTmvOBSjztVQ=;
 b=hDT1xE9J+IVKjEqV/UTie2xi6Vf0ZeV0KBXNarcDHxvglJKyjcFfZ0z0Oa2+qVgacX6ckx9bDBSggGl75er6fLzXoWz8c6K9PJFjzUVlIM3Qs+0R7lbWb7ruUH5DM07VmX7k47RmoDbJtQM6Z5MZ496oC63eJaxKdGwbXUPs2UY7xrKHZOhg7LpSLA7tN1HRyP8ke6Uo1LJ8VQqgQSmCWldrwoFLYzvfaimvC9UAvWEATTXWROLzBUQ4hEZL5Ab2NioXYotH5Sy1WiERP+eNN/4LdrQ00fUiiVKs5TH6jGnkybm3Jz2yPkGWQkU/iGxnczqfawL8fGeAp4f7Pu5ewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB4969.namprd15.prod.outlook.com (2603:10b6:303:e4::23)
 by DM5PR15MB1900.namprd15.prod.outlook.com (2603:10b6:4:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 20:47:13 +0000
Received: from CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f5e:6caf:40a6:ce10]) by CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::f5e:6caf:40a6:ce10%7]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 20:47:13 +0000
From:   "Jonathan Zhang (Infra)" <jonzhang@fb.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 09/15] cxl/acpi: Determine PCI host bridge's ACPI UID
Thread-Topic: [PATCH 09/15] cxl/acpi: Determine PCI host bridge's ACPI UID
Thread-Index: AQHYvRIwy8rOqcA1b0qGSKl7IMSeNq3WDjSA
Date:   Thu, 8 Sep 2022 20:47:13 +0000
Message-ID: <DE840F3C-0CBA-49A5-B9B9-9D279FFAAFFA@fb.com>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-10-rrichter@amd.com>
In-Reply-To: <20220831081603.3415-10-rrichter@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR15MB4969:EE_|DM5PR15MB1900:EE_
x-ms-office365-filtering-correlation-id: a8bd8d8d-de28-46f0-625b-08da91db4f29
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K7NUIvZIRXEcr0mP5kaAYfGTaJjABCSod9f8fn1W4XanYS8zBgyX3ozqbF326iHxDa7ltishQCHfUoUHuGiDB13QU0FsKq+gNn92reqceTP7JUVRH9gc9SYfz4+2WX0U8yNiJr+SFKnR0L3ZiClNgLhk/5mR1Enxs65eHnhJ6X3l9X0rFY9myQKh0PST+pRVDP+SxoNRqm7K8fA9fK9n6HDfJrCfEXPAuO+/66M+731kwKzjkQR8j5eLl7uTgjCJiSVnhzo6Tyr/8eKnA4Tqzy+3eC9+oIzxaDllFwY+DcMkw61smK/fZ7qVeAPHwkENDltuSRyeFuL4EodBh14XcJIKzmBc42l7+mwb4MTQC0oefPqjejaZVHh3HZTwex8XxpMwZ2jbEkXcHNH24lXWrz6axz1va81QOmAbmYjEydnP1A/58rbdMwRfNdFRUftKmREbyEsgKj7Fbxn57jfp+GZoV8gdGo8SyeS4d/XyX6fjxuRCoVVh497UhX/WB2V640KpNPMPnjDlIXMsM8Ip+2pM7/XEtzqU8dHOUCv+xag7a//t/oQh80O5Rv9yT3j9SVEhLDTl0FiikGVoBeWscZx6UbvVp3Fb4R/et4iinlqQccg5M7bC4Okh07dlT+ZM8H2mRR2DQF12v8fnsyMtphYWxtUKVLlYuA7kDW2cFzVE94rxmUAftWfO8D3Z2btxeXjymo9VGgb3Fia+2dV6TDOlhnjH7lHbtZKD1VYaLo0hl0kikkTgx3GR9ZDZOT2mCX4Sx+MmrrXgZgsIH9LjFZkQZqpLXX9k2UYCKSheGmk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4969.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(71200400001)(6506007)(38070700005)(6512007)(53546011)(86362001)(41300700001)(478600001)(6486002)(91956017)(186003)(2616005)(36756003)(7416002)(122000001)(38100700002)(76116006)(4326008)(8676002)(8936002)(6916009)(5660300002)(66446008)(316002)(66946007)(33656002)(64756008)(66556008)(2906002)(66476007)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2V3bE1vcDcrcDZXWVVrQ1JmMmZuVUQvc0J2SVhTMElYWDF2T2h6akI4ZC9Q?=
 =?utf-8?B?RVUwMW9UaXFmVVFRL0lXNUdNOTVVbHNMSExTdHpJM3RrT3pYK3VzN2M4QzRC?=
 =?utf-8?B?OGpyVzlBRlNKN1djd29XVjdCRnRENGJEbUt5WENHYmZta3dJV0VFWWJrNkNp?=
 =?utf-8?B?SDR2bEVWTElqWFpBKzNaMDhWbnlZbThsV0QxTHI2ekhiZzkrQ1h3LzlTaE5X?=
 =?utf-8?B?dlJCMUVYWVJLalUxazJZZGE2NDVrYlR4cmZMTVdlMzZXT2x0bXNZUTVYMU5x?=
 =?utf-8?B?VTRkVWRmUlNBOXNxY0dYZUVMcXY5OXRXK0hjQ1hoY2VoNlI5cWJVSHIxV3oz?=
 =?utf-8?B?UTArTkMrNWVzSnpoMElSSER5MXB0YmRmdjdwSXBMNzlhNkQ4NFhSWUs3WkFq?=
 =?utf-8?B?aGxtdTN4bDdQN3FPR3VEMFJEbjRHa1NsVlliRU5RMURxUFd3WDBxcmk5b0RX?=
 =?utf-8?B?VXF2RkM5eEtGdEhhQjNtRzd5RGY1bUk1cGIyZVM0b3JlNlNNRUF6Mm03dHFN?=
 =?utf-8?B?TkJkVlBuYVMzM0tYREZLaWNHOW12dzd4aDg5TW9TdXlLK0wzaWI3OGpyTkI1?=
 =?utf-8?B?dUEzbTNtU1V0K0VYZE45N0d3QjIwM2JiQmF0QVFUR3BzbGt1NmtqVmsvYU8y?=
 =?utf-8?B?c2s2Y0VSQ1F6SWljMVRZNnlRZHJmOFBXWUlTdlpvWEZ2NlM1c0lSdzJxcUVB?=
 =?utf-8?B?UXZLdFhKODRKbHd4T1VUV2VXYnpBeUZHOE5jM1AxSmREQ2ZLbVphUEIycENC?=
 =?utf-8?B?WXRUbHZLQ3FRRmJqNFh4VjJpKy83ZFovaHJxL2M2ZTN3V0tncklYSzJnVm5w?=
 =?utf-8?B?R1VjNXI0eW5Cb2FuN05CcWhueDVHd2ZmOHR2QWtCM2VxcnNxUHVsZFBBZFc2?=
 =?utf-8?B?aWFUR2k0R1dnZ3lLQkZIeGM3ZzZ2VExrMG9lWDdrcVhmWG9keHR0VDVuTU0z?=
 =?utf-8?B?UDM2YjdJTlliaDNyNVZoNXFDQkdEU0c4Si93cnVrQnhnNzdZbGFmUll3enR3?=
 =?utf-8?B?MEJKQjNPd0Z6NjZlYWY0ajBQSCtuemxDbm1qTVNqbThtYjRCZ3FrU2FEUVdF?=
 =?utf-8?B?RWNaR0M4dVpORkxJUzB4NlduUkRFL0lOdUVIVHNXT3pydU4xK1VtUWNOeVRr?=
 =?utf-8?B?SkxnUmpXZWkyOTF4NXB6aEQ1M0MvY3h1N2IwOWlwT3lOQlRaZW4xemNMZ3ow?=
 =?utf-8?B?cUNaa3RSQU55TkFIZDYvSlhkbEdVV0dDalpPNUZva1R2cHN0WlNnclg3cndE?=
 =?utf-8?B?Q1RDNDBzOFFRL2J1NnZwazgvNXozdEdDSGRqUlhGdXg2bFBqU3gvM1NxTzFC?=
 =?utf-8?B?bm8vTS9ncnM0S293ekExRm5HY0dDYWNodmpMS212SWZwQVhkV1h0T0JsODQv?=
 =?utf-8?B?bzhpMWhIcSsvb0dDZFhneDFaTkM5eW83UWdIZW9JR0FlM0Yzak85ay8xLzJr?=
 =?utf-8?B?UHExdzB0dWJwVzFMdEhXdXY2cXZYUG1UdGgwa1FWUjFEUnNsdy91YlBuMlRM?=
 =?utf-8?B?TFo5Y1BlZTNBK203Rm85YmZUbDZ6dUFsRU5yRjY5alpJQjlZL2xxSXR5VENn?=
 =?utf-8?B?YUpUMWF1cnNnY0ZCdWtyTDQwaThBemhjNlZqdmFhSW03R2FsbWtkY3FMU0RH?=
 =?utf-8?B?b3VreDMvUVNXWlBpd3o0eUpNSUVHNU5ZL29kd0NoeG1ueTJkb0N3Rk5IZE10?=
 =?utf-8?B?MUZvNmZXQmhtMnNka1pxc3kwMWFsekl3bzV0UUR6SDN3L0FqdHFuR29PSUZu?=
 =?utf-8?B?UnJjNHBoK2xVOXh6NEp6ZG43bHdGQ1dGSXB1WHcvb2dnU2lZcFBzNlp6alE2?=
 =?utf-8?B?ZEhrTjJhMjU5QnNBQ1NWUXNQWjIwR2NXckY3U055QmpmS1lvMW96dDhUMm5T?=
 =?utf-8?B?aFBQUmdpTnJsWS9rSERzOWpsNk93N0EzbTBzZzVIRlk2Sms2b1FMZzNaN2M1?=
 =?utf-8?B?d0t1ek9nTTJacStvcXhueGpCNEM1VGVXaUJtaDUxa1gzWm9OamdZNXhxblRU?=
 =?utf-8?B?WHVBbnZNMkVaWEpyUVFjZmtPa2lvbTk5dWsyWmpTa0tkUERSZUJMTElQaGhv?=
 =?utf-8?B?UFRVTGVMVGxickhIa2tIZXlqSE9mWGVrVm9YL1BHUTRESEdHTmNoUWdteGt6?=
 =?utf-8?B?L3BLZGNDNmZRdUd4VWN2Ni9Oc0J4bHBlRmZuaUk1dy91K0dySXZDcEdnUk93?=
 =?utf-8?Q?D/ccV0P5W7qBiwNy6EF7wGs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDE9B508F8CEB7429B413138B0598A68@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4969.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bd8d8d-de28-46f0-625b-08da91db4f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 20:47:13.8011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoMAn+bXJ8jYwlWsjbtOnfPVriityT+dCsx6Gi5rXGSgmxtCTMFxoHPaf3R1nrqh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1900
X-Proofpoint-GUID: -614mmXCAdXiLYBs4tfK3oGpZQa9lHX1
X-Proofpoint-ORIG-GUID: -614mmXCAdXiLYBs4tfK3oGpZQa9lHX1
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

DQoNCj4gT24gQXVnIDMxLCAyMDIyLCBhdCAxOjE1IEFNLCBSb2JlcnQgUmljaHRlciA8cnJpY2h0
ZXJAYW1kLmNvbT4gd3JvdGU6DQo+IA0KPiBUaGUgVUlEIGlzIG5lZWRlZCB0byByZWFkIHRoZSBS
Q0gncyBDRURUIGVudHJ5IHdpdGggdGhlIFJDUkIgYmFzZQ0KPiBhZGRyZXNzLiBEZXRlcm1pbmUg
dGhlIGhvc3QncyBVSUQgZnJvbSBpdHMgQUNQSSBmdyBub2RlLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUm9iZXJ0IFJpY2h0ZXIgPHJyaWNodGVyQGFtZC5jb20+DQo+IC0tLQ0KPiBkcml2ZXJzL2N4
bC9hY3BpLmMgfCAxMiArKysrKysrKysrKysNCj4gMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9hY3BpLmMgYi9kcml2ZXJzL2N4
bC9hY3BpLmMNCj4gaW5kZXggZjljZGYyM2E5MWE4Li5iMzE0NmI3YWU5MjIgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvY3hsL2FjcGkuYw0KPiArKysgYi9kcml2ZXJzL2N4bC9hY3BpLmMNCj4gQEAg
LTM2OCw4ICszNjgsMjAgQEAgc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqY3hsX2ZpbmRfbmV4dF9y
Y2goc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqaG9zdCkNCj4gc3RhdGljIGludCBfX2luaXQgY3hs
X3Jlc3RyaWN0ZWRfaG9zdF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiB7
DQo+IAlzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpob3N0ID0gTlVMTDsNCj4gKwlzdHJ1Y3QgYWNw
aV9kZXZpY2UgKmFkZXY7DQo+ICsJdW5zaWduZWQgbG9uZyBsb25nIHVpZCA9IH4wOw0KPiANCj4g
CXdoaWxlICgoaG9zdCA9IGN4bF9maW5kX25leHRfcmNoKGhvc3QpKSAhPSBOVUxMKSB7DQo+ICsJ
CWFkZXYgPSBBQ1BJX0NPTVBBTklPTigmaG9zdC0+ZGV2KTsNCj4gKwkJaWYgKCFhZGV2IHx8ICFh
ZGV2LT5wbnAudW5pcXVlX2lkIHx8DQo+ICsJCQkoa3N0cnRvdWxsKGFkZXYtPnBucC51bmlxdWVf
aWQsIDEwLCAmdWlkKSA8IDApKQ0KVGhlIFVJRCBmaWVsZCBob2xkcyA0IGJ5dGVzIG9mIEFTQ0lJ
IGNoYXJhY3RlcnMuIGtzdHJ0b3VsbCgpIHdvdWxkIGZhaWwNCmlmIHRoZSBVSUQgZmllbGQgaGFz
IHZhbHVlIHN1Y2ggYXMg4oCYQ1gwM+KAmS4NCg0KPiArCQkJY29udGludWU7DQo+ICsNCj4gKwkJ
ZGV2X2RiZygmYWRldi0+ZGV2LCAiaG9zdCB1aWQ6ICVsbHVcbiIsIHVpZCk7DQo+ICsNCj4gKwkJ
aWYgKHVpZCA+IFUzMl9NQVgpDQo+ICsJCQljb250aW51ZTsNCj4gKw0KPiAJCWRldl9pbmZvKCZo
b3N0LT5kZXYsICJob3N0IHN1cHBvcnRzIENYTFxuIik7DQo+IAl9DQo+IA0KPiAtLSANCj4gMi4z
MC4yDQo+IA0KPiANCg0K
