Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15524C65BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiB1Jds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiB1Jdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:33:45 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120082.outbound.protection.outlook.com [40.107.12.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895E140932;
        Mon, 28 Feb 2022 01:33:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqVXvKKXToS7P1yEk+Dug2mBZTvVlrc65B3A+5+xilVj/n2I+7ojPXfFHmXup41jNWhnqViKCweT6ueTZZeZ01HhwMELK5qJIhFKmDBWvv0kef/5QZ4VggIad/nR8lTtND3Nrw9zomxBdMNOqvguUdN7MfBtTgMp+a5gyNmjEmE7cN6Iw139G8F75jPhWK9mMnIoU/Wmwuuw/BFqZWW86PNtCsNqOuFWnUeJVaT6198nUXkx6aDfgV6FmwuhaCmJ7XtrGM6eu+qocX4T/PJRB2uxuivoK+wD2QdmAmvq5FJWABL95G+ysUa/Cmr5bFVYWN3e9rZePaCKEWm/8chfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MLFwjWsNIeTZG+TF6XgDilSGJImIKR/i2tBEY23/Ck=;
 b=RufO+hS7SMh5YjP0ZPLe7RRx5zM5L4K2pL+YgPTpcXmua0sYRNaLk8b9z/lc46ck11jXItB4LtL6nztl9TxltE/AkI4nsyM5XxE8QS9ZwW0yNEWAj/c3wZhU0Un4eYN8wldiriFIL5/wTf+iE1EHs7lLzsBqUnljY/nOZyQc1MInZZD1LTgrYcVNFSOOXaKvbY4Jsxr675tTZAwmDFpwe7TZ3NfryaKlvtUmcHsPAJVpoIPS3nfFQ/y3+hGuzUVoyJKx//UqyLgfjRoWjioIxglu96pMgX3XJIvPReDpGkJy0TuZyl+nvDlZdRa9dFprvOAMd7Ah9F+PsAWnXlzlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1660.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 09:33:03 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%5]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 09:33:03 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@atomlin.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Petr Mladek <pmladek@suse.com>, "cl@linux.com" <cl@linux.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH v8 09/13] module: Move kallsyms support into a separate
 file
Thread-Topic: [PATCH v8 09/13] module: Move kallsyms support into a separate
 file
Thread-Index: AQHYJ/ZZRfC599+XvUO2sDt7Xl3WR6ykAICAgAADaYCAAA2CAIAAAy8AgAAgBwCAAAn0gIACECQAgAJlSoCAAAgbAIAAAFEA
Date:   Mon, 28 Feb 2022 09:33:03 +0000
Message-ID: <aa104381-80e2-2c8c-6bfa-974483d497df@csgroup.eu>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-10-atomlin@redhat.com> <YhieKf9EcS3GQSXG@alley>
 <f9449aa6-be9d-9021-66e7-fb0272909ee7@csgroup.eu> <YhisWkgZCK8dz5fl@alley>
 <CANfR36gsRw26C3M0hXGGK2w_05pC0rzkhg0-3Q+8tr_XxLiqiw@mail.gmail.com>
 <CANfR36iKJ6pHU5gm3HKqTPZ=FGsC5qX316UKt2sN0aMFEODA9w@mail.gmail.com>
 <aad10c3f-ecaf-c8fb-f1c6-81ba6f1c4f8d@csgroup.eu>
 <YhqNRoEgIaoplF9b@bombadil.infradead.org>
 <5caa95d8-ba59-30f3-198d-b67389817762@csgroup.eu>
 <20220228093154.5gzs3ega23l7fwks@ava.usersys.com>
In-Reply-To: <20220228093154.5gzs3ega23l7fwks@ava.usersys.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a112da47-ba0f-44cb-1a77-08d9fa9d518c
x-ms-traffictypediagnostic: PR0P264MB1660:EE_
x-microsoft-antispam-prvs: <PR0P264MB1660C9437C1656D6D5FD6F46ED019@PR0P264MB1660.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7AYh1Sw0LOqklNNkL48/Tez6FYaBAAk4On5oR8y4KvxSMxVb/5DbC3+w35952aEM1hi6sXE/olYHczu3y1BkiI+osryew8BhhjtdXTGYsOslS4rSPuJyIrT8ef9HMBkYitx9LS83pfm9QKeByq/Sgc4Pc8eoCmXMYHCLU42uFoRfJpvFtkhNaDEjVZhZ0ZrPUYgflLHPl/AIa6OKYcuCIH3EMW+9JyLPd4yy62jG8PTqU7vIIkwHex2U5ocf4LT3t7AiyZjf4PDegRoz1qBfb0oRBGA87FeiApJDLvjdLjmQ+x3wPTNlprcoArdXN2lRjLh26exH64/45fZtvz84MqVh1RVVQqPKPn2FOGHOMDb3ltzUO/rk9v9ioIRMnYqdO4s0IcI0fz5h+4zo0umGsFgN9T2akqbVvt263OtGxi+SIa9LDMNPAHl1nsN/2I1zXgEBM/zYsX1jAnyO8MCUTNvVTjkcaHWrRHa1QZpg6DEtafr+g/8SlMi9tiC77fKEIQQnbHjAe/OUG+iaiqkdOa32EieUPnqVy9Q3LRduuxSWotYv0oxAZaCWOLpzUpev2jM23oN6wqhdjwnXXUvKgLGqebDvRW+nNQjVnIE9dZ5u3sb84jBwxCqd5MCjGjByPY3ax/JlviW3F/F/YH3Ad/sRSBitYj9TNorGDwWb6BWMOyihveL3T+sAlcaXDD4DXSvpKgpiUHL7MWhkm8GpZYksr3qUxN4+J4g/PtBHkchxhHDrYaww+WMPb6pBLu24C4jqe2vzoSVF2FstooyIew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(316002)(6486002)(66574015)(83380400001)(31696002)(54906003)(508600001)(71200400001)(26005)(186003)(86362001)(38070700005)(38100700002)(66946007)(31686004)(2906002)(122000001)(5660300002)(7416002)(8936002)(4744005)(91956017)(44832011)(2616005)(6506007)(6512007)(64756008)(66476007)(66556008)(66446008)(8676002)(76116006)(4326008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0M5b2FZU2Z2eVdweURlbUFFUGh0MGF6TVZUWUpSWXg0eEoxb0FDYWUrZ1FL?=
 =?utf-8?B?bUJ2ck11eTZJSkYxMFlidmlFOCs0QzFIVEF0WXcyVEFZNi9ZYVNQNFRQM0do?=
 =?utf-8?B?amwvMlI2YWNzcEg5WW9hV0tZdmpRZ2F1ZU1JUTFEQmVUcUdYSjVjSW1ZVksz?=
 =?utf-8?B?ZDZ3ZXJMY1h1YXkrZUp6cFZleUNBT25kYkRkRzNneCs3VEdPL2JSbnVXVUZF?=
 =?utf-8?B?WTcwU0hIMmtJeW1nSGE1S2dwYnMzd1ZjUS9TUVJyTGdnd2xzNUp2MjNETlY0?=
 =?utf-8?B?N3haenpDYzA2SFVlQnNPNG04dzFzbWZ3TWhnQjI2QXRmcTR6MzhQWVRQQ0pW?=
 =?utf-8?B?Vi9jSWtGSW9NWTZNbVpseFZEUXZPUTduVzNTaVNTMXk5VWJORmhtbEZVajRz?=
 =?utf-8?B?Y1FFQlVZb3BsbU03VmtUS25kT1p6dkVwOGcxYU4zdjhvRWxzMG1zVXByWHBu?=
 =?utf-8?B?WWYvL2tQVXE0OGt2Vlp6eTFkMUNLVWdWYnAxQjM4UVNodmw5cnRlbWQ4d0FJ?=
 =?utf-8?B?bXpTSk55RDlyYlIzMmUvclkwdW1ralRsU1V2T2QwVXNhU0YreHVKV2dreHV5?=
 =?utf-8?B?ZXZvZEExZmtmdGN0ZmVNb25Dd21IRDViMHlaZlNza3J4REdGZW1WdmN2bGIz?=
 =?utf-8?B?UXBuTllsMDdYdkdrakNxeEZ4dGNJT0ZpcFd6dFFqd1ZNcjJuU1QrZnN0bmpK?=
 =?utf-8?B?eEwreDJYQ29LWkhLYW02eDQ5SEV4RU5LWkE3MjFNb3hweHBiTlZDelowNVdm?=
 =?utf-8?B?UHBMeEMvQUpEdEt6M09PUy9PMmc1U1ZmQ0VOZVZKbkp2TGM5cW0xOWlid0RJ?=
 =?utf-8?B?RWdmUXJ5SW5tZDJuNEdkKzhqWmlLVE4rNzl5by9RekZpZXdKWGVMV3RmN3J2?=
 =?utf-8?B?TEpvbTFsSjYzeXdCd3o1d09NczJYdDIxVjk4bVBiSlpsbkVMT2Y0U2JuVDd1?=
 =?utf-8?B?bUYvZHkvM1V3QTdnUTh4UHhsZXhka0tVbVEyZDBrRTZvZlhQYVZRTGFhVzFG?=
 =?utf-8?B?c0dWYUVuSXRqVVJqYjIrOEpjNEJKajE2dzdTbHRsQ1lSYU15SFhrc2F4ays2?=
 =?utf-8?B?dVhqS0l0YnJOSUFLb3Nmek41Z3VvaldadmtkVjZMKzF0eFh5dTdTVzNCRk1X?=
 =?utf-8?B?VmE3Z1F3S1BSK1hMMXR3R2ZiUTJYczNsRzdWSTQ2RzNHcklKNklEUzVzcnJ6?=
 =?utf-8?B?TFUyMzFzbXI0VEpxenVUcDBldFkrR080dmN5UmZkaU95d3QreDJ3ZkNvcEpa?=
 =?utf-8?B?ZDRFVUczbXBUK2cvUUNZR0VsK2V0cWhCOVJKT2dGNzhiTW9kSGZFMFNpdlpu?=
 =?utf-8?B?bmZzTERDNnlVNWwrRVFablV5TE4yMC9nSUZBcFJObjhxVHluVXZmcDZqdmE1?=
 =?utf-8?B?cmtkOFJnOFlsTC9VTUdpZngwTVFsZGowZ1lZT1ZrRXYwK3JYQ3VvdDJKLzRs?=
 =?utf-8?B?ajQzczFMMkM4SG9CYVlJVk4vdkpnQ2lBSFY0UkE4bGZXNGJrWldjSTcvcUl1?=
 =?utf-8?B?WlNrM2lmRDVZSE9tZnU2MjZ1SjQyTzFXQ01XRVZXSjV6NzlqbUNXT002TVpS?=
 =?utf-8?B?VUpvcWRiWTJ2UnJoZGdZcXNFcEtDSHljWTJEWHAwWUg5TkJGR2w5RXlHTkcr?=
 =?utf-8?B?NVErTkRyZW1HMUlmbFR6WnpuZ3dYRmROSHJ0TnI1S2JNQWdkT29MNmExWlVx?=
 =?utf-8?B?SzA3N1IvUm4vdjluTERzYk1GeGQ4MWlxaVVoS2pXV3RLUWNnS3hmc283Zk5L?=
 =?utf-8?B?N3lXVDlqRmFLVDRpMWREZVIrK0Y2R0ZzWUhYamRTd1kxb1ZJWTdMaWl0YkV6?=
 =?utf-8?B?d0dHdmVWS3R4TGl1dEx6ekk4WmJDMDNmZUdZUy90Ykk3bHJ5a1p5aStTeTVP?=
 =?utf-8?B?bnJ0RVc2UmdXdTRBTlpLQm81Q0xvcExTTGV2ZlY4MUJrUzNVay9keUFwb0Ez?=
 =?utf-8?B?eVhiSGpzS0Z6Tk54d3JqZEVQTk50UE1UaHFQWXQ5MGV6NlVhTEl4eVlvZzZJ?=
 =?utf-8?B?aW93cUxuSXRvRko3ZUxRV1MvWU5WMksrd1dTM2k0bS9PRWxVM2FvVzlZWHBS?=
 =?utf-8?B?aFVoZmYwUUdvemJ6VFNhRVozd0hrcFdYVmJRNnMwUzdRREI2dlp6NDNYTXVP?=
 =?utf-8?B?em1kcWpiamt5akgxUWlkMkx0ZEgzRU1Fd2lOQk02bUJEN2FRVGVCV0tJNkZq?=
 =?utf-8?B?bXIzbHdaYkY3eXlWMUFjNURFQ0FFdE1YV3JmeHNadUVXVHVWL1U4eVdqT3pt?=
 =?utf-8?Q?3sGfW9T3TqvMx7Z07eTFQ/wqmrYLUbIisIGU8hvHUc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C32E10A668FB35469364D68BAD0CA435@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a112da47-ba0f-44cb-1a77-08d9fa9d518c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 09:33:03.3800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMW/3pXW/FQNo7rb21cTSZjoXUZI+jyb3r5XJFPFD9NoCMMLUBi+uQDNgqI0c3pAKNN9xjJGCf+ntA3VLBDswi0gee2oNS/5lxHS9xrSWBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1660
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI4LzAyLzIwMjIgw6AgMTA6MzEsIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBP
biBNb24gMjAyMi0wMi0yOCAwOTowMiArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+
IEFhcm9uLCBkbyB5b3UgcGxhbiB0byBzZW5kIHY5IGFueXRpbWUgc29vbiA/DQo+IA0KPiBIaSBD
aHJpc3RvcGhlLA0KPiANCj4gWWVzLCB0b2RheS4NCj4gDQo+IEFzIGRpc2N1c3NlZCBwcmV2aW91
c2x5LCBJIHdpbGwgcmVzb2x2ZSB0aGUgU3BhcnNlIHdhcm5pbmdzLCBpbiB0aGUgY29udGV4dA0K
PiBvZiBLY29uZmlnIENPTkZJR19LQUxMU1lNUywgd2l0aCBhbiBhcHByb3ByaWF0ZSBzdGF0ZW1l
bnQgaW4gdGhlIGNvbW1pdA0KPiBtZXNzYWdlLCBhcyBhIHByZWxpbWluYXJ5IHBhdGNoIHRvIHRo
ZSBzZXJpZXMuIFRoYXQgYmVpbmcgc2FpZCwgSSBiZWxpZXZlDQo+IGl0IG1ha2VzIHNlbnNlIHRv
IGluY2x1ZGUgdGhlIGFmb3JlbWVudGlvbmVkIHBhdGNoIHdpdGhpbiB0aGUgc2VyaWVzLg0KPiBB
bnkgb2JqZWN0aW9ucz8NCj4gDQoNCk5vIG9iamVjdGlvbi4NCg0KVGhhbmsgeW91DQpDaHJpc3Rv
cGhl
