Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40545740C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiGNBGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGNBGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:06:14 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659881E3E1;
        Wed, 13 Jul 2022 18:06:13 -0700 (PDT)
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AD3E640DC2;
        Thu, 14 Jul 2022 01:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657760773; bh=yizkHhpqhE0O0Bt4vUNyj2myaam/lYTKy+Q59YDJd7Q=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gYGwbikEICW0ERfIZzaPclHk74hWKRkWZIr1tDluAR/2eHtl1XflzCyaKho52/AiZ
         MRUUfhjGWK5/h9YMXGFVIa+uiQu/UFXl/gbu+ee91U/ZAAmRAtkhqsp08tNdAqdsV1
         25OvxKl9gplEbMP3YPB8uQ/6u0mjbA4G2s6z5xGiisprTwex7O8VJe24ihYeGlPpFK
         JT1tbSUGF7t2kFi89lfoCOBrP5EF3lSQJ2ITuw7LnfkA12XC+9ED5ZvYDnN11R3Icy
         cytiX+F2toAPYk52ErlHprObm0hcwYeEXcuhlfnkIOF4aP/PEKyxfSMBZgh2H68jIA
         DGP4ld0ofZpHQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D70A7A0071;
        Thu, 14 Jul 2022 01:06:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4ED264007A;
        Thu, 14 Jul 2022 01:06:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="SDUyqZlc";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0m48KPAmCi/cDo12ajvEhCKkxymZyhshiqZ1StA97w8dgVds4fp0Q8BbhSt9CzSEBrTiDSdTrIf2tS6eq/M5Jr3pi3z1dJ9sgE+sPNsNC5249U7QdNXhK3I/QBwtBes7Tb/MMfnw+vahH8rM8vvKEtwKRCbUPru+8TPTS1esSn1hG6bfa0ZB95yJTyzeAyD8sG3V2iHfARsI+ZM1pG6sruKt2UGaDeRTETBdIMuH1El+Y7UKPFCXKWGzmAJtZ6bdl/FbdDGudVS8p+o++0gAWXtdXVTcOIrpt1ME1dAFhJvLbQAtw4agYwnij1g+ZA7T9oJka4wnmzRvFdyPdA1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yizkHhpqhE0O0Bt4vUNyj2myaam/lYTKy+Q59YDJd7Q=;
 b=CeQ630LfwvC17Vmef5rfgRogfdB/9XJT9eKED5v3Y+xlVShFxTG36pqIRG2Xc1ykT26Ini3QnFMwFpHUH4NKlOCok/KIs5ddte6RMAjUiCGHS1py4n38WA0VLSyj9l+BYgSUu+swuX9UheRrhyTOYzTOoptdDdvJ9mA+GNcPTBUvmoU7b15fX6KA24bTTawEI6lnkOlHbzbuWkOOQVcsnlR+IJv4A8WxMHf5vVwSW3KAP6/tPlhVvCn62MegarZO4DwWZsnoOBipVDHbwGdKEkuDunNtH9LMvW1U0gRinrV7iS2qHpvjDho91hRAQNyuy9QBhvpd/MMmxBL/7nMrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yizkHhpqhE0O0Bt4vUNyj2myaam/lYTKy+Q59YDJd7Q=;
 b=SDUyqZlcPiin+b5GY1PjTdkWiP01H53m7hEP9AtLDaT3K3onvfFhpt4aEqgAl3o0O2vu9PNMvBk6uR2LsGk6NPwrKAJQr7Vn6GDcZHS2Rk8TR7cPbZ85wb3NZhuklZU4OYbIZzeU0rKnPeGE5go0cDpsjCsxox1jWAGoiHOLzPU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW2PR12MB2361.namprd12.prod.outlook.com (2603:10b6:907:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Thu, 14 Jul
 2022 01:06:07 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 01:06:07 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Rohith Kollalsi <quic_rkollals@quicinc.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: core: Do not perform GCTL_CORE_SOFTRESET
 during bootup
Thread-Topic: [PATCH] usb: dwc3: core: Do not perform GCTL_CORE_SOFTRESET
 during bootup
Thread-Index: AQHYlhcUoSw2MUi2REGiua07EWord619D5sA
Date:   Thu, 14 Jul 2022 01:06:07 +0000
Message-ID: <889f7a73-d8d9-2e40-3386-e8f3f30cad24@synopsys.com>
References: <20220712174423.20484-1-quic_rkollals@quicinc.com>
In-Reply-To: <20220712174423.20484-1-quic_rkollals@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12cf06b7-1435-4c2b-366a-08da65350842
x-ms-traffictypediagnostic: MW2PR12MB2361:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CcFufF59RrpeUwqpSCeRMMvDD7qYkRNM0yx9U6CCR0A9Z2RSyXFT/k0oMA1cMbarRFI9WwPMkuTNPboRyfqr2ig2nMV1zG6sHz9bI7gsj/GtMIIixcrjRaj6yQoUIaeL2IvQkz1MpdwIAsAnOKYFlk9XL1Ogm6sGBtlgtA5FswghCICS6EcsFqEFUQWB8EsfShx9l0QIG8EsY5wJ3EPC9O9WvJDx8gHzgLDbSOzREMQHhnfuD2EpPY0DIksAzzW4yW5IOgZOe6nd0bUl+HDZl7KnsJXZ/OZoCtI4g1p6VowTAqTUR1xbxnjV0B/+gVcrz9fZ4PQ9dJB8Sr/W2ezgxmpAaSq4bbO0QdywiqPIMh6SZv+oTGIs5dnTXOns42Gty/VxmCFURsBRE2ehcBOFkSyKVk2p8Uigx0qXsWLsk2tQZ0ifm4R8SWaZMdpNtb64oBxqV6j84zzL/vFawKddC6iIWF6CemSgBImdCnwFipcRd52I4uMV/ozncankWU9fL3j1IVp+NcByTfVJqd/Ij3D2OM8YUMOTvj0TwTs5TVtaFIQI1GWrDRWB4owGM1alYa9jPmwE+c8Ru9jz+HMlZvT8UeKoj8AmLJYwj2KEYtuVryxve1bPlTtLZ0RnNHPXDBuMgSW2+mWIz1JRQ4XwLLGEF/bJ3yffkeNvFNlHzVq3UKd+nZhlR1RMDLgQErftLV/pXXWNahOm+XKqOykXl13Mf5vY+rdmUtlcaXGbCft2MuJZxamx3pj4nBD1KaG8Y++TA7X9PGDr4Pvq4xuSAFqsEE0eR4B/R4yRugcHt7d8VN2kl+3VLpVM40CWdEnBijkQcmcfQt+RYyUpnWo3cV672tfnBeh4VHU3dex3+ZKuuaLYD9b7BQ7KO/yF3diI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(86362001)(31696002)(6486002)(31686004)(122000001)(38100700002)(8676002)(66476007)(66946007)(76116006)(66446008)(66556008)(64756008)(8936002)(4326008)(2906002)(2616005)(26005)(6512007)(316002)(186003)(83380400001)(5660300002)(71200400001)(54906003)(110136005)(41300700001)(478600001)(6506007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnlkN3lzbFh1QTBqeTZ5bEZzKzRhMGpDc3J2dHVIcVE4eTZURmc4MitXR1VJ?=
 =?utf-8?B?MHFsVkVDWWxhRjhybnRXMzgvclJvSjI2UWVUM21nSVVBdlVBWHlFMGRQSmZF?=
 =?utf-8?B?c2FicVdTanpEZzlzZlV1aHRQYU5ZczJJanlPME1pbVM1RFNNb1RtOXR0aGhS?=
 =?utf-8?B?VEhIV2Z4M1VTdUVjWjhBVDFqQ3ZVYXJqMC9DRHZHNmVnenhQcURUVTlmUnpE?=
 =?utf-8?B?ajNHWFEvdkc0bGxiL0hJYnJmbk02TlhhU2VDYmRUSDdqUm1MenhYMDZYNExm?=
 =?utf-8?B?Zm5MN0UvR0ZxSWFocFZFSUIwMkRsQTNoejdLUERiYjJMd0J3V1ZiS1lsOHlP?=
 =?utf-8?B?bEJvK3EzVU5hYmRSWXhNUEs5M25pbnBzTWFHekUwMTVXQkRJY3VJS2xBaGZR?=
 =?utf-8?B?RnBGUG9Ka1cvTFdMTWo0dFR4SnBNaGN6K3h4amk2NktnV3Q0OXBTUStEZ3JI?=
 =?utf-8?B?Z0tWeDJBcHp1RHlXOUlTVTQ4MmxXVFVNOU5yMjh3VlZwMXc5QXhFL1FPdjJS?=
 =?utf-8?B?QlY3WlpSRHB2ZjFNS0FSaGJNTjY0SUdZMzZCcFc3K1RVdUFqTHYvNlBpV0t3?=
 =?utf-8?B?cC9TenRyNU01L1pCZUZkazZqWXNQTHFWcnVLUTJDQjJGSkRDdWFXQ1p2RTNT?=
 =?utf-8?B?NlJiK2ZyaTh3TStLbTlHRXFPcHNoWHFpemVUemtpWWdPK2poNTU2eW1Cbkt4?=
 =?utf-8?B?NlYveFpvMCtPU2ZQbGRKUFdEV2ZhVmV4Rml3ejZaTHYxcWRXa1NHM2p0WkVo?=
 =?utf-8?B?djZpVHNEQlpiOGxXRjRXSWZoeUpEb3gzTzlkK2hVSWhTNDBzaExXVDVqZEly?=
 =?utf-8?B?ejFHcTNZbDlxamdJTXk5N2NWaU1kNmtWYUkwRmhyUElvbDQzQlMweCtzcy9V?=
 =?utf-8?B?Z0NWMkQ4eHNVNVpoSlNrNWRHWlE3YkIzdmpNbDNzcEVPZ3BvNXREN3lNZSsx?=
 =?utf-8?B?VlkzRkt2Ty96THArb2pydVFWemI0NU1abXl4dzdESTYrSElHUnBNODZHUjRj?=
 =?utf-8?B?RUhJMVBCc2tFNzhLVGxhOUxHK0VHN3JvM2FPM3RtRENjNjFpRnN3NTVuWlRH?=
 =?utf-8?B?TWFBNnVmSmhuTjhORkhGdnRoUmRpbkFxekFOdGszenJXZG10WHpBbm5sa2lh?=
 =?utf-8?B?Sy9rT3RBVU5XUnc5SllwcmxLa1lPSllyZ2lmbkFiOUh5clJVK2RORm1lQXNY?=
 =?utf-8?B?L29DWnZhSHBjMzN4clBQZmJ6djlOR2R4STNKb0FKWm0zMGJwVENvVTNTSjJW?=
 =?utf-8?B?bW1hSXVWRitUWTRncDFwMFhmMHlvaWl6WFlCaDh5WlRxODA2czgxMEo4c1pZ?=
 =?utf-8?B?UkYwWlUwR01mUEpXWXpiRUJqK0dOVXE4NklyYndsTFRpTklvQStPYWRMVzdG?=
 =?utf-8?B?ZGJvU3hqM2xyMmxUR3hkT2ZwWEZpM1dXdkswVGt3TTVJZ2psN3RoNFduK2FK?=
 =?utf-8?B?MnNYUmQ2dWUwcWFsNFVMUGFPeEp2SFpJNDhDVXgxRXR5YmthSXV1T1EwdnFv?=
 =?utf-8?B?K3o3UmtSUlYzekFQelhEbFkzbkdWWk1sbGtxSEpRU2lhLzk2R0xkZGdyM0Uw?=
 =?utf-8?B?MEZMczFTblF1dnE4Z29kV0h5cUhUaHE3OVJJUFA0MVNrdDY5UkxidlpOOG1S?=
 =?utf-8?B?bXlCd0lBaHJKbXgwa29KV2JGZXFKYTFGbEVXZ1l3WlExbys3cmNGa3FNRkxX?=
 =?utf-8?B?QkYzUDZBMGJqa0NnTGZaUm9xMnR2NVJrTWdLVzNveW03Z2VXM2pHM3B2Z3lS?=
 =?utf-8?B?aWsyVTZYZnpQd1dKeE5JSm1RZ0lhbVduK0JpSFRldFhNWDE0VW44ZzZJVktz?=
 =?utf-8?B?S09qR3p6K2VOTDY5ZVJ1dmV3S2VQekhOTGluWEl2cXprcFpKRmFOdDFPVjdh?=
 =?utf-8?B?L3dPcDlERFRtSWQ3d052M3RVeEExa3gzRkNuSkIxVVFkWm5nYU1ubG5VdnJB?=
 =?utf-8?B?L1IyUnkzaDFiQzZ2T0lkVUJJQ09uZll0MElGUGtuOEE4c0FMUlZLbkQ2Sldm?=
 =?utf-8?B?SXphTWJCTDRmSUt3b3QwYmY0OU5wWE5LdGlmK0JlWHNYR3NpRlIxUEhjbGRu?=
 =?utf-8?B?M0dJck84ek5rYXJDWXlOcHZIZWNrQ3RKbWh0NWJmUFhlcnVFamYveHRFYnNo?=
 =?utf-8?Q?ojdJrwUxq/dTZvvHxKOBEmViF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AE8D2FB17EE504A86EDDBCEC289B134@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cf06b7-1435-4c2b-366a-08da65350842
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 01:06:07.2263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOgpgGuU0Lq5+CIWCEjebnBnzJ5i+dU3Z/6FwCmy3ZX9FMRiRHM4uu05uT+wr1+jJyBmWX1myd+R/GDCf6UIHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2361
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xMi8yMDIyLCBSb2hpdGggS29sbGFsc2kgd3JvdGU6DQo+IEFjY29yZGluZyB0byB0aGUg
cHJvZ3JhbW1pbmcgZ3VpZGUsIGl0IGlzIHJlY29tbWVuZGVkIHRvDQo+IHBlcmZvcm0gYSBHQ1RM
X0NPUkVfU09GVFJFU0VUIG9ubHkgd2hlbiBzd2l0Y2hpbmcgdGhlIG1vZGUNCj4gZnJvbSBkZXZp
Y2UgdG8gaG9zdCBvciBob3N0IHRvIGRldmljZS4gSG93ZXZlciwgaXQgaXMgZm91bmQNCj4gdGhh
dCBkdXJpbmcgYm9vdHVwIHdoZW4gX19kd2MzX3NldF9tb2RlKCkgaXMgY2FsbGVkIGZvciB0aGUN
Cj4gZmlyc3QgdGltZSwgR0NUTF9DT1JFU09GVFJFU0VUIGlzIGRvbmUgd2l0aCBzdXNwZW5kYWJs
ZSBiaXQoQklUIDE3KQ0KPiBvZiBEV0MzX0dVU0IzUElQRUNUTCBzZXQuIFRoaXMgc29tZSB0aW1l
cyBsZWFkcyB0byBpc3N1ZXMNCj4gbGlrZSBjb250cm9sbGVyIGdvaW5nIGludG8gYmFkIHN0YXRl
IGFuZCBjb250cm9sbGVyIHJlZ2lzdGVycw0KPiByZWFkaW5nIHZhbHVlIHplcm8uIFVudGlsIEdD
VExfQ09SRVNPRlRSRVNFVCBpcyBkb25lIGFuZA0KPiBydW4vc3RvcCBiaXQgaXMgc2V0IGNvcmUg
aW5pdGlhbGl6YXRpb24gaXMgbm90IGNvbXBsZXRlLg0KPiBTZXR0aW5nIHN1c3BlbmRhYmxlIGJp
dCBvZiBEV0MzX0dVU0IzUElQRUNUTCBhbmQgdGhlbg0KPiBwZXJmb3JtaW5nIEdDVExfQ09SRVNP
RlRSRVNFVCBpcyB0aGVyZWZvcmUgbm90IHJlY29tbWVuZGVkLg0KPiBBdm9pZCB0aGlzIGJ5IG9u
bHkgcGVyZm9ybWluZyB0aGUgcmVzZXQgaWYgY3VycmVudF9kcl9yb2xlIGlzIHNldCwNCj4gdGhh
dCBpcywgd2hlbiBkb2luZyBzdWJzZXF1ZW50IHJvbGUgc3dpdGNoaW5nLg0KPg0KPiBGaXhlczog
Zjg4MzU5ZTE1ODhiICgidXNiOiBkd2MzOiBjb3JlOiBEbyBjb3JlIHNvZnRyZXNldCB3aGVuIHN3
aXRjaCBtb2RlIikNCj4gU2lnbmVkLW9mZi1ieTogUm9oaXRoIEtvbGxhbHNpIDxxdWljX3Jrb2xs
YWxzQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDEw
ICsrKysrKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCAwNTBiMmJhNTk4NmQuLjdjZTBlMDMzZDc1NSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTE1OCw5ICsxNTgsMTMgQEAgc3RhdGljIHZvaWQgX19kd2Mz
X3NldF9tb2RlKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gICAJCWJyZWFrOw0KPiAgIAl9
DQo+ICAgDQo+IC0JLyogRm9yIERSRCBob3N0IG9yIGRldmljZSBtb2RlIG9ubHkgKi8NCj4gLQlp
ZiAoKERXQzNfSVBfSVMoRFdDMykgfHwgRFdDM19WRVJfSVNfUFJJT1IoRFdDMzEsIDE5MEEpKSAm
Jg0KPiAtCSAgICBkd2MtPmRlc2lyZWRfZHJfcm9sZSAhPSBEV0MzX0dDVExfUFJUQ0FQX09URykg
ew0KPiArCS8qDQo+ICsJICogV2hlbiBjdXJyZW50X2RyX3JvbGUgaXMgemVybywgZG8gbm90IHBl
cmZvcm0gR0NUTF9DT1JFU09GVFJFU0VULg0KDQpUaGUgbGluZSBhYm92ZSBkb2Vzbid0IHJlYWxs
eSBleHBsYWluIHdoeS4gQ2FuIHlvdSByZXBocmFzZSBpdCB0byANCnNvbWV0aGluZyBsaWtlIHRo
aXMgb3IgdGhlIGVxdWl2YWxlbnQ6DQoiV2hlbiBjdXJyZW50X2RyX3JvbGUgaXMgbm90IHNldCwg
dGhlcmUncyBubyByb2xlIHN3aXRjaGluZy4gT25seSANCnBlcmZvcm0gR0NUTC5Db3JlU29mdFJl
c2V0IHdoZW4gdGhlcmUncyBEUkQgcm9sZSBzd2l0Y2hpbmcuIg0KDQpUaGFua3MsDQpUaGluaA0K
DQo+ICsJICogUGVyZm9ybSBpdCBvbmx5IGZvciBEUkQgaG9zdCBvciBkZXZpY2UgbW9kZS4NCj4g
KwkgKi8NCj4gKwlpZiAoZHdjLT5jdXJyZW50X2RyX3JvbGUgJiYgKChEV0MzX0lQX0lTKERXQzMp
IHx8DQo+ICsJCQlEV0MzX1ZFUl9JU19QUklPUihEV0MzMSwgMTkwQSkpICYmDQo+ICsJCQlkd2Mt
PmRlc2lyZWRfZHJfcm9sZSAhPSBEV0MzX0dDVExfUFJUQ0FQX09URykpIHsNCj4gICAJCXJlZyA9
IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dDVEwpOw0KPiAgIAkJcmVnIHw9IERXQzNfR0NU
TF9DT1JFU09GVFJFU0VUOw0KPiAgIAkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dDVEws
IHJlZyk7DQoNCg==
