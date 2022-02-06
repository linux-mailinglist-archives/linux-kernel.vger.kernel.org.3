Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2974AAE63
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 09:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiBFIWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 03:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiBFIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 03:22:05 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 00:22:04 PST
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4680C06173B;
        Sun,  6 Feb 2022 00:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644135724; x=1675671724;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=LXJmdmXIlbupWIOKOLkNrPeJs0vMWbv7X8P5f+nne7s=;
  b=SKMhPCMCvFwUtnVo4AMYq0rkw/VmeEsv4mGRvagujofPeEhvfOawwzDI
   vYK92gs6IYV2zGyD5WtAkkYgUwICtwGEbr3OTatVo3N+JbIlNwAVg2kaj
   8fGbXzCkuH4m6sTLQsvAuZdGhfL1x2VGGsNPOyKzAe/e+lufDd8zWOnI/
   HYJT6Wp0Z7SiuV3SI0RTsVdUGmZxhGc0Y5D1T7DiT29YG9Sss1ZScD8Yk
   IZl5HaJvX1gnlETbnByiIKtu65xYB13l9QWa1GXyVmTvBfII9RpjCSPtF
   2RTkmkhTqPeV6o8tVtVi9vQXE2oe8+9Px2cSr5mL3QFN2nQZ0n1tumlIm
   w==;
X-IronPort-AV: E=Sophos;i="5.88,347,1635177600"; 
   d="scan'208";a="192254478"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2022 16:20:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/7T6HnUclDyZYA/sEmkkwY6/SDAkqhrEqIhrvfLISAKGM4QXZ8BFAPM3m3vFNcqWl+UIUjXt0xXqfvxy2Ac3Zn1Dbm/qR/H93Eo8EQBwNigQHWWJgHO5+nXR/yIMxuiOVk1AD0Oppgs0/LY+4JXEM/HMqnsKUBRSlRzWYTqrVjSS7snVYYn0VI6jhrdXu75bBB8krhyM8xvtXt3Qq5kdSzGieklBT2CLOszHgwCa6Q8iuxTjzJ+tiReXO4Mgy1NKsd5ryTxw9GiwxYOa4HBybA44Z2U78z1E5pbPkXyqRyIuRJr9FgW0K1E4XRY1ZdbHk9iTpTA8QcNea24Z1++0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXJmdmXIlbupWIOKOLkNrPeJs0vMWbv7X8P5f+nne7s=;
 b=kcoOzZQYxwJgkzwUgFkjfDaMu4XwIXxKwfEnoBKcNKk4ZPWnmwca35pVOL2lObJABb7/TpQSW9IUMLFl+RP6ljKRE4HjIOLRBR3XC41c5MlaDwT48lGFdsFwPhEztsWXvuIfVR26TxdWZsviwv06gfstm+CglvCQdA1abSbU1VpFliT4H31YozpaYIRVEt6cCASmMTNGAsNGVelfUi4KTyW9v4iw5zr9qN2VyjOUCuFVI0x2tOiVy0IEwhY8Q+emaa/v8O20wW/tDFMy5bYPw5sP+qdfm06n29v+X9+xnNIB9FfDfKiH6gJFo90mRZhmcoA2hjkAL1dbsDX/+nrEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXJmdmXIlbupWIOKOLkNrPeJs0vMWbv7X8P5f+nne7s=;
 b=E75FW+mFZdFgRpF5NuUREwHO3WWHN30Njb4SE4BarKzdu3w2KUpcffP3H8NOll+eLlH3ZviPy1ptJJBaSYnlwWmGPbA5hV+CdjmaZTF9JFVK5x+zTAiu+TezD3fXCpmN5B0GKZPBF2v1l4jXM6bx5A1+kisMypiRQS+gXp9STNI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB8093.namprd04.prod.outlook.com (2603:10b6:408:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 6 Feb
 2022 08:20:58 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::14b1:1b88:427:df7%6]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 08:20:58 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Kiwoong Kim <kwmad.kim@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "sc.suh@samsung.com" <sc.suh@samsung.com>,
        "hy50.seo@samsung.com" <hy50.seo@samsung.com>,
        "sh425.lee@samsung.com" <sh425.lee@samsung.com>,
        "bhoon95.kim@samsung.com" <bhoon95.kim@samsung.com>,
        "vkumar.1997@samsung.com" <vkumar.1997@samsung.com>
Subject: RE: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
Thread-Topic: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
Thread-Index: AQHYGmPQ8Ff+rACVsk6i/i0BNavg3ayGLxRw
Date:   Sun, 6 Feb 2022 08:20:58 +0000
Message-ID: <DM6PR04MB657519E60FAFA19434531CE2FC2B9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20220205074128epcas2p40901c37a7328e825d8697f8d3269edba@epcas2p4.samsung.com>
 <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
In-Reply-To: <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c8daa28-e61f-4152-a004-08d9e9499a78
x-ms-traffictypediagnostic: BN0PR04MB8093:EE_
x-microsoft-antispam-prvs: <BN0PR04MB80939021948A29B7FEFA7D50FC2B9@BN0PR04MB8093.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: asgvkm700VGo+QOi72G+thvBRbszJ8DLWrxFfgnrl/HX4pEqu/qo3VX6kM8LlZV+gqFf2k22mcJiUCWsGa6mtjeufz6pnrQre/wbgkJQpLeFZOhE7lONwX/nUMhnpNqPGbwqHfgMupEziEWU6PQNDC2nOWpC++k6vdh8XeVkkXgHFhRhpw33biBI72m2Z9sr8cdc8Ntsqubfz6vsSOQ/OJOz2wLDQ/UJlgDO5PJ1MLu4aB/B04Pm/BE89RK89WZaZHcqvdbce7/Ll0LQ5HYzylcm2dH5soauh5hmHIbqG8l7Hy7BydNvywOR+hl7xULzwK5IpFPBu+EufON4Xzs2Jg0v0EVGZGcl+44lp32GtN9VnjSjd/GzVh3D31zCil6Ol0TlLYsD0pHGyeNTyA6nGJT1Z4+gCNyYwlQCjHc6r33ImxUOSvH1F9qXGR4BI7jp1I/qiKeN70TS0tYS7VswNRvz0s08jmZqotaxlZnF/8duC2ucoAb4h+V0AnXciIPYykd0pPxYQyaUt4xrRdtCZMMdg/g00YwjoSUepMHlGEcXcIDmdQfHDSF3hvVGbCEo+eq5curEw1Qi0qldRhSbf7u3dfG9C8erDsyUBzeDbphzZxHyQJbnSj2+HEPq0BU9YeoJBlZzX0mNYK1E8hasZueIIQ8gXLncSHvnjnMcYfQfda1w6GUIEerPpPYBg8vxHzXNkYt9xqRiLJxy0cihjvyxPrx1n13n5CbMx0HK6WM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66946007)(66556008)(66446008)(66476007)(64756008)(122000001)(8676002)(8936002)(38070700005)(26005)(186003)(316002)(921005)(71200400001)(86362001)(7416002)(5660300002)(38100700002)(52536014)(9686003)(33656002)(82960400001)(6506007)(7696005)(83380400001)(55016003)(508600001)(2906002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWI2eXdqM0hDNFUrZTdsSWZPZi9TZjhlcG00K05yVUJJYUlBTENHR3p0Z2R1?=
 =?utf-8?B?MjNXL3ZvazZhZ2ZvQ2hPTVJLRjV3ZmMxU1BzaWlXVExSK0I1eVhadkVrUy96?=
 =?utf-8?B?a2szVDZOZDVvZ1FxQ1FFY014Q2lOWWlnNUVKdkxSWktkd0JjRi8rTTlVRnF4?=
 =?utf-8?B?empLeThIbzBremRBYTE2MnpKNmh4VmRQQ2dIdENRS1dIaWl0S2J5aTVsN2xD?=
 =?utf-8?B?TktpYk5wa1hTcHJRV3VLS0kwejVDNnNkSC9yMDRnUkFPREJoTVJSV254SFJs?=
 =?utf-8?B?RlE0MU9tc09qcVl3MFJrMU9aZDVFQ1RyVGFwbjc4MUNGTHk0TjBSakVnWDZ6?=
 =?utf-8?B?RjNDVC82dG8yYTF3R2ZhK3hhajM2SU04MFhpU0tFODFmVmtrNFFQSkJDcXRj?=
 =?utf-8?B?S2FiNEdvRDczL01FZnhjNnB2cVQ5ZWtIcW5oclJ0anY2Z3hYRkJFRHNIQ0Vx?=
 =?utf-8?B?aFdWVW5nZ2dUN2p3d2NKMnpYU21lZ1ZrcEFpejlrWW1GWFdOTFNRQ2FLSlUv?=
 =?utf-8?B?dENjMjBPa2F5NXBiUmZuTmZ1RlpFVWk0cmRkVnRxNnhISmNIVTYxYXdKWDR1?=
 =?utf-8?B?eHBsWm9keGZxamtzeWt5b1dLaW1WclNONXppT1R0b3B0ZkZETlg5bU5vamht?=
 =?utf-8?B?Rk1UeDExUXN0NmFGY0lSZU51YU9ydTdTaTZHRHpuNk9xL0dqdXlrOXM4TzEr?=
 =?utf-8?B?enBBMGl1SVJKWXlLV3ArS3NCYXJPdk1wS1hJWko3R1doVEorNXU5aVlTOUI0?=
 =?utf-8?B?a3JOVUE5RGo1Unh1ODlIZWhyR0lxcnZjZTdnMmVpS0lsVHRqVnJUYTVKMnh3?=
 =?utf-8?B?QjNzU0tMVlJxZElwLzd3Z1hLRnlJWUtJaGJkNVZ3dmhKVFFjcmU0WjFtSXF0?=
 =?utf-8?B?bjFjM1cyeG8vZkQwcXZXVnZKWUU5S3VpckEvZWJPTDdvT2dTbFhFMFNMQ0ZM?=
 =?utf-8?B?TFNJMUtlQmtPRG5UUjZ0OGRKaVJWZXdxQlVDNVMwdC90MFQ4S0JtZ1JQWlBV?=
 =?utf-8?B?UGNkdlJIY3VsaEFEVjNBUlJ5KzJZYTN4QnhiVEZxdHpiWDdhYStxd2w3OVkw?=
 =?utf-8?B?RWtZQTQvaTZzREI0QkF1YVhYUEUzb2o5RHRZMFMrNTY1Mm5scGpBaUJpeDNO?=
 =?utf-8?B?MG51ck5Ob2dpbjNlK29RRzZtTTZLd2dNbUhJOHNoOXlNUXZMVUVZN2RIY2NQ?=
 =?utf-8?B?aXJIa3pzZGJZVHZjQ3MvN1BXclZNank1UktBdmVFd3pObFBXdElqRG1DN3pn?=
 =?utf-8?B?a0dNZ2lLNzBja2FUTm5QcWt0UWhGMlNYQ0RtREsyLzg4Q1dIT0ovZXAydDh4?=
 =?utf-8?B?b055L0EzYXNNSG1YcDdPSmhXSnFNZXZQY0F6T3lPazZJYUhiZDFENTQxakJT?=
 =?utf-8?B?UHlaMVBYcTZsMCtjQWl0dnNnZFNnT2M3TVhIVUVZTWZGWmE0UmJVWDFPMGVo?=
 =?utf-8?B?d2JLL25CekY0b3pCOTFNMm5CQ2hscDMyTllrdXd5SzZXVGsreFRoMC9CdDlJ?=
 =?utf-8?B?NDVqK2RicVpLM3JPemFlOE1HME9IcW9MMHE4dmwrV3I1c0FCd3JCeThpSENB?=
 =?utf-8?B?RkZTOHc5ZHc4bHBRMUhsbFpmTndCRWF1TUYrTEdEWTJPQTJoV1Y5TzR2YTNz?=
 =?utf-8?B?TkcreUd4RFdOdmRNd3lRZ0YxMG92S3NDNmtadmorM1dqKzYvQ0Z0TEJ3aEdK?=
 =?utf-8?B?c2lKeFJCcUE5UFlLVEZrSzJabHhnMXB1Qm81ZGNZR3NlTC8vZGN2b2ppdU5x?=
 =?utf-8?B?T2J4cmlha2dSVGJHRThIKzA3TjlYSnU4eCt4bVlQTUVXc3BWUXF3R0xaMjNw?=
 =?utf-8?B?ODE2SkJBNTJjR09qd0dsYU4vUnIwZWFhNndIK1JEbVJlTFhWTk1TelJQakhn?=
 =?utf-8?B?Z0JPVmVVaGprTE40UFRkdjVXUldTdC9JWERWZURTR0VXMnN6dS9JclV1UFdh?=
 =?utf-8?B?TEFaMWYxWWJSaFNwbm5XRGZodWZpTHZjMHZwSVhxNExKcXVmbWhNbW5xemNR?=
 =?utf-8?B?Z0tBVnZpcGIxVTJOcUQ5M1VoOFZkR2lxSWx5MC9KMGh0SXowd213Q01qT0o0?=
 =?utf-8?B?WlgvQ1AxeUFWbm1sNEl1NjJJazlNcytGU1VFOHhKY2lzekFCTnpndWgrNk9E?=
 =?utf-8?B?K00vemdBV2YzL25FelRzbi9kWVROTzI1c1JCNW5GTnpEbllRSk1kZmYxWFZh?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8daa28-e61f-4152-a004-08d9e9499a78
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 08:20:58.0461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 534vzWXZr1hbUx7dvSqxsMjqIao0SVOReka3YP43MhY07hp1Zysh8XbjRMNw0Qc2RbEwrc7DiodTSpsMMdKa8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8093
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBjbGtfc2NhbGluZ19sb2NrIGlzIHRvIHByZXZlbnQgZnJvbSBydW5uaW5nIGNsa3NjYWxp
bmcgcmVsYXRlZCBvcGVyYXRpb25zDQo+IHdpdGggb3RoZXJzIHdoaWNoIG1pZ2h0IGJlIGFmZmVj
dGVkIGJ5IHRoZSBvcGVyYXRpb25zIGNvbmN1cnJlbnRseS4NCj4gSSB0aGluayBpdCBsb29rcyBo
YXJkd2FyZSBzcGVjaWZpYy4NCj4gSWYgdGhlIGZlYXR1cmUgaXNuJ3Qgc3VwcG9ydGVkLCBJIHRo
aW5rIHRoZXJlIGlzIG5vIHJlYXNvbnRvIHByZXZlbnQgZnJvbQ0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBeXl4gcmVhc29uIHRvIA0KDQo+IHJ1bm5pbmcgb3RoZXIgZnVuY3Rpb25z
LCBzdWNoIGFzIHVmc2hjZF9xdWV1ZWNvbW1hbmQgYW5kDQpJdCBpcyBubyBsb25nZXIgdXNlZCBp
biBxdWV1ZWNvbW1hbmQgc2luY2UgNTY3NWMzODFlYTUxIGFuZCA4ZDA3N2VkZTQ4YzENCg0KPiB1
ZnNoY2RfZXhlY19kZXZfY21kLCBjb25jdXJyZW50bHkuDQo+IA0KPiBTbyBJIGFkZCBhIGNvbmRp
dGlvbiBhdCBzb21lIHBvaW50cyBwcm90ZWN0aW5nIHdpdGggY2xrX3NjYWxpbmdfbG9jay4NCkJ1
dCB5b3Ugc3RpbGwgbmVlZCBhIHdheSB0byBzZXJpYWxpemUgZGV2aWNlIG1hbmFnZW1lbnQgY29t
bWFuZHMuDQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2l3b29uZyBL
aW0gPGt3bWFkLmtpbUBzYW1zdW5nLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3Njc2kvdWZzL3Vm
c2hjZC5jIHwgMjEgKysrKysrKysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3Njc2kvdWZzL3Vmc2hjZC5jIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KPiBpbmRleCA0
NjBkMmI0Li44NDcxYzkwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5j
DQo+ICsrKyBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMNCj4gQEAgLTI5ODAsNyArMjk4MCw4
IEBAIHN0YXRpYyBpbnQgdWZzaGNkX2V4ZWNfZGV2X2NtZChzdHJ1Y3QgdWZzX2hiYSAqaGJhLA0K
PiAgICAgICAgIC8qIFByb3RlY3RzIHVzZSBvZiBoYmEtPnJlc2VydmVkX3Nsb3QuICovDQo+ICAg
ICAgICAgbG9ja2RlcF9hc3NlcnRfaGVsZCgmaGJhLT5kZXZfY21kLmxvY2spOw0KPiANCj4gLSAg
ICAgICBkb3duX3JlYWQoJmhiYS0+Y2xrX3NjYWxpbmdfbG9jayk7DQo+ICsgICAgICAgaWYgKHVm
c2hjZF9pc19jbGtzY2FsaW5nX3N1cHBvcnRlZChoYmEpKQ0KPiArICAgICAgICAgICAgICAgZG93
bl9yZWFkKCZoYmEtPmNsa19zY2FsaW5nX2xvY2spOw0KPiANCj4gICAgICAgICBscmJwID0gJmhi
YS0+bHJiW3RhZ107DQo+ICAgICAgICAgV0FSTl9PTihscmJwLT5jbWQpOw0KPiBAQCAtMjk5OCw3
ICsyOTk5LDggQEAgc3RhdGljIGludCB1ZnNoY2RfZXhlY19kZXZfY21kKHN0cnVjdCB1ZnNfaGJh
ICpoYmEsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChzdHJ1Y3QgdXRw
X3VwaXVfcmVxICopbHJicC0+dWNkX3JzcF9wdHIpOw0KPiANCj4gIG91dDoNCj4gLSAgICAgICB1
cF9yZWFkKCZoYmEtPmNsa19zY2FsaW5nX2xvY2spOw0KPiArICAgICAgIGlmICh1ZnNoY2RfaXNf
Y2xrc2NhbGluZ19zdXBwb3J0ZWQoaGJhKSkNCj4gKyAgICAgICAgICAgICAgIHVwX3JlYWQoJmhi
YS0+Y2xrX3NjYWxpbmdfbG9jayk7DQo+ICAgICAgICAgcmV0dXJuIGVycjsNCj4gIH0NCj4gDQo+
IEBAIC02MDE0LDcgKzYwMTYsOCBAQCBzdGF0aWMgdm9pZCB1ZnNoY2RfZXJyX2hhbmRsaW5nX3By
ZXBhcmUoc3RydWN0DQo+IHVmc19oYmEgKmhiYSkNCj4gICAgICAgICAgICAgICAgIGlmICh1ZnNo
Y2RfaXNfY2xrc2NhbGluZ19zdXBwb3J0ZWQoaGJhKSAmJg0KPiAgICAgICAgICAgICAgICAgICAg
IGhiYS0+Y2xrX3NjYWxpbmcuaXNfZW5hYmxlZCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
dWZzaGNkX3N1c3BlbmRfY2xrc2NhbGluZyhoYmEpOw0KPiAtICAgICAgICAgICAgICAgdWZzaGNk
X2Nsa19zY2FsaW5nX2FsbG93KGhiYSwgZmFsc2UpOw0KPiArICAgICAgICAgICAgICAgaWYgKHVm
c2hjZF9pc19jbGtzY2FsaW5nX3N1cHBvcnRlZChoYmEpKQ0KPiArICAgICAgICAgICAgICAgICAg
ICAgICB1ZnNoY2RfY2xrX3NjYWxpbmdfYWxsb3coaGJhLCBmYWxzZSk7DQo+ICAgICAgICAgfQ0K
PiAgICAgICAgIHVmc2hjZF9zY3NpX2Jsb2NrX3JlcXVlc3RzKGhiYSk7DQo+ICAgICAgICAgLyog
RHJhaW4gdWZzaGNkX3F1ZXVlY29tbWFuZCgpICovDQo+IEBAIC02MjQ3LDcgKzYyNTAsOCBAQCBz
dGF0aWMgdm9pZCB1ZnNoY2RfZXJyX2hhbmRsZXIoc3RydWN0IHdvcmtfc3RydWN0DQo+ICp3b3Jr
KQ0KPiAgICAgICAgICAgICAgICAgICogSG9sZCB0aGUgc2NhbGluZyBsb2NrIGp1c3QgaW4gY2Fz
ZSBkZXYgY21kcw0KPiAgICAgICAgICAgICAgICAgICogYXJlIHNlbnQgdmlhIGJzZyBhbmQvb3Ig
c3lzZnMuDQo+ICAgICAgICAgICAgICAgICAgKi8NCj4gLSAgICAgICAgICAgICAgIGRvd25fd3Jp
dGUoJmhiYS0+Y2xrX3NjYWxpbmdfbG9jayk7DQo+ICsgICAgICAgICAgICAgICBpZiAodWZzaGNk
X2lzX2Nsa3NjYWxpbmdfc3VwcG9ydGVkKGhiYSkpDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGRvd25fd3JpdGUoJmhiYS0+Y2xrX3NjYWxpbmdfbG9jayk7DQo+ICAgICAgICAgICAgICAgICBo
YmEtPmZvcmNlX3BtYyA9IHRydWU7DQo+ICAgICAgICAgICAgICAgICBwbWNfZXJyID0gdWZzaGNk
X2NvbmZpZ19wd3JfbW9kZShoYmEsICYoaGJhLT5wd3JfaW5mbykpOw0KPiAgICAgICAgICAgICAg
ICAgaWYgKHBtY19lcnIpIHsNCj4gQEAgLTYyNTcsNyArNjI2MSw4IEBAIHN0YXRpYyB2b2lkIHVm
c2hjZF9lcnJfaGFuZGxlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QNCj4gKndvcmspDQo+ICAgICAgICAg
ICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICBoYmEtPmZvcmNlX3BtYyA9IGZhbHNlOw0KPiAg
ICAgICAgICAgICAgICAgdWZzaGNkX3ByaW50X3B3cl9pbmZvKGhiYSk7DQo+IC0gICAgICAgICAg
ICAgICB1cF93cml0ZSgmaGJhLT5jbGtfc2NhbGluZ19sb2NrKTsNCj4gKyAgICAgICAgICAgICAg
IGlmICh1ZnNoY2RfaXNfY2xrc2NhbGluZ19zdXBwb3J0ZWQoaGJhKSkNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgdXBfd3JpdGUoJmhiYS0+Y2xrX3NjYWxpbmdfbG9jayk7DQo+ICAgICAgICAg
ICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZShoYmEtPmhvc3QtPmhvc3RfbG9jaywgZmxhZ3MpOw0K
PiAgICAgICAgIH0NCj4gDQo+IEBAIC02NzUzLDcgKzY3NTgsOCBAQCBzdGF0aWMgaW50IHVmc2hj
ZF9pc3N1ZV9kZXZtYW5fdXBpdV9jbWQoc3RydWN0DQo+IHVmc19oYmEgKmhiYSwNCj4gICAgICAg
ICAvKiBQcm90ZWN0cyB1c2Ugb2YgaGJhLT5yZXNlcnZlZF9zbG90LiAqLw0KPiAgICAgICAgIGxv
Y2tkZXBfYXNzZXJ0X2hlbGQoJmhiYS0+ZGV2X2NtZC5sb2NrKTsNCj4gDQo+IC0gICAgICAgZG93
bl9yZWFkKCZoYmEtPmNsa19zY2FsaW5nX2xvY2spOw0KPiArICAgICAgIGlmICh1ZnNoY2RfaXNf
Y2xrc2NhbGluZ19zdXBwb3J0ZWQoaGJhKSkNCj4gKyAgICAgICAgICAgICAgIGRvd25fcmVhZCgm
aGJhLT5jbGtfc2NhbGluZ19sb2NrKTsNCj4gDQo+ICAgICAgICAgbHJicCA9ICZoYmEtPmxyYlt0
YWddOw0KPiAgICAgICAgIFdBUk5fT04obHJicC0+Y21kKTsNCj4gQEAgLTY4MjIsNyArNjgyOCw4
IEBAIHN0YXRpYyBpbnQgdWZzaGNkX2lzc3VlX2Rldm1hbl91cGl1X2NtZChzdHJ1Y3QNCj4gdWZz
X2hiYSAqaGJhLA0KPiAgICAgICAgIHVmc2hjZF9hZGRfcXVlcnlfdXBpdV90cmFjZShoYmEsIGVy
ciA/IFVGU19RVUVSWV9FUlIgOg0KPiBVRlNfUVVFUllfQ09NUCwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKHN0cnVjdCB1dHBfdXBpdV9yZXEgKilscmJwLT51Y2RfcnNw
X3B0cik7DQo+IA0KPiAtICAgICAgIHVwX3JlYWQoJmhiYS0+Y2xrX3NjYWxpbmdfbG9jayk7DQo+
ICsgICAgICAgaWYgKHVmc2hjZF9pc19jbGtzY2FsaW5nX3N1cHBvcnRlZChoYmEpKQ0KPiArICAg
ICAgICAgICAgICAgdXBfcmVhZCgmaGJhLT5jbGtfc2NhbGluZ19sb2NrKTsNCj4gICAgICAgICBy
ZXR1cm4gZXJyOw0KPiAgfQ0KPiANCj4gLS0NCj4gMi43LjQNCg0K
