Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D0B49599F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 06:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378582AbiAUFzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 00:55:22 -0500
Received: from mail-co1nam11on2132.outbound.protection.outlook.com ([40.107.220.132]:38080
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230443AbiAUFzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:55:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jp7t4e3QCHHkeoL+g5hNEMII6s4z/CKb3Ei/E3/q35DLw01M/eyeiPJMa9SjpwtT1tIeC97wCS5mfcq15mKbc0fRG71faC8HCgHLPND0dHf0ruoYDp4KiLxgtmgd94+a/WE8xn6B0/U7iM1fJ+74+0e83+tj98K6J7pINeyl+E+v9PGPoXd0bguqZc/QxGpR1qJldKpe/wnS871+dkYoQ+CczbPQ7cfgd+OxDYjk6r0+wBkQA9KRThuzmSpfpFlUE/yNDm2Z9mgPf5bjGPRWuDHpqs4JUDjTmhwt9AUbHN5yDexIFQuSfpdfv5vtbWk04idtPiJRw7BI7GxWO5TdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw0xODGKQwi71hxguZ8s7nBraJw34fMm73cnb+LWdq4=;
 b=gxmtbhiP6fF0cULNumhrnhiEnpGqDr6nrFUc+XKLIbAvB9HV7wIDZ8oF5gdjxhL0tWVoDDckzNvdSuCJh3frTyvtgbPaj2e/hXY+x4hEKzWngh7S7rLK3X0OMiC+FBNpyFkQW8m58uJDTBQpGW3FyfPnM6Db0xGO9IaspdAfJrxNdY8JdZoq8VcpFpCCRRUR4FcIrXNDzK0rM6lGY8kIn58bxUCaaQPP+AzbtCuF3w7BsIk6btfzxTlsv/9Z3xL/KM1aFqLw3m4pxCz2P9aVZuUtehag0VBV2ZXo7aYlwoL1NDXIIsfb2ACceTd95aPoBcOD7MFvfvjSlj/K9bOFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bw0xODGKQwi71hxguZ8s7nBraJw34fMm73cnb+LWdq4=;
 b=bilUgoJsIr/EQP651KPn9dHnGhDqwsxpL7D4VZx/pCAyH0CxUpgXQlDxATsnzmKzLVf1GW9kbR/ucQy4kVdNpKKe0XZnB7Bzd63CoBxc2vgBB29NoJkzP/hg+a5CHZDpMAl4H88jvmZsqVGfVxag+9GNsvPw+lNfwMw6zfYPsSE=
Received: from PH0PR16MB4248.namprd16.prod.outlook.com (2603:10b6:510:4c::16)
 by MW4PR16MB4792.namprd16.prod.outlook.com (2603:10b6:303:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 05:55:19 +0000
Received: from PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::e88f:f199:eed:4645]) by PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::e88f:f199:eed:4645%7]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 05:55:19 +0000
From:   "Chevron Li (WH)" <chevron.li@bayhubtech.com>
To:     "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Shirley Her(SC)" <shirley.her@bayhubtech.com>,
        "Fred Ai(WH)" <fred.ai@bayhubtech.com>,
        "XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Bruce Yang (SH)" <bruce.yang@bayhubtech.com>
Subject: =?gb2312?B?s7e72DogW1BBVENIIDIvM10gbW1jOnNkaGNpLWJheWh1Yjpwcm92aWRlIGEg?=
 =?gb2312?Q?solution_to_improve_sd_host_card_compatibility?=
Thread-Topic: [PATCH 2/3] mmc:sdhci-bayhub:provide a solution to improve sd
 host card compatibility
Thread-Index: AQHYDot4gdmqR9JJjUqMa4Ila1mDgA==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Fri, 21 Jan 2022 05:55:18 +0000
Message-ID: <PH0PR16MB424894690484561834BB0D93EA5B9@PH0PR16MB4248.namprd16.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed200ebe-8d06-4a31-9596-08d9dca29ae0
x-ms-traffictypediagnostic: MW4PR16MB4792:EE_
x-microsoft-antispam-prvs: <MW4PR16MB479283EC060610702A400A28EA5B9@MW4PR16MB4792.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KLOuyyIChu8KAp3EhGlSWGxGLjFBw0Sy0pZi4lYRY33ET3qIRy/hs9D5hOdrMfVJraRYOxKHCfuI7+GmjC7FlxVQfcN956Dz4015+npBx6hqBN8/WHS2AcLDLiduSRao1DOjeHiUH7W0HUqv4vAVxG//gIuDFJdV/RNb077UqCUFwjFE4G7I9CrxzHuWmufadRkxd1Q5mxphGHPLW7zRnzuHm1s2TNKJclQdyhH3YP7FgdWSA2/2jW/XkOm0MQM/lque+NOoqaFz/18lcymInsUJDTix95AndLGG5NU/hfWO/iDs7CZu4nhMi/m7po9wsbjeymNX9FatHP6w+uDLxUBn250Vfn+jspC/ZprIRNaMoCGtHYS7HTKRN7XT1+BGmgLyh4Vc8bPf3n0bZHFb4vBxtViudl7Whz5DDFefxM+aMrnqng+NsdlDZ4fIPpZ/bE+OH3Hjr4kd8zLHUFe0vXE/pa/J7m3pzzOTHMGujjij2kUPOvs+7BKcg+O4oP54HYRQ+10BVCOIqBW/vFrAn+y9R2gc9DKcu2l4FVy1pYHdpuAccijIREBUKEkefmuarYU5lIL+HsNliod2vclwzUmBanGWArLl4sF6+OK4XciSAYxpygMlVnAqhpBeInkqBYnGjJpN1cbmGPm2PKhzQP5VZ/QWlM7v6snDbDyI5RFXDMRv80566TAkGHnxakw26Lb5q7HpcQjGmGJM4E/FeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR16MB4248.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(39830400003)(136003)(366004)(52536014)(38100700002)(7696005)(122000001)(71200400001)(9686003)(316002)(107886003)(6506007)(110136005)(54906003)(86362001)(224303003)(66946007)(76116006)(66446008)(5660300002)(4326008)(66476007)(66556008)(64756008)(508600001)(38070700005)(558084003)(2906002)(55016003)(33656002)(8936002)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RXhKaTVxUWdSdFozZkZwS3FrMU5VNzZWRUJ0V1J2bDR6cFZYL05WM0FOOUI3?=
 =?gb2312?B?WWw2UHZNN0FZaG10WGRremVyZnBJMmNPRU92VTFWbms3aUFIajJ1RERmMGp3?=
 =?gb2312?B?ZlBSbURteS9RQzF4K013SzRXWkZMTVlqcWN6czNoazJrQnpheWxPSFlIMkgy?=
 =?gb2312?B?d1lkZEFkVHI2NHowMlAzSmM2UVNLbTFrd3kyL2xlVkpsZDNtcUJQVGpMNWlF?=
 =?gb2312?B?QUdLaGxZNXdzSVNMYXc2aGV5ZzBncVdpYlE3eGVnbXZzd3VOZlh4NWVYNXV4?=
 =?gb2312?B?MklLaThKckJFdkhKaXZlYnk2UTJKazllZVlTS3V1d0NRajhGd2FHU01VRDk1?=
 =?gb2312?B?L3NxbmY1YTZYQjFoWmxCUjB1QjVGWkZnL1QxVzZ1VVp5RXhWdkN3aHVDVktp?=
 =?gb2312?B?cDBLU2lOUTI5MlJQQk5XUFcxZU5ZUnAveVJ6dXpHS0FZd3h3RUo5dHlGODI1?=
 =?gb2312?B?U1lKdUtoWGpRWkRQUzNkVTlGV1d0djYzZkQ5dzZjcERVYzlvWmc5dlFaaUcw?=
 =?gb2312?B?UEh2cHI3UzAwYXM1THBsOE1nR3NxTFJlWTVyV0h5R0lnRldWQXlnakhZODB3?=
 =?gb2312?B?SFFKRUdpdkxqanlMcHVUcXBXb01lS2VxNUZOSHFGVUlaUHZadVhhT0ZVcUta?=
 =?gb2312?B?QWJTVFpIRjFLNjNhSFJWejN3VFl6RFVLMktINlRONXNkcStHSThDZE9WSjdn?=
 =?gb2312?B?ZDkwMWlvNjBRcGJONkVtUDZUU2xOY24yQWc0dnZOOVFibitZQTFQbjdDbzA3?=
 =?gb2312?B?NUU1TEtZazNKNHVIcy9oZzhDYlRDeGc5anU5clRhWFlhS3ZrUVlJczZqRUlm?=
 =?gb2312?B?TW91NjJlWWNtNkpZU3RUVzdXbExjWG9taFVFYkpGalVQNFZVL29JckUwbjVx?=
 =?gb2312?B?WGFuUzhkcWl6MlE2SjJyUURXZVZ0TGtDeS9uMDVFRUZ2NEJ3YTFPbXVOOEpa?=
 =?gb2312?B?L0hsSWt6bDgwaG44REp1OXVyQjV6TXFoOU9kMm5XaFQvcWU2VkVUd1dMQ3l5?=
 =?gb2312?B?WDFFUUdRa3czRnRBVC9WMWFhZldmUFpsM1J2b1ZlNVpyTVMycS9WTm0zdVdW?=
 =?gb2312?B?aFZiT00xekpnTVVFTEYxS3dISEVCNENHSVlZbWszTWd1enJwOTEwQnFvaEdM?=
 =?gb2312?B?ZUliRVJPa3k5TTA4KyttM2xselJ3cHU1WEJJVGFwcXY5S2ZxYjB2Y3FUYWds?=
 =?gb2312?B?Ym03aDBtSThQWTBmZjZydXVYcHhUNnVNV3VjY1ladStUWlArZ1ozcDZTclJp?=
 =?gb2312?B?aHVxME12Q3kydFJuMUVBSloxcFJEOFVuNU5ucUNZQ3lHYUpoUVVxc2k3eTZx?=
 =?gb2312?B?enlUSU1JaFVTS2pNTXFmUGRYNFdFKy9XSDJNbUNQaGVmN2NhdDZQUC9rZ21r?=
 =?gb2312?B?Yk0rK05oSS9sN0VFRzlHYi9iSnJnUEkzczUxb0FUcmFPSldCK0JvbFh2MDRi?=
 =?gb2312?B?SHpDRGMrblBzWTVCS0xvaDlZRmtpa0I0VjBZdUpUL2paMW1UR0N2K3Q1dWFn?=
 =?gb2312?B?ZnpyMlMyb0ZrUWRRalpMQ3NMcVJTTjNVenprNFF3a0ZOOW1iWVpDZGw2SExC?=
 =?gb2312?B?UERHUEpQR0RXdTNGWEZJWTlFNTBwVXBnd25teHAzaUNzN21VUWt4Zmsya0Jr?=
 =?gb2312?B?ZUlUK2dQWHB4R1F0dm1DN09UY3JvbDdCcjR0TlRqRGE2aUw0MGtVOUdrVGVV?=
 =?gb2312?B?QUhDSWx0U0NuMUh0KzVzM2l0M2Q0Z25NNW5naEVSYjNPZHIxL3lCM25IRG0w?=
 =?gb2312?B?Ui9PMnRSbE1RL3pkc01QTGdYbmFKQXRodmdTM0Y3VkxSVU8yQ1JiNjdwMGt1?=
 =?gb2312?B?VWoxWU13aE1PUWNoWjdRTDhnNjV0MzIvdUdDaEhwUkgzWDE2bi9iOUxRRVIv?=
 =?gb2312?B?cWdhUjV6VTRkMDd0QXJ0bmlYTEhzM2kxYldNano5YWxUdm9NcHYwQmxuMjFt?=
 =?gb2312?B?eTZNMFlyWXZ3SEo4R2FuR3BlSCtOMTBoTzRweEdub3c4RHdpS0hzbWdyTkdw?=
 =?gb2312?B?NThBZ3BNK0grV3d2dmVSaXVmdUtUeGZFdDFobTl0aDQ5RFBHY3hYVGpVUGsw?=
 =?gb2312?B?aE1ocDRFZVJ1bGtOWVZBR29BSm4zVzAySVQ3YWFQdndrblJHcU5sU3Rrby9G?=
 =?gb2312?B?c01vUlNnclNyRVdwd2FvM1FWbTNlc3J2Z0JJSjFxa1lQTUxTNitvejJ0WFFK?=
 =?gb2312?B?WTJnclhSRmRqbGNLdGozVkNaV1Nmbm8wbVFVdEV1bnRQTHcvdHFVRHpzd2pY?=
 =?gb2312?B?bThQN2RJQkZIRU1xSUpMWjBYemtRPT0=?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR16MB4248.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed200ebe-8d06-4a31-9596-08d9dca29ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 05:55:18.8970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8igB0CTAPulAggt5OKvvRXllWkRhkCbpORkIU3MSP1ZvwpO3uIxBm+4IssuztFaZmXOgAv4QbM2LXvKeyWrOEcy3AZ03HcHow7csQ8tc4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR16MB4792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hldnJvbiBMaSAoV0gpIL2rs7e72NPKvP6hsFtQQVRDSCAyLzNdIG1tYzpzZGhjaS1iYXlodWI6
cHJvdmlkZSBhIHNvbHV0aW9uIHRvIGltcHJvdmUgc2QgaG9zdCBjYXJkIGNvbXBhdGliaWxpdHmh
saGj
