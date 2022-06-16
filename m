Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7830354D9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357345AbiFPF1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242913AbiFPF1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:27:19 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90073.outbound.protection.outlook.com [40.107.9.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6D35AEED
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoANzO67cZ93+m/7e5HD5dxDQ3gY9ZXiAaDlOk3XlOWN8YU602HLl6OsDhpUkfdgHJH9+yHJQpQLqkQXsaduxGH90ZHekSK0PkSRVTC7X3P0xokV3lXvxrDKPnI20yOePnQddNKtb3U8UXqp9zlsL7vWogT63BEF1JC+QtsVURmPIJXTg1xgpvk1sQ5GeZryuB7imT9sb5B6xWpvc/Crigl8AZqADNpkYQeKu9EYrUwQz7szwWIacby80Ifq2uIfUcECwHKylDOUR45SmTEdIWihcu2Ai9xQmUe/SOnu1sZpOaS9GZAXcf9pQrHM4K8oajB/VboTTet6DbVRXCtj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHucbkq8ZKs7qi9ii6ep4WKls2fpTci3b9BYrZTa+4g=;
 b=YiNet88dXgoPSZ9zUvNrqsvqKx4NuA/ChXYbnIKae3Icu3jP/xZ61It46hHvBGvERv3HHBLOhO49c2vC5n3Sk4nFNWwqOxJ5yW9bITyAxiswaEkrYa0h8gLBln9USjEVrakxCIrglj+9H2baAQlSkFbXq2JVgCU8b5ZZl1Hl3XjE/Q73y0e+lqDzrmfqnNlf91jTYL0Qmw72IuQg2w8asRMH+nBrk3jFhBFaJGtiXAD9dgRMy0bU1vDbdnSt+I3L+GHIcMhyjBGyMCqwbTKLyQOnljgAt4hx3qGe4Jm9/qkq+4GvR+wk28NAwdkKcE5cIoUcdYvibUWQafPtTtenWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHucbkq8ZKs7qi9ii6ep4WKls2fpTci3b9BYrZTa+4g=;
 b=HgWdDvcFIpHW1337aC92FAQp8WYitrqhmS5hNmmnprtb8X8gRyWgtX+yPnwIHBeosrRYJhxrD7RCpCTPPcCfUO97YSn9NbZuK2TyR2Y9yQgL0i8cEvIwMbQsVGb6JoJqk07o6FaRm5zP7HV3K4YJzY734nJXqXY7caUNqJoouCBMOcoI9esXGrmM0JXtK3+yYL01YijR5EvME/6XqZodyswKMqTiKOS3FQ1HYl76E3SJnMNdNmn/wnFzJfQ1VcRfm8Cq0jsguKNAVTCXrfpS8CTgThRMp/C7g8oRADctQY0eUu9bWmGQAUUg34UsCcbzi79ze7GQniDQn0yj+xAn0Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB4077.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 05:27:15 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%5]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 05:27:15 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 2/2] mm/mmap: Drop generic protection_map[] array
Thread-Topic: [PATCH V3 2/2] mm/mmap: Drop generic protection_map[] array
Thread-Index: AQHYgTbqSfMGmo1TpEeDUHkZHTGmdq1RgQmA
Date:   Thu, 16 Jun 2022 05:27:15 +0000
Message-ID: <8819cd0a-4120-9afe-e491-2843681a0e7e@csgroup.eu>
References: <20220616040924.1022607-1-anshuman.khandual@arm.com>
 <20220616040924.1022607-3-anshuman.khandual@arm.com>
In-Reply-To: <20220616040924.1022607-3-anshuman.khandual@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 946b5b6a-82dc-43e2-14fd-08da4f58df91
x-ms-traffictypediagnostic: PAZP264MB4077:EE_
x-microsoft-antispam-prvs: <PAZP264MB4077CEA64BC2A5173FCFC1D3EDAC9@PAZP264MB4077.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nkRoOGTT8pXP2FWynuKzxzH5YL2/yRtiQbzitUZcZWtt5c5vCWNVrkYV/ZtGpe8IkQThWtXQjN5qbsTM5BPsMu/rsjZOaMl3qjm5vZpX61CGYQLpYvWDQaVw/0IxcFfS881wKSZuiXIFtoecD+m/kcc4Wbu6nnEsiYamdlzNt16D5rWHYMRuuDcr8Cq58imRsl/cmfAIjTfNGh788UI6uo+Xy6FDTgp29+/njT+3nIKqMNd4WR/y6g13nz7OqICzgKZQmBSwEw6M8j0jbOi+0uvN6XajtFVYAEyGWsLoQ51jFCHLHCWISIbVYPsTR4LfWt3Jbwf8zkQZCsCT5sURMmXOUi2gKVeDyfd7bpHuGpSQyk1a0ev7gDRRW6KrFWPcxyXBDqXxB7x4DGNICb6hCwleqYkjgWwprFJ7yPLyfhNjqJiiZbHqAXYStVSEjHfqk2F9QHhFM/fTVm8aJf/opA3ufDD/0EWCGcvHYAVGElJ+YLQt2Suo7ssdt8NR2RsX2vOP5pg0Mk9yqGcVFXOwC1/4FU3Xxlg5eD64O63WLh7AddOUFmrN1d1kNQBrk+rx4c9IkUWz+jLnArjP933hxbcGuRYAtdafZUXmf0TpA7IMWI8nKpbZ1M/xQ1KsHaA7FAPxOS/kGNWPIg+DS9jpnUxbEpT4t3cJ0Fypilo6j7w7Iah6T85bqgZAT7Q5z1cuw9SFNrJL+ewFADCquKRGlkZ12NfpV28v1Vb8dsZPeImFK/OBleUqZVwo3Gb1m7NZHdUUZiYzHqnsJOuAADE7bLaunpJ88UZziDInmk9eaU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38100700002)(2616005)(186003)(38070700005)(122000001)(66946007)(8936002)(5660300002)(8676002)(64756008)(66446008)(66476007)(66556008)(6506007)(76116006)(4326008)(4744005)(2906002)(44832011)(91956017)(26005)(508600001)(6512007)(54906003)(6486002)(71200400001)(316002)(31696002)(86362001)(31686004)(110136005)(36756003)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTFuakZQakQyQUR1TXAvL3FYV2szam5QeDlFNXZrTDJFRnBpM0toRlgxaEZK?=
 =?utf-8?B?QzcrV3A0cHJWSGgrSFdLUzFNRjVQZjg1UTFidDZOWTA2NTl2T3VkOERQV3hI?=
 =?utf-8?B?WnBva01ra25aL2RMaVhkaGRyRGtDczNndnorL2hEcXE1K0ZqZzA0MjFKRVdU?=
 =?utf-8?B?TEM3aStBcDlndXl6VTN5ZjFUVVJIZ1FWVDlCMlA4K1cvMVJuNFcxU2ZqUmxu?=
 =?utf-8?B?OUlyQkFtMG5KekpIVUZSbXNYRm1PL2VlYldMclNIZEVpMW5uRFQrdzc3VTFh?=
 =?utf-8?B?WDQrM1VsYW5FZWtqemtIMWpnN2JxWUlXbldNNkJkYTVBbmNzZU9qdWwyVi9j?=
 =?utf-8?B?QjVaWnZ0RFhKY3lZNWJqanpSazMvYTQvYnNzZ1B4RXhUWndZeFpXUGV3eHVT?=
 =?utf-8?B?Q0FIVFBzWmdwanhudXU2WklhR1VuMGJCTGY5dkVxdklLUFNrMzlsQi9rOFJI?=
 =?utf-8?B?VDNaaEhrdWQ2WFVpQzFCRHpVNVFUQkszY3EzUFQySnRad0dIWGd5YU15Z0Qv?=
 =?utf-8?B?T093QThsOEJkSzhXMUw1VUhDd2pUQWoxYThwUnduSzVuanl1cDhVWTVUcitn?=
 =?utf-8?B?bW56WWQ2K1VvS0xYQXVjMTVoaXA5eUlaNEV3c01hZFl3dGc5bWR3QU1YeDlG?=
 =?utf-8?B?eUJJWkp3T0F1VjR5cjVWYWpnelkrRGU4Wi9YMUM1RHJNZTQ4ZzFJTWw2aVcr?=
 =?utf-8?B?dURJSFJGbDZmbktWQmtqeUpoZUhUTlVkdkZCSXdBbi9NakgzZFlUT2V4ZVlN?=
 =?utf-8?B?K3hWZlpIZkYrL2lXK0FGb291dVV0V3I2eUswNTVLV0NJNDY2NTFYeE9XNnBD?=
 =?utf-8?B?eklLZnpJNGN0MnlkQW4xNjRFVjJlWWY0YWZCd09xay9tODdoakpkcmQyZi9W?=
 =?utf-8?B?Rlh4bEp6UTg2Sk9GVy9aSFR0OVZyVWRjcWFpb09DNHZVejBnRWVKUVA3MFBm?=
 =?utf-8?B?dExkemVLR2R0MXpNR1NHcFdUWG9waE9teUpwV0FTWm45RGNKVjR1cFk1ZXBH?=
 =?utf-8?B?VzFpV3FhaEZibHFOdjQyK2o5c2UyaTZlNHdXbGJodGptQXVQVFErcFhCK0Z1?=
 =?utf-8?B?bVo0dWpHUmo0bk5HWVVOeFF6Y2FIYUZ1dU82RG9peWx6Z3JINm96TGZDaTN5?=
 =?utf-8?B?WThXQ05iTENSNmU0a29qQXI4UnJ1dXVaWEozajZvejFTYWFMekVmSGl6Qncv?=
 =?utf-8?B?aEUrZU9BSzVvSEpqTHFMY3o2dXpudGRPcWVxemJhSS90eWVyVzRPYVNBMDNm?=
 =?utf-8?B?RWF6QkdrWGc1ZXBZNktJMEd3V2NMd0Vwc0JpOE1BdDFJQzRyN3ZaRUtndmpV?=
 =?utf-8?B?U214dnU4NHduVzR6WEpQaEN4REhGajJRcno0SWVwM2lCbXpqMkRacnpKTnpa?=
 =?utf-8?B?b3pEbXo1ak9LaGRpV0xmU0g3VGlNZXdnMHFUVXlqMWZsQWxKdkJDSVlHaFFJ?=
 =?utf-8?B?OEVLQkdLTXpXN1l5WTQ4WDhPS3JjbVFBSWIwQllJbkVqZHJRL2VsUnlSU2Za?=
 =?utf-8?B?YjV3U3VPSnh6eVhYUUFGVUljbjBYK1hIdi9oR2hneEpFcFhuRHJ1aHQ0YWVQ?=
 =?utf-8?B?QXZCV1dNckZiY3Z0SlY2YlIrSURjWUJnY3BjTHR4MzVLMU5wMzdwZWFjSC9x?=
 =?utf-8?B?d2g0dXFuRTV2dVdyTHk3aEgrYmU3WHlYUGdySU8ybFNpeVZubnlnVkdqSTdt?=
 =?utf-8?B?UFNjSDBmMGM4ZHJCM01BbGl6Y2dZZ3BqRGFaWC9qdFpRTXdwdlRsNnh0MmF2?=
 =?utf-8?B?NlMvZ0Y0SUZCRmRPaWFLZFdoUG1WWm1qVkhKck94T1J3YXFrU2NDMnJMWm9Y?=
 =?utf-8?B?ZWlsbldCWTB4djZ6cEZoTndybzk0cnFNOVpjNUExTFZabEtwL2t4bE9IQWFx?=
 =?utf-8?B?WHZxRzl5NlptVlpPNFBEdVR3VW1haVV3N3JWK0JmUjBLbFBVdEpXMHJlYm0z?=
 =?utf-8?B?Y3NReUg5TU9IWVJFWnNuL25FbmNGMVF1UEpjNlIxRkRVWUpOVWI3OHk5NEdB?=
 =?utf-8?B?Z1ZrT3pMVksrajNrWFM1Y05qTUNIYWtkOGoyZVdsTU55UnB1QUpxaS9seEg1?=
 =?utf-8?B?Z0hsYVJaeFp6blNPZXAxUTJTMUpjSmQ0VmQyVGRrb0x1ai9yZFovRU5qVUVp?=
 =?utf-8?B?UTJDQy90M1dEODhUbDI4dkV2NFRta1FCb3RCWVRCYWhBb0g1aVhyMG9xSHBP?=
 =?utf-8?B?cHlQMHNqMjJrd0JyeXNpakNNWHVuSDdGc2dsU1UwdTFwbllBOXpCTElvRExw?=
 =?utf-8?B?THYxa3VGck9XM2J2K0tEV0ZjdnZ2TG9BN2NmaDFyRnNTUG44bmZ2Z1JjQWMy?=
 =?utf-8?B?VmJ6WUU1R25LWThGN21OSG55dXh6MW0wdnl0d3RJaCtvV252LzJFdTVOSnlX?=
 =?utf-8?Q?WjICj/3ixLhFXAdilnbR2I1mUfUtBvx4QhCBV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59DAADFCBEA771459E245855E9CD14BD@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 946b5b6a-82dc-43e2-14fd-08da4f58df91
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 05:27:15.2577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wsx59JrzQ9yP2vOl0/hr0n4d1Bd0OEax7EgbJSY07QGqmcEvF/kruu65mUp0Wh2GLOFYNFvZQBl9mgG6U1DgPztVfXTi+nbtu6HsuINVYUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB4077
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE2LzA2LzIwMjIgw6AgMDY6MDksIEFuc2h1bWFuIEtoYW5kdWFsIGEgw6ljcml0wqA6
DQo+IE1vdmUgdGhlIHByb3RlY3Rpb25fYXJyYXlbXSBhcnJheSBpbnNpZGUgdGhlIGFyY2ggZm9y
IHRob3NlIHBsYXRmb3JtcyB3aGljaA0KDQpzL3Byb3RlY3Rpb25fYXJyYXkvcHJvdGVjdGlvbl9t
YXANCg0KPiBkbyBub3QgZW5hYmxlIEFSQ0hfSEFTX1ZNX0dFVF9QQUdFX1BST1QuIEFmdGVyd2Fy
ZHMgX19TWFhYL19fUFhYIG1hY3JvcyBjYW4NCj4gYmUgZHJvcHBlZCBjb21wbGV0ZWx5IHdoaWNo
IGFyZSBub3cgcmVkdW5kYW50Lg0KDQpJIHNlZSBzb21lIHByb3RlY3Rpb25fbWFwW10gYXJlIF9f
cm9fYWZ0ZXJfaW5pdCwgc29tZSBub3QuDQoNCkknbSBzdXJlIHNldmVyYWwgb2YgdGhlbSBjb3Vs
ZCBiZSBjb25zdCBhcyB0aGV5IGFyZSBuZXZlciBtb2RpZmllZC4NCg0KDQpDaHJpc3RvcGhl
