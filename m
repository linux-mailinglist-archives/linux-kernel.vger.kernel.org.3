Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AE64EC592
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbiC3N1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241609AbiC3N1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:27:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E0D68320;
        Wed, 30 Mar 2022 06:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648646748; x=1680182748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3Z8bHSca1BOCh17eO4NO8sqhrE8EvPIwWxOhw4eZY+c=;
  b=c7ndrjWbG9B2L+ipaUcBXHf6ZtwfAhycMxCZb/5pRHENFI/0gbhkE7wh
   mYgXudZ1fhearST958oYFPJvtHrldLalhUpHv2cq+1vfXin5Jq9mMTeos
   0ehE0C+kjxZM66AzHrZMZdfLZpmiuDNgQrXdvGegtO/j7OqnjaTb66B2o
   dUly2nSO/pKqpKmOCnESXLBKdjLFDJNUXXTAyb3lr9CngaXGIeDUSNFFH
   bfiqZ/g7Y2YmbhbBhnDPNkLuFnVKZZ0EF33dCq/5RGv17RoP1fvJi9Cni
   SeHdAf+K0eGsqb9gj/ES14WP2p1yl7U2BfA8M/GmYVpcjcRd1yuar87cI
   w==;
X-IronPort-AV: E=Sophos;i="5.90,222,1643698800"; 
   d="scan'208";a="150906832"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2022 06:25:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 30 Mar 2022 06:25:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 30 Mar 2022 06:25:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bV9BNPo5P8nsh+XYDCTdrXvHI+VnwxfqeiQr/zQ2USBD39Yg8fAvNY1zTCJH2tlIWBC32dUYRUGN4iUV3IMSHL1Zh2PPqOIji68V82zrh0MLFWJ+WJkbiD541fJ+bXMIBZqn8mvEuy9QyhnUP0opX3H/dc47lunlyf+M18KtydyzyDcaEyGdvs/tsi7/eEuhbwbEui4fI65I47F41FBcxlyytHH2lPz7Barx7uc3oIrcVOA0QlapSXwnZpY70pwH5fIkNo5fOnucugyK0/76HvSMq2QsBGU77TgS6cTnDN2LNR7hw8tVfI+DUbFuD2A3ksZZADqrrLepwxuwixVcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z8bHSca1BOCh17eO4NO8sqhrE8EvPIwWxOhw4eZY+c=;
 b=keja3t1LbWTDJZPK+a4gg2/xxCFULhzciCf2w/eFGqJcaWC2omADENun4YURbPNlJsItahgjuBGWhAJ/UQHctSvM3/O6t4bOKRXfGIM8wn4094dS14SByBtdyoqwOTE8OJPgraqAmNxzOLnbbWJZRVDMmbVdUGRQwE3ar3Ie/zfV+FjfVn03r1HHswIhb6SHJsJeFoRYLgJD59OETIYAftIe1fhWPQuoiBPO6DG//RQaAiylcWWGZx8pYh0sTiWmyhTSaqptJHhT3N2xymB4zgws0izLaskW6Ga9LY2N1+2yeo5oddjegZlBwRXfGN3dWVZsG1nQdH2yNtFQ3SJ9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z8bHSca1BOCh17eO4NO8sqhrE8EvPIwWxOhw4eZY+c=;
 b=byJ6OzDqENSl7rOLPfKfQsQZ0XMrI43kge1FsHRuUso4+Macv7ypw6QrXGfy5NMaFMDFl6PfhDmLdgSUBIY6INcTVOoSYSox97Psul15x0t+p313pWuryQkNFn3v1QOHjkf3BxE4bNMka9v6GSdT+MniA6c9CNP3bgjD5+XnJv0=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by BN7PR11MB2531.namprd11.prod.outlook.com (2603:10b6:406:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Wed, 30 Mar
 2022 13:25:44 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%6]) with mapi id 15.20.5123.021; Wed, 30 Mar 2022
 13:25:41 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <Kavyasree.Kotagiri@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 3/7] ARM: dts: lan966x: add missing uart DMA channel
Thread-Topic: [PATCH v2 3/7] ARM: dts: lan966x: add missing uart DMA channel
Thread-Index: AQHYRDmn6tLfPKgfskCEwfEIjqkd7w==
Date:   Wed, 30 Mar 2022 13:25:41 +0000
Message-ID: <0fd20108-b5dc-f220-5721-9c349145248f@microchip.com>
References: <20220304153548.3364480-1-michael@walle.cc>
 <20220304153548.3364480-4-michael@walle.cc>
In-Reply-To: <20220304153548.3364480-4-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f89f551-b555-4362-6685-08da1250c9ae
x-ms-traffictypediagnostic: BN7PR11MB2531:EE_
x-microsoft-antispam-prvs: <BN7PR11MB2531F4E3A5B12E19673AAACB871F9@BN7PR11MB2531.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BwUXA65VijaeJmwZW4me78VWxUGPNs0rzoOdTnP2gs8QkFSgRbypIrQ8EI0us/KOdNUdcYZJGj6U7zXrY7/6V2DC77Fi3rf+XJRmn2fwrcps4rNt2iQTPzg3S//2FWl06HrMgaaidtae2RRl8irwx5zdRYgR4l5h6srSC/IwUSNupDs2+WGEfpdm8N86Qrnu5CV3DoZJJISg5c9iEV2h7rSmezE7KGg9tr49dsk9p8nAiicIAApoduH6OF6SGL054S6pduuHAQHPoGj+F9SfPwo7FaXz06DzoGQ4eASMpOPcC3zmnEkcacEPktSIXJVhZE5Ir9rTFrmZTPWCJNgAOC5NqLuLTo9RpNWh8D3TYKoTVlMBiHT3nTH70ptsAusLhEseV0rToI2dp+VVayO8I3WBznXi4glayx3FESSlOsjuiCZqeCxtzexNvH387O95Fji+nny+swIcsnuJn50BkuXNgysCl5R5FntnxD0AJeQjl64hXtQaMyEfAxfnn99nj4H/VaaCb8TdBrN8UqP7ovGJLud0K7KRkosI0NFfE3YtRCjBprUih3p6ExIw3ugBtmX7WLUpCLTDjRbHwubnVW1djlh50oorDNMmhLEwuiscVtJKF/XC+wO5XXu7b9VCpW8vQenm8cRdXZvEsDDpgFMJoUhxTXtA5mVoi654Odh3ei6kSe0bDeoT1zyEAYqaSTmY64ZYOkQZfUaikbf04cw07huhWJrjoXFpuGd/v+bFqQ8X9Z4jlw+Wc1UYujdnAVOS/QmnhMF5GeidLvCcrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(71200400001)(38100700002)(6486002)(4744005)(8936002)(122000001)(186003)(110136005)(83380400001)(38070700005)(26005)(54906003)(508600001)(86362001)(31686004)(53546011)(2906002)(76116006)(6636002)(91956017)(31696002)(316002)(66446008)(36756003)(66946007)(66556008)(64756008)(66476007)(8676002)(2616005)(6512007)(4326008)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUl6R0dXVEI1bm0valZEOFVnd2xYbVZ4RThOOHh1OEJTdk02aTR4WWhVYy9T?=
 =?utf-8?B?TmVpVVFITTRMWHdmTmlTWS8wWG4zSThsRldaZzF1NUxuOWowQUxObGhjamNM?=
 =?utf-8?B?SzVGandicEpCdi9CUUwwOFZpUThvc3NHREdMQ1JQdEdaWTNBT3FqQzVQTm5D?=
 =?utf-8?B?SjhkbGlQVjNPZmhnc2ZTSW0yWW03c05Ic3NVK1ROK21TZVlGR3c5d1Z6SXRU?=
 =?utf-8?B?L1B4TzB6eEpxazNuOWFreHA5V2hZUFl0QTBLQkd6UzgrYUVjZGZYQkk4bk1r?=
 =?utf-8?B?a1UydExvczF3dUlRTUZTbnk0bUIveXpLSDhLTGFhRXpQRjA2Snh5MTJFUUNm?=
 =?utf-8?B?V1NRZHBiVVJxWE5URnhXSGx6RVlFTTBoZFVGQWQyaWhpb2lSS2ZSaXVNOVdO?=
 =?utf-8?B?d0NlS3VPcjB2NVMvUHpIczQwa3J3SUF4OFROa2twaU5TVWdXTG5ZYnZjTEZ5?=
 =?utf-8?B?N3hVajhzb0JDN0Z5VUpiTXliQVBISGtISlRFTEx3N0x1Q1RROWJvcVlqa2JT?=
 =?utf-8?B?Qk8yNDl3N2t2K2xSN2luMVdyVXVtNmVpNENoZU9aRkMwVjZiRWY1dGFxV2g4?=
 =?utf-8?B?Smo1aVZndW9odEphZDVIY1Rpb0prSElFN1R1MlRJdVJRbW9Lcm1YTFV5QnV1?=
 =?utf-8?B?NVBYOVpsMmNkVTFKVDVPN0NXVDdIbmw0UUtkdGRnTzU0YW1EUkpPUFprRE1N?=
 =?utf-8?B?bGxkZTk0R3prV21LcEFoaWFtbWtiU1FFTWJSL2d2UCtlN3drcWpaV2tISHZV?=
 =?utf-8?B?RGhLK2ZTVzRITm1hR1QyNkdRRWRIY1hWRzhabkVXT0pYa3ZHa2tJRjMvRTJX?=
 =?utf-8?B?WWtEbFBoRGVINGU4WG9Ga2hvZjhOVzRpeUJDdkFBUVozajArTVZNZDQ0aVJR?=
 =?utf-8?B?THNTSCtRR3dOSmZBbjJmVFFTM0xDK1VPM0RVRTN6TGdKdWtoLzlIUHhaaEhD?=
 =?utf-8?B?YjIvWksrbUlDUTVuUWZPWjF6dUVjODMrSWNMRnFkNUtpRGh0cW5jemhvWWpZ?=
 =?utf-8?B?T1VsTkV0aFJQa1RHQ0t5eXBYRGtIZ0pLbXNzSFdGUklkbXY3VDhxOWxseWto?=
 =?utf-8?B?a0tNaTlQRUlDVVg3VU1memNhK3d6TzVyZHE0bzV3YU1samJRN09YSWRnaHlp?=
 =?utf-8?B?aG9XZHJyR1h2YjZycWdNdWE3dmdaZnhaMEE1blpLdjFaZWRNWW5BbHFVYXlh?=
 =?utf-8?B?Q1JxU0xjVUFydHBHRWx4N1A5MEZXVXJ5dTBCQkZiUnVuMzFiS3hMY2hNYzkw?=
 =?utf-8?B?cE5PUGluTWNVWUpEdkhPOEdueWpoY2x3elhGNTNqVFg2emt6VXdLSEJpTFdV?=
 =?utf-8?B?U2FXNEZ5WFlIZW85VnRXcmwzMkFQSm01TUtNWW5jcmdlWEZJNG9VQXhKK3ds?=
 =?utf-8?B?bnBYZ202THozRnFmcWJ3Q3dQWFYvRTJURVZRS0xDYU1TR0VlcE5hVmJFNzU1?=
 =?utf-8?B?Q2x1aFdkRk1XWll3amtlZUFSc1hsL1ZqRFM0ajVaMXpvQWpHdFVKMzM5RGtr?=
 =?utf-8?B?SW9jVU05UGdGVU1TaE03WXBKNGJGbFExODFQc1YvUU5jR0I0WFZLVEVoM1R0?=
 =?utf-8?B?QjQ4cHozNEsrOWxwMis3eDFscVVEckpJOE9uUENrS1czamVndTVWU0dwYVpC?=
 =?utf-8?B?V1oxQmlSenVjM0Vvak1lTVR0VUFyK2ZReDM5Q1QyNDhXYnJLbmRoMmJMakxY?=
 =?utf-8?B?RTArUnkrby9NbmtjYTlyZXVHTWpMbHVJK3BvT3ovcEcwYW8rQ1JWVnBSeE5n?=
 =?utf-8?B?a09YcHRyRFVWUFlxb2VkYmdjWWh5U2lhNGZSaHFDNGMwWEtEbWpCTE9qWGFs?=
 =?utf-8?B?WHBvRFdxOTE5UDV6RzFWMkJyWHErL3lzaExIYnJHMnd5andwdURJT2pyY1pq?=
 =?utf-8?B?c0h2TTZJOTdVM050Z2xHRXpIdWhxT3hLL0lNaXVKZHZ6RzN1V3cwYnh2WTRZ?=
 =?utf-8?B?MVhyUFBtWmxnS3FjeFBnS0N5RVh1b1Vwd2Z2cVJCdXh0amk0dW1CRHpBKzBu?=
 =?utf-8?B?aFRmVEpzZUJSZm5PQkMySFVCL3p5RzhXR3k3UkFXd2FoakVrR3JmaXQ1YTJ1?=
 =?utf-8?B?N2kyeVdiTzZNQVNtRXYyVHI4QTdFZ1JWRThnRXR2Qlh4TFdGNHRVcGZ4REov?=
 =?utf-8?B?WHdVWE5IY0NMemVuMk1zdmMxVE93aEpkaUdMUWl4N3JCOVJPYldCTWFrd2hC?=
 =?utf-8?B?ZTA0RnNrckZtM1hhUU9qdk1LcVh1NmFvaVVEZFRiUFFsUjVsZVE0MFpOb3Jy?=
 =?utf-8?B?YmNVTFdVeUk0L1c5dFVxcndCbzM0cFJZejE1aExIcDFqbzNCbXJRcHBIT2NN?=
 =?utf-8?B?Yi9EWmdlZjA2YWVtb1dRL1hEUHZyQnNJMklzR3Q4aFlGWFZOcVNZZ3h4TnZa?=
 =?utf-8?Q?igUPeEMSCCvFa/nU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <969CAA7CCAA8024DA11DE5ECEAF35066@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f89f551-b555-4362-6685-08da1250c9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 13:25:41.5742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfNr+RLtvZj0zFIKCHfXwhH/j0e43gejuW+YrT0408fFUufgn2bpJAaml17pBC54ZgzcBp50uwlKKdjCRnSh3IJN/79nOiFF5Oo9l/yvYbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2531
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDMuMjAyMiAxNzozNSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgdXNhcnQgbm9kZSBvZiB0aGUgZmxleGNv
bTMgYmxvY2sgaXMgbWlzc2luZyB0aGUgRE1BIGNoYW5uZWxzLiBBZGQNCj4gaXQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KDQpSZXZpZXdl
ZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0K
PiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaSB8IDMgKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvbGFuOTY2eC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+
IGluZGV4IDM5ZGZkYjhlMjllZC4uMjMwZGUzYmRkNWYxIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2
eC5kdHNpDQo+IEBAIC0xNDQsNiArMTQ0LDkgQEAgdXNhcnQzOiBzZXJpYWxAMjAwIHsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05
MjYwLXVzYXJ0IjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgy
MDAgMHgyMDA+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMg
PSA8R0lDX1NQSSA1MSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBkbWFzID0gPCZkbWEwIEFUOTFfWERNQUNfRFRfUEVSSUQoOSk+LA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmRtYTAgQVQ5MV9YRE1BQ19E
VF9QRVJJRCg4KT47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hLW5hbWVz
ID0gInR4IiwgInJ4IjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3Mg
PSA8Jm5pY19jbGs+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrLW5h
bWVzID0gInVzYXJ0IjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhdG1lbCxm
aWZvLXNpemUgPSA8MzI+Ow0KPiAtLQ0KPiAyLjMwLjINCj4gDQoNCg==
