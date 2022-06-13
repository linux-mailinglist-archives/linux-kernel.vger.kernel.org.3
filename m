Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC18354A239
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbiFMWo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiFMWoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:44:14 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5498F31344;
        Mon, 13 Jun 2022 15:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F34DSK4xezmHPN3cFWnxgoHpWkUhIeJO5hcCDsQa20JkfxbTWTGjR/9AfTQcEFmRZDuPfJPOr0//4BWdYzFSjdRsvmKWLKYgyWSthBi/MQG+ZpAWHLG9WMEV5dksdZXrCmeIqpklXDFSUSThP1d8/5gey9+NTUSwJZI4MCTAWdrlQ9IVoCkzUnBS/RLFqqac2xE2AH+gsb6PHk2BPqk2eczibQFm7ZDMQV7jxtozoc10d5aK0km+AfnGwLrrLlV58zOWPhZi52sFMJIOjKgaLJX7qHS+jjtXjyA3EQF/5/ESVV22of9G6/Oe6tHJdr77Xmxo7P9qIBLAv0pEvK43uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir5rz8fJ/jW/enhdicNVppht0L9l9eaXkakrtNirGTM=;
 b=PtnuRW+7QzRak118scyBc0bQ2CWemlOCPOfQp3iPceXbVBGHzDl4J7y6xt7EArSMiN7cYlhIYd97LM47Bm1L1aNVZQFTNSoJOnEkfD/qnKG6TaQ9kbJ+hXmFvz+1HbaQ86H63ElJKN8PN5rGhETsMHbzuRnxQMqsvtkoxKvn+GirFeYcC8Z+jXwx8GlGOoI8Wi160af4hc+aj0Uf5T3wqCw56PkO6B96nzpHDEYhrq57Qxe5mu9nwDyOP2S6nBVgQm1AjHzr1ZOgvV56PyjdWFdG7+W6TwudMBNr6bIvlMHhi6qaBAaRqMjnyHaoQ3lh3In00PW5o+X6zFaBstfTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir5rz8fJ/jW/enhdicNVppht0L9l9eaXkakrtNirGTM=;
 b=EEk9iDoloD4zTMDH+svU8c5hGScaDL6w+UfNpOLemAs8BS3sRopzsn5ZpADfWT4V86zPed3RUhXvdDHCOD5Z8F8ccbcsI/9kK9pKDBqSNsfFkpH57qKTW6oWeut2vXvppEQf0P1p2Iru7UXcwjPhV3XzxYIixfyYzOdBQgN//NWH545Micgku3g+KODizxYJ6q+nKqkHInXQ2PwNubYRNRgU4q1q/ANC4UHTIxu3hoItVqyw3kRI5mkYmKmY1Do6UHnUFywxiDq2l7uHkZHE1NSxe851Ee9rwrszwE3p0cd0TX2ZSLKplBmJ6ynXYhfYgHPxwBoxUT0oO38eAiSA7Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN1PR12MB2510.namprd12.prod.outlook.com (2603:10b6:802:28::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 22:44:10 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 22:44:10 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/20] block, blksnap: module management interface
 functions
Thread-Topic: [PATCH 03/20] block, blksnap: module management interface
 functions
Thread-Index: AQHYf1dczDvW61stMUWvrJE2W9102a1N74GA
Date:   Mon, 13 Jun 2022 22:44:10 +0000
Message-ID: <629624d9-4a1c-211b-c37b-4873665f8aea@nvidia.com>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-4-git-send-email-sergei.shtepa@veeam.com>
In-Reply-To: <1655135593-1900-4-git-send-email-sergei.shtepa@veeam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cdd3f9c-52ec-4424-be88-08da4d8e3b4d
x-ms-traffictypediagnostic: SN1PR12MB2510:EE_
x-microsoft-antispam-prvs: <SN1PR12MB25107C0BC725E6BB88FBCC3EA3AB9@SN1PR12MB2510.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WaAKdKsuK1a0sYM+F6odZaJOMndYYxzHMVRksgxB8THHHuCh8cGz9Z3JnNgpnq4z8SVTEVcoZrApK9j7mgKF9QhOKSMjPdXmGnBGemyf9R4IQ+lMF0LzxdSkC8xsyLLJ4Iqmr5gtfjOafd1i5eQieN2SepnTHYCwbRGpQMbEsgi8jkCL5W9bTm8GGfgnzeorMo31M+JhRrnYHWOfKSrSn2nciKwUwcN58inOedMBSMes/OcXQyhX6QQ5Mm7Kk9nSaHotAw5N5j/7MxDMaIvBSXAqfgx8kKF5MPX6x+TtKEHFor7+TLcMG/tJDcr9b0rhNwEL/WanADHeNnsTHcyp09ZIiHtSkG/qIVNOGF8V4bEQ9vVP9rW9PWOgWKGvzdxAR1ni249kQfdIvKYFSrolxk+fczg7+2sCuC5IgBsk8NK9RSWhc3e9tMS9IjjIhlTdkUi+h/o9ylCkFnnFQ9f13LJnICx3sf7fEphVay9+mc3hThNmbAiY++FnTohqkHOjyjMOuiG3Tn9XZYUDvvJU4vj6lzUPywlwjXdmync/D+N0Gv5c2/Z0Iibkaogu80pzFgXGko9I3RmhKHktqKdDJ239b47SpP8sly2YMhgx8stqabDOQX2IWOWwlMANLEoTzIzhsnP9EYEFhnTeQz+hY83KM+eh2HTgBalRmknzpr5cEaRa6L5rmJy8sltYKw65/ATTS+23gdRSYnphoqRFUqHXgDlr4cmGq32xWPRS5DCJYrhiSZpF+52zamZPH4bPrCHJ5/qMfWA6wr20+RIYdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(110136005)(316002)(36756003)(86362001)(38070700005)(2616005)(6506007)(4744005)(5660300002)(31686004)(186003)(6486002)(64756008)(8676002)(66476007)(66446008)(122000001)(66556008)(76116006)(2906002)(66946007)(91956017)(71200400001)(31696002)(8936002)(508600001)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXFYRVo3d0swL1poTTdNRHd1aURZRkE3STAvU1lqQ1pqK3M1eUQ3OGxoQjFo?=
 =?utf-8?B?NVlXczRxQTg2UmN2THkyNDlyaU8xY0VvRnZZSUsxbHNCWGtXTlhjWjFDeU5N?=
 =?utf-8?B?RDdiSHd2MnJyZUJKcHhuNERkb29JRVo2eEpOOVh6cldsNFc3eUJ5ZWZDTHZ2?=
 =?utf-8?B?UmZmdk54N04zUUYvY2c5Zlo4bmhSTTV0SGdad3lWVUlQeFEzdHBURDZNeDE0?=
 =?utf-8?B?RzBmQ0hzbzdwdmJQSm1OSDhMUGMwQjhCWGFsalRySmJ5aWdKOGFlL2FwTTJN?=
 =?utf-8?B?ei9KMEJoOXM3Yy9YTzBzOWxNKzF1b1ZBMmJMYlBqVEo4TUhJdkxndTcvWGx5?=
 =?utf-8?B?VFhZUFpGYThSYkI4eFpnYXA0RXpRN1l2b2ZFQzhWalRjbWpoeHRjbGtyMTQw?=
 =?utf-8?B?dmZHSDhxZHA0dFZiUzJpT3Y0c0RuR3l0M09wOE1IZnNJT0pVTVRvY2hySldn?=
 =?utf-8?B?ZHZwSUFYWnRoTnR1WDcvbDFJN0FhUk1QNlNGbVp2cnhvSldhczMzTzd3ZVU2?=
 =?utf-8?B?bjIvN0xBR2tuczFhdlA0UW85djVLdUI3dm8zZXBzM05FNnRxdTFIMVVBenIr?=
 =?utf-8?B?RkYzK3NxcTV4Z0ZBMndMdWZBK1hwdjM0eUwySnkwR3FKZldGazNWc05LdkFk?=
 =?utf-8?B?eTRZZXZ1em1FUmI4N3RIdzJ4TTlabk45OUN3dThiYlQ3eUtaMmJ4TERkdUZH?=
 =?utf-8?B?UUl0b2doaWhUWG01MENvTWZTWU1vRm11YXhVbWVuTTRKbk8vWGs4UzY3NG14?=
 =?utf-8?B?Z1QrYVFxcy9EcDI5YVVsdTBLSWZhM01PeUVqZDh1OWx4L0ZBUm9GeXNzbUd1?=
 =?utf-8?B?UWU3QVczeGtnSXFodm5QVVBDaWJheVp3LzZQbE43M0UyeXY1NURpNUtrS1lX?=
 =?utf-8?B?b2d1VG0xU2wzT1BOK3JlU3JJZVUyZUlPaU8xL1BuVThpbS9PTE8wK3VPalJI?=
 =?utf-8?B?SGM2MytqNmFDdlpTYStyZW5UNXhXSUVXcHlacFJwQkVYV1dIeVZMWXc4NVNi?=
 =?utf-8?B?ZDlXQlZVdmU2RTI4NG1xNW5WTnUxR01IUjRXd2tMVGhRQndXekRBTnRZWlRv?=
 =?utf-8?B?cENqVVhsc3ZkQ0RFd2toRzh0ZVNVb2VPV0xMaE9PSm50U0kxYTc2V2pCUUYw?=
 =?utf-8?B?QXJ2VEpJY25xNEZObmNvMnd6Y2kra2VUV3lSUm9BbEpiYm55TFZiaTJ0VnZ2?=
 =?utf-8?B?SjJxZ3BSdDVheGhDMkxMbmIzMXVMTzBJeXdSbjJmOTNERWNlRjQ5WGt0OVJv?=
 =?utf-8?B?VlNsWWtMYUhZNU5qT0RySXIwdTlxT1lSZ2NGN2ZyTFkxekxMZmVZL1hpY1VQ?=
 =?utf-8?B?U3htczRsdDQvY3RybXc3eXUwRTVpS05uZzF4Qy84Q2sxRXYzODNmN3NycjA0?=
 =?utf-8?B?Y3FVdnp0WFovT3l0WUJPZVlGVkNXeW1keDMxNFczOTJ1aEN1blMyL1QrWnFD?=
 =?utf-8?B?Y3pVRi9SRTJGR2dIdTVCWHk2UGFhVk5Nd1VIcVVPOU4ybElYKzVIT0Nob0c3?=
 =?utf-8?B?aVZSSEpHV2RNVUpGbkV0K2VPZnV5T3NsMElFWThEN1VvWElkZ2hISWFNWGxs?=
 =?utf-8?B?WnBIUiszQzNoL1VLTDVIUXRxYTlrL3BVR0pua2E2YWxKM2ZqT25rVWpSRFBk?=
 =?utf-8?B?UEoraXBEN0lCanNrWVErbUpxcDZ1WW1yTVR3N0JPL0pQUjcweTNOM2F2N3RR?=
 =?utf-8?B?UGVjNFpHM0R3VUpVaVo4d1MvYVkxVzJaUlVHV3Y5TUh4WmpLdWNIbEQycHo5?=
 =?utf-8?B?VnVRMzMxY284cnhjR0wzSHpuVWZHN1lNemxlYjdXUklCVEQ3NXdpKzZ4U1pY?=
 =?utf-8?B?M0JJYzhMNnFqa3plNVJlRXdHWFpnSjZaS0VwMWpvdDRTbGI2Zm0rTDFWQTRq?=
 =?utf-8?B?T1RGMkRBdmJTM0VRWC94R0g3TS80d0FIcmxqanF5UTdWQkJiL0hmZEFpTG9F?=
 =?utf-8?B?bCs3cU00TGYxaXBVY0RvTVlwWS85dTRzUWg1MUg3TDlET3pVRHZMbDRTZnJr?=
 =?utf-8?B?SFVLSnlwclFvTWlHUENSTnJjVWttZWsrTStXZVBXUnhiUjIwYzg4aXdKckxa?=
 =?utf-8?B?dC9MNWU0Z3VsWnBqY3RSRzdsdVh2T3hnb1ZwbHlXbFFPUTlOSGFVZTcrTzFs?=
 =?utf-8?B?amNHS1ZNYXBUMXRqczdDL3hURFdjZGU5RmMzU0RkNmEzTktrTG9UZTJDQTM4?=
 =?utf-8?B?QWhQcEFGOUtwRHZ0eWh4eGtkR256c3NoQWtsSkZBcEgrNEVXaGN6d1kzQWhr?=
 =?utf-8?B?RmhYdVRiK2VrT0RrNHZ0OUx1eGNkSisvTkFKU0I5TStBUVZpZGlkS2Q2VkNY?=
 =?utf-8?B?SHFSems3SzFBSDlma3I5VncxWktBby8xQTRlTk5nWU5nd1RyWDhuVDErUVdJ?=
 =?utf-8?Q?EDx8y92Wb+lq7CMOIaYwLfFQBTXbqSzjcvGacPF6JF7DC?=
x-ms-exchange-antispam-messagedata-1: RdPmNL627hODEg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A80ED8B8FA3C3A4DBFE407713802B017@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdd3f9c-52ec-4424-be88-08da4d8e3b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 22:44:10.1054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U705WU2Y041pB0EgGwRyJGAbDZVF+Wccv9lcBj12YeqlhoOkuGgFhdGIuOIBFax6AA3UCEnjhZL98Z8+zittSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2510
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ICtzdGF0aWMgaW50IGlvY3RsX3NuYXBzaG90X3dhaXRfZXZlbnQodW5zaWduZWQgbG9uZyBh
cmcpDQo+ICt7DQo+ICsJaW50IHJldCA9IDA7DQo+ICsJc3RydWN0IGJsa19zbmFwX3NuYXBzaG90
X2V2ZW50ICprYXJnOw0KPiArCXN0cnVjdCBldmVudCAqZXZlbnQ7DQo+ICsNCj4gKwkvL3ByX2Rl
YnVnKCJXYWl0IGV2ZW50XG4iKTsNCg0KcGxlYXNlIGF2b2lkIGF2b3ZlIGNvbW1lbnQgc3R5bGUg
YW5kIHJlbW92ZSBkZWJ1ZyBzdGF0ZW1lbnRzLg0KDQo+ICsJa2FyZyA9IGt6YWxsb2Moc2l6ZW9m
KHN0cnVjdCBibGtfc25hcF9zbmFwc2hvdF9ldmVudCksIEdGUF9LRVJORUwpOw0KPiArCWlmICgh
a2FyZykNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQoNCi1jaw0KDQoNCg==
