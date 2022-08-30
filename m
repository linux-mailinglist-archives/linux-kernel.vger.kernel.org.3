Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C105A5BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiH3Gkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH3Gkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:40:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DFF43304;
        Mon, 29 Aug 2022 23:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661841631; x=1693377631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+CFLE7TlR4qNotwXsryvuL7lqQ32jcEvwLIpHWmr4R8=;
  b=GDulRPkH2eSSQ4S8VTFCx9TbtJ/9Pl+IwJwj+Nu4/YesTENEdjSEqSnO
   Qx+RZMG82tg7EaVFSy2H/McmEEcUhpBGXslVdNGo+/RB+mGNydt5OH6BT
   TAkIlYn0y2pxEAgRBNXZdzKOk+aNKMUCR0HI1bHXrLJd2d7Fx7R431S5z
   k8zFtZP6+wLupuYHw5X4QjF2PPpLSg7lPHCQ2JUwRXQUv/VvkTItXEWEv
   VaRmw16gP68252mOa7B4wKV8z+GL5AkLAviRpcx+33YeUXi0CPCBqs5lO
   AbAku+D4KEWNepX5iVqHBLsLF9+brFxiIKHqoonyCWrYY6s/Pjuxg56oV
   g==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="178257321"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2022 23:40:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 29 Aug 2022 23:40:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 29 Aug 2022 23:40:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/BLMAkqX4nQnGWORwWzFYbxqLIEvw//hbxQfOyuWNdsif2znUNREPNBXWJIfDe+iMU++3cS1QOaclJjPE3zs8kmwiNPC36GN0zgH+mR8lZ4uANXrDzqfnI0lxin7+2AhLjDOfm6LJd/CZ751Em77jf7URvcp0LnS5Q1wzUEncdf4d7klz06NUW3p+Tw4IO3Qq0yY73kz59BbhYR+HpN+aWUkFdoFsPc9CnnzmxaBhIwa2BAyTENjw4CIekzJ2SoKtwmXX8fZLibA/USYXvBR3tkwGBVA811k+Aqzf4fvIlkhvvvcXpa5OojDnWDqSpoLAMF87rxZkfA7XUSuV0hKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CFLE7TlR4qNotwXsryvuL7lqQ32jcEvwLIpHWmr4R8=;
 b=eieOxqTqLdJU1MptiYlCWUmjSCKIB1f7RPX4T19ybyxnTIYcic71SLF6VIkvnKUBH61kPjxF5Nfd4xuajGjOL/4dN5KIdOOElprh0YcGO5BCBkyFK3/LvUNUElbAGRxdZ3PJZpp/juVruVqwrHRBxpx6baEg8ve7IkgUuTyz5uvcskVcfPZbecaWB0M/OIKKFtRqB5ZrzoLYx8VqfHO1EgKUZ6ll+JaDJFBNd5ncqrCRfJbStQxIZG0AzfjHX/xY2stz6tuph3lekf7KvYgK4n2wpniK7qGdJc9T+9/SAHIt452oxMrnj9agtTaTI7bcKCAe0vEzt+tU8RAy7oMQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CFLE7TlR4qNotwXsryvuL7lqQ32jcEvwLIpHWmr4R8=;
 b=QuFHb1FYEFoGzr9ihcYM0kSt3un5joxRLID0+4XaISXWz41qDhhB7UnbKp2isopIaqYEpaluyM9fmG+R8KUoi48DnEw6q5u9ypgwa0+dHYe/iasgEzfHufpaX3SlKNNtixTJkt9CNQYhXCiFnWBxPuU1w0PhiQuV/UD2rFST4Yc=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SN6PR11MB3406.namprd11.prod.outlook.com (2603:10b6:805:bb::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 06:40:22 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%10]) with mapi id 15.20.5566.021; Tue, 30 Aug
 2022 06:40:22 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <p.zabel@pengutronix.de>, <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 03/13] clk: microchip: mpfs: add reset controller
Thread-Topic: [PATCH v3 03/13] clk: microchip: mpfs: add reset controller
Thread-Index: AQHYvDtgRP7/JvC6V0Gr24BMzSA6RQ==
Date:   Tue, 30 Aug 2022 06:40:21 +0000
Message-ID: <8726cec3-858a-b0c2-ab26-c1e2d2702776@microchip.com>
References: <20220819095320.40006-1-conor.dooley@microchip.com>
 <20220819095320.40006-4-conor.dooley@microchip.com>
In-Reply-To: <20220819095320.40006-4-conor.dooley@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8d48df0-d32f-4ddd-bd74-08da8a52833c
x-ms-traffictypediagnostic: SN6PR11MB3406:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: unalSm4uCn4S2jZ+mPu4EZgIeyYg369uFw48mYQk9YvBH2sgnoVCLY5BPO7nA9VDuhgK42TeOOB5iFnLaFncYvt4S2JXU/1twKbY9BqaZ98WWzfyYq0QvuedXr74EHjAJjDr+jPcqx2NzWXK+dMIGlfeIqqjGkovYPFQDdz2NKVDp3PhfXO1oWSjrjW9pybfE9ZnEC7M8SXjPO5xHWc3xutKg7LuuTd1D1tN3tR+pUCwR+x1W39vxA92nfwOqsO9R1YhxDoQKhGSso/ackqKVEZmgoLWLaopi8apvadgesaZu9sJ+WtVoZtRs50gjiSFzE+TkJQl3WOenpds/OWL/g4ur2lH/+ugFlDEQdhdOV8DiwfHr5OsLVF9XP9Kj3DPBp8Sw+E1YOoibqxVJeZ6TGdfWJbvwOXRaN04OXWhOIM+tG9l8+sem2/BwUNYC7KfveTgUiGJ++KvRkQC1Btx8Fn9hGALCXyzHhakcs7WfTOUQV1MxRCMjzWZfgi8zkgTz+Ls34FYFDM5pIc5QOeY/yeT/nzERC3lhPXo9xOBagiLIWGtV51h8ITQr0UvodQsXyz8sx9D/e7Drxrpe5B4ore872Pzh6LWKYcUBOTQhaHuXrduJ6RE67cXDe6vxXMrpVmgn9IDiioZeFKZR+qdZHwFt7ZyU9imgiMCqlQdBuhEMsK+7sTREn5/J8L6VjzaE++QkI7QJahPjXr54w6Ae9qYjAlURIuWDInU1gYQY0wvY8gzmhG7YbLEqXzFveg7fd1/CsRg4JwRuEkPhW5On+MejsddIY+pC+V3yy3+miTglL2Nbr564v1sFpSLr5iaF3sJQja6R2QiojvgjKGR1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(376002)(346002)(39860400002)(2616005)(83380400001)(186003)(8676002)(4326008)(64756008)(66446008)(66556008)(66946007)(66476007)(53546011)(76116006)(71200400001)(2906002)(6486002)(7416002)(5660300002)(8936002)(41300700001)(478600001)(6512007)(6506007)(26005)(91956017)(54906003)(316002)(6636002)(38070700005)(31696002)(86362001)(110136005)(36756003)(31686004)(38100700002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0txaFN0dGZzWk1BVWwyMVpDTE5NRkZ0ajQvcW5RMTEzbXpoUmFXWGxKeGpk?=
 =?utf-8?B?VWQraXkvSzZtazI4bDY1M3BYL2s1UG5EbU9YOElmSHRqejBqc1VEZnlLV1d0?=
 =?utf-8?B?cHBac3I2Ym5XWlluUXpJeHNCNGVlbU5IdCsyeTFnak9KL3RqWmlvTXF3VW9p?=
 =?utf-8?B?Q1ZaWDd3a3RtbkoxdEsrZ1IxWWxsQ05ZeFZTdzZTMktlRVp2cGJZcHZ5MFBl?=
 =?utf-8?B?M3pyMmNJMGdxWGVuVElVNnU4b1p4MDVHeld6OEtXNExqSEU3MFowem9IWGJJ?=
 =?utf-8?B?V2lmalF6a0srUWFFQzRaMDJyK00vaEorMWlodlQyNVBXU2xuMVM0bHNrcUF0?=
 =?utf-8?B?NlYyM3ppc2VtT25mU1BlYjRyMk5rMU1rZTlSM0hMdm0zM251OERuWjNvaUVy?=
 =?utf-8?B?TldHbngrdGIzVFlmUFd5MzJxcFdFMWVENEU0TXJhcXd2VmRUY1dhSDcrTGw1?=
 =?utf-8?B?ckZBekhqZUxJclJQTEtLeDZGL2theXVJSlNhVHVGVXJSYXBsMmUyenpCbkZ0?=
 =?utf-8?B?SkVjVG13QWRpS1ZHYVNwSWdhaWFIdVA5TXpRU0gxTGhoNEFrcHpkRFlWbk9r?=
 =?utf-8?B?NCtpU0JZSVR5T3J1VVZsaTJGb3pOOTMzalVybzNnUVQ2eTFmTWh0T2dkcmxk?=
 =?utf-8?B?WHN1Wm9MbkxBZVFSRGRMTDRwdm40Z3NuZEh1Yy9jdVNPN3lpd296ZHowdUlB?=
 =?utf-8?B?ZTBPK0VRSmtqOUFoVFZIL1ZpM0gvV1VrcTZ4QnlmbVIvL3ovUW9aK3YzZUJJ?=
 =?utf-8?B?ZiswUUVFNVN6YUpmL3ozRm9mREVrWXR3SzNtUEpLVE5ENXAyd055OXpOUGNX?=
 =?utf-8?B?RldNYVVzQnhycEt6UGxWWERMbVRvSXI5SVBBdDhqeG5RazFkUzl4dEt4YVRo?=
 =?utf-8?B?b3VVUlI0aXgzWEZwMFhDTnlpUHBZa1JBOG94QTc0Tkg1amN6V2JSWWtYSGJK?=
 =?utf-8?B?K1JGRkY4QUx1eGJjN1N1UVhML2Y1OEZvREdlbmoxU3g4RE1yV3VqZWVqZGJi?=
 =?utf-8?B?M243LzlTYk9qOExaVUlodisyTnNkM0RqMGlDZmJITUlmRVllY1gyWGREN3Fj?=
 =?utf-8?B?ZG5SckpWV2hwMld4ek1kSndVdWVnVDJObDJXUTRsa2FraTl5eVdtWndmVEc3?=
 =?utf-8?B?cUsrZVVXTTdYaTJXbW90c2wwNFhSSlJFNTR3K3dwZ0s1MFNCQTh5Ny80UjRs?=
 =?utf-8?B?ZzRyN3J4UU53QkVpaHNxREJkSVJKZC9DYU9QbUZGYjlxbjZGbkhjNG0zWkFD?=
 =?utf-8?B?NUdiYSsrNmNTdjluWGJLSGpDZSt0RkNUR1FZRjZLUFVwZEFzcGZZeGdpMFpO?=
 =?utf-8?B?c3RlZGxZWGhqbzZCbll5NkkvaFcwM21sTEtZRzZBTjdOdzQ4UytvMXgrdmxQ?=
 =?utf-8?B?ZHE4QzV3NGNqUzMrTUZNcDY5YU1UN0VoMlBGc2t2eStuOENmMDYrWTZvWnFP?=
 =?utf-8?B?RGg0UjdXaDVyTVJmOHlpc2VTZjJLbHkvTmMyWkdRSFVjY0J6NlpKK1NmTHVE?=
 =?utf-8?B?cWZKSW1sRG1JYnNSRzNvSm9qTyswRWlvdTlDRDlFWk1UaFJQVVVFRDR3TU5s?=
 =?utf-8?B?d2k4TkxUanZrdUdraFEvOW9RWUVPWlZWN2JJV2k3dll5TWpHSkpqNWZVWFQz?=
 =?utf-8?B?VmxLRVA4aHRDWmxmL1UyNGdlWjJBUGZ0Wkl6V2U0TEdFU2FsN1haUmoybWxy?=
 =?utf-8?B?VnpoNTdUeWFzczB0MWdqcUtTZHpCU2Q4NVdTcHlnM0tFazlNYXllYVo4UW1G?=
 =?utf-8?B?dWgxVVZFYjU5MlYyQkRMQnFoK2JHN0txbThwdnJQUTBOMUxOaEtqWFJXS0RX?=
 =?utf-8?B?SjBvL1VSV3psOUtWaDErWXlhS2tmdjVTSFhjUkhKeDgweUNKcWhkWXV0V0FS?=
 =?utf-8?B?MGtYeVRPTUxZai9kM3lnNDlaYys1bXAvVXY4amdvdW1pakNUV2JnL1FPaDZ1?=
 =?utf-8?B?YXNXbEZMMFo2MlJMc3JtZjlDaVVJS1J1L3FSaWoxblJ4RTJKOWRLU3Y3M201?=
 =?utf-8?B?Uzd0aUl1SlRmclNOc1RpZXZIS3JwRnZhZWVZRVJMOUJ6Rjhxdms1Yjk2RUx5?=
 =?utf-8?B?SHdpNzE0MFdpS21KS0ZtR2pnQS9HUVVPc1FoTnpIMTgyUE4wNFdDUHRaK2tT?=
 =?utf-8?B?Wm9rNnM2bjM4QjUrQ1ZLaFExUzVFdlJ4V2tIYkFad2t4enhaemRYQWMrbGFB?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C74F171FE1DDAE488D4EC0A1292CBB1A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d48df0-d32f-4ddd-bd74-08da8a52833c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 06:40:21.9781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJAqFOCrCTPLsQsIaK5GwZetl+y4wkbc1c9sHwRDRWP0E02i1JqSkfC/SPOFTWh/+5S7KwEyfdGxaD62xTu1LRUMW4XZgHY3CAzdrj6OEto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3406
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMDguMjAyMiAxMjo1MywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFkZCBhIHJlc2V0IGNvbnRyb2xsZXIgdG8gUG9s
YXJGaXJlIFNvQydzIGNsb2NrIGRyaXZlci4gVGhpcyByZXNldA0KPiBjb250cm9sbGVyIGlzIHJl
Z2lzdGVyZWQgYXMgYW4gYXV4IGRldmljZSBhbmQgcmVhZC93cml0ZSBmdW5jdGlvbnMNCj4gZXhw
b3J0ZWQgdG8gdGhlIGRyaXZlcnMgbmFtZXNwYWNlIHNvIHRoYXQgdGhlIHJlc2V0IGNvbnRyb2xs
ZXIgY2FuDQo+IGFjY2VzcyB0aGUgcGVyaXBoZXJhbCBkZXZpY2UgcmVzZXQgcmVnaXN0ZXIuDQo+
IA0KPiBSZXZpZXdlZC1ieTogRGFpcmUgTWNOYW1hcmEgPGRhaXJlLm1jbmFtYXJhQG1pY3JvY2hp
cC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3Jv
Y2hpcC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9jbGsvbWljcm9jaGlwL0tjb25maWcgICAgfCAg
IDEgKw0KPiAgZHJpdmVycy9jbGsvbWljcm9jaGlwL2Nsay1tcGZzLmMgfCAxMTYgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLQ0KPiAgaW5jbHVkZS9zb2MvbWljcm9jaGlwL21wZnMuaCAg
ICAgfCAgIDggKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDExNCBpbnNlcnRpb25zKCspLCAxMSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9taWNyb2NoaXAvS2Nv
bmZpZyBiL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9LY29uZmlnDQo+IGluZGV4IGE1YTk5ODczYzRm
NS4uYjQ2ZTg2NGIzYmQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9taWNyb2NoaXAvS2Nv
bmZpZw0KPiArKysgYi9kcml2ZXJzL2Nsay9taWNyb2NoaXAvS2NvbmZpZw0KPiBAQCAtNiw1ICs2
LDYgQEAgY29uZmlnIENPTU1PTl9DTEtfUElDMzINCj4gIGNvbmZpZyBNQ0hQX0NMS19NUEZTDQo+
ICAgICAgICAgYm9vbCAiQ2xrIGRyaXZlciBmb3IgUG9sYXJGaXJlIFNvQyINCj4gICAgICAgICBk
ZXBlbmRzIG9uIChSSVNDViAmJiBTT0NfTUlDUk9DSElQX1BPTEFSRklSRSkgfHwgQ09NUElMRV9U
RVNUDQo+ICsgICAgICAgc2VsZWN0IEFVWElMSUFSWV9CVVMNCj4gICAgICAgICBoZWxwDQo+ICAg
ICAgICAgICBTdXBwb3J0cyBDbG9jayBDb25maWd1cmF0aW9uIGZvciBQb2xhckZpcmUgU29DDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1wZnMuYyBiL2RyaXZlcnMv
Y2xrL21pY3JvY2hpcC9jbGstbXBmcy5jDQo+IGluZGV4IDllNDFmMDdiM2ZhNi4uMTAzNGY3ZDY5
NjYwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1wZnMuYw0KPiAr
KysgYi9kcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1wZnMuYw0KPiBAQCAtMywxMiArMywxNCBA
QA0KPiAgICogRGFpcmUgTWNOYW1hcmEsPGRhaXJlLm1jbmFtYXJhQG1pY3JvY2hpcC5jb20+DQo+
ICAgKiBDb3B5cmlnaHQgKEMpIDIwMjAgTWljcm9jaGlwIFRlY2hub2xvZ3kgSW5jLiAgQWxsIHJp
Z2h0cyByZXNlcnZlZC4NCj4gICAqLw0KPiArI2luY2x1ZGUgPGxpbnV4L2F1eGlsaWFyeV9idXMu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIuaD4NCj4gICNpbmNsdWRlIDxsaW51
eC9pby5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L3BsYXRmb3JtX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gICNpbmNs
dWRlIDxkdC1iaW5kaW5ncy9jbG9jay9taWNyb2NoaXAsbXBmcy1jbG9jay5oPg0KPiArI2luY2x1
ZGUgPHNvYy9taWNyb2NoaXAvbXBmcy5oPg0KPiANCj4gIC8qIGFkZHJlc3Mgb2Zmc2V0IG9mIGNv
bnRyb2wgcmVnaXN0ZXJzICovDQo+ICAjZGVmaW5lIFJFR19NU1NQTExfUkVGX0NSICAgICAgMHgw
OHUNCj4gQEAgLTMwLDYgKzMyLDcgQEANCj4gICNkZWZpbmUgUlRDUkVGX09GRlNFVCAgICAgICAg
ICAoQ0xLX1JUQ1JFRiAtIENMS19FTlZNKQ0KPiANCj4gIHN0cnVjdCBtcGZzX2Nsb2NrX2RhdGEg
ew0KPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldjsNCj4gICAgICAgICB2b2lkIF9faW9tZW0g
KmJhc2U7DQo+ICAgICAgICAgdm9pZCBfX2lvbWVtICptc3NwbGxfYmFzZTsNCj4gICAgICAgICBz
dHJ1Y3QgY2xrX2h3X29uZWNlbGxfZGF0YSBod19kYXRhOw0KPiBAQCAtMzA0LDEwICszMDcsNiBA
QCBzdGF0aWMgaW50IG1wZnNfcGVyaXBoX2Nsa19lbmFibGUoc3RydWN0IGNsa19odyAqaHcpDQo+
IA0KPiAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZtcGZzX2Nsa19sb2NrLCBmbGFncyk7DQo+
IA0KPiAtICAgICAgIHJlZyA9IHJlYWRsX3JlbGF4ZWQoYmFzZV9hZGRyICsgUkVHX1NVQkJMS19S
RVNFVF9DUik7DQo+IC0gICAgICAgdmFsID0gcmVnICYgfigxdSA8PCBwZXJpcGgtPnNoaWZ0KTsN
Cj4gLSAgICAgICB3cml0ZWxfcmVsYXhlZCh2YWwsIGJhc2VfYWRkciArIFJFR19TVUJCTEtfUkVT
RVRfQ1IpOw0KPiAtDQo+ICAgICAgICAgcmVnID0gcmVhZGxfcmVsYXhlZChiYXNlX2FkZHIgKyBS
RUdfU1VCQkxLX0NMT0NLX0NSKTsNCj4gICAgICAgICB2YWwgPSByZWcgfCAoMXUgPDwgcGVyaXBo
LT5zaGlmdCk7DQo+ICAgICAgICAgd3JpdGVsX3JlbGF4ZWQodmFsLCBiYXNlX2FkZHIgKyBSRUdf
U1VCQkxLX0NMT0NLX0NSKTsNCj4gQEAgLTM0MSwxMiArMzQwLDkgQEAgc3RhdGljIGludCBtcGZz
X3BlcmlwaF9jbGtfaXNfZW5hYmxlZChzdHJ1Y3QgY2xrX2h3ICpodykNCj4gICAgICAgICB2b2lk
IF9faW9tZW0gKmJhc2VfYWRkciA9IHBlcmlwaF9ody0+c3lzX2Jhc2U7DQo+ICAgICAgICAgdTMy
IHJlZzsNCj4gDQo+IC0gICAgICAgcmVnID0gcmVhZGxfcmVsYXhlZChiYXNlX2FkZHIgKyBSRUdf
U1VCQkxLX1JFU0VUX0NSKTsNCj4gLSAgICAgICBpZiAoKHJlZyAmICgxdSA8PCBwZXJpcGgtPnNo
aWZ0KSkgPT0gMHUpIHsNCj4gLSAgICAgICAgICAgICAgIHJlZyA9IHJlYWRsX3JlbGF4ZWQoYmFz
ZV9hZGRyICsgUkVHX1NVQkJMS19DTE9DS19DUik7DQo+IC0gICAgICAgICAgICAgICBpZiAocmVn
ICYgKDF1IDw8IHBlcmlwaC0+c2hpZnQpKQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gMTsNCj4gLSAgICAgICB9DQo+ICsgICAgICAgcmVnID0gcmVhZGxfcmVsYXhlZChiYXNlX2Fk
ZHIgKyBSRUdfU1VCQkxLX0NMT0NLX0NSKTsNCj4gKyAgICAgICBpZiAocmVnICYgKDF1IDw8IHBl
cmlwaC0+c2hpZnQpKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDE7DQo+IA0KPiAgICAgICAg
IHJldHVybiAwOw0KPiAgfQ0KPiBAQCAtNDQxLDYgKzQzNyw5OCBAQCBzdGF0aWMgaW50IG1wZnNf
Y2xrX3JlZ2lzdGVyX3BlcmlwaHMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbXBmc19wZXJp
cGhfaHdfYw0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiANCj4gKy8qDQo+ICsgKiBQZXJp
cGhlcmFsIGNsb2NrIHJlc2V0cw0KPiArICovDQo+ICsNCj4gKyNpZiBJU19FTkFCTEVEKENPTkZJ
R19SRVNFVF9DT05UUk9MTEVSKQ0KPiArDQo+ICt1MzIgbXBmc19yZXNldF9yZWFkKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3QgbXBmc19jbG9ja19kYXRhICpjbG9j
a19kYXRhID0gZGV2X2dldF9kcnZkYXRhKGRldi0+cGFyZW50KTsNCj4gKw0KPiArICAgICAgIHJl
dHVybiByZWFkbF9yZWxheGVkKGNsb2NrX2RhdGEtPmJhc2UgKyBSRUdfU1VCQkxLX1JFU0VUX0NS
KTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfTlNfR1BMKG1wZnNfcmVzZXRfcmVhZCwgTUNIUF9D
TEtfTVBGUyk7DQo+ICsNCj4gK3ZvaWQgbXBmc19yZXNldF93cml0ZShzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHUzMiB2YWwpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IG1wZnNfY2xvY2tfZGF0YSAqY2xv
Y2tfZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYtPnBhcmVudCk7DQo+ICsNCj4gKyAgICAgICB3
cml0ZWxfcmVsYXhlZCh2YWwsIGNsb2NrX2RhdGEtPmJhc2UgKyBSRUdfU1VCQkxLX1JFU0VUX0NS
KTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfTlNfR1BMKG1wZnNfcmVzZXRfd3JpdGUsIE1DSFBf
Q0xLX01QRlMpOw0KPiArDQo+ICtzdGF0aWMgdm9pZCBtcGZzX3Jlc2V0X3VucmVnaXN0ZXJfYWRl
dih2b2lkICpfYWRldikNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAq
YWRldiA9IF9hZGV2Ow0KPiArDQo+ICsgICAgICAgYXV4aWxpYXJ5X2RldmljZV9kZWxldGUoYWRl
dik7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIG1wZnNfcmVzZXRfYWRldl9yZWxlYXNlKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3QgYXV4aWxpYXJ5X2Rldmlj
ZSAqYWRldiA9IHRvX2F1eGlsaWFyeV9kZXYoZGV2KTsNCj4gKw0KPiArICAgICAgIGF1eGlsaWFy
eV9kZXZpY2VfdW5pbml0KGFkZXYpOw0KPiArDQo+ICsgICAgICAga2ZyZWUoYWRldik7DQo+ICt9
DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqbXBmc19yZXNldF9hZGV2
X2FsbG9jKHN0cnVjdCBtcGZzX2Nsb2NrX2RhdGEgKmNsa19kYXRhKQ0KPiArew0KPiArICAgICAg
IHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNlICphZGV2Ow0KPiArICAgICAgIGludCByZXQ7DQo+ICsN
Cj4gKyAgICAgICBhZGV2ID0ga3phbGxvYyhzaXplb2YoKmFkZXYpLCBHRlBfS0VSTkVMKTsNCj4g
KyAgICAgICBpZiAoIWFkZXYpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5P
TUVNKTsNCj4gKw0KPiArICAgICAgIGFkZXYtPm5hbWUgPSAicmVzZXQtbXBmcyI7DQo+ICsgICAg
ICAgYWRldi0+ZGV2LnBhcmVudCA9IGNsa19kYXRhLT5kZXY7DQo+ICsgICAgICAgYWRldi0+ZGV2
LnJlbGVhc2UgPSBtcGZzX3Jlc2V0X2FkZXZfcmVsZWFzZTsNCj4gKyAgICAgICBhZGV2LT5pZCA9
IDY2NnU7DQo+ICsNCj4gKyAgICAgICByZXQgPSBhdXhpbGlhcnlfZGV2aWNlX2luaXQoYWRldik7
DQo+ICsgICAgICAgaWYgKHJldCkgew0KPiArICAgICAgICAgICAgICAga2ZyZWUoYWRldik7DQo+
ICsgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUihyZXQpOw0KPiArICAgICAgIH0NCj4gKw0K
PiArICAgICAgIHJldHVybiBhZGV2Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IG1wZnNfcmVz
ZXRfY29udHJvbGxlcl9yZWdpc3RlcihzdHJ1Y3QgbXBmc19jbG9ja19kYXRhICpjbGtfZGF0YSkN
Cj4gK3sNCj4gKyAgICAgICBzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYWRldjsNCj4gKyAgICAg
ICBpbnQgcmV0Ow0KPiArDQo+ICsgICAgICAgYWRldiA9IG1wZnNfcmVzZXRfYWRldl9hbGxvYyhj
bGtfZGF0YSk7DQo+ICsgICAgICAgaWYgKElTX0VSUihhZGV2KSkNCj4gKyAgICAgICAgICAgICAg
IHJldHVybiBQVFJfRVJSKGFkZXYpOw0KPiArDQo+ICsgICAgICAgcmV0ID0gYXV4aWxpYXJ5X2Rl
dmljZV9hZGQoYWRldik7DQo+ICsgICAgICAgaWYgKHJldCkgew0KPiArICAgICAgICAgICAgICAg
YXV4aWxpYXJ5X2RldmljZV91bmluaXQoYWRldik7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4g
cmV0Ow0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHJldCA9IGRldm1fYWRkX2FjdGlvbl9v
cl9yZXNldChjbGtfZGF0YS0+ZGV2LCBtcGZzX3Jlc2V0X3VucmVnaXN0ZXJfYWRldiwgYWRldik7
DQo+ICsgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsN
Cj4gKyAgICAgICByZXR1cm4gMDsNCg0KWW91IGNhbiBqdXN0Og0KCXJldHVybiByZXQ7DQpvcjoN
CglyZXR1cm4gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCk7DQoNCj4gK30NCj4gKw0KPiArI2Vs
c2UgLyogIUNPTkZJR19SRVNFVF9DT05UUk9MTEVSICovDQo+ICsNCj4gK3N0YXRpYyBpbnQgbXBm
c19yZXNldF9jb250cm9sbGVyX3JlZ2lzdGVyKHN0cnVjdCBtcGZzX2Nsb2NrX2RhdGEgKmNsa19k
YXRhKQ0KPiArew0KPiArICAgICAgIHJldHVybiAwOw0KPiArfQ0KPiArDQo+ICsjZW5kaWYgLyog
IUNPTkZJR19SRVNFVF9DT05UUk9MTEVSICovDQo+ICsNCj4gIHN0YXRpYyBpbnQgbXBmc19jbGtf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4gICAgICAgICBzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiBAQCAtNDY1LDYgKzU1Myw4IEBAIHN0YXRp
YyBpbnQgbXBmc19jbGtfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAg
ICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGNsa19kYXRhLT5tc3NwbGxfYmFzZSk7DQo+IA0K
PiAgICAgICAgIGNsa19kYXRhLT5od19kYXRhLm51bSA9IG51bV9jbGtzOw0KPiArICAgICAgIGNs
a19kYXRhLT5kZXYgPSBkZXY7DQo+ICsgICAgICAgZGV2X3NldF9kcnZkYXRhKGRldiwgY2xrX2Rh
dGEpOw0KPiANCj4gICAgICAgICByZXQgPSBtcGZzX2Nsa19yZWdpc3Rlcl9tc3NwbGxzKGRldiwg
bXBmc19tc3NwbGxfY2xrcywgQVJSQVlfU0laRShtcGZzX21zc3BsbF9jbGtzKSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsa19kYXRhKTsNCj4gQEAgLTQ4NCw2
ICs1NzQsMTAgQEAgc3RhdGljIGludCBtcGZzX2Nsa19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiAgICAgICAgIGlmIChyZXQpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4g
cmV0Ow0KPiANCj4gKyAgICAgICByZXQgPSBtcGZzX3Jlc2V0X2NvbnRyb2xsZXJfcmVnaXN0ZXIo
Y2xrX2RhdGEpOw0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4g
cmV0Ow0KPiArDQo+ICAgICAgICAgcmV0dXJuIHJldDsNCg0KRGl0dG8NCg0KPiAgfQ0KPiANCj4g
QEAgLTQ5MSw3ICs1ODUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtcGZz
X2Nsa19vZl9tYXRjaF90YWJsZVtdID0gew0KPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAibWlj
cm9jaGlwLG1wZnMtY2xrY2ZnIiwgfSwNCj4gICAgICAgICB7fQ0KPiAgfTsNCj4gLU1PRFVMRV9E
RVZJQ0VfVEFCTEUob2YsIG1wZnNfY2xrX21hdGNoX3RhYmxlKTsNCj4gK01PRFVMRV9ERVZJQ0Vf
VEFCTEUob2YsIG1wZnNfY2xrX29mX21hdGNoX3RhYmxlKTsNCj4gDQo+ICBzdGF0aWMgc3RydWN0
IHBsYXRmb3JtX2RyaXZlciBtcGZzX2Nsa19kcml2ZXIgPSB7DQo+ICAgICAgICAgLnByb2JlID0g
bXBmc19jbGtfcHJvYmUsDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3NvYy9taWNyb2NoaXAvbXBm
cy5oIGIvaW5jbHVkZS9zb2MvbWljcm9jaGlwL21wZnMuaA0KPiBpbmRleCA2NDY2NTE1MjYyYmQu
LmY5MTZkY2RlNDU3ZiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9zb2MvbWljcm9jaGlwL21wZnMu
aA0KPiArKysgYi9pbmNsdWRlL3NvYy9taWNyb2NoaXAvbXBmcy5oDQo+IEBAIC00MCw0ICs0MCwx
MiBAQCBzdHJ1Y3QgbXBmc19zeXNfY29udHJvbGxlciAqbXBmc19zeXNfY29udHJvbGxlcl9nZXQo
c3RydWN0IGRldmljZSAqZGV2KTsNCj4gDQo+ICAjZW5kaWYgLyogaWYgSVNfRU5BQkxFRChDT05G
SUdfUE9MQVJGSVJFX1NPQ19TWVNfQ1RSTCkgKi8NCj4gDQo+ICsjaWYgSVNfRU5BQkxFRChDT05G
SUdfTUNIUF9DTEtfTVBGUykNCj4gKw0KPiArdTMyIG1wZnNfcmVzZXRfcmVhZChzdHJ1Y3QgZGV2
aWNlICpkZXYpOw0KPiArDQo+ICt2b2lkIG1wZnNfcmVzZXRfd3JpdGUoc3RydWN0IGRldmljZSAq
ZGV2LCB1MzIgdmFsKTsNCj4gKw0KPiArI2VuZGlmIC8qIGlmIElTX0VOQUJMRUQoQ09ORklHX01D
SFBfQ0xLX01QRlMpICovDQo+ICsNCj4gICNlbmRpZiAvKiBfX1NPQ19NUEZTX0hfXyAqLw0KPiAt
LQ0KPiAyLjM2LjENCj4gDQoNCg==
