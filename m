Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FFD4F948C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiDHLzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiDHLzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:55:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE9BEB0B8;
        Fri,  8 Apr 2022 04:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649418773; x=1680954773;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jbrmaJXrAfvUjj/ODdWMbIi2IEgrd/is08i5vCvWqmc=;
  b=jwNNlvAutcWePa3aCs1vaTrqaF99c4+oa9uymWl3auKl5PVmMSBJdIJZ
   YESh9DgmPHCqxMvz5pFaZL7+KlIOlx7i8EIEI5TglKAd3a98n0aAHdRE7
   WCW/czMZQxUDQn9eNE0NzhBqvO6QVnVjbusoQhsm2kVudCP5atFodj1gF
   mjjXOSee3tYZL5wGaBBsUnAtAcxPuleUDtkdecFqYkbQpKEPPrU53ps0F
   gVcIPbOt/MEDPlxux14W3QmuR3htFj39dGUqWAz+VnzD0Ts9+TYZBTUIA
   cyCs8O2yBMYDaFJFXEAWIJnlnAHA0DOz5L+OPFNamqrXbExl8ZCJqj9OI
   w==;
X-IronPort-AV: E=Sophos;i="5.90,244,1643698800"; 
   d="scan'208";a="159427027"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Apr 2022 04:52:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Apr 2022 04:52:50 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 8 Apr 2022 04:52:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I40wzvm5C0K0MWqidhqusVOOIqhC7sa1pj8zRH67YoEMaE0fFomasbRfqK4+uiGk18wf6mXDI+62SSF2Ac9t2rxWhZlJh2nsQpAnObSFSXBxNrWO4iclXmUT5eCZUjXbLv637hlheoVFvipUu01upy+xJqp3LHNViSL5w4P7A965ZixeMqQzO3F32/morb+AgLu1vRSwgoHi6ifXQz0/Ex5V17ZguQXhVQuk4VYbjZZ563BvWig1ou96qOwSQBzCBE0Y3LzQSsdDF5gCJ47WyIa0VnDhWeWGxERsQ5IbTqwouyQxRflIb2fX1LgR3FRcvhx9Y1JFksKKQGGQYh+GfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbrmaJXrAfvUjj/ODdWMbIi2IEgrd/is08i5vCvWqmc=;
 b=K8QLwm5rbc+qMWVgV1t9YJU6zVrfZkLk6rsmvpkSADSyK4Cr5iMsU1iV/tz7dumka+83KWPBVk4jpIu5iUKcr+RPTGQ9Nj3shTzg40Mt/R00fp24B+i/rXRoa6MAIy8X33l5RKyqCtnN0pwYOecQ5K9rqGtjGuqqv2l/B8a1lj1mow0AAQizXXPcVK+9rd2ROBIT93S4o2x3mw5jkJcuWXG/xlGczBbsCKTSHjIHPerTqmutDgsK70WyLe1Pg87zZMtsVkx4uAb3Pb5ftCAaR+oSlP8yUlBlaZ3v7BIqVcN1r4tw5vmwvFsJysGBgdb0B3JNtTkVcbfKqEzZ/NCrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbrmaJXrAfvUjj/ODdWMbIi2IEgrd/is08i5vCvWqmc=;
 b=m2/MCa9Wz8xkF/n0ib9MSJq9OC8tMPsSoqhV2YDILlV12DPq2hzWeVtSUB68w5Nyg6OkNYTXRmu0cgagRNrryA8uMNIA9KjPVmyqYl6pZYwYnn34RUJ7X80YqH4jKpc9/lbZPxWmkKoovqKSVVTwEZG22uBPhSJVmVMnpU6KbFc=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by PH0PR11MB5950.namprd11.prod.outlook.com (2603:10b6:510:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 11:52:36 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::f532:35a1:ab60:7880]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::f532:35a1:ab60:7880%9]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 11:52:36 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <Tudor.Ambarus@microchip.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH] spi: atmel,quadspi: Define lan966x QSPI
Thread-Topic: [PATCH] spi: atmel,quadspi: Define lan966x QSPI
Thread-Index: AQHYSm3jk0K5BssK3U2dpWPfF7LRFazkaHiAgAF/sUA=
Date:   Fri, 8 Apr 2022 11:52:36 +0000
Message-ID: <CO1PR11MB48654DEFB31E8F8AB00C180292E99@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220407105420.10765-1-kavyasree.kotagiri@microchip.com>
 <0d1ad948-278d-4cad-9a20-99cf4fa984b9@microchip.com>
In-Reply-To: <0d1ad948-278d-4cad-9a20-99cf4fa984b9@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1550b3a5-cba2-494c-fcce-08da19564631
x-ms-traffictypediagnostic: PH0PR11MB5950:EE_
x-microsoft-antispam-prvs: <PH0PR11MB5950DB0860E56A8B5AE0224992E99@PH0PR11MB5950.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Do1srb2T1Dgj1rXpKmOtNHDFrlBdWsHswrh6v6AD85BD9Nf9+HurOkJsH/MonTw+FFMFkwyv6o1R6Gn/HDWDn15muS5ky5amsImqosTYCjv0xtFzYYP//Lx8Yyoiyd4K89tP/WjovwyLBEZoiuXUNoJJze+DNzbPY3HbyPb4yItPtQuzujASJh0P/T71HztpXiI7gCR/lco0c9vOUtJmWUsju9UjPJFpiH0Oy0uCR6MsKEdpLsxXddP/4zyyy5qTFCsdmMv3nG473dMV+31pfFVNF7gh1d1ibaWFMj44VL8nQA6Hp7FDXsJU/XomZ2JVnFlgBHQrGQ7MCCHVKtOe6ha3Gm0FS0Z3fO5QhT4kyLIzMlaZyeGE/jUBH6Jyiz4qVX3dRm3mFwssnzFcAUX/cfoM4elwEFWR8+FVlaMUdDOBVRoLETaSSQ5NWBfi0UamEUfMJNgXNh3Ayuxw4oJJIb1meowMrjs29zR5lovFy2IORTgdoPCm+FsQp0wHIK0rorH4tK+MGfCjr26ThcKaaMn2j4AjYMbzZtnWafNdWsvW1gJsK8YYcVfsHKFPbiGDDk8K6ZrhpYswsel4dMVDYmPVxR+j+mNVl+Tm0KYsA24WC37wMCxmRPeMN0cTEmQ1HUYB0WUf3zIINoa0P6dQHvkcJNoL+ewsnJI82wZPlg9i+H+UuE5C6xzgqm6CJoW6F+td52574khM08JgkM5DLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(71200400001)(38070700005)(122000001)(4326008)(316002)(55016003)(5660300002)(2906002)(52536014)(33656002)(86362001)(9686003)(66476007)(64756008)(110136005)(76116006)(107886003)(66446008)(66556008)(54906003)(7696005)(6506007)(38100700002)(26005)(186003)(83380400001)(508600001)(66946007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0d2ZzNsQXJCN2N6MnBkeDFseUFqdTJ2WHBhNHg5aWRia0lkRmVZQUMyTGE1?=
 =?utf-8?B?QlhtQTVRRHpxWTB4bUN6M29DMkdRSThyRWFxbkxJc1N2U0xnTlQ5K21VQndD?=
 =?utf-8?B?ODRsWm81Zk5HaXhDREZvOVlEQXYvd3JZcjNpTEgwQnBZNjdNMU9PaC9qcmxp?=
 =?utf-8?B?SS9mL3hlMmdNQ3BISHFxLzh2WERQS3diaWZCME5nYzMzSWwyREpuekgvTjRh?=
 =?utf-8?B?SUZvMmNJemFsL1UrYWlkLzlPRjVFV1NWSllJTHFIaDk0Nk5nUXBOOFhSN0t0?=
 =?utf-8?B?RFg1WTg0V1VkbDg4L0RmNzIybnRjT3pWTk9UWjVVQ1o4U0lQZEVBZ2R5eEg1?=
 =?utf-8?B?NDlwbm5wZkl3cGMyYWFMQlB5aXhLdVdUS2ZTVXJpTUd1UXlJOHVQS0hCUW40?=
 =?utf-8?B?ZGVnbGJqREhYalVlZkRWZC9ad0I0MGorK2hzZmc0ZEtCZ1g4QldYTEdmMzJT?=
 =?utf-8?B?NmVKRzNrMGdmQVJiV2M3MGNOaUczYlRyZEZYQVEvOEVqWFpESU5YVHg4ZUQ4?=
 =?utf-8?B?bGpSYklHZWhralZGWHNrK2MzTzNhWXFSbHBaUSt3YjRzR0RIOGtxK1NyVllm?=
 =?utf-8?B?bFlFaThZSHlqZUMyZ0JRMHNRUm5IdzNvK3h0NDJKTnNUcW1EUTNjd0NVbmJy?=
 =?utf-8?B?aWV1T056S3RzODBJaEZCN1lhZEhLOGdLWS9yOW1xTU82d09URC9GTWJ6SzNV?=
 =?utf-8?B?c1JzRDRMTzNSZXovYnFtRURJZXZ4VFVaTFFrQWtXb2d1NkdkT2VYNmFVVHVx?=
 =?utf-8?B?MEFhTStua1lna3FSR3VJNFBTcVBjVzVOeU1ZdlVRVHVmTHdpVERZWndNaUo2?=
 =?utf-8?B?N3dwV0tSTGhUT1d5L1BIWjhFL1VFYUw4ejI2OFUzcE80STZLV0lGRDRnUVAz?=
 =?utf-8?B?K01XL1lUOFBvcWlUR3ErYUhYTHhleGx2aG9McUFHbHVmczVOalhPMjRQM1ZC?=
 =?utf-8?B?MTJGUVpwMC9HUkxpSlZNNWtzWUdaclh6dys1bS9ERkRYNGZsYXFYaVhMNC9r?=
 =?utf-8?B?dE9LKzhTZWg4ZGRmMEdqTmRLYnRRdVkvc2lPTjFqUi90enc2dUhIdEhoR0kx?=
 =?utf-8?B?eENuMDQvUTdVVTRiSnBicDkxUGhaSnJaTkVPQlByaDJ5cTlCSFN4dU5xWmhG?=
 =?utf-8?B?UWNHME1OdmgvUWdhUXNYV045bERFcTB3WlNYLzdhWm1YKzlQTHg2ZG9EMGlR?=
 =?utf-8?B?ZE5LdHhJbFZnZ0FxNFRDTG9OQkxLNHFRSkx2NUFwcFZVL0xIZVBEeXlZQlp6?=
 =?utf-8?B?STk3a05rR3RUc240ZUQwQ2FoSi9CanloSHp1ZFY3VHpRRWJLNklBb3NXbzJv?=
 =?utf-8?B?UUs3NHFxVWprZW1VL01UZ2RZQTdybXNwNFRhK2NzS3pUSDFGQ3h1UXRwVHFZ?=
 =?utf-8?B?UzBiaW96emVhaXZWWTZmU2ptQjg5ZlRVSGRNUS9wNmhENStUK1JNMjhxYTBy?=
 =?utf-8?B?Z2EyWjFYSEVZaFVadW1RalE0RWdBK1VPMERRZ3lxL3l2ZHplVUlVb0tEL2J5?=
 =?utf-8?B?bFN4NTlmeWdDK1VxdHZGMFo3Mm52SVRkTVM4N29JOVdCVUd2ZDYraWFueHFZ?=
 =?utf-8?B?b1hCM3B6cTdRcUVYNkpUVlMva2FZVDExY1BGVTVldnQ1aDlNck5pbnU2U2Vq?=
 =?utf-8?B?UEZEcUR3aWZFazJhdjZxcnkxczRTN2ZkbzNvdkVVdTZ3T2NHbmgvMllkRms1?=
 =?utf-8?B?djJqVCswMHpZZEcvSG1XUnRGTTNwa0QxeitMM01za2s4UEdqajFwVzZpSjFT?=
 =?utf-8?B?RlBrVjJqSUxxREU4OVZHZVRFR21sM0s1QzZEeFQ2NWhJNEpjVHVyMmoxK1B3?=
 =?utf-8?B?RlJVeGY0ajNjcFVaZUJUZldWTzFUbGxHSTY0Zi9BU1k3RmgxdmVPSEU3cDhV?=
 =?utf-8?B?WmF2YldBaGhwZ1c5ZHZhN0hyTXdBVmRnSEJMVnpRREFuM3dib3FiQk5lLzRZ?=
 =?utf-8?B?ekxGZkdPT0ZNdHZtaFBPUWpYaFpSTUdvbnFhRlhqQU9UdktlYjZEMUFCMUNm?=
 =?utf-8?B?SWdWTGlyUE9VNS9WSHpvR2JXY3JtNTZaeTRicG02R1V3cnBnVGppWUI2eEt3?=
 =?utf-8?B?Vm9JQlYzZDNESFVsTFgrT1diZHFYY0JjODI5QkdxMlVDNHZFSTBZT0NscVJR?=
 =?utf-8?B?eGxxcC92QlpPWkZ5TGZGaGIzcW0rRDlQNXhRWEZxUGNVRmZ0NnBpYlVjRzBR?=
 =?utf-8?B?aGpMUzZQK0dXK0dHU0xiWXBnRzhVclF5L2hvbjBTUTdJY04zbTFpQkcvdGJX?=
 =?utf-8?B?YUE1NENmNThUcElHZ1h1TG5PL3R1eHNBUk4rQXBxSFZ4RFlsU3ZabWlBMkw2?=
 =?utf-8?B?ZFJlVFdZQXNlb3I5RjlzdmticDlRZHNYMnFlbitXaWlnVHpuRTBYZHk2NGFO?=
 =?utf-8?Q?jfb/vTHwRbc1MJwM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1550b3a5-cba2-494c-fcce-08da19564631
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 11:52:36.0502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1BuOEl7kK3fF1otYvPO1vBvueL8z2ijyyVXC22R7TpGo49JPaqx1KSAlZF4oOMzKZxUC9s4hIydQum4eS1HCfuEiK04Uvus3UALIU7tiWFhE7JiDoc1OptUDafYyi5f8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5950
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gTEFOOTY2eCBTb0Mgc3VwcG9ydHMgMyBRU1BJIGNvbnRyb2xsZXJzLiBFYWNoIG9mIHRo
ZW0gc3VwcG9ydA0KPiA+IGRhdGEgYW5kIGNsb2NrIGZyZXF1ZW5jeSB1cHRvIDEwME1oeiBERFIg
YW5kIFFVQUQgcHJvdG9jb2wuDQo+IA0KPiBIb3cgaXMgdGhpcyBJUCBkaWZmZXJlbnQgdGhhbiBt
aWNyb2NoaXAsc2FtYTdnNS1xc3BpPyBEb2VzIHRoaXMgc3BlZWQNCj4gbGltaXRhdGlvbiBjb21l
IGZyb20gdGhlIElQIGl0c2VsZiBvciBmcm9tIHRoZSBib2FyZCB0aGF0IHlvdSdyZSB1c2luZz8N
Cj4gDQo+IE5laXRoZXIgb2YgdGhlc2UgaW5zdGFuY2VzIHN1cHBvcnQgb2N0YWwgbW9kZT8NCj4g
DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuIEFsbCB0aGUgdGhyZWUgaW5zdGFuY2VzIHN1cHBv
cnQgb25seSBRVUFEIHByb3RvY29sLiANCllvdSBhcmUgY29ycmVjdC4gVGhlcmUgaXMgbm8gZGlm
ZmVyZW5jZSBmcm9tIHNhbWE3ZzUtcXNwaS4gUGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoLiBJIHdp
bGwgc2VuZCBuZXh0IHZlcnNpb24gb2YgZHQgcGF0Y2hlcyB3aGVyZSBJIHdpbGwgdXNlICJtaWNy
b2NoaXAsc2FtYTdnNS1xc3BpIiBmb3IgYWxsIG15IHFzcGkgbm9kZXMuDQoNCj4gQ2hlZXJzLA0K
PiB0YQ0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEthdnlhc3JlZSBLb3RhZ2lyaSA8a2F2
eWFzcmVlLmtvdGFnaXJpQG1pY3JvY2hpcC5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWwscXVhZHNwaS55YW1sIHwgMSArDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWwscXVhZHNwaS55YW1sDQo+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbCxxdWFkc3BpLnlh
bWwNCj4gPiBpbmRleCAxZDQ5M2FkZDQwNTMuLjEwMGQ2ZTdmMjc0OCAxMDA2NDQNCj4gPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2F0bWVsLHF1YWRzcGkueWFt
bA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWws
cXVhZHNwaS55YW1sDQo+ID4gQEAgLTE5LDYgKzE5LDcgQEAgcHJvcGVydGllczoNCj4gPiAgICAg
ICAgLSBtaWNyb2NoaXAsc2FtOXg2MC1xc3BpDQo+ID4gICAgICAgIC0gbWljcm9jaGlwLHNhbWE3
ZzUtcXNwaQ0KPiA+ICAgICAgICAtIG1pY3JvY2hpcCxzYW1hN2c1LW9zcGkNCj4gPiArICAgICAg
LSBtaWNyb2NoaXAsbGFuOTY2eC1xc3BpDQo+ID4NCj4gPiAgICByZWc6DQo+ID4gICAgICBpdGVt
czoNCg0K
