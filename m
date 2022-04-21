Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079E3509E36
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388670AbiDULFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245056AbiDULFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:05:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D15B1582C;
        Thu, 21 Apr 2022 04:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650538958; x=1682074958;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qJkVYBuXTO0J3pw7EJapz95GEksM4cLykmlXxZcwpE0=;
  b=NiITA/CSF+FWE67gAeNRWR2KXjbH4qiAqp8OiRJ3BksNfqIvRIDQkw10
   1fQ9GD9T0luqlMSHaqWBD3tZzX6d0hksZivEpRiMRcnd/dbCfO+aBGaho
   LNWLiX0v1vRAzfHT4TFMyb6cjujbHCj9EUa7ks30aHpO/oY4gKYL8lD4t
   HmGBrKtXdbAhRvXBKlVZgub0aj7MvABJya+LZ7kbu5CYNzVwMuxXi04SN
   rG0cICxSDuQ5DQVLvd+R631afzILkWFNwl+w/lpvv+B45G7XY4rTwkdXq
   +3IgaGirznQHfshonS/JP8U2NbFFGRtHGF/6qU3XGn97RswF3tYCBzbm9
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643698800"; 
   d="scan'208";a="93087130"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2022 04:02:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Apr 2022 04:02:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 21 Apr 2022 04:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRt8+s6bXlmyCqSf1Y+JVss1gVp2zGWHDyershvXFmEu2DCZXaUHhS2ifZKqTK8TKab87zr90RE37qPf4XckqjvcL0r/lE0gL8oV2zalqCvsSzUiwY0AcTlQ7mOYh2PN/lOhnX48SwytJDC8NWICkDTS0GQmMoaXywu/NqoE572kSulJ+Fo43rQZUV5rSTxybVToMCwHEG9e0vZ26q7LG7SObxxNRMx1vMpRZHHPLf4jimoToX5nCTyN6Bavtn06M7alDGUQ/tR42JrTunzzShJ2xV/S0vZjgciUOBOol6GQMTwi4L2AmYkggYDbBghgNJ9qDRezaJi6U+l7PHgOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJkVYBuXTO0J3pw7EJapz95GEksM4cLykmlXxZcwpE0=;
 b=gF0iZXDngZeOCmFayuPwt1KReVy7+JD8gi64xAIWit5ud5FXMUNA1kTXzlGzm7mDnuubyOddJoV86hZimTvMg4I/FHkWSdjproU2b5+SN/ChvwgevQwGiT8Q12ImRcJviyEfssqKOzJb0tYjM0fkfB4OaAU351TK7o4RvcEHvIzgQzTlh2nYfqeBRZLnXHskdT0kWNc4inpca8yd3Nxw5hW3FCnxrhIZjFw2aCR163Xi8kDW+AWsC/r4yZAsLuPk56tmGxar5Srv+mgWMHfHAJASiE11aP7SWpPXO+YYqhP5F0eg9YQ0GiTUafRTK+Y+OXITPj80LqsimBEzMqPCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJkVYBuXTO0J3pw7EJapz95GEksM4cLykmlXxZcwpE0=;
 b=Vodk6ZPqs0I5tTBio+FrAo80jJgPMYIt4+Ks6iD0ce2B4Ak9bSbDFzRt0Z9iM4nYehLCY6pUrN7QXEbNCG2tZs47BxLokuKLTsgRRTcNBnhFPBg4kUH7Znh4svQt79xBforXLwMHNnYzhvRYPzAKCv4MS+uQEdiEpdqpwDOFTWA=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MWHPR1101MB2223.namprd11.prod.outlook.com (2603:10b6:301:54::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Thu, 21 Apr
 2022 11:02:35 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 11:02:35 +0000
From:   <Conor.Dooley@microchip.com>
To:     <naresh.kamboju@linaro.org>
CC:     <zong.li@sifive.com>, <lkft-triage@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <palmer@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <bmeng.cn@gmail.com>,
        <sfr@canb.auug.org.au>, <linux-next@vger.kernel.org>
Subject: Re: [next] riscv: sifive/fu540-c000.dtsi:171.4-42: ERROR
 (duplicate_property_names): /soc/dma@3000000:compatible: Duplicate property
 name
Thread-Topic: [next] riscv: sifive/fu540-c000.dtsi:171.4-42: ERROR
 (duplicate_property_names): /soc/dma@3000000:compatible: Duplicate property
 name
Thread-Index: AQHYVW13ed28jdglL0mqf+BONPXO2qz6M6mA
Date:   Thu, 21 Apr 2022 11:02:34 +0000
Message-ID: <41f85208-9b53-bb45-729a-0faed85f6cda@microchip.com>
References: <CA+G9fYvnf3Ys+ptCJf1fNOc1rjTiSEEY9Gxbc49eOrx227xOoQ@mail.gmail.com>
In-Reply-To: <CA+G9fYvnf3Ys+ptCJf1fNOc1rjTiSEEY9Gxbc49eOrx227xOoQ@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48f3a8c5-e512-4e48-45de-08da238670c0
x-ms-traffictypediagnostic: MWHPR1101MB2223:EE_
x-microsoft-antispam-prvs: <MWHPR1101MB22232942652D726EA752887798F49@MWHPR1101MB2223.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IBYBnpFKw83YQU0kRZ+lyeEeDYr5J3nFWyiHZ7rdmStxjnH3yOJ2fxnHqUK78s79nQv/8Wd2ixLvcBReX/d2JbqwDqx86cgiDslXFCW/o3OiWgVf5AvtBy459hqvCcx0+QEnuoNehYfbTNpo9HtRI1DymnoFOHQ8SKlCaY0RRKXu5Nc/r/hfbF0xn647sAn7CZP9GgFZ+zfTQ271Uf0Cw5pdVycDaKSKaBVc68pDqRXZNQM3VKzEIq4WqEthl0tOlinf3WnnlMsXuDOqwFhX7WzKT/JPStGFsvMTIT322yBV2bmVk7kg8icdH8HCCtnlt3cPdD9sJXzzvgzxZ+yZlxjec3iVdJCvdjVoya6Z/yrIlDeneFIb+dAlvAl0vyAvZfPXcMPw5V2KRc64d3IJxzz219y97nFBKai0cx7UQmpTyP83w+iL841fxbstMK7SWVqOoofLyYCCc78M0xMMz2UZPZLsyRsQz2cqGkKWdvsH8VmAzdKWn3TYT+hUM7s1HkAnnOXkDbi2nlqJweX7c4gct8tMk8wFg7b/dHazO63px/MPiRQilJ9mGLVc0WWCkX/AraKiKfImhP+BOwFXNepxbiclaG5UBR+BSLLHzN0Pv5aDQY2JSfVMcbEKPnzWJ9SEiyubaAjt9KDU+aQVd8t+Kfz0eDvTLQkyfbF6tUkDNvR46sqiZ6nRNFysClaDlxg4nq4AonLmGRVwvB+ArI+ul7G2NAj2dbt173jMRiUML6kL+ZDgV+J/yVcMyNcGYTrJyMJsZG+UsQBv2GDo2laG3BSJkGraYd5HbkqaP6j5Z4RogyuSiV2XmXbI3g6S3Ri2pRjmMKFVpCv2HOEbdV5+Z5cMN8eti13ibgWA5hQtpbx6oAddVVnIffTz380V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(122000001)(6916009)(8936002)(6506007)(66556008)(8676002)(64756008)(66446008)(71200400001)(54906003)(53546011)(4326008)(86362001)(76116006)(91956017)(66476007)(31696002)(966005)(6512007)(83380400001)(31686004)(66946007)(38100700002)(26005)(36756003)(2616005)(316002)(5660300002)(2906002)(186003)(38070700005)(45980500001)(220923002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3NsQldlOEJ2UU1DamtUWGtOZGtIL09BRFRVOFR5RkxCR1B6NUZYSkdLRCt0?=
 =?utf-8?B?NnVYZ2Y3cnNaZmozYVJMTDV2VW4zMklqS2NrcnQvc09ST3lGZ3g5YjJxVGJq?=
 =?utf-8?B?c0swSGJ1cVhmZkJ5b01ybU5xcDlwUXhldWJtTEkrOVRrQW1HR1ZZcXB6czdJ?=
 =?utf-8?B?cHkwaTA4UDI3Y1h2bG9nQk9lUWhCcnV5SmFqV1FYelgyQlNQRnVwejZHRTBm?=
 =?utf-8?B?eTRueXhySVhiTS9kRVZsUmFlbUhwRG11NDNSNGNMK2p2b3d1YnExSzlzTjc3?=
 =?utf-8?B?a3pLRDZ5eUR6cTRpNEtHSldraVBQbGp0MytKajJudjdpOFkyWmF4emsvck1k?=
 =?utf-8?B?UEhSSGozTHc3T1BpcHM1bWh6TVJGWUpjS3JPZGtMem1LenRTTHhKc2lxRUZC?=
 =?utf-8?B?UE1UMzVhNWw2eFFSd0dxLzNIa3JrQ2hRUFBDYVAzYnU3NS9MbjRvWlBhUk9T?=
 =?utf-8?B?d0xkanN3dXJVZUxvK1NPQTZJZkx0eVpnaVhkcDdVaGdmTGZ0ZHQwQjZGV0k4?=
 =?utf-8?B?YlRRZXpYVnJsci9iZTVJZThXVHVhNUZKQjBuKzRKejZ0R2JsSG1PUitoM2RM?=
 =?utf-8?B?ZTNmOWlURnNkYjFQSWpOU2xkNFhxcWRRM3o4L2hORGtIZjFtM0U1dzBsbGlE?=
 =?utf-8?B?VmkyL01oUnd0TDVDanF4enk1bWc1UFl2a0xsemFuLzRtaXFuWXQ2Qk5aZnU4?=
 =?utf-8?B?UFNHWkQra2FhK3o2S2lWb1AwRXJ3citSMzhzVnYvSWNHQlBRbGhWWUtPNjA1?=
 =?utf-8?B?aFJqVWhXVGRVb0kxcVhQKytwcEpLQW05WUt3T0hZQTlpYTB1d0VSWFA2TWNJ?=
 =?utf-8?B?eXp5QkVLcERRVmZFb0dhT0J6T0pldjFLN0pMdmdQbWlJOVcxL1JoSFRuMldC?=
 =?utf-8?B?WXlwNnlOTXJHRDBZYlUwMWJBdStzdlAwMS9hS0RCQjRvSFFhU0RINXZramVV?=
 =?utf-8?B?MnJtdG5JVWIzVTE3K1VjV3JQN0dMRWZkamJDL2RxbWdLQzhmVE1YK1FMbURD?=
 =?utf-8?B?em93UWpjU2FBYzUyLy9yNXZ3OHZwNlZSUzdQVFY1NmRrV0lJaUJYZnA4WkZr?=
 =?utf-8?B?QjhsOVBWUFE1T01XVUUzU1ZBYVFQd0dCZjYxUjdYdVRzd013SVd3N0tvanRW?=
 =?utf-8?B?TTlNTEEzRmVDL2dReHRtazlrdFZRbDJ2OTJTM29kSFNJaUhMQ3JTdVp5UjBz?=
 =?utf-8?B?V1FHSWVuNENnajJ2N0t2N0ExYktuazgxblR5Z0lKYXk5VlJiUGNkOGp5Z0p2?=
 =?utf-8?B?NWxnMFVoVmhtTGZxazlmNFQ2TEFiVUt3WTZtSnlUcmRnTnBCNVh0NDNZSXkv?=
 =?utf-8?B?SFQ2eGNrNERyZnNUK1NPYTZqdDdWc0p4dDFkYzAzQkpERjZkUUFQeHlJeTI5?=
 =?utf-8?B?Z1N5ZFBBNERjQldNUXZldmtBdlYwMDJaWHVvc1hmTWZLeVNzeUIyYjgxTkJi?=
 =?utf-8?B?REZPWTF3RkxGdE1kbFlraEUvK3plNnFLcnRoUmpaYk45aFFzemVQb3BpUnls?=
 =?utf-8?B?dzhpU1IvM1JFaEliTmJEdEdZM3dLTlFyTVQwbE5DODRXZkVucVl3NDRpd3RX?=
 =?utf-8?B?QXdGYTFjcUs0YW85alFvTTFUd2tMbCtNRFBaNGkxMk90WFlhaEdQZkt0Uk5L?=
 =?utf-8?B?TEdiUTJHMDFpL0VkRGF4ZXIrNFI2U290bHRwZmQyNzMzUjFCdkUxM1NnZlFp?=
 =?utf-8?B?a1FpbFJOSHNILzdCNGpNQmN0MWRqcTIwTVNnV2ZCdjdCOFNQQjFpSlZCUzI3?=
 =?utf-8?B?NEFtN2xFNVhIdDNCeXk5cFpCakZwQ0hnMDRnVFZKalNjbHZJb1oxazBxOVVr?=
 =?utf-8?B?aWJQZ2pyMmcxOUtlV3Z2UVBScVJubG5qSXJaK3RSRmpSNW0xU016Y3kycTR4?=
 =?utf-8?B?enJuVUZGREFkc3BSaXl6R1VxbkNqdCs5SHFmSXBCaHQrb0ptSHRyUHJHVVVK?=
 =?utf-8?B?UjRwS2dOLzFpK1hEM25HM29HY0FiVFI5Uy90RGIxODloMDcxaUc0Z1hwNENk?=
 =?utf-8?B?K0VBR1pqUXFyMmpJUHdwbDFubzFYOVRiK01GSERpL2JKUUM0aHI4QUkzTFA3?=
 =?utf-8?B?cWFhMHF3dXFxd3JuN0NxN01UQWx2V1dZNmpBelAxellkbWh4MVRGOWlCbDdV?=
 =?utf-8?B?YkVCbmNRc0d5cmFBVnQvbkNuenZTNXBRYUVTUVErOVVEKzNDMXFVZDI1dU1Z?=
 =?utf-8?B?d0VMMnYwMUNPckFoM2RMNVFoby85NTRLT3paR2hQSVJ3WTJaRmdab3QvbXdq?=
 =?utf-8?B?K1MxWFVrN1dzemtkVmFHWFljdUdicThtUkNvY1JocDFzRHB1V3hWcHdoMytB?=
 =?utf-8?B?Y1draUpkaTkyaDBJSktYY3l0eGx1cWFld2dYNVREOFVxcjNRQm5LQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97BD51DA22E520449C3E53AE20C9CD26@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f3a8c5-e512-4e48-45de-08da238670c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 11:02:34.9960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYz2jU+K7Kr62kFXwWR3Pq+9DWPrDI/gbklnCFlzfYUgxhGYJcwbTe9kMzboOBaAAEdwS34YjpXWElr5EgtKVddS9rRv6ue9aFIkzDht3Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2223
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjEvMDQvMjAyMiAxMDo0OSwgTmFyZXNoIEthbWJvanUgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gTGludXggbmV4dC0yMDIyMDQyMSByaXNjdiBk
ZWZjb25maWcgYnVpbGRzIGZhaWxlZCBbMV0uDQo+IA0KPiBSZWdyZXNzaW9ucyBmb3VuZCBvbiBy
aXNjdjoNCj4gDQo+ICAgICAtIHJpc2N2LWNsYW5nLTEzLWRlZmNvbmZpZw0KPiAgICAgLSByaXNj
di1jbGFuZy0xMi1kZWZjb25maWcNCj4gICAgIC0gcmlzY3YtZ2NjLTEwLWRlZmNvbmZpZw0KPiAg
ICAgLSByaXNjdi1jbGFuZy1uaWdodGx5LWRlZmNvbmZpZw0KPiAgICAgLSByaXNjdi1jbGFuZy0x
MS1kZWZjb25maWcNCj4gICAgIC0gcmlzY3YtZ2NjLTgtZGVmY29uZmlnDQo+ICAgICAtIHJpc2N2
LWNsYW5nLTE0LWRlZmNvbmZpZw0KPiAgICAgLSByaXNjdi1nY2MtOS1kZWZjb25maWcNCj4gICAg
IC0gcmlzY3YtZ2NjLTExLWRlZmNvbmZpZw0KPiANCj4gYXJjaC9yaXNjdi9ib290L2R0cy9zaWZp
dmUvZnU1NDAtYzAwMC5kdHNpOjE3MS40LTQyOiBFUlJPUg0KPiAoZHVwbGljYXRlX3Byb3BlcnR5
X25hbWVzKTogL3NvYy9kbWFAMzAwMDAwMDpjb21wYXRpYmxlOiBEdXBsaWNhdGUNCj4gcHJvcGVy
dHkgbmFtZQ0KDQpLcnp5c3p0b2YgYWxyZWFkeSBzZW50IGEgZml4IGZvciB0aGUgZHVwbGljYXRl
Og0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvMjAyMjA0MjEwNjU0MDEuOTMw
My0xLWtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZy8NCg0KPiBFUlJPUjogSW5wdXQgdHJl
ZSBoYXMgZXJyb3JzLCBhYm9ydGluZyAodXNlIC1mIHRvIGZvcmNlIG91dHB1dCkNCj4gbWFrZVsz
XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmxpYjozNzY6DQo+IGFyY2gvcmlzY3YvYm9vdC9kdHMv
c2lmaXZlL2hpZml2ZS11bmxlYXNoZWQtYTAwLmR0Yl0gRXJyb3IgMg0KPiANCj4gZHJpdmVycy9w
Y2kvcGNpLWRyaXZlci5jOjUzMzoxMjogd2FybmluZzoNCj4gJ3BjaV9yZXN0b3JlX3N0YW5kYXJk
X2NvbmZpZycgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQ0KPiAgICA1
MzMgfCBzdGF0aWMgaW50IHBjaV9yZXN0b3JlX3N0YW5kYXJkX2NvbmZpZyhzdHJ1Y3QgcGNpX2Rl
diAqcGNpX2RldikNCj4gICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4NCj4gbWFrZVsxXTogVGFyZ2V0ICdfX2FsbCcgbm90IHJlbWFkZSBiZWNhdXNlIG9mIGVy
cm9ycy4NCj4gbWFrZTogKioqIFtNYWtlZmlsZToyMjY6IF9fc3ViLW1ha2VdIEVycm9yIDINCj4g
DQo+IA0KPiBSZXBvcnRlZC1ieTogTGludXggS2VybmVsIEZ1bmN0aW9uYWwgVGVzdGluZyA8bGtm
dEBsaW5hcm8ub3JnPg0KPiANCj4gVGhlIHJlY2VudCBwYXRjaCBvbiB0aGlzIGZpbGUuDQo+IEkg
d2lsbCBydW4gbXkgYmlzZWN0IHNjcmlwdCBhbmQgZ2V0IGJhY2sgdG8geW91Lg0KPiAtLS0NCj4g
cmlzY3Y6IGR0czogQWRkIGRtYS1jaGFubmVscyBwcm9wZXJ0eSBhbmQgbW9kaWZ5IGNvbXBhdGli
bGUNCj4gDQo+IA0KPiBBZGQgZG1hLWNoYW5uZWxzIHByb3BlcnR5LCB0aGVuIHdlIGNhbiBkZXRl
cm1pbmUgaG93IG1hbnkgY2hhbm5lbHMgdGhlcmUNCj4gYnkgZGV2aWNlIHRyZWUsIGluIGFkZGl0
aW9uLCB3ZSBhZGQgdGhlIHBkbWEgdmVyc2lvbmluZyBzY2hlbWUgZm9yDQo+IGNvbXBhdGlibGUu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBab25nIExpIDx6b25nLmxpQHNpZml2ZS5jb20+DQo+IFJl
dmlld2VkLWJ5OiBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyQHJpdm9zaW5jLmNvbT4NCj4gQWNrZWQt
Ynk6IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAcml2b3NpbmMuY29tPg0KPiBBY2tlZC1ieTogQ29u
b3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEJp
biBNZW5nIDxibWVuZy5jbkBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBhbG1lciBEYWJi
ZWx0IDxwYWxtZXJAcml2b3NpbmMuY29tPg0KPiANCj4gU3RlcHMgdG8gcmVwcm9kdWNlOg0KPiAt
LS0tLS0tLS0tLS0tLS0tLS0NCj4gIyBUbyBpbnN0YWxsIHR1eG1ha2Ugb24geW91ciBzeXN0ZW0g
Z2xvYmFsbHk6DQo+ICMgc3VkbyBwaXAzIGluc3RhbGwgLVUgdHV4bWFrZQ0KPiAjDQo+ICMgU2Vl
IGh0dHBzOi8vZG9jcy50dXhtYWtlLm9yZy8gZm9yIGNvbXBsZXRlIGRvY3VtZW50YXRpb24uDQo+
ICMgT3JpZ2luYWwgdHV4bWFrZSBjb21tYW5kIHdpdGggZnJhZ21lbnRzIGxpc3RlZCBiZWxvdy4N
Cj4gDQo+IHR1eG1ha2UgLS1ydW50aW1lIHBvZG1hbiAtLXRhcmdldC1hcmNoIHJpc2N2IC0tdG9v
bGNoYWluIGdjYy0xMQ0KPiAtLWtjb25maWcgZGVmY29uZmlnDQo+IA0KPiANCj4gLS0NCj4gTGlu
YXJvIExLRlQNCj4gaHR0cHM6Ly9sa2Z0LmxpbmFyby5vcmcNCj4gDQo+IFsxXSBodHRwczovL2J1
aWxkcy50dXhidWlsZC5jb20vMjg2OGFubEt3VFA4YWF2bzE5TFQ2S1JJcTFULw0KDQo=
