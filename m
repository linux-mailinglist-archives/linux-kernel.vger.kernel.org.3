Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C13546F59
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350927AbiFJVkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347712AbiFJVkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:40:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2105.outbound.protection.outlook.com [40.107.22.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EA05BD24;
        Fri, 10 Jun 2022 14:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPf8n+P0Xv+3o1H/ZBmk87+GShJXroXqkl9rjrFsWmwxbZ1efDrG/M9sJDLgBj4sNzh2hILOJVIhc4t7DT4PD8TMZUE+rYSDTQC5nigqcPb89d82jNcGFhmk9QDExZz1pXrM8rXSV+yNF/btdQB50xtNlW57W0VVca1g1KAqVEJZahtU3dAZOOkfgIhYParneDqxKFwI8KZm3isuLhYQLFLn2hZreoDLyc+mD9BJSHF901jtePU2M55KnF1TDSUPZVdd8kJ8woi3ZqlN5Ud4EgOJBVAyRFJ/0MFs8+hhVCTUlAWvV117OZ+O2CRQDruqwaXwCD14NgZnWUFaUCPNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPMbjpoepCjtVQrazHo+mC2yYDSfmFPl1CVSulV6f40=;
 b=SHP8XYpq56UHVp5IfqUFBPz5ITsd3JKqHhnBRCqA75ZcF09KBCTUHLAczuFcf9mmgzMXhue+pa86Ixb99NhSy2kK/4sQmxV0lQnztbLeRc7Q4V1muDV1XuZezgBcwsQG0XV8Yp5GZz3lpRDYzt8LGy5SE4Qm6zjsvZESjtxWgt6qBIIU08YNR2XcU3uyW3TjqJVwsANA9+CjBwsJOTSo1xG4u9zmk0WYy+Tg4MC7JXhModYsDLzCVtRGOED6Qrp60uTZpKGvvGXL/Y4v8rtSz/DBIKv4GwMLOuGfbCm/zymrRtAP6eVLzTRzLFDFOodOHVNFNgHHHpJRIudW28iK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPMbjpoepCjtVQrazHo+mC2yYDSfmFPl1CVSulV6f40=;
 b=qSMI4XD3upt9BDwNvAXZYTfowJ77isRdi4REgXhZgfTLL2Vsa4OXyPiDXPWQc021YjyHOlx0ThzYbabpiurOJ41VGFW6dxvjCuJoFHni29rogbjo4OUSOmmGFDz3qli+kZAJ7+ctpZKQmcytuCSruygcyvFSVAnJE//YSyQR2yU=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AM4PR0302MB2674.eurprd03.prod.outlook.com (2603:10a6:200:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Fri, 10 Jun
 2022 21:40:00 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::4cae:10e4:dfe8:e111]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::4cae:10e4:dfe8:e111%7]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 21:40:00 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] kbuild: use a pipe rather than process substitution
Thread-Topic: [PATCH] kbuild: use a pipe rather than process substitution
Thread-Index: AQHYfRH1ryitWurVh0Sl5dfaKRFyRq1JKyCA
Date:   Fri, 10 Jun 2022 21:40:00 +0000
Message-ID: <20220610213959.bjrw6nrxaby2lb3g@bang-olufsen.dk>
References: <20220610213453.630304-1-alvin@pqrs.dk>
In-Reply-To: <20220610213453.630304-1-alvin@pqrs.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe763221-71a9-40f6-d786-08da4b29c573
x-ms-traffictypediagnostic: AM4PR0302MB2674:EE_
x-microsoft-antispam-prvs: <AM4PR0302MB26746B952B52E3760F74C6F883A69@AM4PR0302MB2674.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: muovx8ANwlXWmLFefw3B/iL6mDL7gp+nfNBw21e1mumqAu6sI7j6RayIAnDXPRehXD9/E2FanXTh55LAk/q5g8WEkLMjYBe6AAziu8QoKmcRPCoDaoKiGuMhTvmilyVd+abE1xNToHxEBsnUFhQm3HWG5AX6Ja7F2TkJriKje5YP5ihsNMWORj3idC9gRG/KhvucceKHcOjQzuZwQRL3bkiba48Ki41PeW84oCIV9y/GedQiVcMNHLCMkxg0V1MIEE/+0u05b7l4H74WOQhTRjFZhutpb55ZqV1ZQ0bDL+vE+I7eSRKGKHUW1sCS/VonEncMIc0b7OWA55lcbjvV6OYbFDp92GLMsj8fPNsXs5kndsWwFdvQcEvMZapznbSL0QYm+u/No8LYjJAbllT41tzdSniXefRV3H2Rd5TMAyyN3bch6KQQizCW0zBDVuuTltHbP1cM8lV68fRnIEvK6w+X8OqUZdl23CWj4CG4teUVMXUt0W0ua2N4QkjaFGOIl+ZgNPFm3F0sHjLNQ1GpkPlXWcykYwlUB5QbRYPWNv4gz4BSwzT50ulqzaUT+C6QSxOtNtG2VhGzXP5KPu+isz81/dmrZUm+cqg+u9rmhrTe5IFI3IMrFnDWxsbT81uzBphy8PuB6j4iqn42OTr4BCO8kDnUbtbWN+vfbf+tlJMrPReG9wiXyyniXRHnY2bs7ePRP6aMXUGGxQKEAWECI0OEXqlCsAmNfdgZcSUaQURJB8QhtcAsD1ouLN9dP5zk03RCPuzXVd2Y1+dTeu9FAHU3aB7FL5/3umosaj7tYJo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(508600001)(6916009)(38070700005)(186003)(966005)(6486002)(122000001)(54906003)(36756003)(1076003)(71200400001)(66446008)(66556008)(91956017)(66476007)(64756008)(76116006)(2616005)(4326008)(8676002)(85182001)(85202003)(66946007)(2906002)(86362001)(6506007)(8976002)(8936002)(316002)(5660300002)(66574015)(38100700002)(26005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG1pSjhqMUduTnlsUXoxN2hreXIxS1h0MHhjR1lQMnNseWQ0YWFzNEJVS0V5?=
 =?utf-8?B?WnV4UWYvV3JRMWpuekU2Q1VqSWVmSW5jeXBuR1k0UWJ3OEVJUlVNWHRvWjZU?=
 =?utf-8?B?SWZsL0VnMjRxOWZEUmpTckMzeTBBQVczekRGUnU0Y3Y3K0REVTM2Si8yNG52?=
 =?utf-8?B?VG5BR3BJenZGUVJhWWh5MytWaTJETVNKSWQ5Szh3T05LSG8wSFUyK0tqTURL?=
 =?utf-8?B?ZmQwcnB4UE9BanVWRTV6SGlob0JISnByRE5QYXZqOVNEelRQMmJKa3FneTVY?=
 =?utf-8?B?MGlCd3RiSkw2T1ZCSUpoLytkOEFzWEVSS1J3NmFuTWdjNFhZLzc4eU5hcGlP?=
 =?utf-8?B?Q1dkS0oyMmJxaDBJcFZqamNTeVV3bS9XdER4OEdXQ3RlNFhSVU1YMkhyL09u?=
 =?utf-8?B?S3FXR3V3NVZreTVQeStLWSs3dERHK1IzNHU3cUVSOVVoRW1nMFh3bGlsL0xi?=
 =?utf-8?B?Myt6YlcrTTkvdWJrL1pwdERsbGw4VnVqNFhDU29QRFhkdlhkZGJycE9nQWkv?=
 =?utf-8?B?c1FaczNKMVFIbW4yZUlBNWlKR0oySVBuMG5TUFRRM29GVHZVQm1iUERsRTZn?=
 =?utf-8?B?N1V5TnJxdlp3aTllbWZsdVBVTmtRQ1I3OU91d0pORXhRaWlVTTVoR05aR09W?=
 =?utf-8?B?TzBkWTBoRTJPL3NzY3hiaVJRQmtLU1QrY0lPbjdWaURINFNTNk1iUXBXV3pr?=
 =?utf-8?B?MU1oaUFUVWFlOVYyL0JPdEtkUENKSnVvODg1R2lqWjRHS3N1a2gwV3pkUFRX?=
 =?utf-8?B?aFhFdkgwNkJyQ081aUQ4YzllWDZ4L2ZNYzFZNS92bHRqVUtjbkdHaGNORWpN?=
 =?utf-8?B?ZjRhclNHTWxWTjhVVk9sWHJiR1FURlFIM3BkNXMzODVTVEo4ZUoyTnhPUG0x?=
 =?utf-8?B?aWQ5S1N1RGd2TkhndzVFRlhtU2ZZU2ZDSWF0UVgwQTNyQnozZTIzT21jN1N6?=
 =?utf-8?B?ZVgrdFo3djYrUW9YcTRHSzlUWlR4R0FwYW1SZFJ4TFJad3BsbjZwdHlMU0dU?=
 =?utf-8?B?Q28zU2Vld1duYkJDaDZpbjl2dmZnaVlIME5UaDg1Ty9UbjN0bG5VNkJkYnlS?=
 =?utf-8?B?NVpIVUErQ1V4M1JIR3RMNE13S2tJTndTU2VhWWpsZjlrUkx6VEYxVjZHWEw0?=
 =?utf-8?B?Z0YzS1VWc0tEbkZiNEs1YTIyUEptT1FEMmFxaXcvUjdxWUV0M2FCUUpvVXNy?=
 =?utf-8?B?bWVnNjFNa2tNZHdSNWV5R0RnSGhMV2NZbmVZN1R2QzJWNStoaUxlUlh0Qnp5?=
 =?utf-8?B?NjNlTkErdCsrbXYrWmMzcDNKMzltWUkyTXlSbUtFVjkvT3hQcXVBN3hSRmc3?=
 =?utf-8?B?a0gvdDVzVHlGTjNlK0QwZnNZMDBNaFB6NE1kMGhhdFhEM1E2VmdzK293bm1P?=
 =?utf-8?B?enIvaXBlZFNVU2I1eTAxSWZKMkNQVEU1V01OWmJHZWFFQUJjZWh0UDZUNjAx?=
 =?utf-8?B?YXpJN1RpdzRzOUswUDNQL283bXh6dEdjWUhWNDh2YUdYYXVUSHZsck51TmtB?=
 =?utf-8?B?eG9iN0xwVnhUcHRLTXQ2VTl1ZzM5TitWYk1ja1N0cE9vSFUwQkNndXdVNEZ2?=
 =?utf-8?B?bUtNbUsra1g0dFpKYUMvRXUvRWs2Zm1KU2lqb0FodkpjN2JaTnk1ZjdTOC9w?=
 =?utf-8?B?V0pVdGs3eHl3WWx0eEpkTWpsc2JYUFBmM0xuWEw3QVRjN0ovUkFacGg4UXdR?=
 =?utf-8?B?bWlXWnRvYTMrZ1NhWDN3b0JCMXBNSUUxR1VhbWx3YWduWUcvWXQzU2lvOWVt?=
 =?utf-8?B?N1J4NWVaNTJ2UnRXZTR1Q1FJTGttS3o2TVhqNlNJSEhiYWNXUThOUGJaR3pj?=
 =?utf-8?B?cllaMXZuQmFLU1BGTCtBb1h4bmQ3VU1tQmg4dk9OREtQbGdGN3d1Qmluc0dk?=
 =?utf-8?B?R20rMGdnQVBERDY5SjRlbGtzYnl1NXIrTDVSWmd6MzlYM0dXcXRPRWdqOHdB?=
 =?utf-8?B?UmkxY2NyUlF4cU1VR1M1SEVTZy9jR3l3RkpnYkxLZjZjU1VvS3BtMnF1UzA3?=
 =?utf-8?B?UUcxTkdQajhYQzBjSEZlLy9qZWk4T2xJRytTTEIvN2VGY1VNem5tVlRucFNv?=
 =?utf-8?B?WXRkYWVKQXBST2VCeW5xUFFaa3dSL0ZNMlJ6RDB2bkYxRCtpZ3hSVXplMkRx?=
 =?utf-8?B?cnFMSDIxdDJGVWcwNzNEQ3FKVy9qZTBDa2ZicUNDcGhnTks2UkR6d3dyU1I4?=
 =?utf-8?B?MHZlS2NmQStvd3RWSmwyNDVXK1NjMVNPaFlxbXlKUFQyWXhxdU8zRFd2dmN1?=
 =?utf-8?B?b0VsNThIKzlmT1lPTmJ6QjVrLzZBSitENEZYaEU2ZFVhWU1iZGg0bFp4QWVQ?=
 =?utf-8?B?b29LbEhnTVJWdGtvQWlLT20xNnY1Uy8xUVdxZUZWTW1kem1jRVN2WUQyTmhq?=
 =?utf-8?Q?mMc0QqF0D+u3VqEA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42FE50489D805649A4A02E983245B304@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe763221-71a9-40f6-d786-08da4b29c573
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 21:40:00.4479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCMGW18TIejEUl1Cnkfo9XtzTnj2e/sUyBilAdiuIa67X6xFNj8R4SwulaWv4hgtjv//mYc5KTQiaMfFK3o38w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0302MB2674
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdW4gMTAsIDIwMjIgYXQgMTE6MzQ6NTJQTSArMDIwMCwgQWx2aW4gxaBpcHJhZ2Eg
d3JvdGU6DQo+IEZyb206IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmctb2x1ZnNlbi5kaz4NCj4g
DQo+IEJhc2ggcHJvY2VzcyBzdWJzdGl0dXRpb24gb2YgdGhlIGZvcm0gYGZvbyA8IDwoYmFyKWAs
IGFzIGZvdW5kIGluDQo+IHNjcmlwdHMvY2hlY2stbG9jYWwtZXhwb3J0LCBjYW4gY2F1c2UgaXNz
dWVzIGluIGNocm9vdGVkIGVudmlyb25tZW50cw0KPiBhbmQgd2l0aCB0b29scyBzdWNoIGFzIHBz
ZXVkby4gVGhlIGJsYW1lZCBjb21taXQgc3RhcnRlZCB0byBjYXVzZSBidWlsZA0KPiBlcnJvcnMg
Zm9yIG1lIHdoZW4gdXNpbmcgdGhlIFlvY3RvIHByb2plY3QncyBkZXZzaGVsbCBlbnZpcm9ubWVu
dDsNCj4gZGV2c2hlbGwgdXNlcyBwc2V1ZG8gaW50ZXJuYWxseToNCj4gDQo+IC4uLi9zY3JpcHRz
L2NoZWNrLWxvY2FsLWV4cG9ydDogbGluZSA1MTogL2Rldi9mZC82MzogTm8gc3VjaCBmaWxlIG9y
IGRpcmVjdG9yeQ0KPiANCj4gUmVwbGFjZSB0aGUgcHJvY2VzcyBzdWJzdGl0dXRpb24gd2l0aCBh
IHNpbXBsZSBwaXBlIGludG8gdGhlIHdoaWxlIGxvb3AuDQo+IFRoaXMgaXMgZnVuY3Rpb25hbGx5
IGVxdWl2YWxlbnQgYW5kIG1vcmUgcG9ydGFibGUgdGhhbiB0aGUgZm9ybWVyLiBOb3RlDQo+IHRo
YXQgcGlwZWZhaWwgaXMgZW5hYmxlZCBzbyB0aGF0IHRoZSBzY3JpcHQgdGVybWluYXRlcyB3aGVu
ICR7Tk19IGZhaWxzLg0KPiANCj4gTGluazogaHR0cHM6Ly9idWd6aWxsYS55b2N0b3Byb2plY3Qu
b3JnL3Nob3dfYnVnLmNnaT9pZD0xMzI4OA0KPiBGaXhlczogMzFjYjUwYjU1OTBmICgia2J1aWxk
OiBjaGVjayBzdGF0aWMgRVhQT1JUX1NZTUJPTCogYnkgc2NyaXB0IGluc3RlYWQgb2YgbW9kcG9z
dCIpDQo+IFNpZ25lZC1vZmYtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmctb2x1ZnNlbi5k
az4NCg0KT29wcywgSSBmb3Jnb3QgdG8gY2hlY2sgdGhlIGxpbnV4LWtidWlsZCBsaXN0IGJlZm9y
ZSBzZW5kaW5nIHRoaXMgcGF0Y2guIEkgc2VlDQp0aGF0IGEgbW9yZSByb2J1c3QgcGF0Y2ggaGFz
IGJlZW4gcG9zdGVkIHdoaWNoIGFkZHJlc3NlcyBhIHNlcGFyYXRlIGlzc3VlLCBidXQNCndoaWNo
IGFsc28gc29sdmVzIHRoZSBpc3N1ZSBJIHdhcyB0cnlpbmcgdG8gYWRkcmVzczoNCg0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgta2J1aWxkLzIwMjIwNjA4MDExMTAwLjQ4NjczNS0xLW1h
c2FoaXJveUBrZXJuZWwub3JnL3Jhdw0KDQpQbGVhc2UgaWdub3JlIHRoaXMuIFRoYW5rcyENCg0K
S2luZCByZWdhcmRzLA0KQWx2aW4=
