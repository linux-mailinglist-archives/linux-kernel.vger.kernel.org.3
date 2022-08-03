Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF32588C5B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiHCMq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiHCMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:46:23 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Aug 2022 05:46:21 PDT
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873101B783
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1659530782; x=1691066782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q1pUKXdm6DZTKaW/XjMwweI00xqDT0x2AjLDNChCQfw=;
  b=SFHjh06RhMUOfoJlNfwuEWO8pbszdijeL4tJyITJdJYpa7eoNcuX2rda
   lACM3HlF9D/eZ1I1zfBgofcypXcz1nrct6V9Q7ccbFvmVNhH0p8z67+15
   4cCsNYSaTwcvNO2PN69wKbksbVO8Q5+RtH/km9VhchLB1gML/ClywNCY8
   y1Z0zT2C/ETKtZLz907/LOy3v+DKkJM4rXzZvZ212XHMIfI7vEqHMFUiq
   PGt2hMfK/rN8qLwgRTlRxnPLhDTqDKs9PoMHtoEjrI1BKEc0qdt7kNw3Z
   A0d59w9ZpTSugU6Yvn7fEO1GHqA/SELQi9GLRDKa69UUwemyxi3PTVHGC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="61915304"
X-IronPort-AV: E=Sophos;i="5.93,214,1654527600"; 
   d="scan'208";a="61915304"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 21:45:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBJMM5eW8uQyf04gMjQDRPU5sy93jnlt5iY3LtZJoFzD8nI4YAMYOokEqZ6syiNJm8YY/XGKB09q0Gcx9/+WejZ7IEuj9VraKzfHmSAqJPSDNnA0YrfbVGbGq/EFW3ItWjUTn8810UuS41rRdCj2RbbYl8pru/hChmrqlgfzbP1olUEdtmLV0sujc1zW4VbBa49J0Q8GADBLFP+UzItM/wotoxw287Uc7HhMGsPYWw6CJsVUP8HALpx8tsFnBe08WCwTaIdu1mFvL89+WHjeMgHTYKblXs3zlk5i20hsT0pqlzlEUjkl1Xcvi/jxFvuJ4D7D2GQ5MRNlj6QHuTOhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1pUKXdm6DZTKaW/XjMwweI00xqDT0x2AjLDNChCQfw=;
 b=RCw/fVOAD8UcltfnSH/FoWOFi/OxhpKlDl865sVC7jtXEdcmPsiIlAe7xYdMfvBO52OuAAaFhXz4YyDVljZqgCmOivZWdQjDeDTWiy9ngMPlGmOzXKkDOB6EojfBbhU5iR+Mz4SVCpK4Fs0ktMM5ClEj28wrqNnUUzF1xwO3BdidnP6XDkRqmUTdVWPPvueIlT6dT5ESoPR/0/0F4QsqoSp1K/GwJqOadoCw2cg4CjKehNx/yP2rIskd8zZ0iWY/n9z8Hm2TcrnkU6Ig1V+fHj1jCa7XhHnvN9CtQFoE4ZOIHRzg4o4p+XDrD3NDLWiekEm5eriC3Pjmz0x+cdl7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com (2603:1096:400:4f::8)
 by TYAPR01MB3167.jpnprd01.prod.outlook.com (2603:1096:404:88::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 12:45:09 +0000
Received: from TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9ae:f491:2e96:3e8d]) by TYCPR01MB6160.jpnprd01.prod.outlook.com
 ([fe80::9ae:f491:2e96:3e8d%5]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 12:45:09 +0000
From:   "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
To:     'Robin Murphy' <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>
Subject: RE: [PATCH] iommu/arm-smmu-v3: fixed check process for disable_bypass
 module parameter
Thread-Topic: [PATCH] iommu/arm-smmu-v3: fixed check process for
 disable_bypass module parameter
Thread-Index: AQHYpsmDxVlqTekfrEi2VPEkV3AV062c6GeAgAA08pA=
Date:   Wed, 3 Aug 2022 12:45:09 +0000
Message-ID: <TYCPR01MB6160FF56DA7F9DEB2841C656E99C9@TYCPR01MB6160.jpnprd01.prod.outlook.com>
References: <20220802234207.1994093-1-ishii.shuuichir@fujitsu.com>
 <5bce32f7-c3c2-7750-2c48-1d54eb645607@arm.com>
In-Reply-To: <5bce32f7-c3c2-7750-2c48-1d54eb645607@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZmU1YTk0ZWQtN2Y5ZC00MWM1LTgwZDMtYzhjNTJiYmUy?=
 =?utf-8?B?MWI3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wOC0wM1QxMjozNTowNlo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: fc1cf0c6261b4805a6f343cdb7b6fad7
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e359d9e0-b2aa-4003-745b-08da754dffdd
x-ms-traffictypediagnostic: TYAPR01MB3167:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QBtKz0gI1EJ12VwWk6/TWr8wkBcjqEkxcLo7IIAaIm9AY7UPHUluujEZDNGQqa2n4uu+rSpWT5bb0WErpWumSeBliroOO5g0DDSSvG0Mjxjb/at+FesRq4VfBFF2PGpwZbr3tbtdJn7NOSAo56EzCrsOtcDXdA5VlXYWwNQCBgdIZwXa1V+DCnZZros2ptgRBno9LBakeXZXmfQT/Vyb+sZNTX1RFZ5E2KkR8O93xR3FisinUIZWCQJzVX/d+JK/pOej/FPvZWC4eaqaCjHw6e5GkdwNI53DzNLoyVfqsP2CfYDdxM3EBQnHOXE3nadhU1XjkqhBHuoXvGdOuJClp42HhehdwlSBYzaAvAw81tiQxDxal6Nv0BCSO0ht5X2RSVodWEQgtJxmKp6siJXah4IqlzVo1CaTKNYiFsrt5SEYps9o/OoAhC+zwt9sFAUHI+JBWtBuM7Z5jEvfZth03rv8wCKagv2ks3isbywWV0lh3k/VHWqXSnbphx9p7Ac84ZQecHe6dk4hARudyulfCf1Q5StvCy1DrkN0af9+lOBGwuOhoy6ksdxVTiCak1teA9VcejwNhVCIffYjft7jI7BGR5c5CgYgeYkMnM/8SNe5CZjmmXJ4zWiDIuh9ia5x08zXgy1I0GwZJYtg1FK6tQjSnzRAdWY7Rn8PLGGere84IPa73syP3M4kMT7lmVEOs1jvjhqXLVydkPKoU/bNuSmHLyTI9tDhRjmBGXCeWhFD2PBeBFoIM7reqQqoMp4hxztHJfkrfjDZm7lSbXQGJcXuY1QhmSJ8wX73TwlKcdumI6652MWUHAsp0t+QmMM6Kod27gC7eKDBK54Y14fb7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6160.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(52536014)(41300700001)(86362001)(38070700005)(8936002)(478600001)(316002)(110136005)(76116006)(66946007)(8676002)(66446008)(921005)(66476007)(64756008)(66556008)(71200400001)(4326008)(82960400001)(85182001)(186003)(33656002)(107886003)(55016003)(83380400001)(7696005)(53546011)(6506007)(38100700002)(9686003)(26005)(122000001)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWdnbDlDY0lvQUxaM0VVZU9GbnpqdG4rc0xSTTdvMHJlcGlURFNhWlArYmR5?=
 =?utf-8?B?dkZLSlFsd0ZtMjZzK0RlVXBXZU05ckQ5TysvcE9vejJuREpEcGtIOXYzZ3FN?=
 =?utf-8?B?YlV4MjMwaEh0WjFkYXdkQU9Ga3BPbXZqWXViN0RkMlhGWkhkMGh3eUpvNmpX?=
 =?utf-8?B?cXowT1AxV0ZKbmFMdGpOV2Z1TUNGcFBmZ3pSeUZoN1lWbUNjdGhDbEhEakpl?=
 =?utf-8?B?WE9aNXBudDBEa01ndE81aUJIOUZQQ2N4Z2lmdkhzQUZoc1RQaXpROHVRZnlp?=
 =?utf-8?B?K1RFT2pFM2x0Nkt1MkhxT0dFc2tpbHRQN2tBZUs3SkpuTDc4OGVDTVUxNFBB?=
 =?utf-8?B?Um5abnMwMHA2RjJJQXVDQm1Rb3JIWUxuU2c2SE1MQVVONDVoLzF3YW1zTUxv?=
 =?utf-8?B?U0l3YzdpUUUyZEtmUzEwWHZJcCtpK0NtN2lFdEd1TXNrdS9NVHc1TlRwNW85?=
 =?utf-8?B?Z2VacDY1L3lBUFdWWlBiZzZ6SDA1bWRXYUpqSTZveDl1MTlENkttR0N0M0tw?=
 =?utf-8?B?OXh2WCtiaU91T3hQbEgzMmx1WTFkMCt1RjFacTFYbG5rb21ybWZyKzIxcDhT?=
 =?utf-8?B?QjVjaUZETjhNUXcwY3BzQ056OVk1dlg2enEvTGRQRTlpSTV6ZmRKb1Z4cXZ2?=
 =?utf-8?B?KzBxOVU3V091UFNQTXM5OE5jNUhzam91MnNmZFBFWlp1TjdRd0RqOEdhU2pS?=
 =?utf-8?B?MC9tWERNZGg0b0F2UE45Z29PK1pJeEFqbUxwOGliTUJxZGhKWEwwZVdpakgx?=
 =?utf-8?B?NlNMQ1Y1c1RKMGdBTjAyMkI4TVRNK0pNa2M5ZXV4RGRrZFFHcHVZbVJ6Y3Jj?=
 =?utf-8?B?R1hieE9ZamRJRVNUZ0p0b2ptRXNHemdxVnFrRE5rZU5BRTZoVlBZYVp3bE9U?=
 =?utf-8?B?MmFienZyd0pMTE5tSnh1aUJpNjdpQnhpMThXYWNLUnoxRlY1V0JzdTUrUDBw?=
 =?utf-8?B?S2w3MlpLakFsamZCbVI2WWhZbXM1M25aam1CbGM1dmk5eWNLUks4RFdBOXhH?=
 =?utf-8?B?cDc1SWV6U2NPN0xWb1QzU1dyNVUwUzZYbG5IKytuTzRvcWh0RG1xZjYvbWNz?=
 =?utf-8?B?bW1qUnorTFEvakRQN0hpT1RwVnpzclJaeDA4U2JFYXdvQU90Q0dJdmYvV3cz?=
 =?utf-8?B?cjhpZjlkWGZrakQ2bUhReTc5MEgvcVRqNXZVYjA3RUkrK2NNWkFwa1hLV3J6?=
 =?utf-8?B?ZmNMVEU3QmMySnhnYzNHbFhubHlJNFN4NG5QYUNDUVhJdWJxTTkrbVBuV0l2?=
 =?utf-8?B?WE5sOVNVWERmZmRta0dlRjNXZXhRRy9Pa1l4MGYxQ0dGbkhkeHpWM25iZjcz?=
 =?utf-8?B?aDJlZDdTUWpRWXZjbG1VNEdCdHc1c1p2bkRJRlhOYk9DNy91NnU5Q3ZQUFBx?=
 =?utf-8?B?My8zK1NzWUcyQWRweWtDMVpOaWlmSGswREY4UGxyVmc1UHZUVkZueHZOTTVt?=
 =?utf-8?B?QkZDcUJpS0FCcnRhOURRMTVPNWpvc2NkbXVISitQVkxEaFlYbW82WHNzSHdK?=
 =?utf-8?B?QVc4dk50REhiNVRXSVFxS0NyNkRNQndxWVhhdUxVQmxHTll5dG9zNFA0cUxT?=
 =?utf-8?B?bnR1Wk9OMmRKNllNbGVMUmUyT0tmaVJrdHlXbEJOT3NROHRyVm9ndmltcnVZ?=
 =?utf-8?B?MGgrNW41aUdjYVFlOW44bkYrdEF1TDlvYjdkVDl3ZDB1V21xQ1daNFpYYnZT?=
 =?utf-8?B?aE94Nm43Wk84T05uOXRZdlNrdTJEdTRhRGtLUFBHL0k5SXpBaVRUaDJadjZU?=
 =?utf-8?B?aCt3SzlzeWFMY1pSSTFjMlJoTTllZTNWdDBpcTZwTEozRy9JKytXclVxUjhL?=
 =?utf-8?B?UENudnE4WCtOeTltR3YvL3h1ajY2d1JGM3BQYjQ3Y20yMTF2QlA1ZHRqVmta?=
 =?utf-8?B?UGlCQ1VjelBlL2tXajNaUFpXTFcvZ0hHOVVTS0dEa3l2dWpnU1lVb0dNUFV1?=
 =?utf-8?B?TDZlbkZRYWNVWVEvQkZVWFROaWw3eTEvRStpbWNwZDFCSHVEMjcva29IZXVZ?=
 =?utf-8?B?S2JYRS9udEIzTmNiV1lYNEJidmcxeGdRcUN5UFdmNW9abFdYZGEwd3duc2Q4?=
 =?utf-8?B?R3FCNUVkajNCb0RheDFmTXlGOTh3YXR3MnZpYWlkMTc0UzN2elB4c1VPRTVS?=
 =?utf-8?B?aXpKdVozM1Y3ZDFHWjFWYTRKTHVZOUVkQ1ZDVjRQNkNsOHI1ZXIrc0RwMURB?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6160.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e359d9e0-b2aa-4003-745b-08da754dffdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 12:45:09.1356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttcu7q6TmSVHzW9rgUmOIKdS58Eo/V2Rqk7b+s+DtC9D0UGzD466AdJYUM/c5pfLLv4Jq0EfLg7VHzitOabqi4Rl0Io4Z2miGF4ZoBw+uAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3167
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYmluLA0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+ID4gICAJLyogRW5h
YmxlIHRoZSBTTU1VIGludGVyZmFjZSwgb3IgZW5zdXJlIGJ5cGFzcyAqLw0KPiA+IC0JaWYgKCFi
eXBhc3MgfHwgZGlzYWJsZV9ieXBhc3MpIHsNCj4gPiArCWlmICghYnlwYXNzICYmIGRpc2FibGVf
YnlwYXNzKSB7DQo+IA0KPiBUaGlzIGNoYW5nZSBsb29rcyBvYnZpb3VzbHkgd3JvbmcgLSBpZiBi
eXBhc3MgaXMgZmFsc2UgaGVyZSB0aGVuIHdlIGRlZmluaXRlbHkNCj4gd2FudCB0byBlbmFibGUg
dGhlIFNNTVUsIHNvIGRpc2FibGVfYnlwYXNzIGlzIGlycmVsZXZhbnQuIEl0IHNob3VsZG4ndCBl
dmVuIGJlDQo+IHBvc3NpYmxlIHRvIGdldCBoZXJlIHdpdGggYnlwYXNzPT10cnVlIHVuZGVyIEFD
UEksIHNpbmNlDQo+IGFybV9zbW11X2RldmljZV9hY3BpX3Byb2JlKCkgY2Fubm90IGZhaWwgOi8N
Cg0KU29ycnksIG15IHVuZGVyc3RhbmRpbmcgb2YgdGhlIG1lYW5pbmcgb2YgdGhlIGRpc2FibGVf
YnlwYXNzIG1vZHVsZSBwYXJhbWV0ZXIgDQphbmQgdGhlIHByb2Nlc3Mgb2Ygc2V0dGluZyBHQlBB
X0FCT1JUIHdhcyBpbnN1ZmZpY2llbnQuDQoNCkkgbWlzdW5kZXJzdG9vZCB0aGF0IHRoZSBkaXNh
YmxlX2J5cGFzcyBtb2R1bGUgcGFyYW1ldGVyIGlzIHVzZWQgdG8gc2ltcGx5IA0KYnlwYXNzIChk
aXNhYmxlKSBTTU1VIChTTU1VX0NSMC5TTU1VRU4gPT0gMCBhbmQgU01NVV9HQlBBLkFCT1JUID09
IDApLg0KRm9yZ2V0IGFib3V0IHRoZSBmaXhlcyBpbiB0aGlzIHBhdGNoLg0KDQpBbHRob3VnaCBv
dXIgdW5kZXJzdGFuZGluZyB3YXMgbGFja2luZywgDQp3ZSB0aG91Z2h0IGl0IHdvdWxkIGJlIGEg
Z29vZCBpZGVhIHRvIGhhdmUgYSBtb2R1bGUgcGFyYW1ldGVyIHRoYXQgc2ltcGx5IGRpc2FibGVz
IFNNTVUsDQpzbyB3ZSB3ZXJlIGNvbnNpZGVyaW5nIGEgZml4Lg0KDQpCZXN0IHJlZ2FyZHMsIA0K
U2h1dWljaGlyb3UuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9i
aW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1
c3QgMywgMjAyMiA2OjI2IFBNDQo+IFRvOiBJc2hpaSwgU2h1dWljaGlyb3Uv55+z5LqVIOWRqOS4
gOmDjiA8aXNoaWkuc2h1dWljaGlyQGZ1aml0c3UuY29tPjsNCj4gd2lsbEBrZXJuZWwub3JnOyBq
b3JvQDhieXRlcy5vcmc7IHRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tOyBqZ2dAemllcGUuY2E7
DQo+IHRnbHhAbGludXRyb25peC5kZTsgY2hlbnhpYW5nNjZAaGlzaWxpY29uLmNvbTsgY2hyaXN0
b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI7DQo+IGpvaG4uZ2FycnlAaHVhd2VpLmNvbTsgYmFvbHUu
bHVAbGludXguaW50ZWwuY29tOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGlvbW11QGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBpb21tdS9hcm0tc21tdS12MzogZml4ZWQgY2hlY2sg
cHJvY2VzcyBmb3INCj4gZGlzYWJsZV9ieXBhc3MgbW9kdWxlIHBhcmFtZXRlcg0KPiANCj4gT24g
MjAyMi0wOC0wMyAwMDo0MiwgU2h1dWljaGlyb3UgSXNoaWkgd3JvdGU6DQo+ID4gVGhlIGN1cnJl
bnQgcHJvY2VzcyBkb2VzIG5vdCBlbmFibGUgdGhlIGJ5cGFzcyBzZXR0aW5nIHJlZ2FyZGxlc3Mg
b2YNCj4gPiB0aGUgdmFsdWUgb2YgdGhlIGRpc2FibGVfYnlwYXNzIG1vZHVsZSBwYXJhbWV0ZXIg
d2hlbiBBQ1BJIGlzIGVuYWJsZWQsDQo+ID4gc28gdGhlIHZhbHVlIG9mIHRoZSBkaXNhYmxlX2J5
cGFzcyBtb2R1bGUgcGFyYW1ldGVyIGhhcyBiZWVuIGNvcnJlY3RlZA0KPiA+IHNvIHRoYXQgaXQg
aXMgaGFuZGxlZCBjb3JyZWN0bHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaHV1aWNoaXJv
dSBJc2hpaSA8aXNoaWkuc2h1dWljaGlyQGZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJp
dmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyB8IDIgKy0NCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMNCj4g
PiBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMNCj4gPiBpbmRl
eCA4ODgxN2EzMzc2ZWYuLjI1NmQ3YjJhODNhNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lv
bW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYw0KPiA+IEBAIC0zMzk2LDcgKzMzOTYsNyBA
QCBzdGF0aWMgaW50IGFybV9zbW11X2RldmljZV9yZXNldChzdHJ1Y3QNCj4gYXJtX3NtbXVfZGV2
aWNlICpzbW11LCBib29sIGJ5cGFzcykNCj4gPiAgIAkJZW5hYmxlcyAmPSB+KENSMF9FVlRRRU4g
fCBDUjBfUFJJUUVOKTsNCj4gPg0KPiA+ICAgCS8qIEVuYWJsZSB0aGUgU01NVSBpbnRlcmZhY2Us
IG9yIGVuc3VyZSBieXBhc3MgKi8NCj4gPiAtCWlmICghYnlwYXNzIHx8IGRpc2FibGVfYnlwYXNz
KSB7DQo+ID4gKwlpZiAoIWJ5cGFzcyAmJiBkaXNhYmxlX2J5cGFzcykgew0KPiANCj4gVGhpcyBj
aGFuZ2UgbG9va3Mgb2J2aW91c2x5IHdyb25nIC0gaWYgYnlwYXNzIGlzIGZhbHNlIGhlcmUgdGhl
biB3ZSBkZWZpbml0ZWx5DQo+IHdhbnQgdG8gZW5hYmxlIHRoZSBTTU1VLCBzbyBkaXNhYmxlX2J5
cGFzcyBpcyBpcnJlbGV2YW50LiBJdCBzaG91bGRuJ3QgZXZlbiBiZQ0KPiBwb3NzaWJsZSB0byBn
ZXQgaGVyZSB3aXRoIGJ5cGFzcz09dHJ1ZSB1bmRlciBBQ1BJLCBzaW5jZQ0KPiBhcm1fc21tdV9k
ZXZpY2VfYWNwaV9wcm9iZSgpIGNhbm5vdCBmYWlsIDovDQo+IFJvYmluLg0KPiANCj4gPiAgIAkJ
ZW5hYmxlcyB8PSBDUjBfU01NVUVOOw0KPiA+ICAgCX0gZWxzZSB7DQo+ID4gICAJCXJldCA9IGFy
bV9zbW11X3VwZGF0ZV9nYnBhKHNtbXUsIDAsIEdCUEFfQUJPUlQpOw0K
