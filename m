Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3285B1506
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiIHGrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIHGrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:47:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB8FD21FD;
        Wed,  7 Sep 2022 23:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662619646; x=1694155646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3gtdWlKVtU+pBjXCqs/RB53FB0EU+8jCwGkjP9t0PU8=;
  b=jHZ2zQhoO4QvxoRLkRoZqToAu7Sn1qB9u1hdxxVq6tWPRI/bp823aWsZ
   ni4cUT0MxnuI55c+0Cib872zp4DvNxmTE2okeWRbZSJF56wINyFgTTGao
   QVSveOPxBFho40fcxaLFjnBYSsHyG2yaRAFqauusbcDrMoPGPUe6X+ScJ
   kgy9jmeI/my0+j50PQSSgXxU8uafQfVZVF+VYfE7C4RaDu7no4KX/N/Y3
   58s9xNRGyDCawwz+c0ozRSqkHFfKjOcrF6eGmVGxx4ZTTVBD7iKGFKYzs
   EJDgtJJB0liVRhOA0FzRxnKSdxe0HnrsrveFJltbhT+r09/J8ZZCp74/E
   A==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="112686629"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 23:47:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 23:47:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 23:47:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHaNwCvl71caK+e6jBRKlAhYqgHuBvu95ibHec+KHPKhz+XDRQqiUPl4dlyi/ftUM/jlRAPU5nFtY3d1pQIS6bfNypMROLcnRlVlV552847KiKZyPf0axrNWTVZETJiJYIe8KaTmTrN4rXsp5zgxqt7n/pejE8eMbHu3lZeTIrv4n2IEImHKzaYTohb6tjqlyNeCZ45dGiOH8XLSfJNbRzBlZ6scdeuKR77KIz0YdBnBhLEAhEL+L+EyXkVC+R6B7xehguhmmRU7rOSBlFTKqKIXlGGhTm2Ux6QFLi1391DSDD8GwyLkrPEkAJ2UP8A8VtGjD3ltquaOjM6rIK5YzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gtdWlKVtU+pBjXCqs/RB53FB0EU+8jCwGkjP9t0PU8=;
 b=RucY2+aTq0Qs8ZdD9j6rR6nCcmUtE6jB4O8//51VZsY0xxGsjzYtgk+6B/eY++d5SFMG6bpXVL3oNQIx2+Pnk2AntKZwgVVe+2eIeHchCOhQbaTXb/hzD9IRRP6IUia/vkj5F5uKoE4sb7V9XT2mVt1USCRUG7WSuPxvzqEKCjW4pC6x17jVtfhJPp0UkwpCRDnzo/L/SiETvhH0cQ96mpMgyIXOtJ0fPmMM2Pwb5uMNfH4KDyKXZjA5QFXIKNcAkEwCm/CRxJf7qk+m3Chg3tyIG7bsqY8R+0DcMtnGQZ5pBA01AWJedXWt/apku0DQk4qj0joW5GxPzt1TI9RJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gtdWlKVtU+pBjXCqs/RB53FB0EU+8jCwGkjP9t0PU8=;
 b=TuKj9t1jHkjcGRPRhCwR8+NiHqMknazxGdVt7EufxafW5d+FJRSRX/TqojX3J0e9zyq3a8Ot6oL4xBsbAZdMdc9FPUOqppdYrUTMIjZm8x4qh3/jONt6w89SiCafNL1T8FXtnOjP1baS9dp+PYbF0K+HRUPOXEapgNpbX9Mn5LQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 06:47:14 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 06:47:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 11/13] clk: microchip: mpfs: convert cfg_clk to
 clk_divider
Thread-Topic: [PATCH v4 11/13] clk: microchip: mpfs: convert cfg_clk to
 clk_divider
Thread-Index: AQHYw07UZ0PbuV0vJUa1xA2NaCuUtw==
Date:   Thu, 8 Sep 2022 06:47:14 +0000
Message-ID: <5719c8a9-1c15-fc66-7747-6e029a15b4c6@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
 <20220830125249.2373416-11-conor.dooley@microchip.com>
In-Reply-To: <20220830125249.2373416-11-conor.dooley@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2618d600-a456-47cd-1ed3-08da9165f6e9
x-ms-traffictypediagnostic: PH7PR11MB5766:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Co233hQQrwv/YGB0736Ml3178KxlEkGJnbon3Ke3tAih+PY9Jy6St0y1CMnjmNxDrHNcOExr6uJRXeAFgLu/XYJVeci0jStuGbW9ZpOht1cEuE5nv5CWmdtccmHj8rJn5JnopzmRLsoHRCiMexGvHnUJEYF14bxHVLwZ4MVriv7cnNLy1YmZd+03dq45DwInPzr+2JE7DrElZKd7Cv5VaxTjZcYoJlPm5LLvK79U00Zuvva/16kLtwMQkEnaFjPwUIySts89QYvoDi137k71JtIlpRiDSPwsrXwn98Qd+N6MfqqyaQrOCf6tBZRsCcfa1Hc85bjFaClk/c4LH/hudPpNYCNz0RHVHzZZvL8MglugAG3J+EuTEMD0i0UmRIb/atdDrWSLaP7V35NXX+CdYXPm5c2wYkYmIiH8/hvzkx3XtF4MpQyTwXJbq+DIFgClRSiNYz9dEQ35APE8vPAiTheEy9V+DxXZJDumVmNtJCYfbrkPBKFywneJLwgK3SQwDiimx5A15dfLnZq3ySSW2+o4dZyziK6OfGwT9/370do0BjBOSmCjtaA38HX14GJjgV59l8gogxVDSAMl6Am7oZXcqg1mU9XqlB76dBcGDUw6nqsVqDQKC/GFVyHzM2oQ78sfdC7bguGJ7u6PlG5xKHTO3DY+IJqq/WdFeYN3UqmF0+0SELC0Vo5mO7tdxVt1cOHpLixojekMiuXS1/XtW6dFHUILxllrtV0iYB5U8K64tj9t3V+M1mrpem7j2cai1PA7gIwgXc0b2DT8NmWgjssqyyNiBpa+gXrAa7MibGvKL87JtQxTO7sNtufSx46WSHwgpyb1fanCZD6nnHX4Sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(396003)(376002)(346002)(66556008)(110136005)(316002)(2906002)(6636002)(83380400001)(6512007)(53546011)(6506007)(478600001)(54906003)(26005)(7416002)(5660300002)(38070700005)(31696002)(36756003)(86362001)(8936002)(66476007)(91956017)(66446008)(66946007)(64756008)(8676002)(31686004)(122000001)(4326008)(186003)(71200400001)(41300700001)(38100700002)(76116006)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1lERjNIZXY4MFR0aWxiNWQrdWZ1Y09ibi9leWRPMW8vQyt2WkJTT1VPdWJN?=
 =?utf-8?B?bkZpRXJqRW5RL0UrUE01NlNTNnRobFo0djlMbE1saktDL3k1ejdjZHBpRzVj?=
 =?utf-8?B?Zk5JSmdMRGU2UTVxSDFBa1htR0pmNlpaeGFrY1hZMjRjS1JmS1prM3dYcm9L?=
 =?utf-8?B?Tnh6L1FUVndxZVkzRFpvSGpOZ1NzV1BucUlBbU5WWVo4RThNWW1uTlVjY3RT?=
 =?utf-8?B?S3NJbjhEUysxZkE0VzJDSDNyZUxkK2EyOHN3WEFQSGNZTDNwTTQzYkxKTWxr?=
 =?utf-8?B?RFQvUW5HeTRUUTlDcjdIbkptd0s5ZkJ2NHEwekx4WXJpK3diazNQbXZwWXJ4?=
 =?utf-8?B?OVZ4Z3VFV256R0FPTUJsdUhiUHpxcXBRUTExWGg0akpjdytKWTd2TVFHazVu?=
 =?utf-8?B?Z0hvNzlBcTc4amtXMVpKOFVUcDIwdGZWeTl0bVFWd2dPLy9aTXJ6OHNvQUcv?=
 =?utf-8?B?OFowdkFUMWlPUVBLY3NMRDNmWUdkWWppMzIzSm9JaXBPZThGMzNkNTVIZUxX?=
 =?utf-8?B?Zi9mOEhaWm5mZkFNL2FSKzdMeXlHbUxURjZ4NjdXbU53d2ZqMEJMcXl2UGls?=
 =?utf-8?B?VVN6bkZvWmZVVWs2ekpTK0JDZHlPb01yWnFFeUwzd2gvOWhwME1HNFRvc25B?=
 =?utf-8?B?Z1dIcHdCQzFSZzEramlUZW55a3RxQ2MzYU5EencxbXlMZFZ0ZVlOUFUxcklm?=
 =?utf-8?B?R3VmU0dNU0FhcUcyaUg5OC84cEgzYTFVUmtOdDVFc0cvbWF4SFgxdkk1WndV?=
 =?utf-8?B?SCtwWWhJaGd1SDlnSy93dHFCOGEzWFBhYzdqSHlvakZ3ekxDcVIvdEl5OWUz?=
 =?utf-8?B?Mk5FTVE0T3VtcFFGK3JsVkErNkUzUDFBQlkrZUQ1SjEzS0hHbzlUQldoWmFE?=
 =?utf-8?B?YVVJZ0ZTMHhQWXhLWXZWMytxOFBMcW4wUHdTRjZMeEtjSHhHQUY2TUJybTJJ?=
 =?utf-8?B?NUU2b3MvZjJKRUdVTDhDOXMxeVJSR3dIREhicFRLTUZvY2RobnRLT0JxVmVs?=
 =?utf-8?B?Z1NDUVJPS05INHVraU83OXNsYVl0amdPS1hsQUV6ZzBSQnRlTjU0TUhVNGJX?=
 =?utf-8?B?ZE9GL0U1VnJLRzBhZ2xrZnVSZ0RNbTdNM3dOY3NYQTI5WVFTOTV4ODRvUDNE?=
 =?utf-8?B?ZHlHLzZQTGkvUlcxZk5KVE9JZEthQnY0RDF6UXBGdDNIR0R3eE42VGR5dWhq?=
 =?utf-8?B?b00wUURKWUpFaVRsb3RGZEdUdGVla2IzMEgzRjEzNXk5VnE1bHlXcHR0cUZl?=
 =?utf-8?B?MkZnUzJBOVpLNFdNSitWVEJ2b3ZVNmI3VWNpNWsyVkVlRHpacEhJcVBFdk1B?=
 =?utf-8?B?dkMrYzlQMVhLeFQrTG1mdWpWREY3TVY3R3JyR2o5d1hFeHZTN2ltaXdORmUx?=
 =?utf-8?B?Zk9hQlVZLzk3UlpGMkFMcG5TQlAvVkFPWGZ0b0tmZVROMlBFVEhvQXV2bHlR?=
 =?utf-8?B?SkJPY0NIMG8xOXpXS09lVlB0Z1ZaUlMrbjNiNUZneGFaZFc0VEVrcnJCa1dn?=
 =?utf-8?B?d0VnOFNEUS9Yajd3TGJpUCszNDlyNWNKbVVYTHRoS1hCc25CUnVDd0VEOXln?=
 =?utf-8?B?cWhUbWtVKzVMalg3Yi9FYWVCdFFNSzZvSFZGNjlYREIvdkR0Q2tsMGd0eXlO?=
 =?utf-8?B?MDZKOGpFQnBzYWJwVktZRHBXajJNMlpLaEpkVy81dmN2WWE4MlhVV3J0bnhK?=
 =?utf-8?B?Q0FURktNKzNndWFFT3UreXF1azdxc0ltMTk3Qm9QbXVLOVpIcGU1aVRoTDNI?=
 =?utf-8?B?QUJveW9maHVmTGh3UkVCYjlEUWlMZnpSa2grODRmUC8xUkRHd0R3TzdudHlO?=
 =?utf-8?B?STlwL1NmRmNtZG5WRnpvd2pzT2tYdDNzVmdTenc5c0FscnNZSG94SDFYM1ZZ?=
 =?utf-8?B?UGd1K25kbXJjSXRYdzhEcnduUE9CNktCcnN5TEZlY1BXR010MS8rdkg2SUpx?=
 =?utf-8?B?YWt1MXJ5U0ZlS2pKWm5XNVgzay9yQ3NhU0YreUF0czZIeTRQWjBLZmVhc3JB?=
 =?utf-8?B?YUFyTUVQMitWZFJIMU9JcDVTbnpVakl2RnBFZTFEZ2pjUkg2RTUyYVIxTHdJ?=
 =?utf-8?B?QU81SW5TS0xML1JmNUNzVGFTRUs4bmJrcmRhNU9QVmlzcEVyMlJpd0FlR0FI?=
 =?utf-8?B?UUY0dmJ0NUt3SEVObWVCUTduRzFWUzUxcDBHRVhKSXFibEo3Z3U4dno4ckhs?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B2B9130C7066046B2255BEB81FC0229@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2618d600-a456-47cd-1ed3-08da9165f6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:47:14.6075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kq8Lj0s7Xr63EBApSo5nVp0mh/Tm3p5wyiumF3N6NtbocglHL+wn008qCSpPuK/sKr3EvumIAwGzwMkgqqP/mGp5HrwtLcrZkeztvSrDy9Y=
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

T24gMzAuMDguMjAyMiAxNTo1MiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBUaGUgY2ZnX2NsayBz
dHJ1Y3QgaXMgbm93IGp1c3QgYSByZWRlZmluaXRpb24gb2YgdGhlIGNsa19kaXZpZGVyIHN0cnVj
dA0KPiB3aXRoIGN1c3RvbSBpbXBsZW50YXRpb25zIG9mIHRoZSBvcHMsIHRoYXQgaW1wbGVtZW50
IGFuIGV4dHJhIGxldmVsIG9mDQo+IHJlZGlyZWN0aW9uLiBSZW1vdmUgdGhlIGN1c3RvbSBzdHJ1
Y3QgYW5kIHJlcGxhY2UgaXQgd2l0aCBjbGtfZGl2aWRlci4NCj4gDQo+IFJldmlld2VkLWJ5OiBE
YWlyZSBNY05hbWFyYSA8ZGFpcmUubWNuYW1hcmFAbWljcm9jaGlwLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoN
Cj4gLS0tDQo+ICBkcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1wZnMuYyB8IDc4ICsrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspLCA2OSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9taWNy
b2NoaXAvY2xrLW1wZnMuYyBiL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy5jDQo+IGlu
ZGV4IDUzOGNiNTg5ZDIzMi4uODhhMjAwZTg4ZTU0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Ns
ay9taWNyb2NoaXAvY2xrLW1wZnMuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xr
LW1wZnMuYw0KPiBAQCAtNTEsMjQgKzUxLDEzIEBAIHN0cnVjdCBtcGZzX21zc3BsbF9od19jbG9j
ayB7DQo+ICANCj4gICNkZWZpbmUgdG9fbXBmc19tc3NwbGxfY2xrKF9odykgY29udGFpbmVyX29m
KF9odywgc3RydWN0IG1wZnNfbXNzcGxsX2h3X2Nsb2NrLCBodykNCj4gIA0KPiAtc3RydWN0IG1w
ZnNfY2ZnX2Nsb2NrIHsNCj4gLQl2b2lkIF9faW9tZW0gKnJlZzsNCj4gLQljb25zdCBzdHJ1Y3Qg
Y2xrX2Rpdl90YWJsZSAqdGFibGU7DQo+IC0JdTggc2hpZnQ7DQo+IC0JdTggd2lkdGg7DQo+IC0J
dTggZmxhZ3M7DQo+IC19Ow0KPiAtDQo+ICBzdHJ1Y3QgbXBmc19jZmdfaHdfY2xvY2sgew0KPiAt
CXN0cnVjdCBtcGZzX2NmZ19jbG9jayBjZmc7DQo+IC0Jc3RydWN0IGNsa19odyBodzsNCj4gKwlz
dHJ1Y3QgY2xrX2RpdmlkZXIgY2ZnOw0KPiAgCXN0cnVjdCBjbGtfaW5pdF9kYXRhIGluaXQ7DQo+
ICAJdW5zaWduZWQgaW50IGlkOw0KPiAgCXUzMiByZWdfb2Zmc2V0Ow0KPiAgfTsNCj4gIA0KPiAt
I2RlZmluZSB0b19tcGZzX2NmZ19jbGsoX2h3KSBjb250YWluZXJfb2YoX2h3LCBzdHJ1Y3QgbXBm
c19jZmdfaHdfY2xvY2ssIGh3KQ0KPiAtDQo+ICBzdHJ1Y3QgbXBmc19wZXJpcGhfY2xvY2sgew0K
PiAgCXZvaWQgX19pb21lbSAqcmVnOw0KPiAgCXU4IHNoaWZ0Ow0KPiBAQCAtMjI4LDU2ICsyMTcs
NiBAQCBzdGF0aWMgaW50IG1wZnNfY2xrX3JlZ2lzdGVyX21zc3BsbHMoc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgbXBmc19tc3NwbGxfaHdfYw0KPiAgICogIkNGRyIgY2xvY2tzDQo+ICAgKi8N
Cj4gIA0KPiAtc3RhdGljIHVuc2lnbmVkIGxvbmcgbXBmc19jZmdfY2xrX3JlY2FsY19yYXRlKHN0
cnVjdCBjbGtfaHcgKmh3LCB1bnNpZ25lZCBsb25nIHByYXRlKQ0KPiAtew0KPiAtCXN0cnVjdCBt
cGZzX2NmZ19od19jbG9jayAqY2ZnX2h3ID0gdG9fbXBmc19jZmdfY2xrKGh3KTsNCj4gLQlzdHJ1
Y3QgbXBmc19jZmdfY2xvY2sgKmNmZyA9ICZjZmdfaHctPmNmZzsNCj4gLQl1MzIgdmFsOw0KPiAt
DQo+IC0JdmFsID0gcmVhZGxfcmVsYXhlZChjZmctPnJlZykgPj4gY2ZnLT5zaGlmdDsNCj4gLQl2
YWwgJj0gY2xrX2Rpdl9tYXNrKGNmZy0+d2lkdGgpOw0KPiAtDQo+IC0JcmV0dXJuIGRpdmlkZXJf
cmVjYWxjX3JhdGUoaHcsIHByYXRlLCB2YWwsIGNmZy0+dGFibGUsIGNmZy0+ZmxhZ3MsIGNmZy0+
d2lkdGgpOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgbG9uZyBtcGZzX2NmZ19jbGtfcm91bmRfcmF0
ZShzdHJ1Y3QgY2xrX2h3ICpodywgdW5zaWduZWQgbG9uZyByYXRlLCB1bnNpZ25lZCBsb25nICpw
cmF0ZSkNCj4gLXsNCj4gLQlzdHJ1Y3QgbXBmc19jZmdfaHdfY2xvY2sgKmNmZ19odyA9IHRvX21w
ZnNfY2ZnX2Nsayhodyk7DQo+IC0Jc3RydWN0IG1wZnNfY2ZnX2Nsb2NrICpjZmcgPSAmY2ZnX2h3
LT5jZmc7DQo+IC0NCj4gLQlyZXR1cm4gZGl2aWRlcl9yb3VuZF9yYXRlKGh3LCByYXRlLCBwcmF0
ZSwgY2ZnLT50YWJsZSwgY2ZnLT53aWR0aCwgMCk7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBpbnQg
bXBmc19jZmdfY2xrX3NldF9yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LCB1bnNpZ25lZCBsb25nIHJh
dGUsIHVuc2lnbmVkIGxvbmcgcHJhdGUpDQo+IC17DQo+IC0Jc3RydWN0IG1wZnNfY2ZnX2h3X2Ns
b2NrICpjZmdfaHcgPSB0b19tcGZzX2NmZ19jbGsoaHcpOw0KPiAtCXN0cnVjdCBtcGZzX2NmZ19j
bG9jayAqY2ZnID0gJmNmZ19ody0+Y2ZnOw0KPiAtCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+IC0J
dTMyIHZhbDsNCj4gLQlpbnQgZGl2aWRlcl9zZXR0aW5nOw0KPiAtDQo+IC0JZGl2aWRlcl9zZXR0
aW5nID0gZGl2aWRlcl9nZXRfdmFsKHJhdGUsIHByYXRlLCBjZmctPnRhYmxlLCBjZmctPndpZHRo
LCAwKTsNCj4gLQ0KPiAtCWlmIChkaXZpZGVyX3NldHRpbmcgPCAwKQ0KPiAtCQlyZXR1cm4gZGl2
aWRlcl9zZXR0aW5nOw0KPiAtDQo+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJm1wZnNfY2xrX2xvY2ss
IGZsYWdzKTsNCj4gLQl2YWwgPSByZWFkbF9yZWxheGVkKGNmZy0+cmVnKTsNCj4gLQl2YWwgJj0g
fihjbGtfZGl2X21hc2soY2ZnLT53aWR0aCkgPDwgY2ZnX2h3LT5jZmcuc2hpZnQpOw0KPiAtCXZh
bCB8PSBkaXZpZGVyX3NldHRpbmcgPDwgY2ZnLT5zaGlmdDsNCj4gLQl3cml0ZWxfcmVsYXhlZCh2
YWwsIGNmZy0+cmVnKTsNCj4gLQ0KPiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm1wZnNfY2xr
X2xvY2ssIGZsYWdzKTsNCj4gLQ0KPiAtCXJldHVybiAwOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMg
Y29uc3Qgc3RydWN0IGNsa19vcHMgbXBmc19jbGtfY2ZnX29wcyA9IHsNCj4gLQkucmVjYWxjX3Jh
dGUgPSBtcGZzX2NmZ19jbGtfcmVjYWxjX3JhdGUsDQo+IC0JLnJvdW5kX3JhdGUgPSBtcGZzX2Nm
Z19jbGtfcm91bmRfcmF0ZSwNCj4gLQkuc2V0X3JhdGUgPSBtcGZzX2NmZ19jbGtfc2V0X3JhdGUs
DQo+IC19Ow0KPiAtDQo+ICAjZGVmaW5lIENMS19DRkcoX2lkLCBfbmFtZSwgX3BhcmVudCwgX3No
aWZ0LCBfd2lkdGgsIF90YWJsZSwgX2ZsYWdzLCBfb2Zmc2V0KSB7CQlcDQo+ICAJLmlkID0gX2lk
LAkJCQkJCQkJCVwNCj4gIAkuY2ZnLnNoaWZ0ID0gX3NoaWZ0LAkJCQkJCQkJXA0KPiBAQCAtMjg1
LDcgKzIyNCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2xrX29wcyBtcGZzX2Nsa19jZmdfb3Bz
ID0gew0KPiAgCS5jZmcudGFibGUgPSBfdGFibGUsCQkJCQkJCQlcDQo+ICAJLnJlZ19vZmZzZXQg
PSBfb2Zmc2V0LAkJCQkJCQkJXA0KPiAgCS5jZmcuZmxhZ3MgPSBfZmxhZ3MsCQkJCQkJCQlcDQo+
IC0JLmh3LmluaXQgPSBDTEtfSFdfSU5JVChfbmFtZSwgX3BhcmVudCwgJm1wZnNfY2xrX2NmZ19v
cHMsIDApLAkJCVwNCj4gKwkuY2ZnLmh3LmluaXQgPSBDTEtfSFdfSU5JVChfbmFtZSwgX3BhcmVu
dCwgJmNsa19kaXZpZGVyX29wcywgMCksCQlcDQo+ICsJLmNmZy5sb2NrID0gJm1wZnNfY2xrX2xv
Y2ssCQkJCQkJCVwNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHN0cnVjdCBtcGZzX2NmZ19od19jbG9j
ayBtcGZzX2NmZ19jbGtzW10gPSB7DQo+IEBAIC0zMDIsOCArMjQyLDggQEAgc3RhdGljIHN0cnVj
dCBtcGZzX2NmZ19od19jbG9jayBtcGZzX2NmZ19jbGtzW10gPSB7DQo+ICAJCS5jZmcudGFibGUg
PSBtcGZzX2Rpdl9ydGNyZWZfdGFibGUsDQo+ICAJCS5yZWdfb2Zmc2V0ID0gUkVHX1JUQ19DTE9D
S19DUiwNCj4gIAkJLmNmZy5mbGFncyA9IENMS19ESVZJREVSX09ORV9CQVNFRCwNCj4gLQkJLmh3
LmluaXQgPQ0KPiAtCQkJQ0xLX0hXX0lOSVRfUEFSRU5UU19EQVRBKCJjbGtfcnRjcmVmIiwgbXBm
c19leHRfcmVmLCAmbXBmc19jbGtfY2ZnX29wcywgMCksDQo+ICsJCS5jZmcuaHcuaW5pdCA9DQo+
ICsJCQlDTEtfSFdfSU5JVF9QQVJFTlRTX0RBVEEoImNsa19ydGNyZWYiLCBtcGZzX2V4dF9yZWYs
ICZjbGtfZGl2aWRlcl9vcHMsIDApLA0KPiAgCX0NCj4gIH07DQo+ICANCj4gQEAgLTMxNywxMyAr
MjU3LDEzIEBAIHN0YXRpYyBpbnQgbXBmc19jbGtfcmVnaXN0ZXJfY2ZncyhzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCBtcGZzX2NmZ19od19jbG9jayAqDQo+ICAJCXN0cnVjdCBtcGZzX2NmZ19o
d19jbG9jayAqY2ZnX2h3ID0gJmNmZ19od3NbaV07DQo+ICANCj4gIAkJY2ZnX2h3LT5jZmcucmVn
ID0gZGF0YS0+YmFzZSArIGNmZ19ody0+cmVnX29mZnNldDsNCj4gLQkJcmV0ID0gZGV2bV9jbGtf
aHdfcmVnaXN0ZXIoZGV2LCAmY2ZnX2h3LT5odyk7DQo+ICsJCXJldCA9IGRldm1fY2xrX2h3X3Jl
Z2lzdGVyKGRldiwgJmNmZ19ody0+Y2ZnLmh3KTsNCj4gIAkJaWYgKHJldCkNCj4gIAkJCXJldHVy
biBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIGNsb2NrIGlkOiAl
ZFxuIiwNCj4gIAkJCQkJICAgICBjZmdfaHctPmlkKTsNCj4gIA0KPiAgCQlpZCA9IGNmZ19ody0+
aWQ7DQo+IC0JCWRhdGEtPmh3X2RhdGEuaHdzW2lkXSA9ICZjZmdfaHctPmh3Ow0KPiArCQlkYXRh
LT5od19kYXRhLmh3c1tpZF0gPSAmY2ZnX2h3LT5jZmcuaHc7DQo+ICAJfQ0KPiAgDQo+ICAJcmV0
dXJuIDA7DQo+IEBAIC0zOTMsNyArMzMzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfb3Bz
IG1wZnNfcGVyaXBoX2Nsa19vcHMgPSB7DQo+ICAJCQkJICBfZmxhZ3MpLAkJCQkJXA0KPiAgfQ0K
PiAgDQo+IC0jZGVmaW5lIFBBUkVOVF9DTEsoUEFSRU5UKSAoJm1wZnNfY2ZnX2Nsa3NbQ0xLXyMj
UEFSRU5UXS5odykNCj4gKyNkZWZpbmUgUEFSRU5UX0NMSyhQQVJFTlQpICgmbXBmc19jZmdfY2xr
c1tDTEtfIyNQQVJFTlRdLmNmZy5odykNCj4gIA0KPiAgLyoNCj4gICAqIENyaXRpY2FsIGNsb2Nr
czoNCj4gQEAgLTQxMyw3ICszNTMsNyBAQCBzdGF0aWMgc3RydWN0IG1wZnNfcGVyaXBoX2h3X2Ns
b2NrIG1wZnNfcGVyaXBoX2Nsa3NbXSA9IHsNCj4gIAlDTEtfUEVSSVBIKENMS19NQUMxLCAiY2xr
X3BlcmlwaF9tYWMxIiwgUEFSRU5UX0NMSyhBSEIpLCAyLCAwKSwNCj4gIAlDTEtfUEVSSVBIKENM
S19NTUMsICJjbGtfcGVyaXBoX21tYyIsIFBBUkVOVF9DTEsoQUhCKSwgMywgMCksDQo+ICAJQ0xL
X1BFUklQSChDTEtfVElNRVIsICJjbGtfcGVyaXBoX3RpbWVyIiwNCj4gLQkJICAgJm1wZnNfY2Zn
X2Nsa3NbQ0xLX1JUQ1JFRiAtIFJUQ1JFRl9PRkZTRVRdLmh3LCA0LCAwKSwNCj4gKwkJICAgJm1w
ZnNfY2ZnX2Nsa3NbQ0xLX1JUQ1JFRiAtIFJUQ1JFRl9PRkZTRVRdLmNmZy5odywgNCwgMCksDQo+
ICAJQ0xLX1BFUklQSChDTEtfTU1VQVJUMCwgImNsa19wZXJpcGhfbW11YXJ0MCIsIFBBUkVOVF9D
TEsoQUhCKSwgNSwgQ0xLX0lTX0NSSVRJQ0FMKSwNCj4gIAlDTEtfUEVSSVBIKENMS19NTVVBUlQx
LCAiY2xrX3BlcmlwaF9tbXVhcnQxIiwgUEFSRU5UX0NMSyhBSEIpLCA2LCAwKSwNCj4gIAlDTEtf
UEVSSVBIKENMS19NTVVBUlQyLCAiY2xrX3BlcmlwaF9tbXVhcnQyIiwgUEFSRU5UX0NMSyhBSEIp
LCA3LCAwKSwNCg0K
