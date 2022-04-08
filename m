Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F084F91FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiDHJ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbiDHJ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:28:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2132.outbound.protection.outlook.com [40.107.215.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A0322A294
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ9BH4jkVr5VoIbeJtE06PTV7LfOnSRm6/xosRC65yCeZEhW2osx2MXvq7BsAkvLbVq60a1DExFY5UT8+LFK5/TBCKBAMBijS1cax51biTfAzouR/I6WJkLtKy8HPB2Fi2ySEonLhhSH36A7oXlb1L+yFwjlOqeD/DAgacEKrqwOIO1zsoFt49YDRGojh5arz6loXQIoz6IDZ/4aqpdBsZwOgT5PmGE1ngNRhbHKdAOGCwdRFq/ztCB2bJo6/27V1YRgCFgVCuwf5Nnz9tevpX85NIxaJlizfIW+ePAg8Ijt4SplJyAGAjf/VcrahssQUdFCMLJTnZkKkuQTZ7y7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEeVLgu77RJHQQbeebN8oB5bLMEn68O6g62vyQJ093M=;
 b=E5+ewlTMYICtXdzV8QW91uM1EiTX+9Yw+UQcFeqn5SPQLBo9km360o520Mh+nfyOh2kCtOHBvjGn5srSdvRogW49IQPoxXgKLEmSLe7x62F/fLv3sHrq8ZlQh7Cvm9E1yTlgl/YP5PwcjlzR7qWGm9E9c64oDxSoHWSNdwoQVzVZZm91zqhXC7QiW7sJnfcRYO/kr1l5RoOAOuA0vfx8U5ZpQTq8JyGQFhtyBh/Zn5BMoojhWd+8dgN9Qgr+9pq0OA7aJc2GY8xsOCO6YnlHGrRamAHqZLEv5jfa8iQMn3BVtipovjFc5CcQeysQZRU8aD+V0JE8kvGS4wtNclOzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEeVLgu77RJHQQbeebN8oB5bLMEn68O6g62vyQJ093M=;
 b=DJ8oT0+4D3mKUQ70vNF315Lk6savmRFqLoT5QHr0nQK9D3F5jT7lXxNg3C7t3yVyqHhhujhKrZ9TF0q7vPRONHPCwn20TuGiOBc1ZYgNZk0YdwgCiz1rcf6E0BAFPoDqGeT/MrnYh7eUu4/4ul9dBQJrz5aOV2+y1jQtRKOFfBU=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by TYZPR06MB4366.apcprd06.prod.outlook.com (2603:1096:400:8e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 09:26:00 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5144.025; Fri, 8 Apr 2022
 09:26:00 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] arch_topology: support parsing cache topology from DT
Thread-Topic: [PATCH] arch_topology: support parsing cache topology from DT
Thread-Index: AQHYSZdCGkQ2mLDvVU6wfMdXkcz1WqziuauAgAEIO/KAAH/kAIABgBa5
Date:   Fri, 8 Apr 2022 09:25:59 +0000
Message-ID: <SL2PR06MB30820CCBE8F839B1ADD19DFCBDE99@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1649236680-4340-1-git-send-email-wangqing@vivo.com>
 <20220406110655.iimv6s4godvgfwoq@bogus>
 <SL2PR06MB3082F70F1F4CE661288103C1BDE69@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <20220407103022.fim3cvpnzfngyzkt@bogus>
In-Reply-To: <20220407103022.fim3cvpnzfngyzkt@bogus>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a20229e5-2e3c-4f54-0130-08da1941cb51
x-ms-traffictypediagnostic: TYZPR06MB4366:EE_
x-microsoft-antispam-prvs: <TYZPR06MB4366E223030B40ACCF2FCAF1BDE99@TYZPR06MB4366.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3GZxVja7+Rql3jWzAFcGelZZo5g13shu5caVas5Pzb1NhfokLse9P4g/SfxfDdifOqVcoJiR3ajHar9eZZp+Jlmm+XheTgFylx1F6jFKisHZKA6EclLab6ZTQPZcK42LnksOkQ37q+4vwqZ22yHO57OOD6Vmktlmnua9aKmC/YAVz4YEedpd682Bdkp44x3QXjsNbw2ejqFDAW2Vha0jj6+/0X+kLi384F5fcSRZnGkM35BJJJh6qPcc6nqNld6kx/E8yMvVPbvQZNWkn864b3NseZF6zuNqWOnaJzFqOEqrSajcYgGQ6AC9rjRqqIugc4qsXKfh7ZNJgq6IPb6pYM50pKbLVVLZWmypqpfs69FXiCib558MtGUhUPZRAyEIYy0eajNtCfmM6eQ3R/VyxEYXTuRcXIvP7d6mt3RVTJecgP1Ca1RtXMcHQqWWd9asrHpg+FQcT+fwxuYEDOhLYf8iHcNYsoGhAkVWX3E97v0ZYKjkKXrMIAf9xnRosErQkMyi3eUSz0Yd46dI71wTSDqvzjJvFNm3AC6mBwSiwhS3Eh7a4f+aXrNqnKoKhvPBpeUgGQnpeGrHBZT0VhPB49BxLRQs6Cgj40e2mHmp/3ph5U1jqtMVqCGMctNJsRCkwMrHSfAxbhLP5CfwK4o4qDfNbXfkK6kmugN/cqpzL8As0Ne5GGFUMKLVDiKUgytjXjQHDE1xIB/CN/1IGgwugQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(76116006)(8676002)(64756008)(4326008)(8936002)(9686003)(66476007)(66446008)(55016003)(5660300002)(83380400001)(66556008)(91956017)(33656002)(2906002)(7696005)(122000001)(38070700005)(38100700002)(6506007)(54906003)(71200400001)(85182001)(6916009)(52536014)(86362001)(316002)(26005)(186003)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2tLOHRRbUhPZWl6bC9lblA3WU56UUNEWTFZQzN3ZVhPRG5zS0VDK241MHFy?=
 =?utf-8?B?L3RDTy9TWGc4MzZmcW03eGFVZG16Mm50ZkNMTjV0Mys1aDdYbE9SbDM2YjBG?=
 =?utf-8?B?Q0R0TjlyNTFrM2lUTmpjbWNmZkxhekhwQXArRmU5RXY2NUI1bFZ1bDJ5Mjc3?=
 =?utf-8?B?WkJZQmU5bXBiL2Z3dThvN3FOTDdzazVXTmtGMEtHN2htNDUwUHRPVjgrOHF3?=
 =?utf-8?B?dm0vUGNRL2E4T0Yydm9tM1B4Z3M5bE4xeDZqNlhKSDI2Qk03ZFlEcEpMOHB0?=
 =?utf-8?B?VHMzeGZLVStEVEh3Y1FwVkV4cm9kMDl3SEE0Ulo1THZRRCtpUVRuRU11UnJt?=
 =?utf-8?B?Q3Q5VmtvZkxlY2hxZS9pNGhSUGt1ZjhVa0dpMWdnZk40Rm0xMVhoV3VlNFVX?=
 =?utf-8?B?ZVAvR0pqMVprU3dJRERONUJjTjYxTmFTM2R6TmMrYnlaSTNmVVZjelMxWnYr?=
 =?utf-8?B?R29vYzZMVnZ4UE1USEVKUVdEbnBzOXZTTmVSSm9NaGlmRmh1YWpURFIyOGpn?=
 =?utf-8?B?SHRFVTRwVy9YYkdURzRULzlGSy9sMTdvejlMclpVTGZYS0FIdWY4RG1WVFJj?=
 =?utf-8?B?Ylh5NkFZSldkQlhJV1A0QmhOUCtRV3JFRVdURVorU0pzK3h5TzcxL1RFZ01K?=
 =?utf-8?B?VWZ1RVdMUkoyRDZDcWNYZ0d6eFpWNkxQT2N6QW5TUkszelQ1K0QrTnF2TnpM?=
 =?utf-8?B?cFMxVDQ3R3lxQWE5amlYSEJydUI1b2pOTVRJOW9Yam5IU3V6U2Y0MGVWa1RI?=
 =?utf-8?B?QjlmR1BWeGFKSjBDWEVOZ1Zqa3BKNDZGUDF3N3dBb3B3YUdxWnB1QzlyV1h4?=
 =?utf-8?B?U0Joemc0alRFNXN2MzZnMXlhMkd3Rkc0U1RnZStWd1VZYjlDRGdxMWFLaHZY?=
 =?utf-8?B?cjBjNHF6TktRcmJkenJtUG5qR082Q0ExMk1DVGJ1N1d4Sis4N00yajBHOS90?=
 =?utf-8?B?bkx6TEtjMkFoR2VJTVV4Qnp0UTRwWFU2bGt4TklVY3ZMMU9YMUluMnpGT21k?=
 =?utf-8?B?TzRsbkpEbC8wSEtOWGY4OTZNQzJHeGgybXJyQ0VENnJnclM5Y28yUENLdUF1?=
 =?utf-8?B?NFBtNzdudDMrV05HVHYrUjVjVWhrd1RmczhyM1o0N09iSkJadElmWXgrS2dR?=
 =?utf-8?B?ZnlCbFdkYTNuY0VPdWw3dHdmZmJZSkVCdUFzUFp6N2ZIblVVbkEvSVZTczVR?=
 =?utf-8?B?OTdNaFVYbGtkZHo3dDAwblEvTlVDcFRKYzMwcU5PL054YUpWVCtMNmZKMjFY?=
 =?utf-8?B?QnUrczY0WkVZVUUrVktmd0J4R2lrTTBMcG80THlBWG43UEovcXFZdXYvRk1z?=
 =?utf-8?B?ZEo1SnE5K0lrUEhxS21zZXdKSWRzRTRkcWhHQ2owVVRob0k2SFFhbG9YVHlL?=
 =?utf-8?B?NU9WbzBQVzdjeHh3Sm1ZUGN1WlR0bjgzYlFzSXpWUDFxM3YyaEVWQzh0cCsx?=
 =?utf-8?B?TWFKQ0crMnUrUk56RWhGMmVPYVk2OS94ZTRzZTNBYjRtUStvdXlLcW5QdlAv?=
 =?utf-8?B?cXA3MXlqQWV6S2lnNHRhSklDZDVrWVVxRHdoWlNKZ1FUdTZ3cDFyN2hGUnRY?=
 =?utf-8?B?RjF4M24weXBGc21UREJaOXVTWlB4dnI3UG9FZU9LU3J1dm02Tys2L0cyM1Vi?=
 =?utf-8?B?M1ZjTHl2RmxaZGJ0T3lsdSsxcGlMTHdLZG5JUWRMVEdsL2pTbWp0RWNFZUFy?=
 =?utf-8?B?ZFZHRFE1U1hxUGF6M3RjNVpnSWVGakVXS2ZwTTBUUHRjVW9vcU5sRXgyYWln?=
 =?utf-8?B?bTE4QVZodHl6c3k2VmdTek5ydndWaDFZLzZ4eUpXeGVvdE9LMmJ5RmVvdXV2?=
 =?utf-8?B?SjJUeUpyLzZ4dEVBRjZVNlBiblJWZDFjVk5tZnl4bWtTUTJ6eGs4b0JLQ2V1?=
 =?utf-8?B?a1lGZ1JXSzZvVmtkVXY0OWJXODZ6U1I0MVZON0lIMFU1SDFOMEY4UEU3ZFVJ?=
 =?utf-8?B?ZG56YTFQYzlPODZJblg0Zjg0R0hxd1hyejArcUxQSWpMMVEvWTVWejZON1VC?=
 =?utf-8?B?N1BsWEJPQUQvUlFsMElUVjhFMmdkYVg0TXdtdGZwTFlnQWFsRE9QQTl4eFV2?=
 =?utf-8?B?c0s3aUxvaXlHbTJPT25VQ3REQXdqMFF0cEx2clBSd0thOGNXdFZQeHJPN1RQ?=
 =?utf-8?B?LzVabG5XY1MvMEE0OStaM1dXbXlIRlc1WTZkZnJjcjZ1RHJSbkUrdVhYUWRU?=
 =?utf-8?B?OXh5K1ZDaGIvTm1BRDY0SEN0WXZaOUtIMXRRR0xPVTh6cUpDWTVQV0hSVnZJ?=
 =?utf-8?B?UE9oWXRuNTBxa0FsUG1jZE9SODJ4R1lwVjBISW16WDdmbUZORC9wSkpIUUZN?=
 =?utf-8?Q?9eAHS7SVJ1P5O1rpIv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20229e5-2e3c-4f54-0130-08da1941cb51
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 09:25:59.3811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KijO8PhQJfzsfP1a+S162ktj5520d7W2szsgVVGKAmJ6FEnnCpUlWMEddG/TQK8keQb2v/vLC4OCxV732gf8Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4366
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IAo+PiA+PiBGcm9tOiB3YW5ncWluZyA8MTExMTI4OTZAYmJrdGVsLmNvbT4KPj4gPj4gCj4+
ID4+IFdoZW4gQUNQSSBpcyBub3QgZW5hYmxlZCwgd2UgY2FuIHBhcnNlIGNhY2hlIHRvcG9sb3B5
IGZyb20gRFQ6Cj4+ID4+ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1MDogY3B1QDAwMCB7
Cj4+ID4+ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5leHQtbGV2
ZWwtY2FjaGUgPSA8JkwyXzE+Owo+PiA+PiAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBMMl8xOiBsMi1jYWNoZSB7Cj4+ID4+ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAiY2FjaGUi
Owo+PiA+PiAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbmV4dC1sZXZlbC1jYWNoZSA9IDwmTDNfMT47Cj4+ID4+ICrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPj4gPj4gKsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTDNfMTogbDMtY2FjaGUgewo+PiA+PiAqwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRp
YmxlID0gImNhY2hlIjsKPj4gPj4gKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9Owo+PiA+PiAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4+ID4+ICoKPj4g
Pj4gKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjcHUxOiBjcHVAMDAxIHsKPj4gPj4gKsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV4dC1sZXZlbC1jYWNoZSA9IDwm
TDJfMT47Cj4+ID4+ICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPj4gPj4gKsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjcHUyOiBjcHVAMDAyIHsKPj4gPj4gKsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTDJfMjogbDItY2FjaGUgewo+PiA+PiAqwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRp
YmxlID0gImNhY2hlIjsKPj4gPj4gKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5leHQtbGV2ZWwtY2FjaGUgPSA8JkwzXzE+Owo+PiA+PiAq
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+PiA+PiAqwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4+ID4+ICoKPj4gPj4gKsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjcHUzOiBjcHVAMDAzIHsKPj4gPj4gKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbmV4dC1sZXZlbC1jYWNoZSA9IDwmTDJfMj47Cj4+ID4+ICrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfTsKPj4gPj4gY2FjaGVfdG9wb2xvZ3kgaG9sZCB0aGUgcG9pbnRlciBk
ZXNjcmliaW5nICJuZXh0LWxldmVsLWNhY2hlIiwgCj4+ID4+IGl0IGNhbiBkZXNjcmliZSB0aGUg
Y2FjaGUgdG9wb2xvZ3kgb2YgZXZlcnkgbGV2ZWwuCj4+ID4+IAo+PiA+PiBFeHBhbmQgdGhlIHVz
ZSBvZiBsbGNfc2libGluZyB3aGVuIEFDUEkgaXMgbm90IGVuYWJsZWQuCj4+ID4+Cj4+ID4KPj4g
PllvdSBzZWVtIHRvIGhhdmUgcG9zdGVkIHRoaXMgcGF0Y2ggYXMgcGFydCBvZiB0aGUgc2VyaWVz
IGZpcnN0LiBPbmUgcGF0Y2gKPj4gPndhcyByZWplY3RlZCBhbmQgdGhlbiB5b3UgcG9zdCB0aGlz
IHdpdGhvdXQgYW55IGhpc3RvcnkuIEl0IGNvbmZ1c2VzIGlmIHlvdQo+PiA+ZG9uJ3QgcHJvdmlk
ZSBhbGwgdGhlIGJhY2tncm91bmQvaGlzdG9yeS4KPj4KPj4gWWVzLCB0aGUgc2VyaWVzIGNvbnRh
aW5zIHNldmVyYWwgcGFydHMsIHRoZSBzY2hlZF9kb21haW4gcGFydCB3YXMgcmVqZWN0ZWQKPj4g
dGVtcG9yYXJ5LiBCdXQgaXQgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCB0aGlzIHBhdGNoLCB0aGF0
J3Mgd2h5IEkgdG9vayBpdCBhcGFydC4KPgo+VGhhdCdzIG5vdCBjb3JyZWN0IGlmIHlvdSBwbGFu
IHRvIHVzZSBpdCB0aGVyZS4gQ3VycmVudGx5IG5vIHVzZXJzIHNvIG5vIG5lZWQKPnRvIGFkZC4K
Pgo+PiBUaGUgYmFja2dyb3VuZCBkb2Vzbid0IG1hdHRlciwgbGV0J3MgZm9jdXMgb24gdGhpcyBw
YXRjaCBpdHNlbGYuCj4+Cj4KPkl0IGRlcGVuZHMsIHNvbWUgcGVvcGxlIG1pZ2h0IGZpbmQgaXQg
dXNlZnVsLCBzbyBiZXR0ZXIgdG8gcHJvdmlkZSBpdC4KPk9uZSBjYW4gaWdub3JlIGlmIHRoYXQg
aXMgbm90IG5lZWRlZCBvciBpZiB0aGV5IGFyZSBhbHJlYWR5IGF3YXJlLgo+CgpJIHNlZS4KCj4+
ID4KPj4gPkhhdmluZyBzYWlkIHRoYXQsIE5BQ0sgZm9yIHRoaXMgcGF0Y2ggYXMgaXQgc3RhbmRz
LiBXZSBoYXZlCj4+ID5kcml2ZXJzL2Jhc2UvY2FjaGVpbmZvLmMgd2hpY2ggaGFzIGFsbCB0aGUg
cGFyc2luZyBvZiBjYWNoZSBpbmZvcm1hdGlvbi4KPj4gPklJUkMgd2UgYWxyZWFkeSBjb25zaWRl
ciBMTEMgYnV0IGhpZ2hsaWdodCBpZiBhbnl0aGluZyBpcyBwYXJ0aWN1bGFybHkKPj4gPm1pc3Np
bmcuIEkgYW0gdW5hYmxlIHRvIGZvbGxvdy91bmRlcnN0YW5kIHdpdGggeW91IGNvbW1pdCBtZXNz
YWdlLiAKPj4gCj4+IGNhY2hlaW5mby5jIGp1c3QgZGVzY3JpYmVzIHRoZSBwcm9wZXJ0aWVzIG9m
IHRoZSBjYWNoZSwgSXQgY2FuJ3QgZGVzY3JpYmUKPj4gdGhlIGNhY2hlIHRvcG9sb2d5LCBzb21l
IGxpa2UgY3B1aW5mbyBhbmQgY3B1IHRvcG9sb2d5Lgo+PiAKPgo+Tm90IDEwMCUgY29ycmVjdC4g
V2UgZG8gaGF2ZSBpbmZvIGFib3V0IHNoYXJpbmcgdGhlcmUuCj4KPj4gbGxjX3NpYmxpbmcgaXMg
bm90IHVzZWQgYXQgYWxsIGlmIEFDUEkgaXMgbm90IGVuYWJsZWQsIGJlY2F1c2UgbGxjX2lkCj4+
IGFsd2F5cyBiZSAtMSwgYW5kIGNwdV9jb3JlZ3JvdXBfbWFzaygpIGFsd2F5cyByZXR1cm4gdGhl
IGNvcmVfc2libGluZy4KPj4KPgo+WW91IGNhbiB1c2Ugb2ZfZmluZF9sYXN0X2xldmVsX2NhY2hl
IG9yIHNvbWV0aGluZyBzaW1pbGFyIGFuZCByZW1vdmUgbG9hZAo+b2YgZHVwbGljYXRlZCBjb2Rl
IHlvdSBoYXZlIGluIHRoaXMgcGF0Y2guCgpGaXJzdCBjb3JyZWN0IG15IHByZXZpb3VzIG1pc3Rh
a2VzLCB3ZSBjb3VsZCBoYXZlIG9idGFpbmVkIGNhY2hlIHRvcG9sb2d5CnRocm91Z2ggZ2V0X2Nw
dV9jYWNoZWluZm8oY3B1KS0+aW5mb19saXN0ICsgaW5kZXgsIGJ1dCBpdHMgaW5pdGlhbGl6YXRp
b24gCmlzIGFmdGVyIHNtcCBjcHVtYXNrIGFuZCBsbGMgY29uZmlndXJhdGlvbi4KCkNhbiB3ZSB0
YWtlIGRldGVjdF9jYWNoZV9hdHRyaWJ1dGVzKCkgYmVmb3JlIHNtcCBwcmVwYXJlLCBvciBwdXQg
aXQgaW4gCnBhcnNlX2R0X3RvcG9sb2d5KCk/Cgo+Cj4+IFdoeSBub3QgZ2V0IHRoZSBjYWNoZSB0
b3BvbG9neSBmcm9tIERUIGlmIHRoZSBhcmNoIHN1cHBvcnQgR0VORVJJQ19BUkNIX1RPUE9MT0dZ
Lgo+Pgo+Cj5TdXJlIGJ1dCBpZiB0aGUgaW50ZW5kZWQgdXNlIGlzIGZvciBzY2hlZHVsZXIsIHBs
ZWFzZSBpbmNsdWRlIHJlbGV2YW50IHBlb3BsZQo+YXMgdGhlcmUgYXJlIHF1aXRlIGEgZmV3IHRo
cmVhZHMgYXJvdW5kIHRoZSB0b3BpYyByZWNlbnRseSBhbmQgZGlzaW50ZWdyYXRpbmcKPmFuZCB0
aHJvd2luZyBwYXRjaGVzIGF0IHJhbmRvbSB3aXRoIGRpZmZlcmVudCBzZXQgb2YgcGVvcGxlIGlz
IG5vdCBnb2luZyB0bwo+aGVscCBtYWtlIHByb2dyZXNzLiBJZiB0aGlzIGlzIGludGVuZGVkIGZv
ciBBcm02NCBwbGF0Zm9ybXMsIEkgc3VnZ2VzdCB0bwo+a2VlcCB0aGVzZSAyIGluIHRoZSBsb29w
IGFzIHRoZXkgYXJlIGZvbGxvd2luZyBmZXcgb3RoZXIgdGhyZWFkcyBhbmQgZ2l2ZXMKPnRoZW0g
ZnVsbCBwaWN0dXJlIG9mIGludGVuZGVkIHVzZS1jYXNlLgo+Cj5WaW5jZW50IEd1aXR0b3QgPHZp
bmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPgo+RGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dl
bWFubkBhcm0uY29tPgo+CgpJIHdpbGwgZG8gaXQgaWYgbmVjZXNzYXJ5LgoKVGhhbmtzLApXYW5n
Cgo+LS0KPlJlZ2FyZHMsCnNjaGVkX2RvbWFpbl9mbGFnc19m
