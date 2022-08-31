Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F3D5A7CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiHaMFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiHaME7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:04:59 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2095.outbound.protection.outlook.com [40.107.96.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F3CCE3C;
        Wed, 31 Aug 2022 05:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFkn9H6ADr1fOJPUHYsGMWJt7ae2l4W2Ijxnh89LZ+OPgwr+1tGhs8Bm5z/5My2FIEpx1n6vPy/p5BzsuWORmderBUfdDs+XreFo1kb9XAtDxlYMABhsecfLh6frwNT8kPzF1w/nkr7lva4Tjf6V4V58sXWU0K2RO0R/Nw+vtQmBULZKXsz6lcW5EsGp5YZZWbf/GDsJodzeQ8Oj7aMXDNGexoJo+ydqn6v7MM5AtB7QX41EaCHV+13+Gcd13p84SqLkhWDaU4g83Aqca0N6ZOWk4d7sLFST0IYZOTG+J6keXvrC6GYFHThy+v0CYyvFaSA4BMgUVrPJsiZGVeZilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilXQhsFWyvXfVQTjY4wlOulq/VU4gxdZkQ0jwinT1jc=;
 b=h5AHIGPsWJp7ASIiyWaO8l9XsM7/H+I60HAPHq4EV83wEaG3TWh1+YXuvTeILvgLra2nsvXH2lRO/NRlYlStoKykEPAvK5wCe4Ec6aCDexu/SS8TnZcxxVx7bB0D3wePIK98e9junw5yNs4BZBhQDJVaZ0N1YXhzCpr+RSEa0R0/QjSD/RGTbXgPm1osxYirjCRSY2UrSKzhJB2wDHPDTbek6fdUs3Y4Lv6XQzP72a1KJHA2akuh3Vnu6VcYL9fGZGduS6KdM9y1vck8856zco08HEtCpXcCWkd+1fywqy/Q9KaE4nBVjqnlG2oN8EDeOCmC0vvoEYpVywplBslZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilXQhsFWyvXfVQTjY4wlOulq/VU4gxdZkQ0jwinT1jc=;
 b=ol1sgJfBhRpBIDjpijr1z7t24v6SVSgMMcoM+3nC/pKmFT2+6BL+6n2fBx96t2NnxgjLqrOD7+a4z6DxyGPbUrg/Je+lQNX5Uk2MGJv3P/1PuUaPy/GRhKGT7o7DShPb1gmswO5UwNZn/k0yaoFILnJt+XxI69H4V6zLhkFiUmA=
Received: from PH0PR16MB4248.namprd16.prod.outlook.com (2603:10b6:510:4c::16)
 by BL0PR16MB2340.namprd16.prod.outlook.com (2603:10b6:207:40::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 12:04:49 +0000
Received: from PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::b8c4:8853:2bc4:dc70]) by PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::b8c4:8853:2bc4:dc70%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 12:04:49 +0000
From:   "Chevron Li (WH)" <chevron.li@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Charl Liu (WH)" <charl.liu@bayhubtech.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Thomas Hu(WH)" <thomas.hu@bayhubtech.com>,
        "XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shirley Her(SC)" <shirley.her@bayhubtech.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggVjEgMS8xXSBtbWM6c2RoY2k6Rml4IHRoZSBTRCB0?=
 =?utf-8?B?dW5pbmcgQ01EIHBhcmFtZXRlciBpc3N1ZSB0aGF0IHRoZSBTREhDSV9UUkFO?=
 =?utf-8?B?U0ZFUl9NT0RFIGlzIGNsZWFyZWQgZnJvbSByZWFkIGRpcmVjdGlvbiB0byB3?=
 =?utf-8?Q?rite_direction_incorrectly?=
Thread-Topic: [PATCH V1 1/1] mmc:sdhci:Fix the SD tuning CMD parameter issue
 that the SDHCI_TRANSFER_MODE is cleared from read direction to write
 direction incorrectly
Thread-Index: AQHYnDWHPDtKQXUUwECGoxlnk+IE7a2NI6IAgDjaI1A=
Date:   Wed, 31 Aug 2022 12:04:49 +0000
Message-ID: <PH0PR16MB4248A089CB5FF2BEC527742FEA789@PH0PR16MB4248.namprd16.prod.outlook.com>
References: <20220720123737.117-1-charl.liu@bayhubtech.com>
 <69334100-1ba7-50e1-5d0e-83081c2241d7@intel.com>
In-Reply-To: <69334100-1ba7-50e1-5d0e-83081c2241d7@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7bb6be7-7d9e-45bf-76f4-08da8b49014c
x-ms-traffictypediagnostic: BL0PR16MB2340:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xiXPfyrGftOAQJtcNRxfaKHYSfzdH0RT3YQYycel6Yo2gc6H+deAJ8jNidARqAqRdfu2n5trXR0KC7JRQPfSneZx8l013jw5g52CdMyGlqCPGkDZvJTmavNSGxewwnhGJGi5++kFoYFOn0VZjD4PfNfdh77R9w3cQ95olunDgUsmhO7MKS/TuUdvsUb4CCFQDj7C5GWw/CxCGbzDAdua3b71ZSLiSFHKrnsWXGzQOTm+UkSmaPtF/Iosmv7XPf/Im21802UqaFL3t5+xJ/jZsWND4d5PyY0fbvaxGb+CwmMY9vuNHpZeYTsAfCngUvwsMk5HrWhh0p1nQPp/o9FT/yxT4VHk7MBmBmPIzEgebxJhMWe261Ozak2iZCFAqjkFeRzhKy1+LCOcElT7A7+eVd735zeTQ5F97luu4E+g0y+8yF3INpVQRLXt8OoNhEtT7B241NJb6jEIAQAvAM045AsrmWDnMaHiMY1xURbUCjoxSGQQXpHkJwetOyNHkfC9+eespwUtf96ZQ5B585K+c/miGuOZ4M0P0ivDMp5fEgFJ0wsGWyLE/hylzc3BXRwx/m+UmSRX1mgDGWjM0kwCh72d2YpbrZnrJI4wTLw5DwyakLMwI0o9x0ofb0Tk5Q84EgTSXivP4QmJClskIFKzAfIXSmL2if8ddVuyzpJ3OCaaHsXX7TyW1RRevQz7zyy1SbMlbIYfb1xCV6/lIHCkPorZWEDDsOjxvDy6llyjCMs0mvER7AerxtqrtVTsHMKKFwGyf3Jr0fPXTF4rh5PNiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR16MB4248.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(366004)(396003)(376002)(136003)(346002)(478600001)(2906002)(107886003)(66946007)(66476007)(64756008)(66556008)(6506007)(7696005)(52536014)(33656002)(41300700001)(8936002)(4326008)(76116006)(186003)(5660300002)(55016003)(83380400001)(66446008)(86362001)(53546011)(26005)(122000001)(9686003)(38100700002)(54906003)(71200400001)(316002)(38070700005)(224303003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0xvOWFrRTBpK3g3RW9XVm1LWHB5NTlqTVFMa2xjclp1TGNyTVE3SzdDUGpJ?=
 =?utf-8?B?V3QzOVI3VW1DVlJvekhjSEpMQ3Z3R0M1citKczhveXdWeThGZVZxZ1VRUU1W?=
 =?utf-8?B?N2U2eFpyN2tVRVU2dDgvNVE5Z2VmZ0ZDMlFaUzl4bzJPenAxS2xBMzVTMmF0?=
 =?utf-8?B?bm5HOTdGMmxqcFdCbk9za3Vncm4yTWhyZnV1clJ2eWNQMmZadFRCS3RXQU44?=
 =?utf-8?B?ZWlITHFxM2xDTm1NelB4VmlBNm5VdmxKV3EyaFVYbFVQYUJlbDhhajRkd0o1?=
 =?utf-8?B?aFUvM2pEcE1jV3dXM01ucGFTY1dJWjlGVnVhWjR4dkxPNUM2NGoxaGdsZEgr?=
 =?utf-8?B?TEp5WjRkZU5RQWZpY3JtaHUzeWlERUdkWXhOOTdQbzVERnNHOUJIWkJFbW82?=
 =?utf-8?B?ZG9qWndBMStnajlURTdwQXdvOFVTWnF1b3d0Z2ViTTg1N0xaMjlzWExHUnBY?=
 =?utf-8?B?a0txRHlhemhCM0RaZm9lZTFnOEN3RzZoYS9oa05nN3JKdC9ZVDJBeEZpakNR?=
 =?utf-8?B?QlBWZklpaFN1MXNtLzdJMjFweGRvRXF6QmxBbHpnRVMvV2tFbWo5U21IUHFC?=
 =?utf-8?B?WTV3a0lzMDArY3l1ZkRPaWZFTk1CdGRSZG9xdXBmQnRNWEVtNDlGVXQ2UUd5?=
 =?utf-8?B?ZmtRS1RwZWMzdGFhMGRwTzFha3dObFd3QjMxdytQeUZVMTkzUDZ3UEtyaVBW?=
 =?utf-8?B?NFNZcE5ucVNUMkxzN1R1RXhYTlF2M2VkYVRjd2tQcmtCb0lZUDBDZjlaRCt2?=
 =?utf-8?B?WDdMVWZNd1VaZzV2NWs2eE1lb0xJMGtIWjMvOEQwWFdmOFF2aHVzZTNYajAr?=
 =?utf-8?B?aWtQcUMvUzRWaERWYlU3VWVSWmpqQzRxUWRiVi9RVk84S2IvS3FscGlTbzQw?=
 =?utf-8?B?bStwWnhsMlVhQUZVOHJHL2ZWaXhCV25NNWg1VlVWV05hNzJFK0t6WWNMQzFH?=
 =?utf-8?B?ektzWUgvMmk1Y0xHRWdqSm9XcC9jbWRFanpzT2gxSmRkZndkUDVRcXJ2T1RY?=
 =?utf-8?B?TVpwUTRZR09WUUdnajV6SmI5VU83TmNaS3FjQnh5Tm1yMUlFNzRxTGlqd1Rl?=
 =?utf-8?B?dDBEUnl2amdDdFJ2YWZEdmFEVDVKajliWGhJdGZzRnFjcmlnbTNOaDd2ekNi?=
 =?utf-8?B?TVJuSzhRS2RSelAxWTRvQW9OMURuVFJ3ZnJOVjVMN0UwZExEWU1oYmFhNFpG?=
 =?utf-8?B?K25xdlpCSXNPSWFWRVd1SnNDUU54cEZldGVEUDBQUWN6UWNHZXRzT2pNT0w2?=
 =?utf-8?B?UmUxUlA0UWd0WUhxN1hiUzNhQ0tGdzFlUEwyRTQxdUZBWDdNdGZNYW9lbStB?=
 =?utf-8?B?WTJaTEFzdUpQNmNCajdlMFVoTkVDZUtNUzAzSlMweHlRWTFycGdZSkNFbWNT?=
 =?utf-8?B?MzRUeUZuVG0xTFFtWTlWajdncjlKQlVMdmFIZmRLTFNyMFRNNGM0c3A3Qi9I?=
 =?utf-8?B?WmV0REtKSkxjYTVRWDkvMDZabjhQZnJsYjltZFRnNk11Q0hZS1ZOcjdIY1FQ?=
 =?utf-8?B?UTBTNWpacFA0N3RCVlpZbE1xaHU3VWY1cGJBY0ZLcnBlM2Y3cm1SKzdhc09R?=
 =?utf-8?B?Q1YwTmtRUUZ4NlhmY2VaaXJ0TmdTTFVZOXFUTWRKLzFaOWY0VEtwTXVLNGsr?=
 =?utf-8?B?SEFNUDk1ZWJuNFZYdEsrZ2kxeWRjcVVBbGlwdDNaUUlLajNZTGxML25XNkJE?=
 =?utf-8?B?OW12cFNzUXJORTZ6Vm10SVRNQ05hbm5xYWh4K0RLK210RkVCWVUxZnQxUHl3?=
 =?utf-8?B?c0J3ZXlIZEtDdjl3YnJ0SllOTWVGeVpkNmRRNDJqVUtPOWZRN2VHYit1VjBw?=
 =?utf-8?B?aDFkZ3FraURFUERydWNpbytibHZJcXoxTjd3QW0zSUU1dHFaTDBraXd5SkYr?=
 =?utf-8?B?ajJ2U1Juem51aGtDa05XdDhXbi8vMC95czhuODUrajllVHk2dEc1VzNGdHYy?=
 =?utf-8?B?SXhEMGt1VTVlY0JmSFNPR3VPcnFjcFJzcTNtYUxUNzdYUmJzU0JlSXJPRWJP?=
 =?utf-8?B?VmUwdERlVUVrQndieGFXK1pISm0wM1p0SlhYU0FhazlWVVB1T0JzKzlPMng0?=
 =?utf-8?B?ODM1MFV0NTVscHpCUzhsL1FtZ2FKb3BRY3RIbkszZCtGQUM2YmM4Ry9LUWdo?=
 =?utf-8?Q?U9dGrdd9ToLdGLo3bx8blitLk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR16MB4248.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bb6be7-7d9e-45bf-76f4-08da8b49014c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 12:04:49.6696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QgFJgQ5Fdd3wsvYtSvwB4bA5OJwRQMfFRgaplNgWC+CAX5mSA7LzPH4ENKDAmdyR6Vl7A/50Z3AkuJ/3iGaHA8CexUXG0x3qluZpJwxALoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR16MB2340
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFkcmlhbiwNCg0KU29ycnkgcmVzcG9uc2UgeW91IHNvIGxhdGUuDQoNCkRvZXMgeW91ciBj
b21tZW50ICJtbWNfb3BfdHVuaW5nKCkgY291bGQgYmUgdXNlZCBoZXJlIiBtZWFucyB0aGF0IHdl
IHNob3VsZCB1c2UgbW1jX3NlbmRfdHVuaW5nKCkgaW5zdGVhZCBvZiBzZGhjaV9zZW5kX3R1bmlu
Zz8NCg0KSWYgeWVzLCBJIHRoaW5rIHdlIG5lZWQgYWRkIGJlbG93IHBhdGNoIGNvbW1pdCBieSBD
aGFybCBMaXUgZm9yIHRob3NlIHJlYXNvbnM6DQoxLkJheWh1YiBob3N0IHR1bmluZyBjb21tYW5k
IGRvZXMgbm90IGhhdmUgYSBkYXRhIHBheWxvYWQgYW5kIG91ciBoYXJkd2FyZSBkb2VzIGl0IGF1
dG9tYXRpY2FsbHksIHNvIG1tY19zZW5kX3R1bmluZygpIHdpbGwgcmV0dXJuIC1FSU8uDQoyLkJh
eWh1YiBob3N0IGNhbiBiZSB1c2VkIGZvciBib3RoIFNEIGFuZCBlTU1DIGNhcmRzLg0KMy5Cb3Ro
IE1NQ19TRU5EX1RVTklOR19CTE9DSyBhbmQgTU1DX1NFTkRfVFVOSU5HX0JMT0NLX0hTMjAwIGFy
ZSB0dW5pbmcgY29tbWFuZCBvcGNvZGUsIG1heWJlIHRoZSBzYW1lIGxvZ2ljYWwgYXQgaGVyZSBp
cyBiZXR0ZXI/IA0KDQpCUiwNCkNoZXZyb24NCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R
5Lu25Lq6OiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4gDQrlj5HpgIHm
l7bpl7Q6IFN1bmRheSwgSnVseSAyNCwgMjAyMiAxNToyMg0K5pS25Lu25Lq6OiBDaGFybCBMaXUg
KFdIKSA8Y2hhcmwubGl1QGJheWh1YnRlY2guY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsg
bGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
5oqE6YCBOiBTaGFwZXIgTGl1IChXSCkgPHNoYXBlci5saXVAYmF5aHVidGVjaC5jb20+OyBDaGV2
cm9uIExpIChXSCkgPGNoZXZyb24ubGlAYmF5aHVidGVjaC5jb20+OyBUaG9tYXMgSHUoV0gpIDx0
aG9tYXMuaHVAYmF5aHVidGVjaC5jb20+OyBYaWFvR3VhbmcgWXUgKFdIKSA8eGlhb2d1YW5nLnl1
QGJheWh1YnRlY2guY29tPjsgU2hpcmxleSBIZXIoU0MpIDxzaGlybGV5LmhlckBiYXlodWJ0ZWNo
LmNvbT4NCuS4u+mimDogUmU6IFtQQVRDSCBWMSAxLzFdIG1tYzpzZGhjaTpGaXggdGhlIFNEIHR1
bmluZyBDTUQgcGFyYW1ldGVyIGlzc3VlIHRoYXQgdGhlIFNESENJX1RSQU5TRkVSX01PREUgaXMg
Y2xlYXJlZCBmcm9tIHJlYWQgZGlyZWN0aW9uIHRvIHdyaXRlIGRpcmVjdGlvbiBpbmNvcnJlY3Rs
eQ0KDQpPbiAyMC8wNy8yMiAxNTozNywgQ2hhcmwgTGl1IHdyb3RlOg0KPiBXaGVuIGNtZC0+b3Bj
b2RlID09IE1NQ19TRU5EX1RVTklOR19CTE9DSywgdGhlIFNESENJX1RSQU5TRkVSX01PREUgDQo+
IHNob3VsZCBhbHNvIGJlIGtlcHQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoYXJsIExpdSA8Y2hh
cmwubGl1QGJheWh1YnRlY2guY29tPg0KPiAtLS0NCj4gQ2hhbmdlIGluIFYxOg0KPiBLZWVwaW5n
IHRoZSBTREhDSV9UUkFOU0ZFUl9NT0RFIHdoZW4gY21kLT5vcGNvZGUgPT0gTU1DX0VORF9UVU5J
TkdfIA0KPiBCTE9DSw0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyB8IDMgKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS5jIGluZGV4IA0KPiAyMjE1MjAyOWUxNGMuLjZhMGY2NzI1ZGFkYiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2kuYw0KPiBAQCAtMTQzMCw3ICsxNDMwLDggQEAgc3RhdGljIHZvaWQgc2RoY2lfc2V0X3Ry
YW5zZmVyX21vZGUoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsDQo+ICAJCWlmIChob3N0LT5xdWly
a3MyICYNCj4gIAkJCVNESENJX1FVSVJLMl9DTEVBUl9UUkFOU0ZFUk1PREVfUkVHX0JFRk9SRV9D
TUQpIHsNCj4gIAkJCS8qIG11c3Qgbm90IGNsZWFyIFNESENJX1RSQU5TRkVSX01PREUgd2hlbiB0
dW5pbmcgKi8NCj4gLQkJCWlmIChjbWQtPm9wY29kZSAhPSBNTUNfU0VORF9UVU5JTkdfQkxPQ0tf
SFMyMDApDQo+ICsJCQlpZiAoKGNtZC0+b3Bjb2RlICE9IE1NQ19TRU5EX1RVTklOR19CTE9DS19I
UzIwMCkgJiYNCj4gKwkJCShjbWQtPm9wY29kZSAhPSBNTUNfU0VORF9UVU5JTkdfQkxPQ0spKQ0K
DQptbWNfb3BfdHVuaW5nKCkgY291bGQgYmUgdXNlZCBoZXJlDQoNCj4gIAkJCQlzZGhjaV93cml0
ZXcoaG9zdCwgMHgwLCBTREhDSV9UUkFOU0ZFUl9NT0RFKTsNCj4gIAkJfSBlbHNlIHsNCj4gIAkJ
LyogY2xlYXIgQXV0byBDTUQgc2V0dGluZ3MgZm9yIG5vIGRhdGEgQ01EcyAqLw0KDQo=
