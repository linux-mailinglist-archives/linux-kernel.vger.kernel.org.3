Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0C250824E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359851AbiDTHkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350256AbiDTHkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:40:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D8012088
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650440236; x=1681976236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IyytIa6TPGM/v+onGsCglA1LPucipJJzXkr9kx8zaBg=;
  b=urkYFgFJ5I4Lt4w11+Cyn7is+3PgLXoXhPy90f0C9YmvT1mwPs8Hscn9
   IUstMVYM1kvlu87UV5DRzBe5WHJRoVNiJ18LZTqNxh061vOwzLaTws+VQ
   0fe9vKWZRn3GNauF9hdHZK0s6ZRji+69s80s2iV/RTi02bMmDMYqRSi7g
   uSag0ISYcMvI5gHsBOCDYoWcjAVwgrRft/iRImZz2i/7Er6T1/XX7d87C
   BR6h6ydqvNXr5y5cIdBtuHkwV0lHM3OuFrNP2HhbwRLGtx97PBadomo7R
   scrUI54n/Gd6TR+wtljMzr8xmHHZTjSwa3fFXujPzXX8a3iNARLldLxzU
   A==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643698800"; 
   d="scan'208";a="153184611"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2022 00:37:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Apr 2022 00:37:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 20 Apr 2022 00:37:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5OYFiRSNfuoLYctUNkMvEzgStivN9s8wMuKD/IkcrkA1meJF8qhqjEzWl7rcJcK+CRJbLJX+bSVVPHhH9P30210DJmGbpRmMWg3QEY5zywttgKlJr+T0Pna4i1iR0ApieS1ooSl0bxWzQes8Eq4QB+acyUHJUrr6ETUONQsK2kO+aPCnKpjpUtDkh73jy2L3QmzyRA/FlBk4XBVNVW4dkL+8AxPpvTfSfxlk2cPy2rizJMvWonQMWY3UjdjVow4l0kolWjcEAvTgoiFoRIfkreDUbdGAC/sBeyYcwIMF1ta/DB2VB5uTGPSCuxH+5nwFT4MxXEN1jFEUzlsHnzYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyytIa6TPGM/v+onGsCglA1LPucipJJzXkr9kx8zaBg=;
 b=UAw/hw3o0Ia0YyPrBRmiDV+KFd+IGewmfz3UXm6Jv4fIWA8zHy3s/B6WpgPE/ny32glL/Q5VhN0TZKH3+g4JL1BEoGRwLzpxs5iNH2l3iJhSx0ZSiDKgaHXD6vlomspG7Vlwf4j/KFZAiD0RfrQSZTroaHau64qLPaSWpGzeqYrTQdJhbuDV+f8CzrGxgbdP5VdRVxDDwLsN2SrmrCABJLN7NrMSnr6u7xfVbKUCs+BUgTT48BjdqV3/V8H1t0NsOaE0ZrF4I6gVKYQ0sRE6m/HTeFZ8Xtv/ml2xbCJwbFKmJJuhXPNQFszealAenP+xSFAy6ohWXyEHItPH07BOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyytIa6TPGM/v+onGsCglA1LPucipJJzXkr9kx8zaBg=;
 b=sVM3KINWckdPPONzcHsmhn2mngaQmgUZP6gjtOD+yMq2HfWaLWvkGra+cMiWGemZSvq1RFxSBfXtA49QlMZHY9tbkl8M5n90rror9kzKjnRpiJQdcagK/qZMgIA0fnVwBYlinAAsCk2lxHJsdopFqhhTUCGgK3EiEuCk3FlGzjM=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BY5PR11MB4370.namprd11.prod.outlook.com (2603:10b6:a03:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 07:37:09 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00%7]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 07:37:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <michal.simek@xilinx.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH] mtd: spi-nor: Introduce templates for SPI NOR operations
Thread-Topic: [PATCH] mtd: spi-nor: Introduce templates for SPI NOR operations
Thread-Index: AQHYVIlwY/7kSmK8TkCTUnmKCS036g==
Date:   Wed, 20 Apr 2022 07:37:08 +0000
Message-ID: <30d1f956-c196-6744-3dd7-7217c3298645@microchip.com>
References: <20220304093011.198173-1-tudor.ambarus@microchip.com>
 <20220420063231.kdtppbpwceiyfocb@ti.com>
In-Reply-To: <20220420063231.kdtppbpwceiyfocb@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1d2389f-4b82-4723-2370-08da22a09377
x-ms-traffictypediagnostic: BY5PR11MB4370:EE_
x-microsoft-antispam-prvs: <BY5PR11MB4370750A26B6482F59F0242AF0F59@BY5PR11MB4370.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M5G4zR2E+Z2rFf//+6GQSMnEe/+6DWdJE2mYErsLn/MnXYPIN9+jeQLqkLQDYRGxMTnLy5C1JpFeK0cHB9YKrXl6GKyqqepEBq2s9iyTkQ9/1DGmSfhAOK/Hm5MfKGqV0DKoiQU0LnKJIFeWrF5pRDYs0M4HLK5AN+F+oBiDcribUUz/D7Rb3LofKfyqWC87zxT3cU65QQ/vC6H4ILKs2dSRxUaDseDmC/HyBuEzSKo8+8fakMfq7OUzsnm1KZvr352cAx9z5MPEBLT1Cxe6nv3Tga2M5ARy9Uw9hrGC09VJDSN0Qx0RtfsVmISIXPsMqJqn3sg0D/UJM5JLVp1QyQ5ZuZORQU/CFmXUk20oUGRWTfZckXGsMB+OCxAxiRI7BpXNLetyNGjvW3oRxPNIVjfUlXXjM6ixRIPhzpqjsIlQtZ7clPkBrg/Np5bYwPmNT5XSorab+V3efh+K68k3y4+CBzN6KQ+qsTppE0zJwM9DvxIRmhYt6wSfRDEUcsUXEv0JeyfGlpBBOFGtsGiQ9fooseu5/Zzoc2+vqKna+ZWebIdbL6/3VFD+4h4kGXFBmM8Xc+tZUkkNc6s9NoeI5WiCFbw18nBb2tKtL91DHJaEJFWQ2IFVrYSIQQPGClHzWExem27QSaxYGQv49Rf9eC5N5gMFzfqq1xseG5jLOx65FseWSLS7R+NSXiMEFDGBlXM+Sb4LFR8Bl24Q23LkvLEEXA7IFs432YN01UqbbFrwkPzpG6qom8OJLvN2TZQlCl0KWkVU4A/DgQ4Hjlia2GzJCBfqvhjyOsQLXo59Be1rBeYKMZ2J83j2DpGUCm5Jooarcem3JrSV81Z/XDF/1H5//xNR1P/3wcdgS0aA/mg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(53546011)(38070700005)(38100700002)(6512007)(36756003)(122000001)(76116006)(6506007)(66446008)(4326008)(186003)(31686004)(66476007)(8676002)(91956017)(66556008)(8936002)(64756008)(316002)(66946007)(2616005)(54906003)(86362001)(31696002)(6916009)(83380400001)(5660300002)(508600001)(966005)(107886003)(6486002)(71200400001)(2906002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVRIQWRrRktvWU96SzlId2Y4TERybHpjY25jOTlGSkFhOW9lM2FmaVRwSy9a?=
 =?utf-8?B?RmRNcy8rZVYzYTRvM3A2a3p2SFl4Zms2N2N1SGxkdkNwWVRKTFlPTklkdE40?=
 =?utf-8?B?WHFCV0tKNGFxWXNnTk96YmhWZVk4c1gwclhTbHJsMHNtVkZBZG9uWTJWTlha?=
 =?utf-8?B?RUtVVzltN29hYXl1VmRWV084U0kxWlo1Q245aWJqZy9qaGJBNVdlQVhrMXhE?=
 =?utf-8?B?YktCTnh5SHpvUmhHK1F4b1BrYWw5U0VLbEI5QUtkOGtTTUwxOUV4R2Z4M2JR?=
 =?utf-8?B?MXBFRDEwTDdzd0p3S2JPOTNKbXVnZUlPd3RKYUZNeTJMY28rakZCSGpDTGx0?=
 =?utf-8?B?NmkwckVVNlVVeHlKWWEwampnaDFtUEJYdFJ6djhCeDNtaTFGMC9nUHpoRDB1?=
 =?utf-8?B?SlRLVHZQMlFtV1NkTkpJeEUvRStYanEwSDF0Y3dxMk0zREtMb3hjcCtsYm9p?=
 =?utf-8?B?YUpMVUd6amhka0hrZTVhZTdwc1pMTi8ybktpNWpwdXAyK2t2ZmtVU0FuNlhk?=
 =?utf-8?B?a2loWVRpcVhscU5zdGkrQmVqdWNtd0E4bGFoenhKYjVES1cvVEtuczhNUlVL?=
 =?utf-8?B?UEF5cEUya1pWUlpZZTFvUU1yTm9ha3J2YlpaZ0hpQzcvYzZzWFBvZ2Q4T0RP?=
 =?utf-8?B?akZOOU9LT08rZmNHQnhuWnFkNGxQZStOWW4wTStlNlpqcUZTZm5Ra014Wmxt?=
 =?utf-8?B?WUdCNnRQQmF4YkJoczA4aDhkQUFjYXAzbjVaT3NBNE1aM0NnRkdQdWtSYjll?=
 =?utf-8?B?MitpLzhLMm5MLzMwVnl1WHdscDhTVTRNVjZVTWFRcnJHQmJSTHFhMW4xZEhm?=
 =?utf-8?B?djBhdjhPQmNXeFQ1VG83dTNtRUg0ZWZ5ckYvZm1sdEpsbGVOM1FMM1FQeDNJ?=
 =?utf-8?B?STNtcUtGZFB6d0lSZjVJaXdhTWdMSk9sbnlnQmJ5TkJCRmlaT2NUYUNsNERh?=
 =?utf-8?B?ajVEQms0K3VteHFuLzhBeTd5NXkzVytTd2JQdXFZZmNxcC9HUDg1TkxacG1n?=
 =?utf-8?B?M2k4ekk3aXNhS1hiOHcxVWpndnA4RWpkYzJxcUNxVEF4WjFUSFE0aEJQaHJ2?=
 =?utf-8?B?anBMRTBhNnFOMXo1cGpSS2U1Rm83ZnlqOHJUNU93aGxKV21tenliOHBKUExq?=
 =?utf-8?B?WllpOTM2RVZzbXBveHhBbkxEb0FWbGlVSng3Szh2MllxSkl1L05TS1dlTmY3?=
 =?utf-8?B?L0psMUcxRVhyVnRLZXZ3YUFlOTV1WENadnZIM2Zub1JJMmNhUDFOdlp3UVRL?=
 =?utf-8?B?TGhQeWcwQUR2c2Q1RFlad0R0RnJmTU5hT010OWE2RWJ4YWV2cHJiczV6SUJ1?=
 =?utf-8?B?S2lWZ2J5c2lEWlVobVE3VXp2bEhiMHdKZVo3QlBramN5TmtDUkhPb3o5b2Zp?=
 =?utf-8?B?QmNDYWxGVXVEWDN6Yi9uV3h0aGtuZzRkVnlnd2RpVmdNTFdyUkJiZGV0ci8y?=
 =?utf-8?B?N1NnME83OXpEVkNTeUcrZzhmZitES2ZORVZaQi9HcFI0WVNCZlQ5WUVCZFFR?=
 =?utf-8?B?T2cySU5pMWJlS1FzR2ZnUEdBYnNOL3lIaXpKTjd0eVkzMEE2L05wZGRSeFU3?=
 =?utf-8?B?ZXZZbVlFN3RVdjVqR3YyVTZUV0JCVTRNeEFYY21leHIyWEU0MGFSa3llR3Jr?=
 =?utf-8?B?NENpSGpFbE45SDlOS0FTdGd0Y3JDWWlPK2xrSkZtV2JxRktYbFN5MGhxalU4?=
 =?utf-8?B?NFlRdkhtdkVpRVhBdjV0SWZLakxEY2hJbUZjN3NMVUtjWEQ3K2RhRDJVQWpw?=
 =?utf-8?B?Y1l3YW5oNkppL2wwejRTTDhFQnN2WjR2UzlhN3B1cGpHY1FxcC9wbWo0clU2?=
 =?utf-8?B?UXo5K2VBQmloL2xsWEs5d3l3SzZKbjdHNklwZVVLZmZkRlVobVNRUmZtT29v?=
 =?utf-8?B?N05vanlEendpNExPSWtyYU1HRkdsa2pzR0QxdVFmVlZXK25kV1VFZnJvVlRh?=
 =?utf-8?B?NEIvY0QxTnpRMkxqSXBUaE9jaS9aaFdiVCtFQkQ2NnZUd0QxYmd2emFiS1lB?=
 =?utf-8?B?T3pQUmw2ZUxEeDJqQkFLY2duV1F3ZUpMdGFvQitlYStPUWlJelZ1MXFoZjVS?=
 =?utf-8?B?NjFlcjBGS1EvRUtGL29ENEVlVWMvcmVuVFNBcUJHazVseGd2aVk5VFp2QVNV?=
 =?utf-8?B?YTg5NUNQZFdMS21jQ2lWL21qa0JtMUlJUGZBNlkzTHBiR2lhVHREOWhzdk05?=
 =?utf-8?B?UHVpSWtac05vYkh0MW1Db2svaERUaWIwS2Z0UVVuMGxDR1NIRi9WTUVmY1Z6?=
 =?utf-8?B?L01OVW5YMXlWY2lQR3d4Y3dIVDBIMmlRcUdvTndWOXhwTERVZ3p4ZWZGVkJk?=
 =?utf-8?B?MWR0cC9nLytpZ0dyTFRPcEJlaGdIWVAvbFkvOTkrRHdwS1NGYy9FTDZxK0Ir?=
 =?utf-8?Q?aA/FWnir3Rnkzzrg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE943053F1085B4395C2F76434450FA9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d2389f-4b82-4723-2370-08da22a09377
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 07:37:08.9891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sv3FcQB/2M0SAyUvyUOAs5xU9E0IScVBzVsHGEWXmhFZ5CFO0qRpqltG3pAG9sIUudTieiZQtQ87Ar4M95xDaPSGcc/6DemLL2mBmJJJEUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4370
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yMC8yMiAwOTozMiwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMDQvMDMvMjIgMTE6MzBBTSwgVHVkb3IgQW1i
YXJ1cyB3cm90ZToNCj4+IENsZWFuIHRoZSBvcCBkZWNsYXJhdGlvbiBhbmQgaGlkZSB0aGUgZGV0
YWlscyBvZiBlYWNoIG9wLiBXaXRoIHRoaXMgaXQNCj4+IHJlc3VsdHMgYSBjbGVhbm5lciwgZWFz
aWVyIHRvIHJlYWQgY29kZS4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgZXhwZWN0ZWQuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29t
Pg0KPiANCj4gSSBoYXZlIG5vdCBsb29rZWQgYXQgdGhlIGNoYW5nZXMgdmVyeSBjbG9zZWx5IGJ1
dCB0aGUgaWRlYSBzb3VuZHMgZmluZQ0KPiB0byBtZS4NCj4gDQo+IEFja2VkLWJ5OiBQcmF0eXVz
aCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQo+IA0KDQp0aGFua3MuIFBsZWFzZSBub3RlIHRoYXQg
SSd2ZSByZXNlbmQgdGhpcyBwYXRjaCB3aXRob3V0IGFueSBtb2RpZmljYXRpb24NCmF0IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW10ZC8yMDIyMDQxMTA5MTAzMy45ODc1NC0xMC10dWRv
ci5hbWJhcnVzQG1pY3JvY2hpcC5jb20vDQpZb3UgY2FuIG1hcmsgdGhpcyBhcyBzdXBlcnNlZWRl
ZCBhbmQgdXNlIHRoYXQgaW5zdGVhZC4NCg0KQ2hlZXJzLA0KdGENCg==
