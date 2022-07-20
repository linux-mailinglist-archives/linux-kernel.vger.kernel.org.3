Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7857B7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbiGTNrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbiGTNqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:46:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA35B065;
        Wed, 20 Jul 2022 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658324802; x=1689860802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VX78MYSmEIN4HsGfGWqX1d1mKjVFaTp4p6cOrI5T1ts=;
  b=EgFj4kbIpe0mqAcAVYTMrkj3z7LVCj44FyDFL3upnHyvrC9BGbMJO6BT
   TZmrwDYRr9IjXQ2oJi+RDaUP5YTkCaKtDVaixKx7PvMkazaXdMfa44SAA
   Dtl771NC6gwPz9oLrnSYOy5WFeZuKn/qkgq3/WPhHjvJAqKpx+5qYXsqf
   vAPqiXVs6x05mOOHMpbzADp0j2dUxf098hI7b309oQK5fvNR8qcSCXaZY
   479ztNJTnYZZ2NUJ2dlbknfIkLB3u8G0eZO9QAYFeFZ5dsu/U/so/tD7H
   wzW3V2LWWxRa1AdY6M2TXB7bgs99delkVmHP8SKIRu3P1WlHMgVdFKeo4
   g==;
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="172908208"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 06:46:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 06:46:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 20 Jul 2022 06:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iewdeQTgB12JmpP3q6p5AFS3hH/jBKG1x7H+TIhNJeDzJU2WnKNrS+qRAmrOYfwFo/bkmV2XNmfJLspTBEKi9zHd2hKJBPmDU62J3neHmLtWTPqSgGrASZBoBrGvdKtW//+HfTA9GQZX7PA9geXvEtkWnlWYxLCDmpbXWG37HY9YAqaZMgUu0k2XnyuNrZT/oMD6sqivsy4K1UlZtVo3E2zg7QK2j1r3/usNWGtvmRQMZEvgwKVhSq8WOtkEoa9z6a11baufcodbZqtN+m/728Lgt+Xf+UvDgbTAkZsim7c9n327zwnX3M/BBWdlYqTJA1PFIdKnNYtfDOhrumwBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX78MYSmEIN4HsGfGWqX1d1mKjVFaTp4p6cOrI5T1ts=;
 b=cjiTPoFxQ1jfAUzJv/ZvSfkvIXue1540cC0eWpGy/f2IsyxxyyG4I2JWButY5F+JdVTrYNnrXxyM71KPKRoigKqjLSosHffjK0LB53mpO3q5EAj6xQI8ZSBA4XEFKLn0pDCYwAoQuNwDk2tj5xeB5m3MO3+EIvXetTdP7FRporOOKi4vNzk9vbUe6/nsval+nD+1mgssrPjDRyw4WA1qvGkoH+aV1WTH8kItJWL5ne9Id6woyV9p4Dym3MHJUDpx4tKFKj3ukBnTzXqDvhFyMB+h4M4mt8QndlVWOZvqonpC6s49XW+h8CR6D4zmxVHyjeIGl3DlulzEK56nSMPVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX78MYSmEIN4HsGfGWqX1d1mKjVFaTp4p6cOrI5T1ts=;
 b=mZJSRNomBDQpn6vEiM3V/CG32Iqu82leiy4CT8SfgbAOPEswcdg5lFMF/OiJU9Bu3akWAMs8mW+q15dVoUrdbqTUDW2qM4v7HhNwbHTeDqhqexOHqBgD+jzV8n4KayldFYxBwVXsycPpQZDWEEqu5c3H6RxXtZJUnOBXjpLBEoY=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 13:46:26 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::6090:db2c:283b:fe69%9]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 13:46:25 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sboyd@kernel.org>
CC:     <palmer@dabbelt.com>, <robh+dt@kernel.org>,
        <Daire.McNamara@microchip.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>
Subject: Re: [PATCH v2 00/12] PolarFire SoC reset controller & clock cleanups
Thread-Topic: [PATCH v2 00/12] PolarFire SoC reset controller & clock cleanups
Thread-Index: AQHYj5/vIrxOVV1EL0SoHOsgiQHkyK2HXw2A
Date:   Wed, 20 Jul 2022 13:46:25 +0000
Message-ID: <ee72b966-433d-ae9e-4544-44ad1fd1abad@microchip.com>
References: <20220704121558.2088698-1-conor.dooley@microchip.com>
In-Reply-To: <20220704121558.2088698-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae19ab9a-43a1-4e91-79b2-08da6a563d7e
x-ms-traffictypediagnostic: LV2PR11MB6072:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r56X+wxcq0etRZbkTghMZN8lMlJYeCxiW5gN3vwxb58Cp1iUtOPhveEEYC5Tv6KfVdXvBaRvgBjpjMOylEH/0wnTodII/wnFYkSJYP7BPwrqF4zn38iI4RUhl9Wui0GKpXva7ODT6qrxHXNBxjq4RdQEESVCS1SJZYm8P44qVTsaRxdJBF9m/hwPcl1oAP90a9CUu+oyR31kfbVr9qoFZukP4nI204TgiQcTPoHP6iB1ZEgZVAHs69Yb8z9rO8NP3ZcQFlTgaNSsw8uNx1thOwM16RnnhYlPpPRKBGUzIYVgpctKrZeV3oZuEQL/lanjk4H3e/RT3xTRcnisAkq7GjvSl0Zqr+/7TLpriHeevs/ZFnZNmAndft5waTqtoS8YIOdqL8sItMkqvUDVT3TKZDOKU5uRQRsnypwWwZvyUN6GPe8hlOghFlqFGWjRbAxF6pZk/P5ihj9+M3zuJqGkLFApYmMh0uJ0715BZSWERiHnJHGjB5s9PQM/8OjkPwf755a7ulvEjkjgs6RfQw7YfNY3JJdZAbNbza9laURwbm728FfuJbZFn5uo9og3ywMjo9LiucwBYJVu37dn2UZ6Wt6CXu/cIvtW7pFqwLzC6rgO0w6zTvYMrQ61GLy4ll2OgIEBO9VdFkGG2wN2oogicfIOzAJDT2j+4xon/DfPOLInxsT8nQrhKAhsN0pd+PceE9v4eCGQailw38DtQwh726MxpnxA6uqWF/hhq9dEM6mB7SlOZ2zO7q16eMBYkv6bGGIvNqMGWY1U/b9KdkzoXsFrM6E3rfgdU2dUcFWFZ2OO8HQCC0mEcQuJiaXLqA8O22ETapgwMTjmltt6b82K5fhqNr96E6JW8IpkdCWwn16tLt3enSHw+v2Uiw+FiHarDCaQy3d9+KdPS3UVBUfdRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(396003)(39860400002)(136003)(6512007)(6506007)(31686004)(2616005)(71200400001)(53546011)(83380400001)(41300700001)(966005)(26005)(5660300002)(186003)(478600001)(6486002)(316002)(8936002)(8676002)(91956017)(54906003)(38070700005)(64756008)(76116006)(66556008)(66946007)(66446008)(6916009)(66476007)(122000001)(4326008)(2906002)(38100700002)(31696002)(7416002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEIwZUFXSGNWbmxCbjFLU05KVm85cVROZG5rTVBPc1EyVTBITnVNcmxHbXlP?=
 =?utf-8?B?cVRzNDgwRXFOaG4xZDNPNENaelVkdGJvczFpYlgyZU5ycUxSVmdKMVlKeG9Y?=
 =?utf-8?B?cTBWVGFSWXVqbmxtTjd6VlB1ODdnWUc3dHVxMnB4S2kvWHYyTktmd1NmT0dX?=
 =?utf-8?B?bU5Za2w1TzRTaTk4cVZORTFlTndiSzFubnRTMFlFZWRoZ3RVN0FwbDZmZFJR?=
 =?utf-8?B?Y1JsekxuZTh5dTRwVUlpaVFkR0RMOTRXbFlnV2JPK3lROE5idWppbEcwekVI?=
 =?utf-8?B?NThKczZGTmVFVjZ4N25xMmdTRFFNTnp0bnE1ZTc0dEpEZ3BMMGI2QmlDK2Ny?=
 =?utf-8?B?eEFJVDlPVnpkT2ppSGJlV01JdkVpVHlxN0lSdlV1WVMzaUc0ODlVN1RzMHFh?=
 =?utf-8?B?dkxMWXBFQXZoOXgzaWxROFNNZ3VFbzlDVWdTM2d0K3ZMVlFGMkRnZXptMGtU?=
 =?utf-8?B?QVd6UkEwc2FXdThBNlQrMS9pVS9INWN4VVdwTWUvejdIS2tHcDZWdTVOdXRL?=
 =?utf-8?B?YkdYNWduN09wOE5ya3B4aEMxZkZ6SFJ2Z1pBU1BJNSt2bkVXUVZTSyttN21r?=
 =?utf-8?B?NGFNUHdCc0ZJTjY2SndzalBWS0Z6eGZIQldDSFpnRTZLejUwOGpqalFOdkJB?=
 =?utf-8?B?YkF6TVJXVUhiOWRCRnNaNGRNYko2d0gyRkIwcmNLT2c0QXhYS1lBY2NlSEhz?=
 =?utf-8?B?TENWU3ljUytIWWIwL1ZpWGdqNFo1NjViNFcwWFJOekl4T3loaXYvSWdMc21V?=
 =?utf-8?B?ZXJ6NDlwQ3ZBbWlFNW1LTUg2RHgvZ3lyMVBWckpvckJnUnZwazRMTGgvdVMw?=
 =?utf-8?B?YWdYcUFHcktGaEN1RHhqb25sUWxGWWhMRzdvRURxakVsNXg1QnRFVWNWNTF2?=
 =?utf-8?B?SUszTlZCTXVTS2Q3SU5iZ2lWUnA4aitVVFF0OWxsMWJON05JQjBJY2Y3dGQz?=
 =?utf-8?B?cjNHVnUyZENmUHpQeWQ1RDFOMXQ4TmlQb0pjYWtkWG5qOFpORmtxbWg3ZWJy?=
 =?utf-8?B?QXdoSS9FOWxtRWJrNGNGeW5LYzJrdjZLY0hYTEQvd05yeE9OUUhkS1JCaW94?=
 =?utf-8?B?QXBORUhuQUF6NnRHQ3hEME9SRzJETldBN0RkVjdBN1RyRGlsVGdFbm5nN2tE?=
 =?utf-8?B?Qmw4MUJBbzRRTWhaaEhIdHlmdnEyclRYeVZqNDg1dEF5MVZxcDBvaTUzK2Ux?=
 =?utf-8?B?TStNbndkcFU2V3JLRTh5cndKTXdTeDRBOTBoTTZQMndycXdMZHhnVkx4QmhB?=
 =?utf-8?B?M1VNbXVGYjcvRkI0YmY3QncxWWYzQ3NuQnN1VU1FTzBrK1Zta1hDbWFlUExK?=
 =?utf-8?B?WGdIcDJVTEJnYXp5WUFZbmJEZzF3a1I0L3Q5akxYUWhsckg5REpYUytvMUNQ?=
 =?utf-8?B?blQwY3pydUUwRUVRdkJQU2hVdzRGdUVCSVh2Sm9wcTRUVXBWeC91QkoxcTZk?=
 =?utf-8?B?L1MrNysvSjNWdFZBNCtMcmQrdmczcGNqdHp4elJJUDF0eXlvUUxOc1FTVko2?=
 =?utf-8?B?cmtpS2IrSlVBZkx0bFZsU09PZ2ExVUd5UzVBUE5lUXRYbUlQU3pCQmNrS3px?=
 =?utf-8?B?cE1Jc3N1RnVTbVl4bkNuOU80MHVQaXphVHNKZ29VUjdvSEJra1Q5SUE1YXZy?=
 =?utf-8?B?K0xTSGhqa3NOcVpkZmFtUDNtZ0pHQkxiRGdJODRvT2dCZERTYlpqd0t1QlM3?=
 =?utf-8?B?cHFxWU9LSDY2YzVtY3ZHbWc4YmE2T0pLbjRXMzc1TjNHdUZNRXN0czVOaVpN?=
 =?utf-8?B?NmhJNnpaWVNiZ2ErRjNnV0ZPR1VSYkQ5bHFmRFcvTWE1NlZ3aFY0dGY3QUlO?=
 =?utf-8?B?ZjJOZytNZUtnTmRzdU9NcnF5d3dlNUZkWkNiOWc3RmR2UUxsSllQTHQ1V3Vy?=
 =?utf-8?B?aGFzZXFhdjF6bWNJSENPK0RIYlRjV2VJSjBCbWJRd0pEMkp0aTZxU3RrZlRB?=
 =?utf-8?B?MUsrVHpnMzJ1WVBEZEt4MUZNdU9HcTY1TmtDVkpVTVM3aTFSVEhWbWRSRTYw?=
 =?utf-8?B?ZjV5Tlc5MlJvVVhvQm9rNHg0enYzQVlQMllKT0xXQ0J3c1l1WGcrOE02d1BK?=
 =?utf-8?B?N1lndlJ5dUZLMkVGbmE4UnNudlpLOU9XZm9tUHBkWGhRMXYyVVpBOVFtbDdk?=
 =?utf-8?Q?zWETkQ2b01PyPL1Yk0Yk+J3PU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0636A56930088849848797144B4E2809@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae19ab9a-43a1-4e91-79b2-08da6a563d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 13:46:25.7464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THwG4l2jtEogE+aiRi7xwWAvGjZHNa0XM0GsY9h9C+8BhBtF2+Rw699Kq8+6s79SDF9m1h1KgwN4Nk6lfn/0EjICHoPDGDYRMC81oi538OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQvMDcvMjAyMiAxMzoxNSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBIZXkgYWxsLA0KPiBJ
IGtub3cgSSBoYXZlIG5vdCBzYXQgb24gdGhlIFJGQyBJIHNlbnQgYWJvdXQgdGhlIGF1eC4gYnVz
IHBhcnRzDQo+IGZvciB0b28gbG9uZywgYnV0IGZpZ3VyZWQgSSdkIGp1c3Qgc2VuZCB0aGUgd2hv
bGUgdGhpbmcgYW55d2F5IHRvIGFsbA0KPiBsaXN0cyBldGMuDQoNCkhleSBTdGVwaGVuLA0KDQpB
bnkgY29tbWVudHMgb24gdGhlIGNsay9hdXhkZXYgc2lkZSBvZiB0aGlzIHNlcmllcz8NCg0KVGhh
bmtzLA0KQ29ub3IuDQoNCj4gDQo+IEtpbmRhIHR3byB0aGluZ3MgaGFwcGVuaW5nIGluIHRoaXMg
c2VyaWVzLCBidXQgSSBzZW50IGl0IHRvZ2V0aGVyIHRvDQo+IGVuc3VyZSB0aGUgc2Vjb25kIHBh
cnQgd291bGQgYXBwbHkgY29ycmVjdGx5Lg0KPiANCj4gVGhlIGZpcnN0IGlzIHRoZSByZXNldCBj
b250cm9sbGVyIHRoYXQgSSBwcm9taXNlZCBhZnRlciBkaXNjb3ZlcmluZyB0aGUNCj4gaXNzdWUg
dHJpZ2dlcmVkIGJ5IENPTkZJR19QTSAmIHRoZSBwaHkgbm90IGNvbWluZyB1cCBjb3JyZWN0bHku
IEkgaGF2ZQ0KPiBub3cgcmVtb3ZlZCBhbGwgdGhlIG1lc3Npbmcgd2l0aCByZXNldHMgZnJvbSBj
bG9jayBlbmFibGUvZGlzYWJsZQ0KPiBmdW5jdGlvbnMgJiBub3cgdXNlIHRoZSBhdXggYnVzIHRv
IHNldCB1cCBhIHJlc2V0IGNvbnRyb2xsZXIgZHJpdmVyLg0KPiBTaW5jZSBJIG5lZWRlZCBzb21l
dGhpbmcgdG8gdGVzdCBpdCwgSSBob29rZWQgdXAgdGhlIHJlc2V0IGZvciB0aGUNCj4gQ2FkZW5j
ZSBNQUNCIG9uIFBvbGFyRmlyZSBTb0MuIFRoaXMgaGFzIGJlZW4gc3BsaXQgaW50byBhIHNlY29u
ZCBzZXJpZXMNCj4gZm9yIHYyOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA3
MDQxMTQ1MTEuMTg5MjMzMi0xLWNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tLw0KPiANCj4gVGhl
IHNlY29uZCBwYXJ0IGFkZHMgcmF0ZSBjb250cm9sIGZvciB0aGUgTVNTIFBMTCBjbG9jaywgZm9s
bG93ZWQgYnkNCj4gc29tZSBzaW1wbGlmaWNhdGlvbnMgdG8gdGhlIGRyaXZlciAmIGNvbnZlcnNp
b25zIG9mIHNvbWUgY3VzdG9tIHN0cnVjdHMNCj4gdG8gdGhlIGNvcnJlc3BvbmRpbmcgc3RydWN0
cyBpbiB0aGUgZnJhbWV3b3JrLg0KPiANCj4gVGhhbmtzLA0KPiBDb25vci4NCj4gDQo+IENoYW5n
ZXMgc2luY2UgdjE6DQo+IC0gc3BsaXQgb2ZmIHRoZSBuZXQgcGF0Y2hlcw0KPiAtIGNsazogYWN0
dWFsbHkgcGFzcyB0aGUgc3BpbmxvY2sgdG8gdGhlIGNvbnZlcnRlZCBkaXZpZGVycyAmIGdhdGVz
DQo+IC0gcmVzZXQ6IGFkZGVkIGEgc3BpbmxvY2sgYXJvdW5kIFJNVyBhY2Nlc3MgdG8gcmVnaXN0
ZXJzDQo+IC0gcmVzZXQ6IHN3aXRjaGVkIHRvIEJJVChpKSBtYWNyb3MNCj4gLSByZXNldDogdXNl
ZCBsb2NhbCBjb3BpZXMgb2Ygc29tZSB2YXJpYWJsZXMgYXMgcG9pbnRlZCBvdXQgYnkgUGhpbGlw
cA0KPiAtIHJlc2V0OiBkcm9wcGVkIHRoZSBzdWNjZXNzIHByaW50b3V0DQo+IA0KPiBDb25vciBE
b29sZXkgKDEyKToNCj4gICAgZHQtYmluZGluZ3M6IGNsazogbWljcm9jaGlwOiBtcGZzOiBhZGQg
cmVzZXQgY29udHJvbGxlciBzdXBwb3J0DQo+ICAgIGNsazogbWljcm9jaGlwOiBtcGZzOiBhZGQg
cmVzZXQgY29udHJvbGxlcg0KPiAgICByZXNldDogYWRkIHBvbGFyZmlyZSBzb2MgcmVzZXQgc3Vw
cG9ydA0KPiAgICBNQUlOVEFJTkVSUzogYWRkIHBvbGFyZmlyZSBzb2MgcmVzZXQgY29udHJvbGxl
cg0KPiAgICByaXNjdjogZHRzOiBtaWNyb2NoaXA6IGFkZCBtcGZzIHNwZWNpZmljIG1hY2IgcmVz
ZXQgc3VwcG9ydA0KPiAgICBjbGs6IG1pY3JvY2hpcDogbXBmczogYWRkIG1vZHVsZV9hdXRob3Jz
IGVudHJpZXMNCj4gICAgY2xrOiBtaWNyb2NoaXA6IG1wZnM6IGFkZCBNU1MgcGxsJ3Mgc2V0ICYg
cm91bmQgcmF0ZQ0KPiAgICBjbGs6IG1pY3JvY2hpcDogbXBmczogbW92ZSBpZCAmIG9mZnNldCBv
dXQgb2YgY2xvY2sgc3RydWN0cw0KPiAgICBjbGs6IG1pY3JvY2hpcDogbXBmczogc2ltcGxpZnkg
Y29udHJvbCByZWcgYWNjZXNzDQo+ICAgIGNsazogbWljcm9jaGlwOiBtcGZzOiBkZWxldGUgMiBs
aW5lIG1wZnNfY2xrX3JlZ2lzdGVyX2ZvbygpDQo+ICAgIGNsazogbWljcm9jaGlwOiBtcGZzOiBj
b252ZXJ0IGNmZ19jbGsgdG8gY2xrX2RpdmlkZXINCj4gICAgY2xrOiBtaWNyb2NoaXA6IG1wZnM6
IGNvbnZlcnQgcGVyaXBoX2NsayB0byBjbGtfZ2F0ZQ0KPiANCj4gICAuLi4vYmluZGluZ3MvY2xv
Y2svbWljcm9jaGlwLG1wZnMueWFtbCAgICAgICAgfCAgMTcgKy0NCj4gICBNQUlOVEFJTkVSUyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgIGFyY2gvcmlzY3Yv
Ym9vdC9kdHMvbWljcm9jaGlwL21wZnMuZHRzaSAgICAgICB8ICAgNyArLQ0KPiAgIGRyaXZlcnMv
Y2xrL21pY3JvY2hpcC9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgZHJpdmVy
cy9jbGsvbWljcm9jaGlwL2Nsay1tcGZzLmMgICAgICAgICAgICAgIHwgMzc5ICsrKysrKysrKy0t
LS0tLS0tLQ0KPiAgIGRyaXZlcnMvcmVzZXQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgNyArDQo+ICAgZHJpdmVycy9yZXNldC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAyICstDQo+ICAgZHJpdmVycy9yZXNldC9yZXNldC1tcGZzLmMgICAgICAgICAgICAg
ICAgICAgIHwgMTU3ICsrKysrKysrDQo+ICAgaW5jbHVkZS9zb2MvbWljcm9jaGlwL21wZnMuaCAg
ICAgICAgICAgICAgICAgIHwgICA4ICsNCj4gICA5IGZpbGVzIGNoYW5nZWQsIDM4NiBpbnNlcnRp
b25zKCspLCAxOTMgZGVsZXRpb25zKC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
cmVzZXQvcmVzZXQtbXBmcy5jDQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IGIxM2JhY2NjMzg1MGNh
OGI4Y2NjYmY4ZWQ5OTEyZGJhYTBmZGY3ZjMNCg0K
