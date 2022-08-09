Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C0358E1A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiHIVPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiHIVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:14:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C394861B33;
        Tue,  9 Aug 2022 14:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660079671; x=1691615671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p9Ns8s2ei4gxTKVXej88jiPDsoiU1g8FsiSNuI4ozy4=;
  b=OuMb2qLvTLJ0ks45uIei1lhkrBDVVwxbdJAciSMjURruKMl+IR1yZeY6
   TeU01/UjT3dDbpQthalLhzJ28MK6EpslSrkgTAKdwZhlb/jmy0ZOfBvHD
   fFnodZUVN++7rzKGF3N2yAEnliMbsPxnA0w3eG7MK4tkOXFcOY4oJ/muN
   +kLYJ+AdXm+n78DcpotSyxMDlL1TpqVAl3XENNGDNfVGMR+/pISqX+gOZ
   AibCYQsPbQtPUwGhyg3PlKhdUkat1hmAjJeQAIgkcw04VvJFrxicNKKJk
   IgA6Z6JPssNIu7zlrUl00CwW1qoA0upHMM70pTZ2XP6qOPFH8nb77ubNu
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="175595388"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 14:14:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 14:14:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 14:14:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqlkOlaL+BCFkOe9DomumrbZWyXLaw0t6HFe5Alp8pzu/CLdnR6eAPu4cAotRmsAFunsgLOcqQM/CCjyUQVslL4zveXb8DJklutamhIozIA/1njEV99cMq4r5PC1M+EbbH5IrhDxTD+498oKK7s+v4yEm7OXRgy+AIRx4Uq414vGuqCJ20cWUAZZSsJS9ws14CcD57V0WPkhZ2kFsNKXSsAe9Qt4ThohA24WXa7Zm+KtbEc8EhMzPfhnuN6VZ0kHkKEQrYdxbG/Eq/XXkE9nR5G+SJ0/0w/8BT3uCvsNrhEJI+mK43JPk8ncMrzkhdmGvmooqOOBLC4+BsoL/VaEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9Ns8s2ei4gxTKVXej88jiPDsoiU1g8FsiSNuI4ozy4=;
 b=ERLCV74fuj9/Oyg8V6Sc4gpjmMM8jtcP5gouPNQI29KCTSotIWm8tx9y8ukKATdgtFE1Fb28ZNYAdULKKz/P6fhO6oOlqr3N867FQIhdiG9lG0/szCWqRFryCZVFqHeTpQ69gw5Dn+1ePZm0KBdqI+Dc9viGUUVHFh0FpCxy31mCxeWvgitUQ4oj5fTV07fDL7Be/HJTMYsxQcoXSJ+FQ1rQW3nm+lIi+lm7F1GTkCwnJon3vkKTiBCmB/dquIAe5rWx6ocABCXDdwBHFIKBC6OBhvZeWneB95WK7HCAS5vCDaHOo2ActvelYIEMb5pkx/sKwBvqaRjhPu66E+PXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9Ns8s2ei4gxTKVXej88jiPDsoiU1g8FsiSNuI4ozy4=;
 b=JZe/LOs8UPwEY5acAzMAm38gAbdTMMTjBKR0DLMqkA3P+rnmgQhNPnWxyzctKfq1vopa6CX686WiB1OW4rBV9Eet1ytWGX6gYe9irE1g7PRhPKpo7G8RKCYmQzzmVXLyLuA/J7K18MyGK6lJga1Sqw6gqVyDSi0ZzcwxgJlQA8k=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 21:14:25 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 21:14:25 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Conor.Dooley@microchip.com>, <xianting.tian@linux.alibaba.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <anup@brainfault.org>, <heiko@sntech.de>,
        <guoren@kernel.org>, <mick@ics.forth.gr>,
        <alexandre.ghiti@canonical.com>, <bhe@redhat.com>,
        <vgoyal@redhat.com>, <dyoung@redhat.com>, <corbet@lwn.net>
CC:     <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <crash-utility@redhat.com>, <huanyi.xj@alibaba-inc.com>,
        <heinrich.schuchardt@canonical.com>, <k-hagio-ab@nec.com>,
        <hschauhan@nulltrace.org>, <yixun.lan@gmail.com>
Subject: Re: [PATCH V5 4/6] RISC-V: Fixup getting correct current pc
Thread-Topic: [PATCH V5 4/6] RISC-V: Fixup getting correct current pc
Thread-Index: AQHYpmoWKDGeRD7OZEqsYpbx58+Qu62nHMwAgAAAYIA=
Date:   Tue, 9 Aug 2022 21:14:25 +0000
Message-ID: <0e01c36a-bf06-6065-daee-b0cc78c79e4f@microchip.com>
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-5-xianting.tian@linux.alibaba.com>
 <3fbfaa49-8ee9-a65c-133b-d0f072f0eb6c@microchip.com>
In-Reply-To: <3fbfaa49-8ee9-a65c-133b-d0f072f0eb6c@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: def29dd8-ec2d-4699-b27a-08da7a4c235b
x-ms-traffictypediagnostic: DM4PR11MB5262:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TPbxNA+hzcZ1iSPWNZX56THekK9xLVg++yL14qAeusamLe0z7WR0/U4f+PLBAsC0kdr0T5M1mMRbqA3NWL5IpEgzlrLDxmUbHlelFhArWs+Umlof7i2xxne21dHAQxsby2oNojz9WGCIl1pTsFp6S7hW+UQqF+Z/K/Rwh+DNhsRY/qidXL9iYjbXIqpRT4tenMOktAmkK4HYF01yn0wjpIDStD8ZcPR3XlZVW+qKiclqer7/pot/c6oSG5LqGNiztqiHv8Qj86UxT2aWcnoGOvQNuiU06K27d6ZEfbReki0W55chAaaBpPBTpUqbHmVap0baQry5V3+RhVkxI8ruTzbzSpTuKlUhJW6QzsoL1E88e0EXKmNJbZCqa04sqmcEzKDb72mumLJ8gFYlABVugi/bkt/vPW9jmOLQEIHjhuo9O9yTsV+i6FsowzMIXxcAFcrc8lflZeg/V9eFpi+7WlnKQWZKM7hfadihaLlMbCizOdYrHK6pWdWhn3KTb0gPgr0gTGn5+Hoc9ijqmErJfKczzGTwlmx++sU2O7lmfHj1Z9CJdFtK7opc+nPUXJPonwp9Lk9twVSF/aTNU+QLfKFrv+oCZ5tcmnHU0Zv9jPnhBiA5TtG03pP6GhzExj28n/QH1Qb5elhOEOKbemzlmMXtRxt+H+DfXkyG6Bce9Km89BocZSshzsmFJCmv07I9oR3zifNsUylRwKJsiBbRX/0EieoA3Onl++3Ki/ZEMRpTLDS/4kbJzbbiFoWWQ3vAsYLGwV7CbyWsGXoO2b9k1qN36hY5+nc9gekA9+sjJheB38QjG2kWb61rUS3Zk4M1zrpbtcTA/quHV28a3P2YiP7S4mt+mWy2SbQAMTSPer9GzTaTdqahzVwmeCsju7rR2LnkktPRgoS1xVQHU5wUonKGKCx4olK6YBCnue8XiTLhBUZEVM74v5P/9whd2BO1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(376002)(396003)(136003)(41300700001)(26005)(921005)(2906002)(53546011)(6512007)(2616005)(38070700005)(38100700002)(122000001)(6506007)(316002)(6486002)(186003)(71200400001)(31686004)(91956017)(66476007)(64756008)(4326008)(8676002)(36756003)(66446008)(66946007)(76116006)(66556008)(8936002)(110136005)(54906003)(86362001)(478600001)(5660300002)(7416002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEIxZVo3VkxxNGwwQUJXZDkxcW4wdkV6UXlzNUZXRFJidVZlVkp0YkVlNkVD?=
 =?utf-8?B?LzJJbjA5MlhsRGJCcm5COGhBRDF5RkkzOGd3RWVUNExMWXlDMWpjZmFPTy9z?=
 =?utf-8?B?M0g1U1IrY2FYUE8zU2lJSC9VSlFaYllTclJpdU5reWhSaUJzcEU3TlczcFF2?=
 =?utf-8?B?TWc3c2hxckhCZG4rc2hiQXJlN2E4d3dpQnpyckVQTXcvZGJYNGpvdThQM2t2?=
 =?utf-8?B?Y3haZmN2d1BSMDl5Vkg4N2FKVkhJcEtoVnY5SzdNd2NBVUxaTThMU1NORUFN?=
 =?utf-8?B?UTBEOWVTYUcvZFFmamtqMjAxOTdWSGNnZElZTlpVRXdITWYvWFhIYnpyNms0?=
 =?utf-8?B?ZWRNejdJUnVFWTRNLytrMlJkZmV5QTU2U3pNT1RPcTVFK0ZGZDVFamd0NTBG?=
 =?utf-8?B?d2pzY21zMEluV0ExM25xc2U0cno0WHdYZEFSVERHcnlxc2ZVWitjbnhodU8v?=
 =?utf-8?B?SFV0aDVocDFNWGFrSnR6ZHllZm5obDkyMjlxMTJvVDBLM1lyZklYb2dDbnlJ?=
 =?utf-8?B?QndqVGFqRG1xaUVKeThldEZ6YW45azBJbTdFVVVmVHhlK1duNzE1eHlQWlY4?=
 =?utf-8?B?eGsxQnlRS2ZrSnQ2c3Zpd2JjckpTa2V0VjcyZERDVlN1OFlYbGYyTEtGUlFk?=
 =?utf-8?B?RHVnZS81bm5aNEdKTExrREIxbkNmSE9waVBNUmpvZHBydEtlREljbGR0enBO?=
 =?utf-8?B?SWNWWWZ5TXlib1JOUnhNS3ZLamhTdGFMODh6cXFIYXFYTTkrZUEycFp6Uk5G?=
 =?utf-8?B?TUhMUDRiQXZBUG9KL3FvcWZaSHNNY3FHVEx4Vm5GbmRoOGp2M0dUamZOVFhZ?=
 =?utf-8?B?MWo2RFR5dnNlZFhxSWFUY3p0WlR2cnUrZE5MWnBtSmdYaW1pNWhkSHR4K0wr?=
 =?utf-8?B?ZXU1VGJkNVgzenpJTGZGWjJzUG5tcTRkbmdRUkZsK1c0NGZpZ3Zxc05MTUwv?=
 =?utf-8?B?bDU1QnlpNlRBRkpmVmNaSFZJazNaaTlwenpVYmprWkQ2a3pTMU5FcGRJYWlF?=
 =?utf-8?B?WUpzaVpUanluTTlHNndWU3hVYi95NFNoY05ZYVowOVNLbDMvZHlIRHVUZC9O?=
 =?utf-8?B?N1BkdGYwSGFDZzlrYWduNEE1MzJBT01POVV2MVgxTlEvQk13TUI0V0U5ZzZV?=
 =?utf-8?B?NjFvOTFtdUVlektpR3NJbm5kNzY0Vm9iZlErRno1bHU3SXJUbzRXUHN3a2NU?=
 =?utf-8?B?K0pqVExhb2tBZGU5K09oOFVXK3JKWmM4T3NCMlV2OFRRRzl5bWtlYU9CbEQ1?=
 =?utf-8?B?dmRqclVJdFZ2Y3l5VTZmSEovbDF4cGRjYy9qWkRoWVRxbFN4dk50cTVTS2VX?=
 =?utf-8?B?bUhEbWMxS21yM3E2bDBMNnJ0bzBDN05vWVNyTFppaCtqd2hydUZrU1ZuTFVY?=
 =?utf-8?B?VCtPRWdjQkt6ejBPenhOc3NPOWFpZ1FzQVU4M2tyNytKbFlSZlpLb3V0OVEy?=
 =?utf-8?B?OWhwUE96OEtndTZsU0M3d3QweWtSVTUrV3dudUd5WVpONjh5SHhNcDNMdGo3?=
 =?utf-8?B?VEIrYzg1RnhJYitXT0I1eHVGWjh6b3NsMjkzR2dkdGEvUmxRUCtlTW40NmdY?=
 =?utf-8?B?anRUbThHVTJJOUUvbUtJbW85VWVweGZpQ3NCb1ljNUVnT1VGeTVSTDN3blZ6?=
 =?utf-8?B?OUhLS0EwcWF3YnNWNEhRQ1VKVDVjNklpMFlYQUR2bUxUbFB2V1Exb3B0U1Ju?=
 =?utf-8?B?dGx2L0ZGYTg1WXU2cWxiTjBOU3cza1lYZ0xJVWZKZGFYL0V0cFpKYXhPWE5U?=
 =?utf-8?B?UXU5MDdCcGlYaTBXMzBWbzEwNDNuV2dhQndpVDNmMUtZdDF2YmxlWHZkVW5H?=
 =?utf-8?B?a2ZMaHNldTdGR0NWZ3Vkd0hQRGFZVnA1T0EyMFFpNmRQZlNsa1A0ZDFqZW9C?=
 =?utf-8?B?OTcrdytpV0p4VEhUWDFjYlR1cjhaNm80SHZNanR1K0tFZnB1WDE0Mk4zVndi?=
 =?utf-8?B?RGtCSGhmQmJuMVFVL1pJV3BvYnpvTSttd21xUzRBQ3dhMytMWUtzWmUyRDFh?=
 =?utf-8?B?OWtFRHpaR3NUMlY2eVZ1VnU1Z2tFUDVFZDBUbGozOHdSQ29pZFpDSG0wRGth?=
 =?utf-8?B?MnpHQTg4Mktab1NBb2oxMXhXeDRWZmd1ZTdCOUxNNlFia2VCdmJ0b2RWYm9z?=
 =?utf-8?Q?aZgvbI9Sp6hU0l7TMOgowQhds?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC234938723AA745ABDB7092BD8864D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def29dd8-ec2d-4699-b27a-08da7a4c235b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 21:14:25.5349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0WHlJRJeM1KuzhPZuy1fb88CZ3pgBRqGJdoi04h8pp3eG5Vy8ZReqvPBrRSBabSaz/V58EuLuspNY9RuNZnpznCwd/7/XftxIb9wVCDxwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzA4LzIwMjIgMjI6MTMsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPiBPbiAwMi8wOC8yMDIyIDEzOjE4LCBYaWFudGluZyBUaWFuIHdyb3RlOg0KPj4gV2hlbiB1
c2UgJ2VjaG8gYyA+IC9wcm9jL3N5c3JxLXRyaWdnZXInIHRvIHRyaWdnZXIga2R1bXAsIHJpc2N2
X2NyYXNoX3NhdmVfcmVncygpDQo+PiB3aWxsIGJlIGNhbGxlZCB0byBzYXZlIHJlZ3MgdG8gdm1j
b3JlLCB3ZSBmb3VuZCAiZXBjIiB2YWx1ZSAwMGZmZmZmZmE1NTM3NDAwDQo+PiBpcyBub3QgYSB2
YWxpZCBrZXJuZWwgdmlydHVhbCBhZGRyZXNzLCBidXQgaXMgYSB1c2VyIHZpcnR1YWwgYWRkcmVz
cy4gT3RoZXINCj4+IHJlZ3MoZWcsIHJhLCBzcCwgZ3AuLi4pIGFyZSBjb3JyZWN0IGtlcm5lbCB2
aXJ0dWFsIGFkZHJlc3MuDQo+PiBBY3R1YWxseSAweDAwZmZmZmZmYjBkZDk0MDAgaXMgdGhlIHVz
ZXIgbW9kZSBQQyBvZiAnUElEOiAxMTMgQ29tbTogc2gnLCB3aGljaA0KPj4gaXMgc2F2ZWQgaW4g
dGhlIHRhc2sncyBzdGFjay4NCj4+DQo+PiBbICAgMjEuMjAxNzAxXSBDUFU6IDAgUElEOiAxMTMg
Q29tbTogc2ggS2R1bXA6IGxvYWRlZCBOb3QgdGFpbnRlZCA1LjE4LjkgIzQ1DQo+PiBbICAgMjEu
MjAxOTc5XSBIYXJkd2FyZSBuYW1lOiByaXNjdi12aXJ0aW8scWVtdSAoRFQpDQo+PiBbICAgMjEu
MjAyMTYwXSBlcGMgOiAwMGZmZmZmZmE1NTM3NDAwIHJhIDogZmZmZmZmZmY4MDA4ODY0MCBzcCA6
IGZmMjAwMDAwMTAzMzNiOTANCj4+IFsgICAyMS4yMDI0MzVdICBncCA6IGZmZmZmZmZmODEwZGRl
MzggdHAgOiBmZjYwMDAwMDAyMjZjMjAwIHQwIDogZmZmZmZmZmY4MDMyYmU3Yw0KPj4gWyAgIDIx
LjIwMjcwN10gIHQxIDogMDcyMDA3MjAwNzIwMDcyMCB0MiA6IDMwMjAzYTczNzU3NDYxNzQgczAg
OiBmZjIwMDAwMDEwMzMzY2YwDQo+PiBbICAgMjEuMjAyOTczXSAgczEgOiAwMDAwMDAwMDAwMDAw
MDAwIGEwIDogZmYyMDAwMDAxMDMzM2I5OCBhMSA6IDAwMDAwMDAwMDAwMDAwMDENCj4+IFsgICAy
MS4yMDMyNDNdICBhMiA6IDAwMDAwMDAwMDAwMDAwMTAgYTMgOiAwMDAwMDAwMDAwMDAwMDAwIGE0
IDogMjhjOGYwYWVmZmVhNGUwMA0KPj4gWyAgIDIxLjIwMzUxOV0gIGE1IDogMjhjOGYwYWVmZmVh
NGUwMCBhNiA6IDAwMDAwMDAwMDAwMDAwMDkgYTcgOiBmZmZmZmZmZjgwMzVjOWI4DQo+PiBbICAg
MjEuMjAzNzk0XSAgczIgOiBmZmZmZmZmZjgxMGRmMGE4IHMzIDogZmZmZmZmZmY4MTBkZjcxOCBz
NCA6IGZmMjAwMDAwMTAzMzNiOTgNCj4+IFsgICAyMS4yMDQwNjJdICBzNSA6IDAwMDAwMDAwMDAw
MDAwMDAgczYgOiAwMDAwMDAwMDAwMDAwMDA3IHM3IDogZmZmZmZmZmY4MGM0YTQ2OA0KPj4gWyAg
IDIxLjIwNDMzMV0gIHM4IDogMDBmZmZmZmZlZjQ1MTQxMCBzOSA6IDAwMDAwMDAwMDAwMDAwMDcg
czEwOiAwMGFhYWFhYWMwNTEwNzAwDQo+PiBbICAgMjEuMjA0NjA2XSAgczExOiAwMDAwMDAwMDAw
MDAwMDAxIHQzIDogZmY2MDAwMDAwMTIxOGYwMCB0NCA6IGZmNjAwMDAwMDEyMThmMDANCj4+IFsg
ICAyMS4yMDQ4NzZdICB0NSA6IGZmNjAwMDAwMDEyMTgwMDAgdDYgOiBmZjIwMDAwMDEwMzMzOGI4
DQo+PiBbICAgMjEuMjA1MDc5XSBzdGF0dXM6IDAwMDAwMDAyMDAwMDAwMjAgYmFkYWRkcjogMDAw
MDAwMDAwMDAwMDAwMCBjYXVzZTogMDAwMDAwMDAwMDAwMDAwOA0KPj4NCj4+IFdpdGggdGhlIGlu
Y29ycmVjdCBQQywgdGhlIGJhY2t0cmFjZSBzaG93ZWQgYnkgY3Jhc2ggdG9vbCBhcyBiZWxvdywg
dGhlIGZpcnN0DQo+PiBzdGFjayBmcmFtZSBpcyBhYm5vcm1hbCwNCj4+DQo+PiBjcmFzaD4gYnQN
Cj4+IFBJRDogMTEzICAgICAgVEFTSzogZmY2MDAwMDAwMjI2OTYwMCAgQ1BVOiAwICAgIENPTU1B
TkQ6ICJzaCINCj4+ICAjMCBbZmYyMDAwMDAxMDM5YmI5MF0gX19lZmlzdHViXy5MZGVidWdfaW5m
bzAgYXQgMDBmZmZmZmZhNTUzNzQwMCA8LS0gQWJub3JtYWwNCj4+ICAjMSBbZmYyMDAwMDAxMDM5
YmNmMF0gcGFuaWMgYXQgZmZmZmZmZmY4MDY1NzhiYQ0KPj4gICMyIFtmZjIwMDAwMDEwMzliZDUw
XSBzeXNycV9yZXNldF9zZXFfcGFyYW1fc2V0IGF0IGZmZmZmZmZmODAzOGMwMzANCj4+ICAjMyBb
ZmYyMDAwMDAxMDM5YmRhMF0gX19oYW5kbGVfc3lzcnEgYXQgZmZmZmZmZmY4MDM4YzVmOA0KPj4g
ICM0IFtmZjIwMDAwMDEwMzliZTAwXSB3cml0ZV9zeXNycV90cmlnZ2VyIGF0IGZmZmZmZmZmODAz
OGNhZDgNCj4+ICAjNSBbZmYyMDAwMDAxMDM5YmUyMF0gcHJvY19yZWdfd3JpdGUgYXQgZmZmZmZm
ZmY4MDFiN2VkYw0KPj4gICM2IFtmZjIwMDAwMDEwMzliZTQwXSB2ZnNfd3JpdGUgYXQgZmZmZmZm
ZmY4MDE1MmJhNg0KPj4gICM3IFtmZjIwMDAwMDEwMzliZTgwXSBrc3lzX3dyaXRlIGF0IGZmZmZm
ZmZmODAxNTJlY2UNCj4+ICAjOCBbZmYyMDAwMDAxMDM5YmVkMF0gc3lzX3dyaXRlIGF0IGZmZmZm
ZmZmODAxNTJmNDYNCj4+DQo+PiBXaXRoIHRoZSBwYXRjaCwgd2UgY2FuIGdldCBjdXJyZW50IGtl
cm5lbCBtb2RlIFBDLCB0aGUgb3V0cHV0IGFzIGJlbG93LA0KPj4NCj4+IFsgICAxNy42MDc2NThd
IENQVTogMCBQSUQ6IDExMyBDb21tOiBzaCBLZHVtcDogbG9hZGVkIE5vdCB0YWludGVkIDUuMTgu
OSAjNDINCj4+IFsgICAxNy42MDc5MzddIEhhcmR3YXJlIG5hbWU6IHJpc2N2LXZpcnRpbyxxZW11
IChEVCkNCj4+IFsgICAxNy42MDgxNTBdIGVwYyA6IGZmZmZmZmZmODAwMDc4ZjggcmEgOiBmZmZm
ZmZmZjgwMDg4NjJjIHNwIDogZmYyMDAwMDAxMDMzM2I5MA0KPj4gWyAgIDE3LjYwODQ0MV0gIGdw
IDogZmZmZmZmZmY4MTBkZGUzOCB0cCA6IGZmNjAwMDAwMDIyNmMyMDAgdDAgOiBmZmZmZmZmZjgw
MzJiZTY4DQo+PiBbICAgMTcuNjA4NzQxXSAgdDEgOiAwNzIwMDcyMDA3MjAwNzIwIHQyIDogNjY2
NjY2NjY2NjY2NjYzYyBzMCA6IGZmMjAwMDAwMTAzMzNjZjANCj4+IFsgICAxNy42MDkwMjVdICBz
MSA6IDAwMDAwMDAwMDAwMDAwMDAgYTAgOiBmZjIwMDAwMDEwMzMzYjk4IGExIDogMDAwMDAwMDAw
MDAwMDAwMQ0KPj4gWyAgIDE3LjYwOTMyMF0gIGEyIDogMDAwMDAwMDAwMDAwMDAxMCBhMyA6IDAw
MDAwMDAwMDAwMDAwMDAgYTQgOiAwMDAwMDAwMDAwMDAwMDAwDQo+PiBbICAgMTcuNjA5NjAxXSAg
YTUgOiBmZjYwMDAwMDAxYzc4MDAwIGE2IDogMDAwMDAwMDAwMDAwMDAzYyBhNyA6IGZmZmZmZmZm
ODAzNWM5YTQNCj4+IFsgICAxNy42MDk4OTRdICBzMiA6IGZmZmZmZmZmODEwZGYwYTggczMgOiBm
ZmZmZmZmZjgxMGRmNzE4IHM0IDogZmYyMDAwMDAxMDMzM2I5OA0KPj4gWyAgIDE3LjYxMDE4Nl0g
IHM1IDogMDAwMDAwMDAwMDAwMDAwMCBzNiA6IDAwMDAwMDAwMDAwMDAwMDcgczcgOiBmZmZmZmZm
ZjgwYzRhNDY4DQo+PiBbICAgMTcuNjEwNDY5XSAgczggOiAwMGZmZmZmZmNhMjgxNDEwIHM5IDog
MDAwMDAwMDAwMDAwMDAwNyBzMTA6IDAwYWFhYWFhYjViYjY3MDANCj4+IFsgICAxNy42MTA3NTVd
ICBzMTE6IDAwMDAwMDAwMDAwMDAwMDEgdDMgOiBmZjYwMDAwMDAxMjE4ZjAwIHQ0IDogZmY2MDAw
MDAwMTIxOGYwMA0KPj4gWyAgIDE3LjYxMTA0MV0gIHQ1IDogZmY2MDAwMDAwMTIxODAwMCB0NiA6
IGZmMjAwMDAwMTAzMzM5ODgNCj4+IFsgICAxNy42MTEyNTVdIHN0YXR1czogMDAwMDAwMDIwMDAw
MDAyMCBiYWRhZGRyOiAwMDAwMDAwMDAwMDAwMDAwIGNhdXNlOiAwMDAwMDAwMDAwMDAwMDA4DQo+
Pg0KPj4gV2l0aCB0aGUgY29ycmVjdCBQQywgdGhlIGJhY2t0cmFjZSBzaG93ZWQgYnkgY3Jhc2gg
dG9vbCBhcyBiZWxvdywNCj4+DQo+PiBjcmFzaD4gYnQNCj4+IFBJRDogMTEzICAgICAgVEFTSzog
ZmY2MDAwMDAwMjI2YzIwMCAgQ1BVOiAwICAgIENPTU1BTkQ6ICJzaCINCj4+ICAjMCBbZmYyMDAw
MDAxMDMzM2I5MF0gcmlzY3ZfY3Jhc2hfc2F2ZV9yZWdzIGF0IGZmZmZmZmZmODAwMDc4ZjggPC0t
LSBOb3JtYWwNCj4+ICAjMSBbZmYyMDAwMDAxMDMzM2NmMF0gcGFuaWMgYXQgZmZmZmZmZmY4MDY1
NzhjNg0KPj4gICMyIFtmZjIwMDAwMDEwMzMzZDUwXSBzeXNycV9yZXNldF9zZXFfcGFyYW1fc2V0
IGF0IGZmZmZmZmZmODAzOGMwM2MNCj4+ICAjMyBbZmYyMDAwMDAxMDMzM2RhMF0gX19oYW5kbGVf
c3lzcnEgYXQgZmZmZmZmZmY4MDM4YzYwNA0KPj4gICM0IFtmZjIwMDAwMDEwMzMzZTAwXSB3cml0
ZV9zeXNycV90cmlnZ2VyIGF0IGZmZmZmZmZmODAzOGNhZTQNCj4+ICAjNSBbZmYyMDAwMDAxMDMz
M2UyMF0gcHJvY19yZWdfd3JpdGUgYXQgZmZmZmZmZmY4MDFiN2VlOA0KPj4gICM2IFtmZjIwMDAw
MDEwMzMzZTQwXSB2ZnNfd3JpdGUgYXQgZmZmZmZmZmY4MDE1MmJiMg0KPj4gICM3IFtmZjIwMDAw
MDEwMzMzZTgwXSBrc3lzX3dyaXRlIGF0IGZmZmZmZmZmODAxNTJlZGENCj4+ICAjOCBbZmYyMDAw
MDAxMDMzM2VkMF0gc3lzX3dyaXRlIGF0IGZmZmZmZmZmODAxNTJmNTINCj4+DQo+PiBGaXhlczog
ZTUzZDI4MTgwZDRkICgiUklTQy1WOiBBZGQga2R1bXAgc3VwcG9ydCIpDQo+IA0KPiBUaGlzIHBh
dGNoIGlzIGFsc28gYSBmaXgsIGJ1dCBub3QgYXQgdGhlIHN0YXJ0IG9mIHRoZSBzZXJpZXMgd2hp
Y2gNCj4gKEkgdGhpbmspIG1ha2VzIGl0IGxlc3MgbGlrZWx5IHRvIGJlIHBpY2tlZCB1cCBmb3Ig
YW4gYXV0by1iYWNrcG9ydC4NCj4gDQo+IEFzIGl0IGRvZXNuJ3Qgc2VlbSB0byBkZXBlbmQgb24g
dGhlIHByaW9yIHBhdGNoZXMsIGNhbiB5b3UgbW92ZSB0aGlzDQo+IHVwIHRvIDIvNiBpbiB0aGUg
c2VyaWVzPw0KPiANCg0KUGx1cywgaXQnZCBiZSBuaWNlIGlmIHRoZSBzdWJqZWN0IGdhdmUgc29t
ZSBtb3JlIHN1YiBjb21wb25lbnQgY29udGV4dA0KJiB0aGUgc2FtZSBhcHBsaWVzIHRvIG1vc3Qg
b2YgdGhlIHBhdGNoZXMgaW4gdGhlIHNlcmllcy4NCg==
