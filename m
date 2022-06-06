Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2740B53E297
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiFFIu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiFFIt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:49:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB1F1756B3;
        Mon,  6 Jun 2022 01:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654505207; x=1686041207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8RogLV0b53HvHf3Awf97eSt4ldxDx38ejw5Q6RIzPEw=;
  b=fR4X3df1ER8pqLR5j1Rb+p6Bjj2mNq/LXVD4YeGDMtMqAgjxlmB+ONDn
   rRs0WgDdqmjricEmOwtRSA0FFxeSSK4flfcY/Q+crpsmBYwIX1otOQFan
   GxVl2tNOUJmycw4s5qezKbp1JIkb+ldkNX+tLuVBi+CGlHUztZlFImvOu
   +tDZ/Wpsp9naoMPn5OuyQR0S2wfALgO8VmrjgYNS0TO3G0Z4KfKENUE2H
   l+GWqhcFIIpqdYu19+KwT05eX9KcVj8lbu6hfiYqFQvvUC5agAvV465hj
   Y+6R3i+lDgpTVsjNEAUAFGyZ1BhogmtZ/EKksicrMj70FF8+Lsq7W3XnC
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="176655128"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2022 01:44:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Jun 2022 01:44:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 6 Jun 2022 01:44:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFsxHyPPTvaawWzDZp+gPCmXrePWAA90k7D1pFRKIFegdHpNQ7k2A0sf4RCE+kwR/1HIGPyh6hnbWVZTIEIx9zh6GhhNzPK2RsiovkWeILq4hBWi/Y4bU3QlFpHIoq21WJCA+7fQiE5mKvc6pObshbnoUfzvJZsi4Bjc41kMqpXYeHuODaeFa3Sb6v2ngyHAUo3XrfG+oyO2wjmEbxV5epNJ3mIqxND/y0K+nYwLXO0wUOja6LWn4xha/9bRy0k4lP3h4VtOTnR2vIXV+vf558RQ8z7NB5Sul9R9Dhj6y3EaRi3JZa4Cq0zvtmBP8ptMJwZ5l8V5MXWPClSAz8P2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RogLV0b53HvHf3Awf97eSt4ldxDx38ejw5Q6RIzPEw=;
 b=HpYv0o4+V7XOp5RVjcLcjZ6xi2vJjiKbxjv+DUuU3DH41Xab2pszfRU+SOlGiicXD2aSXc07XsyFEaW8ldiUyeMcprmWEutywOsAsnN8TTdnR4Xo7nivrQ8lwIGgSWkqwqlMAbKH/0j61YvwyJ2WW1ApkBCeK1ZQEbxmhW9TIS6S096yNHcH+xgsTOGzkWBLi6ZTWVZfleHTFnlfgeTEs6lSoiWb8iiwOBdiZudI0eByLxOELuuyNUmNJ8fhecXgevN+IgX3faJ/KBjvxw+/vpsnroy8NRu25lGWUx/e4uYYpdyynNwtF5SJ8qlAhygPTfcw3QA92EUBIrWhu0YU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RogLV0b53HvHf3Awf97eSt4ldxDx38ejw5Q6RIzPEw=;
 b=ZJpsQybkRVIkXO6daXyrNZXe4cHrbazpt2KfaM/NaiuEqso/ubxYfsoyCnp78PYdEEMKjIeUGJ69O9thOAWJmltMN9v4ugDR3Y5HqPJUtR1FjM+7SX4jSS5agMRXV9X1tCI/HSy2wPslmLk81EXwvpucFkBzN9Apzs1rFFHsHgk=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ1PR11MB6275.namprd11.prod.outlook.com (2603:10b6:a03:456::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 08:44:26 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::8dbc:9dd0:ba2:e99]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::8dbc:9dd0:ba2:e99%10]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 08:44:26 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mfd: atmel-flexcom: Add support for lan966x flexcom
 chip-select configuration
Thread-Topic: [PATCH 3/3] mfd: atmel-flexcom: Add support for lan966x flexcom
 chip-select configuration
Thread-Index: AQHYeYGgK5O6CULJIkykUBP2DzYTiw==
Date:   Mon, 6 Jun 2022 08:44:26 +0000
Message-ID: <5f9fcc33-cc0f-c404-cf7f-cb73f60154ff@microchip.com>
References: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
 <20220603121802.30320-4-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220603121802.30320-4-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 173f8cf0-221c-4ba1-652e-08da4798c328
x-ms-traffictypediagnostic: SJ1PR11MB6275:EE_
x-microsoft-antispam-prvs: <SJ1PR11MB62756FA7AEE3A003B417722F87A29@SJ1PR11MB6275.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQUFkwJixPjezaY/EHYNx92/Re8tFiTKXzNHzCnyDwzzwsdjbyZF5109AE2uMu6Geq2ZpPZu5fDai5Rnz0d16f0Yzi2AxDYEH2yJSKNaPLzyc3BN4toj274fQsUjRYv2k/sN79qNU7/4Vg9NQtj3Y5hR0iulzvJi7R2qyriDEKHvShRk1bBAm0dC/4siG73dmDOT3oyXwzjiMoGNilpRrGaeQC3UQEMd55wkguWNH0Y9fV5McidWi11eYnmCbVUDyAauthkM+FK/L2g7kU31+Ax7/Aci2IIMB56iFypJiolgWLLmFcF8HY829T30Ly7G1jzQSHrp7euNthrNkKt7rRv+3upNw7QPk/mfc+cFTFYts4UbXz6mTEZrkZ5EnjsFswdJ+yKya8IBVnx7049rlk/KigNu1uxw+/nWGHSR7HfuYATRyxBzm1Z//ULqUwbxoNGlONdQ7/utXV1eUNB1hUJkIzqxvPqhL/OBHy6paJLNHOjCOEiyv794SByqYaBpypzoQ3hHILpE4i+I+kxveh1MSKcmi8KHoThIutFIeb4r87xkuim2ZHIA9kGp27h16xmKaeqTdEJhD79lBQ0JLbmbCYXG5cvuKa2p/kk/Bf8/56nEffsDEY9DzU60XaLcwmM9a9q+Y5TK5x+TOBzVQBIshIDazWxXGRdZ+nTJF/jmA9lq5JJo4SarC5yfbUCU85d+++B0c61VbMlLxeVPaiVirgrn0AcKanjUOkQSzn5f1LF2V2hndxL7OmFoz2ZwDA3RzjVxNJP+j0ra+L4Yx4teUBgtzbWpy4JK+NSpiNAUhyJfuqo4kv+bSQWQS+7Kj12ModJRoektKsPWmpA95XwKf0xP7zMyuqlGZ4f3rS0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2616005)(66476007)(76116006)(6636002)(31696002)(31686004)(8676002)(71200400001)(54906003)(83380400001)(508600001)(5660300002)(26005)(8936002)(6512007)(66446008)(186003)(66556008)(966005)(53546011)(38070700005)(36756003)(91956017)(110136005)(6486002)(6506007)(86362001)(2906002)(122000001)(66946007)(4326008)(64756008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWRIM2QvN01wejlUVUlmUER2MStNUERWV1pQOUxHWmFoUndqRlYxdERaVUNx?=
 =?utf-8?B?M2RkWnFRNG16Yk1MSnpNTTdtTTRlakpHUFhlcHJPS0lEa3NqMWxjNjhWbW1i?=
 =?utf-8?B?UGxrbFhjV0NyblIrNENGNXhYUmtWbmQxbzJJOHhhWWtad2ladnlSc2hKYTFC?=
 =?utf-8?B?WGlacDVKSVpiK05uWkdKaGpTUWVyWlhyemwyWHp0NStMRGRjMTQ4Umx2ZEdO?=
 =?utf-8?B?ZDRhVXY1UE9xTkpIRzRXRUdIUFJxSSsyZ3ZQVkk1K1I3VnBJRnlLZDVMa3NR?=
 =?utf-8?B?TUROZzhwcnlSWFZpZUdRUHZQMU54ZmNXY1ZEZkpOdUpEdE54RUZJTldEYnJp?=
 =?utf-8?B?dkhUTG80M2pNNW5HNEpZaFp5bjRCZVVEdVdGNWU4a01wRkR0cUxrQjI1R0Y3?=
 =?utf-8?B?MUw3KytJL1NtSnNVa2kwUW51K0VjdmJMbkR3Y1lPb3UyeHRFVEhJZEZOZklM?=
 =?utf-8?B?S0pPR3VoZDhTbSsxUk5CWXhQSUxUVHR1YzZRNzBHcklJV3h4eEt5eWh5WHBj?=
 =?utf-8?B?aTQxSUFYK1hCdlNHZ05Ba0dyZnpVSkVBQ3ZBWU05MHJyTS9DWCtRbnA4OExD?=
 =?utf-8?B?TUpSNitiU3FyTkF5dmJJK2F2Z1g0RXdoNFo1U1hUc0s0UjNhekNuK0RZeDc1?=
 =?utf-8?B?STFRSFlMUlJWaCt0UEhZTW1TMTMycVlxTjJmN3J1RkpENUhOV0grSVFha2Nq?=
 =?utf-8?B?N2h2SEtuVS9Ob3d6bGhHQUFZNUtTTEwwRmozcVorL0cyZVUxa1U4Yk5IYlZq?=
 =?utf-8?B?TjY5dmd6a3pHWThpSXFNTlRoem1nUnArZHVJQjdadHBSTWQ1NUtSVjVjbGNN?=
 =?utf-8?B?K0s0L1lZRU5kT0ZjelRIQnAyVGo0ZFQvVWNJVjVZUXNzK1VyUVMxVDZ6YnhY?=
 =?utf-8?B?NG9GRG9DQjNCMG5wdjdUUUZCWjRvQXpnNVhZV1VRT0hPNU1XLzA3RVlkSi9P?=
 =?utf-8?B?eEZmWnllVTZLa2NKT09McE1uazV0VU5NUXNKZ3JNWFlxc3BkU1cwTEZ4YUhM?=
 =?utf-8?B?dzl2MVFnOHlUckI1NnQrcjhndmdiNE9BUUpQVG9paGdQTyt2TFJ0Z0tOYTJO?=
 =?utf-8?B?WkpCS1dVWTBaMmhkR0x0UlZsbGVsQmZhTjdJR0lrcjhBQ3hYaVhzNmd3anR5?=
 =?utf-8?B?WDh1WFhpVEE2aWd0TWE3Y094OWdJUUNReGpjSVBqRjJ0NmNvdjZWeWVoZWhu?=
 =?utf-8?B?WkdQSnBOUmRDd1VsY3pHSTErS281cWdSN2VNNUU1QlU0MWdJamZzV2lUTWNt?=
 =?utf-8?B?alJWVEc0bVVBWFQzemNLUU1WQ0Fic3FkR253Tnk3ajl4YzJkLzhFWC9WOFB3?=
 =?utf-8?B?dFYwU3YxYm1mNTVXRm1UOTdHcjh6WmhkQUExdTVmbHl5NnF6VXRaaE5idUNi?=
 =?utf-8?B?bzg1aS9SYkZHYlFLTFhJNk1ZTmlFZXFwRlpER2lqL2p4a3FtSUUzbW85c0tn?=
 =?utf-8?B?TkJYL1VzMFl1MTNzUnNudkM4aEt6UlFxUVFlS1lQd1Fmand0b1JVblRwbWZC?=
 =?utf-8?B?QklQZGZSTThoKy9PNm9DTGJ6NFVtSDNYRCthbFoyYUtzbXB1N0dPMGRqaDJK?=
 =?utf-8?B?enZka254dGNtdS9hZ2h1S1VsSWNSeUg0eEkwbHFOWTFFb24yN01Yei9wYW5a?=
 =?utf-8?B?RTN5eGxJa001eHFYTmVvQXFLTWxHOXgzMlhxQytzVCtVNEs0a3VHaloyeHhL?=
 =?utf-8?B?QUQzNGlBb2Z5OGVudlNzNC9CMzlJejkvK3lmMDdhZExOY2REV1pPTDhsK095?=
 =?utf-8?B?eEtFWnRJWXM1ZjREazdsZGV2NlllZEhWbHROdDdlb3ZYMGlmV1R3OE11dUsw?=
 =?utf-8?B?RHRxcndlUW5CWWxrQnp5d1pQTW1tbzVvM2pvMjFvZm5WMDFCelJ4dS8wY0ZS?=
 =?utf-8?B?bTJRa3k2WkJXRmtTMitOd0tjWnF1c01MQjJ1UU5jK0h2LzcwMDBVOVJpTFJD?=
 =?utf-8?B?cDU4N3ZYcW04SzFzVThUNnJOUmcrS1dNVEJxdW9nT0JyMkdicmVjUi9oaWhI?=
 =?utf-8?B?MFRubFdTaytPSm9iT3d3bXczT1BXa2QrVzlBaktYUGxGc2lOMTdnYjJ1YmpP?=
 =?utf-8?B?elNVcU5ESUF2Si92blBsVmhic2tockdvSTVvSXVYVUdDQ2VKQ3VxaXVuMUw3?=
 =?utf-8?B?K2pqM2h2Y0F5R0VESStSVlJ1YUZPb0xieE1mTzJXWFNXZFBlWXNvQ2hvRTRx?=
 =?utf-8?B?N3ErdVJHVmpRN3QycmcvNEljdnRvcWo4RE9hYzkraXpUNEVYYnVPRkpLdGEz?=
 =?utf-8?B?Z0VXYU5HMDdDWktBMlJFa1VMMXFncUV6OWc3M0N5WWM0bDgrYnhkL2lkaEFz?=
 =?utf-8?B?eHN3MlkrMU04a0R1TEdVMEc4MXRQZVNpMktDdCsrVGZOOUIyZXVKNFVGRWho?=
 =?utf-8?Q?WSWtAeb+JCU+Pnjk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B10F9D35F45A749B21F5CF4E988325B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173f8cf0-221c-4ba1-652e-08da4798c328
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 08:44:26.0839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQcxJ1eej2n5iO30YN7ZHQfcLoH5vGEYDD/Lb9DU73uUlEVRqI05gzCBqojDYJqcBw0LoFURhkIKTOeNr6bBunfMvys5oidz+n+w1xet1x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6275
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDYuMjAyMiAxNToxOCwgS2F2eWFzcmVlIEtvdGFnaXJpIHdyb3RlOg0KPiBMQU45NjZ4
IFNvQyBoYXZlIDUgZmxleGNvbXMuIEVhY2ggZmxleGNvbSBoYXMgMiBjaGlwLXNlbGVjdHMuDQo+
IEZvciBlYWNoIGNoaXAgc2VsZWN0IG9mIGVhY2ggZmxleGNvbSB0aGVyZSBpcyBhIGNvbmZpZ3Vy
YXRpb24NCj4gcmVnaXN0ZXIgRkxFWENPTV9TSEFSRURbMC00XTpTU19NQVNLWzAtMV0uIFRoZSB3
aWR0aCBvZg0KPiBjb25maWd1cmF0aW9uIHJlZ2lzdGVyIGlzIDIxIGJlY2F1c2UgdGhlcmUgYXJl
IDIxIHNoYXJlZCBwaW5zDQo+IG9uIGVhY2ggb2Ygd2hpY2ggdGhlIGNoaXAgc2VsZWN0IGNhbiBi
ZSBtYXBwZWQuIEVhY2ggYml0IG9mIHRoZQ0KPiByZWdpc3RlciByZXByZXNlbnRzIGEgZGlmZmVy
ZW50IEZMRVhDT01fU0hBUkVEIHBpbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEthdnlhc3JlZSBL
b3RhZ2lyaSA8a2F2eWFzcmVlLmtvdGFnaXJpQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9tZmQvYXRtZWwtZmxleGNvbS5jIHwgODYgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDg0IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jIGIv
ZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jDQo+IGluZGV4IDMzY2FhNGZiYTZhZi4uZjg3ZWUz
NjA2ZWIwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21mZC9hdG1lbC1mbGV4Y29tLmMNCj4gKysr
IGIvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jDQo+IEBAIC0yOCwxNSArMjgsNjQgQEANCj4g
ICNkZWZpbmUgRkxFWF9NUl9PUE1PREUob3Btb2RlKQkoKChvcG1vZGUpIDw8IEZMRVhfTVJfT1BN
T0RFX09GRlNFVCkgJglcDQo+ICAJCQkJIEZMRVhfTVJfT1BNT0RFX01BU0spDQo+ICANCj4gKy8q
IExBTjk2NnggZmxleGNvbSBzaGFyZWQgcmVnaXN0ZXIgb2Zmc2V0cyAqLw0KPiArI2RlZmluZSBG
TEVYX1NIUkRfU1NfTUFTS18wCTB4MA0KPiArI2RlZmluZSBGTEVYX1NIUkRfU1NfTUFTS18xCTB4
NA0KPiArI2RlZmluZSBGTEVYX1NIUkRfTUFTSwkJMHgxRkZGRkYNCg0KR0VOTUFTSygpID8NCg0K
PiArDQo+ICtzdHJ1Y3QgYXRtZWxfZmxleF9jYXBzIHsNCj4gKwlib29sIGhhc19mbHhfY3M7DQo+
ICt9Ow0KPiArDQo+ICBzdHJ1Y3QgYXRtZWxfZmxleGNvbSB7DQo+IC0Jdm9pZCBfX2lvbWVtICpi
YXNlOw0KPiArCXZvaWQgX19pb21lbSAqYmFzZSwgKmZsZXhjb21fc2hhcmVkX2Jhc2U7DQoNCkFk
ZCBhIG5ldyBsaW5lIHdpdGg6DQoJdm9pZCBfX2lvbWVtICpmbGV4Y29tX3NoYXJlZF9iYXNlOw0K
DQo+ICAJdTMyIG9wbW9kZTsNCj4gIAlzdHJ1Y3QgY2xrICpjbGs7DQo+ICB9Ow0KPiAgDQo+ICtz
dGF0aWMgaW50IGF0bWVsX2ZsZXhjb21fbGFuOTY2eF9jc19jb25maWcoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgYXRtZWxfZmxleGNvbSAqZGRhdGEgPSBk
ZXZfZ2V0X2RydmRhdGEoJnBkZXYtPmRldik7DQo+ICsJc3RydWN0IGRldmljZV9ub2RlICpucCA9
IHBkZXYtPmRldi5vZl9ub2RlOw0KPiArCXUzMiBmbHhfc2hyZF9waW5zWzJdLCB2YWw7DQo+ICsJ
aW50IGVyciwgaSwgY291bnQ7DQo+ICsNCj4gKwljb3VudCA9IG9mX3Byb3BlcnR5X2NvdW50X3Uz
Ml9lbGVtcyhucCwgIm1pY3JvY2hpcCxmbHgtc2hyZC1waW5zIik7DQo+ICsJaWYgKGNvdW50IDw9
IDAgfHwgY291bnQgPiAyKSB7DQo+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIkludmFsaWQgJXMg
cHJvcGVydHkgKCVkKVxuIiwgImZseC1zaHJkLXBpbnMiLA0KPiArCQkJCWNvdW50KTsNCj4gKwkJ
cmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+ICsJZXJyID0gb2ZfcHJvcGVydHlfcmVhZF91
MzJfYXJyYXkobnAsICJtaWNyb2NoaXAsZmx4LXNocmQtcGlucyIsIGZseF9zaHJkX3BpbnMsIGNv
dW50KTsNCj4gKwlpZiAoZXJyKQ0KPiArCQlyZXR1cm4gZXJyOw0KPiArDQo+ICsJZm9yIChpID0g
MDsgaSA8IGNvdW50OyBpKyspIHsNCj4gKwkJY29uc3QgY2hhciAqZmx4X2NzOw0KPiArDQo+ICsJ
CWlmIChmbHhfc2hyZF9waW5zW2ldID4gMjApDQoNCkNvdWxkIHlvdSB1c2UgYSBtYWNybyBmb3Ig
MjA/DQoNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJCXZhbCA9IH4oMSA8PCBmbHhf
c2hyZF9waW5zW2ldKSAmIEZMRVhfU0hSRF9NQVNLOw0KPiArDQo+ICsJCWVyciA9IG9mX3Byb3Bl
cnR5X3JlYWRfc3RyaW5nX2luZGV4KG5wLCAibWljcm9jaGlwLGZseC1jcyIsIGksICZmbHhfY3Mp
Ow0KDQpXb3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8gaGF2ZSBwbGFpbiB1MzIgY29uc3RhbnRzIGlu
c3RlYWQgb2Ygc3RyaW5ncyBoZXJlPw0KDQo+ICsJCWlmIChlcnIpDQo+ICsJCQlyZXR1cm4gZXJy
Ow0KPiArDQo+ICsJCWlmICghc3RyY21wKGZseF9jcywgImNzMCIpIHx8ICFzdHJjbXAoZmx4X2Nz
LCAiY3RzIikpDQo+ICsJCQl3cml0ZWwodmFsLCBkZGF0YS0+ZmxleGNvbV9zaGFyZWRfYmFzZSAr
IEZMRVhfU0hSRF9TU19NQVNLXzApOw0KPiArCQllbHNlIGlmICghc3RyY21wKGZseF9jcywgImNz
MSIpIHx8ICFzdHJjbXAoZmx4X2NzLCAicnRzIikpDQo+ICsJCQl3cml0ZWwodmFsLCBkZGF0YS0+
ZmxleGNvbV9zaGFyZWRfYmFzZSArIEZMRVhfU0hSRF9TU19NQVNLXzEpOw0KDQpJIG1heSBtaXNz
IHNvbWV0aGluZyBidXQgSSBkb24ndCBzZWUgaGVyZSB0aGUgYXBwcm9hY2ggeW91IGludHJvZHVj
ZWQgaW4gWzFdOg0KDQorCQkJZXJyID0gbXV4X2NvbnRyb2xfc2VsZWN0KGZseF9tdXgsIGFyZ3Mu
YXJnc1swXSk7DQorCQkJaWYgKCFlcnIpIHsNCisJCQkJbXV4X2NvbnRyb2xfZGVzZWxlY3QoZmx4
X211eCk7DQoNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgc3RhdGlj
IGludCBhdG1lbF9mbGV4Y29tX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICB7DQo+ICAJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiAr
CWNvbnN0IHN0cnVjdCBhdG1lbF9mbGV4X2NhcHMgKmNhcHM7DQo+ICAJc3RydWN0IHJlc291cmNl
ICpyZXM7DQo+ICAJc3RydWN0IGF0bWVsX2ZsZXhjb20gKmRkYXRhOw0KPiAgCWludCBlcnI7DQo+
IEBAIC03NiwxMyArMTI1LDQ2IEBAIHN0YXRpYyBpbnQgYXRtZWxfZmxleGNvbV9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCSAqLw0KPiAgCXdyaXRlbChGTEVYX01SX09Q
TU9ERShkZGF0YS0+b3Btb2RlKSwgZGRhdGEtPmJhc2UgKyBGTEVYX01SKTsNCj4gIA0KPiArCWNh
cHMgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7DQo+ICsJaWYgKCFjYXBz
KSB7DQo+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIkNvdWxkIG5vdCByZXRyaWV2ZSBmbGV4Y29t
IGNhcHNcbiIpOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCg0KQXMgSSBhbHJlYWR5IHNhaWQgb24g
WzFdOiB5b3UgcmV0dXJuIGhlcmUgYnV0IHRoZSBjbG9jayByZW1haW4gZW5hYmxlZC4NClBsZWFz
ZSB0YWtlIGNhcmUgdG8gdW5kbyBwcmV2aW91cyBvcGVyYXRpb25zLg0KDQo+ICsJfQ0KPiArDQo+
ICsJaWYgKGNhcHMtPmhhc19mbHhfY3MpIHsNCj4gKwkJZGRhdGEtPmZsZXhjb21fc2hhcmVkX2Jh
c2UgPSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAxLCBOVUxM
KTsNCj4gKwkJaWYgKElTX0VSUihkZGF0YS0+ZmxleGNvbV9zaGFyZWRfYmFzZSkpDQo+ICsJCQly
ZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LA0KPiArCQkJCQlQVFJfRVJSKGRkYXRhLT5m
bGV4Y29tX3NoYXJlZF9iYXNlKSwNCj4gKwkJCQkJImZhaWxlZCB0byBnZXQgZmxleGNvbSBzaGFy
ZWQgYmFzZSBhZGRyZXNzXG4iKTsNCg0KRGl0dG8NCg0KPiArDQo+ICsJCWVyciA9IGF0bWVsX2Zs
ZXhjb21fbGFuOTY2eF9jc19jb25maWcocGRldik7DQo+ICsJCWlmIChlcnIpDQo+ICsJCQlyZXR1
cm4gZXJyOw0KDQpEaXR0bw0KDQpbMV0NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAy
MjA1MDkwODQ5MjAuMTQ1MjktNS1rYXZ5YXNyZWUua290YWdpcmlAbWljcm9jaGlwLmNvbS8NCg0K
PiArCX0NCj4gKw0KPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShkZGF0YS0+Y2xrKTsNCj4gIA0K
PiAgCXJldHVybiBkZXZtX29mX3BsYXRmb3JtX3BvcHVsYXRlKCZwZGV2LT5kZXYpOw0KPiAgfQ0K
PiAgDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGF0bWVsX2ZsZXhfY2FwcyBhdG1lbF9mbGV4Y29t
X2NhcHMgPSB7fTsNCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBhdG1lbF9mbGV4X2NhcHMg
bGFuOTY2eF9mbGV4Y29tX2NhcHMgPSB7DQo+ICsJLmhhc19mbHhfY3MgPSB0cnVlLA0KPiArfTsN
Cj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXRtZWxfZmxleGNvbV9v
Zl9tYXRjaFtdID0gew0KPiAtCXsgLmNvbXBhdGlibGUgPSAiYXRtZWwsc2FtYTVkMi1mbGV4Y29t
IiB9LA0KPiArCXsNCj4gKwkJLmNvbXBhdGlibGUgPSAiYXRtZWwsc2FtYTVkMi1mbGV4Y29tIiwN
Cj4gKwkJLmRhdGEgPSAmYXRtZWxfZmxleGNvbV9jYXBzLA0KPiArCX0sDQo+ICsNCj4gKwl7DQo+
ICsJCS5jb21wYXRpYmxlID0gIm1pY3JvY2hpcCxsYW45NjZ4LWZsZXhjb20iLA0KPiArCQkuZGF0
YSA9ICZsYW45NjZ4X2ZsZXhjb21fY2FwcywNCj4gKwl9LA0KPiArDQo+ICAJeyAvKiBzZW50aW5l
bCAqLyB9DQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYXRtZWxfZmxleGNvbV9v
Zl9tYXRjaCk7DQoNCg==
