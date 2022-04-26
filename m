Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B550F2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbiDZHpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbiDZHpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:45:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E220133E5B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650958931; x=1682494931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A95AbmXToWUP+d0oS/iDMc5KGoyqfZqXJF73u+L3+S8=;
  b=ha0Avv555v9iAHxCs8LKWLoiFuwCHavsi7CgJywqQNiz8ThlqgTRyYH7
   N3NTm73FQG7G/HVTUyJ3tN5WZV73gnFmBWW/Ayi+wd9jD381d8R8KEdBP
   TbgAErMAByJ45RKx4fJA/P56sQaCpmOOyYZO7/tMHcO7uuHDPDebHQvxK
   KpJCLq4Ym4ibkWTZLunpS/Wvk0fi3HKHDNwS3MLwRTiwNZE9df3ERRwSm
   oBPCwhF62TSCkRTbkKauqBSeI73TVOMsTXASkTM0Ch5baNQQSqAX4L+/d
   AOwW6xd8aSavZdHAx1F+sl7iRWlYdg9RKB6VpjGEttPF9HJyJuUjY/wW8
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,290,1643698800"; 
   d="scan'208";a="93554466"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Apr 2022 00:42:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 26 Apr 2022 00:42:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 26 Apr 2022 00:42:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFikROtoPTg+pBw2VgRnhFiEGk34mMf7FLf89MSsTKwUAzbc5HlBr5OsEpjJGRy+oG8n1dpNp57zO5sItt4IC7xb8Z26gE6hnY/mqrqDIYBkWdnIT+muBjBRzf5DLiEh/ZudvMjbLprjU+zW1gnXgelAZR7JKYNDRmK+aYbpxndqrn2b5dLBovt4FJKZzZEAharcSoTl1YYczeGl/Qnt6KV/y1c6jsU30fX2jqAUr/Pc/Nl6xvHyoeRlIGI4VH5oFMnZnv3CGkS9zGpUK3gYDYApjMR5E7aEQAHpe7LEXR2Vy+rwgLjHG5wvanEAWohxVGSHLFWSsvq8UnUf6ceXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A95AbmXToWUP+d0oS/iDMc5KGoyqfZqXJF73u+L3+S8=;
 b=LJ1zh6hYazmAgdiPvw7IrLxf+Xa8mIhmZtH4vPrZU8UzghsMpWUt4QF1yw25kdV3sBjI/qL5vAH9XETlJ7o8vruVQ5DZY/NRkYU/4ZhbudMXb1G8S60sMUjzJiDKFPozErEMX4UeQjWBmN+XlqgDfeGR8Il1gHKlybgXRLiDTIhKVdz5aA2h24FH1Bp+qw0PfBesliLQk0OufssRCSpOBSj6bGUF2L9tVvAY25XoRVY2n4JRsge/x+xIVxLXNT8BqD2SKsUwDElcu8GmlS8uP2Q1zIFOJhT4dUMDYZoSC3/MyceDxKdj5ux1uqP6WJeKEU2T1Eh99PxQBUL+2QmkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A95AbmXToWUP+d0oS/iDMc5KGoyqfZqXJF73u+L3+S8=;
 b=t28VGgvSUuPD3C9/4r1sGt5cXLzzo+DQd/PFRhLaAWGfDhukfVMsvPrwdQaol5YQS4PJvnblVK4ucBo8GlsmrQW4aA4y6gTPK+MUib5Y832GR7Xv7l//0/mICJCAcBqiEu/vo65Ypw2M2rIoclpGwsZ3d3gMht9v1sVci8+6xzw=
Received: from MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11)
 by PH0PR11MB5047.namprd11.prod.outlook.com (2603:10b6:510:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 07:42:04 +0000
Received: from MW4PR11MB5936.namprd11.prod.outlook.com
 ([fe80::3c24:30c4:ee81:9f1c]) by MW4PR11MB5936.namprd11.prod.outlook.com
 ([fe80::3c24:30c4:ee81:9f1c%2]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:42:04 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alexandre.belloni@bootlin.com>, <sha@pengutronix.de>
Subject: Re: [PATCH 1/2] Revert "ASoC: dmaengine: do not use a NULL
 prepare_slave_config() callback"
Thread-Topic: [PATCH 1/2] Revert "ASoC: dmaengine: do not use a NULL
 prepare_slave_config() callback"
Thread-Index: AQHYVX72QXC33nrbF0modlG2iKn8ia0A0EKAgAEG/YA=
Date:   Tue, 26 Apr 2022 07:42:04 +0000
Message-ID: <dc173079-78b5-81e9-42ec-439954c00efb@microchip.com>
References: <20220421125403.2180824-1-codrin.ciubotariu@microchip.com>
 <YmbFr14wI6qoNJ0b@sirena.org.uk>
In-Reply-To: <YmbFr14wI6qoNJ0b@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c2a7c94-f50d-4abf-f746-08da275841e4
x-ms-traffictypediagnostic: PH0PR11MB5047:EE_
x-microsoft-antispam-prvs: <PH0PR11MB5047615E3BB7FFBA894747E9E7FB9@PH0PR11MB5047.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q+K+vBvp84WnStrJoOw980gTUP3fNcXzMyeohU2uYKs4rW30xaBuhEx3gta+acXVHMMHox10tNrFAYsY+pQMzc4dnB4ZJhGlVEv/WaaMzNAjH4jAC4sQ6Cut0vrNAftW3YVlUaxYgzlg0ELPQZGkmJfyMZHGFr6bjpA9HDneN+jLATfSnFUyghUrBWME3qFRY1IxRQrI+Az8TEUO2gj0BUNZZnAYLW9AEIDJ2iqq/oBI/MRLobDfkIPtYmbbY1KMU3TOt5FB3Mja3pjvTJ9FmXgzRZo7p5RfWcC/1x2nSljlAl85o6uk2MxjOUNr2OTpF1Fth26mH2Mg1yX/FOINjOwGMBsCNrAjSxi5OvX25FRJx05bLWpBVQKwDVp9DeEdjC+uODTAJq7gFMBizoRklAAB5vB41vn9Gqe1sn0yP/HkC0ozubTeL0YnV5bUMr3PXkeZIYlLWWfKKqD4H9p8OvBQrg2TDwnEUhDnW894JowzcZmkUs2zTrHm5GMAuaQuuc2K10FKlNUwQKHsQU7KGNS9l3cTDPWKUfciwu2iju0hb+yAHLCyHyWxxttOmjQlTz6ASx3ZX3KCJWTakuAbBoAaGgn6XDSeecEg+//T/vJVNSKKRU6718rG6WYzVXdvToIwIjNAPG4sTTWtnD1rons4vTASo8jnwaiP1CL3wcNiY3hv9wGHsaGEi1BhEhZcHJzyMTCU67+g/5ww63Fne8VkxcQgWEeNZcBIaDBJeCTTwJ0P9IjfMQ47SUVuvhggWHRKVykVYZXTYMUK+7Fm6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5936.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(508600001)(66946007)(76116006)(186003)(2616005)(54906003)(66556008)(64756008)(71200400001)(6512007)(66446008)(36756003)(316002)(122000001)(66476007)(8676002)(6486002)(91956017)(31696002)(2906002)(6916009)(31686004)(86362001)(8936002)(4744005)(5660300002)(38100700002)(38070700005)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFcvemxVTVd6UzdPTUJqdnZsSWVzYTluQWgvZXJqcXIrcGNaSnBLYWRHNGNQ?=
 =?utf-8?B?SUJBb0dsdEc1aWVvYnAyUjI0NDdxV1NFQ0RsSDNjaEU0T0E3NHdOMzFadGtw?=
 =?utf-8?B?MHowWnc0Uncrb0t3TjFmS0cya1RSRmlZbUJBZXdZUGFIbUo4cUVmcEpuVVVC?=
 =?utf-8?B?MW92M3I2bDBxcmhRQzVQWjUxVEc5cTJscXYrV3pUNHhhM0VFTlF1Y0lnR1Ni?=
 =?utf-8?B?TnNDblJTSkUrTndEbmVRaktJRS9rbnlEWDI1cE9HMnl1b0Rqbm1TMERtN3Y2?=
 =?utf-8?B?RmZLL3c0NkJZbXJKOGZ6MUJTWVptdWVKYVVjcWlmSHdneTV1cldNS2VpZDAz?=
 =?utf-8?B?ZEk4cDVvQ3lwSHpZaWZhNjI2UEp0Vkl0bzZjUEx4VnRjLy9qVUtuRVdQSzFX?=
 =?utf-8?B?bmhPbTF1RUwyRzNXZTNEUHUrS1FVNFVVV0dKVjlyOXgrcGlHNkhGTXI0dU04?=
 =?utf-8?B?M1ZRR2I2YlpuQ2J4cUhqT1VSR1JOZzZaeVZ6bWhDMzU1c2lMVUljOXc2REJS?=
 =?utf-8?B?VUtEbnYza3Bkdmh2bjZTSEwzOUZLQ0kvYW9tRFp1TUNXUGl5R09OK3BUbW1T?=
 =?utf-8?B?VWFwUE5PL3FIdDFtRVN0SHFmTjNJWHg3T2FOL0E5cThReEQxZ2tJNDEwNmoz?=
 =?utf-8?B?bEhpdjBBa1VUdHdEdUJLRm4zdmtsbjl4dm5qakVyUURPWmprRXBSdFh1Ymtm?=
 =?utf-8?B?ZEJGZXdKNFgwZU5OMWhuYWRUMXl2cGZoUnhMWjl0UDNBTHZWL3VPdXk5bWc3?=
 =?utf-8?B?OFJuekNiOGoxMkhpdmR5amFRTGR5QVg0cjlqOUtsZXlENkV0RXg0enl1VnFL?=
 =?utf-8?B?OEJ5WnUxdmtrb1JlaFIxY3d2K1ZKWmlvUktKLzZRaEM4ZytvZG5yS0IvdnRa?=
 =?utf-8?B?NytGazB5U1pocUx3WE82SXlQcTk0eTBac0Rhb3AzNnFad1kyTUwwV050Wnov?=
 =?utf-8?B?VzFwQ2k3dUkzTGFkdlJVUml6d3dsMzJiMWZjcVE5YUdoSm9ENmV5UGp3OENY?=
 =?utf-8?B?RkttOXVuc0x6QllWclpCWkZkVDdlUmFsdnlaSlVsVUZxNE5lLzNqU2V3Uzl5?=
 =?utf-8?B?NDI3cUhkanE4blR6ckloM3BMUTN2dlZhazdrY1VZRE5EaWJKSFJlVm8vc0NT?=
 =?utf-8?B?ZmR1RTNuRTMvOXo2U1BrdE9IVFc4RWFPK3NZdU9FcTZUYTFrZUJ2OU5vNnZE?=
 =?utf-8?B?RjlCMXBXODNUK2RMZ2dLcURZMEE5OXpLTERQS1crVG5RUEdOL3hXdU5Yd00x?=
 =?utf-8?B?N2FYMnNDWm1hK2wrenNack5RK2srdFRpNnRXWGdPNXRFWUFYMFNpNDlkQUxO?=
 =?utf-8?B?WGsyYzlrbGE0bGVYM21qS2pnd2hlRGFYTmlsRC9aSStGekpzZk5tUjRFM3Zv?=
 =?utf-8?B?K05IbnlyMkFnQ1ZKL29NQkU5NjhHUWtCbHJpcTVqTXBUM3Rocmgyb3JyeE5w?=
 =?utf-8?B?dW9UVXgyUGI5WGRramtRQTZnaFh1L1RwZWhOUVpYQ09ROW0zUFdsc1ozMG11?=
 =?utf-8?B?R2FvbjNQY3JPSUs0a1h3MVJPa09BUHpQNmsyU1F2YXlYN212ZGF4emJ0VkEy?=
 =?utf-8?B?Nk54VjlRVzVhcXBhQklRcVVrenk3YVNTTlVUbUc3UkY2aHFRKy9vc2gvMzFI?=
 =?utf-8?B?N0dDTmFQcG1kRVZ4OWdBa1Bua2sxakRYWFFrQzc5dFFDbkt2RGNtKy9rQnZj?=
 =?utf-8?B?TlJZa2N6OENPNVkrRm5qcnhrOW1vSWpheEpxUGo1RGtNTzFpVDNrNFJlOFhw?=
 =?utf-8?B?cUVYT242TmVLUDBzRGlqYUxLM2tkQllCd0JrUVY3NWpicEJKMnp6bEg5VXVL?=
 =?utf-8?B?cit0TnlRYlJWRlA1V242SC84STU3dnYzbmlrWXZOYmVHWTRMdk92MEh3UnVx?=
 =?utf-8?B?Rlh6TTJJVzdEYmVIOTdtZG1PcmZ2UmtxSU5JRm5tZHVSdzdxRmorbjIyNFQw?=
 =?utf-8?B?bVlSSURQb2pZVFpwMnZrVmNNNTROZHhWd0orN0tQR3Q2UW5sa0wzRSs1a2Qv?=
 =?utf-8?B?dlRtRGs0cDNxYlM0WG0wS0o0N0Q1S0NKY0J0RFRjdDlHbldYenhMODE4b2dH?=
 =?utf-8?B?K0RuTWdBQXhqRWxPMnBQL0Ewb3J0TDYrY1hxYzZmNUVYUkVZUFlmREV5U1Jr?=
 =?utf-8?B?ZWtSeFhtR1pUbHpkcTdpTkpkWTVvYnlJbGZFOHlKT0pGeXhkWGJZUlcvbkxv?=
 =?utf-8?B?em1pNHE2TE1LbnFrUDVFM0ROQjN1M09BZVF3NjA0ZzNYN3U3Sy9MNHNwMHNB?=
 =?utf-8?B?aSt5em9qYTh2OWRhSDFaSU42MUhUN2o2c0VQMnVkc3p6Sks2anRQaU4xZThn?=
 =?utf-8?B?bTc3REswaWQ1Tnh5cGkxZEdmSTZGL3RTd1ZYdmZWOUUvYWxBVWx2Q3pvYUlH?=
 =?utf-8?Q?YFfCftWD909IIxsuBz9CqJLESugDTPIj2ud+1e3EfagtT?=
x-ms-exchange-antispam-messagedata-1: fOX6Ka1oXdCePxDkMCPZ3DNEkMDwYT0eAUI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABEF5889A5379B499D8F1194EDDE96A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5936.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2a7c94-f50d-4abf-f746-08da275841e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 07:42:04.2163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czhf+FclKBi40E+waP8iCfMv4XnofZb8llPcZxM9RZRAaBwF02JnpgWFRTXRGBMYdSqUbJbPloh+6anzm1Mlf24aYKcBuPUb+XtB8cpAjHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5047
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUuMDQuMjAyMiAxOTowMCwgTWFyayBCcm93biB3cm90ZToNCj4gT24gVGh1LCBBcHIgMjEs
IDIwMjIgYXQgMDM6NTQ6MDJQTSArMDMwMCwgQ29kcmluIENpdWJvdGFyaXUgd3JvdGU6DQo+PiBU
aGlzIHJldmVydHMgY29tbWl0IDlhMWUxMzQ0MGE0ZjJlNzU2NmZkNGM1ZWFlNmE1M2U2NDAwZTA4
YTQuDQo+Pg0KPj4gQXMgcG9pbnRlZCBvdXQgYnkgU2FzY2hhIEhhdWVyLCB0aGlzIHBhdGNoIGNo
YW5nZXM6DQo+PiBpZiAocG1jLT5jb25maWcgJiYgIXBjbS0+Y29uZmlnLT5wcmVwYXJlX3NsYXZl
X2NvbmZpZykNCj4gUGxlYXNlIHN1Ym1pdCBwYXRjaGVzIHVzaW5nIHN1YmplY3QgbGluZXMgcmVm
bGVjdGluZyB0aGUgc3R5bGUgZm9yIHRoZQ0KPiBzdWJzeXN0ZW0sIHRoaXMgbWFrZXMgaXQgZWFz
aWVyIGZvciBwZW9wbGUgdG8gaWRlbnRpZnkgcmVsZXZhbnQgcGF0Y2hlcy4NCj4gTG9vayBhdCB3
aGF0IGV4aXN0aW5nIGNvbW1pdHMgaW4gdGhlIGFyZWEgeW91J3JlIGNoYW5naW5nIGFyZSBkb2lu
ZyBhbmQNCj4gbWFrZSBzdXJlIHlvdXIgc3ViamVjdCBsaW5lcyB2aXN1YWxseSByZXNlbWJsZSB3
aGF0IHRoZXkncmUgZG9pbmcuDQo+IFRoZXJlJ3Mgbm8gbmVlZCB0byByZXN1Ym1pdCB0byBmaXgg
dGhpcyBhbG9uZS4NCg0KSSBkaWQgbm90IGtub3cgaG93IHRvIGRvIHByb3Blcmx5IGRvIGEgcmV2
ZXJ0LiBJIHNhdyBzb21lIHBhdGNoZXMgb2YgDQpHcmVnIHRoYXQgd2VyZSBtYWRlIHdpdGggJ2dp
dCByZXZlcnQnLiBJIHdpbGwgcmVtZW1iZXIgZm9yIG5leHQgdGltZS4gDQpUaGFua3MgZm9yIHRh
a2luZyBteSBwYXRjaCBhbnl3YXkhDQoNCkJlc3QgcmVnYXJkcywNCkNvZHJpbg0K
