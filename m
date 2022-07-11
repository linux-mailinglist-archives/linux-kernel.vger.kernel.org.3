Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BCD570135
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiGKLwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGKLwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:52:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D3A237F5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657540349; x=1689076349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VObhPx6ebQ6PcsxtsECNmZiS4F4nEwwKNgIVJKyFbgM=;
  b=LRH9YGt7Z9DtPvGtOTXTzudacsKMIOcp7Uo6iRiO2v95oOi6BYTuLMxz
   QeJprmYKMlare/wLKMqV+Smflievdb6Vk+18UKTBes+OqvupQF0Y19RGk
   3x9i8nMkTQ1tiDchm8deE42O9AKV+WjNSfwVE6aR+/SSXT3eQDfP9sCCP
   MyI+6nb4CQpSnPWuxePESYVjqI3vX2WI6NX9BWUcD1QGkSorEHqqmq/u2
   sadXcHs0IzRo0FpRQgIoCYTCDWl1MG2XTEZmiVDMmED327tClaW3t8wBC
   N+sl8LCPg9LDO8wB9Oyb7aQcE4AZ8aHZ9KnP9E9SRVFqFw8PGg5bFTfX5
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="164175946"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 04:52:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 04:52:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Jul 2022 04:52:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNvsAwk6LXKYty3BQlDhLEipqYMr7+MIaP+UDYLg66xOoWQlRMOI75yJBBe4TVJDKEm3peAK6cosMaBkA6ybP+lBjR54r0BMyHaYmSBJdqPUWEtnPMzPBHVwhssrLNUiErl20HUi6eNIfSzpD6zgVevFYPgq5DbvpTQS1dRNOg3yVOrY5+MQsAeG+42W3oq+bJTCNs9jkNil/6qx7rhJju/46Q/ncoLZsoxDGQ6W0CJ1CUR4lQoOBnGOKQC2cjcTAWFgUltaZ3eVmFClV9XdjA/7Zp2Muymt01e2YFT7Lqtf8d9V51yLvNToje8LATHO49alguL1rHkJtj2FUZK9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VObhPx6ebQ6PcsxtsECNmZiS4F4nEwwKNgIVJKyFbgM=;
 b=aYH80/k0jJAcIoga3B+FuakcaX6uMLz97RFtWvr+XGKFibeWq7/5e/05O/XGgeroIVx0RJWgmeZ8+WG//XaNi8JSu37Wk6eUXo4F8FnHWnxWhR32Yho+2naoY0DUhuhqS2wK5tvoqFKft1qKUpYYxfXXfoZ5e64/PYYSyIbdNgc1A0D7/syq7TH45BxBZzjazlCUmFq1jhXxvwv9APdASJiv9PeD5+7EjGxBCet2jw7/G4rpTR2i5nvX3rPw5Nq+Oz9N48J94DcNsFaT4uYIKNi3MmPPwW/+m48KqExFJwLivhPYyw10Dq4q4vscqaVwN6KkfdjSvYLJxcZGJ3AYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VObhPx6ebQ6PcsxtsECNmZiS4F4nEwwKNgIVJKyFbgM=;
 b=vSBhNFzfuZxc/f06jmz5W/mqyeo2dSvDCNBeZSzs7AQ9794KJpk8nhnr2s+equq2YVc1PA+g53U2x0vx4gNStJOBbsTMkwq/NxTCKd4wLqgENHQCF4vJew5dO4lcpDpv9FWemlyGNHRgzrab1350PQHCQ852UdcdwAlDQFmkENw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4520.namprd11.prod.outlook.com (2603:10b6:208:265::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 11:52:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 11:52:16 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robin.murphy@arm.com>, <ben.dooks@sifive.com>, <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <iommu@lists.linux-foundation.org>, <sudip.mukherjee@sifive.com>,
        <jude.onyenegecha@sifive.com>, <m.szyprowski@samsung.com>
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Thread-Topic: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Thread-Index: AQHYlRyqCglqeptGyE+tRp+rve6Wyw==
Date:   Mon, 11 Jul 2022 11:52:16 +0000
Message-ID: <fc216e29-7dfb-5265-33d1-b547b8b7bd52@microchip.com>
References: <20220708170811.270589-1-ben.dooks@sifive.com>
 <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
 <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com>
 <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com> <20220711102134.GB4639@lst.de>
 <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com>
 <20220711103921.GA6542@lst.de>
 <43426798-44df-c2c7-1f46-0b79201cb620@sifive.com>
 <ac4944b8-5d15-4761-6315-7dba6eaee0e7@arm.com>
In-Reply-To: <ac4944b8-5d15-4761-6315-7dba6eaee0e7@arm.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29759040-2601-4dd4-a1ed-08da6333cd37
x-ms-traffictypediagnostic: MN2PR11MB4520:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y74t7c6ee19EeAz1UxGZ98906gczVegQa2e4x59LPKzg8unwycDf8Ehpw34qiM6UkXptnJ1RydDTriSMw+YJvpOPmcyvNljoP8nQ7Bn1kn4YDq9Wi7zl7GGnB8NhjcUqP3rwbR2C5gcUFicJHwmVeOd7EauCunCBfd+c1cb5n5X7ieHcNn0IEf+ZnTN45wYKkWOW1ZhU69cXFP4chi1qWnoT6hqOle1cxd8Dld/3IznoSrlPQkkiHrFFPDcmR9FT74nZzO0gq1BJunDb42RWboqWJLs2t/ih7S7qFjrzzEYDuk1oFNiuQ1V68qZCI2yzWLJQUfM14L6b3g6o5KTwCr5XN3l7XVkHdMzdJ5ZDfDzwzjYw7xk31M1h3C9JhHXpV9yMD0hzAUijTUi6ZU6Oue8COL0lZHCkMO/rA5ivX2iwXn3J22y291GRNs7L+pFhWxLNtqqg9jFPhchGE5VxyX3rikqtIOJoWjBGVVkzcQE6WEAJuf1/X9XtrcN0crHIZtTXL7Zj16USchQn8bgXXvR25xHjQNccTtl+3oHo8ohD6TjuVW5IZNWLBczNnhqELVvV+r/L7NlXtjuKLwz1p5EdiSSID2k2u4kO2K8L3KgyszVIHjDeEutcmNn2pLKtZf1flahWAcq3xgtAgYufi9QcKeRhCdtM6yj7fKlfWKTVBVcSSx0p6UyUS7/Xcn2UEeRg4Z/9ePTVB+2M/8grHXnIPKRW/kdvNnemwxy7JKfzQvvuOwv7c8/pIbzSF9ctDwtGyPey8OtiT5wFYYnKJRNLwIjHCt8St84J/Zqd1twAS+C5FPbV2Q7wZlR53lXd6lrdxSiaZSQUxtTjmmn0xpI/KQofMiVxwn60UaWah58iTG/YyZ3lXzeW5z+q0rv2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(136003)(366004)(39860400002)(91956017)(2616005)(66946007)(64756008)(5660300002)(4326008)(76116006)(71200400001)(66556008)(36756003)(122000001)(38100700002)(8676002)(8936002)(31686004)(316002)(38070700005)(66446008)(6486002)(26005)(83380400001)(2906002)(86362001)(186003)(53546011)(6506007)(478600001)(6512007)(110136005)(54906003)(31696002)(41300700001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGRmU0t3MlZ0dzVNbnZwUHFqWGdSQko1SDRvdm5oVldLbjlvV2ZNMEF1VlRD?=
 =?utf-8?B?ZTRYL3F3b1VYbU5HamE2WGVMTE1ZSUhFQ0sxeG5ML2tXQlo1SmMxaWlpdzha?=
 =?utf-8?B?WTdGYThmek01b3NkN2FlbkhmbUI5b0p6Q3pZYkx3RXd0S0hqRzI2dG9raFZa?=
 =?utf-8?B?bUI3Ny9YdHVZZnVLRHBPUGNhK0lEc3RqZlBNVExPbVpxTkFYdWtPNWhqbFhZ?=
 =?utf-8?B?ZlhyUDh5a1BUSWFPMm44RVVOWWdlcHptTE15QXhka1ZOUEtuQTM2WGVkMUN3?=
 =?utf-8?B?Smg4S3BFbHMyVmg4SS9tR2g0UHdKSzc5amN4Z1NQNmpZaldyVWt1R3FOYTcy?=
 =?utf-8?B?T0d3R1loT0pKY2dNd1IwU1BHV1FsVGEzZkxQUGFKOGZOS2VvNWtlM2lSNUxC?=
 =?utf-8?B?VFQrak1mK3MxK0dFdy9reVkrUm9yQVZIdWdTU1NFeG4yUjhqTDlMc1pHb0Js?=
 =?utf-8?B?cXd2M0RZbUZwYVlJSkFlM3ZCNE8wZVJPTmZUTFQvclY2bDI1T1YxeHluKzJF?=
 =?utf-8?B?elZQWEh5U1VLVnFNTTdaaTNtVWd2R09zOVZ2TGJ2RFk4b1NQNFZjSVVWMjBj?=
 =?utf-8?B?UWFZMVFvRVQxU2o4dHM3WUFXMzQ5YkRUdjlySW9yMUZpaXhQME8vNTV3UFoz?=
 =?utf-8?B?NnpLM0p5TGMwNytUc1E3REI1OTJQQ0JMTkpDekRZaXJDYWd6WVpIaTZpNVA4?=
 =?utf-8?B?VElFV1UySVYzZDcwOS9KcWI1b2FYVlUvY0loWktJWHJXNzIyb0UzMitQV0xn?=
 =?utf-8?B?MTdYNTBaTTNsQTgyYm1wUE56WHY3VlJTbDJiZGFaRUFJb3lRNWdNYXl0eVZx?=
 =?utf-8?B?MS9zeHIxODViNTNDNnZJbzhtVjd1cEZJKy84aUlWRy94Q3poMksrOSt3THBP?=
 =?utf-8?B?SWdKQjBqTlZ2WVRpdHdKaVhjc1FtTmRVRFplcGFVY2d3ZUJWbXQ4VGFWMVdz?=
 =?utf-8?B?U0wvc1ZVc2luaGQxMFNvLytxTkFuMVZVV0UxRkFrNlFPVEhCUmZqN2UxMUJp?=
 =?utf-8?B?SStla0NLV0FUeDBFVUlxWldmWG9vN1g3OGxWcUpXeW83ZTVCT0p4Y0lrRE1V?=
 =?utf-8?B?NDU4cmFUNVNhYmsxZjlKNlF2UU9WaGF3RVQxMkJCK1UrMWcycWtWMmJoc1hw?=
 =?utf-8?B?QUNIRzdFb256cHVJZVFxSnBLekxna0NhcENDcVhzc3g1aXBkSGZxNWE5UlQ2?=
 =?utf-8?B?TUYySCtGV3piTVhTT25aTGF4dXR6NWVsTG9id0ZDZk51L0VSTUdVODJOSU1U?=
 =?utf-8?B?NFZNK20zQ21JUU9QU3NJNXNyVjcvdEZBSnlNVWFLWXFUaUorelFJME54SE9X?=
 =?utf-8?B?bEhWeHpzTjd6ZUg2U1dQZDlxYjVvU2JtVWF6L2sxNkVPbE12Rmh6azVjdVFy?=
 =?utf-8?B?b0VUUDRsYk94UEdvT0c4WVV0NTNKckFTY1NDQmZiL3hwQm1sSEZlak5SZCtx?=
 =?utf-8?B?YlJHZ0dhQnpPUGxxVTlCSTZVelJUNnFDTGxMTVdNVUNwZGhncDg5dlhWQ0ln?=
 =?utf-8?B?eGtQZnBPbDYyZEliQ1VIU2MvbWE3clRDdjIzbjR1RkpKeXJDRFJveUk5ZUxQ?=
 =?utf-8?B?bHNocDN1a05WRWVnV1hoL2RKeGhKYlJoYzIzdmQycWk1Q01FRmFyYU1reUxo?=
 =?utf-8?B?R2kyYlYyNHlMTitYd0l0MnZKNHRJQ0hWaTJ4MGtMMDBDSlpJQ21UTVAvQ2U4?=
 =?utf-8?B?VkRMeitmMkZMYkxxU0paYzcwdUJZNVBTTzUyM0t0TEZkbFl0dlVwK3FyRlhp?=
 =?utf-8?B?bnhGMGUybUtWVkZNOFVIbUFCeDB3eU1GbFBUeTlUQ3B0SWlVQWxJOElrM3Jo?=
 =?utf-8?B?RThUdm4yME9QR1EweTVYOXhtRlZHRkFmVlJDVGVUZW9VYnZQZ2tkWkJEQTRB?=
 =?utf-8?B?Wk92dVJ3MzVrMHowY3Axb3NjT0s3V25mMWhwb1I1YmRiTmRxRndOVURZdVRL?=
 =?utf-8?B?RHhBaEw3Rk9jSlFEZzZ2UVJlbVNYU2kwcGF3RTBEbFduZlh0UGxwcUZiZmRR?=
 =?utf-8?B?b0R1b3ZyNmNXTzQ1b2YyUEp4VmFSeEFFZmlRY0w0eFpmaGltS2hwdFZMSWxX?=
 =?utf-8?B?NXhmaEZZcWpuZVp2dmdmOHB1SC8wL29ITEdDR09zVnhXZmNMbkpYSFUxZlRO?=
 =?utf-8?Q?ORYdrkOoAXNaQQeEH8R1afjvp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0A264A5875A214E9A131211A833B2CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29759040-2601-4dd4-a1ed-08da6333cd37
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 11:52:16.3647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1EgrbsWqzsExUtrtwkg3zghYXZAOdyoC/3EYdmMAknXSPx0C4UaVh7MjT/O6wuQdaV72eB5ClVGim+R/MeExd83j29oT4+QeBHz6LQKtYn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4520
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzA3LzIwMjIgMTI6MDEsIFJvYmluIE11cnBoeSB3cm90ZToNCj4gT24gMjAyMi0w
Ny0xMSAxMTo0MiwgQmVuIERvb2tzIHdyb3RlOg0KPj4gT24gMTEvMDcvMjAyMiAxMTozOSwgQ2hy
aXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+Pj4gT24gTW9uLCBKdWwgMTEsIDIwMjIgYXQgMTE6MjQ6
NTFBTSArMDEwMCwgQmVuIERvb2tzIHdyb3RlOg0KPj4+PiBPbiAxMS8wNy8yMDIyIDExOjIxLCBD
aHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+Pj4+IE9uIE1vbiwgSnVsIDExLCAyMDIyIGF0IDEx
OjA3OjE3QU0gKzAxMDAsIFJvYmluIE11cnBoeSB3cm90ZToNCj4+Pj4+PiBJZiBub25lIG9mIHlv
dXIgcGVyaXBoZXJhbHMgc2hvdWxkIG5lZWQgU1dJT1RMQiwgdGhlbiB0aGUgZmFjdCB0aGF0DQo+
Pj4+Pj4geW91J3JlIGVuZGluZyB1cCBpbiBzd2lvdGxiX21hcCgpIGF0IGFsbCBpcyBhIGNsZWFy
IHNpZ24gdGhhdA0KPj4+Pj4+IHNvbWV0aGluZydzIHdyb25nLiBNb3N0IGxpa2VseSBzb21lb25l
J3MgZm9yZ290dGVuIHRvIHNldCB0aGVpciBETUENCj4+Pj4+PiBtYXNrcyBjb3JyZWN0bHkuDQo+
Pj4+Pg0KPj4+Pj4gWWVzLg0KPj4+Pg0KPj4+PiBQb3NzaWJseSwgd2UgaGFkIGF0IGxlYXN0IG9u
ZSBkcml2ZXIgd2hpY2ggYXR0ZW1wdGVkIHRvIHNldCBhIDMyIGJpdA0KPj4+PiBETUEgbWFzayB3
aGljaCBoYWQgdG8gYmUgcmVtb3ZlZCBhcyB0aGUgRE1BIGxheWVyIGFjY2VwdHMgdGhpcyBidXQN
Cj4+Pj4gc2luY2UgdGhlcmUgaXMgbm8gRE1BMzIgbWVtb3J5IHRoZSBhbGxvY2F0b3IgdGhlbiBq
dXN0IGZhaWxzLg0KPj4+Pg0KPj4+PiBJIGV4cGVjdCB0aGUgYWJvdmUgbWF5IG5lZWQgdG8gYmUg
YSBzZXBhcmF0ZSBkaXNjdXNzaW9uKHMpIG9mIGhvdyB0bw0KPj4+PiBkZWZhdWx0IHRoZSBETUEg
bWFzayBhbmQgaG93IHRvIHN0b3AgdGhlIGltcGxpY2l0IGFjY2VwdGFuY2Ugb2Ygc2V0dGluZw0K
Pj4+PiBhIDMyLWJpdCBETUEgbWFzay4NCj4+Pg0KPj4+IE5vLsKgIExpbnV4IHNpbXBseSBhc3N1
bWVzIHlvdSBjYW4gZG8gMzItYml0IERNQSBhbmQgdGhpcyB3b24ndA0KPj4+IGNoYW5nZS7CoCBT
byB3ZSdsbCBuZWVkIHRvIGZpeCB5b3VyIHBsYXRmb3JtIHRvIHN1cHBvcnQgc3dpb3RsYg0KPj4+
IGV2ZW50dWFsbHkuDQo+Pg0KPj4gT2ssIGlzIHRoZXJlIGFueSBleGFtcGxlcyBjdXJyZW50bHkg
aW4gdGhlIGtlcm5lbCB0aGF0IGhhdmUgbm8gbWVtb3J5DQo+PiBpbiB0aGUgRE1BMzIgem9uZSB0
aGF0IGRvIHVzZSBzd2lvdGxiPw0KPiANCj4gVGhlIGFybTY0IGNvZGUgb3JpZ2luYWxseSBtYWRl
IGFuIGFzc3VtcHRpb24gdGhhdCBhIHN5c3RlbSB3aXRoIHRoYXQga2luZCBvZiBtZW1vcnkgbGF5
b3V0IHdvdWxkIHVzZSBhIERNQSBvZmZzZXQgaW4gdGhlIGludGVyY29ubmVjdCwgYW5kIHNvIHBs
YWNlZCBaT05FX0RNQTMyIGluIHRoZSBmaXJzdCA0R0Igb2YgYXZhaWxhYmxlIFJBTSByYXRoZXIg
dGhhbiBhY3R1YWwgcGh5c2ljYWwgYWRkcmVzcyBzcGFjZS4gVGhlIG9ubHkgcmVsYXRpdmVseSBt
YWluc3RyZWFtIHBsYXRmb3JtIHdlIHN1YnNlcXVlbnRseSBzYXcgd2l0aCBhbGwgUkFNIGFib3Zl
IDMyIGJpdHMgd2FzIEFNRCBTZWF0dGxlLCB3aGljaCBhbHNvICpkaWRuJ3QqIHVzZSBhIERNQSBv
ZmZzZXQsIHNvIGl0ICJ3b3JrZWQiIGJ5IHZpcnR1ZSBvZiB0aGlzIGJvZGdlIGluIHRoZSBzZW5z
ZSB0aGF0IGFsbG9jYXRpb25zIGRpZG4ndCBmYWlsLCBidXQgRE1BIHRyYW5zYWN0aW9ucyB3b3Vs
ZCB0aGVuIGRpc2FwcGVhciBvZmYgaW50byBub3doZXJlIHdoZW4gdGhlIGRldmljZSB0cnVuY2F0
ZWQgdGhlIE1TQnMgb2Ygd2hhdGV2ZXIgdG9vLWJpZyBETUEgYWRkcmVzcyBpdCB3YXMgZ2l2ZW4u
DQo+IA0KPiBJIHRoaW5rIHRoYXQgc3R1ZmYncyBsb25nIGdvbmUgYnkgbm93LCBhbmQgaWYgYW55
IG9mIGhhbmRmdWwgb2YgcmVtYWluaW5nIFNlYXR0bGUgdXNlcnMgcGx1ZyBpbiBhIDMyLWJpdCBQ
Q0llIGRldmljZSBhbmQgdHJ5IHRvIHVzZSBpdCB3aXRoIHRoZSBJT01NVSBkaXNhYmxlZCwgdGhl
eSdsbCBwcm9iYWJseSBzZWUgdGhlIGZpcmV3b3JrcyBhcyBpbnRlbmRlZC4NCj4gDQo+IE11Y2gg
YXMgd2UnZCBsaWtlIHRvIG1ha2UgRE1BIGFuIGV4cGxpY2l0IG9wdC1pbiBmb3IgYWxsIGRyaXZl
cnMsIHRoYXQncyBzb21ldGhpbmcgd2hpY2ggY2FuIG9ubHkgcmVhbGx5IGJlIHNvbHZlZCAzMCB5
ZWFycyBhZ28uDQoNCg0KT3V0IG9mIGN1cmlvc2l0eSBCZW4sIGNhbiB5b3Ugc2hlZCBhbnkgbW9y
ZSBsaWdodCBvbiB0aGUgcGxhdGZvcm0/DQpUaGFua3MsDQpDb25vci4NCg==
