Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BE05607B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiF2Rtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiF2Rt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:49:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54BF294
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656524965; x=1688060965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0dzmVzP2M9KrIiqyIpUnOu7xEeb/0zaVT7pQk/U85pk=;
  b=b/v1Tm7aSZI+teTzdAVQT8jGuiA+QjPE3EmvM0NVXmF5TFVOLy0B+fFy
   EqQ2GLnfmkf8XD1DWSFA0/cyd7O68z7NbfvMu3U2mMSEqNUM4S635f4qm
   9tA+skWXSZ4fIcamBVtNIW4Eplo0gxbIlZAISl2iOCrjpeLgXi2nGsxFa
   rx3puNAG/GV9fE2XBGzjVLj+ObzsA+1sHIcb5zb1aZ6HGXl5fg91Zpg2b
   LV86B++9jZ8jSYRmEjkCONWPgtj/PqtuZVgURlOkiFEbqZGps4kH9QXZU
   snltXGH3AZ9qxoM+qRlauzU5tccgMzJSsfmuNBbjYr2JXv+JEZ1lD31i6
   w==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="162630032"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2022 10:49:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Jun 2022 10:49:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 29 Jun 2022 10:49:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvppErm8KZZzobj5Nryxnqa0cLqc+483iWOIViPi2XxKWrcgacu8nkaefmNSnBKKIf2TVTWfJMFS4XI9te7/k9Jep0pXV1XNyMtu9DWm7kjJoH9qG/PoV8WFY6bMx0krUI9/NWp8T8vWQYxo1o1QR00t+KvGtzUCjoRKweza0rpF5fZCylm+c49Qm2QiEwp155cfNimcUnAqyZ1F6OabHZ3QKqseiG6pQjll2ob63bVyfsm1oSkaqWQ2bysbkU+25B6+VCOEGAXQ1yNmK09KcL74B/wy5WEUXqao/2Jl+YDh9dH+7Yeposyua+ZTXXkNeIbZMs8NfiOrCIW1/aXRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dzmVzP2M9KrIiqyIpUnOu7xEeb/0zaVT7pQk/U85pk=;
 b=eUTp+Ge2n4AqSXjSIfj0NKlQMcbv+VNKrS+jttqPhshYtbcA81O5dI0GULFgjk1pTgU6RmThqBIeGpYz9ZVeQPF+xwv8NAplE95XHEI54Z3vmu97OVyXSEQHqsvPo5p8HNZuBUiQxTYFkNX/jk/qG/nn2o3O+W4qV6w9nhYSBni3MUE0n7PEhBXMJf5YaK14GlZ0dqaeGXv43A/9qiMJC4pL34lctfig4t/REhabUxFAZmvNF/TiRCTKnbXMIIT9noMPeugljVMHR3QxTlMjF6NzqKlYpFzN0r98tzvlKcGOJH6Znbm9W+uu3a3F9y63vLRFmeQ3rwwZefHf2QUw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dzmVzP2M9KrIiqyIpUnOu7xEeb/0zaVT7pQk/U85pk=;
 b=DAOL6z/hSTOuG40jV0z//0+jIGGJfmA7GFW7uIRbeR5XVed6GGJdd/iQqTXBtYZZp83BIk1EPstcDIL6oG35AFJYFD4rEOnS8RHPrA7vf/eY7amPMlcjSQv6cedIJxY3hlyrZSnbu+HBDwGpYB7RcoKH0n4r4UFxYOB4T4wvAps=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR1101MB2091.namprd11.prod.outlook.com (2603:10b6:4:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 17:49:21 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.022; Wed, 29 Jun 2022
 17:49:21 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <atishp@atishpatra.org>,
        <atishp@rivosinc.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <wangqing@vivo.com>,
        <robh+dt@kernel.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <gshan@redhat.com>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Topic: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Index: AQHYikaSsliGXUqkU0W62iFZL9A2pK1mrJEA
Date:   Wed, 29 Jun 2022 17:49:20 +0000
Message-ID: <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
References: <20220627165047.336669-1-sudeep.holla@arm.com>
 <20220627165047.336669-10-sudeep.holla@arm.com>
In-Reply-To: <20220627165047.336669-10-sudeep.holla@arm.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5cdbbba-34f4-4e59-0225-08da59f7b25a
x-ms-traffictypediagnostic: DM5PR1101MB2091:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8OL6pH+bJ0uSkmMPWWHKuyhtD8xV6e2gLshDvdrh9iORkOCgXgZoDDR8VmHpLDys64aI0jc4ETTiJ7m1IXtaKquhYd7/h7IlT0j2ZKdwdJyFj2eC8HXWwKS2d13hnLmK/vApU/+cSXGlOhW1CyrNQsbbp315ui8g9Ffm8K6X+dZV2T4BwHYa7UlGFj5e2h6OO4HYFKs9AEVmb27BWr4oqp7WMk7E7lvaQKxH28rAWe8WfO8Su0Mj4al/VYpBVDU8iXa7+8f/HtrCorrv0/wwDbLJQgjfOLrxAlsJYTvLm/TPm+oYkRpewtibnevZe56OjohblF+yYcH3b3eLG4vzsRpyAuMhYiAPOYm63wzJjcA24dN+HiBj1pAzOLiqXx4Vs6m/mGWXe9/ODKDyyPnyn7jAThiIYWbKlddcYB5RRcg82vp4bEsWx8zFtsq9Zm0nHd4CTowdwdBZFf3FpHwneT9ltn4wB8b4VepNhgeW7fOe7WYXKJi32wYWPny067/FOrOakMV88cQqZL17tApl9F7lg6Qijxn2QrvAZ/NQEwapXH9IbO2lsHgI9lquulLTUzuQQ5B+bU8usKvBIR7CBZCYVpCergBMzph/smgZRwW2iuG2eC+MWrlAK56WGvoOLoZzwv1xAa2AOsgiLX6mUhodcFbLAENkTbjXr1hJhSA+ZMmDCRaenmzZ5oYTKUTNNsls8p6+I0q2IhEf86aFcXffCXodQfKAgWgY7Epvz8TYQMPhcSTdifXDbxZWMlb3RKkWiwfb9NHOixKx3nUktmSE9N9LfVMwHgaz4FlNjwx0qdgt6gA4WLNwVbD+5RCwcqWuZ7R5THTIj0yuKqZztEeBdZ9wYReIkmuh3RXol+YuK+QQjXNrDRHHi9uVby8M1K2jGu6u1wU9zDWqi1/CHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(136003)(366004)(396003)(346002)(110136005)(54906003)(4326008)(36756003)(66446008)(966005)(107886003)(41300700001)(26005)(2616005)(71200400001)(66946007)(31686004)(186003)(8676002)(478600001)(38070700005)(6486002)(6512007)(2906002)(5660300002)(316002)(6506007)(7416002)(91956017)(83380400001)(122000001)(53546011)(76116006)(8936002)(64756008)(86362001)(66556008)(66476007)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXM0d3B1VTgyMStPTHJTWTlOblptYXVnVlZQRnduVVM0VnBUL1JuaG4xckpQ?=
 =?utf-8?B?dFZNWWVLMTdFS0JYQzNCUjlsUTdPT0NXaldYS2VnNUlKcmk5U3FLU1NZU1RD?=
 =?utf-8?B?Z212bjBhdTY1bW8vKy8zbnpEc1NsY3c0UHVpLzBpUVZobmNReDgrblQzMkRH?=
 =?utf-8?B?UTQwSkpaRXlQT1dJcUV6dzMvRTZYRlp6UnNib0V2eFhLZlFRMzJHdEJ5WHNz?=
 =?utf-8?B?dkVJV0REL0NTY0UrMFptUUJSQW1oOGJVUnBtOEUxbTlOZzgvTmlXRGl3MENE?=
 =?utf-8?B?ZWlXdU52ZEhEdHdERE9iVlhSN0kvMjFPVm5JQm81Q1M5bDYzR1ZUQVlGek5O?=
 =?utf-8?B?c1FUMGcyeHBlc1RjOHh2cDdNQmY1cmJJSlNqaUgvNzJySnRrMzZlZ25qa3Jq?=
 =?utf-8?B?TkJjcHI5S2xSVURKcmNiY25Yd3FnMzhUWWdyYmdUNklpT2w2U1dSNFB1T1Bs?=
 =?utf-8?B?bytKMktVT0VyUkpEYnZIMVluZWY5NVpkaTJ1d1B4ZFRvQmQzb1B2NjAwdnpH?=
 =?utf-8?B?SHQyVTFZOXl2VlFKek9SRG9LcDV1K3djMUxhUzlwNWs0MWQ0VmxXTnFnNjRI?=
 =?utf-8?B?VG5ldGg3RU1PMXloRkRlQnNjanFUK1FQZGRub3BqTEtiZFYxWVJCcHFlZ2JG?=
 =?utf-8?B?NS9uNU1udUN5QXorNUp0OVlFd2w1RU5kengwQ2lDRC80Mi9aYkFyOXhORHpS?=
 =?utf-8?B?Tk5IRjgwbVRzUlhUOFBGQ2xYZEM5UHBsOVVaQytNTW02Y2Z2QXlxMnFEZUI1?=
 =?utf-8?B?SHVKRDFxVHdYWHdZNzNBR0RWUis4MGs0TDZ6K05jL3hEdWxCMXlpWkgvMStz?=
 =?utf-8?B?clR2YmYyY3kyazZCYllCcEFiR0FubUwwTU8rMVFNMWxteUdlMSt5VWJMcGgv?=
 =?utf-8?B?TjNpTEpza3FCRVRZV21UREp3OTNxOC9pUGdudWFiWnNQRmd2cnFWQmxmRWRT?=
 =?utf-8?B?emF1eVFENTFoS09uZ2k0T2c4UFQzM2VYVXJWKy9ZclFPVm9hYWxGZTV1VTUx?=
 =?utf-8?B?VnBwTVE0a2lRZjQ1S1JkdlJFcFh5U0JScGFJR2t1bkVRZitaRStjTmQ5VitG?=
 =?utf-8?B?cTdKdEhvS0VQcWgrcGhPaUw0M2VYNVJ2dHJOczlwYm9XaVBmN1VkZUZOajV4?=
 =?utf-8?B?WkNxTzNEL1lUTFRPbkRCSmJtd05RcGJaeGNNdjVlaDQ0RC9ieTJnT25sMW95?=
 =?utf-8?B?cjJnUVhUdGxpek1wbnE4UDh1NWNkK3V6NjNZeHljcklGcFc0YjhZaGhOclh4?=
 =?utf-8?B?Y1g4Unp2Mm5TaTdPOExWYjdWK2pSd05obzNVZ0Z2cUp2NTQ0QXVQODNjOXhM?=
 =?utf-8?B?UzloYjN1U09rYlNwSE5TQytLVTVMU1ZJZ1g5bzRqdFNnSnZwWUdpVzU5VmVm?=
 =?utf-8?B?N0FzeTdaTmZCejUxQ29LaDJTRXBpUlR2MngzMDRMQi84a1BiMHZsb0E3bHEr?=
 =?utf-8?B?YXVWdVpvczRiVlEzM0dCVDJJRmx1VXhvRFVsTFVsZFovcUlpb2xMQ2xKZnRX?=
 =?utf-8?B?bUxsRy9RTitGZm96K1dkVENrWUlhYXpYalRaUVU0Ty9XQzlvYkRCdVJ6QXhi?=
 =?utf-8?B?MllwNlU4bEZBM21mSGl6SmNiMmh3QmhLNjgydU9rKyswL0dTSDNaTWx1RTVF?=
 =?utf-8?B?TElWckk3MG1IWHpJeHlOU2l3a2cvNTJXYVk5SFZjK2Z3WmdUSDVQTm5uMUNF?=
 =?utf-8?B?M2xNNUE0d2xjRmllUks0dzV3WnBkQVptUzhSWjJ0WFlIaW5CSkFKbXFtZWli?=
 =?utf-8?B?cW9XMkFSZHBtT2F2Nngwa3orS09lM2NRc1Y1aGVqaGJzeEZpVDVQa1BuaVIy?=
 =?utf-8?B?RmJ3aHRqNGtYOEo0b1JLRFRzaFpoSVNHNmtXNUJBV0ljQUxLWnJKRzIzRHFK?=
 =?utf-8?B?THY0STU4a2xVY2RySGVET3ptYSsxRksyR0JDQ1laOE93TU5zSjJsRm81WnI4?=
 =?utf-8?B?c2VFL0lWWFQ1TitRa3BvVTUrNmN6Ums4R3ZGZUNWdEpFZkxQNWhiQXVGamtN?=
 =?utf-8?B?MWFqMUJUMTY0SWs5aVpJREptc09zMnNudERqcVhGcVVWSk9qZHZReFFEaHc2?=
 =?utf-8?B?dHpnTTlDeWN3c1NmTFNLNEY3U01yeTRRY3RvUUpURUV1dGp1NHNMeC93Q1FJ?=
 =?utf-8?B?dHZhYzJmSVlIY05YaW9vMHJpSERKc2NSOHpWS01rR2w0WHJuYjVGdDVLdktm?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E6B8E73D939B945BED3C2BFBCD1F144@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cdbbba-34f4-4e59-0225-08da59f7b25a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 17:49:20.9915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9W6NG6cLZMkNTvNcR0V245r56jPsze3G+WzS0wxKCGlWrAwLAwPosu2SVMJi5f5e0B9/oTl8moG3qTvXBzRgpVjiOwWDmnRsTQ//eB2EYaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2091
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDYvMjAyMiAxNzo1MCwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBjYWNoZWluZm8gaXMgbm93IGluaXRpYWxp
c2VkIGVhcmx5IGFsb25nIHdpdGggdGhlIENQVSB0b3BvbG9neQ0KPiBpbml0aWFsaXNhdGlvbi4g
SW5zdGVhZCBvZiByZWx5aW5nIG9uIHRoZSBMTEMgSUQgaW5mb3JtYXRpb24gcGFyc2VkDQo+IHNl
cGFyYXRlbHkgb25seSB3aXRoIEFDUEkgUFBUVCBlbHNld2hlcmUsIG1pZ3JhdGUgdG8gdXNlIHRo
ZSBzaW1pbGFyDQo+IGluZm9ybWF0aW9uIGZyb20gdGhlIGNhY2hlaW5mby4NCj4gDQo+IFRoaXMg
aXMgZ2VuZXJpYyBmb3IgYm90aCBEVCBhbmQgQUNQSSBzeXN0ZW1zLiBUaGUgQUNQSSBMTEMgSUQg
aW5mb3JtYXRpb24NCj4gcGFyc2VkIHNlcGFyYXRlbHkgY2FuIG5vdyBiZSByZW1vdmVkIGZyb20g
YXJjaCBzcGVjaWZpYyBjb2RlLg0KDQpIZXkgU3VkZWVwLA0KSSBiaXNlY3RlZCBicm9rZW4gYm9v
dCBvbiBQb2xhckZpcmUgU29DIHRvIHRoaXMgcGF0Y2ggaW4gbmV4dC0yMDIyMDYyOSA6Lw0KSSBz
dXNwZWN0IHRoZSBpc3N1ZSBpcyBhIG1pc3NpbmcgIm5leHQtbGV2ZWwtY2FjaGUiIGluIHRoZSB0
aGUgZHQ6DQphcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLmR0c2kNCg0KQWRkaW5n
IG5leHQtbGV2ZWwtY2FjaGUgPSA8JmNjdHJsbHI+IGZpeGVzIHRoZSBib290Lg0KTm90IHN1cmUg
d2hhdCB0aGUgcmVzb2x1dGlvbiBoZXJlIGlzLCBvbGQgZGV2aWNldHJlZXMgYXJlIG1lYW50IHRv
IGtlZXANCmJvb3RpbmcsIHJpZ2h0Pw0KDQpUaGFua3MsDQpDb25vci4NCg0KPiANCj4gTGluazog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIyMDYyMTE5MjAzNC4zMzMyNTQ2LTEwLXN1ZGVl
cC5ob2xsYUBhcm0uY29tDQoNCmJ0dywgd2h5IGlzIHRoaXMgbGluayBpbiB0aGUgcGF0Y2g/IFdo
eSBpcyBhIGxpbmsgdG8gdjQgcmVsZXZhbnQ/DQpMaW5rcyB0byBib3RoIHY0IGFuZCB2NSBleGlz
dCBpbiB5b3VyIGZvci1saW51eC1uZXh0IGJyYW5jaC4NCg0KTG9nOg0KZ2l0IGJpc2VjdCBzdGFy
dA0KIyBiYWQ6IFtjNGVmNTI4YmQwMDZmZWJjN2RlNDQ0ZDk3NzViMjg3MDZkOTI0Zjc4XSBBZGQg
bGludXgtbmV4dCBzcGVjaWZpYyBmaWxlcyBmb3IgMjAyMjA2MjkNCmdpdCBiaXNlY3QgYmFkIGM0
ZWY1MjhiZDAwNmZlYmM3ZGU0NDRkOTc3NWIyODcwNmQ5MjRmNzgNCiMgZ29vZDogW2IxM2JhY2Nj
Mzg1MGNhOGI4Y2NjYmY4ZWQ5OTEyZGJhYTBmZGY3ZjNdIExpbnV4IDUuMTktcmMyDQpnaXQgYmlz
ZWN0IGdvb2QgYjEzYmFjY2MzODUwY2E4YjhjY2NiZjhlZDk5MTJkYmFhMGZkZjdmMw0KIyBiYWQ6
IFs5NWM3NThhODg5OWM0ZTg4MjVhMzVhNjJhNmYzMTY2Nzk5MTIxN2Y5XSBNZXJnZSBicmFuY2gg
J2RybS1uZXh0JyBvZiBnaXQ6Ly9naXQuZnJlZWRlc2t0b3Aub3JnL2dpdC9kcm0vZHJtLmdpdA0K
Z2l0IGJpc2VjdCBiYWQgOTVjNzU4YTg4OTljNGU4ODI1YTM1YTYyYTZmMzE2Njc5OTEyMTdmOQ0K
IyBiYWQ6IFs1Y2JiOWFlZWZlMDA3MGI2MjdjZDVjNTUyOGU2ZTYzNzAxNTYxZDU3XSBNZXJnZSBi
cmFuY2ggJ2Zvci1uZXh0JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvZGVsbGVyL3BhcmlzYy1saW51eC5naXQNCmdpdCBiaXNlY3QgYmFkIDVjYmI5YWVl
ZmUwMDcwYjYyN2NkNWM1NTI4ZTZlNjM3MDE1NjFkNTcNCiMgZ29vZDogWzJlNjU1NmJhZTNlNDUz
Y2YyN2YzZmI5YzYxNDQwODBlMmE2MTcwN2VdIE1lcmdlIGJyYW5jaCAnbGlibnZkaW1tLWZpeGVz
JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbnZkaW1t
L252ZGltbS5naXQNCmdpdCBiaXNlY3QgZ29vZCAyZTY1NTZiYWUzZTQ1M2NmMjdmM2ZiOWM2MTQ0
MDgwZTJhNjE3MDdlDQojIGdvb2Q6IFsxN2VmZTc2YWYzM2Y2YWYwOWE4MjFhY2NlMmUyZTRlODQ4
MTlkMzgxXSBNZXJnZSBicmFuY2ggJ2Zvci1uZXh0JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG1saW5kL2xpbnV4LW9tYXAuZ2l0DQpnaXQgYmlzZWN0
IGdvb2QgMTdlZmU3NmFmMzNmNmFmMDlhODIxYWNjZTJlMmU0ZTg0ODE5ZDM4MQ0KIyBnb29kOiBb
NWFlZWFmNDBkMzEyODhlOGVmYTZmZjJjYmQ5NTJiMTNkZTA3N2FhOV0gTWVyZ2UgYnJhbmNoICdm
b3ItbmV4dCcgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L21taW5kL2xpbnV4LXJvY2tjaGlwLmdpdA0KZ2l0IGJpc2VjdCBnb29kIDVhZWVhZjQwZDMxMjg4
ZThlZmE2ZmYyY2JkOTUyYjEzZGUwNzdhYTkNCiMgYmFkOiBbZjY0ZGZhMzZiMzI1ZDEwN2Q4YWNh
OTcyNzQxMDM0M2JkODZkMzdkY10gTWVyZ2UgYnJhbmNoICdzdG0zMi1uZXh0JyBvZiBnaXQ6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYXRvcmd1ZS9zdG0zMi5naXQN
CmdpdCBiaXNlY3QgYmFkIGY2NGRmYTM2YjMyNWQxMDdkOGFjYTk3Mjc0MTAzNDNiZDg2ZDM3ZGMN
CiMgZ29vZDogWzg5NDU5YTJhZWY4ODMyZjA0NGM4ZmJiZWM1NGI0NmNlYzA1MTU2YzhdIE1lcmdl
IGJyYW5jaCAnbmV4dC9kdCcgaW50byBmb3ItbmV4dA0KZ2l0IGJpc2VjdCBnb29kIDg5NDU5YTJh
ZWY4ODMyZjA0NGM4ZmJiZWM1NGI0NmNlYzA1MTU2YzgNCiMgYmFkOiBbMjRjZGVmYzk2OTczZmYx
YTFmNjcwMjQ3MGFkOTFhYjAxOWU1ZmVkZF0gTWVyZ2UgYnJhbmNoICdhcmNoX3RvcG9sb2d5JyBv
ZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3VkZWVwLmhv
bGxhL2xpbnV4IGludG8gZm9yLWxpbnV4LW5leHQNCmdpdCBiaXNlY3QgYmFkIDI0Y2RlZmM5Njk3
M2ZmMWExZjY3MDI0NzBhZDkxYWIwMTllNWZlZGQNCiMgYmFkOiBbMGQ3MWYyMzZmMGExMDY3YWJh
NzY2MGQwNTZhOTA2MWI1ODc3YmY1Ml0gYXJjaF90b3BvbG9neTogQXZvaWQgcGFyc2luZyB0aHJv
dWdoIGFsbCB0aGUgQ1BVcyBvbmNlIGEgb3V0bGllciBDUFUgaXMgZm91bmQNCmdpdCBiaXNlY3Qg
YmFkIDBkNzFmMjM2ZjBhMTA2N2FiYTc2NjBkMDU2YTkwNjFiNTg3N2JmNTINCiMgZ29vZDogW2Jl
NmFiMmU4MjI4ODhiOGQ5OTgzZDY3MGZkYWJjMDlkNzUzZmQyNGZdIGNhY2hlaW5mbzogVXNlIGNh
Y2hlIGlkZW50aWZpZXJzIHRvIGNoZWNrIGlmIHRoZSBjYWNoZXMgYXJlIHNoYXJlZCBpZiBhdmFp
bGFibGUNCmdpdCBiaXNlY3QgZ29vZCBiZTZhYjJlODIyODg4YjhkOTk4M2Q2NzBmZGFiYzA5ZDc1
M2ZkMjRmDQojIGJhZDogWzg1NGEzMTE1ZjllYzBiODg5MDE1YzY4NTRmYmMwYzFkNjlhNDZlNGFd
IGFybTY0OiB0b3BvbG9neTogUmVtb3ZlIHJlZHVuZGFudCBzZXR0aW5nIG9mIGxsY19pZCBpbiBD
UFUgdG9wb2xvZ3kNCmdpdCBiaXNlY3QgYmFkIDg1NGEzMTE1ZjllYzBiODg5MDE1YzY4NTRmYmMw
YzFkNjlhNDZlNGENCiMgYmFkOiBbM2IyM2JiMjU3M2U2NWIxMWJlOGY0Yjg5MDIzMjk2ZGVlN2Yw
NmMwYl0gYXJjaF90b3BvbG9neTogVXNlIHRoZSBsYXN0IGxldmVsIGNhY2hlIGluZm9ybWF0aW9u
IGZyb20gdGhlIGNhY2hlaW5mbw0KZ2l0IGJpc2VjdCBiYWQgM2IyM2JiMjU3M2U2NWIxMWJlOGY0
Yjg5MDIzMjk2ZGVlN2YwNmMwYg0KIyBnb29kOiBbMmY3Yjc1N2ViNjlkZjI5NjU1NGJkMzliMGIy
YjJmNGRhNjc4YzczNl0gYXJjaF90b3BvbG9neTogQWRkIHN1cHBvcnQgdG8gcGFyc2UgYW5kIGRl
dGVjdCBjYWNoZSBhdHRyaWJ1dGVzDQpnaXQgYmlzZWN0IGdvb2QgMmY3Yjc1N2ViNjlkZjI5NjU1
NGJkMzliMGIyYjJmNGRhNjc4YzczNg0KIyBmaXJzdCBiYWQgY29tbWl0OiBbM2IyM2JiMjU3M2U2
NWIxMWJlOGY0Yjg5MDIzMjk2ZGVlN2YwNmMwYl0gYXJjaF90b3BvbG9neTogVXNlIHRoZSBsYXN0
IGxldmVsIGNhY2hlIGluZm9ybWF0aW9uIGZyb20gdGhlIGNhY2hlaW5mbw0KDQo=
