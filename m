Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C832555CCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiF0GwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiF0GwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:52:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DBB26CA;
        Sun, 26 Jun 2022 23:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656312727; x=1687848727;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=jv6+09tUKzZVDI0c8upd7I2T07N14syCf2mtnG4tTNA=;
  b=ajHVeikgx3XxNvw4wrWblPmp2jfBOKFnxun88oSeHE39bzK52EAHvwKH
   aTvMebJCQhp01RPAU5u4Cj2wnAL9N9O2P3QKqOsJ8Y7pe8cAWjrzh+C/9
   KYBkymc6Sy+Peyr3/gFZau8X5UwVdkGGpA7ALIhnRXwjlShGa6S4BSaCD
   WjJPHA18VXpoVgbZsJ5TksPiAGquUrOjfEM7/8IhzzPO+1EwLg87ro12n
   VsKyP5Dk0TIOvTYQnI4uwEvhzcmmC9BkIkke3VAciHyLqukDi288x2Lsn
   prcAGA/SHJZP7fhgr6wjd84S4Zsl8hSk/6JYCkll2ag6NYoPMUHMmPKvd
   w==;
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="165184705"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2022 23:52:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 26 Jun 2022 23:52:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 26 Jun 2022 23:52:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwT7Hn032RAYWtx5TO3GzTbCE/lEsaQl+LwyEBH0nw1F/lz6ZrzTCALTopUA88aDd3dZqCvNsycI7Y36hTRi1o5Hn5m+U8jtYQZktqcL6Ya7Y/8ke4IPpYelnniSTv3sMRc1G3a1Pmi6mRdIoKTdCapoDRUz1QAJ4nfzY381wcxYdLq36mwaYoQeZCiujQYVblXhq3vWstZmcxOnqTaDOIGI+aUiKhAzWkGe80CgxiR736TxiFiRfR5ccVZMbSqpJ6b3Ji9zjxfAgtVXaaznXpjBLMRQ9o+OBYa/FUG5JS5rjm3qt3UNxMR/q2Q+v49gA8DVrwAme3AAOP4PraALYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv6+09tUKzZVDI0c8upd7I2T07N14syCf2mtnG4tTNA=;
 b=eK/ssZbkXvLLea7NQKiKFXTEyH9++6FnSQtQNfAlQFKJjAlFbpJmAJyaGlbQ6tQvYF9Bt+T22huEfG2vlhGcIdfgU0KlCiAfsiIp5zKMzo7Dk4Euzu7AobcPtfUhqs87M/TYKkw/f+qhglZUpM9R6ZBg/QpVcIBFB1RhB5mAk7RUlWkVJcYf0qYO+cBlv2OtN5FkltRvaBnyInadcJb8eytncOR2K3Ex3pLV1TA6k6riNV9WHIJTokm6vIZQNwRhG2dx42jY/NcIGO6fk/s/pSU9pGHMzp0eUnDS8NrJmmef/Rbc2NuqeWVkdpMhB1Vzt1RoB730aiTnwdzqevuMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv6+09tUKzZVDI0c8upd7I2T07N14syCf2mtnG4tTNA=;
 b=fM5norKtBn23NWie2Jomczkd42kp6b4/Hg4wxSSaNkEiePZh00v/h+oaXFqPaYIEuqRvz+u6ttXKlckwNcWgWrc/7HzujdaUzYJr6nChCm2IQmsvXmFdDopmLrt7oEioVxXPigK3xSgLoD0KMYnlUCiovG1zkhafkRZN2WHb5xY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BY5PR11MB4183.namprd11.prod.outlook.com (2603:10b6:a03:18e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 06:52:03 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 06:52:03 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <Conor.Dooley@microchip.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: dts: align gpio-key node names with dtschema
Thread-Topic: [PATCH] riscv: dts: align gpio-key node names with dtschema
Thread-Index: AQHYh+0TSEsUfCu3dUCW8EahvV7Amq1iLm0AgACljICAAAD0AA==
Date:   Mon, 27 Jun 2022 06:52:03 +0000
Message-ID: <7ef4cc22-6125-d3be-b88d-1202b46ef523@microchip.com>
References: <20220624170811.66395-1-krzysztof.kozlowski@linaro.org>
 <daf4a88e-ea33-be74-7e0a-b2ff20ea734f@microchip.com>
 <9dbe7dc9-aac9-7d1b-eccf-5d4c8683065b@linaro.org>
In-Reply-To: <9dbe7dc9-aac9-7d1b-eccf-5d4c8683065b@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42d2c6a4-295b-4521-025e-08da58098aee
x-ms-traffictypediagnostic: BY5PR11MB4183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hacv2Zrkm5E3LQarRUC2YpIQWan53JD9Mnl6DJ0ppzAmJdMRWrPQXt3IrXqy7dI1yyRTal3r5gfLlP3DBAt8U3Ufjz32VtGCN/KfKmTCFK3cLsZ89d2cZsN3yYRIQtB/kPve4iNtm9FXGagF6GG3KJBINYcNAvgECtSkOjaHBBTcuUEkTdqiJ+PGKbYeVCcWlKSqAVmWRsVe2ES0qPIew0ruSDWHlPAFV7mQDmeM7HyvqEoSLeVkd8UG3E866pN+TDu8+ozqtCP3rZ6fx4VD/feE4L005zDTplV7BMLwcVzg2qNFxQU5Qy4y7+1qkE4bqNMbnTseAEOibPUVKcjXx3V/y54OaFXu/teB90H0moCf2J6I6Biutn+cMw3pGp5lmnt5wS1TcbxsMzbcw4yM0XSmBRNe7feU+luUR6TO8FpX2cB/Mg9BzUJbFjCI5o3hzofCcIehErV6iFrKKDk/PBWb+gYWZNIIUYaH1WZsV8QqoPZfY31R+aUal9/P2PJkxAaijzzWyo/65VMQbc9kYbQK685oxeLvE1VlgsBUYZn5+yv50eYYQ27alpUpY2zUV55HgYF+D6jPUaOagR0ponseaOEXNZl37I9SUiCCdjfQMWJMK787fP7lkcKPeplr1+UxJpmt1Uxx8WQgqWe30aq9IHjtzxw6iexMq9VQuZewH+mN4i0Gasd0tYgfsE6TF6AnOwawXwnc3P7HKD6COGxxFIHn1GSQQqKnpEQcJT3kEwgA5bZAC5ra5+g6Nfg6NV+Ugsxd/nS+4N5BzOIC2qbLXOCqFcguLPsMaYKu//M+71D1S6sPS+HWQry7gAgN+CYxZnGy6fpyAAKbzbYkQ1JY9fmrrOYdXuy5Hk/mJARl7u56pkOHJEqqC1u3GakikiIlzrm0U4R7aqQ4JQyvsSvXwht2TuHFajRmk6xemySpaCUv/G4eksTrU9i154HB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(396003)(136003)(376002)(31686004)(38100700002)(478600001)(966005)(26005)(110136005)(316002)(6486002)(186003)(36756003)(2616005)(71200400001)(31696002)(5660300002)(41300700001)(91956017)(8936002)(921005)(4744005)(122000001)(76116006)(8676002)(64756008)(66946007)(86362001)(66556008)(66476007)(66446008)(38070700005)(53546011)(6512007)(2906002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXlRU2lTSG5iQ05DdFJsTFJyUEkyTHBjUlp0SW5GRk12SXJJdjlXN0FiVTlR?=
 =?utf-8?B?ajA4dWFmYWVUUitPM2F1M0MyZWxkYVUxSVRzVVQyUVJwSGdVeDlRckR6ei94?=
 =?utf-8?B?cE5xRnErbVNpbXVjVGlLbU1sK05BeTRHMm1ONWFKQXBLV2Z6OVlnOER6NDQ1?=
 =?utf-8?B?WDk2ZEtlQlR2K1ZqSVNMcDROTTdQT1ZRdWlqRVFvM3ZVZmp2U3huYjUwK2lN?=
 =?utf-8?B?d1V3NWpZTUtIem5KdXJoTmJXM21aTFBobVpFcThONmFxNjRzNGhXQTVwSzYw?=
 =?utf-8?B?cW00Q2dVQmxHZ2FmUTZJblA3QU1oUVBBYWxXYlNZWXhlNlUrQ2d2SHAxNWRW?=
 =?utf-8?B?ZDd1RXdzOXZSKzBmM2t2elBJYkRoMVQ3M0pReFQ4VXdZbGhRWFI5SDVBdlZT?=
 =?utf-8?B?RWp3NzNhNzBlZEVpbWx6M3BkQ0ZTU3ZTUVNJTVZncEhIRVAxNlAzL1JtRWU0?=
 =?utf-8?B?TUpscjgxSXZMdzlaUVpYTjZsVWRPK05jUFZXaVBiYmZvSmFkNzY3R01CREN5?=
 =?utf-8?B?ZjExQzg1K01XU0JRQUJmRzUvVUJNK3NLZ2dlMlVyOElnSjJoMGNyc2luMndj?=
 =?utf-8?B?SGZTcnpibkRvQnRzRlVnRXVDNmVzVzZlRmNVcEFyMy8yTm4wVkF4UEJnZHAw?=
 =?utf-8?B?SWR0VDdvUmtTNjhrUmg4TDRyQWIxSnV5MkhEdDZCYUx5UU5IVE5TSThQbEdy?=
 =?utf-8?B?azY5b1NITUxnbmNBWEJBYllhSzkrVG9ESHI1TEdMZExFU2VJWTJuanZlR3NQ?=
 =?utf-8?B?Wi9KZFdnMlpxOWxxMmNoZnJRV2RVaU0yblR6RmJ6UEdLejFrVGJjZDRRQUUv?=
 =?utf-8?B?YUxVdnNiK3J0cjFqcGlNY0NNWU96VGZzendlN09wek13TXhXYUFzYWZJcStC?=
 =?utf-8?B?a3JGZFNuSTdRNlgydHFpSGFGRHFCRGlieFFNWFplOUd6SmYvQ0VUTWRRM2lF?=
 =?utf-8?B?UkFOSHh3cnJPek9yRDlNcUpQTDJSSy9FTG5WeG11WDA3YW91MGVvNG1xY1lH?=
 =?utf-8?B?bjJTZEJxZHIyQUVVY2g2TVpkQXE2SUVNREx5UWFxNVRzZUtrSlNCY1FGdko2?=
 =?utf-8?B?Vm5RR1BDODM4MEJWcUhXenR3RjdhYnp3Y2hBMjZHaEFqRUJKMUw3bi8yMXNi?=
 =?utf-8?B?TDFabmhMOVNNVVRPeUtjUExIaFJWQjRic3B5UDNXeUdQNzFuVC9LZjlEZlhh?=
 =?utf-8?B?Tk9tekhSTGR4aTBHRWxHZlBqWG1sU0I3bW9xdm4xRmh4ZisrOEFIdytnZm5J?=
 =?utf-8?B?aVZkTHI5N2NvMzBlTGpyR1NYZlVVWWFadEk0K3hKcFlETzRBMk1nMXFXSm4z?=
 =?utf-8?B?L2JmMi9UMXZIY1hsbFRSTkgrWkk5Vkh6TFUwdC9NNnlNZVFtcGpOQVF1N2VP?=
 =?utf-8?B?RXAwVUxHaW8rbzZoS0FhSlZKZTN3Z1ZoUUo2WEMwWEtSaTlNazNESy9FbmR0?=
 =?utf-8?B?cEhqY051VjJpUFNDc0hvdGRNN09GZ21LOEJaT1ZjSEM3TEt2TTkrQUY2bVVm?=
 =?utf-8?B?MzBqWVNTMEpybHNSOHhVNnJhSVd1STdZeTZNMDdCOTFMZkFjeVdRMXpjUlcz?=
 =?utf-8?B?RytmbjV5bC96QjU0L3BwMTNUVlpSanZUY0lqVUtUQXIrMVVXUnRuNEZEa0to?=
 =?utf-8?B?Z1JBN3V3RkNwMzduMzMyY0VTd20zNWVhVVBaN1I0bXRWMjVPb1VucWx6Z3Vt?=
 =?utf-8?B?UVBlSkNPdU1aNlU3ZnB3QUF3SSt6c05XdjRsaVJZSWJSZE5JS0NuMjhqV0gy?=
 =?utf-8?B?ZFNpRHMrU2dzQmVIK2JhQnhJSmxySWp2RWdzdS92eXRUS2lNS2k0YzJidXVB?=
 =?utf-8?B?VURSZDltYkNQWkJ6bVNmVTlQZWkzcHdmbm9Ma1N3VmY0Y214MTBSYjZMUUZQ?=
 =?utf-8?B?akIyNFNjZklYUEJoWlNDd2cxTStxczZhaEExTDdNczd5aFpJaW5HdXY0UlNN?=
 =?utf-8?B?YUt5SFVjaVVBYmZ6TE9VelRMcDBDMm5PVk45WkVhZ2I3K25RSHlUQTRBeHJL?=
 =?utf-8?B?K3hienVQM3JlNkdrVS96M0FVSG9aeVFiRnhrRW5TbmRkdzFhNkFCeHd4OEM4?=
 =?utf-8?B?NFNrbDR0Y0h4VzVBWVllWVZRb01GTjFYUlVyM0lNenZycG9iTlFuSkRjUWRz?=
 =?utf-8?Q?UX8Lgf2xhnspp+3C54va627K1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FF3775625DBD54D9A80422CCA53BB89@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d2c6a4-295b-4521-025e-08da58098aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 06:52:03.4838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwfSCEZU9j7e32kg1clMt8NOGSl70fWzponQULKuWUqAK301Bm9Mzd6zTGGdC03Zk6X1mRYIZwqXrttOeIPAYzutR5fEGH1zq8hBlIG9hy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4183
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI3LzA2LzIwMjIgMDc6NDgsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9u
IDI2LzA2LzIwMjIgMjI6NTYsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4N
Cj4+DQo+PiBPbiAyNC8wNi8yMDIyIDE4OjA4LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0K
Pj4+IFRoZSBub2RlIG5hbWVzIHNob3VsZCBiZSBnZW5lcmljIGFuZCBEVCBzY2hlbWEgZXhwZWN0
cyBjZXJ0YWluIHBhdHRlcm4NCj4+PiAoZS5nLiB3aXRoIGtleS9idXR0b24vc3dpdGNoKS4NCj4+
Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3ps
b3dza2lAbGluYXJvLm9yZz4NCj4+DQo+PiBSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25v
ci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBBcmUgeW91IHBsYW5uaW5nIHRvIGNoYW5n
ZSB0aGVtIGFsbCAmIHRoZW4gY2hhbmdlIHRoZSBwYXR0ZXJuDQo+PiBwcm9wZXJ0eSB0byBjb21w
bGFpbiBpZiAia2V5IiBpcyBtaXNzaW5nPw0KPiANCj4gWWVzLCBJIHB1dCB0aGUgbGluayB0byBv
cmlnaW5hbCBwYXRjaHNldCBkb2luZyB0aGlzOg0KPiANCj4+IFRoYW5rcywNCj4+IENvbm9yLg0K
Pj4NCj4+Pg0KPj4+IC0tLQ0KPj4+DQo+Pj4gU2VlOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyMjA2MTYwMDUyMjQuMTgzOTEtMS1rcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmcv
DQo+IA0KPiBTcGVjaWZpY2FsbHkgb25lIG9mIHRoZSBmaXJzdCBwYXRjaGVzOg0KPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA2MTYwMDUzMzMuMTg0OTEtMS1rcnp5c3p0b2Yua296
bG93c2tpQGxpbmFyby5vcmcvDQo+IA0KDQpBaCBteSBiYWQsIEkgaGFkIGEgcXVpY2sgbG9vayBh
bmQgZGlkbid0IHNlZSBpdC4NCkkgYmxhbWUgYSBsb25nIGRheSBvZiB0cmF2ZWxpbmchDQoNClRo
YW5rcywNCkNvbm9yLg0K
