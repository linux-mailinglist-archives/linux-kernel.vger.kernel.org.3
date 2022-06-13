Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E235498EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244455AbiFMOzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 10:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386616AbiFMOyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 10:54:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F439CA3D1;
        Mon, 13 Jun 2022 04:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655121393; x=1686657393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8Q5Vi8/J5qbKKRMZA691TAPtHySSM6q/h6jOv0RQgGw=;
  b=nVm7hUuG2MoXbslsDfqagkKlqXgn7y6xEjvDU61oRh/w36Wm+ffQKdjt
   73JXwDsWOSBtt6R/meyygwPLFCNOSraZF+SE3Z+BOKa312PWiJCQohOHQ
   5filSKdqWeUCDWS20p+Md2n82VZeVPvsJIZbdvcgkfXveKYpqLlHHuh/M
   lqmDaQBCr3rTFQgi3EHaR/Qul0Y2PxDF1U5T2tvWbvHDbGHAM6gU+mtGf
   KzLK2Oj5YHEkYikdyGu5QPRaMLOGgfegmgTGFnp3SKwtyASPaqvmRJUAW
   JwcBblUpr+hzUbfPzX4hU3pp7MNNhwkohTzQNOHd7CRGLv7iwSm2gXlTJ
   g==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="99743306"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2022 04:56:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Jun 2022 04:56:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Jun 2022 04:56:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQW58vAI/qZT1/kCap8DC0puMEf/94LS6esakgTCJqqG5mrrLQDsR/XQvLH5iPv+Ao8+dRRpq01EwcvlUxPiwFm1Y3Qa+UAVGCpvIUfKOTHZYKxqoK4lR5CogSZsTuMfpqEUbEHE73upPJltsfXnRbb5oCWM1HmQwEV4N8CZ3xaqFZt4Nu1OL2USBHkRgbadWbFij8Dw4f7sAds596TQBbTqjVEt7mwzcRmMHrrsUbKykwjAG09wXAx8g25It4OpY340eqrDubar0xOPKHWZMudTylWbX8HPW9DxI+hgYSg1/vxkd8M9RgJit/rPWW2fqnOUYsxMjkuLbwXMHWjImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q5Vi8/J5qbKKRMZA691TAPtHySSM6q/h6jOv0RQgGw=;
 b=oLOULw3ivfugL2Ign4WCS8yvP+AV6vxGv+2Fm3tkqKBTBaMiKzHmx9AOBx4I65FADI/ruOQCzowZ7/aCi9dUpAuR8mC2USqlC1W3yowPK8NGnAd8wU5hEaaXFj4skb8QZYpWs6RGxNjm9mqZrguXDAP6ZpVpgtaQUvo81cGxLVw3DLhmY32shhACWkKgkfkGCW3aYovTy/Jnm3x+GDcnOzGE4UC1uPCnBzbQ9ypc+YvUQwjSK2n6xIIzA7JSGGKhkDolKhfVwKSqUHUty3U5YJ2H1sUe/Ys4gvFOroQLaCJAPSdmqlzXHRNEFJ8Rfo6rHgsTpFYq30F2Ga1/5N55pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q5Vi8/J5qbKKRMZA691TAPtHySSM6q/h6jOv0RQgGw=;
 b=apq6iz936rC/t+f4dsOyA6sCZ4RpzAFnDQJlUfWqPtJlHuVQnLCxPi57VuBwhHUyeHkGJ+1Y2kPPaCFn6Jt+NFYrRLPJhaK1KBTo/WcbOar5LEWYO5SG6VKGnY2VvyCfxSyoCwzxKsGweflhEKsYCNc7Trt5t/INFtP71GHRPSE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3755.namprd11.prod.outlook.com (2603:10b6:5:140::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 11:56:07 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.022; Mon, 13 Jun 2022
 11:56:07 +0000
From:   <Conor.Dooley@microchip.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>
CC:     <Daire.McNamara@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <Conor.Dooley@microchip.com>
Subject: Re: [PATCH v2 0/2] Add support for Microchip's pwm fpga core
Thread-Topic: [PATCH v2 0/2] Add support for Microchip's pwm fpga core
Thread-Index: AQHYfxeOm1EkCb4F8E6fiUEwN3NvnK1NOoMA
Date:   Mon, 13 Jun 2022 11:56:07 +0000
Message-ID: <4593d704-7f7f-83f9-8fce-2e691d8ba580@microchip.com>
References: <20220613111759.1550578-1-conor.dooley@microchip.com>
In-Reply-To: <20220613111759.1550578-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff1356bc-f070-4077-97f0-08da4d33b36a
x-ms-traffictypediagnostic: DM6PR11MB3755:EE_
x-microsoft-antispam-prvs: <DM6PR11MB375565324FB288E303583C5498AB9@DM6PR11MB3755.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73JImKjLN4PpDJzAfH8O8nT6v77IQXN9AtK/++sCyG1zdWN5MBmg/MLfv4sVtIgAEeX6oMzyloKq/HiGOcVYsCB0QK/JzBRmxlGrGf/IYyPDD2CFOwGbtv3wpPcJtRh+mGWfb+6r8aBqA4FmjfoUrp/UZ+pEvomASUMo9Kkbs6ln3lSJu6xG+tZIUY6pv+z/YjontzTx1n4aa0LGE1G6GMkzznSJmo0Jryk0L1km6O/6dfKibEXFYftzet72ipIQnkJLqHQD16OY1D0KNrCV66C9x1Kgwho52mAUe+r9R2L4jD4ctZUHGQr/remP2WPUVqVHdfKgpmN1Wj/8rknZOroFWw+SIQ6ske2xHwJ+ZW/DIMl2psWmhQpSZrN0R4TrGOqDJE3YIBFctu7z8W9RrTWNoBqk0kv/TmN0218mAiHLWOkBrQDcONIkou+tZx2xss1lhvRbPXCS8/6GCbXYGgZYp/M2uueeTaCV4Kzduj7T8hCvWjohTcxXgT3sYHERLAKbzQN1g7f19g3OePJMeLk8/rrK1kUc65jDgeOEHhDqWO1qz3pMp7Lqjkh78YpnxY5aFzfEpxWc0Sb+Y2D5Vv/LdIg86TCrkSVuhTUIEdP9awwVlIJnNHVjn7tOO0V8T722r0pHduCsbCWSC8ajlot72jPCxoVoQxDZqbrQqx+H/R5F37YNCHiZ/iZUcyjnqUBhY/q4UDb7nDaKBzQ73eybDJUt/FL1sT0kWg2lwbghG6Ie9na/f/GxrPA1r5/73m9i9mG6FS8zJZnRBgMhwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(186003)(31696002)(86362001)(83380400001)(71200400001)(31686004)(4326008)(8676002)(66476007)(64756008)(91956017)(54906003)(66946007)(36756003)(316002)(110136005)(76116006)(53546011)(6506007)(66556008)(66446008)(5660300002)(2616005)(8936002)(6486002)(38070700005)(38100700002)(6512007)(26005)(122000001)(2906002)(508600001)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anJ5bzdMNlpWS1RCTHFQeHFScHcvV3RFV2dkTzdiRkp2a1R4ZVFaVGw2dEIx?=
 =?utf-8?B?UW5aZGoyZTIrU3BlYUo0UHZBaXlQM2E2a3RaeHNOaGJISHhXSnNldWVsY3FU?=
 =?utf-8?B?ZW1zeTZYKzFNd2VUS3F1SmZRWnBEaE1Ic3I3UmVNMDlMa3k3NjFlRnp2ZURy?=
 =?utf-8?B?OHB5REcwRG9NL3lweHpxcnpaK283WHBETFNLRHQ0N3NsNHVPa29SZkpoZ1dU?=
 =?utf-8?B?RzdVRW94cDFmNnlBdVgyMEV6WFF3bVgvMEdydGV2VzVLMUV2UjliZU9uZG5o?=
 =?utf-8?B?QytTZDA2VUlhY2FqTXhYLytZNlhhelFzRUFJN0xCMDcwVHJpTkRjZ1JvQTla?=
 =?utf-8?B?TFdkUTI3TkZZWnFrWm00bDlyY0ljcEZ4TlVPb2g1d25XSXdHaWZHSjJkK3pJ?=
 =?utf-8?B?TitJSHcwalZPdXJEblVaeW5qRjFPdzBnWHM5NHM5c3ZuU2toUnRXU3FCWDNv?=
 =?utf-8?B?OW9UVkF6b3haNU5jYjNUcVd1aFoxOVJ5c0JIOXhZL2FSMUZKK2Z6SUhZWklK?=
 =?utf-8?B?UW1TalhmTlZzcGo5OC90M2NJQWtFL2svSlZXeHF0cFU1SjQxd1gyMnV6cWla?=
 =?utf-8?B?MVFzVURJSHlaTy9Eb0ZzV3UrR1JRS2JSeEdocnpIdERYZmZ0WlF6VVE0K2RZ?=
 =?utf-8?B?VTJWWEtXdXYzTUNGR0RvL2ZTaXZFbmZIenZXcFVLSVhFOU1UQ1lQV3RyTUNK?=
 =?utf-8?B?YTRDbGNhbFIxbi9YYThNS3NSdXdyVXdWNE9QVVFNK3lSTTk2SndiS00xZTBz?=
 =?utf-8?B?NEV5dHF0QTAxd3pwYkhFak1oWTVIVXpqQmhLOFh1WHZ4TzhxWU01eWtNNzVk?=
 =?utf-8?B?OU1NU2lPOHZyWGVyMGR5R3lvRkkvckxES0NzMUVtaFkxK3k1bFBGSEN6Tjls?=
 =?utf-8?B?Q21aV3QxVUQwR2xmWmg4Mm5EdXRMckxobUdTR0RYamU4WUVFV1RITFRMbDZG?=
 =?utf-8?B?ZndNVEpMa0tTMTNjOVRQblQ5TGs3NllFS2xqbXV2Smp3RTUzUU5KakZGVE9t?=
 =?utf-8?B?aVgxZ3BFR2NENzlxMUlTZENiQTdMQ012T3hjZW9BdkhaKzY5WUczQmtMaTFG?=
 =?utf-8?B?M2ltc3pPanM1NGN3UWNPdW5TaWtHWGRmemZhd2dyc3hMbWlzTmk3RFlsbVla?=
 =?utf-8?B?cnQvTkR1YUtqYVcxbzNtL2VuVzRLbGt2a0ZMUTZrMkt4eEF0ZXJsT3ZmU0tr?=
 =?utf-8?B?TUdvdWlYeWVnT2FTUk41VW41RjRzWnRHNzV5REdvcjVuTkpYa3NFdkhERnhM?=
 =?utf-8?B?MUFwZUZyVDd2VElGVURFb3UvWkNpaWs1cm1oaG5mVVBjUnRoeUxNMkVxY3Ny?=
 =?utf-8?B?eEYxLzBObnZFUXgraGlteXczRVVzTUxDdDV0ZjM3UmlqbExNTUs3Tml2ejV4?=
 =?utf-8?B?Nk14ZDF5UjFiblI5U0J1UEphSnRjQkhxY011eHFzeStZNmpMR3hTRFFtZFIy?=
 =?utf-8?B?Z2x0dm5sV1gvTWptdUJMUElBOEdLMHlhYWRLUmFjYnJXcTROUFZHN1VXS0c3?=
 =?utf-8?B?YXExaXppSHNNblNBNXBoTFBVWGZjZnFMVXlINXZkMGszVzFYTlltT3I3SENa?=
 =?utf-8?B?Uzd6UmJKVGp3NXpGL1ZSaEJURlAvVmZoSVJmQ1AxU2N1RDE3UkJhMWFxYnNr?=
 =?utf-8?B?ZVU4T0JMU3VsRDU5RjJsVy84R201VVF4czFYSGE1R0JxejlDRGo4MjRTSmd6?=
 =?utf-8?B?SW1qMGRNUllnaFlWSTJPN3dqUEhrWEs2TWFwUkRNN3g5QWlOdGYvNlRpTlI3?=
 =?utf-8?B?bmh2bnNDUCt1ejZsbUZNR1E5cHY0ZHZFRSs1bk9Vdm5iUFQwejlhYk9RQjhn?=
 =?utf-8?B?YVU0OGpSRTYxUVBmK1ZtMzRnNjVSYVFZNDAxdnp0MTQ1Uzl1OFV5aFVEOGhx?=
 =?utf-8?B?Q05manIwcjhkNUQ0UWRza2FkS0k4S1lhbnNBUFBheEZDYWhWS2E5NXJXTDJp?=
 =?utf-8?B?b2E2Wlo3Q2JSOERLSVR0OEpmcGxKQ0ZRTlRKVnVmOGJxQ1VsYkwzS05hSCtD?=
 =?utf-8?B?K2VWN3Q3Z2I5TmZNY20wRjlFcXNEbWxadWZ4MTZrRUlzRERiYUh0eXdLcE5j?=
 =?utf-8?B?aTRsa0t0Qm9yRUNMa3pLeFYwYUxKM0JCZnFxQkxGYjZtYnBTQ2ZzZUxOQUFZ?=
 =?utf-8?B?cjg5Rm1jTzlqMVNaeFNNVWxablBnQnlxNHpwdEM4SFBTNStNbEI4THRtemNI?=
 =?utf-8?B?TGJ2ZzA3c1BXVmVJYTV5YjZWNW1BT0hyZmxwUFJZTVdETHkwQnc0aXZ3NkZa?=
 =?utf-8?B?dHRMa2lIMktrZktPRFdmSkp1dmxpRFFtdWtGOEUxcG9oS2FPZ3FWODhGM1RL?=
 =?utf-8?B?ZU44R1RIT2ZUUldxMlU3SlJmQ0lDZ0dkRlhlL1cvK2x6MFhnZXNGUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79D8A338D847A2468C38A1C7541B46BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1356bc-f070-4077-97f0-08da4d33b36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 11:56:07.4486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YyaEMgGW8W63WF/dxVLbwd6ECd+l9FsJHNwjTklD9ICjS8OKn4EZJJc9vLx2CmKNP8n5Ea4DPxOAMgjvFDyVsBy60XTmpMI3kQXOb9dJfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3755
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEzLzA2LzIwMjIgMTI6MTcsIENvbm9yIERvb2xleSB3cm90ZToNCj4gSGV5IFV3ZSwN
Cj4gR290IGEgdjIgZm9yIHlvdS4uLg0KPiBJIGFkZGVkIHNvbWUgY29tbWVudHMgZXhwbGFpbmlu
ZyB0aGUgY2FsY3VsYXRpb25zIGFuZCBhIGRvY3VtZW50YXRpb24gbGluaw0KPiBzbyBob3BlZnVs
bHkgdGhpbmdzIGFyZSBhIGJpdCBlYXNpZXIgdG8gZm9sbG93Lg0KPiANCj4gQ29kZSB3aXNlLCBJ
IHdlbnQgdGhyb3VnaCBhbmQgc29ydGVkIG91dCBhIGJ1bmNoIG9mIGlzc3VlcyB0aGF0IGN5Y2xp
bmcNCj4gdGhyb3VnaCB0aGUgZGlmZmVyZW50IHBlcmlvZHMvZHV0aWVzIHRocmV3IHVwLiBBbG9u
ZyB0aGUgd2F5IEkgZm91bmQNCj4gc29tZSBvdGhlciBwcm9ibGVtcyAtIGVzcGVjaWFsbHkgd2l0
aCB0aGUgbG9uZ2VyIHBlcmlvZHMgd2hpY2ggSSBoYXZlDQo+IGZpeGVkLiBJIGFsc28gYWRkZWQg
YSB3cml0ZSB0byB0aGUgc3luYyByZWdpc3RlciBpbiB0aGUgYXBwbHkgZnVuY3Rpb24sDQo+IHdo
aWNoIHdpbGwgcmVzb2x2ZSB0byBhIE5PUCBmb3IgY2hhbm5lbHMgd2l0aG91dCAic2hhZG93IHJl
Z2lzdGVycyIuDQo+IA0KPiBPdGhlciB0aGFuIHRoYXQsIEkgbWFuYWdlZCB0byBkaXRjaCB0aGUg
bWNocF9jb3JlX3B3bV9yZWdpc3RlcnMgc3RydWN0DQo+IGVudGlyZWx5IGJ1dCBoYWQgdG8gYWRk
IGEgc2hvcnQgZGVsYXkgYmVmb3JlIHJlYWRpbmcgYmFjayB0aGUgcmVnaXN0ZXJzDQo+IGluIG9y
ZGVyIHRvIGNvbXB1dGUgdGhlIGR1dHkuDQo+IA0KPiBUaGFua3MsDQo+IENvbm9yLg0KDQpBaCwg
ZGFtbiAtIGZvcmdvdCB0byBtZW50aW9uIHRoZSAzIHNldHMgb2YgY2hhbmdlcyB0byB0aGUgTUFJ
TlRBSU5FUlMgZW50cnkNCmFnYWluLi4gVGhlcmUncyBhIGNoYW5nZSBhbHJlYWR5IGluIHNwaS1u
ZXh0ICYgYW5vdGhlciBjaGFuZ2UgaW4gbXkgcGF0Y2hzZXQNCnNlbnQgZm9yIHVzYi4NCg0KPiAN
Cj4gQ2hhbmdlcyBmcm9tIHYxOg0KPiAtIGFjY291bnQgZm9yIGVkZ2UgInF1aXJrIiB3aGlsZSBp
bnZlcnRlZA0KPiAtIGJsb2NrIGNoYW5naW5nIGVuYWJsZWQgY2hhbm5lbHMnIHBlcmlvZA0KPiAt
IGRvY3VtZW50IHRoZSBoYXJkd2FyZS9kcml2ZXIgbGltaXRhdGlvbnMNCj4gLSByZWFycmFuZ2Ug
Z2V0X3N0YXRlKCkgbW9yZSBsb2dpY2FsbHkNCj4gLSBmaXggY2FzdCBzaXplcyBpbiBnZXRfc3Rh
dGUoKQ0KPiAtIGZpeCByZW1vdmUoKSBhbmQgcHJvYmUgZXJyb3IgcGF0aHMNCj4gLSBkZWxldGUg
bWNocF9jb3JlX3B3bV9yZWdpc3RlcnMNCj4gLSBzaW1wbGlmeSAuYXBwbHkoKSBsb2dpYw0KPiAt
IGRvbid0IHdhcm4gaW4gY2FsY3VsYXRlX2Jhc2UoKQ0KPiAtIGZpeCBwZXJpb2QgY2FsY3VsYXRp
b24NCj4gLSBmaXggZHV0eSBjeWNsZSBjYWxjdWxhdGlvbg0KPiAtIGFkZCBDT1JFUFdNIHByZWZp
eCB0byBkZWZpbmVzDQo+IC0gYWRkIGEgZG9jdW1lbnRhdGlvbiBsaW5rDQo+IA0KPiBDb25vciBE
b29sZXkgKDIpOg0KPiAgICBwd206IGFkZCBtaWNyb2NoaXAgc29mdCBpcCBjb3JlUFdNIGRyaXZl
cg0KPiAgICBNQUlOVEFJTkVSUzogYWRkIHB3bSB0byBQb2xhckZpcmUgU29DIGVudHJ5DQo+IA0K
PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gICBkcml2ZXJz
L3B3bS9LY29uZmlnICAgICAgICAgICAgICB8ICAxMCArDQo+ICAgZHJpdmVycy9wd20vTWFrZWZp
bGUgICAgICAgICAgICAgfCAgIDEgKw0KPiAgIGRyaXZlcnMvcHdtL3B3bS1taWNyb2NoaXAtY29y
ZS5jIHwgMzEwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICA0IGZpbGVzIGNo
YW5nZWQsIDMyMiBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
cHdtL3B3bS1taWNyb2NoaXAtY29yZS5jDQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IDYxMTE0ZTcz
NGNjYjgwNGJjMTI1NjFhYjQwMjA3NDVlMDJjNDY4YzINCg==
