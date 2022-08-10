Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1606258E869
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiHJIGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiHJIGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:06:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6F260501
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660118793; x=1691654793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k8lmhiREFfx5dcFLajRLzeEsiI7RV7gK1uPWugeoi7s=;
  b=ezVFXXQi5mYWzfBjoAx6iCiNu+qRll5xSIQ70C+vHhRwCrfKtfmQk5iT
   ohbxW3c2yWiR5puKtEbnhItdXLv4Y/Q5HlTPWj5pAtAh08Yb00IfrhiAT
   f0a2yG2keLBVGKWkRFzWJPQzcrSNi29xgSfWDvNZ5Rf0LeSoeWfTUCBqy
   FgtsyKSIEyVrNPKsonLOveFwKoj+lpmlUWPJ7Gklhx4ajQyFJeXJ87hA4
   wix+s+XTua0+PQwU1RNXrvummipVXxpPRGWmwnzvE/EEomscXjDnx34HI
   bhKbOsuIlhK1AvoKlbDNlKnPtygg1ifs889xJqBYPPZMMa/vjH7iBUve7
   A==;
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="108375593"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Aug 2022 01:06:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 10 Aug 2022 01:06:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 10 Aug 2022 01:06:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPoqytnS59oqbXZlcJiosUxiz0G3KiLo5YtivAH7hCTYpMdb0JRN4FjaZhfXbX817E0gPB5mIhtdEdW/x5HUunigz9pBTY21PUksK5nINQxS9S0TFvtDRFbmG3QXruqWHYRjCSJUk7YQbqp7aZLI3a9zr8XwYLyzmOAZz7qA8bqmquRHs7R5SCWM5t3hVXWgZq1Lj9cx/Hd9W7q7xquEDM3oeeu+1PpO3MLf+UHqvfx0Hh39DwaZM2veWUZyKKgTV2ukPk8ZDFwp7H9ywtDcAYC+51X/pPcWADDH9A62TCaI2Rvxghxt+t4NQGSXoSjWvRM7rjf+IiGHSmQeisN9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8lmhiREFfx5dcFLajRLzeEsiI7RV7gK1uPWugeoi7s=;
 b=m0hk/FamQScenTTroDJW0EWTc84gmLtoOHX4QOrEZ7cmy9YuFPvyBouX5aasMNuFxgOYMKZsMhlUAKGM201MC5aUoCvO7WJyp69ewZjTahsiXJ1HAcMzCTiiT6imTVKrBr1Egm0oAy8UdVmsxOq2zkyuZ2LexIfXiGzqKwoK5XjeB2EJnixa8l4RbVqsszqR9sapiIAIsTeLdF5AfMQmko2KXS7WWg+x+rR90I0ZwhfX0SOp6bCSd0+L8JJbGvGPf1WPGXFzYynFbaOVX4loGZpWxjtvGgJ4P6DFR/og7ZeQgpBKZ2O0X7S7UJKCigV1+7gnq/pSvwB+CNYMm7UMvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8lmhiREFfx5dcFLajRLzeEsiI7RV7gK1uPWugeoi7s=;
 b=mv5E1j0z8IS+KVax7oyPbMF6Iea2N4VhN+kHmqW0PYgSIQnfcXRwTcPd8uLw+A46rHmgkGVyfe85e/Kh/aYhXRp2mW7Oe+Uz5tjY4XBniiLjFewZTOUwD96vOyVYww6o4v3LDM7+3thlN8n+zetbreorSotKwNDPGl92wT4CJfc=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Wed, 10 Aug 2022 08:06:21 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1cf7:6d4b:5e26:3f56]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1cf7:6d4b:5e26:3f56%8]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 08:06:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <sudip.mukherjee@sifive.com>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
CC:     <greentime.hu@sifive.com>, <jude.onyenegecha@sifive.com>,
        <william.salmon@sifive.com>, <adnan.chowdhury@sifive.com>,
        <ben.dooks@sifive.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: add SFDP fixups for Quad Page
 Program
Thread-Topic: [PATCH v2 2/3] mtd: spi-nor: add SFDP fixups for Quad Page
 Program
Thread-Index: AQHYrJASR2XJCCWNYkmLP3pHpwj/WA==
Date:   Wed, 10 Aug 2022 08:06:21 +0000
Message-ID: <361fa56d-617c-ee92-151e-5d8fe0a29e53@microchip.com>
References: <20220809201428.118523-1-sudip.mukherjee@sifive.com>
 <20220809201428.118523-3-sudip.mukherjee@sifive.com>
In-Reply-To: <20220809201428.118523-3-sudip.mukherjee@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3450d509-4958-4b9d-8f19-08da7aa73640
x-ms-traffictypediagnostic: DM6PR11MB3322:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kjRSOAimYTkqF02zKN+zRotoYVKODKxvD6/BE9BY60UhIhnfUfXQVQdKl+T6etA1IS1J75PAMdBLoKSEfncsHQCAE+xx4+d/5JxymPDuglHipJVlBWR6FWzvk2WsbKIvGvkeuiRqhm0J3+Esl8vDyGzOUwLt4grHR/KDNsc83DK3pA9G/F6M9o3EU1DPi3ijxWSoSXxAhLZIuFRWa0OjAidc982lmuSIWd9+pXiHpFOzNd904+L8rq5pGQnxwNTZ9IIdEGW1c2fNIzKeRLvPAzN2ONvYNvVFu+RavG47B4/i7FdxSS+hhCgPmN8p9mJjvd4CtyhDo0umEd5Nw+pI5PV9c9jMG1psjDU44nmh/qm9qoh3Mbo1o74gv712MqZbUdrHaU0R5qcEkJTQVSv9jhDJu3rcQtjVsB7NNFNi6H48e02ih+1KBbUZqOadQ/vCcm3X5PlYsfXd249QA6O84hWWR1RGPsgVCAFS+VfKbzuapWWQBHZRVGvolfEivXwhsdDAHpT5F4cY2Mm+lJHnOn1yjxsMiAJ9mKCRZg857me6++Svh6QdHPuP1ZjtvF4POm5FHzImvufQl4q3LK67+6XmwzW5bB00XcJeHMMwh5fBe9a14TS/hZK+QXbVr0ohNryfPaBbnAjjpT5e466YIr0LP8ybumBeGnLiPjRPwWgI77vD5E7f5T9leRY+CiD27MGy47G65VahvhMIJZLIbXls0Q1pAHJZdgYFhYMbWgWFhiCWd4Bjf0EIq5yAFdgeYmXA5vnHC7PvpSc1gqF6C/aeCChoFlJ8zrkVv33frjJcoKXuvhJBk5xXcBtRefcov0YNwxkc5DcYIAktw7lPueUQUNUXqbPjaeMoPfWBAZVNssTPiZ7T/7o2sNHp/j7tbbLg/yjYhco1MaenETrsew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(2906002)(36756003)(38070700005)(122000001)(110136005)(38100700002)(54906003)(316002)(4326008)(8936002)(91956017)(66446008)(64756008)(6512007)(26005)(8676002)(6506007)(53546011)(2616005)(5660300002)(6486002)(478600001)(76116006)(186003)(41300700001)(66946007)(7416002)(71200400001)(66476007)(86362001)(31696002)(66556008)(31686004)(45980500001)(43740500002)(352734003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkJ4N3ArS3Raa0x5dnd1RU5WUCtyQ1ZYWCtaMFhIMVdxdDd5UmIxOUhRTkg5?=
 =?utf-8?B?ZDFueGgxYkwzU3BuUkhmTC9yMUlKeHhhRmxyTDVMZ3kzeTZXVzAwWmkvL1Zo?=
 =?utf-8?B?TmE1NW1DbWk3T0pTRy85cU05UlBFc3pkRHN4U2wvbFpQNWpSYjl4eURyckVR?=
 =?utf-8?B?Z2FDS1RRQ2wvWFZHdUFHYitkblNKUnNpRnVDS2NCUWl3a0dLRzBNeHMyaU5Z?=
 =?utf-8?B?MWNheWcvSGNZdDlLS0ZzM2VoY0dpSXF5dXFGN2djZ3ZoOENJR1cvWFY0WTZX?=
 =?utf-8?B?Z0s2Vi83dE5RVXU2SHp5RjdTUDFtUGtYcUhQKzFlbG5xd1ZCMEZtS0JhZ2dZ?=
 =?utf-8?B?WkF2VC9HcjYzTE9IVFMrR0l0bDFsdzRlYk1GUm4wVFM4RllneVgvVUdsbDA1?=
 =?utf-8?B?MHZBWjhkM29OUmRJRDZlVTRUSU5TckZ1N3Y0UW1sVkpQd0UxS1RObkhUekYv?=
 =?utf-8?B?andwT0hvMjRoeFJFN0J5WkFEM29KM1dtcEFndklhNmxrTzZBa3hSMzhwUmls?=
 =?utf-8?B?RHQvOXA3Mmd1R0ZkVyt2akIyQUpxV1VHdVFESWh3aU5DclVrNGp4clNZdWg5?=
 =?utf-8?B?ZkZpR0tvaXg1OWRWc0x5ZzYwOEZyUmVobmNFL1FMTnBkS2FXS1dBRHNsODVF?=
 =?utf-8?B?UTd5am1keVdoK2h4WWYrbTc0SHd1RTNnQUhtd21xVy9VTmNINTJCaXd0VzdO?=
 =?utf-8?B?RnRWRVVXeHRiYnFWcE8ybW1rN0lZUk9pZUJCbVBVNldrNlpTNTRDT01MTlVp?=
 =?utf-8?B?eHR2SXFGWjJtanloRC8rWnA3amp1UElaK0NVMGlKMmN1Z0svN3JmeTFYZ1Qy?=
 =?utf-8?B?dUJtYVdoZDJYRlJQNGp0RHFualgwdEFYSzZFSFN4TjYwbXVhU3NYZEs4TWdD?=
 =?utf-8?B?NS9BWmt4bWxXN1RKeDZKMkxXbUVvMlJSY0NzeklCb3d0TWc3QXdYZkxjQnZN?=
 =?utf-8?B?NFBZRzNkNk9BNFBOcTNmQk03VG5yc01IbTQyaU8vUjhwcXV2dm4va0hHQm0z?=
 =?utf-8?B?bFJ0Nkx1SFg4ZHgyTEhIZHlvSFFMMGlBSTRTbWc3dkR1cGlSRHVSdWdIem5r?=
 =?utf-8?B?WStuZ01MUE9LcmdOQ0I3UjdNVUpuNTFXQytBRk5wL2laTzh1Zll0UkpJL08x?=
 =?utf-8?B?QUR0MklqRlo5Y3B5ZzQ4ZVdiT0F4cGZyUVRRTzByWWw2Zjh2ZGNtUVQyUXpM?=
 =?utf-8?B?Q3F1VG43dnBncWlCRTYzUDUrSVpycmZwa0NsOGJlSVZzVGU0ZHI4MDhzVEZo?=
 =?utf-8?B?U2NXczJvZWI4b0RmRmhXMmhHY0dFRUFPaWY1cXlSc3RDSnF3MjU0R1R2RmNG?=
 =?utf-8?B?ZHVkODExS0U3SkxpczI1QVJlVU44YmdHNUg3Rmh3cDAwa3dWRXI1eVNEbFlv?=
 =?utf-8?B?NmVRMll4Vm5DN3o1aDNoRVJ2Qm55cUVjWjA3ckFvWHlielhjREhpZXBKc0Vi?=
 =?utf-8?B?R25DWkRGWE5pRW93SjdsSXFQTlNXUEd5am5YNzBCeTVzV1hXOWw1VTF2aWJz?=
 =?utf-8?B?aEl1TzhGV3VOUHZoQ0tTVkNpeWpmTnFFUXlxcGJETU8wSHNMMlpNQTR2Qmo1?=
 =?utf-8?B?OGdNNkJjMHlrb09ubndxZ0RRZTQ3SE5yeU9hak1GcmpNVHFWS2xmbEpEbFZo?=
 =?utf-8?B?SkJTVTY1MEhvZ3d4OEE2dWtyWEtudzdOUFFualRxMm5SRUZ5YVZXZzRXanB4?=
 =?utf-8?B?d2Y1NlBwRnJ4djViekNRZkRXcm45RUdIZU5YVUZtcnY2ajlXNVNjVjlDVWlL?=
 =?utf-8?B?U2pYY0tWYy9OWEN6WU51ZGorZ2c2d3Jqd1BVR3haWFpTczhsUUtRcXpYYjV6?=
 =?utf-8?B?TUh4dWpYSEF4djVydC91VUVpMUc0eTUzdHFJSysxeWZrQlhoTE1UQ1hNMFBp?=
 =?utf-8?B?M3VnZW9tbkQ2OHdnSGZtdnhjVTZScStBcktORWlzQU9NdkNUdlhxYUxhR0hD?=
 =?utf-8?B?UUw4RjNLSjA1NWhBQjRHZnRaSEpCbmRLN25kMGRsakVFQkU2dlJ3SnJWWGxq?=
 =?utf-8?B?UnprZTd6OXRYNVJBWmY0Q3JrdEJJREl5SlBOekxYTjVPZDVxaTdld3piTU1U?=
 =?utf-8?B?eHowWGUwOXE0TVBvOXk4bmRSZWErWUQ5Z3VEWmh3WlhFcW1jNVpZQzlXYzNU?=
 =?utf-8?B?TnZzNk9UUjFLb1poMkdxeDd5UHFyVmh4NHFCR0RiNXRrUm5lVmdmcFVIaUt3?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C724B384C0DB4C468B0F3EEBF0BEC305@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3450d509-4958-4b9d-8f19-08da7aa73640
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 08:06:21.4518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDFAPuiokU2VsMJ7pBg4FkgSaPnSTdqbAi8B+R7Fz22YynWJi/x/ruh6LQhG6i/KDk9JD1vrWrTNTbBKzklawqAFBJmUHKky682xl9M+qw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3322
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC85LzIyIDIzOjE0LCBTdWRpcCBNdWtoZXJqZWUgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gU0ZEUCB0YWJsZSBvZiBzb21lIGZsYXNoIGNoaXBz
IGRvIG5vdCBhZHZlcnRpc2Ugc3VwcG9ydCBvZiBRdWFkIElucHV0DQo+IFBhZ2UgUHJvZ3JhbSBl
dmVuIHRob3VnaCBpdCBoYXMgc3VwcG9ydC4gVXNlIGZpeHVwIGZsYWdzIGFuZCBhZGQgaGFyZHdh
cmUNCj4gY2FwIGZvciB0aGVzZSBjaGlwcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN1ZGlwIE11
a2hlcmplZSA8c3VkaXAubXVraGVyamVlQHNpZml2ZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9t
dGQvc3BpLW5vci9jb3JlLmMgfCA5ICsrKysrKysrKw0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmggfCAyICsrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5jDQo+IGluZGV4IGYyYzY0MDA2ZjhkNy4uNzU0MjQwNDMzMmE1IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYw0KPiBAQCAtMTk2Miw2ICsxOTYyLDEyIEBAIHNwaV9ub3Jfc3BpbWVtX2Fk
anVzdF9od2NhcHMoc3RydWN0IHNwaV9ub3IgKm5vciwgdTMyICpod2NhcHMpDQo+ICAgICAgICAg
aWYgKG5vci0+ZmxhZ3MgJiBTTk9SX0ZfQlJPS0VOX1JFU0VUKQ0KPiAgICAgICAgICAgICAgICAg
Kmh3Y2FwcyAmPSB+KFNOT1JfSFdDQVBTX1hfWF9YIHwgU05PUl9IV0NBUFNfWF9YX1hfRFRSKTsN
Cj4gDQo+ICsgICAgICAgaWYgKG5vci0+ZmxhZ3MgJiBTTk9SX0ZfSEFTX1FVQURfUFApIHsNCj4g
KyAgICAgICAgICAgICAgICpod2NhcHMgfD0gU05PUl9IV0NBUFNfUFBfMV8xXzQ7DQo+ICsgICAg
ICAgICAgICAgICBzcGlfbm9yX3NldF9wcF9zZXR0aW5ncygmcGFyYW1zLT5wYWdlX3Byb2dyYW1z
W1NOT1JfQ01EX1BQXzFfMV80XSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFNQSU5PUl9PUF9QUF8xXzFfNCwgU05PUl9QUk9UT18xXzFfNCk7DQo+ICsgICAgICAg
fQ0KDQpzZXR0aW5nIFNQSU5PUl9PUF9QUF8xXzFfNCBzaG91bGQgYmUgZG9uZSBpbiBzcGlfbm9y
X2xhdGVfaW5pdF9wYXJhbXMoKS4NCnNwaV9ub3JfbGF0ZV9pbml0X3BhcmFtcygpIGlzIHVzZWQg
dG8gYWRqdXN0IHRoZSBvcHMgc3VwcG9ydGVkIGJ5IHRoZSBmbGFzaA0Kd2l0aCB0aGUgb25lcyBz
dXBwb3J0ZWQgYnkgdGhlIGNvbnRyb2xsZXIuDQoNCj4gKw0KPiAgICAgICAgIGZvciAoY2FwID0g
MDsgY2FwIDwgc2l6ZW9mKCpod2NhcHMpICogQklUU19QRVJfQllURTsgY2FwKyspIHsNCj4gICAg
ICAgICAgICAgICAgIGludCByZGlkeCwgcHBpZHg7DQo+IA0KPiBAQCAtMjQ0Niw2ICsyNDUyLDkg
QEAgc3RhdGljIHZvaWQgc3BpX25vcl9pbml0X2ZpeHVwX2ZsYWdzKHN0cnVjdCBzcGlfbm9yICpu
b3IpDQo+IA0KPiAgICAgICAgIGlmIChmaXh1cF9mbGFncyAmIFNQSV9OT1JfSU9fTU9ERV9FTl9W
T0xBVElMRSkNCj4gICAgICAgICAgICAgICAgIG5vci0+ZmxhZ3MgfD0gU05PUl9GX0lPX01PREVf
RU5fVk9MQVRJTEU7DQo+ICsNCj4gKyAgICAgICBpZiAoZml4dXBfZmxhZ3MgJiBTUElfTk9SX1FV
QURfUFApDQo+ICsgICAgICAgICAgICAgICBub3ItPmZsYWdzIHw9IFNOT1JfRl9IQVNfUVVBRF9Q
UDsNCj4gIH0NCj4gDQo+ICAvKioNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5oIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgNCj4gaW5kZXggODViMGNmMjU0ZTk3
Li43ZGJkZjE2YTY3YjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5o
DQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+IEBAIC0xMzAsNiArMTMwLDcg
QEAgZW51bSBzcGlfbm9yX29wdGlvbl9mbGFncyB7DQo+ICAgICAgICAgU05PUl9GX0lPX01PREVf
RU5fVk9MQVRJTEUgPSBCSVQoMTEpLA0KPiAgICAgICAgIFNOT1JfRl9TT0ZUX1JFU0VUICAgICAg
ID0gQklUKDEyKSwNCj4gICAgICAgICBTTk9SX0ZfU1dQX0lTX1ZPTEFUSUxFICA9IEJJVCgxMyks
DQo+ICsgICAgICAgU05PUl9GX0hBU19RVUFEX1BQICAgICAgPSBCSVQoMTQpLA0KDQp5b3Ugd29u
J3QgbmVlZCB0aGlzDQo+ICB9Ow0KPiANCj4gIHN0cnVjdCBzcGlfbm9yX3JlYWRfY29tbWFuZCB7
DQo+IEBAIC01MjAsNiArNTIxLDcgQEAgc3RydWN0IGZsYXNoX2luZm8gew0KPiAgICAgICAgIHU4
IGZpeHVwX2ZsYWdzOw0KPiAgI2RlZmluZSBTUElfTk9SXzRCX09QQ09ERVMgICAgICAgICAgICAg
QklUKDApDQo+ICAjZGVmaW5lIFNQSV9OT1JfSU9fTU9ERV9FTl9WT0xBVElMRSAgICBCSVQoMSkN
Cj4gKyNkZWZpbmUgU1BJX05PUl9RVUFEX1BQICAgICAgICAgICAgICAgICAgICAgICAgQklUKDIp
DQoNCk5vLCBhcyBJIHByZXZpb3VzbHkgc2FpZCwgU1BJX05PUl9RVUFEX1BQIHNob3VsZCBiZSBk
ZWNsYXJlZCBhcyBhDQppbmZvLT5mbGFncywgbm90IGFzIGluZm8tPmZpeHVwX2ZsYWdzLg0KDQo+
IA0KPiAgICAgICAgIHU4IG1mcl9mbGFnczsNCj4gDQo+IC0tDQo+IDIuMzAuMg0KPiANCg0KDQot
LSANCkNoZWVycywNCnRhDQo=
