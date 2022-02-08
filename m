Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E2B4AD114
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiBHFdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiBHFYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:24:18 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31636C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:24:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDd1mTJnFd4VPS5770B/CY9Z7a4wkWOzYnGcQxtbuxj5natCU4PAV5OZ9+elhmvRCwS4YKU8ku9DgHpmA+A56rHr6+9A/w9cFWCC6HTgPyWyJjzJ78hEdWW12Gk81erNrcJ3Vvx0BGOGEvr7+LuT3D5eeqJfy6SHP/yl8Nnp+1ut648X+ahWhKjvtoM3MG9czX9pd6/08IqlZ6flXsOzhSl4cvusRzew6AWMAg+TW38kAFIz+bQ3OHp+PpB5DJcJ7/ArZ7OOdz1pcmPAZoygIqDFd5GxrBRSj4TDs65pWZxgUBwogoYV+U5h+8y9WcKAQubpRdoRhoLp2XerpTEK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgjsvHWfP/7BQNmECUVZDk4WROpMm9vplhy5iqWXVeI=;
 b=CFX3khKXugDcF+Qpk8IRjnmU0rAAa/9HbfAEahOWIR2fgNDv8QqI2MfKwfF60EztY/lLVy3uwyNFYIWGG5KduyYdpm2+DDqiRXNsXShvRJR8I11WmxVsJTYVw/MXquRyllUnl9jpoJg73qXtQ+vgyTPQkadbh+vywqfVqPS75O7n9kLYH9++Au/aTkNaGfThpr3zYaBZMoD/9rm9oKD4p5oFIopftHDLp/1Xg113u3U+aA1y2KKMlLehsHTT/rOgiDyuEjuJ4sR6e1FDrRAsPlmbF+71L2xXJFRsKImEkAlNDskqxN3JvoMAGw9ZMPK06AxZPe0tQa3tJgenStuF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgjsvHWfP/7BQNmECUVZDk4WROpMm9vplhy5iqWXVeI=;
 b=Sx0v+rgZeT8PdDWZMepzdWJhSppF0bARO/ql41rcUvnuYnHK7G89rzCdbd6Md1FNCZfxf63ER8OGoEQfpk4WwVakoZMfaRAiXadzUd7xGWWWTtcUBC24jtjYkUVP1eWmC2a8bzMuT/zLBGUhY4SvAnamK1DWBu63VyeH4cUbPws=
Received: from DM8PR02MB7926.namprd02.prod.outlook.com (2603:10b6:8:31::9) by
 DM6PR02MB6588.namprd02.prod.outlook.com (2603:10b6:5:221::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Tue, 8 Feb 2022 05:24:14 +0000
Received: from DM8PR02MB7926.namprd02.prod.outlook.com
 ([fe80::1da8:d2cc:796a:2879]) by DM8PR02MB7926.namprd02.prod.outlook.com
 ([fe80::1da8:d2cc:796a:2879%8]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 05:24:14 +0000
From:   Amit Kumar Kumar Mahapatra <akumarma@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: RE: [RFC PATCH] mtd: tests: Fix eraseblock read speed miscalculation
 for lower partition sizes
Thread-Topic: [RFC PATCH] mtd: tests: Fix eraseblock read speed miscalculation
 for lower partition sizes
Thread-Index: AQHYGQFq19rp4dgej02YwZhjtlqyeqyCC+cAgAcZj2A=
Date:   Tue, 8 Feb 2022 05:24:14 +0000
Message-ID: <DM8PR02MB7926066D58FAF2FEC1030733BA2D9@DM8PR02MB7926.namprd02.prod.outlook.com>
References: <20220203132434.25769-1-amit.kumar-mahapatra@xilinx.com>
 <20220203175616.14f85dc1@xps13>
In-Reply-To: <20220203175616.14f85dc1@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67cd862c-3823-4809-72b9-08d9eac33ebd
x-ms-traffictypediagnostic: DM6PR02MB6588:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB6588B69600A2AB2DE12AFB8FBA2D9@DM6PR02MB6588.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PAlmfKEpdNfR1l5Y2MFfVfFTVbPQ5MgtPfJIjSTOF7+kHOjdXe5DpEHct2YQWngVkTOvB/uuMKUDNuqe0JCA04LH+Hjd4/VJKVQ2QQ7/vhr4irjIz0sWmF3NoCLrr44ZbdjMR4FQ8DhIidCXB7nnhZPQ6HzVdE+Tv+yeEqxM49b3+ymtffSxm5wdvNTRoj+2SP2/nR55xSlwXT5MdKcwht+DqjR7ZFZ4PisOC7heLYIicP2b1Mww0M0ISn/f4dJE6/gWrtgOkYFr6c2JwfaMhex0Q9wuksU9WB7aQyPFvsD3/Q9nnU4aLCwTWutMkpbq7EXwq6H+HGyMzeowaXvck6GYnZ/wPFCJrHxgSbOZOoaTqYwvNGqHSgv8K35YRUkTA7/f2JUTC2UT2cdG58tkpo0+Lp+zgoCrgsFQaV4LwPYcjNPrecV4JARV20+4PEhQdVh3ahBW1aZkLTEnyOu9SGyns7w8lPfUfiCLSCl0eyxhp4itENtLENEwTp89hHSTjr1uu1pVPrpi6N7eo5aNBZKGOmEA6LDJXeIzHmfMgNbmZ8J0SxSG7WEy1W803MmCU9HWdpHHKOgbhpeOWa3CPjW5RO5zZEKJBzJDSaFgeNxshDY/5qk+4cHMw++H1uAWJQir7jzORI96d0pMiD1FDCxO7LEs8Vsqtg7ds+cxXJpZOPgtvU/CPYWjOJdAa4FQPp72Xa7ijApNY53AHCVehA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB7926.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8936002)(66556008)(83380400001)(64756008)(66574015)(52536014)(66446008)(55016003)(66476007)(8676002)(508600001)(33656002)(26005)(66946007)(38070700005)(86362001)(53546011)(9686003)(38100700002)(5660300002)(122000001)(76116006)(6506007)(54906003)(7696005)(186003)(6916009)(2906002)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bThTbnpLWkdBblNFUmx5RHRRTVk0dVY2MmdkK3RRMWw4bkYxVHB0N2IydjFD?=
 =?utf-8?B?WnNGd1F0ZTMzaWZKcVhzaWk4QVM2blg4bXBycVZlNmdEbC9tM3ozUzRKd2JX?=
 =?utf-8?B?VWhXdWtuNnR1azZNaktwL0hxZ1R5Z2puaHE0REZ2TnFYNmFsQTdtT0JKdUQ5?=
 =?utf-8?B?TE9IRjdTb01sN3d2b09kSWlHNnZBMjdRcmFzdmdsT1pJTXZpQ1R4Q1Q2Sm5p?=
 =?utf-8?B?czFQcDNxWi9kdlh4aVowVjQvUUpRZnpteFJDTmZCakxzNjVSaGdWQzJjRjZF?=
 =?utf-8?B?OEpzbUNIVzRvanc1ODd0RFppalBhNndQTHdFcXJzc041QnR1SVU2TEg2RzZK?=
 =?utf-8?B?dFkxR2Z0UFdDVWVRdXpaUmlPWGFqYkgvR1JvVlRLODNEWS9hc1ZwdW5qalYr?=
 =?utf-8?B?c3JyWDBFV01yaWRMZTVRZW05NzhFQXhBc25qR2NTMGNvakN1RTlIcEpmbXZI?=
 =?utf-8?B?UCtzWmV3SzU2NURWWE5iTnllczVkQndvRE5PeEJ3YXZlYXR6Q0VDMnBkRngr?=
 =?utf-8?B?L3VkdlRCY21zQThaakc3QTdHanhKaHc2MjliMEtMeExYVkUxYllIQzFDRmdO?=
 =?utf-8?B?TEZSVndadWRWc3l4cWlEL0lpOWZmWlY4R3hOT0g4RGZKcnJwOFdNU2dYd3Yz?=
 =?utf-8?B?ZC93U3pQQ0NuMlFtKzhXN3A0dWk4MGdwY3Uwa3AyVU5wZHIrL0ZzbDR6dHR3?=
 =?utf-8?B?NGdJbkpYOWlyVG5lTHdjL0RaaC9kdzBxV3BZbTJpM1JoU3B1aTJvTU0wWnpi?=
 =?utf-8?B?bFFSUk5VWWtUZWlKWStmU2tOSHFsSHM4VUV0bGZDdmdPMnNnQ0J3M095WUNF?=
 =?utf-8?B?NjNRN3NQcDdFcjFDWnE0aTJqSHB2TzJmMkVVclAySnV4NzRyWXdJQkhHQUU2?=
 =?utf-8?B?alhOSjJFZi8yV0Y2NnBNaTEyaDJaUGFxUUsrdDhaRmptOWMyK0VqTVlqKytY?=
 =?utf-8?B?M0w5cFU2SU0zdzFDMVEwa0J1KzNiU3dOVGdRNjh3ZDBaZTZncENYS2V1YVBj?=
 =?utf-8?B?YnU1TWN5YU1VckJrMTRTQ1RQczFVeW5XKzhFU1BTQ0Y0d2p2SlloMk1vVTFJ?=
 =?utf-8?B?Q1kzQk5BclRQcmtZbW1sVkpaMHArSjdWeHpUNmFnS1A4TXgvRXFHZFRvUXFj?=
 =?utf-8?B?bUt4UXYrSXZpaHo1SElsTE1PeVJTOERLdU56dHJzSm5yV2xSTXZIV2duZG9J?=
 =?utf-8?B?UG1DSm1XcHVBeE9CRmVCRHR0Z3d5RExwRVRBQWlxTjc3ZVZlUzZld3N4SnVm?=
 =?utf-8?B?YjBURm83R3FjamRnTTF3Y3dSRjE1VjVSUnJrcWNDcVB0U3pKVGM3QU1xOUJN?=
 =?utf-8?B?VFo2bE9aQk5Qemd0dGZ5Q1BaNGp0TkdJNjJDeWN5T0RWMWhPejlCY054UFVm?=
 =?utf-8?B?UGkzR0ZhdThpNitqbkhZVWZvQzcydk9KNnMrcnhzWHd2UEFUQnJQbGV2eVVi?=
 =?utf-8?B?eHB4UXF5Qzk2NzhCMXQxZlZjUjBDb0pyVTQ5RWhFL2x1WHppREh3SVVIdzdw?=
 =?utf-8?B?SUNQRTdQNUcxMHhGSnIzSGVHM0duUjdwSUsrcENTUUptNXdvSFRISnMybFJ2?=
 =?utf-8?B?TnpoU3ZoMGFQUEJadFM0Vm1NeEQxcVplY2pQRUUzejNWT2QyK0k0Y0NYV3h4?=
 =?utf-8?B?VlpBeHZRakY2WUFVTnF6SWprNHJQZWVwc0VmMk9WbTMxZ0RTRnhPN0UrUE45?=
 =?utf-8?B?T0RuMStDQ3c1YlRGMzZBWXFwZktJK2ZMWXYwVVhyM1ZkYWxpS1BQY0FjdEd3?=
 =?utf-8?B?cHBOYk9qUUtTUytlRjFpektTOUxkUHQ3STJFcXVINmN0YmU3Z3lFMFhram5Y?=
 =?utf-8?B?dzg1NG1EQm9UZ01DMFoyOVY4Yk42Z2dXaGJwQnhleUhrNXY1VndTSW1hbWFa?=
 =?utf-8?B?Q1NLRTJ1bTQvbWhrcW5GZnlWSDVNam5FaFAxenFiK29XOE5keWlNYnNmbTFx?=
 =?utf-8?B?QldMVUI0Wm9tdCtPUzZxL3dKMm0wVEUxalhGVnpvVU9lOW02YkExRzBpM1dz?=
 =?utf-8?B?L2IyZkdOWk5CYUJGR3VEUGFXRHEyVERhOUZMK3VWc0JOWlBVYVp5UDUvNzNK?=
 =?utf-8?B?YkM0TmtoNXE2YnlnaDlBRVdXbGNYY3FwWFJSM2c0WTRJVnNGbXRuaGhDSVlk?=
 =?utf-8?B?NGhYR3FFQWxuSjFRcC9yMWwzMEZZb0hWNkRnb3pqUGJadkloRTJGMnN1V1VP?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB7926.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cd862c-3823-4809-72b9-08d9eac33ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 05:24:14.0511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8yviwimdYAQWoFTNBnYGcXnsEYp5QF/ubmC4hUkQEvdWs+aADuJTRcrf7n40iUdfwvg74SoYnala+o9laYObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6588
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWlxdWVsLA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
TWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIEZlYnJ1YXJ5IDMsIDIwMjIgMTA6MjYgUE0NCj4gVG86IEFtaXQgS3VtYXIgS3VtYXIgTWFo
YXBhdHJhIDxha3VtYXJtYUB4aWxpbnguY29tPg0KPiBDYzogcmljaGFyZEBub2QuYXQ7IHZpZ25l
c2hyQHRpLmNvbTsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBnaXQgPGdpdEB4aWxpbnguY29tPjsgRGF2aWQgT2JlcmhvbGxl
bnplcg0KPiA8ZGF2aWQub2JlcmhvbGxlbnplckBzaWdtYS1zdGFyLmF0Pg0KPiBTdWJqZWN0OiBS
ZTogW1JGQyBQQVRDSF0gbXRkOiB0ZXN0czogRml4IGVyYXNlYmxvY2sgcmVhZCBzcGVlZCBtaXNj
YWxjdWxhdGlvbg0KPiBmb3IgbG93ZXIgcGFydGl0aW9uIHNpemVzDQo+IA0KPiBIaSBBbWl0LA0K
PiANCj4gK0NjOiBEYXZpZCwgd2hvJ3MgbWFpbnRhaW5pbmcgdGhlIHRvb2xzLiBQbGVhc2Uga2Vl
cCBoaW0gaW4gdGhlDQo+IHJlY2lwaWVudHMgbGlzdCENCj4gDQo+IGFtaXQua3VtYXItbWFoYXBh
dHJhQHhpbGlueC5jb20gd3JvdGUgb24gVGh1LCAzIEZlYiAyMDIyIDE4OjU0OjM0DQo+ICswNTMw
Og0KPiANCj4gPiBXaGlsZSBjYWxjdWxhdGluZyBzcGVlZCBkdXJpbmcgIG10ZF9zcGVlZHRlc3Qs
IHRoZSB0aW1lIGludGVydmFsDQo+ID4gKGkuZS4sIHN0YXJ0IC0gZmluaXNoKSBpcyByb3VuZGVk
IG9mZiB0byB0aGUgbmVhcmVzdCBtaWxsaXNlY29uZHMgYnkNCj4gPiBpZ25vcmluZyB0aGUgZnJh
Y3Rpb25hbCBwYXJ0LiBUaGlzIGxlYWRzIHRvIG1pc2NhbGN1bGF0aW9uIG9mIHNwZWVkLg0KPiA+
IFRoZSBtaXNjYWxjdWxhdGlvbiBpcyBtb3JlIHZpc2libGUgd2hpbGUgcnVubmluZyBzcGVlZCB0
ZXN0IG9uIHNtYWxsDQo+ID4gcGFydGl0aW9uIHNpemVzKGkuZS4sIHdoZW4gcGFydGl0aW9uIHNp
emUgaXMgZXF1YWwgdG8gZXJhc2VibG9jayBzaXplDQo+ID4gb3IgdHdpY2UgdGhlIGVyYXNlYmxv
Y2sgc2l6ZSkgYXQgaGlnaGVyIHNwaSBmcmVxdWVuY2llcy4NCj4gPg0KPiA+IEZvciBlLmcuLCB3
aGlsZSBjYWxjdWxhdGluZyBlcmFzZWJsb2NrIHJlYWQgc3BlZWQgZm9yIGEgbXRkIHBhcnRpdGlv
bg0KPiA+IHdpdGggc2l6ZSBlcXVhbCB0byB0aGUgZXJhc2VibG9jayBzaXplKGkuZS4sIDY0S2lC
KSB0aGUgZXJhc2VibG9jaw0KPiA+IHJlYWQgdGltZSBpbnRlcnZhbCBjb21lcyBvdXQgdG8gYmUg
OTY2NDkwIG5hbm9zZWNvbmQuIFRoaXMgaXMgdGhlbg0KPiA+IGNvbnZlcnRlZCB0byBtaWxsaXNl
Y29uZChpLmUuLCAwLjk2NiBtc2VjLikuIFRoZSBpbnRlZ2VyIHBhcnQgKGkuZS4sIDANCj4gPiBt
c2VjKSBvZiB0aGUgdmFsdWUgaXMgY29uc2lkZXJlZCBhbmQgdGhlIGZyYWN0aW9uYWwgcGFydCAo
aS5lLiwgMC45NjYpDQo+ID4gaXMgaWdub3JlZCxmb3IgY2FsY3VsYXRpbmcgdGhlIGVyYXNlYmxv
Y2sgcmVhZCBzcGVlZC4gU28gdGhlIHJlcG9ydGVkDQo+ID4gZXJhc2VibG9jayByZWFkIHNwZWVk
IGlzIDAgS2lCL3MsIHdoaWNoIGlzIGluY29ycmVjdC4NCj4gPg0KPiA+IFRoZXJlIGFyZSB0d28g
YXBwcm9hY2hlcyB0byBmaXggdGhpcyBpc3N1ZS4NCj4gPg0KPiA+IEZpcnN0IGFwcHJvYWNoIHdp
bGwgYmUgdG8ga2VlcCB0aGUgdGltZSBpbnRlcnZhbCBpbiBtaWxsaXNlY29uZC4gYW5kDQo+ID4g
cm91bmQgdXAgdGhlIGludGVnZXIgdmFsdWUsIHdpdGggdGhpcyBhcHByb2FjaCB0aGUgMC45NjZt
c2VjIHRpbWUNCj4gPiBpbnRlcnZhbCBpbiB0aGUgYWJvdmUgZXhhbXBsZSB3aWxsIGJlIHJvdW5k
ZWQgdXAgdG8gMW1zZWMgYW5kIHRoaXMNCj4gPiB2YWx1ZSBpcyB1c2VkIGZvciBjYWxjdWxhdGlu
ZyB0aGUgc3BlZWQuIERvd25zaWRlIG9mIHRoaXMgYXBwcm9hY2ggaXMNCj4gPiB0aGF0IHRoZSBy
ZXBvcnRlZCBzcGVlZCBpcyBzdGlsbCBub3QgYWNjdXJhdGUuDQo+ID4NCj4gPiBTZWNvbmQgYXBw
cm9hY2ggd2lsbCBiZSB0byBjb252ZXJ0IHRoZSB0aW1lIGludGVydmFsIHRvIG1pY3Jvc2Vjb25k
cw0KPiA+IGluc3RlYWQgb2YgbWlsbGlzZWNvbmRzLCB3aXRoIHRoaXMgYXBwcm9hY2ggdGhlIDk2
NjQ5MCBuYW5vc2Vjb25kIHRpbWUNCj4gPiBpbnRlcnZhbCBpbiB0aGUgYWJvdmUgZXhhbXBsZSB3
aWxsIGJlIGNvbnZlcnRlZCB0MCA5NjYuNDkwdXNlYyBhbmQNCj4gPiB0aGlzIHZhbHVlIGlzIHVz
ZWQgZm9yIGNhbGN1bGF0aW5nIHRoZSBzcGVlZC4gQXMgY29tcGFyZWQgdG8gdGhlDQo+ID4gY3Vy
cmVudCBpbXBsZW1lbnRhdGlvbiBhbmQgdGhlIHN1Z2dlc3RlZCBGaXJzdCBhcHByb2FjaCwgdGhp
cyBhcHByb2FjaA0KPiA+IHdpbGwgcmVwb3J0IGEgbW9yZSBhY2N1cmF0ZSBzcGVlZC4gRG93bnNp
ZGUgb2YgdGhpcyBhcHByb2FjaCBpcyB0aGF0LA0KPiA+IGluIGZ1dHVyZSBpZiB0aGUgbXRkIHNp
emUgaXMgdG9vIGxhcmdlIHRoZW4gdGhlIHU2NCB2YXJpYWJsZSwgdGhhdA0KPiA+IGhvbGRzIHRo
ZSBudW1iZXIgb2YgYnl0ZXMsIG1pZ2h0IG92ZXJmbG93Lg0KPiA+DQo+ID4gSW4gdGhpcyBwYXRj
aCB3ZSBoYXZlIGdvbmUgd2l0aCB0aGUgc2Vjb25kIGFwcHJvYWNoIGFzIHRoaXMgcmVwb3J0cyBh
DQo+ID4gbW9yZSBhY2N1cmF0ZSBzcGVlZC4gV2l0aCB0aGlzIGFwcHJvYWNoIHRoZSBlcmFzZWJs
b2NrIHJlYWQgc3BlZWQgaW4NCj4gPiB0aGUgYWJvdmUgZXhhbXBsZSBjb21lcyBvdXQgdG8gYmUg
MTMyNTA1IEtpQi9zIHdoZW4gdGhlIHNwaSBjbG9jayBpcw0KPiA+IGNvbmZpZ3VyZWQgYXQgMTUw
TWh6Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW1pdCBLdW1hciBNYWhhcGF0cmEgPGFtaXQu
a3VtYXItDQo+IG1haGFwYXRyYUB4aWxpbnguY29tPg0KPiA+IC0tLQ0KPiA+IEJSQU5DSDogbXRk
L25leHQNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tdGQvdGVzdHMvc3BlZWR0ZXN0LmMgfCAxMCAr
KysrKy0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvdGVzdHMvc3BlZWR0ZXN0
LmMNCj4gPiBiL2RyaXZlcnMvbXRkL3Rlc3RzL3NwZWVkdGVzdC5jIGluZGV4IDkzZTc2NjQ4ZjY3
Ni4uMmI3NmU3NzUwYzY4DQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tdGQvdGVzdHMv
c3BlZWR0ZXN0LmMNCj4gPiArKysgYi9kcml2ZXJzL210ZC90ZXN0cy9zcGVlZHRlc3QuYw0KPiA+
IEBAIC0xNjEsMTMgKzE2MSwxMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc3RvcF90aW1pbmcodm9p
ZCkgIHN0YXRpYw0KPiA+IGxvbmcgY2FsY19zcGVlZCh2b2lkKSAgew0KPiA+ICAJdWludDY0X3Qg
azsNCj4gPiAtCWxvbmcgbXM7DQo+ID4gKwlsb25nIHVzOw0KPiANCj4gU2hvdWxkIHRoaXMgYmUg
YW4gZXhwbGljaXQgNjQtYml0IHZhbHVlPyBBbmQgdW5zaWduZWQ/DQo+IHVuc2lnbmVkIGxvbmcg
bG9uZyBpbnQgb3IgdWludDY0X3Q/IEkgYmVsaWV2ZSB3ZSBhcmUgbm93IDEwMDB4IGNsb3Nlcg0K
PiB0byB0aGUgNEdpQiBsaW1pdCBzbyB3ZSBtaWdodCBuZWVkIHRvIGVubGFyZ2UgdGhpcyB2YXJp
YWJsZS4NCg0KSSB3aWxsIGNoYW5nZSBpdCB0byB1aW50NjRfdC4NCg0KUmVnYXJkcywNCkFtaXQN
Cj4gDQo+ID4NCj4gPiAtCW1zID0ga3RpbWVfbXNfZGVsdGEoZmluaXNoLCBzdGFydCk7DQo+ID4g
LQlpZiAobXMgPT0gMCkNCj4gPiArCXVzID0ga3RpbWVfdXNfZGVsdGEoZmluaXNoLCBzdGFydCk7
DQo+ID4gKwlpZiAodXMgPT0gMCkNCj4gPiAgCQlyZXR1cm4gMDsNCj4gPiAtCWsgPSAodWludDY0
X3QpZ29vZGViY250ICogKG10ZC0+ZXJhc2VzaXplIC8gMTAyNCkgKiAxMDAwOw0KPiA+IC0JZG9f
ZGl2KGssIG1zKTsNCj4gPiArCWsgPSAodWludDY0X3QpZ29vZGViY250ICogKG10ZC0+ZXJhc2Vz
aXplIC8gMTAyNCkgKiAxMDAwMDAwOw0KPiA+ICsJZG9fZGl2KGssIHVzKTsNCj4gPiAgCXJldHVy
biBrOw0KPiA+ICB9DQo+ID4NCj4gDQo+IE90aGVyd2lzZSBsZ3RtIQ0KPiANCj4gUmV2aWV3ZWQt
Ynk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IA0KPiANCj4g
VGhhbmtzLA0KPiBNaXF1w6hsDQo=
