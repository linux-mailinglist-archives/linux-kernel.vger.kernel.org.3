Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EB8552168
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbiFTPmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241933AbiFTPmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:42:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB4083
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655739769; x=1687275769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H4FMk8TSi2z1Gt40QPfdLRb3v+LfBwU8KnmjTVYKG+Y=;
  b=B0WZe62HS/9eAPGoAjAOW9ZTVjaCCg6efrc/unmwUBQSBENBDQLCzIi7
   BwyaUvrc0NaNEfcV/uWTx8QVWLE3POOEkJu8lZFzgOCekewJicgoOQyyg
   aqVliss0l4x6sAdqVQ8ckq+Yj4qkvyhaMe89m9I7H1AVKUvZs4myZ+CEK
   BqB3WV4zenZkVNWmS/OXLtzT6hMWIsli/Fw/5JRwN7BQGPcgIdVU9gZ4o
   hgulb7qUWvZk0t1rBrSIOJ5hC8pVIr8l1PJa7+ekup8Ckf/jLrTn8jLuP
   AnIhtJ7PLWZgqQdWqFTX55NBnyPvKQCS+8A5S4CvYKkB7VdNsEs6CaBhA
   g==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="100861258"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2022 08:42:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Jun 2022 08:42:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 20 Jun 2022 08:42:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJKl6DPocBj9dEY2oUFEnJV0zOBI4iQQjU2Q8OpdcqQkReTdid7LY9lMO6WIWwoT/CqxLCSPmhtB/xX/GCwA9qbJdQUSoQsUbeFnu8FaWwOJsh3sCtSIxoCxii/YGcgI2fOl/wpxtakQ4ObxgqVTjWUbnYB+mz/Kpvc3vVeVrMWKsvroML5PpIfMTVi/XsJ2Jd9qptHcRyv6EMs9YYpeyP4PvNQVswc4gy4pLDaRKIYYCVYad1+tCRKz8C/dZnGuHt1X+XG5ME+9I37A4HtplDoUpZL2ZEAoAXR/+lJ0qz8J3XKwvn+c7KX8b6r4lO5XGJ+OqDnTarN28SCV1qoPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4FMk8TSi2z1Gt40QPfdLRb3v+LfBwU8KnmjTVYKG+Y=;
 b=jDyIu107wWp37+cDbGwULFGb+BQZR7uZOU46uMP/UhQqnKCJfE946ePhM9TbTAfQ5uEwIhUIKTm4tZ+EARtzqrp64WP/J1itxrIcqWX97R5mFv+JRMfP/LXekjTGyiMObIdWbPVVYAEzMsg4Onw4bsKj8ixG9/fzmjvNMVXCLaDnweSAp4I8Tm8WuMivIg1a6FeWakNhIjop0T0wwnxne+ckXf72sfgXCCEmPkX4d7qqCEb53Kwc/lq9u/N8wX5beBWAFtBbdA0kArVhDY39QO/okEoairgfkeucgnARF2vTF4gY965Upr7ltZQ7ZHtfufzWzPlVTsJxo6tYHVrUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4FMk8TSi2z1Gt40QPfdLRb3v+LfBwU8KnmjTVYKG+Y=;
 b=IjNoUfwexz+PoEUgId3wD+l7MJ60VKVeWmXvEkaej5/dw47hY43aQEOIKcFcdWutghfX/QnbcBjxRzgFU1cSYI0IS6F2tvmbRNI63BxdS8n1GJIhrLNordGz279DukqZQ+3f8iJE2zQDAPPkjqWkI5AL5AVrI2Ad4bwCuUczEnY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CH2PR11MB4503.namprd11.prod.outlook.com (2603:10b6:610:46::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Mon, 20 Jun
 2022 15:42:44 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5353.020; Mon, 20 Jun 2022
 15:42:44 +0000
From:   <Conor.Dooley@microchip.com>
To:     <apatel@ventanamicro.com>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>
CC:     <arnd@arndb.de>, <atishp@atishpatra.org>,
        <nikita.shubin@maquefel.me>, <heinrich.schuchardt@canonical.com>,
        <anup@brainfault.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
Thread-Topic: [PATCH] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
Thread-Index: AQHYhJz75cmfv8WW10Se/zFPHweEZ61Yb4iA
Date:   Mon, 20 Jun 2022 15:42:44 +0000
Message-ID: <9611eca5-0e38-e64b-58c3-a4e67422e011@microchip.com>
References: <20220620115549.1529597-1-apatel@ventanamicro.com>
In-Reply-To: <20220620115549.1529597-1-apatel@ventanamicro.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b79d9d6-04bd-46a8-c410-08da52d384a9
x-ms-traffictypediagnostic: CH2PR11MB4503:EE_
x-microsoft-antispam-prvs: <CH2PR11MB45030167AE8EE2CDC5608B9798B09@CH2PR11MB4503.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GHsHiarrm1dMf3ultIk0IVL9NbkBTRpae1MLFmBht3nKAycYQBI7s0Oxz8HEp+QfjFGdC1QFUsI8FPDPFLfQ+K9ISTiIk/9qk+/W1Gc6+r2OwrriuqVt5vwjT7lR72d2Q3zj3vueDcMDiDjiBlReHSxy4JuJRRBFRmV0tqfmAk1Mg1XPA0fT4i4BhlOMxXItWZZCauDRq/j41TfD53nAay6EWBl513GvY4UKRJDO5EmFqqtLxXkpI6SYRvDyrpbnmINeEKVXaKwXEweRHAwrykHKSWiQDk35VVcKBAOcxB+ioi/Xut9UrSS2WbXwX8wPyi6yE1Zo0LxU2XoTXvyM7E5r8SUo52wrXK6HY5kX0TlAtIEMF6Tbpmf4vLWBsgt7KMYOqNJbJZDVjpzo1GGphSq2NMAtfLGzCRawvJkZIqet2aHD+UydpUe8GvAD/35rsm7I7Vnv56CHFrd1ke+xbHVQ/Xw//MK/bSc1C2FVeg2ELI03ya95GdlbcrJ479hi9KqWJ78dc3m0rbLrN3fVeQ2o+eYSCHGqvehfrYuoZHLtKD1aBHWWrUKkM054e8DXBP9BZNAY0AYb1GSpu+i1nowqTIvodmi+syK3B2UVzzy//MFQacnsuzgl+mDIboxoK3C+NoWIxnBmcY4x0YHUcaPIibsjb3xDOchkmgUzawEmqYeQlD8ZcR1JtTKQCLWfU1AjEprpkjmqkhCBicTpQH7tc93yEN170U+4jv4jONoUmNnMxxJOWNj15agSMctO/HrsdqfgbJ5QUtOZb8fR8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(39860400002)(376002)(346002)(5660300002)(6506007)(186003)(83380400001)(4326008)(7416002)(122000001)(38100700002)(66556008)(2906002)(64756008)(53546011)(6512007)(54906003)(110136005)(38070700005)(6486002)(316002)(66476007)(478600001)(2616005)(41300700001)(26005)(36756003)(91956017)(71200400001)(76116006)(86362001)(8936002)(31686004)(31696002)(66946007)(8676002)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGRIcWNxd0szcXFsZzJDR2JtQWJSbWg5dzI0akdxc0lPK1VnZzhnUVBTaVgz?=
 =?utf-8?B?ZmhCRUo1NFRuQnBZSTM4dW4xemIvTWpRZ3pOaUpHZDQ0OVBVUVlBQ0pNYWNL?=
 =?utf-8?B?ejZraXRpd1d3M213bVdTL05tMHRKNmNhRUJEaFRkaFcwQ0xDT0pPZzdLUWVH?=
 =?utf-8?B?OHRjWGhBOUJiUm5DOHNrbGZKYk5FYUF3TG8yYlh0aWhOd1UzUjB6bG5SY2ta?=
 =?utf-8?B?VzJ5QWxrVzVBVWVyTDYxNDdXMXcvQUJPeFlxRnBYdzNQenlhSEVhQWYwaGsw?=
 =?utf-8?B?MDJjNVhiMWcrbEVHRlRLYXo0VWxaUE5WYUJ6azFJVjN4ZSs2cXBRQnFvV2J4?=
 =?utf-8?B?RDNzWEozL28xQVBJcWZEK1Y1SUtaRzhsSTQ0VmhoZ2s2aFRBU3lBdDJwRkVz?=
 =?utf-8?B?Z3NOa2t0SXMwek56UktOeGk4ZFE2ZFo1MW1tWHpQNDNHUUR6OU50Y1ZwQmZn?=
 =?utf-8?B?RVJqSWM5REhrT3M2Rm40TDd1UzVzWjdXRXRrZTF2emNtMFBBWmdYNjNGNHFW?=
 =?utf-8?B?dENlRENVQTA5RFBIaENvQjQ5SW8xYTZERHVYZ2pPdmRZR1NWdUdIcEtrdk1S?=
 =?utf-8?B?TEtUQ1lLZ0VFak9wQm80TVE2WFM3N1FxNkc2azR1ZnlxTGJqeXJGbzRJL0tT?=
 =?utf-8?B?MjExVUVTNFhCR29RUU1KSmNnbFdhZ1NTZlFwSFNvbDVUT1F1QzhOK3hXQ1BP?=
 =?utf-8?B?eUNmQ0VqemFoTjZ0a0JGeGxJL1JHaVZqdmxpdVFWcUxqejJ2SlRPdzBiNVEv?=
 =?utf-8?B?WHhvbzRDQzVRYms0dm5pZkxIMVF6VFJ0VWdvSkMwZVVJV0dYa0owTHJLRDVu?=
 =?utf-8?B?OU9sbDd2aUp4UFIrcSt3K3hCRzY2a0tHTVd4M0pPQ3BmNmhBdGx1WmVELzJ3?=
 =?utf-8?B?TDdWcnJjcG0yQzVQL2g3dGxuSWJWMTN3bUdZQ1JESVZ3eTY3WjVtemlFbEhH?=
 =?utf-8?B?U2VGQUk0Um52UGJoa1RFY1hwR3hxTUdZekVYVUsyZjk3QU92QXhuSnptR2V4?=
 =?utf-8?B?WkFNSHBPU21HZ2Q2VHlYTHU5cm05M0Y2MWpNczVnYUVLV3lmSUM5emxkekpi?=
 =?utf-8?B?OXRsNEF0a1dQTUlIbW11dXJCTEovbnE4VndFRlk1dXJTbE9qdkN1aUxrT2tu?=
 =?utf-8?B?ZzFIKzczbUEwd0ozMFRET3Fpa050OXhaOHc4MTZzOW43RUYrMWhHNWVyYkU3?=
 =?utf-8?B?ckxYbkFWRG5OWFVaVEhGTTI4NUlEbGZkVEJTLzdtUzRmVENhMEM4dnNjNmYy?=
 =?utf-8?B?Qm16UTk5ZkJuT0hWaGJENlZGaEhoSUh4N3BiV3JSSmYwdjF4WC9lWGxFUzYw?=
 =?utf-8?B?WjhKd1FsTVBRM0RwWHZwMzR2NWM3QzNvc2dIa1R6eUhTRlVFaVFpS08xNE9s?=
 =?utf-8?B?bXpCcHdROUVlcVBrckI0eHJPMWpjbDZPSkhFNWR5aE4yNy92dG1sL1BFVGpZ?=
 =?utf-8?B?Z2JkM1VtU01FWkkxYjdIWmR6c3JVUGtSVVhHa3IzS2VISmtQWE1Gd2kwcnV6?=
 =?utf-8?B?V25aeDlVTy94eExKcFFRRStiTkZURE43UnFaeFM5dW94MWhuYUZuOHEzenpr?=
 =?utf-8?B?T3lrakp6QllNVVMxRDlhbnRXbFVhWW55bmJ1bFk3ajBZUVNJNEwxdm5BWnhZ?=
 =?utf-8?B?MVhvS3FQQjlkY250TkVEYXdJNXcrUEs5bXZsRjFSOVZ6T2E2V1lsQnl6aDJW?=
 =?utf-8?B?ZDcxNThlWWdRRFZ3a3FoSHpYUnk4VkVraXl5ZEwvaHZWelR0eG9QcUpDeklN?=
 =?utf-8?B?aUZwM25MSTZQNVFsbjBWTm5Wa0JQcnBOdWVST1pNOG5GOWxrNVd4WmhKVzEz?=
 =?utf-8?B?ZUJ1aFNsdUFFZVhScE5XbUdqUXdUVG43Q2xxOCtvYVNUaXBsWDdEMU5FMmlG?=
 =?utf-8?B?a1JlbnZpUlpYdmN4MUQreHBSdFMwQkdGYW5hd2xYY0NmMVVNQzZYWVEya3Jm?=
 =?utf-8?B?WWk5NVhJNlQwcXJPVVNQbCtmRENPeG5FNjdYUGMzZGNTSWdlRmh2R1NWOGNW?=
 =?utf-8?B?eWZUcS9ibE91c1NuN05zRnRDUFJwYVB4OHByY2JJaGNjUjlrTmFqWU5hOWRW?=
 =?utf-8?B?TW91enBwYWxiRzRLUVZmR1BiMXBRSmlqbnpRR3RUZGZEb3FuTjBURjgwam5x?=
 =?utf-8?B?S1NzdU81RHViNGN3YW44dzA2cno3STVyb1ZVL2RMbUtqaGdLdlR1UjM3OWF6?=
 =?utf-8?B?SVJMZU5KL2lCVVppSXkwbXBmNVBGUkRzWUg1RTVJRDRJZ1hxWmxHMUJ4bFhO?=
 =?utf-8?B?akhxYWJoeEgvcTdOUnpFZm1TN1YrS0xkOFd1b3JESmdsOTNscTFMTWxNWkl6?=
 =?utf-8?B?VWQ1ZHZ0bXErN0dZcmhTSjRsYWt2MDdOeDFaUloybXU1cGh5UjJrTnhCaHF4?=
 =?utf-8?Q?EgTB3l5adUTxgen0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB97AF574575564C9EC8AA96BD043167@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b79d9d6-04bd-46a8-c410-08da52d384a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 15:42:44.3173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGWQbTsdXWz0rmx3ms3w80uA/Vq1ic8k71YGojYVS+mm35hwV34Y5kZ3lUJE+kPonZqupEdIxrK1OJ25GncvzrSzKtVIkaJhvibvYw03fdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4503
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEFudXAsDQpUZXN0ZWQgaXQgJiBnb3QgYmFjayB0aGUgKHNhZGx5IGJvcmluZykgMHMgdGhh
dCBhcmUgc2V0IGluDQpteSBoYXJkd2FyZS4NCg0KVHdvIGNvbW1lbnRzIGJlbG93Lg0KDQpUaGFu
a3MsDQpDb25vci4NCg0KT24gMjAvMDYvMjAyMiAxMjo1NSwgQW51cCBQYXRlbCB3cm90ZToNCj4g
SWRlbnRpZnlpbmcgdGhlIHVuZGVybHlpbmcgUklTQy1WIGltcGxlbWVudGF0aW9uIGNhbiBiZSBp
bXBvcnRhbnQNCj4gZm9yIHNvbWUgb2YgdGhlIHVzZXIgc3BhY2UgYXBwbGljYXRpb25zLiBGb3Ig
ZXhhbXBsZSwgdGhlIHBlcmYgdG9vbA0KPiB1c2VzIGFyY2ggc3BlY2lmaWMgQ1BVIGltcGxlbWVu
dGF0aW9uIGlkIChpLmUuIENQVUlEKSB0byBzZWxlY3QgYQ0KPiBKU09OIGZpbGUgZGVzY3JpYmlu
ZyBjdXN0b20gcGVyZiBldmVudHMgb24gYSBDUFUuDQo+IA0KPiBDdXJyZW50bHksIHRoZXJlIGlz
IG5vIHdheSB0byBpZGVudGlmeSBSSVNDLVYgaW1wbGVtZW50YXRpb24gc28gd2UNCj4gYWRkIG12
ZW5kb3JpZCwgbWFyY2hpZCwgYW5kIG1pbXBpZCB0byAvcHJvYy9jcHVpbmZvIG91dHB1dC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEFudXAgUGF0ZWwgPGFwYXRlbEB2ZW50YW5hbWljcm8uY29tPg0K
PiAtLS0NCj4gIGFyY2gvcmlzY3Yva2VybmVsL2NwdS5jIHwgNTEgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1MSBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvY3B1LmMgYi9hcmNoL3Jp
c2N2L2tlcm5lbC9jcHUuYw0KPiBpbmRleCBmYmE5ZTlmNDZhOGMuLmMwMzdiODY5MWJiYiAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvY3B1LmMNCj4gKysrIGIvYXJjaC9yaXNjdi9r
ZXJuZWwvY3B1LmMNCj4gQEAgLTMsMTAgKzMsMTMgQEANCj4gICAqIENvcHlyaWdodCAoQykgMjAx
MiBSZWdlbnRzIG9mIHRoZSBVbml2ZXJzaXR5IG9mIENhbGlmb3JuaWENCj4gICAqLw0KPiAgDQo+
ICsjaW5jbHVkZSA8bGludXgvY3B1Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L3NlcV9maWxlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4g
KyNpbmNsdWRlIDxhc20vY3NyLmg+DQo+ICAjaW5jbHVkZSA8YXNtL2h3Y2FwLmg+DQo+ICsjaW5j
bHVkZSA8YXNtL3NiaS5oPg0KPiAgI2luY2x1ZGUgPGFzbS9zbXAuaD4NCj4gICNpbmNsdWRlIDxh
c20vcGd0YWJsZS5oPg0KPiAgDQo+IEBAIC02NCw2ICs2Nyw1MCBAQCBpbnQgcmlzY3Zfb2ZfcGFy
ZW50X2hhcnRpZChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUpDQo+ICB9DQo+ICANCj4gICNpZmRl
ZiBDT05GSUdfUFJPQ19GUw0KPiArDQo+ICtzdHJ1Y3QgcmlzY3ZfY3B1aW5mbyB7DQo+ICsJdW5z
aWduZWQgbG9uZyBtdmVuZG9yaWQ7DQo+ICsJdW5zaWduZWQgbG9uZyBtYXJjaGlkOw0KPiArCXVu
c2lnbmVkIGxvbmcgbWltcGlkOw0KPiArfTsNCj4gK3N0YXRpYyBERUZJTkVfUEVSX0NQVShzdHJ1
Y3QgcmlzY3ZfY3B1aW5mbywgcmlzY3ZfY3B1aW5mbyk7DQo+ICsNCj4gK3N0YXRpYyBpbnQgcmlz
Y3ZfY3B1aW5mb19zdGFydGluZyh1bnNpZ25lZCBpbnQgY3B1KQ0KPiArew0KPiArCXN0cnVjdCBy
aXNjdl9jcHVpbmZvICpjaSA9IHRoaXNfY3B1X3B0cigmcmlzY3ZfY3B1aW5mbyk7DQo+ICsNCj4g
KyNpZiBkZWZpbmVkKENPTkZJR19SSVNDVl9TQkkpDQoNClRoaXMgc2hvdWxkIGJlICNpZiBJU19F
TkFCTEVEKENPTkZJR19SSVNDVl9TQkkpIHRvIG1hdGNoIHRoZQ0Kb3RoZXIgdXNlcnMNCg0KPiAr
CWNpLT5tdmVuZG9yaWQgPSBzYmlfc3BlY19pc18wXzEoKSA/IDAgOiBzYmlfZ2V0X212ZW5kb3Jp
ZCgpOw0KPiArCWNpLT5tYXJjaGlkID0gc2JpX3NwZWNfaXNfMF8xKCkgPyAwIDogc2JpX2dldF9t
YXJjaGlkKCk7DQo+ICsJY2ktPm1pbXBpZCA9IHNiaV9zcGVjX2lzXzBfMSgpID8gMCA6IHNiaV9n
ZXRfbWltcGlkKCk7DQo+ICsjZWxpZiBkZWZpbmVkKENPTkZJR19SSVNDVl9NX01PREUpDQoNCkRp
dHRvDQoNCj4gKwljaS0+bXZlbmRvcmlkID0gY3NyX3JlYWQoQ1NSX01WRU5ET1JJRCk7DQo+ICsJ
Y2ktPm1hcmNoaWQgPSBjc3JfcmVhZChDU1JfTUFSQ0hJRCk7DQo+ICsJY2ktPm1pbXBpZCA9IGNz
cl9yZWFkKENTUl9NSU1QSUQpOw0KPiArI2Vsc2UNCj4gKwljaS0+bXZlbmRvcmlkID0gMDsNCj4g
KwljaS0+bWFyY2hpZCA9IDA7DQo+ICsJY2ktPm1pbXBpZCA9IDA7DQo+ICsjZW5kaWYNCj4gKw0K
PiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IF9faW5pdCByaXNjdl9jcHVp
bmZvX2luaXQodm9pZCkNCj4gK3sNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJcmV0ID0gY3B1aHBf
c2V0dXBfc3RhdGUoQ1BVSFBfQVBfT05MSU5FX0RZTiwgInJpc2N2L2NwdWluZm86c3RhcnRpbmci
LA0KPiArCQkJCXJpc2N2X2NwdWluZm9fc3RhcnRpbmcsIE5VTEwpOw0KPiArCWlmIChyZXQgPCAw
KSB7DQo+ICsJCXByX2VycigiY3B1aW5mbzogZmFpbGVkIHRvIHJlZ2lzdGVyIGhvdHBsdWcgY2Fs
bGJhY2tzLlxuIik7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7
DQo+ICt9DQo+ICtkZXZpY2VfaW5pdGNhbGwocmlzY3ZfY3B1aW5mb19pbml0KTsNCj4gKw0KPiAg
I2RlZmluZSBfX1JJU0NWX0lTQV9FWFRfREFUQShVUFJPUCwgRVhUSUQpIFwNCj4gIAl7CQkJCQkJ
CVwNCj4gIAkJLnVwcm9wID0gI1VQUk9QLAkJCQlcDQo+IEBAIC0xNzgsNiArMjI1LDcgQEAgc3Rh
dGljIGludCBjX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2KQ0KPiAgew0KPiAgCXVu
c2lnbmVkIGxvbmcgY3B1X2lkID0gKHVuc2lnbmVkIGxvbmcpdiAtIDE7DQo+ICAJc3RydWN0IGRl
dmljZV9ub2RlICpub2RlID0gb2ZfZ2V0X2NwdV9ub2RlKGNwdV9pZCwgTlVMTCk7DQo+ICsJc3Ry
dWN0IHJpc2N2X2NwdWluZm8gKmNpID0gcGVyX2NwdV9wdHIoJnJpc2N2X2NwdWluZm8sIGNwdV9p
ZCk7DQo+ICAJY29uc3QgY2hhciAqY29tcGF0LCAqaXNhOw0KPiAgDQo+ICAJc2VxX3ByaW50Ziht
LCAicHJvY2Vzc29yXHQ6ICVsdVxuIiwgY3B1X2lkKTsNCj4gQEAgLTE4OCw2ICsyMzYsOSBAQCBz
dGF0aWMgaW50IGNfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpDQo+ICAJaWYgKCFv
Zl9wcm9wZXJ0eV9yZWFkX3N0cmluZyhub2RlLCAiY29tcGF0aWJsZSIsICZjb21wYXQpDQo+ICAJ
ICAgICYmIHN0cmNtcChjb21wYXQsICJyaXNjdiIpKQ0KPiAgCQlzZXFfcHJpbnRmKG0sICJ1YXJj
aFx0XHQ6ICVzXG4iLCBjb21wYXQpOw0KPiArCXNlcV9wcmludGYobSwgIm12ZW5kb3JpZFx0OiAw
eCVseFxuIiwgY2ktPm12ZW5kb3JpZCk7DQo+ICsJc2VxX3ByaW50ZihtLCAibWFyY2hpZFx0XHQ6
IDB4JWx4XG4iLCBjaS0+bWFyY2hpZCk7DQo+ICsJc2VxX3ByaW50ZihtLCAibWltcGlkXHRcdDog
MHglbHhcbiIsIGNpLT5taW1waWQpOw0KPiAgCXNlcV9wdXRzKG0sICJcbiIpOw0KPiAgCW9mX25v
ZGVfcHV0KG5vZGUpOw0KPiAgDQo=
