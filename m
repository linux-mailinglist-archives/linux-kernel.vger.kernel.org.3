Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074CB54DD16
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359710AbiFPImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359695AbiFPImj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:42:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617A63BA;
        Thu, 16 Jun 2022 01:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655368953; x=1686904953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XfVLULKpROeG3SYp+TH5krvDhUHxeL0FYmOxOJFabPo=;
  b=F6fylvr2gPWehm/a+NRDLiCAGrqVVpr5UXn4/qyv+IDlQXihMZukkRdj
   q4YIJpXl+WFVn2VAqcckm1N9gFNQZomVYzSJZueQUc8VIZIWXVW9qSm9u
   rWH1fxMDPKXVmA7rYwN5MSivOXogU+9Ud/n8nrDDenjo/T3F9Drv/R0b7
   Q0w2jWwVRpz97gZSrv7doQmfJ3uyITZSQt99atOusxD1EFuzsxXDptHyO
   sDu4AjO9qSqcWbHP62v4QbxvPPKo2Uyqo3dgd0rzWK40yOdMgSXLMCusL
   JG5mXxmW6bACU7IulShidOw5h+bnw+retLr5XAgwhaSrJ2alzpyZI0ls2
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="178202900"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2022 01:42:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Jun 2022 01:42:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 16 Jun 2022 01:42:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESPQeLX+xyvj1zO2YKzDVaUAZCwAWsNz5vFfa0NZ/M2jxKbEhs4eFAIXaXse2AAi6fQ3tJoD2iVHZeLN68diQ6oDSe//30XP3DPRB9/P1C6+5u1mGENBwszkTqhAOpwMu1/8M2ewPrb16Vnrch4wineGPNYGz68AtChrEtKg7nX+4Kds1PRYgh+18vh6zzjxIvCiL0SgTEhQ+TDKPMm32P1weVHW/7E3zeXP+gq+5r9g/KaeFcb/biY/zw9kNZL87wMPEqm5WHoR6NdWyXzOMqXcR6nfFObVVUuI2ATxziSjY+B341852LbYZvkOK+VLLJF7mcFfWnn+kHzGFM6wZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfVLULKpROeG3SYp+TH5krvDhUHxeL0FYmOxOJFabPo=;
 b=diujn9jT2MemtJ40/EgpLZFM2LwT8FFPP3cgXepmnrsAvYMQcBjjhNEt8rzGZn+ZFNyH/zYc6vlWCdeyho7JIzfaOrp52HVlVf7gaDerambCueUccDYJzzWXPMSbdvZoMds5XbcLDckmduStxpXSbnq4s2PMRD9HyeMiskelxmttgSinKW9Zd3IDOi9D1jha9xVVY2wYQNnVMoEHl0Eq0WEjtEfslMYegw5ywKrkAELsbkW7ZB11xQNWHTuccpTnRC+DX5fy0GIJjm1ZkHExZecLelMTdd4eGPFjo5UGjUcYAm7r08gpToxYi5hVg7Kcve48e7ot0Kl1sZKttrfU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfVLULKpROeG3SYp+TH5krvDhUHxeL0FYmOxOJFabPo=;
 b=Lq2gtWhCEa4NgAq1EvdIVCdsgQY5GkNd7/IIKbnllfP7QQiWKSOlApb35KWxd/fRgT7j3j7M8PTrz//nlpT5rkjkC0fIb0lz6/10FQ6e2VyqV83JM4+mKffuewqlisyg4vDOUFGEYb6OKdZ2OQFWeFKvjDJsFDYkIGEgjAlG4sQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA0PR11MB4672.namprd11.prod.outlook.com (2603:10b6:806:96::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 08:42:27 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 08:42:26 +0000
From:   <Conor.Dooley@microchip.com>
To:     <windhl@126.com>, <sboyd@kernel.org>, <Conor.Dooley@microchip.com>
CC:     <jonathanh@nvidia.com>, <mturquette@baylibre.com>,
        <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <thierry.reding@gmail.com>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] clk: tegra: (clk-tegra30) Add missing of_node_put()
Thread-Topic: [PATCH v2] clk: tegra: (clk-tegra30) Add missing of_node_put()
Thread-Index: AQHYgV0BiqBZMTCaKEeTt0zKFPdTEA==
Date:   Thu, 16 Jun 2022 08:42:26 +0000
Message-ID: <f7f1e910-24e5-4bdf-f4ca-12f1a5293ef1@microchip.com>
References: <20220616033622.3975621-1-windhl@126.com>
 <20220616060037.5AEB8C34114@smtp.kernel.org>
 <1a776c99.5e5c.1816b98bfee.Coremail.windhl@126.com>
In-Reply-To: <1a776c99.5e5c.1816b98bfee.Coremail.windhl@126.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4603580-8b3b-4982-6e55-08da4f742428
x-ms-traffictypediagnostic: SA0PR11MB4672:EE_
x-microsoft-antispam-prvs: <SA0PR11MB4672334ED99DA20C3D3DEE2998AC9@SA0PR11MB4672.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 18wev3SAi7GtaKZttZrFlopjbvp8GUAcJIXKkm4O6N4B2+liMhKUVLsf625l/1it7s/4ZT2pxDPj8bgLsWB3rfs5cHBBujEA2uvBU3H8mM79tkpuT89U4VwtTQHQdZMTG3FHtqIsZjKAPDT/55z27ifyQpe+olOfqrZYjHLfdTtNDc/lvoESW3Ssb+aUGPR7RDAD2s53kY6nHJlyUJuPiu4sDpoiSzi/jvlTIQrmzV7iG9xPT6J9vfF1kxUhA7XJ7Y89hOU0aJnWrHLpTiJm/wGbREYwU+EgqLR20qAumtRDJ/v/H6Q8fMwgLSAJv+fr7MZP+w8zx6eO31XNKwKm/fe6FrmSlioWHdb08oPH3AB6oMrH0FTVA3VoZTeJPZNFyYjNKwsk87fCJbfQ/tR5JwPh64YGlV0b7EX2Io3gsN2huJteh1fIuWfMqFpJz4d8eGNryUZdkYTiGakiNz76tHg2tcNKtEPPpgMjx1ge9tpOY8ZJYJYUicLT3j5YsdI7bGvrp6zk1j3M5csQPjf2SKV9C8M/Yox6PhbdwykiuUdorYz9UvjcatZhiWWLCTLfFeCxdRzIOkITnA5Lbtx7iMFGCKG5GroMUhNTzhpg7fKm4l9A043RWkoFtYEqrNKcFO6pFSl6sxRqh6oA8asYdw4z6cwsKB2t/kXd6M3qmMjG/FDL2hWupmiU/x36Iep7UXICSq4vCw58151WuEKhtzc2zDPFHCl0DvC/h+F0y6v000G/JOhgKXoEwwuvkc1ALe1+rhML8aqBtuzUONOdkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(84040400005)(122000001)(2906002)(76116006)(66946007)(38070700005)(66476007)(64756008)(86362001)(66446008)(31696002)(66556008)(8936002)(5660300002)(91956017)(4326008)(38100700002)(8676002)(6512007)(53546011)(186003)(316002)(7416002)(508600001)(6486002)(2616005)(71200400001)(6506007)(26005)(110136005)(83380400001)(36756003)(31686004)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkRvMTg0RUdJcldJQXJWcXR2L2VZdjJLc09pMlpNTHM1MFl4WFNjbkd6VUZ2?=
 =?utf-8?B?S3l1ZUd6MVR6dkRIMG9hNUdqWVM2RmxWSDBWcHppT29mMnhoTWhxb0xmeVMx?=
 =?utf-8?B?NXowekl0VVAvalFKSEFXUnhaTDRBMjIrcmNZenJuQ054dTZycDRRQXZHb3RS?=
 =?utf-8?B?R2EzTEtmVFRjVWJRd0l4TjQwWjVXNExCUEFyemlCZis5WXI5TVo2cmRXQ1M3?=
 =?utf-8?B?U2FtK3EzZ0hZOTYzN2JqS1hNdEk5a3dRMk4vNXhad25STGRoNEE0YmlreDBE?=
 =?utf-8?B?WUJ6WG1wL1Z3TU1qME4zS3NsOGMxTVlNL1hUcW1CcW1jSVp1OVlTc3BCdDNN?=
 =?utf-8?B?dkxEUWx1bE9uNkU2U1B3azFScDJ3eDlIOWNyYXBOakxXMSt5WTQ4RjR6N3Q4?=
 =?utf-8?B?TjdUNTFpa0wxK3FJNEUxd216bml1aUcyN3k5OTJPUEFjbEsxYWhMMjkrOHhw?=
 =?utf-8?B?Ykk4WHZyTE1zdUFVVWJOZXhGNkZzK21XbW13eWNCRTNzNUFVOGtmc0hPV2ti?=
 =?utf-8?B?eGR2bTc4RVFId0ZGK2E5VnlGVTlUUjFUTjN1VXMySkl5TElkREQ1UFhDOFla?=
 =?utf-8?B?T25BQ214bllDMnoxSlBzMk9ZR1pDcm8zemtva21iZ1NGT25iN0VkeWhRRXE5?=
 =?utf-8?B?Y25sNmlybXhtcFBJdmlDSEVBZ1JtM0pGbTUrWDBzdFZzRVhoT1ZxbmhidUtL?=
 =?utf-8?B?VXNOYTdkMzVDVFhlK2IxZHg3RFRKTGRGRVdyMXNWVTVoRzFUYjVpSVl6SFJN?=
 =?utf-8?B?bXFNSEdUNmN3UzRwY0JWblI4S0pKRDltYmdYbU1mVVY3TFJOdnBZQkI4d2g3?=
 =?utf-8?B?ZDcxU2h1Q0ZpMWFmM2NFUzg4MU9sNFdpaDh5aXhnTkdUNE9MakZLelQvRFRa?=
 =?utf-8?B?QzFlQ25LOCtQMURxa0w0cUo3VHhxalhSMFJ2d2k1aytVdGMzYUxJeUVEaWZ1?=
 =?utf-8?B?alB4L0FRcnZGL1Nqd0U3d3NtTURyelBSc0dPdkp4dzVZWDdLalB2bVdrOFVk?=
 =?utf-8?B?SHZhOERPU3BiTlFHWTNzRllDYjBybGJUUzhwc0JWWm84KzRKUVNBNmdsZWRO?=
 =?utf-8?B?Mk1xb1BPWnFQWGN1dnNyb1RzUXVNRmZaYzhoT2FIMWdXbDNLRFBYMFZWTUF1?=
 =?utf-8?B?eFpEZjl0bXRSdzY5dFhTWE9GMWNyQllvUXVxbm9naWpaZlZLdk1hYXpHdUxw?=
 =?utf-8?B?Wld0OVZlYXY1MWFuTWpBYnJtUmhtUmJISVloQ0RQT0tlK295RlFTK2w5Z2pT?=
 =?utf-8?B?VWVDdXh6UkxXbVhtd3FEUjF3MFBOd3czQ3R6UEwwTDRxV0pqS044SUtPTDRJ?=
 =?utf-8?B?VnI4KytaQUgvMUd4aHBHc1NnNkZQRTRoVEpBK0pYOFhvL2phTjgreXY4RlMw?=
 =?utf-8?B?YStGUi9ZVEMzbUZmRUd4K0lOYkZRWTE4RnQ0dnA1aDY4c3FTdXFDazJSS0hj?=
 =?utf-8?B?T2pwVkkxT0tJVisrbEs4a3cra0x4TnBzNk4wa0M4dUVVNWtyZmhMYUsxaVo4?=
 =?utf-8?B?aHpxNXdoV2k4dEFhLzdRdlR6VThBY0ZmQVl4MklkNksxc3VNbVBuZDZ4eWl6?=
 =?utf-8?B?SktDL0NDdDZJeGNlbDNlcTYrU2E1RG5LUmdrRW9pTGk0bWJOZHBHZjdWa3Ru?=
 =?utf-8?B?M29XcWF0UXQrNHp4TUg1S0NxTVFVcnU4TkZNSjRNNUZUWUNGd01Nek9YRFBx?=
 =?utf-8?B?d01RUkVqdTROVEZtL1pNNHg2dDcveXpDbmg0VDFtT3pBQkhmblNnRGVzeWl6?=
 =?utf-8?B?TGE2RTV1OERJUE9oUCtCdkZpbzJENWxpMmVnTlJFODlnVG0vSkZaaE1KbVBu?=
 =?utf-8?B?QTg2dHo4TTE3NUREVTBrL1MyWXZwdjlWYkNBbzJMUC9JM3FzNCtMSDh1MUhL?=
 =?utf-8?B?YnhOejlyano1VmR4SUNpWndRMytUZHdsVkZGVlVwUkI5cVpvaFVJd3JJZVMy?=
 =?utf-8?B?Y0R4QXdhWnUvUm5JOURWSEtneUtzUWFlaWs5WXR0UU5zOEU4aDBER3JNNXlz?=
 =?utf-8?B?MGJ5RitJTFlzc1o5bE9ETHR2UlNWY0ZoSDRVOVVFakxHQ0VwSEd3NzZXOGJX?=
 =?utf-8?B?NEQwMWRUTXUyNkgyTWN2dURRd2tGYXpZcVBBVHFKUXIxZS9NRWR4TEllTnhY?=
 =?utf-8?B?Yk1GSVdKbktTWkg4d2k1NjArQi9Sdm03Q3dEZXFwZS9BT0ZmWGlnbUhGNVRx?=
 =?utf-8?B?VFF5NkplUXZRMS8yRmtrUVFacHVSWWpVTFpjaFIwWGdXS0R1aUVFdmxxVTFn?=
 =?utf-8?B?czJUUldHQ3l2RUVBWGFUVit4VlhiVzJTamo3bjlKbjJMVzByaksvMkY5Wkdv?=
 =?utf-8?B?L3JXWUQ3ekhqb3FGWUZYamFPdjhRZDNjTDNGcGRuNGlaWitid2k1UkJQa2t0?=
 =?utf-8?Q?9mzTzt/sxI7mgpaI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0154FD5D8C17D64583EE819595CE20C2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4603580-8b3b-4982-6e55-08da4f742428
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 08:42:26.7620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+6ERcLWij1XuYfqSl7c/KfXijqCPOijKftmZHk9NVz+lC+I3UKl6y3h4iLqwRdL8Kg8SinyIMA/nXSKGhBT1mS5LTBIxM/Bq0gpp/qhPVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4672
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDYvMjAyMiAwOToxOSwgTGlhbmcgSGUgd3JvdGU6DQo+IEF0IDIwMjItMDYtMTYgMTQ6
MDA6MzUsICJTdGVwaGVuIEJveWQiIDxzYm95ZEBrZXJuZWwub3JnPiB3cm90ZToNCj4+IFRoZSBz
dWJqZWN0IHNob3VsZCBtYXRjaCBoaXN0b3JpY2FsIHN1YmplY3RzDQo+Pg0KPj4gJCBnaXQgbG9n
IC0tb25lbGluZSAtMyAtLSBkcml2ZXJzL2Nsay90ZWdyYS9jbGstdGVncmEzMC5jDQo+Pg0KPj4g
c2hvd3MgbW9zdGx5ICJjbGs6IHRlZ3JhOiAiLiBDYW4geW91IGFsc28gY29tYmluZSB0aGlzIHdp
dGggdGhlIG90aGVyDQo+PiB0ZWdyYSBwYXRjaD8gRG9uJ3QgdGhpbmsgd2UgbmVlZCB0d28gcGF0
Y2hlcyBmb3IgZXNzZW50aWFsbHkgdGhlIHNhbWUNCj4+IHRoaW5nLg0KPj4NCj4+IFF1b3Rpbmcg
TGlhbmcgSGUgKDIwMjItMDYtMTUgMjA6MzY6MjIpDQo+Pj4gSW4gdGVncmEzMF9jbG9ja19pbml0
LCBvZl9maW5kX21hdGNoaW5nX25vZGUoKSB3aWxsIHJldHVybiBhIG5vZGUNCj4+PiBwb2ludGVy
IHdpdGggcmVmY291bnQgaW5jcmVtZW50ZWQuIFdlIHNob3VsZCB1c2Ugb2Zfbm9kZV9wdXQoKSB3
aGVuDQo+Pj4gdGhlIG5vZGUgcG9pbnRlciBpcyBub3QgdXNlZCBhbnltb3JlLg0KPj4+DQo+Pj4g
U2lnbmVkLW9mZi1ieTogTGlhbmcgSGUgPHdpbmRobEAxMjYuY29tPg0KPj4+IC0tLQ0KPj4+ICAg
Y2hhbmdlbG9nOg0KPj4+DQo+Pj4gICB2MjogdXNlIHJlYWwgbmFtZSBmb3IgU29iDQo+Pg0KPj4g
VGhhbmtzIQ0KPj4NCj4+PiAgIHYxOiBmaXggbWlzc2luZyBidWcNCj4gDQo+IFNvcnJ5IGZvciBt
eSBmYXVsdC4gSSBoYXZlIGJlZW4gYWR2aXNlZCB0byB1c2UgcmVhbCBuYW1lIGFuZCBJIHJlc2Vu
ZCBhIFBBVENIIHYyIHdpdGggbXkgcmVhbCBuYW1lLCBidXQgcmVhbGx5IHdpdGggdGhlIHNhbWUg
cGF0Y2ggY29kZS4NCj4gDQo+IFNvIGhvdyBjYW4gSSB3aXRoZHJhdyB0aGUgZmlyc3QgcGF0Y2gg
b3IgcmVzZW5kIG90aGVyIHRoaW5nPyBJIGFtIGNvbmZ1c2VkLg0KPiANCj4gQ2FuIHlvdSBoZWxw
IG1lLCBDb25vcj8NCg0KWWVhaCwgc3VyZS4gSSB0aGluayB5b3UncmUganVzdCBnZXR0aW5nIGEg
Yml0IGNvbmZ1c2VkIGJ5IGNvbmZsaWN0aW5nDQpyZXNwb25zZXMgZnJvbSBkaWZmZXJlbnQgcGVv
cGxlLiBTb21lIG9mIHRoZSB0aGluZ3MgSSBzYWlkIG9uIHdoYXRldmVyDQp0aGUgb3JpZ2luYWwg
cGF0Y2ggSSByZXBsaWVkIHRvIGFwcGx5IGV2ZXJ5d2hlcmUgLSBsaWtlIHVzaW5nIHlvdXIgcmVh
bA0KbmFtZSBvciBhZGRpbmcgY2hhbmdlbG9ncy4NCkhvd2V2ZXIsIGRpZmZlcmVudCBzdWJzeXN0
ZW0gbWFpbnRhaW5lcnMgaGF2ZSBhIGRpZmZlcmVudCBvcGluaW9ucyBhYm91dA0KaG93IHBhdGNo
ZXMgZm9yIHRoZWlyIHN1YnN5c3RlbSBzaG91bGQgbG9vay4gSSB3b3VsZCBpbWFnaW5lIHRoYXQg
aXQgd2FzDQpHdWVudGVyIFJvZWNrIHRoYXQgYXNrZWQgeW91IHRvIHVzZSB0aGUgInN1YnN5c3Rl
bTogKGRyaXZlcikgYWN0aW9uIg0Kc3ViamVjdCwgd2hpY2ggaXMgaG93IGh3bW9uIHBhdGNoZXMg
YXJlIGRvbmUgLSBidXQgbm90IG90aGVyIHN1YnN5c3RlbXMuDQoNCldoYXQgU3RlcGhlbiBpcyBh
c2tpbmcsIGlzIHRoYXQgeW91IHJ1bg0KJCBnaXQgbG9nIC0tb25lbGluZSAtMyAtLSBkcml2ZXJz
L2Nsay90ZWdyYS9jbGstdGVncmEzMC5jDQp0byBmaWd1cmUgb3V0IHdoYXQgdGhlIHN1YmplY3Qg
c2hvdWxkIGJlLCBiYXNlZCBvbiBwcmV2aW91cyBzdWJqZWN0cy4NClRoYXQncyBnb29kIGFkdmlj
ZSB0byBmb2xsb3cgZm9yIGFueSBwYXRjaCB5b3Ugc2VuZCA6KQ0KDQpUaGlzIG90aGVyIGNvbW1l
bnQgd2FzOg0KPiBEb24ndCB0aGluayB3ZSBuZWVkIHR3byBwYXRjaGVzIGZvciBlc3NlbnRpYWxs
eSB0aGUgc2FtZSB0aGluZy4NCg0KSSBhc3N1bWUgeW91IHNlbnQgdHdvIGRpZmZlcmVudCBwYXRj
aGVzIGZvciB0aGUgc2FtZSBkcml2ZXIsIG9yIHRoZQ0Kc2FtZSBkaXJlY3Rvcnkgb2YgZHJpdmVy
cz8NCkhlJ3MganVzdCBhc2tpbmcgdGhhdCB5b3Ugc3F1YXNoIHRoZSB0d28gY29tbWl0cyB0b2dl
dGhlciBpbnRvIG9uZQ0KY29tbWl0Lg0KDQogRnJvbSB5b3VyIG90aGVyIGVtYWlsOg0KPiBTb3Jy
eSwgd2hhdCBkbyB5b3UgbWVhbiBzYW1lIHN1YmplY3QgbGluZSBjb21tZW50Pw0KPiBJIGFkZCBh
IFtQQVRDSCB2Ml0gdGFnIHdoZW4gSSB1c2UgJ2dpdCBmb3JtYXQtcGF0Y2ggLXYgMicuDQoNCkkg
YXNzdW1lIFN0ZXBoZW4gbWVhbnQ6IHRoZSBzYW1lIGNvbW1lbnRzIGFib3V0ICIoY2xrLXRlZ3Jh
MzApIg0KZnJvbSB0aGlzIHBhdGNoIGFwcGx5IHRvIHRoYXQgcGF0Y2ggdG9vLiBUaGVyZSdzIG5v
dGhpbmcgd3JvbmcNCndpdGggaGF2aW5nICJbUEFUQ0ggdjJdIi4NCg0KPiBZb3UgbWVhbiB0aGUg
dHdvIGNvbW1pdCBoYXMgc2FtZSBzdWJqZWN0IGNvbnRlbnQ/DQo+IFNvcnJ5LCBJIGFtIGEgYmVn
aW5uZXIgdG8gc3VibWl0IHBhdGNoIGNvbW1pdC4NCg0KT2hoIGRvbid0IHdvcnJ5LCB3ZSBoYXZl
IGFsbCBiZWVuIHRoZXJlIChhbmQgaW4gbXkgY2FzZSBub3QgdG9vDQpsb25nIGFnbyBlaXRoZXIu
Li4pDQoNCkhvcGUgdGhhdCBoZWxwcyENClRoYW5rcywNCkNvbm9yLg0KDQoNCg==
