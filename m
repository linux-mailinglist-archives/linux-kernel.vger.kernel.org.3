Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C605B14F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiIHGq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiIHGqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:46:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A257AD21C4;
        Wed,  7 Sep 2022 23:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662619570; x=1694155570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vln5LI+vqhf4s7pntgvF/ssMr6HDAHOcp9J4DmbyLYY=;
  b=uPY4g8gRMxRK8Yq7s6/JMm9kzQktcwVv0eZvVfa+5iFDn8CJQEfW25mw
   QoQtTA+Fn/WlgZWNWK2A3gWTO/f5VfTUcPCeRtV1o8xyox3VM1fnvVs0h
   r1gQ4qy9+XgEJ4gUVoHAeogKm7T9DF0HJ/ibZU4/tdOk6rC1qRyh03miL
   igX1ua+m1g/XGrpkL5n27AXC6Oul2DAGUs3dmakb1Z1I3q1owvTtUPL38
   /fFnnq2UkwEaHOq6USPuvl+ootce++Mi9nElMQVOfI8VIfgsqjvxkiS0u
   8Goa2OB3PHfsXr0x0/vNFE8+lljzDzb9Br8RY6GR6CfSPBt8KuYxLgcrJ
   A==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="112686474"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 23:46:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 23:46:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 7 Sep 2022 23:46:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhBtD9Fbhzpa29Li5UU5JaUjdW4V/jJhwBgnesnaEU8gaE7OwaN9QqSIGEScZAbPzohJVKaZEZdfDbo0htq4Ukdt7CuTS0S75ZfX4eh9WLnkiNAWi3GOxp2VJrTdEgFl3ChodiEoxVKqGhwPX6nt7oTtWrS9zM5VI4ROUkriOhS0xvShYXK0B5JNwIi70lLXaBV5zsS7rmhkxRHTFIaQAHFlXuDEMWpvB495OVG/lrhGs2SMV+zPXgtHpBDPR1v6JrgzQVol8SG/mj/m1smXqr7wzxrbpcWtK3++mk1Uu1U02w65WGvFsPtDf2lY2eaFxGt+SLCZhXVyN1nFjgbPAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vln5LI+vqhf4s7pntgvF/ssMr6HDAHOcp9J4DmbyLYY=;
 b=Ha2yRZY3/o1cNynwNpGjLMslE+WT6YJ1nvLDFGeazG0QQI+DzCaOfe27zNLYuwP/KXKjKu04SWeCOkUdVWsGLAmOtXkhgBVwbyKgrFXT6l78+Uhs1qcOOzXx5+LdoGZQU/x/OvqX9vW9vlFl6eiauBX5aVUKiPBhr41iuhAulyhDGRXNND40LpRKFfdwCu8CtSopGeVlJ5X+lqn5eyJNt3vDuxd+7fuuuYG2TrVdD3y7aLwzO1v38j4J6JVzJXCjFl4+tRcA7ugnnI78/Y33+nDfFetVkpDzQQT5RzNfGxXkA81aPMFpnCh7rD2ec1ELkCG3VaGjsp3wr+ozLjVJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vln5LI+vqhf4s7pntgvF/ssMr6HDAHOcp9J4DmbyLYY=;
 b=H/O8hYQ5i5ObEIzPphOpECKtUcULY4pURjTDtI8M8AA9BpKFzD5CRwYRjrRGKlKlYN8zkJhVW5eh8NPQr6+A/Oox2gyhL0bl11oFjQO04won8UDQcfjQvV/6CDA0dOYjkH0vBepfFrupXd4xD5eTIW8JEuCBld2/mqHbsagg/bI=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 06:46:07 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 06:46:07 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 07/13] clk: microchip: mpfs: add MSS pll's set & round
 rate
Thread-Topic: [PATCH v4 07/13] clk: microchip: mpfs: add MSS pll's set & round
 rate
Thread-Index: AQHYw06sm5R2YjJ26U6gCcikco3ZFQ==
Date:   Thu, 8 Sep 2022 06:46:06 +0000
Message-ID: <b7304717-a14a-a677-1a5e-09477a5ac6c6@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
 <20220830125249.2373416-7-conor.dooley@microchip.com>
In-Reply-To: <20220830125249.2373416-7-conor.dooley@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5db4a95-fe75-4c4d-8da6-08da9165ce98
x-ms-traffictypediagnostic: PH7PR11MB5766:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2LwMJTpQfmA1/3O/xXjB9HpjVZRxmDSVBVO8xzkqETjx9tskV0SxLdk/zuypT9izEzDnbO37WCdyH7VntXWg9ZADeOmjjh1eaPLIxHM4y+4ZOhTYrPau5UW8UDuFFbJLVAxKnNlRBMrHO3sAc0dVgPdgx2/arhwZ+RWB72LgWIM9ftRcwAIy8JWqrCiQBhhG5caVwV/g8SEiiphskxeu9Y8br5DyLsERMo/i7PDvacacykBzsM/BKDnA/AIwKBTASbXoUfNTAlXPeY4+fI0iN2B/rdGUzgV9nRRVrEgtJxY7oyuGXuGcmwuSCjqfSJ5wlTOabL1PHKOH3/nkZDhQY9/63UnzLLx9vblq20HJaHjhfYmDH/DCarXQecmBHsQIvBGmrYvpQMAMm0CS+pOh96QoZEvksQKCd+ngMQEUjRlTZBuZg1ENIbvtwLMa1TGrJ6uxKk23JYJvxSNHb9lsrebM9NuvzJEvU0T7N7ajy5xpiWpKCxSJ6lp9hrKqSOVNcK0AMi3v95KFQE1jSZX5fthENBSbJTLKLEL/iZeXSJZ/nkbErucbGv+pllKEZqpfohLx23Wt2Ruw1o27Dndzeu2eetat6BT1NsV/g6lNuHWZ3cAVEj4HoYvAXTeTWHuAFMFFXJVTgQRZtOtZbGB4bSqwwrMUENc9e/FramNoLMj/5O354Xyls5Ow0/Os3dXtCLZR22aZ87OY1Mkb/U2dFtuu/QPXjy/smj88jEEKBhbHJwuCtRVar780wnKv6hJ2N7M4vxlcbyrLmBwKyeXxwy4X7F4UMK4A2K+02qc8C0SPQgUNtga7EDNBs1QZwsu9A+DWDMB1khEW1Z2nd2uakw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(396003)(376002)(346002)(66556008)(110136005)(316002)(2906002)(6636002)(83380400001)(6512007)(53546011)(6506007)(478600001)(54906003)(26005)(7416002)(5660300002)(38070700005)(31696002)(36756003)(86362001)(8936002)(66476007)(91956017)(66446008)(66946007)(64756008)(8676002)(31686004)(122000001)(4326008)(186003)(71200400001)(41300700001)(38100700002)(76116006)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFpIRVZiWmdZUlZXbElqbmVGZmZPeUZXTDl2TVZZdHdqUEZ5eERBLytNZDdB?=
 =?utf-8?B?TDd3YmpERTY0K1FCOGtWVjhOZ2w2eGRSd3c2TklqRE0vaEVPcm9qYS9XMU85?=
 =?utf-8?B?bEZKeitlWHZ4MWZGaGxPb3ZHdmdnSWVtbTI3YXJybDR5VnhQb2V3eEZJVFVj?=
 =?utf-8?B?bjcxcUFDZEM5V0I3TkFEQzgvQzBlbTVSZWU5TmI2Sjl2S1BZbk5tKzZFbDFn?=
 =?utf-8?B?dzZMUnk3NG1jMXVFME1SanpLZ21saHQ5NWZiZ0ZIdWx1NDdRTG5TU01oN0N2?=
 =?utf-8?B?RlJYakxOWUlJQ2ZKQ0dGUUZXQU1CLy9BVTB1NDYyMHpScTNWY0V4NGlrektp?=
 =?utf-8?B?d0lUOVVLTEZUYk03MGNseVBzWFlVN0RhbDBmZ0dXWkl1NXVlOXF2R3RUZTFp?=
 =?utf-8?B?bHVEM3BMTUZMRjJMcnRTMWxHMGRPSjJpbWZMWU12dEpYM2J3cHVSWERhMUJG?=
 =?utf-8?B?NTJ4WktIZ3h0ZTZBSzc2T3RWaXlIQ0lVQm5Sa1BYMlRvN1VPdmtPcUJQaTFq?=
 =?utf-8?B?Umk5dTk1bDZNMGNTZy81cmVaMDZaaEl3SThUYVMxU2FKYXR3TWJYZVdWYndj?=
 =?utf-8?B?cXh2S2QzemhTSVg3aXJnWGEwdjNnRDRGQ1Q2L01adXlGcTFkeERxR1MvK0NX?=
 =?utf-8?B?MU9XK2lWaGRicit5SFA0Smx0QVFvUFEra0xjemY4c2Jkc1F0Z2NENHBnRnJ3?=
 =?utf-8?B?L3NTMUV1cmg4WDhjMEJYb2Zzc0hJVnZpYmZLaUQ4bG4wN0k3MkRQaU5sWHpH?=
 =?utf-8?B?Y3hJZFpjUm5tbzcwaHVjY3F0R21UOWRXYW5KTkNkODlVMEk2Q2xUbm1ZdXpa?=
 =?utf-8?B?RDVoMHk5WUNFR2FHTGlaZVVtVGh1NDFTaytqYU5EQ1JFOE5wTjdPbVlSR2Z0?=
 =?utf-8?B?dDFsdE16ME9IVm5qb3dYTXlmWjZCQ0Q3NEhkWXBRNWRXZ0VYRk5KUDhYSmwy?=
 =?utf-8?B?dWhFWXcwUDdLT0tIRGpOVlQ2WXR0bkFDQXdsQkFJMUVjbkFRbUdrZGR1NGY2?=
 =?utf-8?B?QUtBQmhTaFRmWU05aXFvNjN2T0VBRDdBcGZ3bnU0OStoWml2MTlpc0lEcGEw?=
 =?utf-8?B?dEZ3NWoxWTF0bmU3TVluRVJ3czhnVEt3c3ViN0hFcDRmamt2VXROVUtoVGVV?=
 =?utf-8?B?eHR6OVYrV2ExUWZrbVllSmh4aTlSaUx3dlUyek02STZ4OFd4Mk9UZk5jTmVr?=
 =?utf-8?B?cThNdEt5VzNnT0hhdWZ5WkkxaysyVXVrZEF2ckF6anlsL1VqR0VtM2hQcCtR?=
 =?utf-8?B?Q2FMdzliMVdtbmdXbGdBWVBGY2hMS2VhQzcxNXdvVDZGS1QvdUx6VGpBNEdR?=
 =?utf-8?B?TmRhblMvNUp4MVVxVkYzbUhkYS9nZzkzQjNoWlRHQ1JmRG43a0t5ZlEyUnU0?=
 =?utf-8?B?d044K25tVnAwSWUxOTZYTTJLRlZjd3QyNDB5cERiN3puVmhYZ0NOVzllSlhn?=
 =?utf-8?B?YU01VnJTbndNVjVDdkVyNXNDU0RGVjduOWN6Yzl4OU90VW8yQVVBTjh3Qy9o?=
 =?utf-8?B?Uk9uamJMY2NYMER2aVgyb3o5V1dxYTlOR2JjQXF4L296YU0zN2kvaXpWWGxm?=
 =?utf-8?B?aldFRTJINjRFcDRNSHh6VzNwTUM1b1htcmQvS0g5dnplMDhsWlU4RnBoQjlv?=
 =?utf-8?B?bUg4VVJXZEM5QWx2ZWtOYWJLa1kvRHFXVjZhR1U5aEQrWm51QVpJTGlTQlUr?=
 =?utf-8?B?T0h4T2VKMG5nOFFsT0Q2UjNPbGtlbmh4Wk9ON2tOazdRSGpjQnd1Z1U1MTRV?=
 =?utf-8?B?MURaNWl0V1NyVUVqcmFVRzRMTVJYSjFZakNHeHB6aDI2c2w0bStqejZad2M4?=
 =?utf-8?B?OGxzdTRaV21wMkNqZ0swb3VEWkR1OGlsOW5ITHpGSGw1dEMvVnkxU1Z5WTAx?=
 =?utf-8?B?b1BJcjNKdUh1d1pBRlcvVVdIVlh6Yyt6Z2JtaEk5UGY5c2xoWGk2N2hXb1FN?=
 =?utf-8?B?M1k0R3NXWVFOSldMWjBabVIrQVpoVkFoVWcrVENzcHZEZjFjUERWWVBIOWxY?=
 =?utf-8?B?dXpKVHV4NHR3N0JlcWJkbXVwbFhCR3BxUnYxZTk3UVMydTFScTFKZE5VMW5F?=
 =?utf-8?B?SllVYlhhZ2pweHdzTDR1Ym44MVlSdFpZYWsrL0FMelVxdnBCZGoxTGJSTXJa?=
 =?utf-8?B?cmZQU0I0VjRPaHJ0Ui9xRzd0ZUxOZWJlVDZBb1dSanNoczdKcmV2UW9uenND?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAAD12D67A14BC46B20C32C99751F04A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5db4a95-fe75-4c4d-8da6-08da9165ce98
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:46:07.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lo0zw1OcrH5/dYX93VrDG7JO0kcEJ+wBvITqxKoSUDAkcGYRRQjy9JwmVPgflKsc6Km1k+b2ETn4YOYpbS3jXTKha/bDymryhsXCug8lIMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMDguMjAyMiAxNTo1MiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBUaGUgTVNTIHBsbCBp
cyBub3QgYSBmaXhlZCBmcmVxdWVuY3kgY2xvY2ssIHNvIGFkZCBzZXQoKSAmIHJvdW5kX3JhdGUo
KQ0KPiBzdXBwb3J0Lg0KPiBDb250cm9sIGlzIGxpbWl0ZWQgdG8gYSA3IGJpdCBvdXRwdXQgZGl2
aWRlciBhcyBvdGhlciBkZXZpY2VzIG9uIHRoZQ0KPiBGUEdBIG9jY3VweSB0aGUgb3RoZXIgdGhy
ZWUgb3V0cHV0cyBvZiB0aGUgUExMICYgcHJldmVudCBjaGFuZ2luZw0KPiB0aGUgbXVsdGlwbGll
ci4NCj4gDQo+IFJldmlld2VkLWJ5OiBEYWlyZSBNY05hbWFyYSA8ZGFpcmUubWNuYW1hcmFAbWlj
cm9jaGlwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlA
bWljcm9jaGlwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJl
em5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2Nsay9taWNyb2NoaXAv
Y2xrLW1wZnMuYyB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y2xrL21pY3JvY2hpcC9jbGstbXBmcy5jIGIvZHJpdmVycy9jbGsvbWljcm9jaGlwL2Nsay1tcGZz
LmMNCj4gaW5kZXggNDNjYzk1ODNjZDE0Li4wMDhiNzZkODE0ODUgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL21pY3Jv
Y2hpcC9jbGstbXBmcy5jDQo+IEBAIC0xMzEsOCArMTMxLDYyIEBAIHN0YXRpYyB1bnNpZ25lZCBs
b25nIG1wZnNfY2xrX21zc3BsbF9yZWNhbGNfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywgdW5zaWdu
ZWQgbG9uDQo+ICAJcmV0dXJuIHByYXRlICogbXVsdCAvIChyZWZfZGl2ICogTVNTUExMX0ZJWEVE
X0RJViAqIHBvc3RkaXYpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgbG9uZyBtcGZzX2Nsa19tc3Nw
bGxfcm91bmRfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywgdW5zaWduZWQgbG9uZyByYXRlLCB1bnNp
Z25lZCBsb25nICpwcmF0ZSkNCj4gK3sNCj4gKwlzdHJ1Y3QgbXBmc19tc3NwbGxfaHdfY2xvY2sg
Km1zc3BsbF9odyA9IHRvX21wZnNfbXNzcGxsX2Nsayhodyk7DQo+ICsJdm9pZCBfX2lvbWVtICpt
dWx0X2FkZHIgPSBtc3NwbGxfaHctPmJhc2UgKyBtc3NwbGxfaHctPnJlZ19vZmZzZXQ7DQo+ICsJ
dm9pZCBfX2lvbWVtICpyZWZfZGl2X2FkZHIgPSBtc3NwbGxfaHctPmJhc2UgKyBSRUdfTVNTUExM
X1JFRl9DUjsNCj4gKwl1MzIgbXVsdCwgcmVmX2RpdjsNCj4gKwl1bnNpZ25lZCBsb25nIHJhdGVf
YmVmb3JlX2N0cmw7DQo+ICsNCj4gKwltdWx0ID0gcmVhZGxfcmVsYXhlZChtdWx0X2FkZHIpID4+
IE1TU1BMTF9GQkRJVl9TSElGVDsNCj4gKwltdWx0ICY9IGNsa19kaXZfbWFzayhNU1NQTExfRkJE
SVZfV0lEVEgpOw0KPiArCXJlZl9kaXYgPSByZWFkbF9yZWxheGVkKHJlZl9kaXZfYWRkcikgPj4g
TVNTUExMX1JFRkRJVl9TSElGVDsNCj4gKwlyZWZfZGl2ICY9IGNsa19kaXZfbWFzayhNU1NQTExf
UkVGRElWX1dJRFRIKTsNCj4gKw0KPiArCXJhdGVfYmVmb3JlX2N0cmwgPSByYXRlICogKHJlZl9k
aXYgKiBNU1NQTExfRklYRURfRElWKSAvIG11bHQ7DQo+ICsNCj4gKwlyZXR1cm4gZGl2aWRlcl9y
b3VuZF9yYXRlKGh3LCByYXRlX2JlZm9yZV9jdHJsLCBwcmF0ZSwgTlVMTCwgTVNTUExMX1BPU1RE
SVZfV0lEVEgsDQo+ICsJCQkJICBtc3NwbGxfaHctPmZsYWdzKTsNCj4gK30NCj4gKw0KPiArc3Rh
dGljIGludCBtcGZzX2Nsa19tc3NwbGxfc2V0X3JhdGUoc3RydWN0IGNsa19odyAqaHcsIHVuc2ln
bmVkIGxvbmcgcmF0ZSwgdW5zaWduZWQgbG9uZyBwcmF0ZSkNCj4gK3sNCj4gKwlzdHJ1Y3QgbXBm
c19tc3NwbGxfaHdfY2xvY2sgKm1zc3BsbF9odyA9IHRvX21wZnNfbXNzcGxsX2Nsayhodyk7DQo+
ICsJdm9pZCBfX2lvbWVtICptdWx0X2FkZHIgPSBtc3NwbGxfaHctPmJhc2UgKyBtc3NwbGxfaHct
PnJlZ19vZmZzZXQ7DQo+ICsJdm9pZCBfX2lvbWVtICpyZWZfZGl2X2FkZHIgPSBtc3NwbGxfaHct
PmJhc2UgKyBSRUdfTVNTUExMX1JFRl9DUjsNCj4gKwl2b2lkIF9faW9tZW0gKnBvc3RkaXZfYWRk
ciA9IG1zc3BsbF9ody0+YmFzZSArIFJFR19NU1NQTExfUE9TVERJVl9DUjsNCj4gKwl1MzIgbXVs
dCwgcmVmX2RpdiwgcG9zdGRpdjsNCj4gKwlpbnQgZGl2aWRlcl9zZXR0aW5nOw0KPiArCXVuc2ln
bmVkIGxvbmcgcmF0ZV9iZWZvcmVfY3RybCwgZmxhZ3M7DQo+ICsNCj4gKwltdWx0ID0gcmVhZGxf
cmVsYXhlZChtdWx0X2FkZHIpID4+IE1TU1BMTF9GQkRJVl9TSElGVDsNCj4gKwltdWx0ICY9IGNs
a19kaXZfbWFzayhNU1NQTExfRkJESVZfV0lEVEgpOw0KPiArCXJlZl9kaXYgPSByZWFkbF9yZWxh
eGVkKHJlZl9kaXZfYWRkcikgPj4gTVNTUExMX1JFRkRJVl9TSElGVDsNCj4gKwlyZWZfZGl2ICY9
IGNsa19kaXZfbWFzayhNU1NQTExfUkVGRElWX1dJRFRIKTsNCj4gKw0KPiArCXJhdGVfYmVmb3Jl
X2N0cmwgPSByYXRlICogKHJlZl9kaXYgKiBNU1NQTExfRklYRURfRElWKSAvIG11bHQ7DQo+ICsJ
ZGl2aWRlcl9zZXR0aW5nID0gZGl2aWRlcl9nZXRfdmFsKHJhdGVfYmVmb3JlX2N0cmwsIHByYXRl
LCBOVUxMLCBNU1NQTExfUE9TVERJVl9XSURUSCwNCj4gKwkJCQkJICBtc3NwbGxfaHctPmZsYWdz
KTsNCj4gKw0KPiArCWlmIChkaXZpZGVyX3NldHRpbmcgPCAwKQ0KPiArCQlyZXR1cm4gZGl2aWRl
cl9zZXR0aW5nOw0KPiArDQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJm1wZnNfY2xrX2xvY2ssIGZs
YWdzKTsNCj4gKw0KPiArCXBvc3RkaXYgPSByZWFkbF9yZWxheGVkKHBvc3RkaXZfYWRkcik7DQo+
ICsJcG9zdGRpdiAmPSB+KGNsa19kaXZfbWFzayhNU1NQTExfUE9TVERJVl9XSURUSCkgPDwgTVNT
UExMX1BPU1RESVZfU0hJRlQpOw0KPiArCXdyaXRlbF9yZWxheGVkKHBvc3RkaXYsIHBvc3RkaXZf
YWRkcik7DQo+ICsNCj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZtcGZzX2Nsa19sb2NrLCBm
bGFncyk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0
cnVjdCBjbGtfb3BzIG1wZnNfY2xrX21zc3BsbF9vcHMgPSB7DQo+ICAJLnJlY2FsY19yYXRlID0g
bXBmc19jbGtfbXNzcGxsX3JlY2FsY19yYXRlLA0KPiArCS5yb3VuZF9yYXRlID0gbXBmc19jbGtf
bXNzcGxsX3JvdW5kX3JhdGUsDQo+ICsJLnNldF9yYXRlID0gbXBmc19jbGtfbXNzcGxsX3NldF9y
YXRlLA0KPiAgfTsNCj4gIA0KPiAgI2RlZmluZSBDTEtfUExMKF9pZCwgX25hbWUsIF9wYXJlbnQs
IF9zaGlmdCwgX3dpZHRoLCBfZmxhZ3MsIF9vZmZzZXQpIHsJCQlcDQoNCg==
