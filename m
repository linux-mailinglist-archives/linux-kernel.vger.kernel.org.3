Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94545AD17E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbiIELTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiIELTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:19:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D0564F8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662376787; x=1693912787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nju5fFsr3imQBpe7dxn0MzTdSOw7ctdAjOCsgdADelI=;
  b=JsP8/oZYmWUfUpbbGI2ct3/SMprCCTXznahdlw6c01kBmKng1kecVRzx
   JoWzB/XQhDyTlGi4YD28l3bjomPk0Qds8jYVgsrAxmNQITuR6OcsqWvVO
   IpDeq+VuGCJnbQUq2NW2wnu/IiOXxanlmtLOTfrcEfJRyx79hkoa/JBCY
   RPk8GJEmavwDxwueVQCwE3DGubJXMAbDMbFzC4w3fciy+h/j4l3IKMt1e
   snQiKICBcXeQElSUDOksIWQCukr+zQwK/hKiWYKl/Lw+4ZWRm2NmmzGAH
   TRYa8dN0hhejuBLeZlB/PnYsWHF1ZIKIHoCmw35DA/5TTnzvitvftWDW0
   w==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="179205722"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 04:19:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 04:19:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 5 Sep 2022 04:19:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrf8QZ9KuEyf8WfDsafaHCHt+uL/4hX+bMJ9sO2eKXrqRObPFGA/RwZuEGDnfY/g9i9wyY7PnPPm/AXMQxG8aQxJMSfUqLnssvKUKLdzHWrDl4BdjXJesuGCypB4eNdrQJp1ZK3AMZOK/OJnnuQJKYO4ssH5OX/3Li0VR/DOzREA2/jsurkcx3XzBsHsT5Cp4bFeJwYTsYRI81hEa4FAqHw0PPJ5nRA2i2SzH0rx5HtWRHJnyHmV02IbCdJIFMe/35yLPCnQhFbrQClpsLl9x/39regnLL1Zdz9jAn1MAZWrtcjEJpe7hdxwqLtm79EaM1Xc0zYHdbuaABPgFg6sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nju5fFsr3imQBpe7dxn0MzTdSOw7ctdAjOCsgdADelI=;
 b=d3bYISvjFHeGVf4rnnhApe9PQnbXgO7uNHEkZ9rL6tektCoDjkvBp1gZTpl6bd2rfsQXO57AR+UHwlk1Z8+nS8l9D1whNSGCHMYB+ydv/ZWwrhGwjk0ke1DNq9tsbmje//BJUxnsb1MBp9/ZQ0lFQM1VPfiqyZ6AeHtcFSR9ZOMdj5yQymJONXFsh6x3hwjDDOONmyN9su1Apr+HYaFmwMlawrxSpk8+VBuSdIQD7r7i541eCSGPtKrBuKl8rP7ZLZBHLwUZGZEBKkS1IEgkjytU96mLQNxwdVKLbNx9+ia6ovlzmvlMyb3WThVx1W/t/ytMJrohnnJX7VtoFA69ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nju5fFsr3imQBpe7dxn0MzTdSOw7ctdAjOCsgdADelI=;
 b=hXpkgPmGAV/N3UT2eB4Bk3P+3nkExDuR+hIA06NLqi5H3Y1AdF/FDgUuAHYmp6/ishxBG+un27WtpYLjm/Y3/zeb477a5tR7tHY9KOBPtDn0E8oEuKPvDfBvJltj8Inuhxo2upgK4gFe8w3bWEakyTZ5hfFzufegASrd3WbQcog=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Mon, 5 Sep
 2022 11:19:42 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 11:19:42 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC:     <guoren@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] riscv: use BIT() marco for cpufeature probing
Thread-Topic: [PATCH v2 4/5] riscv: use BIT() marco for cpufeature probing
Thread-Index: AQHYwRg57DMgpYyc+Uef16fLunMs063QsIQA
Date:   Mon, 5 Sep 2022 11:19:41 +0000
Message-ID: <1e61d31a-9bf5-af79-dbc4-87d63d24b497@microchip.com>
References: <20220905111027.2463297-1-heiko@sntech.de>
 <20220905111027.2463297-5-heiko@sntech.de>
In-Reply-To: <20220905111027.2463297-5-heiko@sntech.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 833da7ca-4737-4d59-6de2-08da8f308777
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ffKrQjGfKH7CxFeJ/Ffg7+q4FRsZQqMfM/PFyk5Ag9lH7YIgT8wVIIgMkVTHpdPJx3W8Xy5rIbq+IbJEbbe64zjx0h1ctNTN0t91Fc72Oi6chX5hlb9ASlI/1rQ2H/FutIopKShhtaCURrv754P1wWBqxUTchVzhoHouJ9RExcYLBH+kRDFIhclC7eSxKXZQYYipr3lcFlE45/G0jxeLe8bi+yZxoqP9nE1DpyBErZ5JIi3LoLgymSUnunbLegc4n7GTVWlfKk0os1ZUKxTIyNUJ47nlbJLKyK7lsQb/4VaMDxBUyfXLbK5d8Yp49mOhDNjB2suFhBWzr/SK/JpWJS1lnvYm0cSnXSC8+NVIcDEZ+zouukqfI+4CmI2thDE8DjoUY7RdsOwX0Wr2UjOmOFgjpgiSkrAyDKUZzqwASmno7YW8yiJEGIpFfd7w3gKE568Cz7jurR8Azj+++QyPDqXyKRanH/wbP8nSc8ZSl96YnAqcng9l5zLNaQv5/EMbfqJrebpkHRvyqbo3BKh3iIdFPmOE9ufyHXtEbI1bS9EQP7SFU+TN0K/OJ/47yeTUTMaKFxpYUubeYVKOhLnwweY2XG5EBmwJO5m85ae2x7D7WkADTx8xyNi0m5muLClK3TbiyeUXszIdnfXh42fTSf2fQfQqjbAJ2h6xp5U0Oyj0jx2yDc9I1b0QidW8EyRtP7MMshNwBEy9kKSejqT7gZEhC/cIie95dnJol4Wy6hRBjGa78Olo2mNhadmreCz9M2fi48S9Cr3Kw8EVo4o51G0zsIVKllIVP+hBU70FeZLqtISeuiTUB3dN+RD7ude29Ks+AWHq7lCXP8N85eK1zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(38070700005)(2616005)(41300700001)(53546011)(86362001)(26005)(6506007)(6512007)(83380400001)(38100700002)(186003)(31696002)(122000001)(8936002)(31686004)(5660300002)(76116006)(8676002)(71200400001)(66946007)(66446008)(66476007)(91956017)(64756008)(66556008)(478600001)(2906002)(36756003)(4326008)(110136005)(6486002)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0oraHoycGQxYi9PM0hscEg1Z0tsMitVT0NNMnJZcVlEazZlbGJKTEhRdXZ6?=
 =?utf-8?B?dlQ4T2VoaWhwQ2tEYmZIc2QzeFVWY2FHdVZaNmZCNDNBTmhVU1k3NzlHRnNq?=
 =?utf-8?B?M0pEK0pYNU9VeWMxbGEwNlQ5LzllbG51bVprUERHQTZndnQ1N1NjTDk3NEl1?=
 =?utf-8?B?VkFHY0tNQTU3ZExKdnFCUC83NSs1VmJzYUp1RHgvTEZnYjJoRWlseFZzVGFx?=
 =?utf-8?B?clB1dDhUWU1NaCtHcHJVbklGa2h0Vis1YWszbGhNWUZiSlZUcGlleHpPK3pP?=
 =?utf-8?B?eGNDV1Z4c09kUklIWVhHVlBYU1Z0NHVhVFlqWXRtMjFGNldGYnNQYmJidFdV?=
 =?utf-8?B?U29ZRDZaeklsQ3VJaHNwNFFacDNQMU1Vb1VQYVJoVjhidGRraXI3cXM0OGVI?=
 =?utf-8?B?U0RZR2c1YlhaNXdnWlR0QUE5QmFKQVM0Unh5VVdtT0lzR1NZRERiRVR2NzF0?=
 =?utf-8?B?dVozSGhhOWJ2SzlPejh6QnBOVEl0bGRQekxvdGtDYWhhZm9XVDR1SEZoWUVU?=
 =?utf-8?B?NERtOEl5NkZnQitDSnRsS3dEOEpIcmIzTTRDUDNGS2plS2JvZHpPSlBKRVdY?=
 =?utf-8?B?Q0Z2ajdLSjZ6c01PRm9nZjZBOGthdmdvNU1TWkFqRC9BSzBhSk5zNVFZSjMr?=
 =?utf-8?B?VVpSWG81N1BqSHYwNEFvSHE3TzB5bm5OVmdPUkJtRU42L3RkdW8weGpKeldy?=
 =?utf-8?B?UFBwM3REYU43OExlSUJmRDZ1cTBKdkV0VnN5UGpHQjQyQXpuazd2T3FOcEZF?=
 =?utf-8?B?VHdGL2kyWGZZRXJFMXJYblFlTHlDYnljcHcvQ1Mxc1ZsQzF3WDY3ODJsQ0Nv?=
 =?utf-8?B?UXBBNERhKzdaemNMSzN1Wi9YQ3JJWTVEZVFKL3Fyd3I5Slk4RWZWcW95ZUpu?=
 =?utf-8?B?ZUw5V1BHVWhxdkdwWkI1ZkhiMysrd1cyUmJoRklPclp5NGVsTXBNM2Mralpm?=
 =?utf-8?B?VDZkOEtqNWFNZFpmRnpJK08vMTJCMm5WaEp0Rld1dlF2b3NPdTRqc2pZODBl?=
 =?utf-8?B?aVE2NzVHMXJDNDNBelN5eCtHWjRHTzZMdkpEbkJQc2dkU2lqRFhRc2loNndN?=
 =?utf-8?B?K3h4cWVpVkI3eDd1L280d3AyVDl3ZGZBRXFFUUcxR00weTMyQmFSaXZwSGRm?=
 =?utf-8?B?ako3YmJ2ZDlURHZSTzFpUWlPeUFTNTB0SVVTMGhBQjRkRUNUM25lRXZUYXRi?=
 =?utf-8?B?cDQva2RSTm0rc0NBWWpxSEtjVng0OHdxdDZqQ0E5UFl1TmlJYkJGRmZVWlF1?=
 =?utf-8?B?aHc3M25aTGg3WWRFc3FkdWdPaVVoSHNmQUZFMXUzb1ppcE9oOXRqMEQ3QVhF?=
 =?utf-8?B?dzlFRjVrVnF1RG91bjcvKy9Qb2wvOWVWRGNZYVFmRE1YVnN3V29VcG1Tc1Zs?=
 =?utf-8?B?SjZlUmJ6TlJobEs5NnFFenMzNXdNYzN1TXlhMnFZd0E0Nk8wdkZzVjBaNWxV?=
 =?utf-8?B?em5ScEw2ekJvSUwvaHk0ZnFadEVVdEpEclB0NmRWSXFXcTNOMzUvNmRVanYy?=
 =?utf-8?B?anZWK2NwSEtmSWRmVlpjY1Vvb1lsdjEyMmtwK3poR0RLKzRLZ1RIU1ZCUFRG?=
 =?utf-8?B?ai9iem42bERxc1NLeFZTRnZEYUlSL3pzajhjNGRkRlZBTUJIa3o4Vk1kamdP?=
 =?utf-8?B?OUNTcGh4WkR2cUtsUlgvaUFkT0QyZDkxT1I1RkV5Nk5FZnpiQy8zMHZ0Y2Zx?=
 =?utf-8?B?ajZMc2p0ZkliUTFUQlg4aHV1dlhIdGtwV2dJUUgzQmNSdzFqbU5mWGVYVmtB?=
 =?utf-8?B?VWVLRXNNdGtBV0JlczlUTTErSHp0M1ZWSnZlS0F2bHNMZEpuNGIvTC94bHVl?=
 =?utf-8?B?dkFpeVdvSU5iTXNRTS85cHFSVHNwOVd2ZGx2QXFpM0RVWnY2OVdoQ0NFdlZ3?=
 =?utf-8?B?LzVWbW11T1dUNThxdWVyd3dxNWM3aW4vMFdnMDB0bGl5WGhsNVRYdjdrdEJa?=
 =?utf-8?B?N0RBcll5YzhxOWNHa081eTZwVERpY1p1blFvSUI2dEV0ZUVhN1RwRnNDZ1Va?=
 =?utf-8?B?VU9Fcmx0S1F3UnBXV0ZJM1dyZGdidFBHRkRzK3I5ZWZ6NDVmV0M1VlZGSm5R?=
 =?utf-8?B?VjIvZEtZOXVxWFBENVNCOGZxK3FLT1F4OWpFV3JsL3NGTlRIWmNoZmpIcDkv?=
 =?utf-8?Q?hsRstxlelPtK0YacZGivvLkRX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E8E669F884DF842B03CDB3D98FE85FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833da7ca-4737-4d59-6de2-08da8f308777
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 11:19:41.9832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crNsEqZU3oTKAQ/fEDxf/Py5AwHo7gFdUg1bav6rMn7re9cCmiymTwdvQkLrFXoiUjrO1FYQmIhOj1dQIwt0/ZFCYYX5KUTZSE/SZeVBM6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5963
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMDkvMjAyMiAxMjoxMCwgSGVpa28gU3R1ZWJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVXNpbmcgdGhlIGFwcHJvcHJpYXRlIEJJVCBt
YWNybyBtYWtlcyB0aGUgY29kZSBiZXR0ZXIgcmVhZGFibGUuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6
IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+DQoNCk1pc3NpbmcgdGhlIGNvdmVy
LWxldHRlciB3aXRoIHRoZSBjaGFuZ2Vsb2c/DQpBdCBsZWFzdCwgSSBkaWRuJ3QgZ2V0IGl0IGlu
IG15IGluYm94LiBFaXRoZXIgd2F5LA0KDQpSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25v
ci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gICBhcmNoL3Jpc2N2L2tlcm5lbC9j
cHVmZWF0dXJlLmMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL2Nw
dWZlYXR1cmUuYyBiL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYw0KPiBpbmRleCA3Mjlm
N2EyMTgwOTMuLjA4Zjc0NDU5ODVkYyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwv
Y3B1ZmVhdHVyZS5jDQo+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYw0KPiBA
QCAtMjg5LDEwICsyODksMTAgQEAgc3RhdGljIHUzMiBfX2luaXRfb3JfbW9kdWxlIGNwdWZlYXR1
cmVfcHJvYmUodW5zaWduZWQgaW50IHN0YWdlKQ0KPiAgICAgICAgICB1MzIgY3B1X3JlcV9mZWF0
dXJlID0gMDsNCj4gDQo+ICAgICAgICAgIGlmIChjcHVmZWF0dXJlX3Byb2JlX3N2cGJtdChzdGFn
ZSkpDQo+IC0gICAgICAgICAgICAgICBjcHVfcmVxX2ZlYXR1cmUgfD0gKDFVIDw8IENQVUZFQVRV
UkVfU1ZQQk1UKTsNCj4gKyAgICAgICAgICAgICAgIGNwdV9yZXFfZmVhdHVyZSB8PSBCSVQoQ1BV
RkVBVFVSRV9TVlBCTVQpOw0KPiANCj4gICAgICAgICAgaWYgKGNwdWZlYXR1cmVfcHJvYmVfemlj
Ym9tKHN0YWdlKSkNCj4gLSAgICAgICAgICAgICAgIGNwdV9yZXFfZmVhdHVyZSB8PSAoMVUgPDwg
Q1BVRkVBVFVSRV9aSUNCT00pOw0KPiArICAgICAgICAgICAgICAgY3B1X3JlcV9mZWF0dXJlIHw9
IEJJVChDUFVGRUFUVVJFX1pJQ0JPTSk7DQo+IA0KPiAgICAgICAgICByZXR1cm4gY3B1X3JlcV9m
ZWF0dXJlOw0KPiAgIH0NCj4gLS0NCj4gMi4zNS4xDQo+IA0KDQo=
