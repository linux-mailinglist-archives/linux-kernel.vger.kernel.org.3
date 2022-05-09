Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B553051FA9F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiEIK77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiEIK7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:59:55 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CF22173F8;
        Mon,  9 May 2022 03:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yrp5tsm/x0YrbQXrDvgqMlF+o8g1FYOi/N1uPXELA+LEu3qpy0x8cUcm1v+MBjK5j7zkgaetnNYrV14+hOub90iqcuzapTIlcCkguQ2EliNW9m07QpLF2pr4k4mzYMQLW3h/JrWOZm3QvXD3xMunLIsDF5WW0SlLPsoHasMcNlUyNYudBEutQ2LOJPOSwBqkQPa1jbhaChq8XvKl1jUiFTUWjmR81vbTIE58JVaGYI9kfCBuiP6xfgLNQ2CJhGp4Ok2u/3Vi3O1F0zy1+D9NvbmFJyV61rKLeNKyrrl5bkA5YAuGZfBu6uBUFJfsEI8YPXtwQqO+hY9qGTyyRi6fFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFtV67VykNc12lZx7hajiq9Uy7CEhZL6HphOiHUPSsc=;
 b=J/0c0CWox0YRTpuD3taPxjaVIylgi9YrlYXq6DYQeLtju5yT7Up/8hTEW3APlVPYdkCWSsySS6ke3DD6u323nrWqy6ciB8vemJkZxa+J8/lHf8CVt9SGfB0Ama2C7RmW2Hje2LWW1PGIWZzWp5krk8otVS25WFXBcsoELZhXph/1XFGmTscBa0zKk5rLUfz0WyE6oK1FCYhbK1+0OPGWtWndSMreSuOz6tCnibis1dOhlFw1dxErTvtCOnlGQLqBkuy7iYHR7GFA8B4C+t2szjsbUC/bZXz9ixaaxvr6k/Bv+sSCY6n8AXmOxM4kCniuxNZELwdcqU9fx4DNjo9Oxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFtV67VykNc12lZx7hajiq9Uy7CEhZL6HphOiHUPSsc=;
 b=ATbU4PBx+xtVZL3QPPYbeqQAouuQRbVVm+qpnSu1vQjYsriiAJvMebdMK0GyKXv6nimfcLryb3PdUEg3+XLdOO9WVw2XPJOmm/HZ7emb5D791sg8PAXQFGPH+sJvfaG7TTxYKeFXiTVlP6xry7Uwghiuz01MMWtJZtahSft3hHQ=
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by AM0PR04MB6849.eurprd04.prod.outlook.com (2603:10a6:208:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 10:55:55 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1d57:4a64:1c30:a00f]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::1d57:4a64:1c30:a00f%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 10:55:54 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: RE: [PATCH V4 2/4] arm64: dts: freescale: Add i.MX93 dtsi support
Thread-Topic: [PATCH V4 2/4] arm64: dts: freescale: Add i.MX93 dtsi support
Thread-Index: AQHYY3ZAnsd0LQ+2IkiQYjiA8y8Qtq0WX5DA
Date:   Mon, 9 May 2022 10:55:54 +0000
Message-ID: <DB9PR04MB847725ABC0A4A0CAE3D5319880C69@DB9PR04MB8477.eurprd04.prod.outlook.com>
References: <20220509072911.3268668-1-peng.fan@oss.nxp.com>
 <20220509072911.3268668-3-peng.fan@oss.nxp.com>
In-Reply-To: <20220509072911.3268668-3-peng.fan@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d36fd27-b51b-49b3-92f8-08da31aa7dae
x-ms-traffictypediagnostic: AM0PR04MB6849:EE_
x-microsoft-antispam-prvs: <AM0PR04MB6849C584CA97ACEA310B4DDC80C69@AM0PR04MB6849.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YSuCJ78d0aGTtXky7x6ww1zABjTXZ1svNGkHjzT3zZMVS0kI0OmkV5bUiJpavqlmEi6vYrfHQw/0Su9LqJVt6/iq1jNaHcGQRszZ0Kh+uUulZcAUo9xNA4UTOs55H7LetqffgJYTQ9rqBXT/cIb3iE8J9Txhe8SDVGpMz7lIzeu3qLx+07ms8chWzp9wOY3ryLniHYr9Bx6ZwBzRyJLGvhE4b23tflqbq7vxH+xKAQ7VxiKNUNhBbsWGN/EAPa+mp1vtBHbcXAobxsp9nx2NVzgdVGMi3C4o24hhZnILxNI9rB6CWW79F2oZl2zEUMtxiqSwa/Uuzp41WXRz5zJV5gs5edSSAmbLipsh4aX1mQneP8xIulGxiMDB89inAiPyvoJ3RIl3hXG+GM2xDyzEwGw/v1mMzmDIkRS9vC4NBsU9ZNoslEYH42RBpAWMTUWKHNIJ3wOsJAjkMkOrVmRkgqfvTLIzaYqf6zlvUemCZdccHsqkmYjhvv/3Dmh8btQ21irsPVZukStrx670vAPmrnoBvQq/AmDWqzW1yuTtdNrdvSdzs+K8qwvOYHlgxSMEUBVsMm3iQXCVfh32682F0Q7bZOKy+CRMNgYjr4LC/9l/SsmQvP3GeDEHKVbJNXQlVaWWqxjpI0wgMgBPA0EjbhwKcmeG2F2jheccoULUoL2MWq/QOMehcfOpj0BJu5gq9Kk9vc+6bl2OVNMuv4wmeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(8936002)(55016003)(7416002)(44832011)(4744005)(33656002)(52536014)(5660300002)(66476007)(64756008)(8676002)(66946007)(66556008)(66446008)(4326008)(76116006)(54906003)(38070700005)(38100700002)(86362001)(186003)(110136005)(9686003)(26005)(6506007)(7696005)(122000001)(316002)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emhqdnpnMW1HWjlMQVoyazUyR09zbE1RRkJWajJqQVVZYzc0NkFXaityRTIy?=
 =?utf-8?B?VzQzWTNrbUErK0lEbmFXTjlhUlRzU2NuUTBmYk5WV3k1TjVLWUNzdDZuV3Mv?=
 =?utf-8?B?MGdnd1NZR0kvQ29wUUh3U1EyNXFNcnkrRWFvSm9QdDBhajR2NXNVN092ZWRp?=
 =?utf-8?B?WFFJNTFPeDhjdW5PR3AyTnhmRU9LOXpLbGJvNDF0L2Y1ZzBWcjJWcFZTU1Ir?=
 =?utf-8?B?VllxYkhxa3o0RW1NUTU4Rzg1UVRHQlMvdXQxV2VRWXc3eFBSa2lLbkI3RjBP?=
 =?utf-8?B?RjIwQlVhVWZpWXRNcXBTZjFCMkhkdExZb1lONnA4Zk9TdTU5ZmdXbElPSy9i?=
 =?utf-8?B?aVZtYmNwQ05JNzJ3TDNZVU0zN1FnNHBrTnZBYkprUzZnc1BaREx2eUt1S3Q5?=
 =?utf-8?B?SVFBSEYxaDlhcmFheU1qUlc3bXNFb21JNlBLcEZqWVMwWnZwVk1TTTRRbVB5?=
 =?utf-8?B?M21SMVBaYXZOTGJkOEx1cFR6V0N4UmFOOU1tdVlOTW1ja3FPYndQZWlMWjEr?=
 =?utf-8?B?UEJyKzBmeTErN0orTzhsVkVIUWFuZ3FPN1B1MnZvNHUwbFFDTGg3R1FYYU9j?=
 =?utf-8?B?ZVRlM2tkNldFVW9OWC9pSk5MYmhSSkpkK2krUU5zaFZGY2ZPWTFvL2NxK3ZK?=
 =?utf-8?B?c0NZQkJUcldNQXRKZlZpQ1hmaFBKQmhmRUpDdUNPRHZFUTF5dDJ3dGdYOEJm?=
 =?utf-8?B?VTROMEcyNnd1YzAzemhvWVhCZ29jbkhhdSs4cjg3RzV1cDFBbjVOYm1zYmZY?=
 =?utf-8?B?RDJlYml0ZldycFdpaDVaOHNPTW5HSjdpNzV6ZG42K1VVc1J0aHlFNnZPTzJK?=
 =?utf-8?B?MGVGUlBkYUxGTDIyZ3FTUStaUzBvc3gzVDU3aFhQb2hPM0tPaW1rZGZRVktY?=
 =?utf-8?B?RFF4eDNWL2FCbTE5RXJSRCsvR25XKzB2WitXV0hZWFJETWk3TlJwVEdOUks2?=
 =?utf-8?B?Z213b0tBNG1yZkk4NTJtaXhaTTBQM2owdjZ1VUZBdDliWFhWWTVZcHVlWUJx?=
 =?utf-8?B?Z0tSaWcwMlk1VCtsZlozRzQvVS9uTzY0bmpMM1cvUXZ1WEtENU9Gci9oUlgw?=
 =?utf-8?B?MGQyUjNkcTBwdXRkT1JTMWNKRHJaeTB3MXhJOEttU0xOQkwrOEdFL041VUpp?=
 =?utf-8?B?bmxrdU1rVVowRlM3bW1pN0lBTkF2NGtPUFBjL0wwU21RYU5BMjJWeXJ5cWFr?=
 =?utf-8?B?bHF4OEwzS2M5NEl3ZzN4K3hqd0VVU3BIUmxkS3BlZlh0TDdRcU5rWlFKajh2?=
 =?utf-8?B?bXNxOVBKVjlRTlh0VGpZVjNrVHp4bzh2bWRmU05LQUhUSE9kUEVLVWxSMzAw?=
 =?utf-8?B?NS94U2ZOVmpCVDZjT0RhSlF2bHhJbmE2aVczbUtNK2Izb1BUY0pkUlJqaEdr?=
 =?utf-8?B?UTlJcXk3ZW42R0xRS2hjTFNCKzFra0R1Y2Nqbldhc3l6Yk5ycVNKV3dTRlhp?=
 =?utf-8?B?dmpGRjBnajVjeXppRExOWkJNS2ZKOFZqZFl6VEZBYW1CK21hT3ZzcW9ZMVZI?=
 =?utf-8?B?QWkvQVVFbWx1b0QwbHJab3I0eHl4WFVPUDNNa3hjMk9pVStMNHZLNER0aTB5?=
 =?utf-8?B?dW1jVStOV0V0Q2thNXY4Y1FjWWZ1cmFtRC8wOGZhTzgxa3lJdHFBMG5tU2ls?=
 =?utf-8?B?YlpPalptMTVJQU5KTmF5Nkh4WGdoZjkyTGdHOXhPc1U0ejhzSTZPcTdhVFI2?=
 =?utf-8?B?UGd4cFZ2NGJucy9xTWt1dnZnamhYU0lkSUY3UzZDWDQ1MVA0MUxWUlpZR0lk?=
 =?utf-8?B?MEtxSU5sY3VYcWY4UFFxWTZ6dkpsNXhuS1FVa25DUkZHMEZYdUhsRC9nN09z?=
 =?utf-8?B?TFg2alRncTREZ1lRUnExcnc0ejgzZVNPWGZBdkpsWm5pdC9BZGpLSGFKdzNS?=
 =?utf-8?B?SldPbGZXdXVGNGVEdVRxSDkyemI1VDdGVlYrRSt3YS9OOFJ2WkQvaTJMQ2hL?=
 =?utf-8?B?a2Z0TlFmMzNVeTJhM1VRRk1FSTlyMGpPb3d5aWNoSWhBaCtjUTFnNWZSOEll?=
 =?utf-8?B?S3NtcmlSaldRT09XQXcrYlhJVzQ2MkxsNWsrRmJFeEovOHk2S0FJWDNqM2JG?=
 =?utf-8?B?a2MwSGFUSElTbVQ0Rkg1WXlUUy95TkdNTjVaUDcrbkdxaDQwcFVpOFFWQUVO?=
 =?utf-8?B?ZGgyelQvUDNUcTNBSmIzdXRZRU9xaTJ6dWUyOEdMaXNlK3lYcEVOa2l6eHYw?=
 =?utf-8?B?Z3diWTh4YmZmZFZETy83K3VSMzhwUW9OckF5WkJhSUtFQjhONW9ON0VzRCtz?=
 =?utf-8?B?ZSsxVE5HbnpVbkNqUnF2eG1BMERiVDNPNXB4RzdJS1ZuSWl2N3l2VVVPVld6?=
 =?utf-8?B?UGdUMklvYSsrVENCdGdlUXdrcjhaSkhBU2pyUStIelRrRWdEK3Nvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d36fd27-b51b-49b3-92f8-08da31aa7dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 10:55:54.8984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3YQ+vbDobNam5VDvtSenL6BUhcDF0iOKzYpGJnH+0d9S7v0XhW7xC9AT4ZamfJLRC/iwlTZKwZGJTtxqfGr7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6849
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IFNlbnQ6IE1v
bmRheSwgTWF5IDksIDIwMjIgMzoyOSBQTQ0KPiANCj4gVGhlIGkuTVggOTMgYXBwbGljYXRpb25z
IHByb2Nlc3NvcnMgYXJlIHRoZSBmaXJzdCBpbiB0aGUgaS5NWCBwb3J0Zm9saW8NCj4gdG8gaW50
ZWdyYXRlIHRoZSBzY2FsYWJsZSBBcm0gQ29ydGV4LUE1NSBjb3JlLCBicmluZ2luZyBwZXJmb3Jt
YW5jZQ0KPiBhbmQgZW5lcmd5IGVmZmljaWVuY3kgdG8gTGludXgtYmFzZWQgZWRnZSBhcHBsaWNh
dGlvbnMgYW5kIHRoZQ0KPiBBcm0gRXRob3MtVTY1IG1pY3JvTlBVLCBlbmFibGluZyBkZXZlbG9w
ZXJzIHRvIGNyZWF0ZSBtb3JlIGNhcGFibGUsDQo+IGNvc3QtZWZmZWN0aXZlIGFuZCBlbmVyZ3kt
ZWZmaWNpZW50IE1MIGFwcGxpY2F0aW9ucy4NCj4gDQo+IEFkZCB0aGUgYmFzaWMgZHRzaSBzdXBw
b3J0IGZvciBpLk1YOTMuDQo+IA0KPiBBY2tlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVs
Lm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQoNClJl
dmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRz
DQpBaXNoZW5nDQo=
