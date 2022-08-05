Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DF558A843
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiHEIow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiHEIos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:44:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEE4193E9;
        Fri,  5 Aug 2022 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659689085; x=1691225085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QNl5j/LDOr3wNZ6LiceEU2mGfoZtJP0rPT2UP2+qZE0=;
  b=DeiZAOoeWua29LN4KOhUSPwMU3DeUNkSuoLFVu/xe9V7GWItU677M39Y
   kSDYMDXiWVddhs2CKJLgPfDDtjr9B3Hpf26Z109VE5pASbgVuKOjug9IU
   zxGLOGwVjZBMpxdXiFoAu1xdWcar97xwPNfCRWVN1AU+jlLFtFFoy3jQP
   uh/ul0BAMhcQMqx8cJaQhiIbuwPTweW3zVXi777jBCAni/TL77hJwQrQu
   JJI/4zqJnrQ1TnN2lD2c74GwlSC2f8eth3JoKjVv2a5AViZ49FXAJpRC5
   7aDu28GmpUy+nTQz/Xjrjpr9pVX0gDVw1NRN21CWZsUBycP9f1O4TWmov
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="175043941"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2022 01:44:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 01:44:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 5 Aug 2022 01:44:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOm2t1zi55qQ7AkX++B09X2AViFt3DIo0qm7DxziJesc8lRu+b4CorFRsephMRFoi7ViUdirnUkCAMPBn5RlW86CXsaFxWwyAHZyagxjpHziSt8OGBolihxRtfk1vc+FmgHpT6i9ewvMu6hvc8z6hl3TkR6k+mJvvTwjgw0YOKo8MpYdcz27y1Ga4zG4rlixnZLiT3pM2+gdSSz/uEDDp1omhSfuORqoleRAZiz58ikd+LyrG9XKf54qt6+uOYze4HbHQ/22Bbz4KKTz0Rzp+3JkDlXcCmLIdrs1sXuYeZouEMij7YFCu2RbUveQa6/X1kVnC4DOCGLdmpZej54F0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNl5j/LDOr3wNZ6LiceEU2mGfoZtJP0rPT2UP2+qZE0=;
 b=D0i1/2SwE46Wg0bFvBn74HJZ9shaU27W77Zda4qMkJBR0a9Rx+yziT44Ta2w444ZlZCY0HDGjlFb+Y1UXL6fIKolYbLxhN7s/zY7UUkouZPvYtY0ZwP5NgbGebd4wd5wdNe8YmjUIQwVJdnTvZTgEbCmUJtX54RVfv0XZ/MtKUbxgp4kjXESMq1kK5QNHXB8BlpyWeufRhZ5SLWeykIge/vUmOBJpRM5R97gSMu+RZ6kpZcuz0Fh+5aczOUyHwNT2B3RUOFJd/1d8oCNVsGWsl/t1xnxLecrobHQKsWrtLNZFLz2FIUt8bM6yeod4UYCIg+cqngLg+FH+xsw+S9fXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNl5j/LDOr3wNZ6LiceEU2mGfoZtJP0rPT2UP2+qZE0=;
 b=bayvFvpcOfWivrlu41y1rkf7SSYPSVqOACQRPxPgW9ZlvoIyYAqOlSA74BeSEGT4YTjC7HxM6Rc4FC5wiYuYMbUlf7ERIFdYpud0vZAaIn4wcM7m2C4OYVMP9MLZEy43FBH4wmTCOj5GUv6T+gyh5MLV1/78WAvUZmsaqfL7tbY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3174.namprd11.prod.outlook.com (2603:10b6:a03:76::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Fri, 5 Aug
 2022 08:44:39 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 08:44:39 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <Nagasuresh.Relli@microchip.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v3 2/4] spi: dt-binding: add coreqspi as a fallback for
 mpfs-qspi
Thread-Topic: [PATCH v3 2/4] spi: dt-binding: add coreqspi as a fallback for
 mpfs-qspi
Thread-Index: AQHYqIybeJXvHam7Y0inKes5YtTewq2f3dwAgAAMvQCAAAp2AIAACTWA
Date:   Fri, 5 Aug 2022 08:44:39 +0000
Message-ID: <c2256f4b-95cd-aa9b-f839-8f54e2ba8d5e@microchip.com>
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
 <20220805053019.996484-3-nagasuresh.relli@microchip.com>
 <a83c5784-6c86-497c-78d8-1550e8add7ec@linaro.org>
 <1e48a9bb-9e35-66e7-e8e7-ff5de9941fc7@microchip.com>
 <d94704b7-8a21-9eed-68e8-53221a08d677@linaro.org>
In-Reply-To: <d94704b7-8a21-9eed-68e8-53221a08d677@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0258b6c-a141-4e9f-f93d-08da76bebbad
x-ms-traffictypediagnostic: BYAPR11MB3174:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YjywgxNSTJ2I+qgbNo6lM+x1tHaYGu8vfbd/4H97138e4pr9l6U+tTtRCyV2GLhaOjmW1/CYreOny1mRHZ8lAQIPqoUXpaKU6C13opTavunXigS5wTFWeOIG+Mjb5LDSu/XFsb8ja3XeuBwpR+ZI0qcRrak4bY0x5Fv5dLYT0aNI4iAK3F/YC0/dak+hcJgjniJ1bv57a1FdV6xCPh57vnCTtkcc7wkWS4qVQvh9j6Dn8Vq0d8F4h9CEOLZ9ye4kQytEWi4JM0W5BnloShCaXJBjS5/dab35h+v/7h7eVgJ9Hwhh2vNGen1FzJKK+GR8DGSIpDFXIAE2U4lb/RJDwdFZsNp6iKJ2YsHg6ikBmZPhX0Uun9nfkcC6HBOPDDoiKeQxFXm9tA5d5qwjpifMHAxnXGHVvWe3w2nM5cCAfIf/YrsLYComQntKra6LgtnitU01Jaqi3uYU21a8C/srNyD6lbtHDPrqrzgxPBVTQHaKfdV+RKQWPk7g2Hl6FQ4Nm0TY0vkVtmVacrsMJfDR8m3vbgdVxQF9jwftcTZzXBwSj9BKlGQnDzaA/7VPUiClF+fKYrCdPGFXy2lYCCvbk+Sg1aQV5qbnmJyfHC2wjFnHN70kjc7TJvS6Ese/sQPiNobCnstjCVVVIB4EOXUaOWNRFPpjCbeiU1FYAjVc1TXKRgDR7Fsl/91glBHjg3q2FRxob4J3L4Zu5od7MWy3EAsCgHuTzCMj3TDo8XepxC3RTDGivzG4rZxoD2zHltxFO89cR+2zmSM+boxP+SHutEFz9+HGvp73M96HKKKn3moY5UfXWp5x7J4yFnsMNFO6LpqtS0ITL0epLBOKYj0TqR72av0jzhL6Ww3o2aVLYzMt3awVNx5sdPTWGZtR0ngH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(346002)(396003)(136003)(76116006)(2906002)(8676002)(107886003)(66446008)(5660300002)(38070700005)(66556008)(64756008)(91956017)(66946007)(66476007)(86362001)(4326008)(6512007)(71200400001)(122000001)(38100700002)(31696002)(26005)(316002)(478600001)(31686004)(2616005)(41300700001)(8936002)(53546011)(6506007)(36756003)(54906003)(6486002)(186003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clN4dDBHcHF0akhQV24vdFdmaGVWeG50cE54bDNHb0ZSenBqd0tRRUxzNTFW?=
 =?utf-8?B?ODRKdEIvMG9TYUI5VzUraHlWQ2ZSem9vbEFsZGJ2eVRENmhOM0Rvc3RlSjNr?=
 =?utf-8?B?NUpKRFRqMUI3YldtN1ZQcnVzTFlJSXg1YjNvZDJQS3Y5ZVZqZ0xmS1hwMGZG?=
 =?utf-8?B?M0x1WEhhOHZJYmtqdkhsRmdFVWRwODJzRkluVUpZSUV1ZnRtSEE3RXJwVUdJ?=
 =?utf-8?B?ejk0aHZtZTNHOHBwbUFZT25LWEhRcTZLZWZ2TUYrb0NwVTg1djZGYXNuYkI0?=
 =?utf-8?B?QXFRSFcwcFdka2I1cjdZQk5nZVZ2dVNZSzcraU9xYmh0d2RFbEUvNHI3YU9w?=
 =?utf-8?B?dTZJWmxHQ3UwQ29WQ0FxUHBVTHBhWjhEMWx5QXlSWVR2OSsvbFlodVErNSs4?=
 =?utf-8?B?ZURCU1JXWUxNeFJMeDVHL1R6SUNwZ3J0WjNKbzhzaC81cithSGFSTTMrcW9v?=
 =?utf-8?B?YnU3REZxMVQyRkY0c2JHaWZVMEFzMkxjamtwNVBoNTJUUjVqQ0pyMWJSbXdX?=
 =?utf-8?B?VjFNKzVrTmh5Vnh2eWlIOEhCTDlzQWpTK0RQTW1BYWdxNnR5YVNWZWZvaEIy?=
 =?utf-8?B?VzBrOGdMQ2FOWm43eXljN2Z2RmFYUHVidEpJTm5EOUJqcHNJUk8xV01UTWl3?=
 =?utf-8?B?S2tHOTFNeDhIbGpRUFFrNnIwRGVvT09UbDBMSzRqTGl5OEZCSVc5dE1WUnZu?=
 =?utf-8?B?N3Y2V3pVK05SR0FpUUhWTW5aanNyblZ0VnVNdm5CNnpzUU5UVlBsaFl6ZUVq?=
 =?utf-8?B?d0JNVUFLWDNjOGJaR3VyNWs3bjJtUHFJQS93Tm96TVBJTkVJZ3ZTU0xzNFJu?=
 =?utf-8?B?SW96ZnlKVkxGM2ZZY0pqL2R5TjJSODdlRzF3M1BVSkE0dFFNc3lubEJFSGVk?=
 =?utf-8?B?NXUrZ2VaN1Iza3JMNGpJV0ovdHJnVzF6Vkc2cVQ4a0syb0p5a2w1TjcvUmF5?=
 =?utf-8?B?SmkwZkYyZXZ2TTRWbXpLUDQxYWpLMXVmUisrclBaeUZWenU1bVAyMy9zL0ov?=
 =?utf-8?B?Z1RLU2tGcDM3NjVrR1VzNUdYRlJaOWxId09JN2hBcEZtRFNMWmYxRmw3MFZE?=
 =?utf-8?B?SXlFWGxCS2xjRWtxWHdrZ3hhd0hVdGpuTjREYmkrNnhHNmRCbnZLMko2M0Fz?=
 =?utf-8?B?UnB4aXJZQUlsUko4RVh6RUxZYllFVkRBc0w4S3NWVEk0WngrN3VHNGtQTGQv?=
 =?utf-8?B?VXB1UjZnSkgvNVJrTW9Jb0RDaE83ZHJHZ0FvN0hnck0xUXo5N0Q3YTVDU2g5?=
 =?utf-8?B?YUZXUXMvSHhQd0Rwd2R6YU5DK1ROTHZXekFLc29oaHk0MStmaTVFdGhzUE1p?=
 =?utf-8?B?YytQYkkvN1BGQTdMMHJNd3dOcDN4ZnMwNGgyVENqOHFXNlROOXcxVlEwN0Ux?=
 =?utf-8?B?cWs3MnRlRXVQSGdEbWM3QWMxRG9WclFKcDhMbUhUakFURU81M0duOXhZOUxh?=
 =?utf-8?B?STBvcURMbzhFVHBQYUpscWt2bGdwTXJXemQvWlltT1JvUmdsNWdpc1BHYUlm?=
 =?utf-8?B?OUpLVFE3YjF1NG5OME1GQ01PU0lmMkNwMjdNWDFZMjRRZjRpaWl2NnpLeVpl?=
 =?utf-8?B?eDlhZzhOay9OK0d6UG40NnlVMnVadDRNcUd1ejBhcDdCdE5UemxFZlVOY24y?=
 =?utf-8?B?aWpUVEdndDBhTHh1QzduVmgxQXQxblpkbjBGQW9kbjh3elowVy9nUkJsWnpR?=
 =?utf-8?B?eXVRQkdXQ2t3RlVzMmREaGdxcEs4UTVnZEtKemhmblIvZDNrM0xXeGZydlUw?=
 =?utf-8?B?MlN5c20vUkJEKzRSc2E4YmZYVVZvdlh0Vm0reGRmMkNaTzRQNU1PMGE1L25T?=
 =?utf-8?B?RUZnbE5pT3RUMkwxRmVGNzVtbWtxUWtZeDM0TkQrVjN3bjFGSmw3WG9NN0ZI?=
 =?utf-8?B?WURhMy9KSTFtVnRrSTJHYjd3VTMzYytOb09XcVE5SGE0bFhXSGkxalhUN2VU?=
 =?utf-8?B?bEhPWEpLdDRnM2NKU2gwSjhUVXprTFRHZ09iRDVMOUsyYndvc3FQUXRIZFdW?=
 =?utf-8?B?bkZZcFArV0FhZ2dLdWloRVFVQmxObmRMVzRkSVRoNy9DVUJoeTdRRzdpNnh0?=
 =?utf-8?B?WHIreGE5ZStYN3B6ajFDanpFV2s2OWdkMUxUZDVwNjRDaUlOTnJ6QjJnZk5L?=
 =?utf-8?Q?wEABL86dgOJHSVv6vP+sriw/v?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E798D07F6F51954386F4C19FC8DBED2F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0258b6c-a141-4e9f-f93d-08da76bebbad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 08:44:39.0483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88iiUFCdInzMPmDgpJ8nndoW2Wyq+OUk6BWAiVBVwb+eXsN9RrgoZj0qAOxhSt0CmPvZRAg51dcCQ+S3u9CcJETvw9rLzMhCU9q+gJEeEtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3174
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMDgvMjAyMiAwOToxMiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwNS8wOC8yMDIyIDA5OjM0LCBD
b25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDA1LzA4LzIwMjIgMDc6NDks
IEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVu
dCBpcyBzYWZlDQo+Pj4NCj4+PiBPbiAwNS8wOC8yMDIyIDA3OjMwLCBOYWdhIFN1cmVzaGt1bWFy
IFJlbGxpIHdyb3RlOg0KPj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NwaS9taWNyb2NoaXAsbXBmcy1zcGkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zcGkvbWljcm9jaGlwLG1wZnMtc3BpLnlhbWwNCj4+Pj4gaW5kZXgg
YTQ3ZDQ5MjNiNTFiLi44NGQzMmMxYTRkNjAgMTAwNjQ0DQo+Pj4+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbWljcm9jaGlwLG1wZnMtc3BpLnlhbWwNCj4+Pj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9taWNyb2NoaXAsbXBm
cy1zcGkueWFtbA0KPj4+PiBAQCAtMTgsMTAgKzE4LDEyIEBAIGFsbE9mOg0KPj4+Pg0KPj4+PiAg
ICBwcm9wZXJ0aWVzOg0KPj4+PiAgICAgIGNvbXBhdGlibGU6DQo+Pj4+IC0gICAgZW51bToNCj4+
Pj4gLSAgICAgIC0gbWljcm9jaGlwLG1wZnMtc3BpDQo+Pj4+IC0gICAgICAtIG1pY3JvY2hpcCxt
cGZzLXFzcGkNCj4+Pj4gLSAgICAgIC0gbWljcm9jaGlwLGNvcmVxc3BpLXJ0bC12MiAjIEZQR0Eg
UVNQSQ0KPj4+PiArICAgb25lT2Y6DQo+Pj4+ICsgICAgLSBpdGVtczoNCj4+Pj4gKyAgICAgICAg
LSBjb25zdDogbWljcm9jaGlwLG1wZnMtcXNwaQ0KPj4+PiArICAgICAgICAtIGNvbnN0OiBtaWNy
b2NoaXAsY29yZXFzcGktcnRsLXYyDQo+Pj4NCj4+PiBFaCwgdGhpcyBkb2VzIG5vdCBtYWtlIHNl
bnNlIGFmdGVyIGxvb2tpbmcgYXQgeW91ciBkcml2ZXIuLi4NCj4+DQo+PiBXaGF0IGlzIHdyb25n
IHdpdGggZXhwbGljaXRseSBiaW5kaW5nIHRoZSBkcml2ZXIgdG8gYm90aCBvZiB0aGUNCj4+IGNv
bXBhdGlibGUgc3RyaW5ncz8gVGhlICJoYXJkIiBwZXJpcGhlcmFsIGluIHRoZSBTb0MgcGFydCBv
ZiB0aGUNCj4+IEZQR0EgaXMgYSBzdXBlcnNldCBvZiB2ZXJzaW9uIDIgb2YgdGhlIGNvcmVRU1BJ
IElQIHNvIHRoZSBmYWxsYmFjaw0KPj4gdXNlZCBpbiB0aGUgYmluZGluZyBoZXJlIG1ha2VzIHNl
bnNlIHRvIG1lLiBjb3JlUVNQSSBjYW4gYmUNCj4+IGluc3RhbnRpYXRlZCBpbiB0aGUgRlBHQSBm
YWJyaWMgYW5kIHVzZWQgdGhlcmUsIHNvIGl0IG5lZWRzIGENCj4+IGNvbXBhdGlibGUgb2YgaXRz
IG93bi4NCj4+DQo+PiBUaGF0IGJyaW5ncyBtZSBiYWNrIHRvIHRoZSBvcmlnaW5hbCBwb2ludCBx
dWVzdGlvbiwgd2h5IG5vdA0KPj4gZXhwbGljaXRseSBiaW5kIHRoZSBkcml2ZXIgdG8gYm90aCBv
ZiB0aGUgY29tcGF0aWJsZSBzdHJpbmdzIGl0DQo+PiBpcyBrbm93biB0byB3b3JrIGZvcj8NCj4g
DQo+IFRoZXJlIGlzIG5vdGhpbmcgcGFydGljdWxhcmx5IGJhZCB3aXRoIG1hdGNoaW5nIHRvIGJv
dGggb2YgY29tcGF0aWJsZXMuDQo+IEl0IGlzIHZhbGlkIGNvZGUuIFRoZXJlIGFyZSBob3dldmVy
IHF1ZXN0aW9ucy9pc3N1ZXMgd2l0aCB0aGF0Og0KPiANCj4gMS4gSXQgaXMgcmVkdW5kYW50LiBJ
IGRpZCBub3QgbG9vayB0b28gbXVjaCBhdCB0aGUgZHJpdmVyLCBidXQgbm9uZSBvZg0KPiB0aGUg
b2ZfZGV2aWNlX2lkIGVudHJpZXMgaGF2ZSBzb21lIGRyaXZlciBkYXRhIHRvIGRpZmZlcmVudGlh
dGUsDQo+IHRoZXJlZm9yZSAtIGZvciB0aGUgZHJpdmVyIC0gdGhlIGRldmljZXMgYXJlIGlkZW50
aWNhbC4gSWYgdGhleSBhcmUNCj4gaWRlbnRpY2FsIGFuZCBhY2NvcmRpbmcgdG8gYmluZGluZyBj
b21wYXRpYmxlLCB1c2UgbGVzcyBjb2RlIGFuZCBqdXN0DQo+IG9uZSBjb21wYXRpYmxlLg0KDQpS
aWdodC4gVGhlbiB0aGUgYmluZGluZyBpcyBjb3JyZWN0IGFuZCB0aGUgZHJpdmVyIHNob3VsZCBv
bmx5IGJpbmQNCmFnYWluc3QgIm1pY3JvY2hpcCxjb3JlcXNwaS1ydGwtdjIiLg0KDQo+IA0KPiAy
LiBPdGhlcndpc2UsIG1heWJlIHRoZSBkZXZpY2VzIGFyZSBub3QgYWN0dWFsbHkgZnVsbHkgY29t
cGF0aWJsZT8NCj4gVGhhdCdzIHRoZSBzZWNvbmQgcHJvYmxlbS4gSWYgb25lIHdyaXRlcyBiaW5k
aW5nIGxpa2UgdGhhdCBhbmQgY29kZXMgaXQNCj4gaW4gZHJpdmVyIGRpZmZlcmVudGx5LCBpdCBs
b29rcyBsaWtlIGl0IHdhcyBub3QgaW52ZXN0aWdhdGVkIHJlYWxseSBhbmQNCj4gSSBhc2sgcXVl
c3Rpb25zLi4uDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
