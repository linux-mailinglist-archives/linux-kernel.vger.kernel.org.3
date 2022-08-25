Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09A5A0883
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiHYFmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHYFmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:42:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE8D87681;
        Wed, 24 Aug 2022 22:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661406165; x=1692942165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xJ8SjMugtIfiGhfHg+IuFU7YoxiLchtmtoR/72e5oY4=;
  b=VEDbNAcpuCnLQ7aNSlRGouFQKeL50Hxg01bZJ50bWxuvz7KJWlFOUQue
   6iDjqnjBCIygRAB4xHoHxMcxdOL+nBoxjnc4A1N1khLFmTK4eOHrFBTbO
   5MB/pMuWkdjFmBuy56xPGam/ByDEjtUTSlYXbLm88e7aKLiJo4We8170u
   kZARQIYbSpThUTwxonePFxJS28HhfM3X5N5SjW6t/ShdjQ30/NKwusc2H
   arvPsvpRXkf1cJAC25u272KkgKpGdPw7hxGGN3APFUJ/gI/Iv0XjQAFvu
   Ftj40Bsx1NZ04vCO7ddQ8FEdqkqBph3WLys1nKiqVpe57hYvQZ2hDPaZE
   A==;
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="174054810"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 22:42:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 22:42:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 24 Aug 2022 22:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwH654Jn/v+C/GI/lE5KTnWC12kgHfgdHYKfaSoogvAW/PZLPuBYpuXj1/Si+a251cvayra7T2L5sv3hxhuH+Fb1xN23Ta/GDe/0InFJc+GukKJCndoQkZ7lb89dhamozqGBtAUB0dGK1VseYAgUSgvzcxxBGW/M3SC9ESTwWMBYZk3Y/tkqqNKzHmp7shTS285W5dFxZ2JzmbC6hxCYkuXZdpZOJ17I76/m7n3vsACf1Pr6758UdgT55ZnJG/niDm6PM9PCpy+EiG1urxyw9w39AQvYTdoAkC0rVgbpsoZUYiSHG+XBZWGg7Bo02mPCXnhovBmQ8KPAaTq3KG12cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJ8SjMugtIfiGhfHg+IuFU7YoxiLchtmtoR/72e5oY4=;
 b=kSixtnq2VabdNGlLiH0xgGJsVY3xrivI85mrmWbSeM42m51PCoclbIDQ2IWFqU3X6V9amFuy4MdOY3AmTwwilM6u1iQryKQxTpcEZ+uJDC9wIucZVvepUemZvw81ZmEJcfr0FhPUh1UFbrGRK4e1kcUvGRRWhkpgtiEjsu5hR1JreNw3RtXiHXBvu2IYalcJFjS+XIM/ODVOJfyU2HtgoS1E4hDIfGBE8Oh1ufuycvnuz90iugmYOf8iZXfUypAo5OJuhpsBKFT4W1yLl3orco4ApoCrX9iDuK09RFN56v6cP2o8Wdc7M8RdH6opCqWE3RwL5+rx47nm2Co+tXwX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ8SjMugtIfiGhfHg+IuFU7YoxiLchtmtoR/72e5oY4=;
 b=MfVeTJOpvGi1OeEr3mlza93w8MB1zNqsIEaAG+J4w5xw6EkjXzAKLDV0BTcbjmjMn6PbKZT80RH3Io256XrcFb4X/+x75waJmMZMb0na2gsrr6NoHpAToPXmWnbOPNpU0wsDuWCmhNatj3VPSU+gq4JIHUvnxkA2M2C4gIP3iWk=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM6PR11MB4755.namprd11.prod.outlook.com (2603:10b6:5:2ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 05:42:42 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%10]) with mapi id 15.20.5566.015; Thu, 25 Aug
 2022 05:42:42 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <dengshaomin@cdjrlc.com>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>, <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH] pinctrl: at91: Fix double word in comments
Thread-Topic: [PATCH] pinctrl: at91: Fix double word in comments
Thread-Index: AQHYuEV+GGIsEWuvxUOcKXpZKJaJow==
Date:   Thu, 25 Aug 2022 05:42:42 +0000
Message-ID: <cbf2164c-332d-9787-31d0-3c5f8ff53d93@microchip.com>
References: <20220825014921.6135-1-dengshaomin@cdjrlc.com>
In-Reply-To: <20220825014921.6135-1-dengshaomin@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c592555-69e9-44e3-45ae-08da865ca125
x-ms-traffictypediagnostic: DM6PR11MB4755:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GUlFe29Fkx7p9czmJQ4suJ1mEqou93CE0qjgyqlFQfY0TKGIMr5jyUNE1fuA/l5dpp2GMIyM/GdLFSg4P9HkiYM7OgCYYEo/t/HzOL/h4xW1P+aP+pUoxRk9I9Ro4QzTai6a2JsxKH2YUnC0V+2ZyHkj+30rhbJD8zk3eBMCN/XlnwFZ4lOiwv6ZqksIBnftRAcBdZt14r1qgVWguFCr+9VzV9V8+Fl1ICrdds97J8tO3ldUy+LhI0pzSruWLS2SetDRlkvn7tTjagjSwOMbrqSY7eiZX2UZOMUQ/HDSeXdZrFmxTTThVl10EnvS+dhWG5jmQyoXEXlPNQ2Da8MEj7uvAxNWrLKRPQ1k8Fhnmd7gKfVVT34RkAPLHPX1QB45Nm4puOwOFPexeL0DmJaHk8avCd87sXaX1wfGSFK5Z/10Y+kc/NTGeMaqsGX2tML7OOxKss2Gy2/x27po5IEs/qR6ky3DBiTBVwnaJzQqZ+2AsoERsH/j3RP7clBdmq+0k0L4FhgnWq5viLEM4gJsbVvRB7nK5CduEj1GDzyExW6ltpMyO3WiW1y4fok9q41Pt43v3bvdVim/Tqj8jM2UfsdLaaS1r5xGEEIZ9y+9PFTedlJwxh60y93iuwGNGBHOcmQLMMW93m9q+n3IYHFIQF2VuFjEtDu/aA02TBacijoFn445WRBOrwAW7m/ab5xKX3yYBPjuQiAAiB1MblfxROPjNBCCG52gPyUYVogXI8QQiC69hCjiQABDXBCeFoCL9Rr1WvsjBLUsMWxTlAtT75C2WC82Cgr0ELRJUhuZUKbLgsiZc5NCXtWUgdI75pVc54Oa2UC9h6RJiNJn8bsCuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(376002)(136003)(346002)(186003)(38070700005)(38100700002)(122000001)(64756008)(83380400001)(66946007)(76116006)(8936002)(66446008)(66476007)(5660300002)(66556008)(4326008)(8676002)(31686004)(91956017)(2906002)(36756003)(316002)(53546011)(6506007)(41300700001)(26005)(6512007)(966005)(54906003)(6486002)(86362001)(110136005)(71200400001)(478600001)(2616005)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K09RQWRYSzdWa3dGYkR6eGNINjl1QkYzdHJnZDd4WkdhTVFPNXhuY3hQTnJv?=
 =?utf-8?B?Z01KNlB5bXMxa2k3c1BUWUFwdlJ4MC84eWpLYTNzOGNVWndQdStJRkE4MkJE?=
 =?utf-8?B?dXRVL0Q3WDI2NTc2bWU1NGRoNjFqcjdZbjlaS2tVRnhzUEsyZ1B0OEtqUWlw?=
 =?utf-8?B?Vi9OTm51c1p3N1ZYN0dENCtNQmJRc1dlc2FrTEZoVnFadnhWUmoxMnBpY0VY?=
 =?utf-8?B?TFZjazhJUHBxWVlFUmdYR25kOHVqTlMweHNqbUVaZ0xEQ1pRZWdWajRXMlA3?=
 =?utf-8?B?V2NTZHRoOTZkcUlnVUdpYXJqR0FtUm9BZ3Z0eU5JcVNGS2ZEdW9WdzZ5Tkgw?=
 =?utf-8?B?ZU9WWEpHNVZMNVQ1ODV1OWZ2UXg0QXJ2UnRUdVpDMDBYSUxmMFppZTdoMFY0?=
 =?utf-8?B?S2lLR2xIWGZMZmNXK0lVLyszZG9CWko5ellzUFg1MFVraVIzY1ZndnBYNzNs?=
 =?utf-8?B?bEVJZVZKczEwZDRyMjFCR2tRT0ZwMUpLNk16dnZnTnNnYzdDSUh5alBrcU5O?=
 =?utf-8?B?WVhPUUQ5QXVzY2dLc2tzNHpCb2pqT1llUzZZZThmdUlkcDVSbDVJdFpnUjk4?=
 =?utf-8?B?UHRxSmdXWjJ4T29QK0JHZTVCVWVLNHhZblZaNjdLb2lEZE9SY202bXNsRnBk?=
 =?utf-8?B?bGU1aTNhZHUxQ3JYWU4xTzQ0NitScWM5SkEwSU5iSElBN1hVbUdSYlNVRExY?=
 =?utf-8?B?WTRCeHBZYzcwRGZwQWZQWUpCQWpsQnovVDV4MzVleHdjeXdlSU9CUEF3cGVz?=
 =?utf-8?B?dHV5ZmxYeGhkVThFdmloRjZZelgrbzVBUHExSkt6Z3BSeWtSZi9oZ3NmR2xQ?=
 =?utf-8?B?b1l2dDEwTEg5M1lvWkVHRnJ2MVdwOU5NcHNJazdGbkFwN05wZ1NoT3hKcVN0?=
 =?utf-8?B?a2p4cmRtUEdMSGhscm5TUTZPbDZXUVU0Z2dPV2lWd0RRWHlNOWg4VUtVNHRy?=
 =?utf-8?B?bzlvaDRaOU5FTnB2RkltY1ZSRXhqRUdoaHNFUnd6dFRma2c3Wi81ZXZ0SSsv?=
 =?utf-8?B?NTRvYnZUV0JXc25sbVJ5U3E2bFphTlpJTUVhelVIZ1R1MnJpNHpPUy8rS1RG?=
 =?utf-8?B?MnZTTkpza0VLWkwrWlhzT2lBamlHeHdBdVgrOEcrYk5kK29zN2pVdmZ2MzRk?=
 =?utf-8?B?UGVSV2o4d2V1UURPRDdleDJCSGVBZE53Wm1jTE9tNFVIUG1zbDd4Sjh2Mkh2?=
 =?utf-8?B?SXdIbEFTSElqb3ZsQ3hmL2JzeGo3UTVMZkJ3akhtcmlsS2V5RWVwOVFoY0M4?=
 =?utf-8?B?emhqZEhsM3dJZlgyMzFKVWhsYVRHQkRWNnA1MDFmam13SzNJazZaeURTeFds?=
 =?utf-8?B?MzEwK0xmT1FpNjkzQVFYczJJQ0NQT1NLWVlhblB4Umk2NnhtSnFvcWhpTVhB?=
 =?utf-8?B?a0F0L3g4L1ljY2ozVnBNTUZhNVhoZUdvbWFDM2grZytVVkRad2FuZk9aTndn?=
 =?utf-8?B?TUJCQ3diMzhXa29jdnUvY2dFanhxSlZjUC8zTjBmc1J4NGM1MFpobmV5dWFv?=
 =?utf-8?B?WFBna2JrOWd2ZDBBMEVYRVYwNXYzK1JLaWJTaDFOZzJHcjBGaXZBZnFHUVl3?=
 =?utf-8?B?emFmUEowR284bFVsdWx3WjJZSWg1eWlQWmRzaVF5S3c4YitYNkJxaUZsUVo5?=
 =?utf-8?B?ODNleWlBaE5XTDJrV3UwYVVGMExDSVVTY1ppNzBYOGdTL0plbXBOSG5UY1Fo?=
 =?utf-8?B?SEFLQ2xYeVE3Z0hYR1dDZUFpVk1ycTR5OEdaVmJHNWFKY1ZveTE3Tis5ZHVi?=
 =?utf-8?B?VFFxank1bXVQUUt4MWkxRGJqcHhIeFhlZEYzbGFEWEVDcHkyR0xxY21YZll5?=
 =?utf-8?B?OStBUnE2c051eHcvNGJmZUpMUEp1d0F0MmlEQ0s0N21IVlpTcngwcHlJMk1N?=
 =?utf-8?B?dHBSQ0xqc2JDbHhTK2UrQWdNbU5DVFY5TlVuaGUwajhUR2VMK2l5ZjdzNzNs?=
 =?utf-8?B?S1NZWUVkNk1jMU5qbmFVbVFmSWRHSWFVS2VmcjVCaVpDRThabGZKUmxqUk9D?=
 =?utf-8?B?MlZmMnpVWWphVnlqbDBobEtZMGlWQm9FWFdNdGVQcnI3ZHpvNFRZNDN0ZnZs?=
 =?utf-8?B?QUdJYXlwUElPWlhXTHl2VFNHcnBoQWNna09SRmtBQVEwMWhML0xOa1dlKzM5?=
 =?utf-8?B?QXBvSVFUa05yVFJ1U1R1LzF2S3AzVVA3TTZFbGV4dlpsY05JVlE3SVMvM09S?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AE8271EC738324D87F4990F7C1AF557@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c592555-69e9-44e3-45ae-08da865ca125
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 05:42:42.4877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWGwQIaeQtTyWmW/8ykC2duBqxiPWs9jsIgYeFLNjkVdg2rLw1E3aZwzV57eVwyS+5i99A2J7OGWDWUkyavebWMP+FX8oT3pPoUNDnYtcmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4755
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUuMDguMjAyMiAwNDo0OSwgU2hhb21pbiBEZW5nIHdyb3RlOg0KPiBbU29tZSBwZW9wbGUg
d2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBkZW5n
c2hhb21pbkBjZGpybGMuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6
Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRGVsZXRlIHRoZSByZWJ1bmRhbnQgd29y
ZCAidGhlIiBpbiBjb21tZW50cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNoYW9taW4gRGVuZyA8
ZGVuZ3NoYW9taW5AY2RqcmxjLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3BpbmN0cmwvcGluY3Ry
bC1hdDkxLmMgICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy94ZW4veGVuLXBjaWJhY2svcGNpYmFj
a19vcHMuYyB8IDMgKystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1h
dDkxLmMgYi9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMNCj4gaW5kZXggZDkxYTAxMGU2
NWY1Li5mMTIzNGU3MTllNTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGluY3RybC9waW5jdHJs
LWF0OTEuYw0KPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMNCj4gQEAgLTE3
NDgsNyArMTc0OCw3IEBAIHN0YXRpYyBpbnQgYXQ5MV9ncGlvX29mX2lycV9zZXR1cChzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiAgICAgICAgIHdyaXRlbF9yZWxheGVkKH4wLCBhdDkx
X2dwaW8tPnJlZ2Jhc2UgKyBQSU9fSURSKTsNCj4gDQo+ICAgICAgICAgLyoNCj4gLSAgICAgICAg
KiBMZXQgdGhlIGdlbmVyaWMgY29kZSBoYW5kbGUgdGhpcyBlZGdlIElSUSwgdGhlIHRoZSBjaGFp
bmVkDQo+ICsgICAgICAgICogTGV0IHRoZSBnZW5lcmljIGNvZGUgaGFuZGxlIHRoaXMgZWRnZSBJ
UlEsIHRoZSBjaGFpbmVkDQo+ICAgICAgICAgICogaGFuZGxlciB3aWxsIHBlcmZvcm0gdGhlIGFj
dHVhbCB3b3JrIG9mIGhhbmRsaW5nIHRoZSBwYXJlbnQNCj4gICAgICAgICAgKiBpbnRlcnJ1cHQu
DQo+ICAgICAgICAgICovDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9w
Y2liYWNrX29wcy5jIGIvZHJpdmVycy94ZW4veGVuLXBjaWJhY2svcGNpYmFja19vcHMuYw0KPiBp
bmRleCBlMzhiNDNiNTA2NWUuLjUyZGE3NWJmODQ4NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy94
ZW4veGVuLXBjaWJhY2svcGNpYmFja19vcHMuYw0KPiArKysgYi9kcml2ZXJzL3hlbi94ZW4tcGNp
YmFjay9wY2liYWNrX29wcy5jDQo+IEBAIC0xNjAsNyArMTYwLDggQEAgaW50IHhlbl9wY2lia19l
bmFibGVfbXNpKHN0cnVjdCB4ZW5fcGNpYmtfZGV2aWNlICpwZGV2LA0KPiAgICAgICAgIH0NCj4g
DQo+ICAgICAgICAgLyogVGhlIHZhbHVlIHRoZSBndWVzdCBuZWVkcyBpcyBhY3R1YWxseSB0aGUg
SURUIHZlY3Rvciwgbm90IHRoZQ0KPiAtICAgICAgICAqIGxvY2FsIGRvbWFpbidzIElSUSBudW1i
ZXIuICovDQo+ICsgICAgICAgICogbG9jYWwgZG9tYWluJ3MgSVJRIG51bWJlci4NCj4gKyAgICAg
ICAgKi8NCg0KVGhpcyBzaG91bGQgZ28gaW4gYSBkaWZmZXJlbnQgcGF0Y2guDQoNCj4gDQo+ICAg
ICAgICAgb3AtPnZhbHVlID0gZGV2LT5pcnEgPyB4ZW5fcGlycV9mcm9tX2lycShkZXYtPmlycSkg
OiAwOw0KPiANCj4gLS0NCj4gMi4zNS4xDQo+IA0KDQo=
