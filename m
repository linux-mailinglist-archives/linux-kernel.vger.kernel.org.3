Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49308591217
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbiHLOUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiHLOUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:20:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE2891D2F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660314011; x=1691850011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mSSHtUeVM+A4C8f4M1t1LHXxuMVjfYh8bn5ikOhx3jg=;
  b=hjZ9dj5qrgerJK7DRHasuUnhkwPn6V2CBXkIAqT4DkQ125K3h6+a1dgY
   NnosHHQw0zXL31iRCq5R+21RjguB75rHkAgOL/IAtBOxaJci9Hr7qzJEb
   0MRV9eXljV5YeMgJjEbB8oUDK9IsmBx7b6TIvIRyxIGIL6cT3M6gI0If5
   +1eiEk0rxW0PCdp6s0jsdsN7CXGo7zpeZFIk9tt7wvLwcbG1aUs71PEPO
   ts9LZWP3YJR4RLfZX/z/Sf8DYpxIkax4eVyZA6mePsD22FKjjcSwgz7Mw
   GBeJt7ZMjLO1XSKw2dk7EUUXEJ+fXvUPyGVA5M3y/5wMmeMfVFZ+qtcoq
   g==;
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="169043945"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2022 07:20:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 07:20:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 12 Aug 2022 07:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0gxg7lHXyJDVIx5f9+0Fdg6Okg+5IwTwfst1lH7IjnNFLO88F9bq5OgV6gYauJVeWrqNjkwwY5EWvWWBfuHHCrvZMUaDRuwSeJf+ns8CrgFbkWvQcaN/vFifBsxXDpjQAhI+XxyDAoZ3d+GZ0VmkgLz/xbvyAsugd0HsfvTsHO/CDuhV+6NEOu6oHwKcjXaBJ4b1s1vDv2vY0JmTXk6R71CPlyusGBIibWV3l0vt3f5hXYVy2FncAIGi+kVLT2w5Oj4csYNsEJhIC89tMYYNjHBtiQ8NzV4RPSfR4V6gGuZKr/VUQwYjTjXA4av+dB7D5XhDczKC1JbGX4LcWZsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSSHtUeVM+A4C8f4M1t1LHXxuMVjfYh8bn5ikOhx3jg=;
 b=ZtMZmbCTV87gEflX1lt6VU2m0qpMcFmYzTxmf0dVSFNxnsSBTOCot4dEiKkXvqfIU1ajowlPtltcxwXv0xb0U+kW5KqjGBlQSh0/vI544NrnCSkGxvybweROYFTWy9Umsg/ByiFauCGSgmbouAwNWr4n0HQzoC0I+Pkq0+Kdc4N58jLvlB26ZFgTizO/yE0jIkSeakfkg4e3UKk5MBiD4mQkvCRSCGwsA3he+MjQ5L2Stc6vmSVtjoSlqYUgLcmit7UD1hd1dLmsJM/kredVHBFMaFURrGHWFdmh/PvYbj9N/jaBm6VZTNfvgmjdUPpu6+ScHdkpKlP3kHv4stBCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSSHtUeVM+A4C8f4M1t1LHXxuMVjfYh8bn5ikOhx3jg=;
 b=CWyAOKnR/xiNjH1nDdwGKEY+Q6FdYNKG2B/4vm5RH35+N7PKZUSL8t2n7DZtPjDA4LwtSqI2detlIBut/Qu/3YVFFp9kQI7jHZRU5W87im7FCniwosLdQbi2cW/eeY0lN+tDmQifuO1JqKql0X20KIylBcI5/KWfN6MqdIuGxGk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1706.namprd11.prod.outlook.com (2603:10b6:3:b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Fri, 12 Aug 2022 14:19:54 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 14:19:54 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jrtc27@jrtc27.com>
CC:     <palmer@dabbelt.com>, <palmer@rivosinc.com>,
        <atishp@atishpatra.org>, <anup@brainfault.org>, <will@kernel.org>,
        <mark.rutland@arm.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf: riscv: fix broken build due to struct redefinition
Thread-Topic: [PATCH] perf: riscv: fix broken build due to struct redefinition
Thread-Index: AQHYrlLLJJmuNPzJiU+k51rJJC8n162rTtwAgAABmgA=
Date:   Fri, 12 Aug 2022 14:19:54 +0000
Message-ID: <84e4739c-0197-f9d9-5529-24f6037c85fa@microchip.com>
References: <20220812135119.1648940-1-conor.dooley@microchip.com>
 <2055040C-D443-47FD-B6E2-C4C6B3E600B4@jrtc27.com>
In-Reply-To: <2055040C-D443-47FD-B6E2-C4C6B3E600B4@jrtc27.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bd406d0-de11-4fda-93db-08da7c6dba12
x-ms-traffictypediagnostic: DM5PR11MB1706:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /m41IsnzLhfvGGBALFf7bY95pxHzB515+r5l6khfHURiMGEAjI/D5XNe02QQeUHsKPxHNqZPf/p+xonqMH8FIe83i0hNYON8xEqIHAAeDm9vDTEylOdBPQwSPTQGOcq1cdKwxfympJjuOIR6rTH6SrkmumEjD4PHZWYWohnsQvgyfYF4XrLS6nuvkPmYI6chP+Y9/lOahabhqCyQvl4lIZVWHSy8OAEVMYNjJc30EqDdHVDJpjVk4gujaKEJlGx2BalBrj3JC9tTmaF2Yl0fua+0q5LnDBhWc86cdPiZhk2SZF5mRTGnI9HLDJ8OLXNvMSiUXUesFLv52QRTvEThInIjqgRH0VHvUWHqjvq/356eXUsw2a00Ar7r/cEup99vk4zN1ec6GjcUq5eYvIMi7IqsNL/0mtQIB4T3VVICJxnUxiFhWl4D2GrRz6iBkAV6WL3WpuEoxsNPg6HGnCIiiKOvWoA13w0dyhfp7kFkB1UWViWVYflm07DFTbErphjZ7es1po76ZH8pwexkawjkJtaB8NdivP9V1FwoSJ0PvAgD5molL1bu/p3Bp+YPeu+3Knz/9XgJFBiwP2I2t5anH3vEQhyHrQCXqgjOgZisTSTuENUsC74xtIp+fjNNDnsmSUQUv0Sg4sJeZLG5Ut4qOFMhabNN0YyoyPLYFXDbzEM9AJ5hoQfwRZnB6B7B3O1SJGO4Gxvk6Mx/0Gitr9rH75kLQwnLCEnoo/m0PWAIl8DuLQJZt7JT1jzhoXNRKyMUlEaIxVr2gNDsPJ9bWg32wyOIhZel78T8o0Hg++O4lHfyqC3eMXLoobGbRhAYNyClqy0DFPwBx/E/SYPB1jQeIvmNYqkJh6a1BR6pUhKlM268IA1LA8W3py9rPBxpMaIyLpLGWba8O/QV7kqU3y7cHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(376002)(136003)(366004)(186003)(8676002)(2616005)(64756008)(5660300002)(26005)(71200400001)(31686004)(36756003)(41300700001)(53546011)(83380400001)(478600001)(6512007)(6506007)(6486002)(966005)(38070700005)(122000001)(31696002)(86362001)(76116006)(316002)(6916009)(2906002)(66946007)(66476007)(4326008)(54906003)(91956017)(66556008)(7416002)(66446008)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3AyNklFN2pQajNIbjdwUUN6aFF4b0dqTGRJNld4UEl4YnZHRFNWZm5Ua0U5?=
 =?utf-8?B?eHJQNU41d1ZYNHhraXBMZ2QvaDFVRUNpSGNoQXc5dlBhRVVpUjBhZHJPU2hs?=
 =?utf-8?B?OEZIdjlYMVJ5R3l5NHZCcjlqTTdBZEFjZ3YwTXI5c2JJUk5nQm1HQkIvWmtK?=
 =?utf-8?B?RnFSR1JTdEVJRzIybHZrYzd2ckM0OXVWNU9lQis5TnlDTTc1dEVJN0ZKUGt0?=
 =?utf-8?B?eUZmbjgvczJhSWNyVm1jOHJmU0xobXVSWk5oZUtwK01ZTlU2RWlLK0t6UWRP?=
 =?utf-8?B?TFJVZGVvdzFsZUwzU1JVbldPU0Y0MXVwZGd4eUZSZWRlcy9WVmNlQ2I0WE8r?=
 =?utf-8?B?ZHoyUjVTWFhnYWplbWVaK0pmbkU4QXZZdXo1YzFWM1RKR1RnY25GSlQvRFVV?=
 =?utf-8?B?UUZWamhEVGg5NktodWR4MFBUQ29ENUZVYm5iVzAwdzZhNzJNb2QvTjVxczhu?=
 =?utf-8?B?M3o2Z1Q3K2VTaG1EY2RXWTRvLzMwTmxBaExMci8yZTMwMXBTRjB0ZnF5N0VL?=
 =?utf-8?B?bCsvWXFlMlFhdmx1UjFKM2RMSVZJeHU5WFJtbWlQSmUwTitGbm5sQU5BTFpw?=
 =?utf-8?B?NVIzNFFzZ0FCcVplWEJIbksyWjhZbUcyVU5OWko1TzJvdDNJbDhKa295eFBY?=
 =?utf-8?B?TENyTVhrQXY5YjZPRmxiMmpBcVNmU2hXZXdHQlFMWkkwWmxtZUxVV1Q5VzlI?=
 =?utf-8?B?NTJGY1E5Um5uU0hUc2d6eXQySDNicFVTdkh1OVdnTWFmUGp0dllFd2FaRW10?=
 =?utf-8?B?eGdxOWhaSzBxY0IvNFlnMWJlck05dDY5eHAxOEpCSDNUT0tFL0ZKV3I3a3pZ?=
 =?utf-8?B?MkFNYk9WTGpscnQvTTU2elNuMjA5QnZvL1JiTUtQeG5jYVVNVTROb29yU2NL?=
 =?utf-8?B?RVR6aTR5cGQ5T3RWbGQwRWpCWEg1cW82V1hQWW81dFdMZ1RVeUZDeEVtU3B1?=
 =?utf-8?B?MzdsY3FXT3ZmUDZsK28ydDlxQk9BRVVRVkYyT1JPWW1yeVE1c1Q4Mm5YMHh2?=
 =?utf-8?B?SHNIeDJoNHFNMFR4RXFCUDQ3cTdlVVB4TERPb1M3ZmFrd2hwOTVwMUI0VjBS?=
 =?utf-8?B?WVZzS2FDNmRTajhSUml0NUtvVzlXRUFsZDd6bGQ3M2s0R2dlRHN2RlJtRW5q?=
 =?utf-8?B?R3dpQlhkeXp4d0VLek1TSDY1MTJsSzhXWDJodE5yNFpINmtnNzVDNkx1WHZv?=
 =?utf-8?B?aWZjeDdWWHlVdlBWbDIyTytHUXZBZDlwTzVtRCt6aFlvWHo5OFZuSXYxWWIw?=
 =?utf-8?B?cnRCd2EvbFhYVDNHaVowT0RsRGFaRGtOQlNxaHpmNEJiUlBwTlBXcnRWWkNR?=
 =?utf-8?B?VDJDZG5zLzVvQTFWZmNSaTFUZjBCWlRrTnYxSVpMOU9leklMNVc4YTY5RFBX?=
 =?utf-8?B?U09pZ050Vm82Z2tEQ3Voa3Z4bk1pQlJIOFhNb1BaTTdrSE5KUUI3L1g3TU81?=
 =?utf-8?B?Qm8xcDA2UlBNaXgrcFI1MDdaVVlXZTNtb3A0ZWdzTDNUSDgrSGhFMDE5SDF0?=
 =?utf-8?B?ZFgrMFRtMm5XbW8vbjk0R1J6bHBYNDBhMEFwYS9TME9iekZIdVNsTUljc0hJ?=
 =?utf-8?B?M09QM05WQmtxTkNhQmVGZkF0Y1IzanVYd3NJUExoNjAvQUlzUVpxMnAvM1Iv?=
 =?utf-8?B?L0JqcWh3SWRrN3JDQWhPYWZLRk1MUlJXbjJubnBMb2FyUS94QUR0cHNDRThY?=
 =?utf-8?B?ekhBdVhKMml5d1BDaUo0KzJGVmpjeWxvaVBMRk9YaXdhcjYxeGozUCtheEVI?=
 =?utf-8?B?Vzk4QU91QXhPVDJBMzF1cjR5T0FscXVSMXlVQ01KbkYxNkNybDYwMEZtVkVk?=
 =?utf-8?B?d3pkZTYzbTFCWlVsOTBOa1F5UHFDSGM2cDZUU0tzOUkveVMwMm51TU1JbGp5?=
 =?utf-8?B?RTJFNFVmSURicFRjNVR0RXowVzY4aHBkQmtOS04xYzhKdnplVWJZS2krUkhL?=
 =?utf-8?B?OEY4cjV5VERrMTJiYTE5YUJ4dm0ybE9vN25aV2c0TWxvdEd6dDAxRldQYUUz?=
 =?utf-8?B?UFhoQlFFUUlld3R4M0ZPeWR1dXIySkQ2aFA3bmZTUEZyTTkzQ1h6SHphOWxk?=
 =?utf-8?B?clFhbjVWL2U3ZkhZUkRzQXBmOTIrSnpYdDR1MVF0OG14Wnc3QUhDOFhYWkt5?=
 =?utf-8?Q?jH7ScN/yyiBg0AF3bUXBAcR/o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE306BA35A2554469981DD0DD1660A3B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd406d0-de11-4fda-93db-08da7c6dba12
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 14:19:54.0936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: By1k4vycwj78Y4eU8Ej4EMXDsq9bCFj7fUtSATXyLqHeedjlooZ7nPrpbG4yQzUiCptXwICvq4MwQnYzANo6+Y0sdwuEnUP+pJ1tkAhCobE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1706
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMDgvMjAyMiAxNToxMywgSmVzc2ljYSBDbGFya2Ugd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMTIgQXVnIDIwMjIsIGF0IDE0OjUxLCBD
b25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+DQo+PiBC
dWlsZGluZyByaXNjdi9mb3ItbmV4dCBwcm9kdWNlcyBmb2xsb3dpbmcgZXJyb3I6DQo+PiBkcml2
ZXJzL3BlcmYvcmlzY3ZfcG11X3NiaS5jOjQ0Ojc6IGVycm9yOiByZWRlZmluaXRpb24gb2YgJ3Ni
aV9wbXVfY3RyX2luZm8nDQo+PiB1bmlvbiBzYmlfcG11X2N0cl9pbmZvIHsNCj4+ICAgICAgIF4N
Cj4+IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vc2JpLmg6MTI1Ojc6IG5vdGU6IHByZXZpb3VzIGRl
ZmluaXRpb24gaXMgaGVyZQ0KPj4gdW5pb24gc2JpX3BtdV9jdHJfaW5mbyB7DQo+Pg0KPj4gVGhp
cyBhcHBlYXJzIHRvIGhhdmUgYmVlbiBjYXVzZWQgYnkgYSBtZXJnZSBjb25mbGljdCByZXNvbHV0
aW9uIGJldHdlZW4NCj4+IHJpc2N2L2Zvci1uZXh0ICYgcmlzY3YvZml4ZXMsIGNhdXNpbmcgdGhl
IHN0cnVjdCBkZWZpbmUgbm90IGJlaW5nDQo+IA0KPiB1bmlvbiwgbm90IHN0cnVjdA0KDQphdXRv
cGlsb3QsIHRoYW5rcyA6KQ0KDQo+IA0KPiBKZXNzDQo+IA0KPj4gcHJvcGVybHkgbW92ZWQgdG8g
aXRzIGhlYWRlci4NCj4+DQo+PiBGaXhlczogOWE3Y2NhYzYzZjljICgicGVyZjogcmlzY3ZfcG11
eyxfc2JpfTogTWlzY2FsbGVub3VzIGltcHJvdmVtZW50ICYgZml4ZXMiKQ0KPj4gU2lnbmVkLW9m
Zi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0K
Pj4gZHJpdmVycy9wZXJmL3Jpc2N2X3BtdV9zYmkuYyB8IDE0IC0tLS0tLS0tLS0tLS0tDQo+PiAx
IGZpbGUgY2hhbmdlZCwgMTQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGVyZi9yaXNjdl9wbXVfc2JpLmMgYi9kcml2ZXJzL3BlcmYvcmlzY3ZfcG11X3NiaS5jDQo+
PiBpbmRleCBlN2M2ZmVjYmYwNjEuLjZmNjY4MWJiZmQzNiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvcGVyZi9yaXNjdl9wbXVfc2JpLmMNCj4+ICsrKyBiL2RyaXZlcnMvcGVyZi9yaXNjdl9wbXVf
c2JpLmMNCj4+IEBAIC00MSwyMCArNDEsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0
ZV9ncm91cCAqcmlzY3ZfcG11X2F0dHJfZ3JvdXBzW10gPSB7DQo+PiAgICAgICAgTlVMTCwNCj4+
IH07DQo+Pg0KPj4gLXVuaW9uIHNiaV9wbXVfY3RyX2luZm8gew0KPj4gLSAgICAgdW5zaWduZWQg
bG9uZyB2YWx1ZTsNCj4+IC0gICAgIHN0cnVjdCB7DQo+PiAtICAgICAgICAgICAgIHVuc2lnbmVk
IGxvbmcgY3NyOjEyOw0KPj4gLSAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIHdpZHRoOjY7DQo+
PiAtI2lmIF9fcmlzY3ZfeGxlbiA9PSAzMg0KPj4gLSAgICAgICAgICAgICB1bnNpZ25lZCBsb25n
IHJlc2VydmVkOjEzOw0KPj4gLSNlbHNlDQo+PiAtICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcg
cmVzZXJ2ZWQ6NDU7DQo+PiAtI2VuZGlmDQo+PiAtICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcg
dHlwZToxOw0KPj4gLSAgICAgfTsNCj4+IC19Ow0KPj4gLQ0KPj4gLyoNCj4+ICAgKiBSSVNDLVYg
ZG9lc24ndCBoYXZlIGhldGVyZ2Vub3VzIGhhcnRzIHlldC4gVGhpcyBuZWVkIHRvIGJlIHBhcnQg
b2YNCj4+ICAgKiBwZXJfY3B1IGluIGNhc2Ugb2YgaGFydHMgd2l0aCBkaWZmZXJlbnQgcG11IGNv
dW50ZXJzDQo+PiAtLQ0KPj4gMi4zNi4xDQo+Pg0KPj4NCj4+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+PiBsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QN
Cj4+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+IGh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCj4gDQoNCg==
