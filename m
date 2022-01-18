Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC54492F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349284AbiARUkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:40:11 -0500
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:35690 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344158AbiARUjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:39:54 -0500
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20IBYc7O032144;
        Tue, 18 Jan 2022 15:39:26 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2059.outbound.protection.outlook.com [104.47.61.59])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dnapfs175-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jan 2022 15:39:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKz3GC4GpYe2xtqiBHI+/FvQrRmK0YV2pm9mZjgtfD9GXQPTQH4CnXqNPcaD67Q4Qnmsf2iolvvY6GHSYPzDWKiMY/Ns199vMgsOkF0CGRvNIekdM2x/OvJbprZokTC9rWnW6nRgEVIjYGTo7kW/dXrHGQWamhWgm2JUkBs6wEFrG3OOKnl8SW9BzTYxLkyiZ4rGcD7/geywh3R5rCSSosG3fywW2Bd0gpXumZcyrUpX2Y89AsG8cV1NZVa53eKEN3gspPf8Ceu7dYJfHqxdFMjYFCxnsF/EJF46oGAvjwXZ4YWCI3ND/I+x055vdj8XxXsiFFy7SkPbyZORMqsaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZndoB73Ecm9S0TBduWTH3d2nDwoEr2FdJRTsoRwH3So=;
 b=GQDT61cgCPRZQctGpgQs29La3jsKct2kqphYHAhm7/eOoaQa2O/Z9qlm5IJU0HnnnH7z+zDtJlxnuzDNmRQf1oVoAO7NS6wre+KQCBriTQAZ/RaBp30kB34/jRo15hsu+rw5SZaBYzO7C1wsyhzBk32TZzmuMQxpPC0luzLjtLNrTzi2IO52O483ThnmFr2LnydWgjH2tP1U5ovSimO/Nb+N1vFSRblgT/aOfjyomvcS4KGnHBQiTfypVRVuc/ZLaRxXYrDAY06QdE8fR3JK31FwuZaALjP4oj6krxI4bsmcqPlx6vjb57T0iDdL+XPt7EF/bIeSv11GgGksWubfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZndoB73Ecm9S0TBduWTH3d2nDwoEr2FdJRTsoRwH3So=;
 b=XHXqx2ZBKG+pYy9cuuBDBt/ArWPMdWpkf9DxzLbPCi279f5/Wx8COntesk2LmXWu9S8VumnfWdVFaHCt+AwMpC3SiZj9tTpeMMoEtfJPIJ0NTMZWwnkHgdazuMOGo8s/ElWqScxfPIt+gC3ofNG9gImNoFpRcTgf8DJ1zQGb3Ts=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YQXPR01MB3079.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 20:39:24 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 20:39:24 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "sean.anderson@seco.com" <sean.anderson@seco.com>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bjagadee@codeaurora.org" <bjagadee@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "agross@kernel.org" <agross@kernel.org>
Subject: Re: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from reference
 clock
Thread-Topic: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from
 reference clock
Thread-Index: AQHYCZ/4XkJytJwIJEir+k8QaI40kqxnCOeAgAIr+YCAAAIGAIAAAgEAgAAKzIA=
Date:   Tue, 18 Jan 2022 20:39:24 +0000
Message-ID: <eb3ba4b54d09dbe413907adb86669096110bbd0d.camel@calian.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
         <87iluifxy1.fsf@tarshish>
         <7831a4f7-7c3f-4a2a-be73-38f2c40a123c@synopsys.com>
         <f28052d9-5dea-a05b-8745-09e4d237b539@seco.com>
         <f53ba815-f2ee-a558-73f3-06c5a43f5c5e@synopsys.com>
In-Reply-To: <f53ba815-f2ee-a558-73f3-06c5a43f5c5e@synopsys.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 140443a0-8f93-4ac9-250f-08d9dac29cf8
x-ms-traffictypediagnostic: YQXPR01MB3079:EE_
x-microsoft-antispam-prvs: <YQXPR01MB3079AD33CBFD4CE9A74912C3EC589@YQXPR01MB3079.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNBH3Gv1ubbzZ1P4+j/Joi6pnwOSd0cuTWNU1ZfqQq8TJT0xZThpbJjiP40RTstmxoPtPi8osxr5YOvS7sjtNP/hfMgcFsw/xsmUNV051jxvZ/Oh1NFX7JGCcKwgQJ9SsDS35xwHfJMkS01V3n62SSiYQhZBE6MaDoxfV5ebD2WT5b3IlXHlWLEOX6fLzfTbgFUhaWY6AHAkmg0EBha3hL9aRh1aMzR00WNiHOq+avEiOM+iueYHpDtlyg/07nN0mSNXSFa4sWXRegvgSFcHSEx85bkiqJCRBV+JoCkoSUN0m1vIoKUizQjAOumA+BObIi8HA0eDnpxwLyWdO4kfekG/ZN8GFGLndmr+EqH/fTcY8N1rK6L4LVrRnjpQTcbWO6CT0Sng3SDURD6Y6iu24Pqc1OS4Paj0tTniqTSMfezlZl8CyAtwAO4fJDJPGqCZYz/V74si1rmQlpZ1ASIAod6SDkc2YapwLUu+ZHQcYGJyY8cZSGmffL5hjsHHPL/UkH1ME/DwAwJdeOysOfbcybBp/CxezTtEkN93grxmWvEyiBm8OwNApJXqd8XgrPEm6Nn0qfFJOWzXEiO/ov5KEdMDAIAMiYDOrJEqC3je2UDz5CFgo4DNfjR6/n8MRINaBH9SPUXeECF5wEGCOLDnywnjrdg1tbCbxSxNz/pvdhHLilfvRc1qOKlgz5uEPLre1kweS+Z5NGqpi1lop5fZH95p/3DnMX+hmbzG4ddITLMnHvYxKDmnLeXVm0/kiWuGjHbFwbuvUwqh+pDua2Y5SV1JxN7Zpecod3qBSxFwKV+ZpoRbeglVHOubF/WHCz/zWHRGxyuyvTLsa4kl94Ulyey08JUl8jrlm5dLfgi1ABI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(53546011)(122000001)(4326008)(54906003)(66556008)(110136005)(15974865002)(6506007)(66946007)(6486002)(508600001)(36756003)(7416002)(186003)(86362001)(38100700002)(316002)(8936002)(5660300002)(66446008)(38070700005)(966005)(64756008)(71200400001)(6512007)(76116006)(91956017)(83380400001)(8676002)(2616005)(66476007)(44832011)(2906002)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlN5UHAvNWU0bDJpRFd5UG13ZTNnQTg1ZVMydVlzR0ZtS1ZEL0ZZbTUxOWJh?=
 =?utf-8?B?WWN3NEwyVEhMUUlVL0lZS0FEWllDRnk5UitKbU5WU29nM1JHbXBNSVVCOEZB?=
 =?utf-8?B?UUhOSmZteVFZTnRsT1Nhc1Q1aXAwQ2Q3azl4OVI0TWxwNElSRjhZNmNqZ0V2?=
 =?utf-8?B?eWIwU2VvOW5nQSs2cUFFWmpmdGVRMUZmbDFZU2RLbHBoZVpMZUxpYnF0TFND?=
 =?utf-8?B?Zm1oTFdzUVh4ZFlndm1PbmdHRit0d1JHR1Z3Vi84RHZyQUpTN0psZ1JBendY?=
 =?utf-8?B?MmtocTdMaEE0V2NSS3dWVGZITGU1Mjg2a2hQekdCOHVLc0tKTkthaFl1OVpq?=
 =?utf-8?B?SlBIRlFvQnBoUlpEMHUwcU9zMTQ2ZG9hNTAxV28rU0R0a3dIVEdxT1EzYmNK?=
 =?utf-8?B?N002MlpOdGxtYW1XUE8wSTBYelpDTTczaHE5cXRlSHZrT0dlbjY3aUlFTWVj?=
 =?utf-8?B?dEtjVGYzKyttSkxKNGVCdUFhalMvS010WlRBeVREMmxPRUFubnZUUTg2d0Za?=
 =?utf-8?B?ME1KU3VMRW04dVoraithSFlvS2F1Z091UkFKWlJQVWdaUUNpQm1iUFFNSmp4?=
 =?utf-8?B?cHpCcU83akl0bGF6L0VNTDFrK2FlNms0dm1RdG91MVNqc0VkUUVPQjI0R2tm?=
 =?utf-8?B?N040QzQzVUNCdXdDRzlRbnVKRkhvZGpyNDdlSG1lblNlVzJsMnRzQjFJN3ZT?=
 =?utf-8?B?NkdZK1FicEdIdVFLcHNZY2hqUVdCKzhvcCs4dy9WNlpaTzVHMDlNKzVlOW15?=
 =?utf-8?B?cHFYRWZ2TUt5SVZqL1BRSFg1RW9ZNDJ2T21LQ2Y2ODRyeElDcHVNUDY4a25v?=
 =?utf-8?B?OTIxSzcwQk1HTHIvRHAyZTJaM1N3ank2WVNZYmVyUy9naWJzSW52N3FSd2ZE?=
 =?utf-8?B?V2taUHBYTDk5bUU0MGhQaElLWkhwYnh3UkN4OTVlUFVYOGMyNlVIVklsdDli?=
 =?utf-8?B?d05hRWFwY0RRdjluR0tXOEVwYXZ6S1phTVJvMHBBSGtBbThwWk1QQ2VaL09C?=
 =?utf-8?B?UlJXQm80eDBWS1gyeERSUVdTMXJhRVc4Y1lUQy9DUTNUUmlMWjlBS2ZaMDNU?=
 =?utf-8?B?T3d5clFoVGxhbmFXejIrbFN1UUtrcFR4d0ZTcGlXS0dBc0ljYVlqRjNsbHdx?=
 =?utf-8?B?b2tKV3NSS2wxTTlsc1NQOVNaci95KzYxclpZNjlYOVpsdXEvc3U3Q2lCbGNu?=
 =?utf-8?B?bGh3Sk9iTFJua1lvbmlqOGYxYVNDUFhVT3dyMFg5SVZZZkpFbEJ6NnNqWjlR?=
 =?utf-8?B?T2FjbytieWptcUVVaHVXQXRkMkl2ekp0bG1VOEpqakZldm9zN1NXT1VDMVZi?=
 =?utf-8?B?RjdUVlJPdnlxa3luQVZSekI0WEVjY3Z4bkFRZVJXbC9Gcys5WlFVT3QvZzkx?=
 =?utf-8?B?UG84L3JYcnBGNGdLMGtIV3pxUEZHODFyNDVuMTVYVk0zc2dWV2ZGdEJzSk11?=
 =?utf-8?B?azZGZFUrRmdaYUNyWWZkUFpzUHdxUGxQVmNHSTc0N1FnZmRQdUZDS0V4Y1Mx?=
 =?utf-8?B?LzJIWWpPcmtGYTM4S1NRZzZBOGsyTWV6aXErVjFrWHliZUNwV213elUrcTRL?=
 =?utf-8?B?Q3hWQ1h1T0NUeWI5cVBvSUtxa09NQVNxMGZ2Qk5IczVvZzUyLzNVT05tTXUv?=
 =?utf-8?B?YnZPU2RBcklEekN1NG5mNk9jRmNlaXUwODJmdXUvb3JXTk5IdnZxSC9UbDJC?=
 =?utf-8?B?cnQ3ZUdzcWNhbHlETitpRExZQTBUYTFVK3VSTGZKSHRya1llUURReE82L3E2?=
 =?utf-8?B?ZE1uQkhzM3VKK3kvR3ZvVUNyTVZXZlk3cm91MnI3SVptMWJtUnZJZ0Y1L2Zs?=
 =?utf-8?B?T2NzalFvQnh6Zzl1R2IycUgvQnlhNVNRZU05Mmo0K1IrZzBvM01zSmo3N0ZS?=
 =?utf-8?B?YWpQS3hpQklwN245b2ZwenhkcTc3T1ViQ2FvYUIvUTB1cEVjWWE0RElZblAr?=
 =?utf-8?B?Z0MwajBTZlp4LzFPQWRtbHVKOXBKcmphZUJaK2xKRW5jYjRiNFpodjdCMEtV?=
 =?utf-8?B?Y2UrUFcvOGNMWVZxMVN1QXl2V2RvTlExS3lTNlVQNytJMEVFZW1lTWdITHlR?=
 =?utf-8?B?eU1kbjJvSWZ0djVIZCtLbmlJc05XMVppcXhIaUNCcG52ZmQxaG1UUFNoY1ZF?=
 =?utf-8?B?U1VDQXdIMHB3a21sUVNNcWhVS2VGdGxScnl1ZDNXL254am1RQXhlOXJnYXRM?=
 =?utf-8?B?R2dnYStZQ0djWThJMzcwMGFGTWlDS0JqN3YwcS85TUdyTDRRdHlQZ3ppQmtR?=
 =?utf-8?Q?Kkt/n6awypymb+clCxBS+XAzgVXCjbeTmgsOWlZrZw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D72A7D462014C438A23F1D89C947906@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 140443a0-8f93-4ac9-250f-08d9dac29cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 20:39:24.1029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2VIl9yKga5UYtDj+cFxgsnlre0tL82bEgXdIrSAXA5TR+k3A4O7agjeKlmGH0gWS8myuFJwy/2abLvRhCW/HI3+6I1vkHshzXjSw2XqMwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB3079
X-Proofpoint-GUID: -dGedg0oEBqLg3y3swgHLWdK8rTF6N7N
X-Proofpoint-ORIG-GUID: -dGedg0oEBqLg3y3swgHLWdK8rTF6N7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_05,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTE4IGF0IDIwOjAwICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
IFNlYW4gQW5kZXJzb24gd3JvdGU6DQo+ID4gSGkgVGhpbmgsDQo+ID4gDQo+ID4gT24gMS8xOC8y
MiAyOjQ2IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiBIaSBTZWFuLA0KPiA+ID4gDQo+
ID4gPiBCYXJ1Y2ggU2lhY2ggd3JvdGU6DQo+ID4gPiA+IEhpIFNlYW4sIFRoaW5oLA0KPiA+ID4g
PiANCj4gPiA+ID4gT24gRnJpLCBKYW4gMTQgMjAyMiwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4g
PiA+ID4gPiBUaGlzIGlzIGEgcmV3b3JrIG9mIHBhdGNoZXMgMy01IG9mIFsxXS4gSXQgYXR0ZW1w
dHMgdG8gY29ycmVjdGx5DQo+ID4gPiA+ID4gcHJvZ3JhbQ0KPiA+ID4gPiA+IFJFRkNMS1BFUiBh
bmQgUkVGQ0xLX0ZMQURKIGJhc2VkIG9uIHRoZSByZWZlcmVuY2UgY2xvY2sgZnJlcXVlbmN5Lg0K
PiA+ID4gPiA+IFNpbmNlDQo+ID4gPiA+ID4gd2Ugbm8gbG9uZ2VyIG5lZWQgYSBzcGVjaWFsIHBy
b3BlcnR5IGR1cGxpY2F0aW5nIHRoaXMgY29uZmlndXJhdGlvbiwNCj4gPiA+ID4gPiBzbnBzLHJl
Zi1jbG9jay1wZXJpb2QtbnMgaXMgZGVwcmVjYXRlZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBQ
bGVhc2UgdGVzdCB0aGlzISBQYXRjaGVzIDMvNCBpbiB0aGlzIHNlcmllcyBoYXZlIHRoZSBlZmZl
Y3Qgb2YNCj4gPiA+ID4gPiBwcm9ncmFtbWluZyBSRUZDTEtQRVIgYW5kIFJFRkNMS19GTEFESiBv
biBib2FyZHMgd2hpY2ggYWxyZWFkeQ0KPiA+ID4gPiA+IGNvbmZpZ3VyZQ0KPiA+ID4gPiA+IHRo
ZSAicmVmIiBjbG9jay4gSSBoYXZlIGJ1aWxkIHRlc3RlZCwgYnV0IG5vdCBtdWNoIGVsc2UuDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gWzFdDQo+ID4gPiA+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDIyMDExNDA0NDIzMC4y
Njc3MjgzLTEtcm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNvbS9fXzshIUE0RjJSOUdfcGchTTN6S3hE
WkM5YV9ldHF6WG83R1NFTVRIUldmYzF3Ul84NHd3TTQtZlNoaUEzNUNzR2N4Y1RFZmZIUGJwcmJk
QzRkMlIkDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGluaCwgeW91IHN1Z2dlc3Rl
ZCB0aGUgZGVkaWNhdGVkIERUIHByb3BlcnR5IGZvciB0aGUgcmVmZXJlbmNlIGNsb2NrOg0KPiA+
ID4gPiANCj4gPiA+ID4gIA0KPiA+ID4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2Q1YWNiMTkyLTgwYjktMzZmNy00M2Y1LTgxZjIxYzRl
NmJhMEBzeW5vcHN5cy5jb20vX187ISFBNEYyUjlHX3BnIU0zekt4RFpDOWFfZXRxelhvN0dTRU1U
SFJXZmMxd1JfODR3d000LWZTaGlBMzVDc0djeGNURWZmSFBicHJicE9GbXZYJA0KPiA+ID4gPiAN
Cj4gPiA+ID4gDQo+ID4gPiA+IENhbiB5b3UgY29tbWVudCBvbiB0aGlzIHNlcmllcz8NCj4gPiA+
ID4gDQo+ID4gPiANCj4gPiA+IFVubGVzcyB0aGVyZSdzIGEgZ29vZCB3YXkgdG8gcGFzcyB0aGlz
IGluZm9ybWF0aW9uIGZvciBQQ0kgZGV2aWNlcywgbXkNCj4gPiA+IG9waW5pb24gaGFzbid0IGNo
YW5nZWQuIChCdHcsIEkgZG9uJ3QgdGhpbmsgY3JlYXRpbmcgYSBkdW1teSBjbG9jaw0KPiA+ID4g
cHJvdmlkZXIgYW5kIGl0cyBkdW1teSBvcHMgaXMgYSBnb29kIHNvbHV0aW9uIGFzIHNlZW1zIHRv
IGNvbXBsaWNhdGUgYW5kDQo+ID4gPiBibG9hdCB0aGUgUENJIGdsdWUgZHJpdmVycykuDQo+ID4g
DQo+ID4gQ2FuIHlvdSBleHBsYWluIHlvdXIgc2l0dWF0aW9uIGEgYml0IG1vcmU/IEknbSBub3Qg
c3VyZSBob3cgeW91IGNhbg0KPiA+IGFjY2VzcyBhIGRldmljZSB0cmVlIHByb3BlcnR5IGJ1dCBu
b3QgYWRkIGEgZml4ZWQtcmF0ZSBjbG9jay4NCj4gPiANCj4gPiAtLVNlYW4NCj4gDQo+IEN1cnJl
bnRseSBmb3IgZHdjMyBwY2kgZGV2aWNlcywgd2UgaGF2ZSBnbHVlIGRyaXZlcnMgdGhhdCBjcmVh
dGUgYQ0KPiBwbGF0Zm9ybV9kZXZpY2Ugd2l0aCBzcGVjaWZpYyBwcm9wZXJ0aWVzIHRvIHBhc3Mg
dG8gdGhlIGR3YzMgY29yZQ0KPiBkcml2ZXIuIFdpdGhvdXQgYSByZWYgY2xvY2sgcHJvcGVydHks
IHdlIHdvdWxkIG5lZWQgYW5vdGhlciB3YXkgdG8gcGFzcw0KPiB0aGlzIGluZm9ybWF0aW9uIHRv
IHRoZSBjb3JlIGRyaXZlciBvciBhbm90aGVyIHdheSBmb3IgdGhlIGR3YzMgY29yZQ0KPiBkcml2
ZXIgdG8gY2hlY2sgZm9yIHNwZWNpZmljIHBjaSBkZXZpY2UncyBwcm9wZXJ0aWVzIGFuZCBxdWly
a3MuDQoNCldlJ3ZlIHVzZWQgdGhlIGRldmljZSB0cmVlIHRvIGluc3RhbnRpYXRlL2NvbmZpZ3Vy
ZSBkZXZpY2VzIGluc2lkZSBvZiBhIFBDSQ0KZGV2aWNlLCB0aG91Z2ggb2J2aW91c2x5IHRoYXQg
b25seSB3b3JrcyBvbiBEVC1iYXNlZCBwbGF0Zm9ybXMsIGFuZCBmb3INCmhhcmR3YXJlIHRoYXQn
cyBwYXJ0IG9mIHRoZSBib2FyZCBpdHNlbGYsIG5vdCBhbiBhZGQtaW4gY2FyZC4NCg0KV2UndmUg
YWxzbyB1c2VkIHRoZSBNRkQgaW5mcmFzdHJ1Y3R1cmUgdG8gaW5zdGFudGlhdGUgZGV2aWNlcyBh
bmQgZGV2aWNlDQpwcm9wZXJ0aWVzIGluc2lkZSBhIFBDSSBkZXZpY2Ugb24geDg2LCB3aGljaCBj
YW4gYmUgdXNlZCBpZiB0aGUgZHJpdmVyIHlvdSBhcmUNCmluc3RhbnRpYXRpbmcgdXNlcyB0aGUg
Z2VuZXJpYyBkZXZpY2UgcHJvcGVydHkgYWNjZXNzb3JzIGFuZCBub3QgdGhlIERULQ0Kc3BlY2lm
aWMgb25lcy4gVGhhdCBnZXRzIGEgYml0IGRpcnR5IGhvd2V2ZXIgLSBJIGRvbid0IHRoaW5rIHRo
ZXJlJ3MgYW4gZWFzeQ0Kd2F5IHRvIGNyZWF0ZSBwcm9wZXJ0aWVzIHRoYXQgYXJlIHJlZmVyZW5j
ZXMgdG8gb3RoZXIgbm9kZXMsIG9yIG1vcmUgdGhhbiBhDQpzaW5nbGUgbGV2ZWwgZGVlcCBoZWly
YXJjaHkgb2Ygbm9kZXMuDQoNCkZvciBhIHVzZSBjYXNlIGxpa2UgeW91J3JlIGRlc2NyaWJpbmcs
IGl0IHNvdW5kcyBsaWtlIGl0IHdvdWxkIGJlIGJldHRlciB0bw0KYWJzdHJhY3QgYXdheSBzb21l
IG9mIHRoZSBjb3JlIERXQzMgY29kZSBmcm9tIHJlYWRpbmcgdGhlIHNldHRpbmdzIGZyb20gRFQN
CmRpcmVjdGx5LCBzbyB0aGF0IHRoZSBQQ0kgZGV2aWNlcyBjYW4gaW5zdGFudGlhdGUgaXQgYW5k
IHNldCB0aGUgY29uZmlndXJhdGlvbg0KaG93ZXZlciB0aGV5IHdhbnQsIHdpdGhvdXQgaGF2aW5n
IHRvIHdvcnJ5IGFib3V0IGNyZWF0aW5nIGZha2UgcHJvcGVydGllcyBmb3INCnRoZSBjb3JlIHRv
IHJlYWQuIEkgdGhpbmsgdGhhdCBwYXR0ZXJuIGhhcyBiZWVuIHVzZWQgd2l0aCBzb21lIG90aGVy
IGRyaXZlcnMNCnN1Y2ggYXMgQUhDST8NCg0KPiANCj4gQlIsDQo+IFRoaW5oDQotLSANClJvYmVy
dCBIYW5jb2NrDQpTZW5pb3IgSGFyZHdhcmUgRGVzaWduZXIsIENhbGlhbiBBZHZhbmNlZCBUZWNo
bm9sb2dpZXMNCnd3dy5jYWxpYW4uY29tDQo=
