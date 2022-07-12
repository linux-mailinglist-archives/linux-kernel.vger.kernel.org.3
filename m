Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C675714DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiGLIkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiGLIk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:40:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD582A5E4D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657615225; x=1689151225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jzc4ewTlgeR+Ok1ojXKiLd8czc0wgsfyT06ozRyCqPY=;
  b=XR/0QY7W5uCwJSGbEfriDxKJPInwOT/MrwYoTrykY/N6FQI3FEtLjusk
   IOJfhLTv1cGDu3mVRWxd49tpkGarKE676xmMTUJUt3GivUmSiRbuHc2iG
   zo5GUKgQeMmlRXxoaiaZ3vl1Rd7z7SNl0iAJPTotZcEZ4TNUyeBdXluW7
   uIFl17bFbFG2AMy//SwsDAZfUpG6kIeuQKPxH1wsp0mCx3VpkfXViY7Eq
   SL9UrjQqufa7PcJheHurV6sQUB5oXIyov2ePWq0qet73Dys7J945M7Tp2
   BN0kWT6CmBRml3EOK12y7VrCrDmz1zUR2X/SbXmY6QiHgNRk0HePj0Svz
   A==;
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="167422848"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2022 01:40:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Jul 2022 01:40:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 12 Jul 2022 01:40:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCGTw3uxdH2Rij8JnriyGJbylC/ZUHa2niu9+GuxT3veEbZ7kbnIK0eBVMTXkf4nRK1YphXVZ+3rKv6dPR1B8BtTQD1Wgl9fpmHfoHfgxZWo15NiqJs2hUk/p029eoHZuNdoPfYgDWx7NZIJ/9X6zIBNH72/q4eh7AIn9YydllseNAFXr1RALOOU9Q/417WHG7gLu3dLK32OjJaz0HzGgwHrkp787czpYy56rDf5lfzJUMl3oHpRKZ4e7pxdW/PbI6DT3384I5OAC0FffCadkuXfjgh+NyL9PTr+/BZHeStq6yt5z9dUZgrGbTCNFAM/Ge9IGETvqEwyzvtLvvcJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jzc4ewTlgeR+Ok1ojXKiLd8czc0wgsfyT06ozRyCqPY=;
 b=LEIwWlfChOP9yNmaT7wkKuHMnItHGB2MsG7bcYNDDN2g2rKCwmZ352StSAMfk0NuaxRNkNeBokz3jS9ECrDE54CVpP0WzQL6aoeqBJa3V/rCnRjx9SP1GkWrICgAiacrbW+c1iCVtD4AbxayvPBlVpEFl2y6XENXM7qkmfWGmoR+q5pW1UnsVROLLh0Xh5GCXrFSXZ+nhqFstHLwZHstbwslF/LEts5N/fP5dJWIXaEU2s59jn2Y1lC1/Q/TlJ8vOk15Qh0g5gFdJ8hkz3MVNxLG89+X0hkndkCTJD2tqZVAcjVTYax/nDhwYxNFE0C3ZICVfBudgCTmgxN6+KFaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jzc4ewTlgeR+Ok1ojXKiLd8czc0wgsfyT06ozRyCqPY=;
 b=n61tR0MyEVNJ0rncki39rJry14oHuRur5DlB5R8TlAmllhgvEwcRv6AsajlQBOUnvd38Be5M24ByAsPjhlTsfr34VOL8+G6MUyz9N8ULpsLb/t5lBEHNXPOoPBPbooBuNDg0YZyAOlIZWkd0qgS4lrhRO40kQ/sCrTf6wmLbNNU=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 BL0PR11MB3491.namprd11.prod.outlook.com (2603:10b6:208:33::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.21; Tue, 12 Jul 2022 08:40:23 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 08:40:23 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <quic_c_sbhanu@quicinc.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: winbond: use SNOR_ID3() for w25q512nwm
Thread-Topic: [PATCH 2/2] mtd: spi-nor: winbond: use SNOR_ID3() for w25q512nwm
Thread-Index: AQHYlcsGaT91mZeLa0CO/P6y+1cRGg==
Date:   Tue, 12 Jul 2022 08:40:23 +0000
Message-ID: <735a88af-c4f1-a6b3-3f85-ea532b3f39c7@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-3-michael@walle.cc>
In-Reply-To: <20220510140232.3519184-3-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01195290-c96f-4a74-0034-08da63e22938
x-ms-traffictypediagnostic: BL0PR11MB3491:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a3Ql263Zyzk+zjMCRhgUjSj8tqp/r9GYOxK8czyMHboMMbkTDZ0RG80VirJiLsLjjZnN1L5/NSxwxDmkG8TKlO+wK3g3UmvPM2wKkz8y/dWyY26KTqRL8eAD800lU+0BXF92f40NFE9wz+7bBEOZyDAlN7WPdn4OJr3i7v5p6NQ83kDX4qVGH+sXe4kPTtyKmXbyEXgQf7EBe0lHczqtXuFEEX/8NJcbYbWZCEf5oBgDYDOfh17yRZfhS8MWgFAtpKhgp6Epht4bzKRpx6ozQ0A6syiIohFJoMvGAOMOaPxT7mTtJ8vEEb29E+ZKCZAsfzmxrao6m+01BUlYm/VfHfMB9/aDYnKFRym5M3fVuqceLZiqCwWIV1jFEPNH3M+ltGlHxXoEWQyrDVi6G3wG6S0tv2Ha1baIJwxXTYQEtCj5pfD2XfDxELBFEo2EWiVQywv2iXsxvcGbCyiXF/7Sir7O906wCdaPN/0aNSI1FHKhR4gcvyZ4tzQIs38y+e0AR9A5Jt2OsVRP/wsxjNda5sDMIuFDacGdfbLt1nWdrY/GZxpPlgh0glr6b5qRYuRAg0YOFhNyiAJYket/cGQtj07eu7mQd/0Xzd/uT3K8QAnjvHdA0EXtTlW1U60EImfltC42DIYMXvhQR8KvlhoLyKHbJn+BZMsiXHs9epxk27RPrenMbRTuXOSUEAt2h2apgPmO82SPVLuPt0ot5rgwMWP5ujDBDdZdjQ0I0x+jB5O3HBKxs7lI9Qkpe9aIet9U6FPSA8tge/svsMnReO0e/1Izg20FlPWEQxDQfW0UCiRu1pYpPYstnjzQdZIQve5HlkHPiy797W188qKoedT+2xgw0VDvbQrK8+GexlUD/Mj084QVI80qUX28KuuwEHliG/U028mEhkdbw4wc2KvM/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(366004)(136003)(346002)(396003)(186003)(26005)(6512007)(2616005)(6506007)(38100700002)(4270600006)(31696002)(38070700005)(86362001)(122000001)(316002)(76116006)(478600001)(8936002)(558084003)(4326008)(2906002)(8676002)(64756008)(91956017)(66476007)(66556008)(5660300002)(66446008)(41300700001)(31686004)(71200400001)(66946007)(6486002)(54906003)(110136005)(36756003)(138113003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnJ6eHpoUE40M240MFFmcktFL2I4bW81KzU0TDNUdXc0cENNekZBYUs1d25u?=
 =?utf-8?B?ZkNlK1dRcHhvNVp0cms1dnZoVDY4T3ZaZDF1Y2xUK2VQNFF0VTdZbkVjRlJi?=
 =?utf-8?B?djJ1YmN1RVovZzE1S0VoQ0VBeUpYOU9GL2ROV0krRkRyaUQ1UnRMUEhLb3JW?=
 =?utf-8?B?d2haQzJtMm5seE1vQXFjdko1bHFpbm5KbWNLc0dGUEVwTy9Jd0Q5RkpRdXN6?=
 =?utf-8?B?Y0hWUGsyc25ua3dSZ1F3aHA3cjJ0Q0Z3Ty9aczNzLzViVFZRY2xwOXNPWUJN?=
 =?utf-8?B?SEozOXRZNjloSDRSS1VYTXB2ZDdtVHlONFo3ME05aXN4cnlMRFRNNmRRUHBT?=
 =?utf-8?B?cDA4VGN6SE52M3diTEJIWmxxbTBXUFYwQzJaMEw3R0R0RXhTcUcwYnZsc0lu?=
 =?utf-8?B?YlRCaDNXd0RMaVhYZTB4bEJsNlpDMVJxdEpEc1A5RGEya05mUE1sQ3VHanN3?=
 =?utf-8?B?VTlsTXZvd2JDTFpUa0djSUp0VVNYR3NPZy9aTlZSbElhSVpha2hkYzhzcDJE?=
 =?utf-8?B?d2lBd0NhbGFjc0lhN1V3SldHYk9vZWhaU0x1aHgyM2hCSkRxM3NEaUJDR0Zq?=
 =?utf-8?B?U3Frb3ozSG8vR3BWWkdqdGx4U00zNnRBalk0dmNwMjk2Zk91L2xnY0tzVldy?=
 =?utf-8?B?ZE9xa3JkL1lCYXdZT1ArWE0zclNlL1RRb3cxSnBQK0Q3MlRoeEZHUEZ4Q1VN?=
 =?utf-8?B?L1VvMmk0RDg4THVYcFlnd0NvR285V0dqUjBNRXlOaGE3TkNOUHZ0dE0wVlFM?=
 =?utf-8?B?NmErY2dLaVA2REJTd0ZHeFYzTWpXRncxR0ZyYmZBOU9GamdnUEpFNzVnSUhD?=
 =?utf-8?B?VU5XSEFBMmptenJHU1NTZU5GdWlQU0pjY2dScWRWaGd6R2tIUEJUbjZPRFVS?=
 =?utf-8?B?M2JFMnl3VXltOExJTGp2MHhpL2Z6cnFlRSs3dXlqanRreE1ZSmk5bGhBVzBx?=
 =?utf-8?B?UFo3WXY1anVFcVBvZUtXSWlGQkYrNktxK0FZS09uU29ZVW1VMUVkRkRtMU5G?=
 =?utf-8?B?eXNGcExQcmRScFVEL2NvWFV1UXZxMGg5cDFOZ1RiOEUwMU9NMHB1N216Q20z?=
 =?utf-8?B?bGJRbnVUaXB3dkY1ZkNsNkMyc2lPNGpkV21HbmZScTQ5RnY1emVZVWhZcGdR?=
 =?utf-8?B?NWZXeGNwY05UNm1xMGZhbFgrdEMraDRBZEtva3BRV0JKYzhoRHU1dm43N3pF?=
 =?utf-8?B?VnBPZ2g0Wk1yVE5NcGpGc2phNmdQTERYM1NjVzlzN1NneGgzdnFuRUMxcEZI?=
 =?utf-8?B?dDJ2NkUzdE9MZk9OQlRvYUU3ai9KVGx5dTB2VnJDRTdMQnJYZFNsMXp2U09P?=
 =?utf-8?B?QlNvdWMxakh2WjFaWC9FazdYWTdzb2xDMHRIc0phcys4MExEYUlyU3hGYnFL?=
 =?utf-8?B?eDNUMUpnZ2NLd0NqMU1KT001RzJVNzRnNEovTzE4eVltVmZEVkZoeVkzSjZG?=
 =?utf-8?B?Vk4wWHBpTllQVGREWWFVMHpvakxpdnY2ZUxFRHFKeW44cVJYRFZjZWVKOW8v?=
 =?utf-8?B?ZVg0STNoVFpYU1B6ckJDeVlha3N3TXBLT3ZRQmdMbjk5c1RUTDhMVmdsWUV6?=
 =?utf-8?B?OE1mcnB5RGJ4TkhrdmJzY3p5NG9xR3hCWFFzQ2hWWjh5UEJGbjI0ZncxVEtD?=
 =?utf-8?B?SnNVS2JzV2F0YkNlWFNNV21WV0ZoU0JQdW0xblNlSmVjeTRrQlROcGFTU1Ex?=
 =?utf-8?B?alA5Zk51ejNnY252a2xjcFVQZXBJRU5jQUw0WVBYMFVVWno5R1Q2aU1adExu?=
 =?utf-8?B?RHplOUhQN3Zialc5dG9RQ1JNckk1dCtRbW8zdTRTV05heFpEczJLeW9aY3Ba?=
 =?utf-8?B?REtOakIrS1duRTVGa0tDdGhNWkFoTW5YRXU3WldJNUFlTjFRNFpHVThDOGc5?=
 =?utf-8?B?ejJ4TzY1R1F3MWR2VWo5cXhidy9wYVNkL0ZCeGZUOE1SWUpHU1VRR2UwM1E1?=
 =?utf-8?B?cUg3STMxY25TWlc3RXVvR3pldnkzWGVKT2NFWmVtajNEdVJ0TFNnZ3h4cHI5?=
 =?utf-8?B?dmlHaGNaaVlVMXJyVGU3NjhCOWZMUlI4TW81SkpMTFZLZXhtVlNSZC9hM2JY?=
 =?utf-8?B?bE8zN1ZNTUJwQ3pCYnY2RVAvR2taWmNuNEhXRXlEdmNxVzVUaE0wNGp0djRB?=
 =?utf-8?B?N0FBWkRUcFQvZGQybWErUVY4dlBhOE5mbkR4YUtnWjV2aWxhdDAzVkpxRmlS?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71F20B8241781046B5590D4B28901E26@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01195290-c96f-4a74-0034-08da63e22938
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 08:40:23.1484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnZUy/TY2vuFZtEJLwvaMfmYRVsveWoWICx+gZoe2f7RTQYrDmavJfCbxU3xebtg15NgZGlqFZQGFfIx0gGr5trt0pCjBm9N9RM73v4VsK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3491
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2hhaWssIGNhbiB3ZSBoYXZlIHlvdXIgVGVzdGVkLWJ5IHRhZyBvbiB0aGlzPw0KDQpUaGFua3Ms
DQp0YQ0K
