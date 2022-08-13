Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D34591BF5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 18:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbiHMQOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 12:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbiHMQON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 12:14:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FECF5B1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 09:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660407252; x=1691943252;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DpPLFh7zeZbmQYpt+A8J6d1FwvqRSRRNuiETtXvd/nk=;
  b=oCZETtCWw6ME/yDMokUWxw51CpqSZZKCVgVxivx4xRpebtTWQr2xCgDN
   Icz34v3x9lDgRp09BmftMiRDvhVVoXYQrpLxNHhbEfYT0gvnWa9VZ2xLR
   AqWhlBLGRc1JGZfkY1S8D798Q9XUwXTBt5G5wS/91WottJt2HMvT5lR0Z
   81K7T6kZJNWWMVZDeXnqlXWan+thbNo1s7Ae5BK1eyuzsWmals6CBAgzz
   4MK0Tj5Wio+yuRhSORUpMxZ+R6NC6VyRHovdp5tLrHm9UmeRmrORpJUIL
   KfDfEvoygqt/W2ak6nLCedshTNTcj4DCbYLE6qGGMPcd4Gj1bGE62W4H3
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="176120074"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Aug 2022 09:14:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 13 Aug 2022 09:14:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Sat, 13 Aug 2022 09:14:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JThnFgU/515PITOytcVpKHK346V0Fv0hjXPps9vFGzBOwdoxRjCrEIT+Ces+yMXG86RVc/c7BDUi/J6NWXJEgYAdKDD0GGwFUsCiJXVnQMBy9LGB/nRu6LHuGNYdlxdImCKJvXRN9Hlb3MFc+g7t1ymBh+ZXXomvy239peO3d6GBt0StWFgVzWspS+d8LLbcdwzI0jQD984oB0I2UHpOlspvj7alimocSHwBDFdr0J8KVIglh25B2P1wDDH0o30L7e/n8QXklrEDEf/5IZXdTwB/N8qA4CG03768PvTRkV1qrXXG5wplzrRUYkGOunonzMrBdQFW/DZkvc0UHpS4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpPLFh7zeZbmQYpt+A8J6d1FwvqRSRRNuiETtXvd/nk=;
 b=P01hlGf3X2t7Ga0eV25kPndoaZB/d6TtdHgm1588ciiN1XPos3xYuw91XLX6krnD3pKfMMz3d77Hdu7lLjH1YPyWsNSr9jUWIaa51ZpFRqXCUl2bcgtIZAvwwc3t4pqJ5ZkT/LMntGsfskjKIyCTenl+kzb3vBvpvj5Gk9zP0L10h8vJGp83J5yk/fHlyeHw96++uO8quzz/vsmEHUp0Qn0O9nZZ6cBXy8Bhcugoj5FxuVkjQLzCu+HztvgZM/krgVDwsFUgIfeSrRWy5KAWd+jv8DqyfMvDQfa/IFNIn+KKvsBQbWjuEf3lt7YZz4DcLqSAWSC0MN5BT0CLtqmWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpPLFh7zeZbmQYpt+A8J6d1FwvqRSRRNuiETtXvd/nk=;
 b=uJTHlbJsy1mMxZyogQ1Jv1BC9Tg9TjdaiaHLccGaLkyHTkSUg/xyvtA3Sj3Vz7GMnUYUYo9wC0ewLD5cFUhFzVUoiOWVVb2q2tJc/mMfD0Z0Xjlg7ggD3huMHAmk8Law4O3i7tcoGIOP3ELg1VxV/yTVXb21FjPL/a6P3knrSXs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CH2PR11MB4246.namprd11.prod.outlook.com (2603:10b6:610:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Sat, 13 Aug
 2022 16:14:00 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Sat, 13 Aug 2022
 16:13:59 +0000
From:   <Conor.Dooley@microchip.com>
To:     <tangmin@cdjrlc.com>, <anton@tuxera.com>
CC:     <linux-ntfs-dev@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] treewide: Unneeded semicolon
Thread-Topic: [PATCH] treewide: Unneeded semicolon
Thread-Index: AQHYry7nzB4UD5NYqUqbcdmjxpk/1a2tAQWA
Date:   Sat, 13 Aug 2022 16:13:59 +0000
Message-ID: <687da07e-ad0a-dd47-5f54-27f55e2d9b96@microchip.com>
References: <20220813160723.5769-1-tangmin@cdjrlc.com>
In-Reply-To: <20220813160723.5769-1-tangmin@cdjrlc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d7eb23b-8116-4b92-f642-08da7d46d4d2
x-ms-traffictypediagnostic: CH2PR11MB4246:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oPdiwbU5Rl4Xki5aeDx57sDQKx47bn5O2DlGTpTKAEtTuSh0DZPZwZwEY9Gakaw3WkpjqZB6X3mmYfCYe1iTULKjhnMMO1o4CLVt3OUtuU1bXbfWj5f5rm84hrJSKIvibHId0mn8nuD6LjbqYugCwOto44N0EVzrNEJJE9RR5N3ZHbenCkzfgoi7n1QbsMg+lxkdHY0DIfiZhrscTmr8Lcl9+T2n5omF8RQPmGiK3DVPthI7sBCDgF46J88SrnPlPgVfz9QJEKLEwSCSqLqniSGuS+VagKrPEwjcypvcvHnI2xZdQo0vwXFOR3frU39ieRKYJTtdrFC1eq4N+GlJ6Cb/iQSL1xRubpRHMGsVRIfYReFVFw+PmGwj38CHRY/8pVr9gyIzquBRMIwfu1GDTw9wn4aX/GjlDjXf1Te22xALNcpCeZw8kzxYOL940FiKcafo8xhWthJuqD5SoFpZYyIRWkTG9EgDjyt52HUoQCgvnARcajp9oGvBfjKmaENc/WVJBUcGslHlyU3E/KPma5L92OhDQW8Gi9NmJouT+6cbw+VLye/eTjDLwWFMCKWsRpB4rxzDOGdh6AEv63WZlEkwHHNYqivkVUxLmDSwEajknEvtk/clt4Ip8hEnBRliFetOYDC6NAMXns8J2+FuA+TEBshqg27/vD5IwK4dgHmEQ9MK1MuOin+9E4WgXSQR4+ulFj2XEpjNuVhVlWm++v/CZgOndS7FOfQ4TR5c2jWacYGCV72xbcv7grSKrhqRPACVlszKhMrSO/EAPsE0gw9LnDcgLz8AGTs9eb6DYDOLZPHA73Jj6A9U7cx/IQklb3IHIuSiWDUH8MjLtEZkI4PBC1FsLcKLkM3eZKEFD+U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(366004)(39850400004)(396003)(346002)(8936002)(5660300002)(316002)(110136005)(4744005)(31686004)(54906003)(36756003)(2906002)(2616005)(6486002)(478600001)(26005)(53546011)(6512007)(6506007)(71200400001)(41300700001)(4326008)(86362001)(38100700002)(83380400001)(31696002)(66556008)(64756008)(66946007)(91956017)(76116006)(66476007)(66446008)(186003)(122000001)(38070700005)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXZJNGJ3d2kzVkg0VHhRWkErYUlDUDd1dkVuQ0tFTWpENFMwaExXK2ltMm1a?=
 =?utf-8?B?NTN4WVVTMmg2Rm9lanZXWEc1SEJhZXVOQlpNU3doSklYR3JvUitZVlJDbG5B?=
 =?utf-8?B?dkIyd0FzVHNOU2s0QmIrVGNwZU1GeFZ1RUZvMm5rcWFMYXAzMTVKNnBGNTVX?=
 =?utf-8?B?K3dVQUFiNUxDbXAyNUpWaUJiSXNXdVZvY3hQMTNteGNSbEFsRGF4eVZjUGlI?=
 =?utf-8?B?THQ2VHhtQUdoRTVMV3R2Q2lTNGhYNzNaZVB3S1Zoa0hKbjNvaWh0NEVIUWJN?=
 =?utf-8?B?OVlYSzN5OTlFWFVHSllXeUNkSTlDWVlXSm1KRHdnV0JzMmV5eFZRaEFrNUht?=
 =?utf-8?B?ZytoR3RpRmo2YlJ4TXBmT0xEL2x3cVNBSDk0WFNKNXN0UkRodkVmdjFzbjIy?=
 =?utf-8?B?NU1UWUsrdnBRMVZjSzQ2RWc0NmpWWCtkUHFHSEhBVjJ1RkNJcjJWczhoelN6?=
 =?utf-8?B?V0FtRmt0QVBSMENjOVpJbFNKU2lZZnZyY2VqN1ZQckIvZytWODdmckQ0Wi80?=
 =?utf-8?B?WnlOT2JTWS9qUDFSWnVreExCQUp6dFZaUGhmd2ZxY3J2eFMwWkhuZGdRTE40?=
 =?utf-8?B?SEYzeXhuV1B1NHZpUzUzQlFVbWR3dzBDSlhZcDhTVE85OElqRkZWRjBBdkwx?=
 =?utf-8?B?TXhoQTFWN3dTdi9SME9vTHNOdjJYSm5icy9xL0hlbFVML09HbXRqMStIN1U5?=
 =?utf-8?B?bjVPdUxocXcwNVNnUUJQTjBPSXZvSzRPMjNBZ2VxdkRDTDFzMnFzMmRvVS9C?=
 =?utf-8?B?V0dybzY1eWxkUkp5MGhoajU5NDFGVXY5Y01CdTk1YkNkZGloVnViWmZqKzBB?=
 =?utf-8?B?MkNycVVZVlB0QStqTzZlUlRObWh2dGQyQXB5VWFwOCttVmF1Z01lZmVNOENI?=
 =?utf-8?B?cWVCYVdYVEZQNnRVSXNUY1NvQm1ldEF1b0diZ0s2SUg5YitUYmFxV21WOFRy?=
 =?utf-8?B?bk9xTkFjVk1sajRoSEhEZFpYclp4SmNQRGxqTCswQmEyb2pCUVNacHUvK1F6?=
 =?utf-8?B?ZUxHa05tc05TcGFxODg3aitjdWxjMkErdTJVOTgvdERJeTNpYXdsaWFCd2Zk?=
 =?utf-8?B?Wk53dCs2U2pYU0xnMVdRcU5YV0RjTk52K1RHMW0zM05STnJSOFZXbEZYbCsw?=
 =?utf-8?B?am9EcEhVeUF1U0tEVlEzaXY1Y1M4bS9STmhaZDZxOHFHSVp6Y2c2RW0raExp?=
 =?utf-8?B?bjdJSEI0QUlkaTQ2SDFxT1U5UGZzYWVTMUxjd0J0S0IrVWlYSjh5M0lXOTc1?=
 =?utf-8?B?eEgrdk5UcStRSy8wTGtDLzFibXVBMzA4djMyUTRUVHVPNWM2bzI1QVJBYnlQ?=
 =?utf-8?B?S01FYzMxUThTTDZQbHovWGc0bHVQbFNmb3NROXk4dWoyUkNIUVBYUHhtYU9O?=
 =?utf-8?B?VUNZbWJwa1hLMHlCYTNCb1NXVjA5cndUdEg2SzJtM0NUTlNCTmEvK2Qra1o1?=
 =?utf-8?B?TmQrL0kvbzgrYWRvQm8xSnlYRG5jMzBaZ1F3MDJFQlZuaSttdUlmUmhrMVB6?=
 =?utf-8?B?OW53V1VxWWVhRlRUbktBbzdGTXhWSTVDZzdLSitkL1NBSlhVYjZjWG8zZVV2?=
 =?utf-8?B?WEJocnpsaU5VTVFYeVB6cHk3ZnpyTkNTdno4UGk5TXZCanl4RUJnMTM1LzF2?=
 =?utf-8?B?bmxnNWd1OVlzb2U0d3pBSTlDOHZGK1J4ZVhtbnVEV0JzbTBBYmNtdWlpZURC?=
 =?utf-8?B?K3I4M1RwSW9LQVNieE16Y0lOMW9JcWtvUVIzME9FdTBMVmFoRWJHSjlRbW11?=
 =?utf-8?B?UzRTRlJTRkExN3FyVlFVbjVSbi92R2J0SUtkNjZNelZnMFA5b1dVcU9JUHp5?=
 =?utf-8?B?WFQxdWRnSGs3Q0V5VytlbEZsREhyLzlud21tL3dTQlFiazhsSVl2RldkeUZM?=
 =?utf-8?B?R2x3eEg1eFpBWkVuNTd3bzNQN2NZSVJzeEtxeTBYc2pBMTlKSURvN2hQSWdF?=
 =?utf-8?B?aGVBaVJnd3JHL3BZL1dVbk1wd1FRT01CaXhjSjdZSE1SbDhOKytjZzh2ZEk5?=
 =?utf-8?B?MDZhVG8vd2tuMDdIaEhvMTN5NXBJRi8ydTd6M05tckpoUU5ZNHBpWTRCdE9T?=
 =?utf-8?B?aWdFQnVhQnNZeW1QUG8xbnNGNDRhWGkzVkpDSC9VQjVNRGNmUHEwZVc0NTRs?=
 =?utf-8?Q?ZoKGvqsTJeV2gLahlYXEhZlhe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0EA8AE074E25941AFA1115DF81FB8CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7eb23b-8116-4b92-f642-08da7d46d4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2022 16:13:59.7655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZj0quMunmo4f4yJCo9dEgv0KYzxGGVAe2mSaZVzPVDrRXdYXU4pu6BKDgC1vt4ZMBz10+DUju/iSiHB6NXWfDQwBS9GhN2yjpxyWiBNR24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4246
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMDgvMjAyMiAxNzowNywgbWluIHRhbmcgd3JvdGU6DQo+IFtQQVRDSF0gdHJlZXdpZGU6
IFVubmVlZGVkIHNlbWljb2xvbg0KDQpIZXksIHlvdSBtaWdodCB3YW50IHRvIGNoZWNrIHdoYXRl
dmVyIHNjcmlwdCB5b3UncmUgdXNpbmcgdG8NCmdlbmVyYXRlIHRoZXNlIGNvbW1pdHMuIEEgc2lu
Z2xlIGxpbmUgY2hhbmdlIGluIGEgZmlsZSBpc24ndA0KZXhhY3RseSB0cmVld2lkZS4uLg0KDQo+
IFRoZXJlIGlzIG5vIHNlbWljb2xvbiBhZnRlciAnfScgaW4gbGluZSAxNjE1Lg0KDQpUaGlzIGRv
ZXNuJ3QgcmVhbGx5IG1ha2UgbXVjaCBzZW5zZSwgbWF5YmU6DQoiUmVtb3ZlIHVuZWVkZWQgc2Vt
aWNvbG9uIGFmdGVyLi4uIg0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IG1pbiB0YW5nIDx0YW5nbWluQGNkanJsYy5jb20+DQo+IC0tLQ0KPiAgZnMvbnRmcy9zdXBlci5j
IHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbnRmcy9zdXBlci5jIGIvZnMvbnRmcy9zdXBlci5jDQo+
IGluZGV4IDVhZThkZTA5YjI3MS4uZDY2M2I0OWRmODRlIDEwMDY0NA0KPiAtLS0gYS9mcy9udGZz
L3N1cGVyLmMNCj4gKysrIGIvZnMvbnRmcy9zdXBlci5jDQo+IEBAIC0xNjEyLDcgKzE2MTIsNyBA
QCBzdGF0aWMgYm9vbCBsb2FkX2FuZF9pbml0X2F0dHJkZWYobnRmc192b2x1bWUgKnZvbCkNCj4g
IAkJbWVtY3B5KCh1OCopdm9sLT5hdHRyZGVmICsgKGluZGV4KysgPDwgUEFHRV9TSElGVCksDQo+
ICAJCQkJcGFnZV9hZGRyZXNzKHBhZ2UpLCBzaXplKTsNCj4gIAkJbnRmc191bm1hcF9wYWdlKHBh
Z2UpOw0KPiAtCX07DQo+ICsJfQ0KPiAgCWlmIChzaXplID09IFBBR0VfU0laRSkgew0KPiAgCQlz
aXplID0gaV9zaXplICYgflBBR0VfTUFTSzsNCj4gIAkJaWYgKHNpemUpDQo=
