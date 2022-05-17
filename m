Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE28529BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbiEQIEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbiEQIES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:04:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0577C2701;
        Tue, 17 May 2022 01:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652774654; x=1684310654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7DE9r3I3ZEejw57XMxp0Y41EnqMex7nPzmpR6+f3o/A=;
  b=Tkf4i9+twMDQ52mbcoAw6SM1QjPXKsYw3tKvnW/PcMUkIz/KK6frh/yG
   zusBpAGBYFa8YTr+rZ3Z/JMcRz4BsTkBzCtufwms6Oldiqjx/2HEidQ71
   +YIdRDGAsx29HFNV1uRpG8TwX2agEKZsQpEbkCcl0FVgeYuHld3SiO0S4
   Ezbw2jINCyVHBIFYhHlHGBpwzk7b4OiNtxO1gAv1O6rboR9lXgEbhfj0Q
   Dh5AkREmvmSeKTzxviYBnS3MQo7AeYxc3tFGm5LnodqWME2E6tP+qX5nY
   jQPCHmcvCE9fAJGYBQnfuUksFHcyCJjmvO/HOfXVgdDxn3MJpwxKViihE
   w==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="173700412"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2022 01:04:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 17 May 2022 01:04:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 17 May 2022 01:04:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja/oZ2gbrIjR3/RviK5uutBsnN/QPMr5oLGx2TXLoXT5fwahhqHg6EQYLx2XLlcoNjsDhi6IayZACCNIxrDMkd5ar3iayuyY4pFWO26TXvebM4kr9f2YztJC7l4UDAEnSc02fCu0oILKb9QCDgkFcV6HikWwCI7JJrx6TWaU6JcOqj1uNHa6R0L+nzsggdyy+hpY4dfKFbP9dYtbN05etTBYWuMBO6fWL6vwdW6JT/kmmaCTtLdbwrOSYwDc0TjODnkl4FOUh0WjaykDq0Oq2GrLFJx32utT4konrh3lrZ9N4zjJ3lq0TtgR1bnOplZxN8BK8ewxh+JlsxFxv/GDXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DE9r3I3ZEejw57XMxp0Y41EnqMex7nPzmpR6+f3o/A=;
 b=dhQ19CVbRE1ctVHh1NTQJjXkPsTxGtqIoR3ITYNOM61w0SSR6FTFNNCgp/zTMPXstZ6XvDyWKhyHeEGb7FaUUXKN+kww5zoRKVmTI0zNxR6T2PDYwFSytlkiPFa0SB/x3jlI7BfR7ImbfhCiaOuqE016+8yhX6M7xMBt8R1ezybA4Y2ZlM4OvPHRIGL/4JM5ZpWY3Txj4oMHpB68TbNySG6o5UW6vRA0o0iXCK6GGfbIUFIbV6QhdGNpzKLGMHuganEB3MGXZhoj41E7hcWu+NF2v8nnPkUihDimJC2VAVNYhkINrHzC+nUqdhGanjZVWTDhEpiD79oVfro3ZvwUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DE9r3I3ZEejw57XMxp0Y41EnqMex7nPzmpR6+f3o/A=;
 b=CSkyumIpH8p+qYUAHEGJTL3Z+/z4qxTS2b1pdkEtD6kzM/T4k5gH6fEQLc+0sjM1gblqpvhrlLK9HVByMd8AmHNSDXccTeOCvNwtSMuWBoAKVpDF06AC60PMxwkC19z9F2XZk5O80LVMkqujTpNm588/YoEOz3MVu8c8GuSpqC4=
Received: from MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11)
 by BN8PR11MB3553.namprd11.prod.outlook.com (2603:10b6:408:81::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 08:04:06 +0000
Received: from MW4PR11MB5936.namprd11.prod.outlook.com
 ([fe80::ddf6:11cc:3391:d4e9]) by MW4PR11MB5936.namprd11.prod.outlook.com
 ([fe80::ddf6:11cc:3391:d4e9%6]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 08:04:06 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <sboyd@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH] clk: at91: generated: consider range when calculating
 best rate
Thread-Topic: [PATCH] clk: at91: generated: consider range when calculating
 best rate
Thread-Index: AQHYTwYLocsblKFTaE2b4sfTx9QXEKz7LfQAgAaxRICAIP5FAIAADdGA
Date:   Tue, 17 May 2022 08:04:06 +0000
Message-ID: <9d1a4b6c-cafa-b864-ba56-3e62f39cebf2@microchip.com>
References: <20220413071318.244912-1-codrin.ciubotariu@microchip.com>
 <20220422011216.A4A23C385A5@smtp.kernel.org>
 <e18eb810-e437-6a19-26ec-1f0daedaaf5f@microchip.com>
 <20220517071440.DAC76C385B8@smtp.kernel.org>
In-Reply-To: <20220517071440.DAC76C385B8@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23709893-d06c-4fab-c889-08da37dbd08a
x-ms-traffictypediagnostic: BN8PR11MB3553:EE_
x-microsoft-antispam-prvs: <BN8PR11MB3553D47329376A7E82C532DAE7CE9@BN8PR11MB3553.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4K5Xoz+QEjBYTGzIHfFoTVpt4N26EsaxJlpgKRSPrmwiy2hKUEJj8auMkuySjFFq2fNWKT//tt8ffOkXeJ95VbyiZolrHCQUvljXbNw87ZPaICgBkVEDXAt/xnyzl0axLaANQ26rq+8tzDsZ1UbM+adlELa334TMyPnZ4QCTD/svy8/SFff6tZgja9jkDjNnBvZlCjVvP96gDHR3efShBXVi3z2Ga/NGuMxWNC2F9TcZ23hxzNBkMHdA1wBxcOV1XPFL+iCfmNWWEb75EOQZwQLKgYwasASljFSarr0/9+ni5JGvG9yqLdxPHNXxlnvRLDd+kavVkhd4NJYu1DATqvfrOsANmxHj4zq/RCH+TfXNJ3+Djw10o083hDMbdhAaYO6uHCW3F8LnHwsZc+NodX8kL9sqCkwwFCC9eJwHtn6jOudMl3qtyovYhxYs++4BzKQX+LsjMwjuX6bPT8e+ekPYJnKA3VnboQC6trQ+5Olhknxq3Z0pVPwnus0neQI0/cAC1pQbOXOI7LtEUo4XPo0BsbNY2o/i9ms8EwfBUAePuI3LNpTj9vTDLRId2/VdvyoTpLmpVI+9i6QUwv+7dH5K93ETHlR4raLDqa7ad1hwMgoFUDJK2ALcneRr0sGxTbUyZx4CQmdcWDe54wsecBpJHbhocVbEnOEG2ipzJwmTv+NH8b/83OpiRri6I7jqdl7uS5DO2UkIv6RsyyNP9663J9lX1K/YowQSE27Hms+cdOT7gXz3bS+vYIKiRnSrV/XYyHijdGSMH+Hn0J06yg6BNV+G5YHftlDcmzPgfQZ4EUTmLbCF48xWsgCUG254vmVolY+6AM21c1CupVNYeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5936.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(508600001)(2906002)(966005)(5660300002)(6486002)(6512007)(2616005)(8676002)(86362001)(26005)(31696002)(71200400001)(53546011)(6506007)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(91956017)(76116006)(110136005)(122000001)(4326008)(31686004)(316002)(38100700002)(38070700005)(36756003)(83380400001)(107886003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTM0MmdSdTdHYWx5ZDYvRWE2OUNJQVpCNGd5T252RjBtTllGRjRVWHNPUXRZ?=
 =?utf-8?B?cHVaNmgwSng5ektEV1VHMkVkcnlZQ2QyMWh1TW9QaUJGQ3IxZk1DampPdVF5?=
 =?utf-8?B?b1hvTWlIdVNMSHdjMG94ZmhRSkkrZmFBNlFybTBuNVpRT1VpVEFVV2ZkaS9N?=
 =?utf-8?B?ZzJXeS9nQmZQUTVVVUFoRDZ6SUhrWEVJUTJScjBYdmp1Vmt0K3RpQlduN05F?=
 =?utf-8?B?ZG1aS3BINzBoeE53RysyWU14aExKTVpUMFl4UVEvZVZ2djJoTnlkdkk1WHpm?=
 =?utf-8?B?U0xoY20zd3lDYk1EcE5OQUFrcXhTVzhFZUJ1alA5YWhNTFZkZmtNYmFob0d0?=
 =?utf-8?B?ODVVQXRYcmw2QVV1Nms4UXFLeE1qTlUxazJhQ2k4Yzl6NXVOWGlKcUNtQ1kz?=
 =?utf-8?B?RlVhSFRNRGpPUlRzVmxpdFRKVW9pS25VTXB4bXk3RXRLaW1VdTc5RWxicE41?=
 =?utf-8?B?blhrSkg3RDNpQ1NCMXF1bDdkK1NMMlFva3FPNkVPS29nSlRDWnJJWG9vL1pO?=
 =?utf-8?B?bVVzK2ZjV1gxMkpSVVJmbGJGVC8rRXc4d3lRbFVacUQ5RnpDMGk1Y05KeDJL?=
 =?utf-8?B?WnJocGZPMDFSdVFFZ0RadHdvT3J0RGdMN0gvNk5CNmhLc1ZHWVhWdTJ6bjRx?=
 =?utf-8?B?L0NmZGl3anVHeWpIUmJSeWhVZzk1TjVXTmhvUmNSczAwdy9uUGh1V2todzBQ?=
 =?utf-8?B?NElXcHJLVFdtMzEzTlZYTGdoTnF0ZjhzbS9VZDFlQXFMVnlhRVFtZjVIU25B?=
 =?utf-8?B?REJ6Sm9lMVpJaWJHUVB6VWFYQ3phbGxBbmVqb0lhanhvNng2ck8zYXFEeGdi?=
 =?utf-8?B?UWRxSFh1SXhWUWpZSkI5eWNubHhJODdmWDdyMFRuZENBUUdKV3pBRTVQMEFN?=
 =?utf-8?B?S1VLSWZEdnViWW1PbkZSM0NTcjl4UEhabFFNNmxXc0FWcmtvd3BYWG55a3or?=
 =?utf-8?B?N3hPdllQQmtqbjhocGRRQ0lQa0crNVFaQVVVZ0x4UUxOSkhyY0VBS3Flem1m?=
 =?utf-8?B?RHFKZ3hLOGd6ejZxcTEySXJPazhXbG5qZ09nQi9XYWRHcXF0TGpWa3MvT0pU?=
 =?utf-8?B?MFRoaHp1dlQyZ2xheEwzSUxJdUVseVlZVzdqd01HeHBvdC82dUJVKzF4UmYz?=
 =?utf-8?B?Z0lFSzZGVUI0T3lJa240bkN5V1BmR3FoTjBWYVBCTzB0N3N5NGVLakMyTlkx?=
 =?utf-8?B?T0FrZEFqSlZURkc4d1dsWDIzT09UOUxlU08rNExwU1ZNeC9JQk9tNjdUMHZF?=
 =?utf-8?B?cnJVU01lTjdqM005dmxxUzRIL1JCLzFIeS9WWmFQa1h2UW8yemF2S2FYdHFn?=
 =?utf-8?B?ZWxBTjJYR1JEVEsyUEtvVmhEZy9TT1hTU1Q4WGsvL0pLMTN4VnJscVZBZDBj?=
 =?utf-8?B?MVhLdHZ2WHp2eG1hSjJaWmxBdXA3aE9mRFRJVU5UMUM1YXFybkpRcVZaenp6?=
 =?utf-8?B?REUrTmpteHNBdHdxQ2ZhU3BSZVFEdjB0VnRJNEdzckRJMG91TzlwdHU2SWVh?=
 =?utf-8?B?WjFhaDl0SnZxSE5vUjZGOGpvV1RIaElway9yZVB3M0pBNWx1bm8xbWJIa25v?=
 =?utf-8?B?Nm54S3FVYlhaU2RpRFJrd0FOSEtHQU96aDdZZFgySW93UG5YZmR3bENWSXpl?=
 =?utf-8?B?MlJlRVN0SmVWbndlSU1CZkVCRW9wZ09hT1Q2TnhjYnB5UkZMVzJRWERpUzFt?=
 =?utf-8?B?YW1HTkJWOUI2bHNTTUZ2R2hlNmV4a3pjc3hxOTFMWUprNk5jbWgzMUFTSFBV?=
 =?utf-8?B?Tm9IdmtVYXhKWHRVVVhPMzI2KzhNVWxsSy8rODhieERPY3F4RUdlTlFBMXZC?=
 =?utf-8?B?OWlYcVhRZW92ZEJJM0tqaXJSWkd4VWFwQlRUNng5K2RXTkJKZUVtcHVDSFps?=
 =?utf-8?B?UHMzcVdrRFpXMCtnOGZtdDN6c0oxY21qNzlpNk91LzRpcHg5THluL0ZheU1Z?=
 =?utf-8?B?dXFSb1lER1FqZnM3eGxJcFozS1lCRUdDOXNOeUZNV1FIYXFoYUtWMWVaYm9T?=
 =?utf-8?B?TkIzM0VEcUk5R0piMVppL3c5alV2b015Z1R5bjltUFdoZ1hFUlVJWThOTHJR?=
 =?utf-8?B?Rm5CRUNWSHVvQ1J0QWloV2pneVltd2FMQVN5TFdudXk3c0RUOHhVb3JFV1NS?=
 =?utf-8?B?SExSa21XNHVzaGEvV0lEUktoSzdjclJOdUNDZDYvajNicndEWnMyOUtpajhZ?=
 =?utf-8?B?b3R4elFCbHJ5c3N3L05rV3R1UlhjaXpQRk5WWTl4NTB5NEV2a29peW1RYVhv?=
 =?utf-8?B?WWRoTjc2WGQ0WDNyYzhmYk5RcnNrY1RpcHY5QXpMS1JlYzZNaVZFQ3RCSyto?=
 =?utf-8?B?VXplVGZUQ0JubEYza0t6Y1E3VzMwcHViVXN4aEtURFR6RDBxSTFtVy8zQjRK?=
 =?utf-8?Q?CUxNjn05MTgMS7NU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79CD4D59918E13409477C3B2BE47F846@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5936.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23709893-d06c-4fab-c889-08da37dbd08a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 08:04:06.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hI3VMnRjg/jLula6H06fdj239rVsuDRBxNSDzsjIqgv/lIyeYSTxCAlcCAVbEkOJItKNo5Dj54BFhKo4l0XDYwsRzLz5T3bVQh9Qw3sLA0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3553
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDUuMjAyMiAxMDoxNCwgU3RlcGhlbiBCb3lkIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFF1b3RpbmcgQ29kcmluLkNpdWJvdGFyaXVAbWlj
cm9jaGlwLmNvbSAoMjAyMi0wNC0yNiAwMDoyNDoxNSkNCj4+IE9uIDIyLjA0LjIwMjIgMDQ6MTIs
IFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4+PiBRdW90aW5nIENvZHJpbiBDaXVib3Rhcml1ICgyMDIy
LTA0LTEzIDAwOjEzOjE4KQ0KPj4+PiBjbGtfZ2VuZXJhdGVkX2Jlc3RfZGlmZigpIGhlbHBzIGlu
IGZpbmRpbmcgdGhlIHBhcmVudCBhbmQgdGhlIGRpdmlzb3IgdG8NCj4+Pj4gY29tcHV0ZSBhIHJh
dGUgY2xvc2VzdCB0byB0aGUgcmVxdWlyZWQgb25lLiBIb3dldmVyLCBpdCBkb2Vzbid0IHRha2Ug
aW50bw0KPj4+PiBhY2NvdW50IHRoZSByZXF1ZXN0J3MgcmFuZ2UgZm9yIHRoZSBuZXcgcmF0ZS4g
TWFrZSBzdXJlIHRoZSBuZXcgcmF0ZQ0KPj4+PiBpcyB3aXRoaW4gdGhlIHJlcXVpcmVkIHJhbmdl
Lg0KPj4+Pg0KPj4+PiBGaXhlczogOGE4ZjRiZjBjNDgwICgiY2xrOiBhdDkxOiBjbGstZ2VuZXJh
dGVkOiBjcmVhdGUgZnVuY3Rpb24gdG8gZmluZCBiZXN0X2RpZmYiKQ0KPj4+PiBTaWduZWQtb2Zm
LWJ5OiBDb2RyaW4gQ2l1Ym90YXJpdSA8Y29kcmluLmNpdWJvdGFyaXVAbWljcm9jaGlwLmNvbT4N
Cj4+Pj4gLS0tDQo+Pj4NCj4+PiBJcyB0aGlzIGZpeGluZyBhbnl0aGluZyByZWFsIG9yIGl0J3Mg
anVzdCBhIHRoaW5nIHRoYXQgeW91IG5vdGljZWQgYW5kDQo+Pj4gc2VudCBhIHBhdGNoIHRvIGZp
eD8NCj4+DQo+PiBJdCBmaXhlcyB0aGUgY2xrX3NldF9taW4vbWF4X3JhdGUoKSBjYWxscyB0byBh
IGdlbmVyYXRlZCBjbG9jay4gRG8geW91DQo+PiB3YW50IG1lIHRvIGFkZCB0aGlzIGZhY3QgaW4g
dGhlIGNvbW1pdCBkZXNjcmlwdGlvbj8NCj4+DQo+IA0KPiBJIHdhbnRlZCB0byBrbm93IGlmIHRo
ZXJlIGFyZSBjbGtfc2V0X21pbi9tYXhfcmF0ZSgpIGNhbGxzIG9uIHRoaXMgY2xrLg0KPiBBcmUg
dGhlcmU/DQoNClllcywgdGhlcmUgYXJlOg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGlu
dXgvbGF0ZXN0L3NvdXJjZS9zb3VuZC9zb2MvYXRtZWwvbWNocC1zcGRpZnJ4LmMjTDQ1MA0KDQpC
ZXN0IHJlZ2FyZHMsDQpDb2RyaW4NCg==
