Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA455B1094
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiIGXix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiIGXid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:38:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F4C6B7D;
        Wed,  7 Sep 2022 16:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662593879; x=1694129879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FufGjApHJMMw6uzRcEXfTXM8BuOLCj4PQB7MbrTmmtM=;
  b=mwGVdWFbwIQlnSTzE8H2sbDXEgbguRf0ImmC2AFNTuVIkr9q0oe1Ke9G
   L7yNMpssKV9Ppxq03i42rcz64jKIrCT+1HxpUo4j6lAWN7LARksmAQYP3
   WkOWeLTMEvFDaIDuldP24blD9ncqujr/UWbgIF87H7SKL9aLvfRuVMR1Z
   UQr5ItblaOIq02+JCkPxyWc0g1Tze4IFooJDjxLTbTVydhamVOJFOuwqn
   pPCHaM1MwSseRKp7551+ZCoxs8uJoe1pe1/3CktJVSN1yLah7JFCjiJ4q
   qyg7bIauji7TStglKNNEyBQpa+CfIF/WqXdd6uVQzwroQtnfp6rt4OvE6
   w==;
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="179608540"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 16:37:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 16:37:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 16:37:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHg6A/5bivceDpb/ZK4KeKZQqJIDsUX35LvVv5Ipt7S9mTG4LdKxR34eoDAebP2vESP/ry2lb9/BbcdvgYKJP4j0g6wnPxnMv3G3qlYN259GRDlbqghlfPZTkajCpmNaYGzUh7rKscQiYk3vhCil7iFjV0LZ9NbaIycQVZYOfHbJrUGTVxmRBPzBEpLI9SJpfCRC0KIK3Xz2MJEt3eXAkXD6H9+Fbh3bheddzi8q0Bss2XjB6dJxMp9OE+qX3d/E9wIIzhO2DbL8h/RujS+76h1ljTAkNR9liB2X1Cdva3dPfXg2kPD1ArzFpbXr/BUJj4OvKiHtCd0Dp7iZFUeN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FufGjApHJMMw6uzRcEXfTXM8BuOLCj4PQB7MbrTmmtM=;
 b=jt3O7yPxrYIlZiNqnxH7LoOItVz9o+nmb9jRg5XSBt8f1W+tq896PdpE461kzw17gMvBAb7G8ia38MO5U0Vo4kNJh8w88FaOCVSpRT+WK+e1o/8qsBFB5S+L+aGL79OKybkOkmSBPyviZLR9m+Ke6CeIe5nr3btJuU5xbgH3OcK6kQiroOMhaDRYTM3iDGLUXjCIcPZLqJNv0Pqjwdga5hhWcYapIXY2TZxF03Bm3PGvZIEReRlKXieiPatsl1tePRUQTrBmc5Gznyft929WBhDuPD/5vP/GoGhLQmUythlfIQOmRAfCoxpG/b+fAWNs1SAzqfrYIr8SYaBmj/D0zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FufGjApHJMMw6uzRcEXfTXM8BuOLCj4PQB7MbrTmmtM=;
 b=QmGYZZaLU7E1I+bAiaDuT7DwhRCQVtGeec7JyvvvqyGD3tjyUav76QTmQv1Ch/nLjgFp27JOn3CalLN/G8U0W3J2l2vWpn/+S09HdQ5TjiuffAhgWQm7SnkuUhu3COZoegV/5Cj5u8JxHrdY6b7IhDlhe+awU239ylp5EaR+bOU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY5PR11MB6415.namprd11.prod.outlook.com (2603:10b6:930:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 23:37:44 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 23:37:44 +0000
From:   <Conor.Dooley@microchip.com>
To:     <atishp@atishpatra.org>
CC:     <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <atishp@rivosinc.com>,
        <apatel@ventanamicro.com>, <geert+renesas@glider.be>,
        <linux-riscv@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <prabhakar.csengg@gmail.com>,
        <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Topic: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Index: AQHYwdqljaYH7D6050aAz/t+qDALqK3SNfiAgAJOpACAAB1VgA==
Date:   Wed, 7 Sep 2022 23:37:43 +0000
Message-ID: <f362eaeb-6ccd-4392-a346-55fa5ae25e13@microchip.com>
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com>
 <CAOnJCUKLpRz4Fbx1XiMnap-ELw2k1c8E9V8bZiSP+x7z9Z5QrA@mail.gmail.com>
In-Reply-To: <CAOnJCUKLpRz4Fbx1XiMnap-ELw2k1c8E9V8bZiSP+x7z9Z5QrA@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|CY5PR11MB6415:EE_
x-ms-office365-filtering-correlation-id: 8ea06e1d-8c10-4376-c2ac-08da9129f662
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: knjxQA+Xon24GSsFsub3nIWjtx+ZWVK9P35XQBUJEBMRAzWU/Bv9tQVZrCyXfTJPyIPbjm1WqK/f3DlHOnkkqRYwGrgwefBNr7N47yH872IcXpzf0aNFP4VVNuxtPbEca+0D5PpTmCrXTywRPUeXuBjvKj2R2AN5CLxZeUJ+tiG+8NC+prN6QBc/sR6d44p9V5R7xqaydPZ3TXEf+9T05k/h4MvzxW74hmdbxsM2HFjrsHL9jLV+sDYZGDeVP5DFkrvIBmaZdYpg3Ivyg9VekDo57kskMnOuUOqliBnwiq4AaErhYkI7a8HgtyJnR2t+3a+HLFatJpHsB3xHr9NtmadGIZ1FG6PmjJXwUgBczEG79WjykdYKC1nSWQTbkALkaMVW1DOzkuXBnAVeQQ93bdUUgAGuSnE1RpINtWiKFjTXL29+N046GIc9wtMxeIpUHbVaHFquC0TwW9dEqopa7f/a7s4tgu6m+0LXwaGF+ODLHoWzp+Q4FUjn1hIhCIPpX0wIvgKIZYDv2WK58KBCjQnwqg8uTV601ep6Q68zvP/m4zuSJnp43x3HciEMzqUmOhxTL1IImmQT4tMRZdLMWAcwcoC+0/1KvIByv7m8uz5AmM/Jn2QvYz5a+NkJ3KPmNSsDbAWx3bt5o71CvARBQvCt8f6+bn5kMYXf8Tq0bpgsG4QLDh6O47h9L9BD0jnzLzMnI32ephoNFPLHFOQprumbCFpDC4+gb/qOAuXAj3uTgbU0XjDSgZoZNLweYEzPRJsv+OyAA+OwdMi7NcL289aqPBfq/tm+L8GFjHw1cTUsxOzQr/+Ws2kOarmITWlaXkuK7CqMuWuPZT0Mz9RnMs/10xHDtlgszcqtZku8EfZ6VszsQjW2NyLFLH76cTsYBl6CeBBEYWo3f/Id9fpSzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(136003)(376002)(366004)(39860400002)(41300700001)(36756003)(54906003)(6916009)(71200400001)(31686004)(316002)(2906002)(38100700002)(83380400001)(38070700005)(6512007)(26005)(122000001)(31696002)(186003)(66946007)(66556008)(66476007)(76116006)(64756008)(8676002)(4326008)(53546011)(66446008)(91956017)(478600001)(6506007)(6486002)(86362001)(966005)(5660300002)(7416002)(8936002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEFxQ3dxYnVoQ243eXBLZEQvQ250T3FoS2d4TGthOTF0RTF4TlY3TlRudFgr?=
 =?utf-8?B?WE9QdWlUeUdhWUpkcllrZ2FWSmVqTVgwNSswZ2xVREVZTW8rZndDZXNNMVU4?=
 =?utf-8?B?Y3pmN0RHSk9zMjVGUkNPY05LY3JGNHRJZ05XWmxEU29kcHFQaDVmdlh4Rmhk?=
 =?utf-8?B?eHFLMG5tUTlLTG1Bb1kwTk1WUjZiNExxa2taZjlyMVEvRFJMTjkyRCtyNHpZ?=
 =?utf-8?B?bzUxaXBMcmprS3A5VU80VjRiOGs4S3YvcnBaZ2ExNGtFU0Q1NjlMc21ORmhk?=
 =?utf-8?B?MnlYb0daTFVqOHRWNmdxY21aZXFEb0U4TnhXbVJ1NlhKTVc3ald3d25UWExk?=
 =?utf-8?B?SVhBdC81SitZd3A1Y25rbWo0QVhqK0Q3dG1ZRHd6OG1VMmhad0N3V1FNZ21q?=
 =?utf-8?B?VnlhcHl5MEpYLzdaVFJtMXRWbkw3THpOM3N3Q1lWOS9RaVRvNmpwOFRqZXh2?=
 =?utf-8?B?MVVlbEh1VEFiMElEcllSSDFRSERya1RYRkl2VFZHNUswa3hSREhoWjBvUGYx?=
 =?utf-8?B?WU1VaXJYZm02eTZKUnI5Y0g1SXlWeGJWMUVsd0lOK2hjVTV0TGR6UHVNb2tP?=
 =?utf-8?B?ZjgrYUoyQlhrVFJ1bkc3c3R4OUdzRUpNanVYRGdNTW85RHBEWDAxWTZuTXBM?=
 =?utf-8?B?RlAxZnBocUFKRktsd1M5VTVzRmZwcUZieFNmVUYzam1QSmlSZUI5Qi9MOEov?=
 =?utf-8?B?VWk0cTFaUXJnQjhWZWRTbU92anNrdVdBaWtvZmNaRzVoOHBSZ1ZUWUVyb0lD?=
 =?utf-8?B?SWlxN3lhNGJHbDRyUDNwWTFxUTJzOEhFL1BSdFg5WEpjc0NpOWliU3BqTTVo?=
 =?utf-8?B?MGZ1b0lUc3k0Q3owSXlMQ0VBUFc2WHZrVjA4cFpyRmo4eTg0NXVvcXFuRGtN?=
 =?utf-8?B?MkxUWWFqdDBmRytTRExhcW1yUzhseldndERFRmM4QVR2K1BZRXJteWdhKzJ2?=
 =?utf-8?B?aUFUZnhQTFJRblJHRXhveG5UZ2FpbjBvWmtvY3VBZmVYL0Y2T3lER09GU1ZI?=
 =?utf-8?B?ZXVRY0k3T1BmL1YyZXZPbkxBK0ljMlRET1VPcUNTdWF0Y2Q5eHo5S0lYVDdK?=
 =?utf-8?B?QURhQVA5Q2hvRjZZL29QK3J6ZzM4RXYyRDhsaUJJSWo1d3ZDSGR6ZWxtMUNI?=
 =?utf-8?B?TlRFeDVyZUJyc1o1RitURitsdVdudGsvZnMxd1BNdzR4ZmpmMnMxekFweHRC?=
 =?utf-8?B?cUFnS2Q1NHQ4MGdGRVRWa2xjV3FuL0JFV2pONCtiRjU1ek0reVMxMSswanZx?=
 =?utf-8?B?eWhCWVRFSXZGS3BIdTloUHJpWjlCMGJtOGJGN1F4a2dvaVN5YzlYMUFPcmwr?=
 =?utf-8?B?SGE5S2czV0NOR2twMHMxRkRPUFJTbFNHRllBQUQzM294NGtGb2RMNU1hZElE?=
 =?utf-8?B?bFk5NlJOWFNvVnZFcWVoTlRHTlVYY0tDN2h0d09WYk10bTBleEhIdThPaFVk?=
 =?utf-8?B?ZDdSZHZVR2VtZnJBWDNTcFAxeHlmNWJQeDFYa1JmOXpocW1tdjRhak5sdkhW?=
 =?utf-8?B?WldLNVV2TTdFdGh2bXJlSmRLTVlPTU9NWUNTOG9LeGRPTVJUb2VPQlRCazhK?=
 =?utf-8?B?UVVLUmIway9kYkRmNXRrTHZhR2huRjdPMFVsbE4vYkhTSTdPSGtqTk1Nb2V2?=
 =?utf-8?B?MnVCTEZlZ2xEOGVtN2lXKzB4dllUWjZLSUh2dVFRdCs5STYxUWlSTEhDQVc3?=
 =?utf-8?B?c0IxNHY4WDlBU1NyQ01ZU1FvNWxyMnowRzQvUzdWd1I4dGUvY2c1RzJlVXgz?=
 =?utf-8?B?LzVJbStBWXBPMjhjb2FlTnVZaHRVWDdEeTBLVkMyc3lwTUlTN2VtWlQ2OG56?=
 =?utf-8?B?ZFgvQnJDSG1BVzVMNnpuTzB2MGpONVZ2YTR0MENSYk5sQkt4QmVRMnRoRzVm?=
 =?utf-8?B?RFkvUkQ2TmRReFlnbjQ5dWhoUGNFUWdtSmtEdm4rU2xMRW5mZ1l2S1NnT2pa?=
 =?utf-8?B?MUJBTjZnWUg5dG5kZ2VQWVRaNi9tNmZtMTRXVEQra0o5S243R1d3SDNqL0Vl?=
 =?utf-8?B?Rm5rVkNDQ2dEMHdtNm54YkRhTDJsVEJCWUYxTVBXSUYrU1JzM3ZUc1ZPc3I4?=
 =?utf-8?B?U0k2dTVoRXNYMWJxRktLZlc4Y29xS1dLTGhCdGhveUhITVE3aUxwcXcxWG1O?=
 =?utf-8?B?UHkxYXFuMEE5Wm9nWFI0NVZTSXZXeHdob3RRTWM3ampESEpFT09SYnlyNUox?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1743B09AEBBEE438BE3C77F05CBAF2E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea06e1d-8c10-4376-c2ac-08da9129f662
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 23:37:43.9545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SmdL1Ovk+qVi3XQOS6uhurIkS4Mc1tT/s39EwV08jE/kojxvoG0UElNcCqwHCSf6G3HiH2f7HMBa/uAUmw6c0l0ncja+CQpb6jnyI0C2pRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6415
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDkvMjAyMiAyMjo1MiwgQXRpc2ggUGF0cmEgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gDQo+IE9uIFR1ZSwgU2VwIDYsIDIwMjIgYXQg
Mzo0MCBBTSA8Q29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20NCj4gPG1haWx0bzpDb25vci5Eb29s
ZXlAbWljcm9jaGlwLmNvbT4+IHdyb3RlOg0KPiANCj4gT24gMDYvMDkvMjAyMiAxMToyMSwgTGFk
IFByYWJoYWthciB3cm90ZToNCj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRl
L2FzbS9zYmkuaA0KPj4gYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3NiaS5oIGluZGV4IDJhMGVm
NzM4Njk1ZS4uMTBhN2M4NTVkMTI1DQo+PiAxMDA2NDQgLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRl
L2FzbS9zYmkuaCArKysNCj4+IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zYmkuaCBAQCAtMzcs
NiArMzcsNyBAQCBlbnVtIHNiaV9leHRfaWQgew0KPj4gDQo+PiAvKiBWZW5kb3IgZXh0ZW5zaW9u
cyBtdXN0IGxpZSB3aXRoaW4gdGhpcyByYW5nZSAqLyANCj4+IFNCSV9FWFRfVkVORE9SX1NUQVJU
ID0gMHgwOTAwMDAwMCwgKyAgICAgICBTQklfRVhUX0FOREVTID0NCj4+IDB4MDkwMDAzMUUsIFNC
SV9FWFRfVkVORE9SX0VORCA9IDB4MDlGRkZGRkYsIH07DQo+IA0KPiBFdmVyeXRoaW5nIGVsc2Ug
YXNpZGUsIEkgYW0gdmVyeSBpbnRlcmVzdGVkIGluIHdoYXQncyBoYXBwZW5pbmcgaGVyZS4NCj4g
SSdsbCB0YWtlIGEgcHJvcGVyIGxvb2sgdGhyb3VnaCB0aGluZ3MgbGF0ZXIsIGJ1dCBmb3Igbm93
Og0KPiANCj4gRm9yIFBvbGFyRmlyZSBTb0Mgd2UgaGF2ZSBhbiBJbnRlckhhcnQgQ29tbXVuaWNh
dGlvbiBTQkkgRVhUIHRoYXQgDQo+IHdvdWxkIHdvdWxkIGxpa2UgdG8gdXBzdHJlYW0gc3VwcG9y
dCBmb3IuIFdlIGFyZSBub3QgYWltaW5nIHRvIHB1dCANCj4gdGhlIGRyaXZlciBpdHNlbGYgaW4g
YXJjaC9yaXNjdiAtIGl0J3MganVzdCBhIG1haWxib3ggZHJpdmVyLCBidXQgSQ0KPiB3b3VsZCBs
aWtlIHRvIHVzZSBzYmkuaCBmb3IgZGVmaW5pbmcgdGhlIHZlbmRvciBpZCBldGMuDQo+IA0KPiBJ
IGFtIG5vdCBzdXJlIGhvdyB0aGlzIGFsbCBhbGlnbnMgd2l0aDoNCj4+IFdl4oCZbGwgb25seSBh
Y2NlcHQgcGF0Y2hlcyBmb3IgbmV3IG1vZHVsZXMgb3IgZXh0ZW5zaW9ucyBpZiB0aGUgDQo+PiBz
cGVjaWZpY2F0aW9ucyBmb3IgdGhvc2UgbW9kdWxlcyBvciBleHRlbnNpb25zIGFyZSBsaXN0ZWQg
YXMgYmVpbmcgDQo+PiDigJxGcm96ZW7igJ0gb3Ig4oCcUmF0aWZpZWTigJ0gYnkgdGhlIFJJU0Mt
ViBGb3VuZGF0aW9uLiAoRGV2ZWxvcGVycyBtYXksDQo+PiBvZiBjb3Vyc2UsIG1haW50YWluIHRo
ZWlyIG93biBMaW51eCBrZXJuZWwgdHJlZXMgdGhhdCBjb250YWluIGNvZGUNCj4+IGZvciBhbnkg
ZHJhZnQgZXh0ZW5zaW9ucyB0aGF0IHRoZXkgd2lzaC4pDQo+PiANCj4+IEFkZGl0aW9uYWxseSwg
dGhlIFJJU0MtViBzcGVjaWZpY2F0aW9uIGFsbG93cyBpbXBsZW1lbnRvcnMgdG8NCj4+IGNyZWF0
ZSB0aGVpciBvd24gY3VzdG9tIGV4dGVuc2lvbnMuIFRoZXNlIGN1c3RvbSBleHRlbnNpb25zIGFy
ZW7igJl0DQo+PiByZXF1aXJlZCB0byBnbyB0aHJvdWdoIGFueSByZXZpZXcgb3IgcmF0aWZpY2F0
aW9uIHByb2Nlc3MgYnkgdGhlDQo+PiBSSVNDLVYgRm91bmRhdGlvbi4gVG8gYXZvaWQgdGhlIG1h
aW50ZW5hbmNlIGNvbXBsZXhpdHkgYW5kDQo+PiBwb3RlbnRpYWwgcGVyZm9ybWFuY2UgaW1wYWN0
IG9mIGFkZGluZyBrZXJuZWwgY29kZSBmb3INCj4+IGltcGxlbWVudG9yLXNwZWNpZmljIFJJU0Mt
ViBleHRlbnNpb25zLCB3ZeKAmWxsIG9ubHkgdG8gYWNjZXB0DQo+PiBwYXRjaGVzIGZvciBleHRl
bnNpb25zIHRoYXQgaGF2ZSBiZWVuIG9mZmljaWFsbHkgZnJvemVuIG9yIHJhdGlmaWVkDQo+PiBi
eSB0aGUgUklTQy1WIEZvdW5kYXRpb24uIChJbXBsZW1lbnRvcnMsIG1heSwgb2YgY291cnNlLCBt
YWludGFpbg0KPj4gdGhlaXIgb3duIExpbnV4IGtlcm5lbCB0cmVlcyBjb250YWluaW5nIGNvZGUg
Zm9yIGFueSBjdXN0b20NCj4+IGV4dGVuc2lvbnMgdGhhdCB0aGV5IHdpc2guKQ0KPiANCj4gV2hp
Y2ggaXMgaW46IGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Jpc2N2L3BhdGNoLWFjY2VwdGFuY2Uu
aHRtbA0KPiA8aHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcmlzY3YvcGF0Y2gtYWNjZXB0YW5jZS5o
dG1sPg0KPiANCj4gSXQgaXMgdW5jbGVhciB0byBtZSB3aGV0aGVyIHRoYXQgaXMganVzdCBmb3Ig
SVNBIGV4dGVuc2lvbnMgb3IgaWYNCj4gdGhhdCBjb3ZlcnMgU0JJIGV4dGVuc2lvbnMgdG9vLiBB
dCBsZWFzdCBmb3IgdXMsIHNpbmNlIHdlIGRvbid0IHRvdWNoDQo+IGFyY2ggY29kZSB0aGVyZSBp
cyByZWxhdGl2ZWx5IGxpdHRsZSBmcmljdGlvbiAmIHRoZXJlJ3Mgbm8gY29uY2VybnMNCj4gYWJv
dXQgcmVkdWNpbmcgdGhlIHBvcnRhYmlsaXR5IG9mIGEga2VybmVsIHNpbmNlIGl0IGlzIGp1c3Qg
YSByZWd1bGFyDQo+IG9sZCBkcml2ZXIuDQo+IA0KPiANCj4gSXQgY292ZXJzIHRoZSBzdGFuZGFy
ZCBTQkkgZXh0ZW5zaW9ucyBhcyB3ZWxsLiBIb3dldmVyLCBJIGRvbid0IHRoaW5rDQo+IHRoaXMg
aW5jbHVkZXMgYSB2ZW5kb3IgZXh0ZW5zaW9uIGFzIHRoZXJlIGlzIG5vIGZyZWV6ZSBvcg0KPiBy
YXRpZmljYXRpb24gYXNzb2NpYXRlZCB3aXRoIHZlbmRvciBleHRlbnNpb25zLg0KPiANCj4gSXQg
d291bGQgYmUgZ29vZCB0byBkaXNjdXNzIHRoZSBwb2xpY3kgYXJvdW5kIHZlbmRvciBTQkkgZXh0
ZW5zaW9ucw0KPiBkdXJpbmcgTFBDIGFzIHdlbGwuIFdlIGFsc28gbmVlZCB0byBkaXNjdXNzIHRo
ZSBBQ1BJIHBvbGljeSBhcyB3ZWxsLg0KPiBXZSBtb3N0IGxpa2VseSBuZWVkIGEgQm9GIHRvIGRp
c2N1c3MgdGhlc2UgYWRob2MgdG9waWNzLiBJIHdpbGwgY2hlY2sNCj4gaWYgd2UgY2FuIHNjaGVk
dWxlIGEgQm9GIGluIGFkdmFuY2UuDQoNCkkgZGlkIGJyaWVmbHkgbWVudGlvbiB0aGlzIHRvIFBh
bG1lciBvbiBJUkMgbGFzdCBuaWdodCwganVzdCB3YXMgYnVzeQ0KdG9kYXkgJiBkaWRuJ3QgZ2V0
IGEgY2hhbmNlIHRvIHJlcGx5IGhlcmUuIFRoZSBpbmRpY2F0aW9uIHRoZXJlIHdhcw0KdGhhdCB5
ZXMsIHRoaXMgcGFyYWdyYXBoIGRpZCBjb3ZlciBTQkkgZXh0ZW5zaW9ucyAtIHdoaWNoIHdvdWxk
IG1ha2UNCnZlbmRvciBleHRlbnNpb25zIG5vdCBwZXJtaXR0ZWQgdXBzdHJlYW0uIA0KDQpXZSAo
bWljcm9jaGlwKSBhcmUgIm9ubHkiIGRvaW5nIGEgZmV3IGVjYWxscyBpbiBhIGRyaXZlciBidXQg
dGhpcw0Kc2VlbXMgYSBmYWlyIGJpdCBtb3JlIGludHJ1c2l2ZSBzaW5jZSBpdCBpcyBpbiBhcmNo
IGNvZGUuIEV2ZW4gaWYgdGhlDQphbnN3ZXIgaXMgYSAibm8iIC0gYSBubyBmcm9tIHRoZSBob3Jz
ZXMgbW91dGggcmF0aGVyIHRoYW4gb24gSVJDICYNCm1heWJlIHNvbWUgcmV3b3JkaW5nIG9mIHRo
YXQgZG9jIHRvIGJlIGNsZWFyZXIgd291bGQgYmUgbmljZS4NCg0KSSdkIGJlIGRvd24gZm9yIGEg
Qm9GLCBldmVuIGlmIGp1c3QgdG8gZ2V0IGEgIm5vIiBpbiBwZXJzb24gaGFoYQ0KDQpDb25vci4N
Cg0KPiANCj4gSSB3YXMgcGxhbm5pbmcgb24gY29ybmVyaW5nIHNvbWUgcGVvcGxlICpjb3VnaCog
UGFsbWVyICpjb3VnaCogYXQgTFBDDQo+IGFuZCBhc2tpbmcgaGltIHdoYXQgaGlzIHRob3VnaHRz
IHdlcmUgdGhlcmUuDQo+IA0KPiBGV0lXIHRoaXMgaXMgd2hhdCB3ZSBoYXZlIGJlZW4gZG9pbmc6
IA0KPiBodHRwczovL2dpdGh1Yi5jb20vbGludXg0bWljcm9jaGlwL2xpbnV4L2Jsb2IvbGludXgt
NS4xNS1tY2hwL2RyaXZlcnMvbWFpbGJveC9tYWlsYm94LW1pdi1paGMuYyNMMjcNCj4gPGh0dHBz
Oi8vZ2l0aHViLmNvbS9saW51eDRtaWNyb2NoaXAvbGludXgvYmxvYi9saW51eC01LjE1LW1jaHAv
ZHJpdmVycy9tYWlsYm94L21haWxib3gtbWl2LWloYy5jI0wyNz4NCj4NCj4gIFRoZSBJUCBpdHNl
bGYgaGFzIG5vdCBzdGFiaWxpc2VkIHlldCwgc28gd2UgaGF2ZSBub3Qgc2VudCBhbnkNCj4gcGF0
Y2hlcyB5ZXQsIGJ1dCB3ZSBkbyBpbnRlbmQgZG9pbmcgc28uLi4NCj4gDQo+IEJ1dCB5ZWEsIEkn
bGwgdGFrZSBhIHByb3Blcmx5IGxvb2sgYXQgd2hhdCB5b3UncmUgZG9pbmcgaGVyZSBzb29uVE0s
IA0KPiBhbHRob3VnaCBhdCB0aGlzIHBvaW50IGl0IG1heSBiZSB0aGUgb3RoZXIgc2lkZSBvZiBM
UEMuDQo+IA0KPiBidHcsIHdoZXJlIGNhbiBJIGdldCBteSBoYW5kcyBvbiB5b3VyIGhhcmR3YXJl
Pw0KPiANCj4gVGhhbmtzLCBDb25vci4NCj4gDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXyBsaW51eC1yaXNjdiBtYWlsaW5nDQo+IGxpc3QgbGlu
dXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA8bWFpbHRvOmxpbnV4LXJpc2N2QGxpc3Rz
LmluZnJhZGVhZC5vcmc+IA0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXJpc2N2DQo+IDxodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LXJpc2N2Pg0KPiANCj4gDQo+IA0KPiAtLSBSZWdhcmRzLCBBdGlzaA0K
DQo=
