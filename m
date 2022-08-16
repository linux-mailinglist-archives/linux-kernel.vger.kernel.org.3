Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0401D5965AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbiHPWx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHPWx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:53:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1CC55085;
        Tue, 16 Aug 2022 15:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660690434; x=1692226434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+b19+IdbgRCLtY1QaX7waWDK239EdZaGHrdvvCIWSeI=;
  b=iXqoEaO5tY5t1gy17pvzGTmpHw0SZwk/N0agMKDGyeE8rX2TOroIpz5M
   x/pBDv/yKnwoDtJYvL4sw8zWaa9g6gbhjDnrAUsI2bocPhI8vSPmX7p0B
   oExCQL4WnlQ7MfWAmoiahU6zbhDQAU/6Xxerk9+CkrmY3LOrtzD5+HXPJ
   pmMo7ZMPmGWo62NJsL6yFuj8qCPb+ww3TAU5PFGlcafrsoGG4S/Mz6zM0
   fHrhK0QhZuf5upUky/nOD/GKlIbnGYr8IhyVz3AzzF5QMl9U006ZwVEQv
   z4mMSbM/VKO1ENl4VgVVCi1Z18g+0Ngiujv8v33lL4DiWakFr/D6vt3es
   A==;
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="172756857"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2022 15:53:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 16 Aug 2022 15:53:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 16 Aug 2022 15:53:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUc1d0dZK6bMbKrUCy97YD8QmP211DTHWWNWQzrKHRa3ploGyDVzG5D9IK62xYHnX1QGG6Fon5y7YIscLdL5PC360Wx3s/9+sAFgxtu73CNzxMvYE426XScaNRR6aKH+sQbav+TcFun1dPDnKEO9MxzU4n3AES8RlGxeQ3PYxC+Bn/0PVTGZzqqz/mllUCsrph+c41Isro6XqaSXMiEaa0UqUKL2Y9vR06VRKubEWBdE1PyI6hcqm8OMeCR8dTIKnCRtPZxjf+ii2oLrFiSHonJH5D9ujD+CaMgrzFz6QtefE55nRTuWzK0uoR0/2JxLvaUF+UXI1KBzFqab2wV20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b19+IdbgRCLtY1QaX7waWDK239EdZaGHrdvvCIWSeI=;
 b=nKhmovuRKuhpij6xET3NQrnjG/mtnLgfFUlYgU1BhdAZjq7Snxw1qZ2Mt8PvetGQsgDDiWFfSoK333rzmnhXegoIaxYw0baBtUYmr5rV8yNobt2iCPcwd0QsUUsLdS0Fke/mIJqSYLRn5cKFhNqn0c7UaqXFIllOLwc9TpILqBtGuXyssb3PRo9oxcmfpUjVqbGVrVka6rwqVf3WN5EKBWkuYAp6jbdPQgoTcI3aFjjz7dbdsQfv19wwLitEs+lX+D4UzL7M0x+aVuw+9ZQzU5j5PFOWovF2Y8HNXxW99MHwtGMx7UD6OXVJ9g7cjKHWF4rKxPsNKnTvivdaV2F0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b19+IdbgRCLtY1QaX7waWDK239EdZaGHrdvvCIWSeI=;
 b=qxbNYeLxLaruxKNHEQv7ZyI4zoKpA1Y92yfayEyUv1dudBdMSvGBCpX5BNKjlTHYKKnlh/W2/T2gugDwCjfDojhR44pJh0+k9g5vTFgNnv4RCOFYpLfZh8+tbm6Z0rS0qb5x7Das8LU4dUtq7Y4d32/T7085xkPBlitwLxY9WzE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3045.namprd11.prod.outlook.com (2603:10b6:a03:88::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 22:53:46 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 22:53:45 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ajones@ventanamicro.com>
CC:     <jrtc27@jrtc27.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <daniel.lezcano@linaro.org>,
        <anup@brainfault.org>, <guoren@kernel.org>,
        <sagar.kadam@sifive.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <qemu-riscv@nongnu.org>
Subject: Re: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Thread-Topic: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Thread-Index: AQHYqOiQvE59vmIAhkiZ1sZQKraNy62li3AAgAAHfICAAQ/4AIAAST8AgAl5hICAATtPgIAAk0yA
Date:   Tue, 16 Aug 2022 22:53:45 +0000
Message-ID: <5abe9b30-274a-8f36-0797-cc0e981c3f70@microchip.com>
References: <20220805162844.1554247-1-mail@conchuod.ie>
 <YvGBYKZyW0B2/wSr@Jessicas-MacBook-Pro>
 <94fe7e46-6156-1cc5-a4dc-1eee78e99bc4@microchip.com>
 <20220809141436.GA1706120-robh@kernel.org>
 <61829ccd-20d7-e2f0-0a6b-bcd0e076b9ea@microchip.com>
 <1d94e18d-7f51-0619-95a9-6ca5fa7d9671@microchip.com>
 <20220816140633.pkjws7n3qxsescjh@kamzik>
In-Reply-To: <20220816140633.pkjws7n3qxsescjh@kamzik>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ade2dc78-3a0c-4923-7636-08da7fda2ce5
x-ms-traffictypediagnostic: BYAPR11MB3045:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7knpef0snTCWqqqFKJQ/gd4lYgn6piZ44qQ5KEY+spAere8oDAKsfdaK34GdymEzk7UEBnVshdPKdW9cim9xhItqZ+iSFtkk/ctWkopSsc7Y0zENuQAlwbHWEGOGVqspvklvQH041v8Lg7taGrXBjl4Pgqss2jvAOT+14158bJcrLyfGE1rgaE78H11huo2TVTraFFij6D0HNMBLulEjenX84tBXAtAmneRqPhYLO1MzrPM967Hltbh6hSLjKr7fZpmuOFX52r8+6DJqhm0xRUnn1PUD9Ta9mN9DPRXlez3hmF8VZw1gzOSSQu45JN7WzJ3Q3vtMszHilj1s9yi7sgATuho4yaPnVujc5/AfZmNnmj4xbkZacusvs/73uYVHeH9NOMQpRs5eHQsDdhhrMYeKNrnoCWE9jh4Qx2e0dGSOAGSqiZfiAAA8EUYKl1ylSDUWKBMncfug/9p645raPrS64HG8jFiEXG8N8B3EPoyuZDX/OJvHKKrqETXOAR+fmv6hkVvneTdvi1fTw/TW3+2x5blsHzSJLoTBbkjlaXb+JkGy4I3nk9AswEYBzfBzrlbVpqAAjgyaZ+T/c7CpntM1XKo5pwUMWpy+5IURLgoIOgd1pDdbbzyZd112Ei1akh4rZnzN8bp2Fzc+lhqx2Z9VtSidcKmHyUrcbtCC2eY/Sh8By5gIUC0hZkqnpw48jBm7Z28/KmzltveO8PMCTYKRlS3642OZUSg6Z9Kx6/0M9pZ369+9LsFIR0n03dM/VNnXND48U2WVlvqXmN360BlRyPLCIV+qMi441YIOk0GCWswu6imFadwqpltin2s8i8pUZglkzXZnU9ifnooNPS1dJf3/begXQgYt4eGVXFnnDHi2G3gO73twnqcr5LGZfcf27Zo+OuTlKger07w9M9B9Q1SWIPUGQ4KhGyEXXlU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(366004)(396003)(376002)(966005)(53546011)(38100700002)(4326008)(316002)(64756008)(8676002)(66556008)(6916009)(83380400001)(478600001)(36756003)(66946007)(31686004)(91956017)(66446008)(54906003)(6486002)(76116006)(31696002)(26005)(86362001)(7416002)(15650500001)(5660300002)(8936002)(2906002)(6512007)(6506007)(2616005)(122000001)(71200400001)(41300700001)(66476007)(38070700005)(186003)(45980500001)(43740500002)(569394003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVZ0WFRCWXJxM2lvRUpocUU5UUxsc0xrWmRoOWZRa2w3MnpQbmZZYk5TQmd4?=
 =?utf-8?B?K0Mvc0F5TStBdnFQZko0eXg4ZFVGaHFPR2FFTW5UWElMVTVxeXBnYU40dFpY?=
 =?utf-8?B?MWhDamhzMWY3Z0QrSlRWSit6WmNaY3BoYmVTVXVvTE1rTXk4Q2p0aDJaOFRK?=
 =?utf-8?B?cDhsZjE0bHl2Tno1YW93ZmNsdmZCVE9mMFZYVjErbm1lYktVZ3lpQ2diU2Np?=
 =?utf-8?B?MVdUNE9wTVQwOVByQ0krZjMwdUkwakpaQVE1VWcvQ2hQVFRNZWdNTlJKTkI2?=
 =?utf-8?B?MTRKVFg2NmlCUENReDdmYzNpMDJ2eWI4MVNjQ0hHWVdOb2ZqT09OcStJd29B?=
 =?utf-8?B?ZnFoNDVTV214SjYxNExQN1RrcTRnSUQ4K0tYY0tLN09IRzZzWXViYVNuSzN6?=
 =?utf-8?B?am5sNk5YS0xZckdJbDBwSzZkRWRIaVA1ZFlQNjR3alhzOFBNZUNQaEhEUHhM?=
 =?utf-8?B?cVo3a2dnODhER0hNamVrUjFqNHZsVXlsZmpqa1FRemkrbFBGaUZ2UWFJaDdr?=
 =?utf-8?B?bmhNd3dUS2ttY0NlVm9uQzNkZmxRR3J3amdNM0hJQkVITUh5V3FTYVVXUVBD?=
 =?utf-8?B?eEhsUWxLblhDOFhpU2FYRUxLdjhDanhrLytjWEZReGVIdnBDbUFYQXRDbW5C?=
 =?utf-8?B?dzROVkFZNkxLNUhTZDVNRlRpUzhvNmdZUzlwdjFLaThoRkVnRHFTdHNwalJ3?=
 =?utf-8?B?Ly9GZjJmcGgvcFVlZ2ZYNmVqU25KZXFqeVlKZ2NRajM3VDRnQ2NSN2hEWmZN?=
 =?utf-8?B?N0lqY1p3bGFheU56R2FDaGF6NGQwTUhTQVIreXV4S0ZCOEs3aVVjQ24zbUg1?=
 =?utf-8?B?UVArcTBCVVNQbGJPbERkRE8xaWFKSzZrT2ZqY2gvREFoWFNpckhaVTZVbjdw?=
 =?utf-8?B?SkhZUDdWRnZVTEVSM0MxY2RGK3NrdzFDdldoeE11WU1aSldiNUFEMk8wL1Mr?=
 =?utf-8?B?dE5ndkJBVzRva0tiOWpWaG5mUVRSTjYvbkdKcjgzSHB1dGlWak00eUJDSjBX?=
 =?utf-8?B?Y2FSNnZMUmtXVGZxNXQ4STNJRmIyajExSDFOVFNNWDBaeCtoWkxvSTF4RFpj?=
 =?utf-8?B?UXpqckZqb2FvNHJLOW5hbWpCUHorK2ZkMFlNeGZYVzZzWWdvVlJ1amcxV1I5?=
 =?utf-8?B?YUFGZ0hkWVZ6T2Y4Z3JrUTZvVFdBdVFvTmJiam83M1VCNE1QWjFFMnZOeUxU?=
 =?utf-8?B?U3RBZGh4M3ZJbVRiN1ZpeUthQnlnTCtPRUprMHhzNG81MEZBazFqcnA1VEZ1?=
 =?utf-8?B?WnNUVG1CaEJOK0lUaWk0OGFBbTA2UmI3VDMzVjlhZnAxa1RWdEVROGlFUVlL?=
 =?utf-8?B?a1JSY0ppMGY5Ni9nV2V2ZWxLYk94cGtWUTV1b25TZi9mUDdTSERSVFI3WXF1?=
 =?utf-8?B?N09kM3haU0dSUXo5VmY0Z0V6MndSdDEzMWdoOUZMWEl2MHc1MlllejRrc0cv?=
 =?utf-8?B?Yzg4N0ppdUdYL3Vma0N1dFVYUUNZcVRiN2xhZkpneS9MVjRhZFhmZ1EzVVpp?=
 =?utf-8?B?UEpRN01uVkJ5OUxjNFYvVkZXZXJtWE1jRnk0dVFXOEZSQng4NzhnK2ptb2R2?=
 =?utf-8?B?RjNVVUF4L3dKNmtPclJDR3F1NVlMalVPMHlCdUNJV1JUNlduRDM3b0ZJWUdm?=
 =?utf-8?B?b3QreG1JSWNBalZzY3RXRWdYMDB4UWFpYzJ2MDBaN2pXN24xMDIwN21NTExG?=
 =?utf-8?B?alRHU1BVZHBFcDNyQ1NZOGhKTTd2czFHbzlCREQvNzFlZWRCckVibkRXUmZK?=
 =?utf-8?B?WW9ya04waTNKcEN1SkVId0N2SVFnK01hSmt6SnllVkMxb0VDc01QY2t0WjNT?=
 =?utf-8?B?UVYvNEhmWjQyRDhTamlwLzZMQnVsY0dGejU5UGVHUVpkRHdhQVBUWkE0R2FL?=
 =?utf-8?B?RndSOGxIbEdYazlwaWt6aUd1UmQzRkdobGV5RlZxYUlrdTluNE9iU0Y5bS96?=
 =?utf-8?B?MDdkbldZSGFWWVF5OVVDTFZmbGhkT05UVk5BQzVORDRBMEhMNDZLN0Q5SjZM?=
 =?utf-8?B?endWc01YTEIvQUdLMnRhZ3BaNndQbGMwbUhYUXYwVllKTjZzczNpenRNQ2Vs?=
 =?utf-8?B?Mk01MlFJWC9EZ3dtL1duS1VndWtWRVhPVi94UEtoQ0puU0t2ZHZkNHR1MzA5?=
 =?utf-8?Q?LZGoSzHoHaBgyjgqU1IFKbqsV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E62FCB742EE149419E87DFA7EAF97E4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade2dc78-3a0c-4923-7636-08da7fda2ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 22:53:45.9023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJQxIoxkm6/N7nzOFy0kJPFmxLDQFh7Dj02rWHuFSmt9irGWGMx2rFJBFe3isJiTpH99Pzhlkz7LW/2kuryxhXRiE70KTuYkHt6LaVmA7Yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3045
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IERyZXcsDQpUaGFua3MgZm9yIHBpcGluZyB1cC4NCg0KT24gMTYvMDgvMjAyMiAxNTowNiwg
QW5kcmV3IEpvbmVzIHdyb3RlOg0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGFq
b25lc0B2ZW50YW5hbWljcm8uY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0
cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCBBdWcgMTUsIDIwMjIg
YXQgMDc6MTg6MDJQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+
PiBBbnkgdGFrZXJzIG9uIHRyYXNoaW5nIG15IHJlZ2V4PyBPdGhlcndpc2UgSSdsbCBqdXN0IHN1
Ym1pdA0KPj4gYSB2MiB3aXRoIHRoZSByZWdleCBhbmQgaXQgY2FuIGJlIHNoYXQgb24gdGhlcmUg
aW5zdGVhZCA6KQ0KPj4NCj4+IE9uIDA5LzA4LzIwMjIgMTk6MzYsIENvbm9yIERvb2xleSB3cm90
ZToNCj4+PiBPbiAwOS8wOC8yMDIyIDE1OjE0LCBSb2IgSGVycmluZyB3cm90ZToNCj4+Pj4gT24g
TW9uLCBBdWcgMDgsIDIwMjIgYXQgMTA6MDE6MTFQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3Jv
Y2hpcC5jb20gd3JvdGU6DQo+Pj4+PiBPbiAwOC8wOC8yMDIyIDIyOjM0LCBKZXNzaWNhIENsYXJr
ZSB3cm90ZToNCj4+Pj4+PiBPbiBGcmksIEF1ZyAwNSwgMjAyMiBhdCAwNToyODo0MlBNICswMTAw
LCBDb25vciBEb29sZXkgd3JvdGU6DQo+Pj4+Pj4+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3Iu
ZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pj4+Pj4+IFRoZSBmaW5hbCBwYXRjaCBhZGRzIHNvbWUg
bmV3IElTQSBzdHJpbmdzDQo+Pj4+Pj4+IHdoaWNoIG5lZWRzIHNjcnVpdGlueSBmcm9tIHNvbWVv
bmUgd2l0aCBtb3JlIGtub3dsZWRnZSBhYm91dCB3aGF0IElTQQ0KPj4+Pj4+PiBleHRlbnNpb24g
c3RyaW5ncyBzaG91bGQgYmUgcmVwb3J0ZWQgaW4gYSBkdCB0aGFuIEkgaGF2ZS4NCj4+Pj4+Pg0K
Pj4+Pj4+IExpc3RpbmcgZXZlcnkgcG9zc2libGUgSVNBIHN0cmluZyBzdXBwb3J0ZWQgYnkgdGhl
IExpbnV4IGtlcm5lbCByZWFsbHkNCj4+Pj4+PiBpcyBub3QgZ29pbmcgdG8gc2NhbGUuLi4NCj4+
Pj4NCj4+Pj4gSG93IGRvZXMgdGhlIGtlcm5lbCBzY2FsZT8gKE5vIG5lZWQgdG8gYW5zd2VyKQ0K
Pj4+Pg0KPj4+Pj4gWWVhaCwgdG90YWxseSBjb3JyZWN0IHRoZXJlLiBDYXNlIGZvciBhZGRpbmcg
YSByZWdleCBJIHN1cHBvc2UsIGJ1dCBJDQo+Pj4+PiBhbSBub3Qgc3VyZSBob3cgdG8gZ28gYWJv
dXQgaGFuZGxpbmcgdGhlIG11bHRpLWxldHRlciBleHRlbnNpb25zIG9yDQo+Pj4+PiBpZiBwYXJz
aW5nIHRoZW0gaXMgcmVxdWlyZWQgZnJvbSBhIGJpbmRpbmcgY29tcGxpYW5jZSBwb2ludCBvZiB2
aWV3Lg0KPj4+Pj4gSG9waW5nIGZvciBzb21lIGlucHV0IGZyb20gUGFsbWVyIHJlYWxseS4NCj4+
Pj4NCj4+Pj4gWWVhaCwgbG9va3MgbGlrZSBhIHJlZ2V4IHBhdHRlcm4gaXMgbmVlZGVkLg0KPj4+
DQo+Pj4gSSBzdGFydGVkIHBvdHRlcmluZyBhd2F5IGF0IHRoaXMgYnV0IEkgaGF2ZSBhcnJpdmVk
IGF0Og0KPj4+IHJ2NjRpbWFmP2Q/Yz9oPyhfeltpbWFmZHFjYnZraF0oW2Etel0pKikqJA0KPiAN
Cj4gRG9uJ3QgZm9yZ2V0IHRoZSBeIGF0IHRoZSBzdGFydC4NCj4gDQo+IERvIHdlIG5lZWQgdG8g
d29ycnkgYWJvdXQgb3B0aW9uYWwgbWFqb3IgYW5kIG1pbm9yIHZlcnNpb24gbnVtYmVycz8NCj4g
T3IgY2hlY2sgdGhhdCBaIG5hbWVzIGhhdmUgYXQgbGVhc3Qgb25lIGNoYXJhY3RlciBmb2xsb3dp
bmcgdGhlIGNhdGVnb3J5DQo+IGNoYXJhY3Rlcj8gQWN0dWFsbHksIHRoZSBmaXJzdCBsZXR0ZXIg
YWZ0ZXIgWiBiZWluZyBhIGNhdGVnb3J5IGlzIG9ubHkgYQ0KPiBjb252ZW50aW9uLiBNYXliZSB3
ZSBkb24ndCB3YW50IHRvIGVuZm9yY2UgdGhhdC4gV2hhdCBhYm91dCBYIGV4dGVuc2lvbnM/DQoN
CkZvciB0aGUgY2hhcmFjdGVyIGFmdGVyIFosIEkgdGhpbmsgd2UgY291bGQgb3BlcmF0ZSBvbiB0
aGUgYXNzdW1wdGlvbg0KdGhhdCB0aGF0J3MgYSBjb252ZW50aW9uIHVudGlsIHRoaW5ncyBjaGFu
Z2UuIFRoZSByZWdleCBpc250IHNldCBpbg0Kc3RvbmUgZm9yZXZlci4NCldpdGggeCwgaXQgYmVj
b21lcyAtIHdoaWNoIHRvIG1lIG1ha2VzIGJhZCB3b3JzZToNCl5ydjY0aW1hZj9kP3E/Yz9iP3Y/
az9oPyg/Oig/Ol96W2ltYWZkcWNidmtoXXxfeCkoPzpbYS16XSkqKSokDQoNCmFuZCB0aGVuIGZv
ciB0aGUgdmVyc2lvbiBudW1iZXJzIGl0IGJlY29tZXMgY29tcGxldGVseSBhd2Z1bC4NCkknZCBh
cmd1ZSB0aGF0IGlmIHdlIGFyZSBnb2luZyB0byBzdXBwb3J0IHRob3NlLCB0aGVuIHdlIHNob3Vs
ZA0KZG8gdGhhdCBhcyBhbm90aGVyIHJlZ2V4LiBXZSBhcmUgYWxyZWFkeSBmb3JjaW5nIGxvd2Vy
IGNhc2UgaW4NCnRoZXNlIElTQSBzdHJpbmdzIC0gaXMgdGhlcmUgYW4gYWN0dWFsIGJlbmVmaXQg
aW4gYWRkaW5nIHRoZQ0KbnVtYmVycywgb3IgbWlnaHQgd2Ugd2FudCB0byAiZW5jb3VyYWdlIiBy
ZW1vdmluZyB0aG9zZSB0b28/DQoNCkkgaG9wZSBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLCBhcyBt
eSByZWdleCBmb28gaXNuJ3QgdGhhdCBnb29kLCB0bw0KZW5mb3JjZSB0aGUgb3JkZXJpbmcgJiB0
aGUgbnVtYmVycyAtIGV2ZW4gZm9yIHRoZSBzaW1wbGUgY2FzZSBvZiB0aGUNCm1ham9yIG51bWJl
ciBvbmx5LCB3ZSdkIG5lZWQgdG8gY29udmVydCAiZj8iIHRvICIoPzpmXGQrKT8iIGFuZCBzbw0K
b24gZm9yIGV2ZXJ5IHNpbmdsZSBleHRlbnNpb24uIEkgZG9uJ3QgdGhpbmsgd2UgcmVkdWNlIHRo
YXQgZWl0aGVyDQphcyB3ZSB3YW50IHRvIGVuZm9yY2UgdGhlIG9yZGVyaW5nLg0KDQpGb3IgdGhl
IG1pbm9yIHZlcnNpb25zIGl0IGdvZXMgdG8gIig/OmZcZCtwXGQrKT8iLiBBdCB0aGF0IHBvaW50
IEkNCmRvbid0IHRoaW5rIHdlIGFyZSBhZGRpbmcgYW55IHZhbHVlIGJ1dCB3L2UsIHdobyBhbSBJ
IHRvIGRlY2lkZS4NClRoYXQgYmFsbG9vbmVkIG91dCB0byAxOTQgY2hhcmFjdGVycyBmb3IgbWUu
IEkgdGhlbiBkZWNpZGVkIHRvIGhhdmUNCmEgYml0IG9mIGZ1biwgYW5kIGp1c3QgZG8gYm90aCBu
dW1iZXIgc2V0cyBhcyBhIG9uZWxpbmVyLCB1c2luZw0Kc29tZSBuYW1lZCBtYXRjaCBncm91cHMu
IFRoYXQgd2FzIGFib3V0IDI1NSBjaGFyYWN0ZXJzLiDwn5iNDQpBbnl3YXksIGR0LXNjaGVtYSBo
YWQgYSBwYW5pYyBhdHRhY2sgYXQgc29tZXRoaW5nIEkgd2FzIGRvaW5nDQpzbyBJIHRoaW5rIHRo
YXQgL21heS8gYmUgYSBiYWQgaWRlYS4NCg0KSSB2b3RlIGZvciBhbGxvdyB0aGUgeCBleHRlbnNp
b25zLCBrZWVwIHRoZSBjb252ZW50aW9uIGZvciBzdGFuZGFyZA0KZXh0ZW5zaW9ucyAmIHJldmlz
aXQgdGhpcyBpbiB0aGUgZnV0dXJlIGlmIG5lZWRlZC4uLg0KDQpUaGFua3MsDQpDb25vci4NCg0K
DQo+IA0KPiBUaGFua3MsDQo+IGRyZXcNCj4gDQo+Pj4NCj4+PiBJIHN1c3BlY3QgdGhhdCBiZWZv
cmUgImg/IiB0aGVyZSBzaG91bGQgYmUgbW9yZSBzaW5nbGUgbGV0dGVyDQo+Pj4gZXh0ZW5zaW9u
cyBhZGRlZCBmb3IgY29tcGxldGVuZXNzIHNha2UuIFNvIHRoZW4gaXQnZCBibG9hdCBvdXQgdG86
DQo+Pj4gcnY2NGltYWY/ZD9xP2M/Yj92P2s/aD8oX3pbaW1hZmRxY2J2a2hdKFthLXpdKSopKiQN
Cj4+Pg0KPj4+IEkgY2hlY2tlZCBhIGNvdXBsZSBkaWZmZXJlbnQgImJhZCIgaXNhIHN0cmluZ3Mg
YWdhaW5zdCBpdCBhbmQNCj4+PiBub3RoaW5nIHdlbnQgdXAgaW4gZmxhbWVzIGJ1dCBteSByZWdl
eCBza2lsbHMgYXJlIGZhciBmcm9tIGdyZWF0DQo+Pj4gc28gSSdtIHN1cmUgdGhlcmUncyBiZXR0
ZXIgd2F5cyB0byByZXByZXNlbnQgdGhpcy4NCj4+Pg0KPj4+IEFueXdheXMsIHRoaXMgcGF0dGVy
biBpcyBiYXNlZCBvbiBteSB1bmRlcnN0YW5kaW5nIHRoYXQ6DQo+Pj4gLSB0aGUgc2luZ2xlIGxl
dHRlciBvcmRlciBpcyBmaXhlZCAmIHdlIGRvbid0IGNhcmUgYWJvdXQgdGhpbmdzIHRoYXQNCj4+
PiAgIGNhbid0IGV2ZW4gZG8gImltYSINCj4+PiAtIHRoZSBtdWx0aSBsZXR0ZXIgZXh0ZW5zaW9u
cyBhcmUgYWxsIGluIGEgIl96PGZvbz4iIGZvcm1hdCB3aGVyZSB0aGUNCj4+PiAgIGZpcnN0IGxl
dHRlciBvZiA8Zm9vPiBpcyBhIHZhbGlkIHNpbmdsZSBsZXR0ZXIgZXh0ZW5zaW9uDQo+Pj4gLSB3
ZSBkb24ndCBjYXJlIGFib3V0IHRoZSBlIGV4dGVuc2lvbiBmcm9tIGFuIE9TIFBvViAodGhpcyBj
b3VsZCBiZSBhDQo+Pj4gICB2ZXJ5IGZsYXdlZCB0YWtlLi4uKQ0KPj4+IC0gYWZ0ZXIgdGhlIGZp
cnN0IHR3byBjaGFycywgdGhlIGV4dGVuc2lvbiBuYW1lIGNvdWxkIGJlIGFuIGVuZ2xpc2gNCj4+
PiAgIHdvcmQgKGlmZW5jZWkgYW55b25lPykgc28gaXQncyBub3Qgd29ydGggcmVzdHJpY3Rpbmcg
dGhlIGNoYXJzZXQNCj4+PiAtIHRoYXQgYXR0ZW1wdGluZyB0byB2YWxpZGF0ZSB0aGUgY29udGVu
dHMgb2YgdGhlIG11bHRpbGV0dGVyIGV4dGVuc2lvbnMNCj4+PiAgIHdpdGggZHQtdmFsaWRhdGUg
YmV5b25kIHRoZSBmb3JtYXR0aW5nIGlzIGEgZnV0aWxlLCBtYXNzaXZlbHkgdmVyYm9zZQ0KPj4+
ICAgb3IgdW53aWVsZHkgZXhlcmNpc2UgYXQgYmVzdA0KPj4+DQo+Pj4gU29tZSBvciBhbGwgb2Yg
dGhvc2UgYXNzdW1wdGlvbnMgY291bGQgYmUgdmVyeSB2ZXJ5IHdyb25nIHNvIGlmIHtzb21lb25l
LA0KPj4+IGFueW9uZX0gd2FudHMgdG8gY29ycmVjdCBtZSAtIGZlZWwgKioqbW9yZSoqKiB0aGFu
IGZyZWUuLg0KPj4+DQo+Pj4gVGhhbmtzLA0KPj4+IENvbm9yLg0KPj4+DQo+Pj4gcGF0Y2ggd291
bGQgdGhlbiBsb29rIGxpa2U6DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3Jpc2N2L2NwdXMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9yaXNjdi9jcHVzLnlhbWwNCj4+PiBpbmRleCBkNjMyYWM3NjUzMmUuLjFl
NTRlNzc0NjE5MCAxMDA2NDQNCj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcmlzY3YvY3B1cy55YW1sDQo+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Jpc2N2L2NwdXMueWFtbA0KPj4+IEBAIC03NCw5ICs3NCw3IEBAIHByb3BlcnRp
ZXM6DQo+Pj4gICAgICAgIGluc2Vuc2l0aXZlLCBsZXR0ZXJzIGluIHRoZSByaXNjdixpc2Egc3Ry
aW5nIG11c3QgYmUgYWxsDQo+Pj4gICAgICAgIGxvd2VyY2FzZSB0byBzaW1wbGlmeSBwYXJzaW5n
Lg0KPj4+ICAgICAgJHJlZjogIi9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3N0cmlu
ZyINCj4+PiAtICAgIGVudW06DQo+Pj4gLSAgICAgIC0gcnY2NGltYWMNCj4+PiAtICAgICAgLSBy
djY0aW1hZmRjDQo+Pj4gKyAgICBwYXR0ZXJuOiBydjY0aW1hZj9kP3E/Yz9iP3Y/az9oPyhfeltp
bWFmZHFjYnZraF0oW2Etel0pKikqJA0KPj4+DQo+Pj4gICAgIyBSSVNDLVYgcmVxdWlyZXMgJ3Rp
bWViYXNlLWZyZXF1ZW5jeScgaW4gL2NwdXMsIHNvIGRpc2FsbG93IGl0IGhlcmUNCj4+PiAgICB0
aW1lYmFzZS1mcmVxdWVuY3k6IGZhbHNlDQo+Pg0KPiANCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+
IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0KDQo=
