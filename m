Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603E85A8D36
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiIAFP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiIAFP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:15:56 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2073.outbound.protection.outlook.com [40.107.96.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A354880507;
        Wed, 31 Aug 2022 22:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiNgQolJWU9ILe6JJdAkHNLXNw0xRB8R+wheUxwUS23EQ6/3IIL+17L4nC0W8OVT3TMu6FvZNJBXzFfhi4RgSsJrKjhKUxNtJrZE7Rp53HwsI5xvbZacflWj4z6q0OWIg3C9HBX9Ibf4IwJCqBMhhhVnqTZGbHdwsKhubnPSOUbOtJhMetZCXJLERw7FdZx4++Hqv2qq8A06v3Z7x3xThI7anHjw+GGO90/AD3/MrS2n1GtC//ZkNZCme5WPZNZZHVf0CBIlAssOnzy2nrhTTd+9L2xXNqa66qsGmIVYVTVDgrP61/7i7PWWhfYW8ZMlb6b5cnoqCjYROlLLEcK0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFgSYsXyXxP3L3YmvUumR30JnOvPSIT7Sfj/jo1GG5c=;
 b=PY/fAIZEWGT8lkjgScBc8466Ova4ytymPgdX7W35Ziqj337a6cMSJYAAsqPNQR17GVILPLy38Vgc64Ka82D9gE86yx7h/cwXWeJy5h+BSjKRDWZaFnmWSNG7J7u05IJmglGdMefR+ucMmjpxwZqFGwev6UIkZI/ETEPaKRI6yRINRFDShZjjOPA1alBM34zzJZhmPvPsxyBJRcQT5IGNjLAArkSpapa0XKA35bA0/uGkYt53SlANrtuUbJCPfHPl1U1REDAbJ4sdAjFJmW2tngOpdW8a1Tg0fNYiRgF4Z541IbdfNxx+kmM/ZIArJ3E2hKClhOcYOHGhsd0t3unriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFgSYsXyXxP3L3YmvUumR30JnOvPSIT7Sfj/jo1GG5c=;
 b=2kbG8j8TMy1TF3BtuzKzXvoy2hJfPhhaSUrOeCo2qQWMuFZl91jHwFETIrU9aCsgNng/Q1elACrpqJp/UDL5OOLL7v9XIMbTwumREO6jenI6tO1OWp3GV7SIYflvLpy7BgX4DOfuZGEKECwYiiYeMcwC5TR7jukf4gzuzD429c0=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 1 Sep
 2022 05:15:51 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::f5a1:c4e7:9c3e:3231]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::f5a1:c4e7:9c3e:3231%4]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 05:15:51 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Takahiro Kuwano <tkuw584924@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: RE: [PATCH 2/2] mtd: spi-nor: Add support for flash reset
Thread-Topic: [PATCH 2/2] mtd: spi-nor: Add support for flash reset
Thread-Index: AQHYu4bSUGIrY8nYfU66nbvPu6SLyK3J1VwAgAA0oCA=
Date:   Thu, 1 Sep 2022 05:15:51 +0000
Message-ID: <BY5PR12MB425897185209EFB1CDFCBD3ADB7B9@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20220829090528.21613-1-sai.krishna.potthuri@amd.com>
 <20220829090528.21613-3-sai.krishna.potthuri@amd.com>
 <11077b0e-0a79-401e-5232-1dc1d1a04d83@gmail.com>
In-Reply-To: <11077b0e-0a79-401e-5232-1dc1d1a04d83@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56a288f8-235f-4415-b4a6-08da8bd909d3
x-ms-traffictypediagnostic: MW3PR12MB4345:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Fkn36R9v+PCfmwnzJv1YoFlz2rf4n8dg2OnLvoJ0VHAGCubChM9HMb7at00xr3NK4PlsRB9CVtsz4bIYkMV8BlBON+9uZLyzb0LouEHa2g0EMgagYVjWOG2FJSJI5ctzzm32EJju2b9ibXSnbAAu2SegTTbxFQu4LPAst1DI23uABUf7W45rEhGqHUuE1gL0sPqXqf5uIw62nSleHGm8IDkEm9AUK1G7Vn2T5RB2YYWxGVzXHNZmCL8ZQD2cMUtfSWAoah3HYwkO3HAEArxlog3N+4nW0YI6oiyNCDPFIgeX6BbSuisA44CNtZtBnMgHmrRW5mdrimYlb5kdsdg/QEwma8ud4QVb9AaQiziFjVF8Mu0jPCMyz9jambAL04zeMrZ5YXrMLdAVkE8ypkahqU96uCwAwP0a7tK2Q86M5sQB0d7WNgyoldLjvJyV/E2gUF2dX4ZqgTqbGWpsmTKtDMj7pZwhKY9rZCVOQjhEwgPhhy4U177uXt+0JFDxT8Bvv6u66IekymoMXMaQqTpDKWD4VTOQoSlSx0fCrQh3KN4pp/RiBGFrrLfrtgr7aMTr/ZrNo5Wb09NoIxzLOt+pfjcrOdyzYAmkZfy+P2O3l6momPg9otG3alA8G5XZppHfPVdQ1NiIarJdxruZwa8BH5A/jxlfbnyFvPNOuJngNUBo8P+s+MCZytpT8mGXVuD0avWGKRtxSJi/rdbe2ctGecf3DHiNuO2ntR9KR0qmL1IHShX+dvZfH8UqQ6I5JhVwnXgmds7DisMjZHThnfQuWKTIZgqCK+e8WhQ5I2DIGs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(966005)(54906003)(316002)(186003)(66946007)(8676002)(71200400001)(110136005)(66556008)(4326008)(66476007)(76116006)(66446008)(64756008)(478600001)(5660300002)(8936002)(52536014)(7416002)(41300700001)(38070700005)(86362001)(122000001)(6506007)(26005)(2906002)(38100700002)(7696005)(53546011)(83380400001)(33656002)(55016003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEJGQzVpRlF4KzhLYWVjTlVWUW05SE1qNG5pdFBzNVhHWFRqb3JtR3FEVFNB?=
 =?utf-8?B?WWJhRzI1MUNmUE1XV1FxeGlMOFBsQzJkMDBDbmFzWkkyZDlOTllBR2x4WWtJ?=
 =?utf-8?B?MlNSWWFKWGV5WnJTSU1LMDdlQThEQnlseE9SeUtvaHd0OFNHd3d0NGxCVEVX?=
 =?utf-8?B?cDRpOVB0dUhoRTlwSUZORGxtNzlDdzVObDRMVVVXcTFLbG9QQU1JbnpRTVJE?=
 =?utf-8?B?cXcwWUtDMVpueEptbnJZcnNaSkhDRGFIK1BBeTZJV3c4SHREeHFVVFlYK202?=
 =?utf-8?B?TndGeFZaOFp1SWNINDhPMHVWUFVOZDhRekJuS0VBeWVwK0RLYmo0cS8xT1FI?=
 =?utf-8?B?dzI5TVUvMVRwakd5b0hTWWJUOWtJUUUwM3MrQ2IxNlJabzJ0aXF0TnpRSERK?=
 =?utf-8?B?VGFGU1UyWVVLbExWMEtPQkFzUjR6ZjF6T054OWRjVUdTTlZlTWZoSnNCSUwz?=
 =?utf-8?B?eW9aZkhCTkh6T2d6UHE4S2pzNVRERWp2V1JNVldVZi91MW1MK05ZZlpDR1RG?=
 =?utf-8?B?QmE0WFVIMnFmbXJnRWhZU1RRMlNjNk90aWxpeE1uaHpiS2s4c1RZOFovTkpw?=
 =?utf-8?B?YUZmSWZHcWwxNlVNazl1SFc4dEVzYjM4M2t0YkJpc21TSmZCRlJlZUVVaE1P?=
 =?utf-8?B?TXpMR29xY3ZoRnNRUkp5clNUTjI2d3NpcTkzWnU1L004aHl1YnpQQWQvTmZw?=
 =?utf-8?B?NzlRdXFYZWMxYTFrb1BGRmFxcHoxdzE3M0FwS0JkeWpGS0xuczJmaXQ5dkUx?=
 =?utf-8?B?M0Q2aTZ4a3RLb25hMGZQL01JOHlKbi96eUFsUzVMNFlMYlBzMVJJdXM0Umh4?=
 =?utf-8?B?VURpQThiRjNYSWI1OXNBalJ2NmNWTlJKQ0dPTlBQVmlycFpBa3FwcHhjRUU5?=
 =?utf-8?B?bUg2ZFVTYkpaMW9zQ1dwTFA3eStJbS94TWhEQmRvRDhRRFlLRG9pM01XVmtS?=
 =?utf-8?B?cVNiL2txNEhIMCtONWxtYXQ5OEIrT0U4eGRxTG1BSFRRY0o1QW5qZ3N1WHJz?=
 =?utf-8?B?Q2lJamp6bTU1WVcwak00ZVB6THBTeEZuQ0RKbHRxNVJJMGdCelN0NVg5NEdC?=
 =?utf-8?B?THd4L3lQNUNlWDJvV0UxWGZMMWRxTHVmQjBRRnVkUkpHdEMyMm1Od2czbVU3?=
 =?utf-8?B?Q3Q4SGgyVzA2YUgzeE9jRXJPbHhnKzlBR1FJOU1vQm9CL0xscEh0RjRCTVpR?=
 =?utf-8?B?cDl4UWdGMGcyckIvZjhMcnBjQllTY1laSzdQSTRreFJDNEVaQ3dXODBGY1Rq?=
 =?utf-8?B?bThZem93MkdXNW9wc01qNkVWMUc4OHZOMWZ3NzVxcVovL2xKaDJDRklWSDRT?=
 =?utf-8?B?RnR5dFBzVW1yY3Q0VzFya1JaMHZZanhBcmgrdmRaQ0J0c2dyc1dmcDl4UGNk?=
 =?utf-8?B?Q3lLa2xpVmtKWFNIbnlIVzRQK0t4Ri9Zbm0rMXh3Z3dNZ1VuSndMRUhTYzJh?=
 =?utf-8?B?V1BaMVJ6M0xUUm5hcnp4ODBvZXJMT09CTWI5MWQ0cytlV3V1RzNSUmMzT0dF?=
 =?utf-8?B?VytGZ3p1OE1RMEQ1NFRrWGkxRU1qRDg4VFdFTUFQU01INXcySkNJVGgyR1g5?=
 =?utf-8?B?M3FGdmZBNGt6YXpHOG1wQkhkcUFTWlpmRzlGamVuVjVkTDJlc0xqN0lBWlNT?=
 =?utf-8?B?L1FMSFVnUUhxUDlUR09hUklIR1ZaQ2oxNHJFSGQ2c1d0OXJqUkd4RHpGcFVj?=
 =?utf-8?B?NSswaUgrNTFwL1R1S1oyUkFUc25NZGFrQitSc25acW40Z3Z5Q20ydW04M2pX?=
 =?utf-8?B?MEozeW1leUZ5OUtXL0ZFK1BkZ2ZUYjlENmZobHAvRTlBbElRNmk3RGhDOEdT?=
 =?utf-8?B?TWNZYVNnRzRXQWxPbjFsS29ZVElKS2hlcTJnSEFmamlFcWh1NlpmV3VFODJO?=
 =?utf-8?B?dExBdFlqOU1LcVYvQTZYYmJWNWUrenR2OUpxTXZma1hhVTZ5YjM3U0gzajNn?=
 =?utf-8?B?a1JhVjBpM3JEYTRyUnVMTnZ1K0t1cTVPYWd4b1lXTnFLdGtWbXlZM0ViMlNu?=
 =?utf-8?B?WTR5N2p5d1Iva0VscTZXemNEcDV4b09SMDh4aG9pdVkrK084ZzB6NFhZa29B?=
 =?utf-8?B?OTJZT2Vqd0hGREd5SDNNUndmS3BWOUpWS2xySFpmcjVyVzZxS3BHZUgrKzFq?=
 =?utf-8?Q?3C8w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a288f8-235f-4415-b4a6-08da8bd909d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 05:15:51.4911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GHcmjSyX0OuIk7pz2Y3RydUi1hPB+G0jWU4zBsrr/UOxxL3X1b5XGhdw10JZ1UUatulUEteVMN2i9GUXM5sAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGFrYWhpcm8gS3V3YW5vLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IFRha2FoaXJvIEt1d2FubyA8dGt1dzU4NDkyNEBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBTZXB0ZW1iZXIgMSwgMjAyMiA3OjI4IEFNDQo+IFRvOiBQb3R0aHVyaSwgU2FpIEtyaXNo
bmEgPHNhaS5rcmlzaG5hLnBvdHRodXJpQGFtZC5jb20+OyBUdWRvciBBbWJhcnVzDQo+IDx0dWRv
ci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+OyBQcmF0eXVzaCBZYWRhdiA8cHJhdHl1c2hAa2VybmVs
Lm9yZz47DQo+IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+OyBNaXF1ZWwgUmF5bmFs
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPjsgUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNo
YXJkQG5vZC5hdD47DQo+IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT47IFJv
YiBIZXJyaW5nDQo+IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+
IDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+DQo+IENjOiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzYWlrcmlzaG5hMTI0NjhAZ21haWwuY29tOyBnaXQgKEFN
RC1YaWxpbngpDQo+IDxnaXRAYW1kLmNvbT47IHRha2FoaXJvIEt1d2FubyA8VGFrYWhpcm8uS3V3
YW5vQGluZmluZW9uLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIG10ZDogc3BpLW5v
cjogQWRkIHN1cHBvcnQgZm9yIGZsYXNoIHJlc2V0DQo+IA0KPiBIZWxsbywNCj4gDQo+IE9uIDgv
MjkvMjAyMiA2OjA1IFBNLCBTYWkgS3Jpc2huYSBQb3R0aHVyaSB3cm90ZToNCj4gPiBBZGQgc3Vw
cG9ydCBmb3Igc3BpLW5vciBmbGFzaCByZXNldCB2aWEgR1BJTyBjb250cm9sbGVyIGJ5IHJlYWRp
bmcgdGhlDQo+ID4gcmVzZXQtZ3BpbyBwcm9wZXJ0eS4gSWYgdGhlcmUgaXMgYSB2YWxpZCBHUElP
IHNwZWNpZmllciB0aGVuIHJlc2V0DQo+ID4gd2lsbCBiZSBwZXJmb3JtZWQgYnkgYXNzZXJ0aW5n
IGFuZCBkZWFzc2VydGluZyB0aGUgR1BJTyB1c2luZyBncGlvZA0KPiA+IEFQSXMgb3RoZXJ3aXNl
IGl0IHdpbGwgbm90IHBlcmZvcm0gYW55IG9wZXJhdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFNhaSBLcmlzaG5hIFBvdHRodXJpIDxzYWkua3Jpc2huYS5wb3R0aHVyaUBhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyB8IDUwDQo+ID4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQ2
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiA+
IGluZGV4IGYyYzY0MDA2ZjhkNy4uZDQ3MDNmZjY5YWQwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3Jl
LmMNCj4gPiBAQCAtMjQwMSwxMiArMjQwMSw4IEBAIHN0YXRpYyB2b2lkIHNwaV9ub3Jfbm9fc2Zk
cF9pbml0X3BhcmFtcyhzdHJ1Y3QNCj4gc3BpX25vciAqbm9yKQ0KPiA+ICAgKi8NCj4gPiAgc3Rh
dGljIHZvaWQgc3BpX25vcl9pbml0X2ZsYWdzKHN0cnVjdCBzcGlfbm9yICpub3IpICB7DQo+ID4g
LQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gc3BpX25vcl9nZXRfZmxhc2hfbm9kZShub3IpOw0K
PiA+ICAJY29uc3QgdTE2IGZsYWdzID0gbm9yLT5pbmZvLT5mbGFnczsNCj4gPg0KPiA+IC0JaWYg
KG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgImJyb2tlbi1mbGFzaC1yZXNldCIpKQ0KPiA+IC0J
CW5vci0+ZmxhZ3MgfD0gU05PUl9GX0JST0tFTl9SRVNFVDsNCj4gPiAtDQo+ID4gIAlpZiAoZmxh
Z3MgJiBTUElfTk9SX1NXUF9JU19WT0xBVElMRSkNCj4gPiAgCQlub3ItPmZsYWdzIHw9IFNOT1Jf
Rl9TV1BfSVNfVk9MQVRJTEU7DQo+ID4NCj4gPiBAQCAtMjkzMyw5ICsyOTI5LDQ3IEBAIHN0YXRp
YyB2b2lkIHNwaV9ub3Jfc2V0X210ZF9pbmZvKHN0cnVjdCBzcGlfbm9yDQo+ICpub3IpDQo+ID4g
IAltdGQtPl9wdXRfZGV2aWNlID0gc3BpX25vcl9wdXRfZGV2aWNlOyAgfQ0KPiA+DQo+ID4gK3N0
YXRpYyBpbnQgc3BpX25vcl9od19yZXNldChzdHJ1Y3Qgc3BpX25vciAqbm9yKSB7DQo+ID4gKwlz
dHJ1Y3QgZ3Bpb19kZXNjICpyZXNldDsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJcmVz
ZXQgPSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbChub3ItPmRldiwgInJlc2V0IiwgR1BJT0RfQVNJ
Uyk7DQo+ID4gKwlpZiAoSVNfRVJSX09SX05VTEwocmVzZXQpKQ0KPiA+ICsJCXJldHVybiBQVFJf
RVJSX09SX1pFUk8ocmVzZXQpOw0KPiA+ICsNCj4gPiArCS8qIFNldCB0aGUgZGlyZWN0aW9uIGFz
IG91dHB1dCBhbmQgZW5hYmxlIHRoZSBvdXRwdXQgKi8NCj4gPiArCXJldCA9IGdwaW9kX2RpcmVj
dGlvbl9vdXRwdXQocmVzZXQsIDEpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0
Ow0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBFeHBlcmltZW50YWwgTWluaW11bSBDaGlwIHNl
bGVjdCBoaWdoIHRvIFJlc2V0IGRlbGF5IHZhbHVlDQo+ID4gKwkgKiBiYXNlZCBvbiB0aGUgZmxh
c2ggZGV2aWNlIHNwZWMuDQo+ID4gKwkgKi8NCj4gPiArCXVzbGVlcF9yYW5nZSgxLCA1KTsNCj4g
PiArCWdwaW9kX3NldF92YWx1ZShyZXNldCwgMCk7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAq
IEV4cGVyaW1lbnRhbCBNaW5pbXVtIFJlc2V0IHB1bHNlIHdpZHRoIHZhbHVlIGJhc2VkIG9uIHRo
ZQ0KPiA+ICsJICogZmxhc2ggZGV2aWNlIHNwZWMuDQo+ID4gKwkgKi8NCj4gPiArCXVzbGVlcF9y
YW5nZSgxMCwgMTUpOw0KPiA+ICsJZ3Bpb2Rfc2V0X3ZhbHVlKHJlc2V0LCAxKTsNCj4gPiArDQo+
ID4gKwkvKg0KPiA+ICsJICogRXhwZXJpbWVudGFsIE1pbmltdW0gUmVzZXQgcmVjb3ZlcnkgZGVs
YXkgdmFsdWUgYmFzZWQgb24gdGhlDQo+ID4gKwkgKiBmbGFzaCBkZXZpY2Ugc3BlYy4NCj4gPiAr
CSAqLw0KPiA+ICsJdXNsZWVwX3JhbmdlKDM1LCA0MCk7DQo+IEluZmluZW9uIChTcGFuc2lvbi9D
eXByZXNzKSBTRU1QRVIgZmxhc2ggKFMyNUhML0hTLCBTMjhITC9IUykgZmFtaWx5DQo+IHNwZWNp
ZmllcyBtaW5pbXVtIHRSSCAoUmVzZXQgUHVsc2UgSG9sZCAtIFJFU0VUIyBMb3cgdG8gQ1MjIExv
dykgYXMNCj4gNDUwfjYwMHVzLiBQbGVhc2UgdGFrZSBjYXJlIGZvciB0aGlzLg0KPiANCj4gUGxl
YXNlIGZpbmQgZGF0YXNoZWV0cyBhdCB0aGUgZm9sbG93aW5nIGxpbmtzLg0KPiANCj4gaHR0cHM6
Ly93d3cuaW5maW5lb24uY29tL2RnZGwvSW5maW5lb24tDQo+IFMyNUhTMjU2VF9TMjVIUzUxMlRf
UzI1SFMwMUdUX1MyNUhMMjU2VF9TMjVITDUxMlRfUzI1SEwwMUdUXzI1Ng0KPiAtTWJfKDMyLU1C
KV81MTItTWJfKDY0LU1CKV8xLUdiXygxMjgtTUIpX0hTLVRfKDEuOC1WKV9ITC1UXygzLjAtDQo+
IFYpX1NlbXBlcl9GbGFzaF93aXRoX1F1YWRfU1BJLURhdGFTaGVldC12MDJfMDAtDQo+IEVOLnBk
Zj9maWxlSWQ9OGFjNzhjOGM3ZDBkOGRhNDAxN2QwZWU2NzRiODZlZTMmZGE9dA0KPiANCj4gaHR0
cHM6Ly93d3cuaW5maW5lb24uY29tL2RnZGwvSW5maW5lb24tDQo+IFMyOEhTMjU2VF9TMjhIUzUx
MlRfUzI4SFMwMUdUX1MyOEhMMjU2VF9TMjhITDUxMlRfUzI4SEwwMUdUXzI1Ng0KPiAtTWJfKDMy
LU1CKV81MTItTWJfKDY0LU1CKV8xLUdiXygxMjgtTUIpX0hTLVRfKDEuOC1WKV9ITC1UXygzLjAt
DQo+IFYpX1NlbXBlcl9GbGFzaF93aXRoX09jdGFsX0ludGVyZmFjZS1EYXRhU2hlZXQtdjAzXzAw
LQ0KPiBFTi5wZGY/ZmlsZUlkPThhYzc4YzhjN2QwZDhkYTQwMTdkMGVlNmJjYTk2Zjk3JmRhPXQN
ClRoYW5rcyBmb3Igc2hhcmluZyB0aGlzIGluZm9ybWF0aW9uLg0KSSB3aWxsIHRha2UgY2FyZSBv
ZiB0aGlzIGluIHYyLg0KDQpSZWdhcmRzDQpTYWkgS3Jpc2huYQ0K
