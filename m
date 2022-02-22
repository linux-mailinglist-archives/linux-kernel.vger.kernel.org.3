Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E67D4BF9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiBVNzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiBVNzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:55:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166B010E047;
        Tue, 22 Feb 2022 05:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645538103; x=1677074103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uldgvdHXTnJZsKDLYASWNlXiCDLPAn6yccUPyf1zXoA=;
  b=H7hUzzQEPLXN26ZslFudX3wAFEnLO4jTALA+Y8XBtrvv8fqFz+ct9TN3
   cweEw4r9X+zM+9wj5Igll7fwY/f6jwaEIlRSu7hkqA8YnozTWgdtFN7WT
   97+Zdv0pQC8pK5g1rUWnipnDyxG/pcuQfS+eKHgVhkhhR9OQc6RA+bgh/
   gCCeDEiUlrLyHhmaoF/M9d5dWoGp4Tgu/Fbpa2W3nVUd65qtKXonocxn7
   On6GaP+VSe5RRrsQOXKb9fZFg+GszkmT3+jnN7UtD1z6yLQHvQx30tCEr
   3sGvIx0iCdy1v7UXrIbC6jE0u9ch5m/dYI0M1DHYpaI7ACwkSc5MS09rk
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="154431387"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2022 06:55:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 22 Feb 2022 06:55:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 22 Feb 2022 06:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiNmtGJFfhNpl9W5TqeII3IGH6WfGShUaA6rTRMwLVl//xj/QCVlecnG3LTEIkF5TkeXls+0B23CGjP3yx6lNkrusMk4/hfduZWZdHYPagk4BIL9JeKuDrziH9TcervNAz9zTzejc/6VFDP9U1kIv9WHsNyeOX4fuOLqD9NJaF9LA6LYS1vilpTbRKCfsWym7uYuuWXfiL3FKqFlWbOY+C3NSnzHoSjt75QRXHN4HJIGV4V2UptlzxEVChSv3mpyYsPUx9I4rSqDrGfzhrAgQc2pdkvEa6zeJE3h5FkprvLH2lAGMMVA2mTVWXWskMqfe+5iCrwRnyJRit+5OiwOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uldgvdHXTnJZsKDLYASWNlXiCDLPAn6yccUPyf1zXoA=;
 b=lYQF18umx6GCzYIveaJsk/zNqq1pVDNW8DOgo0YsN36HZPl030W3u9PRtWfNlDwXJp/gz3LdJxJxU3e8PXg6nSJBkbn22N6S7ILMBFUJlw/mPEO9bDSwY6Ecd+ISaRTCZMaViueqD4pVCaxtz7a7L/PyUovaCWoR2XVFt5GGo7VtwDftXXZL0KrqD+hPG2q55jsCBfa2a5a9qKcYv9LLsIfj1PuzAr7Oix85XGLuTaswo20zm0jPqs52RsZgdtjRzXbkZDo/2zW7aJTfeDg4qOGU9u/w/mxRJQ3bmvnW57/wjty7FrH51PK7yzdLgj8kQVdOf8q7mriAmWv6Sr80Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uldgvdHXTnJZsKDLYASWNlXiCDLPAn6yccUPyf1zXoA=;
 b=EXDg6DB7FEGGCy4ZirCBnSiglcXc3EVhp2zgwkEe2DYF/qGQCHAmj9wmeKLTJUFhStAp8JkbEKHvSW6/G3tFHwvvdpObEOM+buaqLL/f772ekMQaAMCyAeCqJtiHEho30bB5Tn73c6IgE/Ws52Aj1LN+EDwrEnWrxiqcYb20G6c=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by DM6PR11MB3355.namprd11.prod.outlook.com (2603:10b6:5:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 13:54:56 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 13:54:56 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Thread-Topic: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Thread-Index: AQHYJ/PF9hATniilJUe3fAFeGB3/Dw==
Date:   Tue, 22 Feb 2022 13:54:56 +0000
Message-ID: <81d7c569-d6c2-9167-e007-eda72f34842b@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <44f655d027b49b87065915f6ba2744d2@walle.cc>
In-Reply-To: <44f655d027b49b87065915f6ba2744d2@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bea5d7c-8deb-4a24-9ff9-08d9f60ae89d
x-ms-traffictypediagnostic: DM6PR11MB3355:EE_
x-microsoft-antispam-prvs: <DM6PR11MB3355B23CB37E390DC4CF999FF03B9@DM6PR11MB3355.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Of6xv/ba4ETF+ZBH43feUyVQGod6tKYLiQGOI/pLBC5s75X0twCGTgi3r5mlEKbgTRxzLccR90hQsfEqtGCu2BYdJl3nRNZd5jON2RtmHtY1lKTos0Sc9TrRWKwqdC1Mc4YdnxjOWhXX7v6rZF5ppck2sWb/J+6RSH8OkqLmXtwx4tl0zm+sC9IozN2270qlGfRLuMQ8SUyPizooElUB2H4GLBzLqnrtVrBRn0+JP1OZwi4AbYPrpL8xbU8iW8ZnjKzXVElcc+24EZLPxBWK9uyyr715JeDmh/y9FVQlCj4KSm1+535Fwcr3qwHv/JTJQEt9SexX0UgUUtElLg33hrme20os+McRxUvT/aLmm380UdPlQ4REHR6KsbjlogXO0TTS5hjYbhVQbEtE2+4wKp9ERsi3O/ywNStA99oJEPtUKDoNbjoSrj9I0LvVjBrl4woYbxbi4n06IwgQ1ybJVXspZQ/Zfm4qKVCl8v8cGRluOyp6COND6luWzAPg+shy4InpYzRFibm+W2EK1xEMH8yqWZC/+p7YtzI7scw3zgVrzReaX/jSMIsyTba62cEyfDmhK7e45DY8btSYy+2VAq5H/7cPMjPz148pJ8XplBChZY/FMPcatB1tDMiXLqg4xOnI1gUEe6bFrZneKQMdhfd10PoU3IovAT+lwHwZ0Z8ca1nsDvmWRFAudi1cVwtfeA/5+mWdqIGOtU5HTWMqQBWMXc0abSx9ODsT6OgjVliaZdWMVVR+i3dtEfCsYlYGTuX8eLD4OOEQuIV54a7t+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6506007)(2906002)(7416002)(6916009)(54906003)(53546011)(31686004)(8936002)(36756003)(5660300002)(91956017)(6486002)(2616005)(8676002)(38070700005)(4326008)(26005)(64756008)(66556008)(66946007)(66476007)(76116006)(66446008)(71200400001)(38100700002)(6512007)(86362001)(31696002)(316002)(186003)(508600001)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzZtUmhHdnZFQnRzRjVkalpLb0RMYkh0U1lnT2sxTjJtelN0MUh2SkJuYktt?=
 =?utf-8?B?V2ZJbFJqWE4xTmRxTmozUE03aGVBRTVac0JXdHk3c24zQWgvbS95b2JwRWlX?=
 =?utf-8?B?S3BEL0k0eW5wc2x0U0RIVDRqWWdqbGV3S1R3elRCVGxtcFRmSGVNQ2dhT2l3?=
 =?utf-8?B?RlBlamVxU05rUHdrSllZQ2MwR0tQS2JDcFdJK0pBcDhBUk1sb1pwalF3L2d1?=
 =?utf-8?B?S012WTBuR3BBdFRucHVHWm5UWWlObG9rLzU1OFhOQlJqMThFTTFjZU5FWDhl?=
 =?utf-8?B?U1AxNXBkekd4M1VIaDFJVzg0TFdLU2t1TnVCMUNxSU1Wd1lnM2dOQ29ZbVZn?=
 =?utf-8?B?ZjhzTTBWL3VLZDdWU0UvaTNNNEZkUFhEOWdYWVBhWEt1aVltTkNzTEVjY1V2?=
 =?utf-8?B?NWg0Q3l6WFNESnlKNDY5d2VGMVVhbng1SWtGSUxQOG82NjY4anBPNTVUOEpZ?=
 =?utf-8?B?bndhVDh6Yk1iQXZMSHJUUEE0VkpFNXdyN0VhbjRMbDhaMEJFZFBDV0ZtaVBN?=
 =?utf-8?B?UU12dlY4TXZtNmxVL3Q1MURDeG9RaW9Ba1owZjgrNG1HdkNNNGx0UTBTOVdh?=
 =?utf-8?B?dXhaZGRSaHl1WG5YS0NjTHlNVDN3Mm9FaWtzWTdTWkVMc3g5dFlxNGhWSlBT?=
 =?utf-8?B?bThUaWxncjc5a2I5UTlQVHVUR2N5NElGc2dkUjhLWTR5cGloVm9IaFNMYkdW?=
 =?utf-8?B?S3UrQVhLYlY5NnREQ2xReHhqRndmaFYvNlk0OE1ObU5HSjNPWWVIeHAxdmRO?=
 =?utf-8?B?RzNHRlVpanZ1UzMzT2w1M0hGUllWOG8wRnovQlJMNkg1VU9ZUHY1emlJZ05t?=
 =?utf-8?B?LzlmTjRPcUI2T0tCK2h3SjVsdlZONlNhUWRHNW1jK2JZMWZmdnExcHh1UFBu?=
 =?utf-8?B?SzhLVkJCeHFyOEwzeXBjNzgrYkVBT3F5K0UzaXhmbTd5dk5lRlcxU1RiaElD?=
 =?utf-8?B?UXQ1QWt5SHpkSUZ6aVZydGViU0dpN29ONUFHdDhBaWFvOTZWUzUxVGp3SHhh?=
 =?utf-8?B?VmZ3WEowd21pbUFMYlJlMUhBbS9DWlJwTTRWTlI3MU5vdm5VNGlBZkZ0QXdn?=
 =?utf-8?B?UUV5UCtyUlEwSi9MNjZtNG9FL3pPN0pKUEw4N2pzQ29TeGQ5RE8vbEhGZEgr?=
 =?utf-8?B?TkprSzJVSmxJc0ZoYnUvWGFkUWhRVEk1eWhyTUN6TXBNVXBLYmZKNVdyOUFJ?=
 =?utf-8?B?QldzajBJbHdjem5teWRuOTNRYkxwMVN4K0hBai8zUzgzNHE5NWtFTko4ZXpZ?=
 =?utf-8?B?ekFObHRMY3JNZFU2SG1TVUc5MkM3WXJqU1c2TS9pTlZOR1ROejNlTnRNZktj?=
 =?utf-8?B?cktRNVJ5KzVmc2tpWDNKdlpML003aHZGYjZTQSthWVFDR3VsVlJVeXNsTFlE?=
 =?utf-8?B?TldFN1h3cjRhOExpTEU3WjJ1L2M1QXRQdERTQnRNeHJlZ0V2WEl1UEVMT1Rz?=
 =?utf-8?B?d2xpaEtzQmZzb01TL0JVYy9HWG0rRFQreS9pSkxXOEN5Qy96MVpaSStmWUVJ?=
 =?utf-8?B?Nm1rU3RPWGdTSG14Mk9xbE9VMnd3M1RJUzdxMHBVY2dXczFUQ0ZZenBKWXVX?=
 =?utf-8?B?Z3RqTXM5aXhKSy9LSnZKSkZxZFl6bGV6Y0pIMXNRVUNUUzJUMzVZNG1uQUhj?=
 =?utf-8?B?T3V0SUs1eU4zbUlRVUVqdUhIS1krZVZpTElLdHhGM3d2bkVSdzAxbjZBbEMw?=
 =?utf-8?B?NTg0aUY2RCt4UFgwRHZKV2JiMUo2VzZnVTBLNzArSWQ1WXNWangzWldjekkz?=
 =?utf-8?B?UUVKWktuR0tLbnlNSkhvTDVZOGtZZWg0VldVU3YzVkJOYmowN0VWL2VmM3k0?=
 =?utf-8?B?MitkSVdXSHRtaDUvczArVnl6N05LN1dIOE03UitkOXNaTlQ2dzZJaHRBUjgr?=
 =?utf-8?B?UzcwVVNjWjZPNjRhVEZPcW9EdU1JQzZZbHZhVzYyUWlYUmRtQXM1ZGQzUFVV?=
 =?utf-8?B?OEs3RFh4M3ozejhKc0xjQ05tSkxiS2RxMHUzTm5ydmtBSm9FWEhWRENEbzMr?=
 =?utf-8?B?VGRxT2YrQSt1dDVwa01FbTNTVE9wZWRxaG9PaXd1M0tCSFlycHdid1RqeUkx?=
 =?utf-8?B?NWxoZFo1NW9mVGtWR3J5VEZwa3QvSmpUc0lDdlpqVTU3aTlaOVBzT1JBd0tI?=
 =?utf-8?B?U1NhS0p6R3lCL3U3YmhrcEd3aGo0MngxeU9PRUwyZXI0amQxWXNFdUhiV2pX?=
 =?utf-8?B?Ynd1dzF4UXFlRVJCSTY4eXZ3YVhBSUhDQkNjVmR1aFo0UDVTNEFYU0UzcEs1?=
 =?utf-8?B?YldRMm5FTGcxQ0wxeCtrdGozWGhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD62D1DF1D201540BFF6FA2A981F3591@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bea5d7c-8deb-4a24-9ff9-08d9f60ae89d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 13:54:56.1591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 284d6/vAz09FuIbD7zFIQcems3q6NMLD+2YXFxXuIVMgXi0eN75vrKCOYSu1sA34vC1bWZK9Pzb3+F6wFC2Z2HfI3maMTuoKySMQSHFMu5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3355
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yMS8yMiAwOTo0NCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAyLTE4IDE1OjU4LCBzY2hyaWViIFR1
ZG9yIEFtYmFydXM6DQo+PiBGb3J0dW5hdGVseSB0aGVyZSBhcmUgY29udHJvbGxlcnMNCj4+IHRo
YXQgY2FuIHN3YXAgYmFjayB0aGUgYnl0ZXMgYXQgcnVudGltZSwgZml4aW5nIHRoZSBlbmRpYW5u
ZXNzZXMuDQo+PiBQcm92aWRlDQo+PiBhIHdheSBmb3IgdGhlIHVwcGVyIGxheWVycyB0byBzcGVj
aWZ5IHRoZSBieXRlIG9yZGVyIGluIERUUiBtb2RlLg0KPiANCj4gQXJlIHRoZXJlIGFueSBwYXRj
aGVzIGZvciB0aGUgYXRtZWwtcXVhZHNwaSB5ZXQ/IFdoYXQgaGFwcGVucyBpZg0KDQpub3QgcHVi
bGljLCBidXQgd2lsbCBwdWJsaXNoIHRoZW0gdGhlc2UgZGF5cy4NCg0KPiB0aGUgY29udHJvbGxl
ciBkb2Vzbid0IHN1cHBvcnQgaXQ/IFdpbGwgdGhlcmUgYmUgYSBzb2Z0d2FyZSBmYWxsYmFjaz8N
Cg0Kbm8gbmVlZCBmb3IgYSBmYWxsYmFjaywgdGhlIGNvbnRyb2xsZXIgY2FuIGlnbm9yZSBvcC0+
ZGF0YS5kdHJfYnN3YXAxNiBpZg0KaXQgY2FuJ3Qgc3dhcCBieXRlcy4NCg0KSGVyZSdzIHRoZSBj
aGFuZ2VzIHRoYXQgZW5hYmxlIHRoaXMgb24gYXRtZWwtcXVhZHNwaToNCg0KQXV0aG9yOiBUdWRv
ciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQpEYXRlOiAgIFRodSBGZWIg
MTcgMTA6NDg6MTAgMjAyMiArMDIwMA0KDQogICAgc3BpOiBhdG1lbC1xdWFkc3BpOiBTZXQgZW5k
aWFubmVzcyBvbiA4RC04RC04RCBtb2RlIGFjY29yZGluZyB0byB0aGUgZmxhc2ggcmVxdWlyZW1l
bnRzDQogICAgDQogICAgTWFjcm9uaXggc3dhcHMgYnl0ZXMgb24gYSAxNi1iaXQgYm91bmRhcnkg
d2hlbiBjb25maWd1cmVkIGluIE9jdGFsIERUUi4NCiAgICBUaGUgYnl0ZSBvcmRlciBvZiAxNi1i
aXQgd29yZHMgaXMgc3dhcHBlZCB3aGVuIHJlYWQgb3Igd3JpdGUgd3JpdHRlbiBpbg0KICAgIDhE
LThELThEIG1vZGUgY29tcGFyZWQgdG8gU1RSIG1vZGVzLiBTZXQgdGhlIGVuZGlhbm5lc3MgZmxh
c2ggcmVxdWlyZW1lbnRzDQogICAgdG8gYXZvaWQgZW5kaWFubmVzcyBwcm9ibGVtcyBkdXJpbmcg
Ym9vdCBzdGFnZXMuDQogICAgDQogICAgU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVk
b3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvYXRt
ZWwtcXVhZHNwaS5jIGIvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQppbmRleCBhNGJhOTRj
ZTg0ZjEuLmM0YTM5NjNmN2M4NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRz
cGkuYw0KKysrIGIvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQpAQCAtNjk3LDYgKzY5Nyw4
IEBAIHN0YXRpYyBpbnQgYXRtZWxfcXNwaV9zYW1hN2c1X3NldF9jZmcoc3RydWN0IGF0bWVsX3Fz
cGkgKmFxLA0KICAgICAgICAgICAgICAgIGlmciB8PSBRU1BJX0lGUl9ERFJFTjsNCiAgICAgICAg
ICAgICAgICBpZiAob3AtPmNtZC5kdHIpDQogICAgICAgICAgICAgICAgICAgICAgICBpZnIgfD0g
UVNQSV9JRlJfRERSQ01ERU47DQorICAgICAgICAgICAgICAgaWYgKG9wLT5kYXRhLmR0cl9ic3dh
cDE2KQ0KKyAgICAgICAgICAgICAgICAgICAgICAgaWZyIHw9IFFTUElfSUZSX0VORDsNCiANCiAg
ICAgICAgICAgICAgICBpZnIgfD0gUVNQSV9JRlJfRFFTRU47DQogICAgICAgIH0NCg0KDQoNCg0K
