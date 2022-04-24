Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B228450CEB6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiDXC4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 22:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiDXC4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:56:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2092.outbound.protection.outlook.com [40.107.215.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047E284EE2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:53:48 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=EnueaxJ+OUJnCdp3AntVETgEO4ilatYqhBag5RsywQ07eODHbdhUoOmbSo926yk5z04z7c1YytDVgx1Iz2B5dbRlPYqM98xF8e+el/0Xz9bdW0fyJbl2KiCJLG0YYweoJ9cpHOVhX8qXm/TDMnTey6hwTnWCZCxdop4GA8nWDpg6J1WnNmgJ5bP/9CwykDhWC9q6atOTWnL2KG4UjgCu22bySpsbV+0Dc/ikmfL8AwbS0EWkM1aE29p0qkyc6Y/297rsY2uB5uJ7xLkD0jc7Fv5zBmS/a00VWNvla0rZ/RObuWBVSgvfMlarQB552hnrEDi5EHgMMwneURssL3K7Ag==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1EPIBoHmUfpyNiiKDXRhcroZnce5bHJ0x96/URTxuo=;
 b=N04PvU4lzq6dbqQgZfyPvi3F7aIMc2Zn6ddRLxfS7YxZDFc9jPd89x9dsWR5NtnzzsyCFHtDTxpbXfmxn8j0/jhsbXBv8B2Ym2gxiRdhvDNz8OzXSktOO/qFA/BPg0MCkMx5HzaV7ZGq+v5VZD0QkRENgUqY47A2vnTHUN0a5d8aZYOrlKzMBAT0zvADZ1LtspZpaEo8eqtrMCoMA4wwf5e5M/akslW2rDhKSsm9zHHmxM9OdueWxt4f7B6ZR9mxddxu7ZVAi1hzVrpwhNWe8oZpWmcvA0aPeh/OIT7+E8lNJm4IHb0V+/tjq6mONl/uEpo/gsucmkjJIcpnvBJXIw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=none; dmarc=none
 action=none header.from=vivo.com; dkim=error (no key for signature); arc=fail
 (41)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1EPIBoHmUfpyNiiKDXRhcroZnce5bHJ0x96/URTxuo=;
 b=Jk7py98gRN/f9qSbNcviDAtxQMegNXFbhfR9quEze4x+jyLEQ5qdjSamVeqMkIwHJBfALmzJq4WRQMTi56x8Rb/wHEtrCEF+uXgDXZJ2T9QCdg5qO0cB1F9qaWK7DghsdOn6Hsmrd6IboMapRXVZIWfFnK4RehGTF0hoJtRK0E4=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS1PR0601MB3787.apcprd06.prod.outlook.com (2603:1096:300:7a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Sun, 24 Apr
 2022 02:53:42 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.015; Sun, 24 Apr 2022
 02:53:42 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>
Subject: [PATCH V2 RESEND 1/2] arch_topology: support for parsing cache
 topology from DT
Thread-Topic: [PATCH V2 RESEND 1/2] arch_topology: support for parsing cache
 topology from DT
Thread-Index: AQHYV4aCNOkQM/LGcEqyFMxxMcfCLw==
Date:   Sun, 24 Apr 2022 02:53:42 +0000
Message-ID: <cd36064a335b44e4b2a91bdd460e58c5SL2PR06MB30825B7C53BE59FB7CAC03F3BDF99@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
 <1650628289-67716-2-git-send-email-wangqing@vivo.com>
 <YmKf4rv7+NhhS1CY@kroah.com>
In-Reply-To: <YmKf4rv7+NhhS1CY@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJZpNfxqEike3Bk6/O79HRRq/bcsF1B4yBs9x6zeAbcTI/ucOClfTLmP/hMkNd7dxjsGreh3BEii6MSnvYtBLTOUa3nZBixaqz6UaX9IYhPXLMRzAvRniup/D7DEhVaC5kP49F/y5VMaQDFq8JIQjQDZDAmNpcI8DuCB/Qa40WBq6ROP56vigeDc0VmhQnuFIaVP6u6cSJCdCZQ4KtPBFsk9xUTiAHxfo4DgfQC4VJKvXs9Tr97cIl6tjOXg3D63oo0tPDX/Q/mrMqtIH9GaotKYYiE7LHDWLrv9ri62AbUiJqrQjgKUhdJAPV+AzksbhW1yNJiJP/GiAC6eKRym/g==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71clt4+MMRDVc2d+aymHTSCXBg0u2EVAr+Us3/yeIQs=;
 b=fWscA+ryawGgSYL1S/Sciw4EfyYz2Rpt2Ha2+sEO8mA0FofurzzPQbUfbMjji4GzYUMdWXs0U8O8ubttSCeU32YPTFsHdIbySvfhumNL74V/1QuVhuu7CwccQwXS9J09qaKi+DxB33G78WXzNfwPhiKEd6SxvCF/qO0QlrF+yN82J6FkRpXXjJw292+u25+81ajEia+0ZPeoBYLYOrKwE/Aro3IKddrrJIVnbOkfCjAaRoHz05CRU+6H4BoWStEPLzL6to3zHgi30UBdlhZi9J4FGTmLK1w8kDqkdgcb+RB0nvRYeX0yt1An0edqeMZEskxMwy/5CN3Uqf6ObiNkzA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71clt4+MMRDVc2d+aymHTSCXBg0u2EVAr+Us3/yeIQs=;
 b=DEFHK3dbG8VlcrXS6HP2fdrXPRkFRBYQAAn5Pn2wgP5zfrvNAve5P0lu0lUr2ehi5/HnSt9fhIXkBLi4i2Ib6ZFn4vBLdw9Nxi7ZOvxF9yz4hfm7SHCYaCvVrh2Uto0kAqrgZ4DCjxwEboEArqrk5YmT+oLNCExWlHOQ522a9lk=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-office365-filtering-correlation-id: 4a998361-47c2-4011-a973-08da259da48e
x-ms-traffictypediagnostic: TYZPR06MB4461:EE_|SL2PR06MB3082:EE_|PS1PR0601MB3787:EE_
x-microsoft-antispam-prvs: <PS1PR0601MB37875A4B393752EAB27F65D2BDF99@PS1PR0601MB3787.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kCNcOZvtx4Uecd3wPTQ17mXEVQzsRngt7HH1SWntAT7UQip/mvm9QcaJZ/K0QSB09RDQ4OpBHkpSMoYgiz4SBnc1INCoyTLYuI2XBC7zEhEPI+8+n6MkeXYW1fQAXTFTOFUSEdIpPoy5XplCnK4Wp8cc63hy+LNi4AyxYwMXzpv+VfBGtp7k5cTTlJG8oGWEX8ETgfTwstdCsqGlIv5QgB/2V1cuGFomeFaE+/Pq9wUlYv6cnSQuFpD7nsyA40iDu2TNzadhJvu7dlTTn9vQX6mLAHpcQLfiFxqpiQCaMckIONBbG6mAPATieVlkyNFz90emrXZSPgS96CKuVWcA0Nbd6hYoAn52EHQqOx8l5jKyDYKqVdr32UAkInCGHsh3MLQTsGq4f9YtrToSDgg1dXwRiFOyv/NjJ3ejb6EKpRTA8r97GHS7b6jwr78QGUZcgcp1afeOETFTlawT4hoPk57s9nRZqDFX8Z++q/dQuhBzu5rOK2gUnzfnJU2LoUBa/wlMct0pYy3Xht11wGwOKDwVbA9AWMIGTlTHLvpJQERcmqhcU4zKHKPVJtUjSo6peTbwiDurxeoqTHfsvqzw/AYcN8VIDm7l0rVhSwgZW/TI0meRPk6jM/QudqrRk6WEr/Bx17g/0zcZzPeFnjFb5TzsKlL62S6hjTBFg705uwsXXt87GFi/mzj4xO8duTxZJ5/I2iIakjYG+RLimann3fqQHf1RhfxjvkUtvDyf61Rr/Hlyin1ziRw1u2X2EzHI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(37630700001)(71200400001)(55016003)(85182001)(508600001)(66946007)(6506007)(66476007)(2906002)(8676002)(64756008)(66446008)(76116006)(54906003)(66556008)(6916009)(8936002)(4326008)(7696005)(316002)(186003)(91956017)(38100700002)(38070700005)(86362001)(83380400001)(122000001)(5660300002)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkRmNThmU3NvaGFhOFltanl0bDBTbU9WSGtsenRjOEl1Qm5Pa0haNjFwak9K?=
 =?utf-8?B?MnV2QUJJbkpHV3QrUVlxVXJ4MTYyTXZVS0E3cFZvckllMmlDRG5TQzJ3SWlt?=
 =?utf-8?B?VjVTYkM5RUxSNFdWK3VPWG9SZkd4eDNEdmZPOTNZQjBmRjY4ZDRpZ2JFc1Zr?=
 =?utf-8?B?ZDN1dGZ1ak5jeWxCQW5tT0ZtTS9CYWRsakxwaTBwVlkyWnhmYk5JODNpYWcx?=
 =?utf-8?B?aHpnZG1YUFhmcy9rclEyZXdsTVJiNHM4ZFZTeEdjUkVuWEFSNitrVlNBR3lR?=
 =?utf-8?B?RFI3eCtzejlMd09OaEdhdUlGaHd4M1MrUEZaVjdDNzZ1U2J0UGFrM0JnNTBh?=
 =?utf-8?B?STZldWVFUzdLcW5DK2hzRmlDNUhmT0Z0M0s2MmFlUnFUZXYyZERZcE1GaWFt?=
 =?utf-8?B?WksvZ0x5eUdKOTVYd2ZleUZXK1ZIcDJXdTJOWGFwRExIN2ZEdWd5cjZOcGV0?=
 =?utf-8?B?dnhkN0dhMFVOU0hYRHdhWFNIM3NFamN6VEkrV1ZIZ0F4QWxNK0RadkhtK3A0?=
 =?utf-8?B?Vm9kZE13MGp6VkNUQzlwK1VVbU1jclc0MTdyUDMwRUg3RWVMU0R4SVdVOXV5?=
 =?utf-8?B?WHlYNklHbUxEdmw2RkpZUS9EcmdFSCtJR1YydGUyNS9sa1JFMTdPTFltY0hl?=
 =?utf-8?B?WHRlakZMc3d0b256Z1lGaWRjQncyTDRYSjhiWmdqRnZOS2I2TlB4MndSTzNI?=
 =?utf-8?B?TE5Ba2hnak04RENZekVnSFdkakZCQW9icFd0cGt4cEVDNXR2Wk1UbTZTYlc4?=
 =?utf-8?B?T0h0eERVZHZCV3lsMmtvZVFYQjRKbEdjSUhpQzN4Rjg2b0lIVmhUWHNnZXJL?=
 =?utf-8?B?SlZvTmNXcG4zM3VIYXF6TzNpWTZxdXRuQ0pXOWJlRG83VFBCRkx2YWF6Q2FN?=
 =?utf-8?B?M1dqWTJzbEg2K2tEakhjZTB3QkZ5ampZbVJUakc2MEJlb29MSHlKN2V3cFR4?=
 =?utf-8?B?YTlCd3RqRGFzelA2SGRILzlwRVkxZDdpTUd3a280dmdCMzF6NVR6OFhrcG8r?=
 =?utf-8?B?cU1qYUVTVDBib0UreXJLSFlydTI1RXRLSUtCenZrUVFhZHNhUlZ1VE1DUHRu?=
 =?utf-8?B?dnpjQWZEVTBRekc2OGt5ZUFTaXFjaDJaNVZmYXFIQkkwUFhKZHRDZmRxMzlY?=
 =?utf-8?B?ZklDbCt2RFFPamtHMEtxVkR1TFNMQ3pwb3UwSGtqbEVOQkZRbTRWaEhWeS9a?=
 =?utf-8?B?ZTRGbk5kK09MMURXSVAxYmxjeGZZdU0xbFN3QzBJc096M1ZPVkk0OE90QnJI?=
 =?utf-8?B?b0x2S214UDBLT29rTDBBZW9sSUU1ZGxDWGU4MXNRQjBjbGd1QlptMDc3VHlt?=
 =?utf-8?B?aVpkdkF3ZVZteW1Wanpjc01nZjVZaVlrNUtJcFpaYXFCelNiOHRXV1p5anpE?=
 =?utf-8?B?cUhhOEp6QWtlT2FvY3dTQys2dXZUTUVaOWMwYVJkNjh2TDQwZXpoaVRvTEl0?=
 =?utf-8?B?UXJTaEJzaDNGZ2lEYUdES0NPUERnMGlxdHpJaDB0NHhLRW9pT0lyRm8rWFls?=
 =?utf-8?B?dkFPYU9seTI0aGc0eHBkM1U4c1NBMXVPZVlYSDFteFpWK3ZWSU9lUFVzR2Ew?=
 =?utf-8?B?TnJCYks4bkdySG5ZTWpseDYwaVVEWTdtc2U4UDJhYlFDN3lzM0lRdytkZnNL?=
 =?utf-8?B?Q1hyUkJQQ1N4Q3loUEFYdEhiaVVPU01iVWg4YVdMaVlZUU00ejRRWEdhK1Ru?=
 =?utf-8?B?NG9WbzkybkFDUk1MV1NRMTd2M2Z4NUI4VGtuRVlydXNsRVp6WE8yYkhoYW1N?=
 =?utf-8?B?ci85R1I4ekcvL29qYUpVa2xwaUc4dG8wdS9VM2ExMlBmYWUyeEdkZnNxaGZL?=
 =?utf-8?B?WlBROWNmL2diWW1pYmxaY1dHU2huKzlLYW5jMEYrVHoyZjc3R0dnZEVLNUdI?=
 =?utf-8?B?MnVER0Y1TUJ5R3RjZk5xR3dRSFhVb2xRLy9NZFI1Z3BadkhLOTJsT0krZ3o2?=
 =?utf-8?B?SDBNV0xTS3ppZHZIQVpPNCtHeG5yTjhnc3VuVW1IQ2VkeHhPb2srZXdEVE5S?=
 =?utf-8?B?S0lnaGNvbjBJZENSTDUxQTNvVjh6amZ5T2F4TTRiNCs1em0vNVludWMvWHZj?=
 =?utf-8?B?MzZNSS96QjVZakpSZzlySitxc2xMcnR1ckM1NjFxSitmS3UyT3B6Y3Z0QVBY?=
 =?utf-8?B?cFVoNU13L0hWVmZiUFFZVE1pQ0hmc1gwRm54b0hQaHZCTUh1UmlqN0xOUnk1?=
 =?utf-8?B?bHo5WWdTd0RYZzlJeFBkT1luWDNHT0V1NWk2bC9yQ3QremJHb1B2ZVk2Ykgx?=
 =?utf-8?B?RnViM0M5REN4b3pJbWhySkFvWDd6KzEyNEtMdk1nL3N5bDJIRVVDaEZseG9K?=
 =?utf-8?Q?froA+iCzdqrvhBNDyw?=
x-ms-exchange-crosstenant-network-message-id: dbabb605-7772-4c21-63fd-08da2597e9f0
x-ms-exchange-crosstenant-authsource: SL2PR06MB3082.apcprd06.prod.outlook.com
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-originalarrivaltime: 24 Apr 2022 02:12:42.0856 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: hss+0Pt+oxBBYbDizEr/EnZUchZW9P6eHWJpx1jTzujgqG9ZYrW15xv2tM/3NaTLitn68EWxKyaEXImoQQeusA==
x-ms-exchange-transport-crosstenantheadersstamped: TYZPR06MB4461
x-ms-office365-filtering-correlation-id-prvs: dbabb605-7772-4c21-63fd-08da2597e9f0
Content-Type: text/plain; charset="utf-8"
Content-ID: <14354CD22066084686B8260E24BB968A@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a998361-47c2-4011-a973-08da259da48e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2022 02:53:42.6783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43IIR2ZOpyklB5D3HvLQ45rX0PRovOSCYKroWai26ZCkI9scDYjw+ywJFIkweeHKHJEey6fejkTwSpD21n12Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR0601MB3787
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IEZyb206IFdhbmcgUWluZyA8d2FuZ3FpbmdAdml2by5jb20+Cj4+IAo+PiBXaGVuIEFDUEkg
aXMgbm90IGVuYWJsZWQsIHdlIGNhbiBnZXQgY2FjaGUgdG9wb2xvcHkgZnJvbSBEVCBsaWtlOgo+
PiAqIMKgIMKgIMKgIMKgIMKgIMKgIGNwdTA6IGNwdUAwMDAgewo+PiAqIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIG5leHQtbGV2ZWwtY2FjaGUgPSA8JkwyXzE+Owo+PiAqIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIEwyXzE6IGwyLWNhY2hlIHsKPj4gKiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbXBhdGlibGUgPSAiY2FjaGUiOwo+PiAq
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5leHQtbGV2ZWwtY2Fj
aGUgPSA8JkwzXzE+Owo+PiAqIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTsKPj4g
KiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBMM18xOiBsMy1jYWNoZSB7Cj4+ICogwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb21wYXRpYmxlID0gImNh
Y2hlIjsKPj4gKiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH07Cj4+ICogwqAgwqAg
wqAgwqAgwqAgwqAgfTsKPj4gKgo+PiAqIMKgIMKgIMKgIMKgIMKgIMKgIGNwdTE6IGNwdUAwMDEg
ewo+PiAqIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5leHQtbGV2ZWwtY2FjaGUgPSA8
JkwyXzE+Owo+PiAqIMKgIMKgIMKgIMKgIMKgIMKgIH07Cj4+ICogwqAgwqAgwqAgwqAgwqAgwqAg
Li4uCj4+ICogwqAgwqAgwqAgwqAgwqAgwqAgfTsKPj4gY2FjaGVfdG9wb2xvZ3lbXSBob2xkIHRo
ZSBwb2ludGVyIGRlc2NyaWJpbmcgYnkgIm5leHQtbGV2ZWwtY2FjaGUiLCAKPj4gd2hpY2ggY2Fu
IGRlc2NyaWJlIHRoZSBjYWNoZSB0b3BvbG9neSBvZiBldmVyeSBsZXZlbC4KPj4gCj4+IE1BWF9D
QUNIRV9MRVZFTCBpcyBzdHJpY3RseSBjb3JyZXNwb25kaW5nIHRvIHRoZSBjYWNoZSBsZXZlbCBm
cm9tIEwyLgo+Cj5JIGhhdmUgbm8gaWRlYSB3aGF0IHRoaXMgY2hhbmdlbG9nIG1lYW5zIGF0IGFs
bC4KPgo+V2hhdCBhcmUgeW91IHRyeWluZyB0byBkbz8gwqBXaGF0IHByb2JsZW0gYXJlIHlvdSBz
b2x2aW5nPyDCoFdoeSBhcmUgeW91Cj5kb2luZyBhbnkgb2YgdGhpcz8KClRoaXMgcGF0Y2gganVz
dCBzdXBwb3J0cyBwYXJzaW5nIGNhY2hlIHRvcG9sb2d5IGZyb20gRFQgaW4gdGhlIGVhcmx5Cihi
ZWZvcmUgc2NoZWQgZG9tYWluIGluaXRpYWxpemF0aW9uKS4gVGhlbiB3ZSBjYW4gdXNlIHRoZSBp
bmZvcm1hdGlvbgphYm91dCBzaGFyZWQgY2FjaGUgbGV2ZWwgdG8gYnVpbGQgdGhlIHNjaGVkIGRv
bWFpbiBsZXZlbC4KCj4KPgo+PiAKPj4gVjI6Cj4+IG1ha2UgZnVuY3Rpb24gbmFtZSBtb3JlIHNl
bnNlCj4KPkFzIHBlciB0aGUgZG9jdW1lbnRhdGlvbiB0aGlzIGdvZXMgYmVsb3cgdGhlIC0tLSBs
aW5lLCByaWdodD8KPgo+Cj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBXYW5nIFFpbmcgPHdhbmdxaW5n
QHZpdm8uY29tPgo+PiAtLS0KPj4gwqBkcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jIMKgfCA0
NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+PiDCoGluY2x1ZGUvbGludXgv
YXJjaF90b3BvbG9neS5oIHwgwqAzICsrKwo+PiDCoDIgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9h
cmNoX3RvcG9sb2d5LmMgYi9kcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jCj4+IGluZGV4IDFk
NjYzNmViYWFjNS4uNDZlODRjZTJlYzBjIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2Jhc2UvYXJj
aF90b3BvbG9neS5jCj4+ICsrKyBiL2RyaXZlcnMvYmFzZS9hcmNoX3RvcG9sb2d5LmMKPj4gQEAg
LTQ4MCw4ICs0ODAsMTAgQEAgc3RhdGljIGludCBfX2luaXQgZ2V0X2NwdV9mb3Jfbm9kZShzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5vZGUpCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC0x
Owo+PiDCoAo+PiDCoCDCoCDCoCDCoGNwdSA9IG9mX2NwdV9ub2RlX3RvX2lkKGNwdV9ub2RlKTsK
Pj4gLSDCoCDCoCBpZiAoY3B1ID49IDApCj4+ICsgwqAgwqAgaWYgKGNwdSA+PSAwKSB7Cj4+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgdG9wb2xvZ3lfcGFyc2VfY3B1X2NhcGFjaXR5KGNwdV9ub2Rl
LCBjcHUpOwo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIHRvcG9sb2d5X3BhcnNlX2NwdV9jYWNoZXMo
Y3B1X25vZGUsIGNwdSk7Cj4+ICsgwqAgwqAgfQo+PiDCoCDCoCDCoCDCoGVsc2UKPj4gwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBwcl9pbmZvKCJDUFUgbm9kZSBmb3IgJXBPRiBleGlzdCBidXQgdGhl
IHBvc3NpYmxlIGNwdSByYW5nZSBpcyA6JSpwYmxcbiIsCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgY3B1X25vZGUsIGNwdW1hc2tfcHJfYXJncyhjcHVfcG9zc2libGVfbWFz
aykpOwo+PiBAQCAtNjQ3LDYgKzY0OSw0OSBAQCBzdGF0aWMgaW50IF9faW5pdCBwYXJzZV9kdF90
b3BvbG9neSh2b2lkKQo+PiDCoH0KPj4gwqAjZW5kaWYKPj4gwqAKPj4gKy8qCj4+ICsgKiBjcHUg
Y2FjaGUgdG9wb2xvZ3kgdGFibGUKPj4gKyAqLwo+PiArI2RlZmluZSBNQVhfQ0FDSEVfTEVWRUwg
Nwo+PiArc3RhdGljIHN0cnVjdCBkZXZpY2Vfbm9kZSAqY2FjaGVfdG9wb2xvZ3lbTlJfQ1BVU11b
TUFYX0NBQ0hFX0xFVkVMXTsKPgo+U28gZm9yIGEgbm9ybWFsIGJpZyBzeXN0ZW0gb2YgNGsgY3B1
cyAqIDcgbGV2ZWxzLCB0aGF0J3MgYSBsb3Qgb2YKPm1lbW9yeT8gwqBhcmUgeW91IHN1cmU/CgpZ
ZXMsIGlmIENPTkZJR19OUl9DUFVTIGlzIGNvbmZpZ3VyZWQgYXMgNGssIGl0IHdpbGwgdGFrZSB1
cCAyMjRLQiBtZW1vcnkKaW4gNGsgY3B1cyBzeXN0ZW0uCgo+Cj5Ib3cgYmlnIG9mIGEgYm94IGRp
ZCB5b3UgdGVzdCB0aGlzIG9uPwoKSSB0ZXN0ZWQgb24gYW5kcm9pZCBwaG9uZS4KCj4KPj4gKwo+
PiArdm9pZCB0b3BvbG9neV9wYXJzZV9jcHVfY2FjaGVzKHN0cnVjdCBkZXZpY2Vfbm9kZSAqY3B1
X25vZGUsIGludCBjcHUpCj4+ICt7Cj4+ICsgwqAgwqAgc3RydWN0IGRldmljZV9ub2RlICpub2Rl
X2NhY2hlID0gY3B1X25vZGU7Cj4+ICsgwqAgwqAgaW50IGxldmVsID0gMDsKPj4gKwo+PiArIMKg
IMKgIHdoaWxlIChsZXZlbCA8IE1BWF9DQUNIRV9MRVZFTCkgewo+PiArIMKgIMKgIMKgIMKgIMKg
IMKgIG5vZGVfY2FjaGUgPSBvZl9wYXJzZV9waGFuZGxlKG5vZGVfY2FjaGUsICJuZXh0LWxldmVs
LWNhY2hlIiwgMCk7Cj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCFub2RlX2NhY2hlKQo+PiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOwo+PiArCj4+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgY2FjaGVfdG9wb2xvZ3lbY3B1XVtsZXZlbCsrXSA9IG5vZGVfY2FjaGU7Cj4+ICsg
wqAgwqAgfQo+Cj5ObyBsb2NraW5nIGFueXdoZXJlPyDCoFdoYXQgY291bGQgZ28gd3JvbmcgOigK
wqAKVGhlIGNhbGxpbmcgcHJvY2VzcyBvZiB0aGUgZnVuY3Rpb24gaGFzIGd1YXJhbnRlZWQgbm8g
ZGF0YSByYWNpbmcgY29uZGl0aW9uLgpjYWNoZV90b3BvbG9neVtdIHdpbGwgb25seSBiZSBtb2Rp
ZmllZCBieSBwYXJzZV9kdF90b3BvbG9neSgpLgpjYWNoZV90b3BvbG9neVtdIGJlaGF2ZXMgbGlr
ZSBjcHVfdG9wb2xvZ3lbXS4KCj4KPj4gK30KPj4gKwo+PiArLyoKPj4gKyAqIGZpbmQgdGhlIGxh
cmdlc3Qgc3Vic2V0IG9mIHRoZSBzaGFyZWQgY2FjaGUgaW4gdGhlIHJhbmdlIG9mIGNwdV9tYXNr
Cj4+ICsgKi8KPj4gK3ZvaWQgZmluZF9zdWJzZXRfb2Zfc2hhcmVfY2FjaGUoY29uc3Qgc3RydWN0
IGNwdW1hc2sgKmNwdV9tYXNrLCBpbnQgY3B1LAo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc3RydWN0IGNwdW1hc2sgKnNjX21hc2spCj4KPkFnYWluLCBob3JyaWQgZ2xv
YmFsIGZ1bmN0aW9uIG5hbWUuCj4KPkFuZCBubyBrZXJuZWwgZG9jdW1lbnRhdGlvbiBmb3IgaG93
IHRoaXMgd29ya3M/CgpNYXliZSBJIHNob3VsZCBwb3N0IGFuIEZSQyBwYXRjaCBmaXJzdC4KCj4K
Pgo+Cj4+ICt7Cj4+ICsgwqAgwqAgaW50IGNhY2hlX2xldmVsLCBjcHVfaWQ7Cj4+ICsKPj4gKyDC
oCDCoCBmb3IgKGNhY2hlX2xldmVsID0gTUFYX0NBQ0hFX0xFVkVMIC0gMTsgY2FjaGVfbGV2ZWwg
Pj0gMDsgY2FjaGVfbGV2ZWwtLSkgewo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIGlmICghY2FjaGVf
dG9wb2xvZ3lbY3B1XVtjYWNoZV9sZXZlbF0pCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgY29udGludWU7Cj4KPk5vIGxvY2tpbmc/Pz8KPgo+Cj4+ICsKPj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCBjcHVtYXNrX2NsZWFyKHNjX21hc2spOwo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIGZv
ciAoY3B1X2lkID0gMDsgY3B1X2lkIDwgTlJfQ1BVUzsgY3B1X2lkKyspIHsKPj4gKyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoY2FjaGVfdG9wb2xvZ3lbY3B1XVtjYWNoZV9sZXZl
bF0gPT0gY2FjaGVfdG9wb2xvZ3lbY3B1X2lkXVtjYWNoZV9sZXZlbF0pCj4+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY3B1bWFza19zZXRfY3B1KGNwdV9pZCwg
c2NfbWFzayk7Cj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgfQo+PiArCj4+ICsgwqAgwqAgwqAgwqAg
wqAgwqAgaWYgKGNwdW1hc2tfc3Vic2V0KHNjX21hc2ssIGNwdV9tYXNrKSkKPj4gKyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVhazsKPj4gKyDCoCDCoCB9Cj4+ICt9Cj4+ICsKPj4g
wqAvKgo+PiDCoCAqIGNwdSB0b3BvbG9neSB0YWJsZQo+PiDCoCAqLwo+PiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9hcmNoX3RvcG9sb2d5LmggYi9pbmNsdWRlL2xpbnV4L2FyY2hfdG9wb2xv
Z3kuaAo+PiBpbmRleCA1OGNiZTE4ZDgyNWMuLmM2ZWQ3MjdlNDUzYyAxMDA2NDQKPj4gLS0tIGEv
aW5jbHVkZS9saW51eC9hcmNoX3RvcG9sb2d5LmgKPj4gKysrIGIvaW5jbHVkZS9saW51eC9hcmNo
X3RvcG9sb2d5LmgKPj4gQEAgLTkzLDYgKzkzLDkgQEAgdm9pZCB1cGRhdGVfc2libGluZ3NfbWFz
a3ModW5zaWduZWQgaW50IGNwdSk7Cj4+IMKgdm9pZCByZW1vdmVfY3B1X3RvcG9sb2d5KHVuc2ln
bmVkIGludCBjcHVpZCk7Cj4+IMKgdm9pZCByZXNldF9jcHVfdG9wb2xvZ3kodm9pZCk7Cj4+IMKg
aW50IHBhcnNlX2FjcGlfdG9wb2xvZ3kodm9pZCk7Cj4+ICt2b2lkIHRvcG9sb2d5X3BhcnNlX2Nw
dV9jYWNoZXMoc3RydWN0IGRldmljZV9ub2RlICpjcHVfbm9kZSwgaW50IGNwdSk7Cj4+ICt2b2lk
IGZpbmRfc3Vic2V0X29mX3NoYXJlX2NhY2hlKGNvbnN0IHN0cnVjdCBjcHVtYXNrICpjcHVfbWFz
aywgaW50IGNwdSwKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVj
dCBjcHVtYXNrICpzY19tYXNrKTsKPgo+SSBzdGlsbCBoYXZlIG5vIGlkZWEgd2hhdCB0aGlzIGxh
c3QgZnVuY3Rpb24gaXMgc3VwcG9zZWQgdG8gZG8uCgpUaGlzIGZ1bmN0aW9uIGlzIHRvIGZpbmQg
dGhlIGxhcmdlc3Qgc2hhcmVkIGNhY2hlIHN1YnNldCBmcm9tIHRoZQpzcGVjaWZpZWQgY3B1bWFz
aywgc28gd2UgY2FuIG1ha2UgdGhlbSBhIG5ldyBsZXZlbCBzY2hlZCBkb21haW4sCndoaWNoIHdp
bGwgZGlyZWN0bHkgYmVuZWZpdCBhIGxvdCBvZiB3b3JrbG9hZC4KCj4KPkFuZCB2ZXJ5IG9kZCBp
bmRlbnRhdGlvbiwgZGlkIHlvdSBydW4gY2hlY2twYXRjaCBvbiB0aGlzPwoKWWVzLCBJIG1vZGlm
eSBpdCBtYW51YWxseSBhZnRlciBydW5uaW5nIGNoZWNrcGF0Y2gsIHRoaXMgaXMgbXkgcHJvYmxl
bS4KCj4KPnRvdGFsbHkgY29uZnVzZWQsCgpUaGFua3MgZm9yIHlvdXIgY29ycmVjdGlvbiwgClFp
bmcKCj4KPmdyZWcgay1oIAo=
