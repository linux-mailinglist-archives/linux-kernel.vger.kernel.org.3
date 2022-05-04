Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBB151978A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345028AbiEDGrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345029AbiEDGrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:47:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7D71A04D;
        Tue,  3 May 2022 23:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651646605; x=1683182605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VC04SDQ6f7ZHDy1TMm7TzUzUgRjw625p3fNa3w6r9QQ=;
  b=jIKxKrg2lWI1uSomUWiU1+TxOCVO1coLIy7vr7UayOAS1DAncv2mjnr2
   EylbI3TXvWOus/AK4FiIiPn2aHq34eKV8zjQEHu77A/6bkWcwwJbOJ2sx
   hb7+hKdZvF6c3GNyao9OdgkgxVG3yCPmYmvnWCZj5qPAkKcyVv+YyUsxO
   h0fl91VhjxMMyXVTXehp8zhwBQL9XvsjckMW0rOOFiQg0mcJecP2T8AOX
   6rGkyZViiDWs7JjlHfrENuiM8SK/tk1kcXS7QIIyz9Dwit6TZLUWUYuDy
   KUu3DVEvQ90hcmKfnuY13pintK8pt7DETm652pfHiryBTGVNpeo2fObqA
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="162256605"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 23:43:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 23:43:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 23:43:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFTZUD+3MsPpz2N7dEz6diQWfxE+2QmHX0RSCXeWXHPG4nXIPaPl+OBe4b62I796068WfV2fOf+XWYeX/dCXZWSWuxuO9eDDJRxnH4H6s7Rr3akeGhJwhiDqFP4wgrIMAC2hyxywsplyf+jPZcTY34dllU/j2kToYugwMX5q4ZAENWWWs64YL4h23c6RWGYU+NfBb2BTNXOR9xPDDQIKeU8bFBCR+xh4dRdoRP9rHBhHr2jci2PcNWWbOnfIM/XFLwdGSeWM5cCOpF3zi/BvAhb/SMu7JnJdIoyFNjTNo00y9dIKw6NhblnCPAo0B9/J1i3oLQujD6ajVgqw/LAGAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC04SDQ6f7ZHDy1TMm7TzUzUgRjw625p3fNa3w6r9QQ=;
 b=feAeE5kKvrD5z5eRsBwqdWLPo85S3qP0CV6XefOhc/ey9zjxwBSAnmdWBxwAoJySxe8NKS7ygVmI9ENi9PSRUNH/mDX796LUQ1/o11efl5o1sGgV3lrf7cWLlNLuro9txlRle2nh3C8u4ZFSyqGCx9OOhKqZwD6vIyqQM1W+MSsI/ZLDkMhFm5kKhXVbTBr7QGTlLxyYK7V1OoMOtfeFlZolApolBsfJmRKb2TY4yXHT2xviaFF19HP5rsuEBykdSCZO3pJMBbSJBdDn3EslUGi/JMhU2JQlH+b+ooGYKC2L9r0mFOoi8rY/HNgvkkeZdt5bi5WbYW/y98aNH0G1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC04SDQ6f7ZHDy1TMm7TzUzUgRjw625p3fNa3w6r9QQ=;
 b=B5W1y7u63QUXhKuIKZ9XlV8KYKCCdXynD0Y98+3ml+jIxfjdVbQGKBD6VbbeybcUzZowehp/DKmeQE6hmu9XyDTWDSPc4dw9HxZqoucyeP4enwqBiPEGwzU6aMZBRiRexYRTk4pDWE9WtruE5cjSF0SN03DIwPEX8QMAUspWE78=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by DM6PR11MB4628.namprd11.prod.outlook.com (2603:10b6:5:28f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 06:43:15 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%9]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 06:43:15 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <krzk+dt@kernel.org>, <palmer@dabbelt.com>,
        <robh+dt@kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <Cyril.Jean@microchip.com>, <Daire.McNamara@microchip.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <palmer@rivosinc.com>, <arnd@arndb.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <mail@conchuod.ie>
Subject: Re: [PATCH v3 2/8] riscv: dts: microchip: move sysctrlr out of soc
 bus
Thread-Topic: [PATCH v3 2/8] riscv: dts: microchip: move sysctrlr out of soc
 bus
Thread-Index: AQHYXZF/DC6xJHNIB0mum/kRo+VnAq0N0nqAgAB2wYA=
Date:   Wed, 4 May 2022 06:43:15 +0000
Message-ID: <08498895-ebcd-b0b5-4463-7fb236626dc9@microchip.com>
References: <20220501192557.2631936-1-mail@conchuod.ie>
 <20220501192557.2631936-3-mail@conchuod.ie> <3166309.aeNJFYEL58@phil>
In-Reply-To: <3166309.aeNJFYEL58@phil>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2df9c761-c4c9-4432-52e5-08da2d995dfe
x-ms-traffictypediagnostic: DM6PR11MB4628:EE_
x-microsoft-antispam-prvs: <DM6PR11MB4628C1A056935F81755A1D8E98C39@DM6PR11MB4628.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0zrnKph/aEXvOwaHFJUIBzLMU5iooiFTnfINYLzCV6dOjxdgIgehznooQOOp0v4ypyxeYk2F2UJZ1gK10TaD5wiU+WDpXraUD/8Y8AeC/zl+G8umeqE/1+Gjvthh5nf1R+zdQYnyZOyZcP+611KqUMENJkVFA1i/KAirxzuAyQwVOHBt4Vg2fdvk2W9HuDpXYmax4TW4GMwhOjHhvl32Wgwy/h6H3rV0F5bknG4gHuj2UWktWCYa1F5qFqWeW9izbqw3Sp24OCND88d6ShDBvdSjEg+8iCVOi/bK5KmbtxL+/OfVEVsQ2NrSEhKpE74W4mBfGwml0ZF7J8A3XqYPR6KJuA7g9P0n3fP9vv/o2EqByJxOHhH82MMsjOmW5XOAaoUtGHB13YS1JOVYNddPgYRfFmDnjPEodusr+CdndKXocJTdHfEhBgBWYSYIbuXqfQBy6vldEe5y6FkeQYrnLKNMr0/bwwJbXf/czhAJOXtkXFrU/FNRE0v7gVqXc7JncUgDvGzkHaFwG7hqiQmuGtHMUb/rVQDjsxOUy8mDw3fP3MylUcE4W/8yZHGr9uqaXj+XjYNiItQXrUTLZYHiNaS+JoOicOrHnY6U4/XMgYL9WjK9Bg9pfDYF8ESGuIU2MBAuHOntlkFL3q7Xq9DlCKlDA5xB0PekUQEkBpqt6/xwzzNHi838JGO73oJmcLx/Z7VNNacWXveYNsYfYWCRK2XMdsaD9pxJSx8nhcb0xkXsY1zoioIG7Aj0DsQ3XdbHHe+kvbUbZom1rF/uwbyDeyIYi2scucuMs8VunuX2Q6OPH0KigsuqOAFO/DG3PsNR5JiwhjpPVu2wlOE36+Uvyc2uh0tsSeisf87EryWswLQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(71200400001)(110136005)(7416002)(5660300002)(2906002)(83380400001)(186003)(36756003)(8676002)(64756008)(31696002)(54906003)(26005)(66556008)(6512007)(66946007)(316002)(66446008)(66476007)(91956017)(76116006)(2616005)(8936002)(4326008)(38070700005)(38100700002)(53546011)(6506007)(508600001)(122000001)(86362001)(966005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTQweVl0dmN5M2ZISW9zRXJadkxWVVhFNUJrRHFWOCtTT0lHbm9SNTNMRjNU?=
 =?utf-8?B?NGtNN2dISG9iWDdSemJmRjBCeFlNRGdlQkJjdkFNUmttVkhCSFFZZ3dDYlBN?=
 =?utf-8?B?bnhOQzBPWi9FTkp5eEM1dTgrZWk0QnRYWlVyaGVjaFViMjBDdVFkT3UxNEd3?=
 =?utf-8?B?REN4eStIbTBUY0wwMjVFSTBSTjV4UStQcUtBbldDSjdGeXpvcURtMXg4Q3Rr?=
 =?utf-8?B?YmtMTHFDSEpiR2dwNWVsdHlTTmlDMGVFVHVyeVV2eWdsekYwMjVQalZPNkdw?=
 =?utf-8?B?M3pvTSs2RGJqQlhNTHJiRE54QlhxV0tzTGdXM1lFd292YkxBRFhNbjhHdEJr?=
 =?utf-8?B?R1ZOdEExR295b2hHRXVqTjl0eEtUam4yZjVtZS8vajlobGVDeFpvUjl5U3hy?=
 =?utf-8?B?ck5JUFdHMTZzSjlja1F6ZzBNajdvK29ZM2FkSVFBTVlGcGdmcXdWTElacVY5?=
 =?utf-8?B?eHRRTkExM3k2MW1IelY2RXpGWWRRRHNzS1N3RFlsY0p3bUZVMjVmaVhZZDVv?=
 =?utf-8?B?RVptOXVKdStmdWJmWm05dFVNdk5zdmNOT2NwRTNFZWRrSll5TVF5NXJwdU5q?=
 =?utf-8?B?ZmR5WkxxNkp3ODV4K1hpYS9XSlVvOFZ0U0hab2RNR0VKdXRyS0I3aWxtT25P?=
 =?utf-8?B?bmIwcGV5VnFqY0tQOXdKcHJUZ2JjQWpGcVpHbjRaVVIxbWxRTkhQQ0MxOTNP?=
 =?utf-8?B?eThTN0dhNFpXeFNGVTJmMnYzYXo1SkJVQU95SEN5dUNxdUIrRytSVDRrUjFG?=
 =?utf-8?B?OE9jbU5VWjhBQkhyR1poMDlTZ2I3NVlXMzVZVTlOTU1HbmdYYk5nUEZybkNL?=
 =?utf-8?B?US9jbllOTzV0UUlyN1h4V3FTWjhiNDI1Qk1wREh3aE11Y0VCcllWVkxhSjNi?=
 =?utf-8?B?RzFiaDArVTBFWTVpWlZOL1p1bWVJZmVuT1BRK2tZaE9UdXUzMEhNSVZZZUR1?=
 =?utf-8?B?eFBTOVdDcERuR1hKdEpvbFJadXFVd0Q5R20zYWMvb1JvZWcrK0dtNXIvQmNK?=
 =?utf-8?B?S09rQk1HK0lXWXJRenVzTFQ0TVlIVmJGdjNxWnRkNFJpRkd3WjkrTmVlOTRs?=
 =?utf-8?B?MjVZRFJmUGdMQmRwNEFZUUJIYy82TitDV09UMVBOai9qdXU0M2phbWVpb0Qx?=
 =?utf-8?B?c0M5cStad3FSVzJuSWlUQkZvTVhjK0NleWdGNXRaeGgrR1FwQWtXNENvL0Ra?=
 =?utf-8?B?VGhSR2Z1Q1RYUUJjV0JZdzh6eWZhL0YyQnNDRk83VUZZelg2bEozc0tVR3Rr?=
 =?utf-8?B?dzEyQzBMTU9Ea3JQQmMxT0g1ZllsYXZvb1RNRmR6WjNmZTlFWUlYTk9UeWRx?=
 =?utf-8?B?SnlaMUsvM3JzdkFHNktIelFKdml0Z1VXRWV2akRJYU1GZ044emZsaUY4cHBR?=
 =?utf-8?B?cGZhNjljd3RhVWxINHBFQ1c5elVQOC9ITUt1ZlZqMVd0MEs5citXdW1yQW85?=
 =?utf-8?B?eXdDTHNBYklXQXNFSnlVV2xMM0pkOVZZL0tlREhlclc5Z1pCTUZNci9SbWJF?=
 =?utf-8?B?aDJQTmZKMlR3SDFkTytGVUp5RlBwSEtOVFVMSkpyTlFBN3Eyb1dSVVhuVWc3?=
 =?utf-8?B?T0oxRWRkaVdzN2xyME54WWJWSitsdGFzUnNXOGhvQ0thQkRXUWo1eFBGODhX?=
 =?utf-8?B?OHJTdnlMY0RELzZpOE54aVdEamNoT1oxdDFjOWZ1eHV5NERaaExCdWRuRVNl?=
 =?utf-8?B?YTR1Y0RtYTJHai9CNHdIMjJJU1ZSRE1EYW4wdkhmM2NOM0VsVitQV1BIYWc5?=
 =?utf-8?B?OVJXQmZvYWtDRUR1NzFrWnNaLzIwZTIrT3d3cFl0LzdnbUdEMkM3c0pJZVg0?=
 =?utf-8?B?dlJxeXFObWx4T3hya1RLLzdCbEVUYnlkVlB5SEJzamswVmN6Wlg4K1h3bzNH?=
 =?utf-8?B?VGE4R2lpMWE5TnpSYkJaZGtBajBTenlDRGlhNkVMTllWbitvV04ybGhWenJq?=
 =?utf-8?B?aWJUbzFEcEJVOU1MNTBpK3BNdzlXVCtJQWVja1dONGUzdm4vOUkzY3daSVhu?=
 =?utf-8?B?RzRxM3dLY0pnYXMrSS84OHNmOHZBT0pGYW9XT2NSSU5GQnlETEJuMmxoMUc4?=
 =?utf-8?B?SVV6WExLenZYU0JGYUtYQzAyMFA2YWxwWkdZbjZrL3cwellteWFUeHl6d0Nv?=
 =?utf-8?B?cis2ZkpRT2x4ZTlNT1BobEg1UmdObkYyU3V5TnRFVHRvdzdwZWJtYjl1Tnpz?=
 =?utf-8?B?ZUFPZnljaGEwNitvTVdyMEhtRFo4VGFSY1NBWHFxK1hvK0JJOGp0SE1yalFh?=
 =?utf-8?B?MEVwRHRFZzZWM1U5ZEd5QkFVRktJTnNlYlV0bWNSbDY1SWYxOStIdG10VzVz?=
 =?utf-8?B?OUY0Uk5JVWxsSk96V3RVams3WWI0aDNDako4RHA2SE54VGw0SDRGL1pRc05x?=
 =?utf-8?Q?Se9s5n6jeyt79FVo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDA950E1559FDA4297BAD96E59F50331@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df9c761-c4c9-4432-52e5-08da2d995dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 06:43:15.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5SIlWMJ19+YiY/ZTrsIxgZYTTN95av7H+IWA3cgRaPuGcWHoXSngcmhqq+OQQv+3/UOJd+adWDuJdbpnhcEtIwIN3JgBZZlQi4fGE2SMDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4628
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQvMDUvMjAyMiAwMDozNywgSGVpa28gU3R1ZWJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQW0gU29ubnRhZywgMS4gTWFpIDIwMjIsIDIx
OjI1OjUzIENFU1Qgc2NocmllYiBDb25vciBEb29sZXk6DQo+PiBGcm9tOiBDb25vciBEb29sZXkg
PGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IFRoZSBNUEZTIHN5c3RlbSBjb250
cm9sbGVyIGhhcyBubyByZWdpc3RlcnMgb2YgaXRzIG93biwgc28gbW92ZSBpdCBvdXQNCj4+IG9m
IHRoZSBzb2Mgbm9kZSB0byBhdm9pZCBkdGJzX2NoZWNrIHdhcm5pbmdzOg0KPj4gYXJjaC9yaXNj
di9ib290L2R0cy9taWNyb2NoaXAvbWljcm9jaGlwLW1wZnMtaWNpY2xlLWtpdC5kdGI6IHNvYzog
c3lzY29udHJvbGxlcjogeydjb21wYXRpYmxlJzogWydtaWNyb2NoaXAsbXBmcy1zeXMtY29udHJv
bGxlciddLCAnbWJveGVzJzogW1sxNSwgMF1dLCAnc3RhdHVzJzogWydva2F5J119IHNob3VsZCBu
b3QgYmUgdmFsaWQgdW5kZXIgeyd0eXBlJzogJ29iamVjdCd9DQo+Pg0KPj4gUmVwb3J0ZWQtYnk6
IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAcml2b3NpbmMuY29tPg0KPj4gU3VnZ2VzdGVkLWJ5OiBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPj4gRml4ZXM6IDUyOGE1YjFmMjU1NiAoInJp
c2N2OiBkdHM6IG1pY3JvY2hpcDogYWRkIG5ldyBwZXJpcGhlcmFscyB0byBpY2ljbGUga2l0IGRl
dmljZSB0cmVlIikNCj4+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5
QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBXaGF0IGZ1bmN0aW9uIGRvZXMgdGhlICJzb2MtYnVzIiBo
YXZlIGF0IGFsbD8NCj4gSS5lLiBtYWlsYm94QDM3MDIwMDAwIGFsc28gbG9va3MgbGlrZSBhIHBl
cmlwaGVyYWwNCj4gb2YgdGhlIGNoaXAgYnV0IGlzIG91dHNpZGUgaXQuDQoNCkkgYW0gbm90IHN1
cmUgd2h5IGEgc29jIGJ1cyB3YXMgY2hvc2VuIG9yaWdpbmFsbHksIHNwbGl0dGluZyBiZXR3ZWVu
DQpheGkgYW5kIGFoYiB3b3VsZCBiZSBtb3JlIGFjY3VyYXRlLg0KDQo+IA0KPiBBbmQgSSByZW1l
bWJlciBnZXR0aW5nIHRoZSBzdWdnZXN0aW9uIHRvIG5vdCB1c2Ugc29jLSJidXNzZXMiDQo+IG92
ZXIgaW4gYXJtLWxhbmQgeWVhcnMgYWdvIFswXS4NCj4gDQo+IFswXSBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0
Lz9pZD1jMzAzMGQzMGQ5Yzk5YzA1N2I1ZGRmYTI4OWNmZmE2MzdhMjc3NWY1DQo+IA0KPj4gLS0t
DQo+PiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hpcC1tcGZzLmR0c2kg
fCAxMCArKysrKy0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWlj
cm9jaGlwL21pY3JvY2hpcC1tcGZzLmR0c2kgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hp
cC9taWNyb2NoaXAtbXBmcy5kdHNpDQo+PiBpbmRleCA3NDZjNGQ0ZTc2ODYuLmJmMjFhMmVkZDE4
MCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3JvY2hp
cC1tcGZzLmR0c2kNCj4+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21pY3Jv
Y2hpcC1tcGZzLmR0c2kNCj4+IEBAIC0xNDYsNiArMTQ2LDExIEBAIHJlZmNsazogbXNzcmVmY2xr
IHsNCj4+ICAgICAgICAgICAgICAgICNjbG9jay1jZWxscyA9IDwwPjsNCj4+ICAgICAgICB9Ow0K
Pj4NCj4+ICsgICAgIHN5c2NvbnRyb2xsZXI6IHN5c2NvbnRyb2xsZXIgew0KPj4gKyAgICAgICAg
ICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtcGZzLXN5cy1jb250cm9sbGVyIjsNCj4+ICsg
ICAgICAgICAgICAgbWJveGVzID0gPCZtYm94IDA+Ow0KPj4gKyAgICAgfTsNCj4+ICsNCj4+ICAg
ICAgICBzb2Mgew0KPj4gICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+PiAg
ICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4+IEBAIC00NDYsMTAgKzQ1MSw1IEBA
IG1ib3g6IG1haWxib3hAMzcwMjAwMDAgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAjbWJv
eC1jZWxscyA9IDwxPjsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2Fi
bGVkIjsNCj4+ICAgICAgICAgICAgICAgIH07DQo+PiAtDQo+PiAtICAgICAgICAgICAgIHN5c2Nv
bnRyb2xsZXI6IHN5c2NvbnRyb2xsZXIgew0KPj4gLSAgICAgICAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAibWljcm9jaGlwLG1wZnMtc3lzLWNvbnRyb2xsZXIiOw0KPj4gLSAgICAgICAgICAg
ICAgICAgICAgIG1ib3hlcyA9IDwmbWJveCAwPjsNCj4+IC0gICAgICAgICAgICAgfTsNCj4+ICAg
ICAgICB9Ow0KPj4gICB9Ow0KPj4NCj4gDQo+IA0KPiANCj4gDQoNCg==
