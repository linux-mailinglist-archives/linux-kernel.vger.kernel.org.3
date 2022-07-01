Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B57563613
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiGAOr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiGAOr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:47:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900ED13E84
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656686843; x=1688222843;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NjPUfxDct31FxK667u88FLvU9pkDtF/1fkjR4x3TO1o=;
  b=Rw+yxyYB7Pno1xWoXnECMS5Ia7+f8Ipj4BQjiTWzd2H6hcMIwq2X+S2H
   NF0Xysmpp2ExLpJkJAjuQbPoaemPaSno5rc89Wznbvh+NjzvdiEAR/1nm
   mj08gxjpsJwvbxQyh1nbwMIH09KZRg+tyUhHL7XU3t7HjoJvqkQIlDv+h
   wDt850MCbt4QbVfDqfn/0ltiSv5JsDthMpSutdyo/e9Z6sSmWaiNr0UiF
   ll33HzLqu6Fg13xahrDfZFw+uIW9Xdmeaj11t9NkBAYlyUmWQ3kMJ5dWZ
   +nS19svODv/7Pbh9FdLRk7I2Tfow2BHB5OK/4WU7hezrEXO+uHJRY3pUG
   A==;
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="180385657"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2022 07:47:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 1 Jul 2022 07:47:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 1 Jul 2022 07:47:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ch6fTHZ6i9KPHtyVLpw5Owh8zx7uIwCQbvuLA0muUUX6sAHreKHMzesqFlvvYmWb8MjIKRVEdbobPxMawmiIw1BpoYojKxc0a2kr6rjA78naUpNXRmhx6LJwtrLWtyNT2zA5CGe18r/wEFDsvXGLWoGuJIBgXgzz6SbwFHEKsLMv1Qfdt9DHPKx+YhbwYMmLBeZFLicvpP4MHD/YaF6FexuWjm0LiPufMlmtuc1tcQQGJNzJDYZcTqS/JqWtOOyc87O5Eao8tJc6apYnPAXAU8VRpd+rZhl+1iOq0PS8z6t8Vcb6i5m9lN9fDQbt7jrmNwsKwdNliG2MAXbKMOYyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjPUfxDct31FxK667u88FLvU9pkDtF/1fkjR4x3TO1o=;
 b=DQEE9HP5NyQDsXES30sIeQfcopWyzvaHE+lUMkOzZfNkNBcQYulDax/UvTXrgV4hT6BEYNVbcOa6GGICO1W2e09Y591ESXvPcLp5H+BCwjZk5jpUmm4KakGaM6nhzRL6Cu+qRVVn8ybO3tMk0O8KCPPEY05ztW+lHV2W7ZCuzJV9ncEuLCB2uNUrsBhxN/Wj5ZtNjsSfdB0Zhl9OdauUhETgRuG/eV6C5I6tr32cqjr8xurzuXpVf/ioRgZPvW1smoPivX+QmJEWhsu4HVLfYKzfbbC0MD2K6ne4CDnRJzv5mlHllOKSlUSykN232ZGEkBgDlDpvDGt6SyM2npSPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjPUfxDct31FxK667u88FLvU9pkDtF/1fkjR4x3TO1o=;
 b=vjizimLNE5fbYKwc48bNUjXO6uS9p9AUpial5MYnksPoek6B786BDYWU4n1hVeJIwVFkuv9M2b6ZUWQgFWT7dFaHmFb3UpmupSx5eqa3R2SggzOoaWmtsRbs6w84bDq1NtlWgA1FTJvpj9y9+wNqfnkMLT9eS9oaFKUABYlLwz0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR1101MB2107.namprd11.prod.outlook.com (2603:10b6:4:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Fri, 1 Jul
 2022 14:47:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 14:47:16 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <atishp@atishpatra.org>, <atishp@rivosinc.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <wangqing@vivo.com>, <robh+dt@kernel.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <gshan@redhat.com>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Topic: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Index: AQHYikaSsliGXUqkU0W62iFZL9A2pK1mrJEAgAAIIICAAAargIAAEAyAgAAEPgCAAAqJAIAAMFoAgAC8ZgCAAGP7gIAAEAqAgAAdSoCAAA0zgIAAAdqAgAACLICAAB2mAIAA2xUAgAA8J4A=
Date:   Fri, 1 Jul 2022 14:47:16 +0000
Message-ID: <64272301-7fd5-c996-217d-2b83e85fc1b7@microchip.com>
References: <03433f57-04ed-44a9-a2f6-5577df94f11e@microchip.com>
 <b2ab0ac1-bfef-5ba0-4ee5-15e604d8aa2e@microchip.com>
 <20220630103958.tcear5oz3orsqwg6@bogus>
 <9d9e80b8-17e2-b1d9-14fa-f1d8d7dfbd9a@microchip.com>
 <20220630173513.dyrrmjbpxzi3e6fe@bogus>
 <3840dbf7-ca18-b7ab-4d7a-92c9305476fa@microchip.com>
 <20220630200717.zlc6z6zcqbsw7euk@bogus>
 <ddb8238a-003e-fe5a-2a11-cb34c324fb33@microchip.com>
 <20220630202141.37p5qhppkiz6wrcb@bogus>
 <f5d73b6b-081e-328e-6599-92e8abadbdc0@microchip.com>
 <20220701111156.dqmdrj2hzjadojz2@bogus>
In-Reply-To: <20220701111156.dqmdrj2hzjadojz2@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52133f86-da1c-4c3a-95d3-08da5b7097a3
x-ms-traffictypediagnostic: DM5PR1101MB2107:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +GbBwSY5Xo7OgIMZos8VQphi3I1ROicfdqVFctFoehRgi8Aq9GSGHZ1CGl5U/OttT2Xd62ucguwZPo8uQ/+F3rsWqCnY0Cp9REIcqbS2s2s+JHzK4W/WGKdcKL7mUOzepWAqj7p6mHtq7jVFg9a0pfPYqCZPEM9Riqsp/AWtVyqw2VpfQHsXVyVjpD8/m7B49IMxU2Gj7sYUjPVBMdHhUsmG2yimpoIie9oAn9FbKgirzgst1Ykrpuz/F1ZF6VREW8cDRuVgbftuUTOwF2jlNzpCYmUMtgZbX5WfKS3rN3YTDzJO0yJzs4W+r1TEgkY9T3izHdOQNNNCmFcsYct9hESLE66aQhU+C5y+7w+joB/Kx0MQu8KqLvQUpKLlbnNcWcWtS3HMbUUZREZCNxGYAAwUKzkvLx+6TifF52pc6zR+U2QNCDnoI1ZjTWDbqJ1WZ29sRn2UUJms/6CJj6A/MgAmqOP8qoJyMDnGhHuNfj56pijRSb7OBDAS8jNBtG+HqSSNGhSK3I2kKwP7OcAiyh64TgNPxsi8BRGl2DIQ9RH9uxIPIf5Qy1JW74MP4gEnbPpy7XbdINp3QlqbC2dGuPm73iwTfrul6f/8JDv2cNYdBfVcC6mPRHvz5K+GahKpbxGpUIZOH20dopBbUXgdE9DeBBF9RJyGJnaZqJ9dYhUDVDg3JT2g35edKy22KqjOgd2REXhJdmPvFJBvCwHqUJaOibnn+vm97lqWDYNppQkIzV/KeC2uvZXN5ahdcacMRKzZQjKx4JyWWX9JWb6yz/uCvyJl1hA4B3YY3R8e96VQXi3hRpq4ajdonSg8As/3hGCI1YlLhN3wHfik6ZR0kN42Zgo7fQBaOswoTU8kvHKVekwH6i5nVU2lcClUAVfx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(346002)(396003)(39860400002)(38100700002)(53546011)(2906002)(316002)(38070700005)(6506007)(122000001)(26005)(6512007)(41300700001)(186003)(54906003)(86362001)(31696002)(5660300002)(71200400001)(2616005)(107886003)(76116006)(7416002)(64756008)(66946007)(66446008)(31686004)(6486002)(478600001)(8936002)(91956017)(66556008)(36756003)(66476007)(8676002)(4326008)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE5XSWZhanZDaTlibzc5QURmaEgyak10U0QxZzMzU1RsOEZhVStIMktUNTA4?=
 =?utf-8?B?V2hEek5aZVFUR0xQRjRPZkVaOUNUQnVYeGhZcm5rUUhBYTl1T2JYQUFlbkx5?=
 =?utf-8?B?WkphYWI4c2NQYlBudms2V090aVAvTW9mTy9XVmQ4T0J6aGxRUzdCazJYOGJP?=
 =?utf-8?B?R2tUamNtQVlXYzA1Tnh2cWg2NFNMN2xVcVZKY2NtVk5WTXNmdkt2VkNtbjZL?=
 =?utf-8?B?V09mOE93WC9xRXZmK0ExbXNnRHZnb04yeTYzcWZXcHhzVXZtMjNldWd5d2da?=
 =?utf-8?B?bldHNzdJdnVEY2ZPQno4UXNscVRMbk83UGNnaDFja0hRMWN6RHc1RTJqeXlv?=
 =?utf-8?B?Tndlb3NQSGNnNXZiblI1ZUpZZndobnRxendxT3NzK2JNcHdzUFc3YUJ1WnNH?=
 =?utf-8?B?b3RTVEVMRndObzVpeEFZUjRLMnpCSjhPWUtDM3VBUWtPYXhhWi9rZzY2NWNV?=
 =?utf-8?B?aGZTTHFSS0hXYWNqYk1EcUZhbkM1S3A2WDA1cC9hV1NTbDVzTWR0emNqeEtv?=
 =?utf-8?B?ZWhYMlUwVFU2MERENG9lZXM3RmRhbHBNd1ovMzRIN0hpS3VuYlMvVjNUQXFW?=
 =?utf-8?B?eXBvdDNWNldJaWJadjFnN0dCYXJsVkY5c0pmMjA5YTUwRHRpTnlROGhxNGJu?=
 =?utf-8?B?c0hVdmhCVzFQSFF1U2RVeWZSQ3NTRHB0bmZlVkFnM25xZXNrS0JXN0gzb0Qy?=
 =?utf-8?B?VkxPTkdSaE9tdXNaQ0M0d2c5NXhQOEhGRlpPcmpqL2ZCQWtQdnRIcGVBVVpw?=
 =?utf-8?B?bUJMcVB6QnVWaStpbllmVjNkR1EzellVWXpjQ2gxUXNXNi85S2FWNWI2bFpm?=
 =?utf-8?B?djdjdUhHZTZUL0xyckhBUUVvMTJrNUxub3RRM2dsdnUvalRKK0t4anhqMnh2?=
 =?utf-8?B?V2pvRGd0Q25yenVmNkpOYldVRlNPWEx5aEVjMGtCbFc5TzU0VHRhZk05K0VB?=
 =?utf-8?B?ME95Mnc5aFRGaVlXZTR3ZENGL2s2WjNXTjJDdUJtVkFIamZiZXBXYVZza0Z3?=
 =?utf-8?B?SHl0WWpVeHFzQ2c0MmhwUG5KcnluejEwbXgwMVpVZFBiVEhtbHRkMzNJdTRh?=
 =?utf-8?B?aEMzaCsvSnBWQnRkMkZ5V0RzVFE1Y08yVUpwbDFzMjFqSVkya1JCY3RnbVJ3?=
 =?utf-8?B?Z1NFM2FuOVZPMUtHS0R1WDNEbDdJRitvODJMRHJ1Z2VsemFLS3NBcHdBU09O?=
 =?utf-8?B?S0FtWmJRNkRneTZEaWJVSmxyT2RKeXZXdE5YMTc5ZWlCSkl6WmNEUjBtbTNr?=
 =?utf-8?B?T3BiNkhMQzFNZmdjT3Fic3BGQzRwZmlHSkhUbmllNkNTZlpwZFJoVXRtdG9n?=
 =?utf-8?B?enc4K2dNcnhoMldXaGx4VXRPdkFGZFNXNFdzUms2RHlrQUFObjRTWmI1QW95?=
 =?utf-8?B?akxRQXJBdGRqSWxydXhJUDFTTUpaQlBhZ2tmbUgwb1cxdmo3UU9VOHNiNEp5?=
 =?utf-8?B?SWQyQms4eC9WY3RCR1BNL1VJMGVrdFhQMm9PUHJDYmRhb2JDMW8wS3VqeTRW?=
 =?utf-8?B?c3ZDQkt4Z2NsMUdGS0UxQUxRZ3VmYmtkQU1uZHZ6TVM2MlgzUzNMZ09VQ2pT?=
 =?utf-8?B?MVhQUXlFd2F3eGwzUzJ5a3hENW9OaWNYVjBOem1YWVYzZ05KTFBrOVNzMFBX?=
 =?utf-8?B?M05WaUoyV0lUVC9QbDF4UElHRjBaYUVPd0ljSU9FWWhHMVNYRTE0VUx0MUpk?=
 =?utf-8?B?c0NONGVsTzdZUlNMUXViMDhsUnVRK1ZZQlRqZExRVkM5QWRuUHRRZE9jR0Jr?=
 =?utf-8?B?RjJpMEpqYzM1WG1MUGdSYkd6bmJSdmxDM2R4aUROQ0dwb05YNC9jNFp5RXNT?=
 =?utf-8?B?STlBS0Nlb1dzMkJRL1N2NmVNR1VhaU80ZUdiNHh3WFV0OFBSWFFiOVozMGkx?=
 =?utf-8?B?Um4xTXZCQUJLa2x6YUhmUlV4dHNDeFNUTko3em9zQ0krRzlxb1pYOE9iditX?=
 =?utf-8?B?NWZlZ1ptUU5WZWppMlYxeVpydHJjckdrMHRjSTk5U3phWmZuR0ZRYVh0K0dx?=
 =?utf-8?B?NzRLVG52aWpTUndsV0NMQkVDTEMxeXNFQmlXWUZiQUp2aWZpdGVEWk9HOWcv?=
 =?utf-8?B?c1hhYmEwTW4wS1JRamxIWE9wcUpoaEJwMytiUnRHd3pXL1FLQ1pkaHhzVlZC?=
 =?utf-8?Q?oLCK25Qb8H+TJVXOiqPhmzn0v?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EEF37EA78E18849885A8A48E8B13811@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52133f86-da1c-4c3a-95d3-08da5b7097a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 14:47:16.4735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NqF+dLrr34AkrD4/S1rUBdfryXuf2DyRjKzvoLP8pAVRE4n6GqCENk1yfGW6rwnnaofe0FLUUio937QPNXzwCRjym8jZmTl1qx+bnwsUjOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2107
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDcvMjAyMiAxMjoxMSwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFRodSwgSnVuIDMwLCAyMDIyIGF0IDEwOjA3
OjQ5UE0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4NCj4+DQo+
PiBPbiAzMC8wNi8yMDIyIDIxOjIxLCBTdWRlZXAgSG9sbGEgd3JvdGU6DQo+Pj4gT24gVGh1LCBK
dW4gMzAsIDIwMjIgYXQgMDg6MTM6NTVQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+Pj4+DQo+Pj4+IEkgZGlkbid0IGhhdmUgdGhlIHRpbWUgdG8gZ28gZGlnZ2lu
ZyBpbnRvIHRoaW5ncywgYnV0IHRoZSBmb2xsb3dpbmcNCj4+Pj4gbWFjcm8gbG9va2VkIG9kZDoN
Cj4+Pj4gI2RlZmluZSBwZXJfY3B1X2NhY2hlaW5mb19pZHgoY3B1LCBpZHgpICAgICAgICAgICAg
XA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHBlcl9jcHVfY2FjaGVpbmZvKGNw
dSkgKyAoaWR4KSkNCj4+Pj4gTWF5YmUgaXQgaXMganVzdCBiYWRseSBuYW1lZCwgYnV0IGlzIHRo
aXMgZ2V0dGluZyB0aGUgcGVyX2NwdV9jYWNoZWluZm8NCj4+Pj4gYW5kIHRoZW4gaW5jcmVtZW50
aW5nIGludGVudGlvbmFsbHksIG9yIGlzIGl0IG1lYW50IHRvIGdldCB0aGUNCj4+Pj4gcGVyX2Nw
dV9jYWNoZWluZm8gb2YgY3B1ICsgaWR4Pw0KPj4+DQo+Pj4gT0ssIGJhc2ljYWxseSBwZXJfY3B1
X2NhY2hlaW5mbyhjcHUpIGdldCB0aGUgaW5mb3JtYXRpb24gZm9yIGEgY3B1DQo+Pj4gd2hpbGUg
cGVyX2NwdV9jYWNoZWluZm9faWR4KGNwdSwgaWR4KSB3aWxsIGZldGNoIHRoZSBpbmZvcm1hdGlv
biBmb3IgYQ0KPj4+IGdpdmVuIGNwdSBhbmQgZ2l2ZW4gaW5kZXggd2l0aGluIHRoZSBjcHUuIFNv
IHdlIGFyZSBpbmNyZW1lbnRpbmcgdGhlDQo+Pj4gcG9pbnRlciBieSB0aGUgaW5kZXguIFRoZXNl
IHdvcmsganVzdCBmaW5lIG9uIGFybTY0IHBsYXRmb3JtLg0KPj4NCj4+IFJpZ2h0LCB0aGF0J3Mg
d2hhdCBJIGZpZ3VyZWQgYnV0IHdhbnRlZCB0byBiZSBzdXJlLg0KPj4NCj4gDQo+IE9LDQo+IA0K
Pj4+DQo+Pj4gTm90IHN1cmUgaWYgY29tcGlsZXIgaXMgb3B0aW1pc2luZyBzb21ldGhpbmcgYXMg
SSBzdGlsbCBjYW4ndCB1bmRlcnN0YW5kDQo+Pj4gaG93IHdlIGNhbiBlbmQgdXAgd2l0aCB2YWxp
ZCBsbGMgYnV0IGZ3X3Rva2VuIGFzIE5VTEwuDQo+PiBTZWUgaWRrIGFib3V0IHRoYXQuIFRoZSBm
b2xsb3dpbmcgZmFpbHMgdG8gYm9vdC4NCj4+IGluZGV4IDE2N2FiZmE2ZjM3ZC4uOWQ0NWMzN2Zi
MDA0IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9iYXNlL2NhY2hlaW5mby5jDQo+PiArKysgYi9k
cml2ZXJzL2Jhc2UvY2FjaGVpbmZvLmMNCj4+IEBAIC0zNiw2ICszNiw4IEBAIHN0cnVjdCBjcHVf
Y2FjaGVpbmZvICpnZXRfY3B1X2NhY2hlaW5mbyh1bnNpZ25lZCBpbnQgY3B1KQ0KPj4gICBzdGF0
aWMgaW5saW5lIGJvb2wgY2FjaGVfbGVhdmVzX2FyZV9zaGFyZWQoc3RydWN0IGNhY2hlaW5mbyAq
dGhpc19sZWFmLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgY2FjaGVpbmZvICpzaWJfbGVhZikNCj4+ICAgew0KPj4gKyAgICAgICBpZiAoIXRo
aXNfbGVhZiB8fCAhc2liX2xlYWYpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0K
PiANCj4gRGlkIHlvdSBoaXQgdGhpcyA/DQoNCkFoIEkgZm9yZ290IHRvIHJlbW92ZSB0aGlzLCBJ
IGhhZCBhZGRlZCBpdCAoc2luY2UgSSBrbmV3IGEgcmV0dXJuIHZhbHVlDQpvZiBmYWxzZSB3YXMg
Y29ycmVjdCkgYnV0IGl0IHdhcyBzdGlsbCBmYWlsaW5nIHRvIGJvb3QuIEl0IHdhcyBteSBzdGVw
DQpwcmlvciB0byBhZGRpbmcgdGhlIGlmKCFsbGMuLi4NCg0KPiANCj4+ICAgICAgICAgIC8qDQo+
PiAgICAgICAgICAgKiBGb3Igbm9uIERUL0FDUEkgc3lzdGVtcywgYXNzdW1lIHVuaXF1ZSBsZXZl
bCAxIGNhY2hlcywNCj4+ICAgICAgICAgICAqIHN5c3RlbS13aWRlIHNoYXJlZCBjYWNoZXMgZm9y
IGFsbCBvdGhlciBsZXZlbHMuIFRoaXMgd2lsbCBiZSB1c2VkDQo+PiBAQCAtNzQsOCArNzYsMTIg
QEAgYm9vbCBsYXN0X2xldmVsX2NhY2hlX2lzX3NoYXJlZCh1bnNpZ25lZCBpbnQgY3B1X3gsIHVu
c2lnbmVkIGludCBjcHVfeSkNCj4+DQo+PiAgICAgICAgICBsbGNfeCA9IHBlcl9jcHVfY2FjaGVp
bmZvX2lkeChjcHVfeCwgY2FjaGVfbGVhdmVzKGNwdV94KSAtIDEpOw0KPj4gICAgICAgICAgbGxj
X3kgPSBwZXJfY3B1X2NhY2hlaW5mb19pZHgoY3B1X3ksIGNhY2hlX2xlYXZlcyhjcHVfeSkgLSAx
KTsNCj4+ICsgICAgICAgaWYgKCFsbGNfeCB8fCAhbGxjX3kpew0KPj4gKyAgICAgICAgICAgICAg
IHByaW50aygibGxjIHdhcyBudWxsXG4iKTsNCj4gDQo+IE9yIHRoaXMgPw0KDQpUaGlzIHByaW50
ayBuZXZlciBwcmludHMgb3V0Lg0KDQo+IA0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4+ICsgICAgICAgfQ0KPj4NCj4+IC0gICAgICAgcmV0dXJuIGNhY2hlX2xlYXZlc19hcmVf
c2hhcmVkKGxsY194LCBsbGNfeSk7DQo+PiArICAgICAgIHJldHVybiBmYWxzZTsgLy9jYWNoZV9s
ZWF2ZXNfYXJlX3NoYXJlZChsbGNfeCwgbGxjX3kpOw0KPiANCj4gRXZlbiB0aGUgYWJvdmUgY2hh
bmdlIGZhaWxzIHRvIGJvb3QgPyBDb3ogeW91IGFyZSBhbHdheXMgcmV0dXJuaW5nIGZhbHNlIGhl
cmUNCj4gdG9vLg0KDQpDb3JyZWN0LCBmYWlscyB0byBib290Lg0KDQo+IA0KPj4gICB9DQo+Pg0K
Pj4gICAjaWZkZWYgQ09ORklHX09GDQo+Pg0KPj4gYW5kIHRoaXMgYm9vdHM6DQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9jYWNoZWluZm8uYyBiL2RyaXZlcnMvYmFzZS9jYWNoZWlu
Zm8uYw0KPj4gaW5kZXggMTY3YWJmYTZmMzdkLi4wMTkwMDkwOGZlMzEgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2Jhc2UvY2FjaGVpbmZvLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmFzZS9jYWNoZWlu
Zm8uYw0KPj4gQEAgLTM2LDYgKzM2LDggQEAgc3RydWN0IGNwdV9jYWNoZWluZm8gKmdldF9jcHVf
Y2FjaGVpbmZvKHVuc2lnbmVkIGludCBjcHUpDQo+PiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBjYWNo
ZV9sZWF2ZXNfYXJlX3NoYXJlZChzdHJ1Y3QgY2FjaGVpbmZvICp0aGlzX2xlYWYsDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBjYWNoZWluZm8g
KnNpYl9sZWFmKQ0KPj4gICB7DQo+PiArICAgICAgIGlmICghdGhpc19sZWFmIHx8ICFzaWJfbGVh
ZikNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiAgICAgICAgICAvKg0KPj4g
ICAgICAgICAgICogRm9yIG5vbiBEVC9BQ1BJIHN5c3RlbXMsIGFzc3VtZSB1bmlxdWUgbGV2ZWwg
MSBjYWNoZXMsDQo+PiAgICAgICAgICAgKiBzeXN0ZW0td2lkZSBzaGFyZWQgY2FjaGVzIGZvciBh
bGwgb3RoZXIgbGV2ZWxzLiBUaGlzIHdpbGwgYmUgdXNlZA0KPj4gQEAgLTc1LDcgKzc3LDcgQEAg
Ym9vbCBsYXN0X2xldmVsX2NhY2hlX2lzX3NoYXJlZCh1bnNpZ25lZCBpbnQgY3B1X3gsIHVuc2ln
bmVkIGludCBjcHVfeSkNCj4+ICAgICAgICAgIGxsY194ID0gcGVyX2NwdV9jYWNoZWluZm9faWR4
KGNwdV94LCBjYWNoZV9sZWF2ZXMoY3B1X3gpIC0gMSk7DQo+PiAgICAgICAgICBsbGNfeSA9IHBl
cl9jcHVfY2FjaGVpbmZvX2lkeChjcHVfeSwgY2FjaGVfbGVhdmVzKGNwdV95KSAtIDEpOw0KPj4N
Cj4gDQo+IFlvdSBhcmUganVzdCBtaXNzaW5nIHRoZSBjaGVja3MgZm9yIGxsY194IGFuZCBsbGNf
eSBhbmQgaXQgd29ya3Mgd2hpY2gNCj4gbWVhbnMgbGxjX3ggYW5kIGxsY195IGlzIHdoZXJlIHRo
aW5ncyBhcmUgZ29pbmcgd3JvbmcuDQo+IA0KDQpTb3VuZHMgYWJvdXQgcmlnaHQgdG8gbWUuDQoN
Cg==
