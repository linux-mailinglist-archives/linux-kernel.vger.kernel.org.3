Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF9B594838
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 02:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiHOXaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 19:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244800AbiHOXYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 19:24:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F90E8670D;
        Mon, 15 Aug 2022 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660593950; x=1692129950;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jZ/JKSqfF8dKrtx+ZgiNmxIkL2DGKSS8qAwIiQmHkmo=;
  b=uXqhjG6Z5t38Z0ODxLxKqIRrvdkO6JNWpRybS1na76508qaK1DvR6vUM
   yzRv0Jz2skUooPwyYaBI2XtU/L/0jjCzS1O/wiw6WIaSEUs5wcRMbCg8W
   di+eUhOKup4PM3dDeC4VqjN/gD6hvegNrvkr7lNWAumC8mTAJ4wvGnItz
   0hHmd/r+5GUk/KWIjK59BBuvWUAQuB4IOE6+4FVBGv7SvJFxt1Mf7QeuC
   v+5WpDLE6MNk228OZpGuhEk9dM8AR4mGZIEiFYEfuQqwEFbdQxcdw0o5B
   iyX6WLiNMyDeYZ/TswkWWflkSq+Xr6hEZXnT4oZAszzyCkIpRb+yaVHLy
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="169382920"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 13:05:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 13:05:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 15 Aug 2022 13:05:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyZZHOwQcPAYROLATQkuQlIbT9orMcP5hpCG6C3N9XRqrVm7P5dADZHd/9njpcXWXx/3/sa0En2An8oO7G+a79PmquRaDYAyFNDzVINHjpVcLkyT8dQ63uN/Ayc4oi9O/t4Nkecg/45O83Zi+1SrLhwAY0SNNf5fILu0hOjGugBKAjlFIGWOvqVnW1hOkuV8es5Gn/R6CQ6AuirmJK61wt7GqPLx2pPXQxvGht8ydpFP4ZgV4oQlBlmz8NwnlclCtRcQBNxgiCUr9f0l4K7+CNcF3vr7C7RkuFqDqNYPBSAhdmRy1ihi2xoExi4mu4GZehQFxWBei481nAANp3QeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ/JKSqfF8dKrtx+ZgiNmxIkL2DGKSS8qAwIiQmHkmo=;
 b=BNSKAWFSiLEwIA0eF2M15mCoiqlNMIW2DYxQVYnO9ImmUB1A1HrAFn/7LVYYoN5X6sy8+HmLjKH2yioW215IpbnH9qhDWnhue1FiNU4FuKejhzT8wZaP+c2W0pyd69po+qY2AHfnN0D0FW3ziG/fiqdQIZZNrXfok8U3cTgob9+oqzW4410X0W57nRPKe2+yZcCRoY7nX6eMJpUwyyV2WK2sDPwMhjPYpvmuW9scIVI+9c1anacyv0DlEs+88YQ0VtzvPFpx6OhYx8UudcYxyCvPW7HdrbSuUo1KGM6aFPKcFPxDyNTvEvQeaQs8QRgsqsUw6aWjCCu+KZtre93Phw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ/JKSqfF8dKrtx+ZgiNmxIkL2DGKSS8qAwIiQmHkmo=;
 b=RbJX9a8s2h8xlcMXvPH4TbSe82wtTjLm4scYEHpAYP3Js3WkBcR8Grg5oPvZs0/OlDj/b3EZOuBlRsOCvREXnfYeTdQKxvtyFEHApj1kfisWqJJmkSnyoOztVXygJRZzet3xwy4befcFctgSLqBiHRjLeobOKWuujPtxzGGaHis=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 20:05:41 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 20:05:41 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.csengg@gmail.com>, <Conor.Dooley@microchip.com>
CC:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert+renesas@glider.be>, <anup@brainfault.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
Thread-Topic: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
Thread-Index: AQHYsLoPyzdSi5rmak2RSuYw1tRBkK2wU8sAgAANYYCAAAIoAA==
Date:   Mon, 15 Aug 2022 20:05:41 +0000
Message-ID: <cb3eb397-cc27-c8f2-4194-5c401f6dd690@microchip.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <d9d0deef-92e1-05b4-a195-d2ca03801129@microchip.com>
 <CA+V-a8utT6UE=rc62LPE=UoU0DTJ2dDt7KO9UJ1vAG9r80E2pg@mail.gmail.com>
In-Reply-To: <CA+V-a8utT6UE=rc62LPE=UoU0DTJ2dDt7KO9UJ1vAG9r80E2pg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c207cc33-7c63-4b7f-d258-08da7ef98792
x-ms-traffictypediagnostic: CO1PR11MB4961:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 16anoyz8Yk3rd1jly5EIyEKNRpRgWW9EaQpoADClw5rRROeJ3TIyYZ0QjF4UtjZZlklFh/i440bWbpufkdV3ohH+uu0WhXczja0J7eKgW72YBtsf2v3WMClMXdNxnVxz5ZDZegtU9JOcS7/Cjbkh9dgLJxyFuVhQln3q1a0gGGtB63BQaFfr/nZLrTaewCjBWEX5H3bhTziUpdxQrqFLYh82VEv6EwoVLius3KHdNCHUdePmycLw8dY/YKCFLo7XZRHuWGopnh3Qnm2a2yq8gxQ8CGdMH68RZPY/lm+PiD1wCpalw4fFmSOTVrQErjVFv68cXI6q205IXggPPdAmd+CZOEfDdUIafchZksq4YxRcQB+GBhj4ryaGVxRo1QddGfnAxXks8pa35ur+L37SKtiUIhdO0maJUQfKtau/XsG77h2us2i0M35enUGFUBvkE2U0XvJHhnJAfqcRtQL8/7lsCN3kMehj1HVsMp3Dv5Sl2N+uHJim317l6ftytpg9NTrU9nTEXO2NOYi5h6nZckJ2tWOwZmkWqIaFIGd4YwetmbGGQvzUAunAH90DItsLmK3MEjud54NPXuvK3i+VAhwhORko+lQJiD5X1lo5MvWvfNzLBRpc2gQOJyvoNOsNOONIH5SMyBq6b7O36e0GKuYYb98/GwQPoW6Ty9TF49u+FCueDjngFClpEKYjpP7NGZR7dT9npR5AwhldHnlXVaj4A4DebkgGZYa16rlTtPwF+MGqjL7IRNPM9Hq83eO22KGBX5rgnGaDM/OfgpeSGPpglXbRoLIzj5dMx2nAYALLu6etO4V0Lkv9jZO+eRlRrAElkykSjTFqEFPkM7RpJfVKQ0tY2FRfqnWGpvyQcnPN7zwUV9363smzPAwJ8SDV9s2oPgNcNOss8nRrg9+FLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(366004)(376002)(346002)(110136005)(54906003)(5660300002)(41300700001)(7416002)(91956017)(76116006)(2906002)(4326008)(66476007)(6506007)(66446008)(8676002)(26005)(316002)(36756003)(64756008)(53546011)(6512007)(8936002)(66556008)(66946007)(86362001)(31686004)(31696002)(38070700005)(83380400001)(186003)(2616005)(122000001)(38100700002)(6486002)(478600001)(71200400001)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZThEMG93SVBTVmRrQUgwSmphTGcxNWJ6QVpoRTRuWGhoeFlEN1RSVVE4ak9F?=
 =?utf-8?B?U01LMkdwZ0dBRmphMjVkeDBhaytxRUtXbUg3c0xUdk9JUXM5aDAxWHNuZXYr?=
 =?utf-8?B?OUlzODNlVGx1d3lmS1o5Qm5VSEJrM2pUL2xFZ1VNUWZ0V0tLVVdZSC90MENh?=
 =?utf-8?B?Q1BGYkJTN2pCeHFwSjgxK05CSlVVZ2IzMWVjZkxQUWlMZGRJWllKQ0lFemFU?=
 =?utf-8?B?Q0p2QmdpMXNodW9MY0lpN2w5MWwrWmd3WWU3QisxNEs3a0k2ME1Ud0g5T2tE?=
 =?utf-8?B?Mnl2dnBoNU5YSWNCUG9qQUhXelkyQmhYaHVna1Bod3RyREtwdVoxUFptZFhT?=
 =?utf-8?B?QmV2TFhHS3dvc29aSVZ5c1krTnJGd2hVMTZqdHY1M0RYcCt0TnVUMUJWL1Rz?=
 =?utf-8?B?Z3FHM0k4R2VGY3BJYlVRbWYvNFhHU3g4cDFTZk41cUw5RzEyc1A5THFPWDFw?=
 =?utf-8?B?dHh3WkdJalZ6OXBhSnNmRVZmNlB5SS9reERVOFF3L2RUUmM2bUsyYmZMdVY5?=
 =?utf-8?B?VHVoTk90bXNlUzVKWVFFL3hNdWFMMjFVSXJGWFh1d1dLM3kzUTNsMVBlUWRi?=
 =?utf-8?B?WHdMS2x1NzFEZk5DT213T1dlcE9EUEtoem9hTyt1UGhuVEt5SFN6OWUxcHV6?=
 =?utf-8?B?NnhRRFpaWWFjZEVFcWcvSTI0WVk5b1lXZHJpRWkyQzJ2Y3owYlNFVU5pTGdJ?=
 =?utf-8?B?aHRBZFFqRjJWMTZsYnAzak41WmEreU1BZXlTSUZNdWo5VW5FOFBxT1RZSmM2?=
 =?utf-8?B?aWZtR3F6NWFhcEQrSjdvMnBNUExZb2lsYktKeUYraFM0VThMbXFjYjJQQ0c1?=
 =?utf-8?B?azZCeGtVTkZocGQ0bzFYVER2MG83cHQ4M2Q1cktKMzNMWjNVNHJFTnJmUXFN?=
 =?utf-8?B?K3MzUXFFeHdLaXJXWWdoL2pIRmV1V2pTTG01NEd3a0dFOVlkN0hUN3Z1US9M?=
 =?utf-8?B?cGgwcStRd1FlL3RPZkQ1bWpNeXN4OGtCdzd2Y3pqbnhBL1A1LytrT3l1VjNW?=
 =?utf-8?B?VU9SbllhQTRjV3Z5RG1pN3RpSGNMK254Yld0Q083enFrYmFGbmlFRnNtYU5V?=
 =?utf-8?B?SVhONzB4bHhsTFRaZExkQlJBR3kyMEQ5ajViNWRJR0dRdjZVblo4dG10bWlR?=
 =?utf-8?B?bVV3ajJhckJPcldrS3p6UWt3bUhjWXJXREtPbjNvekVKSXpNNGJBMEhHZWJP?=
 =?utf-8?B?M2ljQXlZT2ZmdnV5bUdIU0FWVzIvUGNPYVhpTHU2Szg1b3kvNXR2cWI5WjlV?=
 =?utf-8?B?bWtqb210R1NxYkJoVW04N1cwckE5WlNYY0FuWFlVbDJtbVY5WVZvOHFwek5j?=
 =?utf-8?B?ejBrL0IwMXRwSUZocjRxdzlsTktSS0d5bmVHUTk2NlRkQU53WVlETXdQMXB0?=
 =?utf-8?B?N3BPM0FXT2tmSFlYQnJNdDZQZVFtdk03MFNLU09GSWJDNytocmtFTURMVXRW?=
 =?utf-8?B?dmRXWFBETjcxQjlXUGROOTE0Qi9pMHlJUGJuU25QdzBqb04zZE1EMERLSUlp?=
 =?utf-8?B?UWZ5OVhUdzZhQVFGelVUNUlrYnMwSEplZ0R5TWJMdFZwNmlhWTZ3ZXhGU2E3?=
 =?utf-8?B?T3ZxaWJOOWhtUmZCWXFmbEZhdnMxV1JzaFJmVkN2MUt4TmJPdlV3RkMyWGpx?=
 =?utf-8?B?QVl1R0NrdFVnY0RHOTNLMFllK1JJYnBWeXBTcTd5TFVxZmxLKzlRTFNTb2Vt?=
 =?utf-8?B?dEZZU0M4SjJ6dWgrVWNSbHUxRytKS2JEdXZjQWNNU21GUGpMaUFkUERpcGpa?=
 =?utf-8?B?Yys0ZnhTZXNLaHBaQ1JlYXVQeTVaNTU4dVZDbWp3eWtDU2VLV21RdWtqKzRV?=
 =?utf-8?B?WlJHQitlYWdMSWZidUpJY3ZHRmlJTkYrQmtwNFF5akxDNmp1RGwza205aWF2?=
 =?utf-8?B?MkdnUDJGbDMvWWMwQitxOTB6V1hJcTA0TnFPbzdGSExEZzFxZmR2TkwzTVE1?=
 =?utf-8?B?UlpkdzNDL285aHZhNWdKRTZLbEIzS3g2TGtvNU83dGxjMG1Ub0JBM1hqYUNZ?=
 =?utf-8?B?NjdRb0E1MklGOU5DMWoyQWZabmd5S095TVJGRlhBMHBXTVhtd3kwZzNrWSty?=
 =?utf-8?B?djc5bWJOK3UwVXNTMm03ZXFiTlU2VllPcXdvdE44N1Q0cmdCL0R4OGV1L3d3?=
 =?utf-8?Q?mYPuUyPu1nd7XocupKefKDM2z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47A72B4C2681A741A806A1261EAABE6F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c207cc33-7c63-4b7f-d258-08da7ef98792
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 20:05:41.2380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fi5ao9x7pbuPGpll31U45fr3k/PMt6X3PPK1AENZyC8Cpvv/q9pnXl3ywukIfubdD74pazQtnj4aUkm+xn0azaMdkkXNWgNawt2BU8t/gq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDgvMjAyMiAyMDo1NywgTGFkLCBQcmFiaGFrYXIgd3JvdGU6DQo+IEhpIENvbm9yLA0K
PiANCj4gVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KPiANCj4gT24gTW9uLCBBdWcgMTUsIDIw
MjIgYXQgODoxMCBQTSA8Q29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPj4NCj4+
IE9uIDE1LzA4LzIwMjIgMTY6MTQsIExhZCBQcmFiaGFrYXIgd3JvdGU6DQo+Pj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBJbnRyb2R1Y2UgU09DX1JFTkVTQVNf
UlpGSVZFIGNvbmZpZyBvcHRpb24gdG8gZW5hYmxlIFJlbmVzYXMgUlovRml2ZQ0KPj4+IChSOUEw
N0cwNDMpIFNvQywgYWxvbmcgc2lkZSBhbHNvIGFkZCBBUkNIX1JFTkVTQVMgY29uZmlnIG9wdGlv
biBhcyBtb3N0DQo+Pj4gb2YgdGhlIFJlbmVzYXMgZHJpdmVycyBkZXBlbmQgb24gdGhpcyBjb25m
aWcgb3B0aW9uLg0KPj4NCj4+IEhleSBMYWQsDQo+Pg0KPj4gSSB0aGluayBJIHNhaWQgc29tZXRo
aW5nIHNpbWlsYXIgb24gdjEsIGJ1dCBJIHNhaWQgaXQgYWdhaW4NCj4+IHRvIFNhbXVlbCB0b2Rh
eSBzbyBJIG1heSBhcyB3ZWxsIHJlcG9zdCBoZXJlIHRvbzoNCj4+ICJJIHRoaW5rIHRoaXMgYW5k
IHBhdGNoIDEyLzEyIHdpdGggdGhlIGRlZmNvbmZpZyBjaGFuZ2VzIHNob3VsZCBiZQ0KPiBwYXRj
aCA4LzguDQoNCkl0IHdhcyBhIGRpcmVjdCBjb3B5IHBhc3RlLCBoZW5jZSB0aGUgcXVvdGVzIDsp
DQpZb3VyIHBhdGNoIDgvOCBsaW5lcyB1cCB3aXRoIHRoZSBjdXJyZW50IHN5bWJvbHMgd2hpbGUg
U2FtdWVsJ3MNCmRvZXNuJ3QuDQoNCj4gDQo+IA0KPj4gZGVmZXJyZWQgdW50aWwgcG9zdCBMUEMg
KHdoaWNoIHN0aWxsIGxlYXZlcyBwbGVudHkgb2YgdGltZSBmb3INCj4+IG1ha2luZyB0aGUgNi4x
IG1lcmdlIHdpbmRvdykuIFdlIGFscmVhZHkgaGF2ZSBsaWtlIDQgZGlmZmVyZW50DQo+PiBhcHBy
b2FjaGVzIGJldHdlZW4gdGhlIGV4aXN0aW5nIFNPQ19GT08gc3ltYm9scyAmIHR3byBtb3JlIHdo
ZW4NCj4+IEQxIHN0dWZmIGFuZCB0aGUgUmVuZXNhcyBzdHVmZiBpcyBjb25zaWRlcmVkLg0KPj4N
Cj4+IFBsYW4gaXMgdG8gZGVjaWRlIGF0IExQQyBvbiBvbmUgYXBwcm9hY2ggZm9yIHdoYXQgdG8g
ZG8gd2l0aA0KPj4gS2NvbmZpZy5zb2NzICYgdG8gbWUgaXQgc2VlbXMgbGlrZSBhIGdvb2QgaWRl
YSB0byBkbyB3aGF0J3MgYmVpbmcNCj4+IGRvbmUgaGVyZSAtIGl0J3MgbGlrZWx5IHRoYXQgZnVy
dGhlciBhcm0gdmVuZG9ycyB3aWxsIG1vdmUgYW5kDQo+PiBrZWVwaW5nIHRoZSBjb21tb24gc3lt
Ym9scyBtYWtlcyBhIGxvdCBvZiBzZW5zZSB0byBtZS4uLiINCj4+DQo+IFN1cmUgbm90IGEgcHJv
YmxlbS4gQnV0IGRlbGF5aW5nIHBhdGNoIDQgYW5kIDggd2lsbCBtYWtlIFJaL0ZpdmUgU29DDQo+
IG5vdCBidWlsZGFibGUuIElzIHRoYXQgT0s/DQoNCk5vIG5vLCBJIHByb2IganVzdCBkaWQgYSBi
YWQgam9iIG9mIGV4cGxhaW5pbmcuIEkgbWVhbnQgbW9yZQ0KYWxvbmcgdGhlIGxpbmVzIG9mICJJ
IGRvbid0IHRoaW5rIHRoaXMgaXMgdGhlIHJpZ2h0IGFwcHJvYWNoDQpidXQgSSB3aWxsIGRlZmVy
IHJldmlld2luZyB1bnRpbCBhZnRlciBMUEMsIHdoZW4gd2UgaGF2ZSBwaWNrZWQNCm9uZSBhcHBy
b2FjaCB0byB1c2UgZm9yIGV2ZXJ5b25lIi4gSSdtIHNvcnJ5LCBwb29yIGNob2ljZSBvZg0Kd29y
ZHMgbWF5YmUuIEkgZGlkbid0IG1lYW4gZHJvcCB0aGVzZSBwYXRjaGVzIHNvIHRoYXQgaXQgZG9l
cw0Kbm90IGJ1aWxkLCBrZWVwaW5nIGl0IGJ1aWxkYWJsZSB1bnRpbCB0aGVuIHNvIHRoYXQgd2Ug
Y2FuIGFsbA0KdGVzdC9yZXZpZXcgaXMgdGhlIHdheSB0byBnby4gTm90IHlvdXIgZmF1bHQgd2Un
dmUgZG9uZSA0IGRpZmZlcmVudA0KdGhpbmdzIHNvIGZhciENCg0KSG9wZWZ1bGx5IHRoYXQgbWFr
ZXMgYSBiaXQgbW9yZSBzZW5zZT8NCg0KPiANCj4+IEFsc28sIGZvciB0aGUgc2FrZSBvZiBteSBP
Q0QgY291bGQgeW91IHBpY2sgZWl0aGVyIHJpc2N2IG9yDQo+PiBSSVNDLVYgYW5kIHVzZSBpdCBm
b3IgdGhlIHdob2xlIHNlcmllcz8gUGVkYW50aWMgSSBndWVzcywgYnV0DQo+PiAvc2hydWcNCj4+
DQo+IFNvcnJ5IGRpZCB5b3UgbWVhbiBJIGFkZCByaXNjdi9SSVNDLVYgaW4gdGhlIHN1YmplY3Q/
DQoNCllvdSBoYXZlIHNvbWUgcGF0Y2hlcyB3aXRoIFJJU0MtViBhbmQgc29tZSB3aXRoIHJpc2N2
Lg0KV2hhdCBJIG1lYW50IHdhcyB1c2Ugb25lIG9mIHRoZSB0d28gZm9yIHRoZSB3aG9sZSBzZXJp
ZXMuDQpUaGFua3MsDQpDb25vci4NCg0KPiANCj4gQ2hlZXJzLA0KPiBQcmFiaGFrYXINCj4gDQo+
IA0KPj4gVGhhbmtzLA0KPj4gQ29ub3IuDQo+Pg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTGFk
IFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPj4+
IC0tLQ0KPj4+IHYxLT52Mg0KPj4+ICogTm8gQ2hhbmdlDQo+Pj4gLS0tDQo+Pj4gIGFyY2gvcmlz
Y3YvS2NvbmZpZy5zb2NzIHwgMTQgKysrKysrKysrKysrKysNCj4+PiAgMSBmaWxlIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L0tjb25m
aWcuc29jcyBiL2FyY2gvcmlzY3YvS2NvbmZpZy5zb2NzDQo+Pj4gaW5kZXggNjk3NzRiYjM2MmQ2
Li45MWI3ZjM4Yjc3YTggMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC9yaXNjdi9LY29uZmlnLnNvY3MN
Cj4+PiArKysgYi9hcmNoL3Jpc2N2L0tjb25maWcuc29jcw0KPj4+IEBAIC04MCw0ICs4MCwxOCBA
QCBjb25maWcgU09DX0NBTkFBTl9LMjEwX0RUQl9TT1VSQ0UNCj4+Pg0KPj4+ICBlbmRpZiAjIFNP
Q19DQU5BQU4NCj4+Pg0KPj4+ICtjb25maWcgQVJDSF9SRU5FU0FTDQo+Pj4gKyAgICAgICBib29s
DQo+Pj4gKyAgICAgICBzZWxlY3QgR1BJT0xJQg0KPj4+ICsgICAgICAgc2VsZWN0IFBJTkNUUkwN
Cj4+PiArICAgICAgIHNlbGVjdCBTT0NfQlVTDQo+Pj4gKw0KPj4+ICtjb25maWcgU09DX1JFTkVT
QVNfUlpGSVZFDQo+Pj4gKyAgICAgICBib29sICJSZW5lc2FzIFJaL0ZpdmUgU29DIg0KPj4+ICsg
ICAgICAgc2VsZWN0IEFSQ0hfUjlBMDdHMDQzDQo+Pj4gKyAgICAgICBzZWxlY3QgQVJDSF9SRU5F
U0FTDQo+Pj4gKyAgICAgICBzZWxlY3QgUkVTRVRfQ09OVFJPTExFUg0KPj4+ICsgICAgICAgaGVs
cA0KPj4+ICsgICAgICAgICBUaGlzIGVuYWJsZXMgc3VwcG9ydCBmb3IgUmVuZXNhcyBSWi9GaXZl
IFNvQy4NCj4+PiArDQo+Pj4gIGVuZG1lbnUgIyAiU29DIHNlbGVjdGlvbiINCj4+PiAtLQ0KPj4+
IDIuMjUuMQ0KPj4+DQo+Pg0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2
QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1yaXNjdg0K
