Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001924D27FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiCIEus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 23:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiCIEuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:50:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C922150414
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 20:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646801387; x=1678337387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/shi+fLpTO3iaT/Cu4MgQq2gEN8tCVz1sGPJ41B5vLU=;
  b=sU51wV2piewihzOQdc3cpHSING9dOj02d6rLkxsdqIxqKDyhmSr78Mea
   2GsLW2ddvPLvgF9LZKZvDcY9lMsFD3mVI1rxWgC6nUVu0Z3tHLP4mrYF5
   OKy4aJcmDZ1IyvOAUDqj+S92GebcfVvsFIqlII3l25W/uNYPwyWyfuXOC
   MJPwmnS43sPYCcuaWEw1zrOcHElhYuLig6azwX9bNCUr7WPM6o1yBP6og
   HpCZHoNKIZKEm84FBc+QrOIqH/j0HKfW1bPjZpJqnVTafxuma+rIIXJtc
   vtHpEUisvyCELQ7u3U9A0Iy9PheI7u7B0enFh2rbC7kWBk6J15K0vdc1B
   g==;
X-IronPort-AV: E=Sophos;i="5.90,166,1643698800"; 
   d="scan'208";a="151352001"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2022 21:49:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Mar 2022 21:49:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 8 Mar 2022 21:49:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOycTmItaHY041jKZvf7wa651App4k+oS9DyzkHvCwKWbahn5hSXOXLPWPNb8BOAWkDmv6IImuWU7RfiIUnn/lbVgzqABFO1xJLKxHGzG+Vsch6pICBCnRtap6M25rSzEBNN7JrSbuLJHxUDAfZ2iNmMvywnSlKEMDMYAnu6BbqbZpQ7lA5cItDxKBh7lGy2TbojY8udKGler5ixamtM89zQcOVOIgQHRSkUt4kSoH/iGF2uX5SrNYDBhoVK+9DIn7GKy641qUQVURQPVidAA4bpMhP7pCiofdYBUeuHVQBsy4dGlDCAZe1dlEJK8Ui/D4A+6Zeg+nNt9RdRq/AY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/shi+fLpTO3iaT/Cu4MgQq2gEN8tCVz1sGPJ41B5vLU=;
 b=IElVxCdXrFkPujJqtw+k9dWEcc35i+OvTI+czxUSFwaPYQfJeTCr+r/7f5ERCDWGa1dXrvUblFVYLvnMIcr3btZIzDIJmyIyeK0jjDDNCBBYIdSBV9B3PXdtmSxMjWVBqJF7slDaeZS2oUAOTI9Axy6+INQZfwJpgAxEtRdyVdFXIBvzYPzSffFGlmgUYgSVWKtmTxNqdY7aoDS9usGMRmMDR58zsPh0x5PpbqlDfgVVsyyz44XNn7kJIKGAhnAgIwYxCaJdWLOzGKudE5PZ8PyDgNLizTM2iXqiSx2u45Tj5FVbl/xsIpACanuXEpIcoDj3qujIK3Ne/cg9esXgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/shi+fLpTO3iaT/Cu4MgQq2gEN8tCVz1sGPJ41B5vLU=;
 b=CBIkCL9U3XEVKKpGnZQKqyHhs00gYF9mIJcI0Sb5sKBB+pwRQPtDtWn66U93N7QUWLyYx/bY8qyzNcLtDs0hvcSDQi9nJrCsmxqrLs60Y3HHre1o/TmVy8uqk/m9+y7l8rp97D1PP8J3Dtu6+6Zs6veU4kNZ72TFnqh2YximYDI=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2815.namprd11.prod.outlook.com (2603:10b6:805:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 04:49:36 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 04:49:36 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <heiko.thiery@gmail.com>
Subject: Re: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Topic: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Index: AQHYMfKsE2aD0LVQO0KmbZoSG1RT0g==
Date:   Wed, 9 Mar 2022 04:49:36 +0000
Message-ID: <91393780-1521-09b7-8dea-14c65e18b37e@microchip.com>
References: <20220304185137.3376011-1-michael@walle.cc>
 <7f339d0c-5ca9-261c-a545-d4ebf3bda140@microchip.com>
 <92cde38c-d398-44f4-26f8-ef4919f5944e@microchip.com>
 <7f947928e7189f98eb950828990b3920@walle.cc>
In-Reply-To: <7f947928e7189f98eb950828990b3920@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d62169b1-8a2a-44c2-5b08-08da01883660
x-ms-traffictypediagnostic: SN6PR11MB2815:EE_
x-microsoft-antispam-prvs: <SN6PR11MB2815D80B5CB1B70D3936C735F00A9@SN6PR11MB2815.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MRzXajuiwOPkPnQw3JrnVOZJOfkvZyD+bzC5eleP17DM2PAOCOK3JwQ+hFAnu2thgGVGgLjFrD7NlwTidIZsb1uK3j6UDi4ScigtEk0Za939idomai0c5KxR84ndDDmTR3Awj67hF+J33R4ATinmeMA/uiTeU5so2l9Ixf4WQDlAGjV07uY1yo+a0AUpnjLSP8pN9b/GHb4EyYuT+ohOpHy5krb/fyF1CV3B7O6Inp7aPy1gAZhVXxbxSbrySW/DZLaFVOKIsQ2GzhX8O4AglLYnImGC3gM/I64QPzxS9VMLrurVrfHfNCSTgT3j/BikQ4Jp8LWCQnhc49E1JUFiSaeQccLmvBpAoBnzE08MxynajogIbPteP9aOnCStnAzzj+IIKz2SE7NZ8ITYdcSVAELc9r0KSIMHtZI+FYnFitmQ4SK6S4cLu83Ou2RCaGBj5/dOgIXmr5F84N0rlFZjH4ZeePwoTYOBHKmHuMIvtC+TysYYzQq/o2LryCh8vPnD5S762N+zCv40c12dd9UX94SU1NiF3KmRVWZ5GLtWUGH6Aon8I0UjgzyVyXBoWYzGB+nm1nrUk6scBP2HaUw8V29VR9yuYRxIQ6lV6bdJA8HsjsTcXLwE0mkw3R8xJveNh9SVT/iY35WahPQuxtS8u8YThjUmr7d7N+fs52nkq/LgplLk3dxuf7RUKrT+Z3Z/dQ2NkNv5LXGRz8a2tkUFDzpepuvSIVRCosI/MnkM/ACJF54WOgAMcjtKQSIjq14PWyjJee83m/4hAeye7vq1RA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(66946007)(83380400001)(66556008)(66476007)(64756008)(6486002)(36756003)(122000001)(53546011)(8676002)(6512007)(76116006)(8936002)(508600001)(4326008)(316002)(31686004)(31696002)(38070700005)(54906003)(71200400001)(6916009)(38100700002)(91956017)(6506007)(86362001)(186003)(2616005)(26005)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEcvalNxVERxQUNTc1BhUzBobTlxMmtNanBZbzc2YjEvS3d3Y3VpT2pXTHYw?=
 =?utf-8?B?dVhZclFnUWRBWnVQUU81UDd2Sk5ydFMxY0kyZEU4RjgvMXdCb1JZdWdUZjY0?=
 =?utf-8?B?R1pCMWhiV2xHY0xhZ0ZCMEdJWVllQVlxckhIVFdsL2JMSG9EaVpRM1RwZUdJ?=
 =?utf-8?B?N0RvUkFVZmFFR3YrK2dtWTdpTDh1UW9RZDBuK1Y1QVNUQlJYQWtGR3cxd3JW?=
 =?utf-8?B?b2RWS1dmY084RDN5ZFdrK2VoY1J3MFBkMHJqUEZVNUFmVnNSRHhGUUxVTUlh?=
 =?utf-8?B?VHVxZmN1VjV1VVYwUmN3RjdsdnVHem8rcWFnV21KbS9pVnVzOStIUC9vejNh?=
 =?utf-8?B?Q3FqYTBmRXU3OFA5MmM1Sm1icjRCcjJBeUlpYTkvOFYzak03aGxGS0RlL2JK?=
 =?utf-8?B?Ni9TRVpaOGx6eUlTNnNSbnNIcG5vSlRWa0FsUzN5aUYyVzNaeGx2OWp0blR5?=
 =?utf-8?B?VVlzblo0YmpzTjQwY01pZ0pCOHZlcnhoNHFGTnREMU02eit3MjEvcUhvbFh5?=
 =?utf-8?B?TTdFcjhwQndtU2pSTTBQeXdQN0RheEJ3Z003QjdvaGtPYTVESzQ2aW5hVjc3?=
 =?utf-8?B?aGF1V05uZUZDOVZkWms2cUlSOVpmS3pLU0Qyc1ZYbWxTeDBZc2ExdUYzODJ3?=
 =?utf-8?B?amdjcGJhcW15Mi9XSk1UNk5CNCtDRStDQVVjTHVUK1pqVjE2TlFqS0QraGZR?=
 =?utf-8?B?UnZnVkJRVU5WYkM4dy8xZU5NaVRsakxrRGRibkJpZE1SaEZqQUJEM2E1L3Fk?=
 =?utf-8?B?OW1WWE1xcGlaRE9TSzJzb3hCcXFDRDJyNWJVbmlTVEJrbjYvZUJna1VZVDRH?=
 =?utf-8?B?WnF5RW1nblJKMlpwMkhrOVVkL1RSb25sK0kzaUN5bHpxUjljNjNSajRwQVVF?=
 =?utf-8?B?MytxeVpFbmtETUx2TWNPZkZiUS85bklJdTBoWjhETnhQVFpYSUQ1bWlGUzYx?=
 =?utf-8?B?RTFHdmVubFpmai9rWERFZTgzSDFGMnJ5ZWxXTmMybnB3SEliNUowU0UyRVho?=
 =?utf-8?B?WEF2TFNyZ0YyeVgzbEVUb2ZFWkxpVEVWaHlVOEFMSE45V3NPMTlDdmFKa0ZK?=
 =?utf-8?B?RURQamhENUNiQXViVFhaZ1VPS0wvcUxwdnd5eVo1NTBnWUFMNHkzOWpnZGlv?=
 =?utf-8?B?c3lTSEJ6dFhLRGtYaExrcjM5eDhkbUJCNFhQVTZJZTVFaVlOTSs2TjUvRXJY?=
 =?utf-8?B?a0U1RTZTUVc2cUl5OUhDZkwwcFNRa2dMSnE4TjVtUjlPQ3NpdW1WZFJWUy96?=
 =?utf-8?B?dW1uUzVFUUlQVy9JVXBjaTFZT2lrSklKMU1ia2ZqY1A2UlJKR2ZxR1JPU3Vs?=
 =?utf-8?B?bmYyV2hUbXZOT2ZEVG1CWnRHQzFNZCtpam1wRWhGS2ZWUURtR20zdllPbWlR?=
 =?utf-8?B?dEhiZGszaGlkbTh4ZnV2ZjhqNExIdE5iTDFNaFJIWUpnT0FEM0h5Q1JiTmdK?=
 =?utf-8?B?Z2Q0ODdId3BPQy9tTGl2dE5pMTNodFRRS0hNNVZzRkdWVTlHSkFUZE1wY2Ez?=
 =?utf-8?B?bVVKU0swYWcranFlZHBjVU1qb1ZGNytEUlFkaC9wVlloMHl5NGxFWnErUU5j?=
 =?utf-8?B?R2FxN2hpdGRsVTBaMkFhT1dkVExxdmtvZmNJRkw2WFVIM3ZvQkNzcklzc0xw?=
 =?utf-8?B?VVQ1RDkxd04xRFFCc3RVdmdJb0o0d081S2QyVVNLalVrT2VCc2h6Y3dPWlo3?=
 =?utf-8?B?VWZBU1ZXcmlnK2Y0TU9paFdyeWVVTm81REgrSGU3UDROd3A4UHE0Lzhib1Ur?=
 =?utf-8?B?MEZuWEx1ZkZHQ1BrdGxTREhVNnlkVlFqMkJsVFFHK0lRUlBiZU0wbzhpOXlV?=
 =?utf-8?B?YjRuUTlZWmgremFRanZOWm4wOVpCTXFUTThIb0ZXOEw3N0gzWktCSzAyWVFZ?=
 =?utf-8?B?RDAxOFhVeEdJMXp6Q25vem9ZR3VHQTBlZ3hoT2g5T3BYVGt5V0ZzWjhnYXdu?=
 =?utf-8?B?NGNtQXRJRlB5L1g0VkxwL2xlUE1PbTk3ZHg1TWpQbHQ2UDVhRXgrejF6eHAy?=
 =?utf-8?B?dEdVeGFmTjRnNzB4dHZqcHd0MlNOaSt2UXVSVXRpR3NmSVRVS2V4UlFydnNI?=
 =?utf-8?B?dGwrTzBjUk5mWTlsYktqUncwTFZSSm9uaXB2KzlITk02UEpMVGhMbXJrbi95?=
 =?utf-8?B?Q0YwS00vZlhRV3hZYlFnZlE4Rk1VdVMwakFlbUFiN1B1TXlIZ0NpZjJ3Zjgx?=
 =?utf-8?B?U2wzcmxscWI0VnV4VUFKRE8ydE54aHRTWm4rNlVyZWt0NGdvYUNvaHpxSjhZ?=
 =?utf-8?B?dFpkTE1mV0FjMDkxUy9JV3FpYVp3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C624514610C7614AAB05CFBBDB137FB1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62169b1-8a2a-44c2-5b08-08da01883660
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 04:49:36.4717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G58wL4Y4It9edJp8i+D1r3K7WfzSnJZqR9EnSFIIim3JckA2t38q/aQYR1hgX0UmOBBKpiMmvsB+0yTlpbi1mMhsVCWmkVure5hTfRP3oy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2815
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy83LzIyIDIwOjU2LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFtIDIwMjItMDMtMDcgMTA6MjMsIHNjaHJpZWIgVHVk
b3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tOg0KPj4gT24gMy83LzIyIDA5OjEyLCBUdWRvci5BbWJh
cnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPj4+IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIDMvNC8yMiAyMDo1MSwgTWljaGFlbCBXYWxsZSB3cm90
ZToNCj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVubGVzcyB5b3UNCj4+Pj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+DQo+
Pj4+IFdoaWxlIHRoZSBmaXJzdCB2ZXJzaW9uIG9mIEpFU0QyMTYgc3BlY2lmeSB0aGUgb3Bjb2Rl
IGZvciA0IGJpdCBJL08NCj4+Pj4gYWNjZXNzZXMsIGl0IGxhY2tzIGluZm9ybWF0aW9uIG9uIGhv
dyB0byBhY3R1YWxseSBlbmFibGUgdGhpcyBtb2RlLg0KPj4+Pg0KPj4+PiBGb3Igbm93LCB0aGUg
b25lIHNldCBpbiBzcGlfbm9yX2luaXRfZGVmYXVsdF9wYXJhbXMoKSB3aWxsIGJlIHVzZWQuDQo+
Pj4+IEJ1dCB0aGlzIG9uZSBpcyBsaWtlbHkgd3JvbmcgZm9yIHNvbWUgZmxhc2hlcywgaW4gcGFy
dGljdWxhciB0aGUNCj4+Pj4gTWFjcm9uaXggTVgyNUwxMjgzNUYuIFRodXMgd2UgbmVlZCB0byBj
bGVhciB0aGUgZW5hYmxlIG1ldGhvZCB3aGVuDQo+Pj4+IHBhcnNpbmcgdGhlIFNGRFAuIEZsYXNo
ZXMgd2l0aCBzdWNoIGFuIFNGRFAgcmV2aXNpb24gd2lsbCBoYXZlIHRvIHVzZQ0KPj4+PiBhDQo+
Pj4+IGZsYXNoIChhbmQgU0ZEUCByZXZpc2lvbikgc3BlY2lmaWMgZml4dXAuDQo+Pj4+DQo+Pj4+
IFRoaXMgbWlnaHQgYnJlYWsgcXVhZCBJL08gZm9yIHNvbWUgZmxhc2hlcyB3aGljaCByZWxpZWQg
b24gdGhlDQo+Pj4+IHNwaV9ub3Jfc3IyX2JpdDFfcXVhZF9lbmFibGUoKSB0aGF0IHdhcyBmb3Jt
ZXJseSBzZXQuIElmIHlvdXIgYmlzZWN0DQo+Pj4+IHR1cm5zIHVwIHRoaXMgY29tbWl0LCB5b3Un
bGwgcHJvYmFibHkgaGF2ZSB0byBzZXQgdGhlIHByb3Blcg0KPj4+PiBxdWFkX2VuYWJsZSBtZXRo
b2QgaW4gYSBwb3N0X2JmcHQoKSBmaXh1cCBmb3IgeW91ciBmbGFzaC4NCj4+Pj4NCj4+Pg0KPj4+
IFJpZ2h0LCBJIG1lYW50IGFkZGluZyBhIHBhcmFncmFwaCBzdWNoIGFzIHRoZSBvbmUgZnJvbSBh
Ym92ZS4NCj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdh
bGxlLmNjPg0KPj4+PiBUZXN0ZWQtYnk6IEhlaWtvIFRoaWVyeSA8aGVpa28udGhpZXJ5QGdtYWls
LmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IGNoYW5nZXMgc2luY2UgUkZDOg0KPj4+PiDCoC0gcmV3b3Jk
ZWQgY29tbWl0IG1lc3NhZ2UNCj4+Pj4gwqAtIGFkZGVkIGNvbW1lbnQgYWJvdXQgcG9zdF9iZnB0
IGhvb2sNCj4+Pj4NCj4+Pj4gVHVkb3IsIEknbSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFudCB3aXRo
DQo+Pj4+IMKgIE1heWJlIHlvdSBjYW4gdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSBhbmQgZXhw
bGFpbiB3aHkgd291bGQgc29tZQ0KPj4+PiDCoCBmbGFzaGVzIGZhaWwgdG8gZW5hYmxlIHF1YWQg
bW9kZSwgc2ltaWxhciB0byB3aGF0IEkgZGlkLg0KPj4+Pg0KPj4+PiBJdCBkb2Vzbid0IHdvcmsg
YmVjYXVzZSB0aGUgd3JvbmcgbWV0aG9kIGlzIGNob3Nlbj8gOykNCj4+Pj4NCj4+Pj4gwqBkcml2
ZXJzL210ZC9zcGktbm9yL3NmZHAuYyB8IDExICsrKysrKysrKystDQo+Pj4+IMKgMSBmaWxlIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4NCj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9z
ZmRwLmMNCj4+Pj4gaW5kZXggYTUyMTE1NDNkMzBkLi42YmJhOWI2MDE4NDYgMTAwNjQ0DQo+Pj4+
IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3Ivc2ZkcC5jDQo+Pj4+IEBAIC01NDksNiArNTQ5LDE2IEBAIHN0YXRpYyBpbnQgc3Bp
X25vcl9wYXJzZV9iZnB0KHN0cnVjdCBzcGlfbm9yDQo+Pj4+ICpub3IsDQo+Pj4+IMKgwqDCoMKg
wqDCoMKgIG1hcC0+dW5pZm9ybV9lcmFzZV90eXBlID0gbWFwLT51bmlmb3JtX3JlZ2lvbi5vZmZz
ZXQgJg0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgU05PUl9FUkFTRV9UWVBFX01BU0s7DQo+Pj4+DQo+Pj4+ICvC
oMKgwqDCoMKgwqAgLyoNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgICogVGhlIGZpcnN0IEpFU0QyMTYg
cmV2aXNpb24gZG9lc24ndCBzcGVjaWZ5IGEgbWV0aG9kIHRvDQo+Pj4+IGVuYWJsZQ0KPj4+PiAr
wqDCoMKgwqDCoMKgwqAgKiBxdWFkIG1vZGUuIHNwaV9ub3JfaW5pdF9kZWZhdWx0X3BhcmFtcygp
IHdpbGwgc2V0IGEgbGVnYWN5DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAqIGRlZmF1bHQgbWV0aG9k
IHRvIGVuYWJsZSBxdWFkIG1vZGUuIFdlIGhhdmUgdG8gZGlzYWJsZSBpdA0KPj4+PiArwqDCoMKg
wqDCoMKgwqAgKiBhZ2Fpbi4NCj4+Pj4gK8KgwqDCoMKgwqDCoMKgICogRmxhc2hlcyB3aXRoIHRo
aXMgSkVTRDIxNiByZXZpc2lvbiBuZWVkIHRvIHNldCB0aGUNCj4+Pj4gcXVhZF9lbmFibGUNCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgICogbWV0aG9kIGluIHRoZWlyIHBvc3RfYmZwdCgpIGZpeHVwIGlm
IHRoZXkgd2FudCB0byB1c2UgcXVhZA0KPj4+PiBJL08uDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAq
Lw0KPj4+DQo+Pj4gR3JlYXQuIExvb2tzIGdvb2QgdG8gbWUuIEknbGwgY2hhbmdlIHRoZSBzdWJq
ZWN0IHRvICJtdGQ6IHNwaS1ub3I6DQo+Pj4gc2ZkcDoiDQo+Pj4gd2hlbiBhcHBseWluZy4NCj4+
DQo+PiBBcyB3ZSB0YWxrZWQgb24gdGhlIG1lZXRpbmcsIHdlIGNhbiBpbnN0ZWFkIG1vdmUgdGhl
IGRlZmF1bHQgcXVhZCBtb2RlDQo+PiBpbml0DQo+PiB0byB0aGUgZGVwcmVjYXRlZCB3YXkgb2Yg
aW5pdGlhbGl6aW5nIHRoZSBwYXJhbXMsIG9yL2FuZCB0byB3aGVyZQ0KPj4gU0tJUF9TRkRQDQo+
PiBpcyB1c2VkLiBUaGlzIHdheSB5b3UnbGwgbm8gbG9uZ2VyIG5lZWQgdG8gY2xlYXIgaXQgaGVy
ZS4NCj4gDQo+IE1oLCBJIGp1c3QgaGFkIGEgbG9vayBhbmQgSSdtIG5vdCBzdXJlIGl0IHdpbGwg
d29yayB0aGVyZSwNCj4gYmVjYXVzZSBpbiB0aGUgZGVwcmVjYXRlZCB3YXksIHRoZSBTRkRQIGlz
IHN0aWxsIHBhcnNlZCBhbmQNCj4gdGh1cyB3ZSBtaWdodCBzdGlsbCBoYXZlIHRoZSB3cm9uZyBl
bmFibGUgbWV0aG9kIGZvciBmbGFzaGVzDQo+IHdoaWNoIGRvbid0IGhhdmUgUEFSU0VfU0ZEUCBz
ZXQuDQoNCk1vdmluZyB0aGUgZGVmYXVsdCBxdWFkX2VuYWJsZSBtZXRob2QgdG8gc3BpX25vcl9u
b19zZmRwX2luaXRfcGFyYW1zKCksDQp0aHVzIGFsc28gZm9yIHNwaV9ub3JfaW5pdF9wYXJhbXNf
ZGVwcmVjYXRlZCgpIGJlY2F1c2UgaXQgY2FsbHMNCnNwaV9ub3Jfbm9fc2ZkcF9pbml0X3BhcmFt
cygpLCB3aWxsIG5vdCBjaGFuZ2UgdGhlIGJlaGF2aW9yIGZvciB0aGUNCmRlcHJlY2F0ZWQgd2F5
IG9mIGluaXRpYWxpemluZyB0aGUgcGFyYW1zLCBpc24ndCBpdD8gQSBtb3JlIHJlYXNvbg0KdG8g
dXNlIFBBUlNFX1NGRFAvU0tJUF9TRkRQLCB3ZSdsbCBnZXQgcmlkIG9mIHRoZSBkZXByZWNhdGVk
IHBhcmFtcw0KaW5pdCBhdCBzb21lIHBvaW50Lg0KDQpObyBuZXcgZml4ZXMgZm9yIHNwaV9ub3Jf
aW5pdF9wYXJhbXNfZGVwcmVjYXRlZCgpLg0KDQo=
