Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E34E5C66
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346828AbiCXAku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241667AbiCXAks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:40:48 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756BA5EDFB;
        Wed, 23 Mar 2022 17:39:16 -0700 (PDT)
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C6BDCC09B7;
        Thu, 24 Mar 2022 00:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1648082356; bh=/7ltwNfBewnW8r9FR5Fc+KOQLCwu4DdZ1wLal/0bEcA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=O4ohaMUJj1aE69BOCwHp+5TI35G1xcErS8ivCRKNOep8SjpeccsCx9n3W0tbHl+dl
         zhW/8BKxU3oPnhWBF8cQCgfVg8SBOZqggKJoF50/2YNy2SPMkFNjTxZcrrJDURJtxP
         uAfft/KXibAjKNJtQfUFf/taszj6N5ZQLRikHNXOJDMJNBTksnBtg7YUcSuJ2YnyiN
         wWqeth3e0sf9xmhTVO6xmwprESwaPcMg5FS7zM43mBVu4dNhWX47g6Trrag9fve9qX
         bWuNZlsF52J9uNwzTvz9UdxF8lIr45SmttrEc1C5DQ9Writo/PXUxVw0JdSWpTiR8U
         nKB9RneldvcFg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 56967A009D;
        Thu, 24 Mar 2022 00:39:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8ACDD40097;
        Thu, 24 Mar 2022 00:39:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dNAzMVQA";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWyKNIeVc0sg2wg1t6BLxi3mNYingaj90FYVxTOg3GfBWNZtu6XWu0uYE40hUmeV+GwLdDv8UdRAPGNgloyVDvFMjgrb40mGN71BOWlFqbKrLOtFrUWoa9NfmC3vxj7/LPtzpo/aiUSng6h9olsJN9xCVwU0sqjUP6HOx8VnQ3u56ATtxaG8oCtPsKJLyaOICvSFSencQXvY0RgYv/ioJdktuN9wVW1CErSLJVnlZOuYYZJzNdAqhxlyaTkeSPuZN6A2Nt8r4SNzZf2eLUJhzzNKRTPp9D6XokoZnh6MOMPleanXL8vb2B8WJq+byQe/hpLT4EribG01RH2bzdY6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7ltwNfBewnW8r9FR5Fc+KOQLCwu4DdZ1wLal/0bEcA=;
 b=OVl5Tm7XzJDIdIea/3km8Stz9cr29FCVFbSvTjGCWoiDXoj/AGybYIF1LKrqTGwkFH5jinsgHPaOWQGIcazu3wAqvmMSP1vlCqsu4bL1Gg4BMRx4lOl2bls9K9+zeQw0CKF78xYhg6ZGtH9S1B096cOwEQe17aYeQazgddOizWSrsikaKLcEVuHwLFuPMHB7LBu/9HzmR1TUiWED/dzwOaMGEAl6OsATnCgzYfSdms4xEx694YHfD1YpTwL5vMtH0C9H0t6G5Q/fNBaN7tEcNymdejYgEkU8rJYHHgKU+PSS6YVrS7/8XUHlFqiDvhSbu+FKtqjGjovWfK2ZO8Pemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7ltwNfBewnW8r9FR5Fc+KOQLCwu4DdZ1wLal/0bEcA=;
 b=dNAzMVQA9AHt6ZDsQF45uMrhDu/3YNQRJazgx7rJQW2OSfCz8PYhD7O/OxCLaA7VhxYZY7/8kAaIXMrJFopQQiG2ofMr9MQWQUFOYOCYHr09pnPtXIlG5wU3pzxPzwPmyIURVM59ZExxBAf9lQyeU1VEG5H5s3WAjAfl9T+iwqg=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 00:39:09 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::e8c9:196b:fe62:833]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::e8c9:196b:fe62:833%6]) with mapi id 15.20.5102.017; Thu, 24 Mar 2022
 00:39:06 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [RFC PATCH v2 1/3] usb: dwc3: Flush pending SETUP data during
 stop active xfers
Thread-Topic: [RFC PATCH v2 1/3] usb: dwc3: Flush pending SETUP data during
 stop active xfers
Thread-Index: AQHYIsliuiq4as3hWE6r+TfikYnp1KzL7aoAgAB4EACAAEfMAIABPAiA
Date:   Thu, 24 Mar 2022 00:39:06 +0000
Message-ID: <e2a15c5e-f437-3dfb-6c49-a97a094eaaae@synopsys.com>
References: <20220216000835.25400-1-quic_wcheng@quicinc.com>
 <20220216000835.25400-2-quic_wcheng@quicinc.com>
 <eeee97bf-2987-3cfb-217e-42615d8d864b@codeaurora.org>
 <26c82c13-d047-853e-12af-e916596c5c52@synopsys.com>
 <469213d0-526a-e26e-88c2-b34b2aa8dfe7@codeaurora.org>
In-Reply-To: <469213d0-526a-e26e-88c2-b34b2aa8dfe7@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fc11835-ceff-4f4d-16f4-08da0d2eb3fc
x-ms-traffictypediagnostic: DM6PR12MB4300:EE_
x-microsoft-antispam-prvs: <DM6PR12MB43006F46AB8A8725A81DD185AA199@DM6PR12MB4300.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WTrf1kCEDfeXHXdsTcGIxt3SLh5oPQoSvNH+a3V6Noad07ZuilfCGZg75Y+n/x1ghB/hoccLCEAw/YhrVTRuHv7C5Sl6cXBdKSJeBLBhb2PkN9z9L9Xl8HWe95sKaVsAXa56oVTmRth9TDJ6HR+5fuO7BobU/FKxJ1OVFTBVLgD7TBAkEJ7MzxPLD7as0a500iVX2sHwZWKaMPIPZx0AJWnFzOdhOjLRh4aevdbcKtIf6AjxpvPtfn9VjqOa/fA/PWQ5+gJj9uf2Cj8C7h50Zmt2dNH4gH0FXFpaANG2MwQKdx9DM3xnQj+4uCahV+i/YaQTP4/tpWZWsRyspXMATMPI9dkBMvoCGGfMabjQ50jT61biMpBm4XP1b4OxdR8v2jokYOnLu+EM6BpACfqveO/kt0vMgE3LqRvBKuNWcbtOHoRVVn8x83q1pgvY+wER7kL8kmtYJUj25wFkK9GIt+e10jQi5MhvYSm7Ausm73ouai02+rHbTOX9qvCyF0MWpja+mN1d9U3/8JVX2WVfJLmw3IieCs6oDtQJQhGa0IUtKO0ZsjojRl7+s+YBfFrlHW5WFHI5HJ1y/zgjG/WrW8sFzXTgcFW34LjKOEMYTd/bYyq5jUt//94Phhh7fwXbEZVtU2E93eizG5POfStUTSSA9BH1EI2QfvPCpagQKUNGqtzKgXUyvdduSGVDvSP/hms5AhGjtkxmsiKQpYIy/1ny7c2d7gm87lWx0IklnebXNmiWY63J1KXNbzfxO13ir4yzuGnM0SijDIB35kPVIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(4326008)(38100700002)(8676002)(66476007)(76116006)(66446008)(64756008)(66946007)(66556008)(5660300002)(54906003)(316002)(71200400001)(110136005)(31686004)(91956017)(2616005)(508600001)(6486002)(26005)(186003)(6512007)(8936002)(2906002)(122000001)(31696002)(38070700005)(86362001)(83380400001)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkdFam83eFVvTTQ5ZzVsRUdVRWNYQVlaSVBpV29CV3pxek44OHJFeDN1NWNY?=
 =?utf-8?B?V0JTM0xKdnZoZ0ZrN3lzTS9KdVhSM3BMQWZRRi9qWXVaaDNVdDVVQTc1T3JT?=
 =?utf-8?B?czk4VSs3MVJPK0xXSEswZk0yTE5NVXd1bzdhQVIyY3ozNmY0bVpkWXhNcC9Q?=
 =?utf-8?B?Z3VrN05OVXZoSkRkNjAvVVZKOFA4YTRDYXV1Z2dzVDY4L3FoZUdJaDljL1Qv?=
 =?utf-8?B?TVhVNEZtTEw0YUEvTnJaQVZUS1ZRdHVnL2VWNmF6RzMyeU5HWUZBMEFQMkZM?=
 =?utf-8?B?cXVwZUpNaGhtcXk2K3A5LzdJUUNKRS8vY3NRaE81Z0lRNk04ZmYxbFdmVkNF?=
 =?utf-8?B?aXlrMUFoRFhIbmtVZkZKaEFpK242L2dlWnpNczVNN1MvamxUQkoyb0RYRmZy?=
 =?utf-8?B?UDJVRjFBYTc4V1hpd2lCbERGZTQ1eU1oSEtkWkdGN3lBekN0YnlKVzZxdlJn?=
 =?utf-8?B?V1ZRRmRxS3VNaTk0a0k3cU5Hb3hsQ1JjQlZkQnZETmR6TlYvbUx6OXhWNjJO?=
 =?utf-8?B?RGgrMWQxRlVMdUJvRVltUFI2WTBRcEt1dEpoVXd5bEtGdWQxa0Fzd0lIdWxR?=
 =?utf-8?B?VUUrR0dwTkNEZXVqZStLOG13VHpMMzM1RnJ2NVc4ckxQZUxPb3BoakJPdlVt?=
 =?utf-8?B?NzNZWnVKSmw5ZUYyWDc1UCtiRlF5Y3h3Ui9Fd25NME1MYXhYamdBWjRCOTU5?=
 =?utf-8?B?Z2J5bGN0TEhJOURsNjJON3BuWXppMGIzVlNCVG9NVFJ1UmZKYmpOSFRnS0lj?=
 =?utf-8?B?djk3S3UwRi9Ub3Fnd21tMjQ5S01aSGtnZzdHSEo0bzdtQW1MZFlaTHRDNXBF?=
 =?utf-8?B?Y1JPVU4zWkpqMGxma0FYMUVPUW15V1RPZmVsUDZ4VjNEY1ZhSktDa3VHMUll?=
 =?utf-8?B?Q25hbTRRT0tsUlY4RXk0a0hKeHk2MjB3dVlmKy9IVGNnblhSTE10Z2diTElt?=
 =?utf-8?B?TmxkTTFEbWpxYmlLRUYyU2x6RmVDZFVDa095L2NqWExMUlhyWUpPRmJjT0I2?=
 =?utf-8?B?K0UwWmFBMGRWbWZLejM5UGtqdlNHTFhBTUI2YlZIc3JvajhMREtlTWRSNjJ3?=
 =?utf-8?B?c01aYXFIdk1HUEVxREJ4Q1J2VVdZYkRzMUppYTl2TTdMQ1NhYVpzTDFxaVFU?=
 =?utf-8?B?a3BWeC9mRS9UQmJjTGdacVFUSk1tSmZrbmN0Wk4xSmxFUTVOeWpVakl1SGFP?=
 =?utf-8?B?MEdNeUlhcDFVaUdGUytJVUkwZ0M0T2IxaEV5ZzV6MWdKSnJXamVTWEpmaVJ1?=
 =?utf-8?B?UlhTcDNGN2wrbEtrUTZab1lDdTBqenpjVThYM3hteVJsdmdRc09uK1VsNHVJ?=
 =?utf-8?B?ZVNwd0ZzYUhoT1RZaDhNdGFlSk1nT0Q5UTl2YmowTTEzUi8yZThuajl5Qy9T?=
 =?utf-8?B?em1ZWTRuR1MwdDRqVGZpZ3NaMDJQUWUzZk1ucHBjMmdMYks2MUNNQ3ovRnVi?=
 =?utf-8?B?amo2YmFHd1Q1bjNRYnY2Z0lKYmxLNWdrcS92OElJbUorRUM0WFl3L3ZWVjQx?=
 =?utf-8?B?NTlWN3RkQS95SlluL3N4cU1POUFZcTNPMC81SmZGSWRPUWd5cFNnVEUwcVdN?=
 =?utf-8?B?SU1DT3hTRjhtcXp5ZlNGM2o4dHdmME9OR3NUZjhVbHY5ZXpubk9qWjRiTzBQ?=
 =?utf-8?B?cmxRaVF6aGlNbkhZN0RIQW5hdVdlNVpHOFFqczdXdXNKZHJZbjRTZVdPNFlD?=
 =?utf-8?B?UFdpMkY3SnpVYVJhNm1iRlVCcjdLb0pCaWZNNTdNWjJFajBJaS9xVUN1YVVX?=
 =?utf-8?B?NGhyckFIQWhDdUJaM09tUGdIbXJsTEJqeU41R0FUMW9jWUR1aXFhNlpmZmVX?=
 =?utf-8?B?cDgzS2dDdFpkQWNXcW9TK1NOd1RiaTZlb0ZYaWppODFCWFVIWTV0ZmRGV0FH?=
 =?utf-8?B?Vit2bm42OVRMVit3Qk00RnhuRGdnc0s0KzJ0QUVGMFB3YjExVTZ1ODhZV1pM?=
 =?utf-8?Q?o8ShBtTD1WuejQgeCW6dG1Fc2FXEJt3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A79E7DFB14D3A34B9732E86012DBA632@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc11835-ceff-4f4d-16f4-08da0d2eb3fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 00:39:06.4395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdgZ4/y9pARebVdIwO7g/xdjk4IYW7+8lQNwKRxK9ezFYdJEvyFIrjsSgOuIDIdqUxeAP5I6S9HjItICPaD9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VzbGV5LA0KDQpXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IEhpIFRoaW5oLA0KPiANCj4gT24g
My8yMi8yMDIyIDY6MzEgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+IEhpIFdlc2xleSwNCj4+
DQo+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4gSGkgVGhpbmgsDQo+Pj4NCj4+PiBPbiAyLzE1
LzIwMjIgNDowOCBQTSwgV2VzbGV5IENoZW5nIHdyb3RlOg0KPj4+PiBXaGlsZSBydW5uaW5nIHRo
ZSBwdWxsdXAgZGlzYWJsZSBzZXF1ZW5jZSwgaWYgdGhlcmUgYXJlIHBlbmRpbmcgU0VUVVANCj4+
Pj4gdHJhbnNmZXJzIHN0b3JlZCBpbiB0aGUgY29udHJvbGxlciwgdGhlbiB0aGUgRU5EVFJBTlNG
RVIgY29tbWFuZHMgb24gbm9uDQo+Pj4+IGNvbnRyb2wgZXBzIHdpbGwgZmFpbCB3LyBFVElNRURP
VVQuICBBcyBhIHN1Z2dlc3Rpb24gZnJvbSBTTlBTLCBpbiBvcmRlcg0KPj4+PiB0byBkcmFpbiBw
b3RlbnRpYWxseSBjYWNoZWQgU0VUVVAgcGFja2V0cywgU1cgbmVlZHMgdG8gaXNzdWUgYQ0KPj4+
PiBTVEFSVFRSQU5TRkVSIGNvbW1hbmQuICBBZnRlciBpc3N1aW5nIHRoZSBTVEFSVFRSQU5TRkVS
LCBhbmQgcmV0cnlpbmcgdGhlDQo+Pj4+IEVORFRSQU5TRkVSLCB0aGUgY29tbWFuZCBzaG91bGQg
c3VjY2VlZC4gIEVsc2UsIGlmIHRoZSBlbmRwb2ludHMgYXJlIG5vdA0KPj4+PiBwcm9wZXJseSBz
dG9wcGVkLCB0aGUgY29udHJvbGxlciBoYWx0IHNlcXVlbmNlIHdpbGwgZmFpbCBhcyB3ZWxsLg0K
Pj4+Pg0KPj4+PiBPbmUgbGltaXRhdGlvbiBpcyB0aGF0IHRoZSBjdXJyZW50IGxvZ2ljIHdpbGwg
ZHJvcCB0aGUgU0VUVVAgZGF0YQ0KPj4+PiBiZWluZyByZWNlaXZlZCAoaWUgZHJvcHBpbmcgdGhl
IFNFVFVQIHBhY2tldCksIGhvd2V2ZXIsIGl0IHNob3VsZCBiZQ0KPj4+PiBhY2NlcHRhYmxlIGlu
IHRoZSBwdWxsdXAgZGlzYWJsZSBjYXNlLCBhcyB0aGUgZGV2aWNlIGlzIGV2ZW50dWFsbHkNCj4+
Pj4gZ29pbmcgdG8gZGlzY29ubmVjdCBmcm9tIHRoZSBob3N0Lg0KPj4+Pg0KPj4+PiBTaWduZWQt
b2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHF1aWNfd2NoZW5nQHF1aWNpbmMuY29tPg0KPj4+PiAtLS0N
Cj4+PiBKdXN0IHdvbmRlcmluZyBpZiB5b3UgaGFkIGFueSBpbnB1dHMgZm9yIHRoaXMgcGFydGlj
dWxhciBjaGFuZ2U/ICBJDQo+Pj4gdGhpbmsgb24gdGhlIGRlcXVldWUgcGF0aCBkaXNjdXNzaW9u
IHlvdSBoYWQgc29tZSBjb25jZXJucyB3aXRoIHBhcnRzIG9mDQo+Pj4gdGhpcyBjaGFuZ2U/ICBJ
IHRoaW5rIHRoZSBkaWZmaWN1bHQgcGFydCBmb3IgdGhlIHB1bGx1cCBkaXNhYmxlIHBhdGggaXMN
Cj4+PiB0aGF0IHdlIGhhdmUgdGhpcyBBUEkgcnVubmluZyB3LyBpbnRlcnJ1cHRzIGRpc2FibGVk
LCBzbyB0aGUgRVAwIHN0YXRlDQo+Pj4gd29uJ3QgYmUgYWJsZSB0byBhZHZhbmNlIGNvbXBhcmVk
IHRvIHRoZSBkZXF1ZXVlIGNhc2UuDQo+Pg0KPj4gVGhpcyBkb2Vzbid0IHNvdW5kIHJpZ2h0LiBU
aGUgcHVsbHVwIGRpc2FibGUgKG9yIGRldmljZSBpbml0aWF0ZWQNCj4+IGRpc2Nvbm5lY3QpIHNo
b3VsZCB3YWl0IGZvciB0aGUgRVAwIHN0YXRlIHRvIGJlIEVQMF9TRVRVUF9QSEFTRSBiZWZvcmUN
Cj4+IHByb2NlZWRpbmcsIHdoaWNoIGl0IGRvZXMuDQo+Pg0KPiBUaGF0IGlzIGNvcnJlY3QsIGJ1
dCBldmVuIHRob3VnaCB0aGF0IGNoZWNrIGlzIHBhc3NlZCwgaXQgZG9lc24ndA0KPiBwcmV2ZW50
IHRoZSBob3N0IGZyb20gc2VuZGluZyBhbm90aGVyIFNFVFVQIHRva2VuIGJldHdlZW4gdGhlIHBl
bmRpbmcNCj4gc2V0dXAgcGFja2V0IGNoZWNrIGFuZCBydW4vc3RvcCBjbGVhci4NCj4gDQoNClRo
YXQgc2hvdWxkIGJlIGZpbmUsIGJlY2F1c2Ugd2Ugd291bGQgaGF2ZSB0aGUgVFJCIHJlYWR5IGZv
ciB0aGF0IFNFVFVQDQpwYWNrZXQuDQoNCj4+Pg0KPj4+IElkZWFsbHksIGlmIHRoZXJlIGlzIGEg
d2F5IHRvIGVuc3VyZSB0aGF0IHdlIGF2b2lkIHJlYWRpbmcgZnVydGhlciBzZXR1cA0KPj4+IHBh
Y2tldHMsIHRoYXQgd291bGQgYmUgbmljZSwgYnV0IGZyb20gb3VyIGRpc2N1c3Npb25zIHdpdGgg
U3lub3BzeXMsDQo+Pj4gdGhpcyB3YXMgbm90IHBvc3NpYmxlLiAoY29udHJvbGxlciBpcyBhbHdh
eXMgYXJtZWQgYW5kIHJlYWR5IHRvIEFDSw0KPj4+IHNldHVwIHRva2VucykNCj4+Pg0KPj4+IEkg
ZGlkIGV2YWx1YXRlIGtlZXBpbmcgSVJRcyBlbmFibGVkIGFuZCBwZXJpb2RpY2FsbHkgcmVsZWFz
aW5nL2F0dGFpbmluZw0KPj4+IHRoZSBsb2NrIGJldHdlZW4gdGhlIHN0b3AgYWN0aXZlIHhmZXIg
Y2FsbHMsIGJ1dCB0aGF0IG9wZW5lZCBhbm90aGVyIGNhbg0KPj4+IG9mIHdvcm1zLiAgSWYgeW91
IHRoaW5rIHRoaXMgaXMgdGhlIGFwcHJvYWNoIHdlIHNob3VsZCB0YWtlLCBJIGNhbiB0YWtlDQo+
Pj4gYSBsb29rIGF0IHRoaXMgaW1wbGVtZW50YXRpb24gZnVydGhlci4NCj4+Pg0KPj4NCj4+IFRo
aXMgcGF0Y2ggZG9lc24ndCBsb29rIHJpZ2h0IHRvIG1lLiBUaGUgY2hhbmdlIEkgc3VnZ2VzdGVk
IGJlZm9yZQ0KPj4gc2hvdWxkIGFkZHJlc3MgdGhpcyAoSSBiZWxpZXZlIEdyZWcgYWxyZWFkeSBw
aWNrZWQgaXQgdXApLiBXaGF0IG90aGVyDQo+PiBwcm9ibGVtIGRvIHlvdSBzZWUsIEknbSBub3Qg
Y2xlYXIgd2hhdCdzIHRoZSBwcm9ibGVtIGhlcmUuIE9uZSBwb3RlbnRpYWwNCj4+IHByb2JsZW0g
dGhhdCBJIGNhbiBzZWUgaXMgdGhhdCBjdXJyZW50bHkgZHdjMyBkcml2ZXIgZG9lc24ndCB3YWl0
IGZvcg0KPj4gYWN0aXZlIGVuZHBvaW50cyB0byBjb21wbGV0ZS9lbmQgYmVmb3JlIGNsZWFyaW5n
IHRoZSBydW5fc3RvcCBiaXQgb24NCj4+IGRldmljZSBpbml0aWF0ZWQgZGlzY29ubmVjdCwgYnV0
IEknbSBub3Qgc3VyZSBpZiB0aGF0J3Mgd2hhdCB5b3UncmUgc2VlaW5nLg0KPj4NCj4+IFBsZWFz
ZSBoZWxwIGNsYXJpZnkgZnVydGhlci4gSWYgdGhlcmUncyB0cmFjZSBwb2ludHMgbG9nLCB0aGF0
J2QgaGVscC4NCj4+DQo+IE1haW4gZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSBpc3N1ZSBHcmVnIHJl
Y2VudGx5IHB1bGxlZCBpbiBhbmQgdGhpcyBvbmUNCj4gaXMgdGhhdCB0aGlzIGlzIG9uIHRoZSBw
dWxsdXAgZGlzYWJsZSBwYXRjaCAobm8gZGVxdWV1ZSBpbnZvbHZlZCkuICBJbg0KPiB0aGlzIHNp
dHVhdGlvbiB3ZSB3aWxsIGFsc28gc3RvcCBhY3RpdmUgdHJhbnNmZXJzLCBzbyB0aGF0IHRoZQ0K
PiBjb250cm9sbGVyIGNhbiBoYWx0IHByb3Blcmx5Lg0KPiANCj4gSSBhdHRhY2hlZCBhIGZldyBm
aWxlcywgYW5kIHdpbGwgZ2l2ZSBhIHN1bW1hcnkgb2YgdGhlbSBiZWxvdzoNCj4gMS4gIHB1bGx1
cF9kaXNhYmxlX3RpbWVvdXQudHh0IC0gZnRyYWNlIG9mIGFuIGluc3RhbmNlIG9mIHdoZW4gd2Ug
c2VlDQo+IHNldmVyYWwgZW5keGZlciB0aW1lb3V0cy4gIFJlZmVyIHRvIGxpbmUjMjAxNi4NCj4g
DQo+IDIuICBsZWNyb3krZnRyYWNlX3NuaXAucG5nIC0gcGljdHVyZSBzaG93aW5nIGEgbWF0Y2hp
bmcgYnVzIHNuaWZmZXIgbG9nDQo+IGFuZCBhIGZ0cmFjZSBjb2xsZWN0ZWQgKGRpZmZlcmVuY2Ug
aW5zdGFuY2UgdG8gIzEpDQo+IA0KPiAjMiB3aWxsIHNob3cgdGhhdCB3ZSBjb21wbGV0ZWQgYSBT
RVRVUCB0cmFuc2ZlciBiZWZvcmUgZW50ZXJpbmcgaW50bw0KPiBkd2MzX2dhZGdldF9zdG9wX2Fj
dGl2ZV90cmFuc2ZlcnMoKS4gIEluIGhlcmUsIHdlIHRoZW4gc2VlIERXQyBBQ0sNCj4gYW5vdGhl
ciBTRVRVUCB0b2tlbiwgd2hpY2ggbGVhZHMgdG8gZW5keGZlciB0aW1lb3V0cyBvbiBhbGwgc3Vi
c2VxdWVudA0KPiBlbmRwb2ludHMuDQoNClRoYW5rcyBmb3IgdGhlIGNhcHR1cmVzLiBJIHRoaW5r
IHRoZSBwcm9ibGVtIGhlcmUgaXMgYmVjYXVzZSB0aGUgZHdjMw0KZHJpdmVyIGRpc2FibGVzIHRo
ZSBjb250cm9sIGVuZHBvaW50LiBJdCBzaG91bGRuJ3QgZG8gdGhhdC4NCg0KQ2FuIHlvdSB0cnkg
dGhpczoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQppbmRleCBhYjcyNWQyMjYyZDYuLmYwYjllYTM1MzYyMCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCkBAIC0xMDEwLDEyICsxMDEwLDEyIEBAIHN0YXRpYyBpbnQgX19kd2MzX2dh
ZGdldF9lcF9kaXNhYmxlKHN0cnVjdA0KZHdjM19lcCAqZGVwKQ0KICAgICAgICBpZiAoZGVwLT5m
bGFncyAmIERXQzNfRVBfU1RBTEwpDQogICAgICAgICAgICAgICAgX19kd2MzX2dhZGdldF9lcF9z
ZXRfaGFsdChkZXAsIDAsIGZhbHNlKTsNCg0KLSAgICAgICByZWcgPSBkd2MzX3JlYWRsKGR3Yy0+
cmVncywgRFdDM19EQUxFUEVOQSk7DQotICAgICAgIHJlZyAmPSB+RFdDM19EQUxFUEVOQV9FUChk
ZXAtPm51bWJlcik7DQotICAgICAgIGR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19EQUxFUEVO
QSwgcmVnKTsNCi0NCi0gICAgICAgLyogQ2xlYXIgb3V0IHRoZSBlcCBkZXNjcmlwdG9ycyBmb3Ig
bm9uLWVwMCAqLw0KICAgICAgICBpZiAoZGVwLT5udW1iZXIgPiAxKSB7DQorICAgICAgICAgICAg
ICAgcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfREFMRVBFTkEpOw0KKyAgICAgICAg
ICAgICAgIHJlZyAmPSB+RFdDM19EQUxFUEVOQV9FUChkZXAtPm51bWJlcik7DQorICAgICAgICAg
ICAgICAgZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0RBTEVQRU5BLCByZWcpOw0KKw0KKyAg
ICAgICAgICAgICAgIC8qIENsZWFyIG91dCB0aGUgZXAgZGVzY3JpcHRvcnMgZm9yIG5vbi1lcDAg
Ki8NCiAgICAgICAgICAgICAgICBkZXAtPmVuZHBvaW50LmNvbXBfZGVzYyA9IE5VTEw7DQogICAg
ICAgICAgICAgICAgZGVwLT5lbmRwb2ludC5kZXNjID0gTlVMTDsNCiAgICAgICAgfQ0KDQoNClRo
YW5rcywNClRoaW5oDQo=
