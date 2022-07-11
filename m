Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A29570A03
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiGKSfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiGKSfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:35:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93975FAF7;
        Mon, 11 Jul 2022 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657564542; x=1689100542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H5tW3po4l2zMow9OrE4ghvA4aiWULJvWcCJQkVpWe80=;
  b=xrq+Y/b6gikF8TwGC9cPi2zfWFQEmry1qK7nWCW6tpRj1mRvOyKT2Nr5
   diF4kwsNcuKPtSWa5iMZLVMwot0FAJCOysG2jDsDq/jY0ygOuJH2VLK4h
   De5ahY6aczo95NeiGiqukgDqH3Nb8Qjyk3cNnNY+8FVE302ic+JNZzWi9
   oJKyT/5h423XUmlZWBovv+kJNvHiUSMCCjubLnnfiCGeffxvVvCZQU61V
   DRTWvbkTSyH/KF47nOlUqKb7nLjbOXXX9VSPvfmApFOJmM6TpVwlF4IDD
   3NVHNWrHoLAeBuFokTE+4ClnDcKkF1Ad4oOLhAvHF7rPghlP3lYfjA1S9
   A==;
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="167333644"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 11:35:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 11:35:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Jul 2022 11:35:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqNC8r+GRpxmbSqk++WzD35Zh9MyfHx9AFcieE+EVntFjTPfKkwN9ekXf6HLO/zCvqLoFu404l45IyA7NFU2Yjn0zh2AFOcHqsyr8Ev5SKGLGV6uUELHUvcYXdF8MHsZfk11zPDSUM+6BAF6HqqsdFRdAza3atdCKnjXsvropCPSfZyZJDUdr3lribtvNn4hw42VqsO4q7Cs3zvYkYcdxzKpXQDG6FDnDUSYYYlqkOaqfus9lMFfMbEF+Fnd5/p5awNjyZBXsqE1ykUJNScHB//b0xwcVGQp0b8uvTRk5Cgi0pcfm2hRCz1lcM++GOkhCAIDmf2YNr8raMV2tcJEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5tW3po4l2zMow9OrE4ghvA4aiWULJvWcCJQkVpWe80=;
 b=RpZ4PMGJqFq0H4SmpSXKMjancjFnYpBYp9merdnbLnN6+7p3oxrtkFZh4/Fdgc/N5M6+Yc1mpxPtFRlN7ccaY5CErBcNsakBK2Hv30w2P0HsLrcki3H9OGFifpNA+XQgwRD06r5mYGwSDo27CIcNVeXgIE8ssoDSMojfqE1p3ljgFDavUmxN1vBqjRg2VvnS8uF46mvXBydY2cFNtVfo9ohEMdnAf+2pRyzfW8eS3n2+wphCnfaIU/Cpp+jVaO9gA6JMU4wEDezOWZ9dW7j8rR/lJj3iMAukDBKkFp6WHRoIhFeChsf8OqSqQ/W09RLALL5DTnyzYVOUPYgvugKoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5tW3po4l2zMow9OrE4ghvA4aiWULJvWcCJQkVpWe80=;
 b=JYS9j2sgROArC7uD3kjE38w2qULqaWH0/VtvrxruipwC1rNP4/K+9g+1UxiKwMZD/aKXIirqBjkIrcHctdi7fdT8wBkHOZEvddZ1fmXls6l27/MFrlpMZqTxuhNliYh+WeYw2PgP9cjB/JsJO7daIcYu0ptfSHfU94ov/5K/mg8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 18:35:09 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 18:35:08 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Ryan.Wanner@microchip.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] dt-bindings: sound: Convert to json-schema
Thread-Topic: [PATCH v2 0/2] dt-bindings: sound: Convert to json-schema
Thread-Index: AQHYlVTyYonqOIFmQEKungwznccSFA==
Date:   Mon, 11 Jul 2022 18:35:08 +0000
Message-ID: <f13ef75e-c884-eac7-2e88-b0d9bb7b0a3f@microchip.com>
References: <20220711183010.39123-1-Ryan.Wanner@microchip.com>
In-Reply-To: <20220711183010.39123-1-Ryan.Wanner@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54f1274a-d5cb-4d74-5069-08da636c1521
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 49bXnUaRbyvnBoZZHc6z9jbo6zd7WmAf4Wx7CeG9upEZ32r1nCa551zS7Llnr6m1CSxH5IQLOp0leAXSLHHDvv1ZMiUf1V2gABS+2+3w6O5xacgKZ2r/Q1F1vHlkq+zQ5/fBEQbRAEnqfwdzw/UtVDo7PTuZ+HZsTFNWNXWDtiH2YhIBDzcAgYDXoF85hp0xlbj5kiLRf1hGVtPmr1l7jsyto+SFiGSueZPQ+cDPStxaQc6/pzuK6GFIjJXxFPt/9cSVYPcPHBQVn+x2cd68BGRIvY0CqTJdOJAXWJnJ8HrBVeysz+FzMtHh2WCjfoy3vrI2JUor0YdhizUGqGKD04tLWMl3PyrcAPInG9D9Y3+shx30umxmnBusuF8h9/AxFNHUjkbwe7IKq3nmrZPWQw+YZYdg6T8ExGKgwB+tafFtVvemdDtAJ7phBf2CCdXqUByx+CTgyCLUdg0I35GbCzg5QJF6nQ/HC0P01ZuezcZpCIxgO9vVR945XRZr9pK4N2AYLKFrKM1wes/81ShKE4bTR3L38dnvPQEt6RIJOeRH2ekYXTHPm4m4hvDm5JgmbrIaxzCH75JUU9VRbmtGJTzSh5eT3V+W9nB55DQFq1BbH/zZgOP5/Zmqbh+sZiZIXkTX0udL+sGQ+8hRaRzxKhWz3O54TszYYYWsRDAZp34Gu4ZgtNcvU4LtKSOPiZ3mIDc/YEFBfzQ7KbfdTPRpDCMnfQ6yD1cz9KwvACZXbpwtZU8Y+CH04zUiZuAGiyUC59XIvBQZgE9dtnHXl9TmO1xEzlRm8O+Ev/HQs2BuPOM8DP6Hbyo1azbb5GHWoUTmAD1yXRirsDunjt9b36MkUG0uOczDMENAEsO59/2xpGeeZt6JNLsJ8apvuW7NBbu4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(366004)(39860400002)(346002)(2906002)(41300700001)(6512007)(26005)(53546011)(6506007)(38070700005)(122000001)(38100700002)(316002)(66556008)(8676002)(2616005)(76116006)(66476007)(64756008)(4744005)(66446008)(5660300002)(66946007)(91956017)(4326008)(186003)(71200400001)(6486002)(36756003)(86362001)(31686004)(478600001)(8936002)(31696002)(54906003)(6636002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE5zTUJEWjdsdTU1SWFtSFdJOHZhS3J5d0xpakJOTERtSk0yZ3JqWmluaGZ0?=
 =?utf-8?B?MXZGTi9LdERubU92M0JWYzJDQnRWNjdDTGhlYzZxUHQ2OUU4TENrZmxJOUN3?=
 =?utf-8?B?ZGFTOCt3YVlTWVBtb2ZSM0RMZTltdkNXYUhWdCtCNXNyNG8xbFFxNlZJdjlE?=
 =?utf-8?B?VzhYejBIakh6ZENyeDZTWCsxY2ZhUEVadTdpeUVJSGlMSTNWTGorUUxKdHd6?=
 =?utf-8?B?V3YwWVhyUzJwYzRzM1FUY09nTmtKZFJJSnlnSzNQNVgrQmZodFhJM2xma3RD?=
 =?utf-8?B?aEF0ODIySDVMeWJQdTBOU0g5WVFkMElDM1IyS1NDMUtuNnVFMDNuRXBsVDdT?=
 =?utf-8?B?aGl6SmM3VXV1bjhveHVOaVdnNXRReUZVQlptMjdJQnZNU3NIamZ4SlNpdFdt?=
 =?utf-8?B?TnJhcjVLd21kR1RKOWJXQkNtSExMeW5kLzBzWk1UWGRkY0MwTFFMdnZUZDdk?=
 =?utf-8?B?M2hka29mRXZkSlkyMC92VWprVWhGZ1d2NXF5cGlVaG5KVG1sK2Y0T0JXRlM1?=
 =?utf-8?B?SnRtcHJacjdvNjZwK2tsZkxqTnYvK0NkcVlJKzNsZmFOaXIzL0ZiSzNtL3BU?=
 =?utf-8?B?U0s3a21KbW1ERHdpN1pudGlzQjE1Z2V5WkhobUFCRHVaMmo5aEVNZGx2Nnd3?=
 =?utf-8?B?N2RLaGpLaWFIZXJONXdwR2RMSVdhT1pCK1RVTkI1TmVoUU1tR1N1cWcwSW1E?=
 =?utf-8?B?TXRZZkxDMmpVWDNHcXU1dGdvZlhEY0F6QmduQ0tFL09EN2lnQ0gvTzBueFN4?=
 =?utf-8?B?Q0VTeTNtNUptcCtXckU1YVNRRW84TFI3WlUxcDBKazFOWGNKeXUyTzNsTW5r?=
 =?utf-8?B?dzd1MHlQSnFrdnlPanZCM1NTNWZQTVhrdlZCOHM4MHF5bEs3ZzVuNk9WUlJh?=
 =?utf-8?B?S0VSZTB6dDNSajZIRzV5VTd0cWxwLzVIa3NsU1lJZHpYbDZFUkROeE5aRmps?=
 =?utf-8?B?TVMycWJKWXExVHFzNHhRK0VOek4ydCtOZEtwOHpRYXJ1bGNvRUtSRWxqcnR0?=
 =?utf-8?B?amI2akREcEIwR2lGNktyenpUVFp0bTlnc2YyOGhGWHVSOFAvWE85QlNhQzJt?=
 =?utf-8?B?QndSOEJhdkRWTTVWWnBjdVo0UXZVellCYndkWGQrQTZML2dFcTZKZHBIY0dy?=
 =?utf-8?B?N1R6SC8zU0FUV3U4ZDA2VmxLQ0thMnRZTmcrVTc4U2NnYUVqS0tFcHZhempT?=
 =?utf-8?B?b3JONTNkWWllT2tRR3pwTWo4bWZqelF1dGZ1cjd0dzMrOGFwOUlkMHhOdUp0?=
 =?utf-8?B?SVNjTGpEaVpzVzUyWW9SeHVnN3RqQjAxcDVST0lKOUNSQU5Sc1ZQcGRWYkYw?=
 =?utf-8?B?VWZlUit1aUV6Z0NKdWRNTjY3aDBlTGwvTkMwLyt0VzhLVVBHSnQxcHBuWDF0?=
 =?utf-8?B?UmY1VmhQbVJRbHVFS3I5V3JLQnFQcXdPVWZ4U3dkdVFoSXk3dGEwOEc1ZCs4?=
 =?utf-8?B?ME1KT0NpMnppdE4yYTFQN1R5dFQ1cWNMSklqbjlZclNVSTEwdmdQVTZMdnhG?=
 =?utf-8?B?a2MvRzhYNnRDVmFzeW1YcWlIV2NVcGtwOUdjcGVsbWIyaFRhTVF4eTVYMjBI?=
 =?utf-8?B?NzRDbWRRVmorZHR6STNjVzdIcWF2SHBjRTlNK25jaW5kNUtRaDVCQkxsUVdn?=
 =?utf-8?B?QmNNQUZSM0NGZnBGT3BVaVNieVpLQkZwVTNIeklXT1IyQWVUQWh2S0c5dGhL?=
 =?utf-8?B?UTQrcjhqRVZxeHM3Tit4N1UwY3lpWWM3V3VRYTlvMzZIV2oxb21Ca2pPUmJL?=
 =?utf-8?B?R2tPN2pyOThVaTBkdDk0cUNndDRHVTRTUGdyb0Jaa2RXZmlWd0E4N0ZvSGhN?=
 =?utf-8?B?eitwdDhrajJPSnlQeVU2RXZDc0FUbnMyVGhvWGhQTmJUZ2JZZTN1QlgyOCt5?=
 =?utf-8?B?SGswc3RnS2pDdUZnaXpXeEpGV1lVK1YxQUNRVGhlQ3ZVWkF3dDBzUlQ0bHBy?=
 =?utf-8?B?YlpkMDlmMktaY0JNcUxwMGRjQlhYc3k1WUhVcExDelI3Wm81VHNWYlZZaTNn?=
 =?utf-8?B?YW1BZitQWS9PVm1qRTdhOUNUMXZkeUpPbzFLWVJOK1UxTGJtZlU4TjNXbWRn?=
 =?utf-8?B?M1hPSXMxOU52bUZNS0diS2tYbG05VnYxSWM0bFpOT3gwL0pnRlVNNlVIbnk1?=
 =?utf-8?B?bzVlenNod1R0blo0ZnBhRXh2eVZkYlJRTUROYUNDTU9nb2ErTU1NWTBDWjRq?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <310D85E49B5E8F46BB6DAC355105F742@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f1274a-d5cb-4d74-5069-08da636c1521
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 18:35:08.8312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sL3I621hWsNvk7Es38NDesIImbUoWLyeOc9lc8q8wWg99WlNs8xcnUMTHxamxFFNNUIo7AK8gqkWyDFhyu2gYoBOID1b8r9/k60xiZkFXkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3668
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFJ5YW4sDQpUaGFua3MgZm9yIHlvdXIgcGF0Y2hlcywgZ290IGEgY291cGxlIGNvbW1lbnRz
Lg0KDQpPbiAxMS8wNy8yMDIyIDE5OjMwLCBSeWFuLldhbm5lckBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPiBGcm9tOiBSeWFuIFdhbm5lciA8Unlhbi5XYW5uZXJAbWljcm9jaGlwLmNvbT4NCj4gDQo+
IFRoaXMgcGF0Y2ggc2VyaWVzIGNvbnZlcnRzIGF0bWVsLWNsYXNzZCBhbmQgYXRtZWwtcGRtaWMg
ZGV2aWNlIHRyZWUNCj4gYmluZGluZ3MgdG8ganNvbi1zY2hlbWEuDQo+IA0KPiB2MSAtPiB2MjoN
Cj4gLSBGaXggY29tbWl0IGZvcm1hdHRpbmcuDQoNCkZvciBzb3VuZCBiaW5kaW5ncywgSSBhZmFp
ayB0aGUgc3RhbmRhcmQgd2F5IHRvIGRvIGl0IGlzOg0KIkFTb0M6IGR0LWJpbmRpbmdzOiBmb28i
DQoNCklmIHlvdSBldmVyIHdhbnQgdG8gZ2V0IGFuIGlkZWEgb2Ygd2hhdCBzdWJqZWN0cyBmb3Ig
YQ0Kc3Vic3lzdGVtIHNob3VsZCBsb29rIGxpa2UgeW91IGNhbiBhbHdheXMgcnVuOg0KDQpnaXQg
bG9nIC0tb25lbGluZSBwYXRoL3RvL3N1YnN5c3RlbQ0KDQpTbyBmb3IgdGhlc2UgcGF0Y2hlczoN
Cg0KZ2l0IGxvZyAtLW9uZWxpbmUgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
dW5kLw0KPiAtIEZpeCB0aXRsZXMgaW4geWFtbCBmaWxlDQo+IC0gUmVtb3ZlZCB0cml2aWFsIGRl
c2NyaXB0aW9ucw0KPiAtIENvcnJlY3QgZm9ybWF0dGluZyBlcnJvcnMgDQo+IA0KPiBSeWFuIFdh
bm5lciAoMik6DQo+ICAgZHQtYmluZGluZ3M6IHNvdW5kOiBhdG1lbCxjbGFzc2Q6IENvbnZlcnQg
dG8ganNvbi1zY2hlbWENCj4gICBkdC1iaW5kaW5nOiBzb3VuZDogYXRtZWwscGRtaWM6IENvbnZl
cnQgdG8ganNvbi1zY2hlbWENCiAgICAgICAgICAgICAgXiBmb3Jnb3QgdGhlIHMgaGVyZQ0KDQpU
aGFua3MsDQpDb25vci4NCg0K
