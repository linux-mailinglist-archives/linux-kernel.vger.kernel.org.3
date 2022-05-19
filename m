Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B838052CC09
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiESGhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiESGht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:37:49 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF6163CF;
        Wed, 18 May 2022 23:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652942265; x=1684478265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5+wuiSjTJLkKdfijllMZOkLVPPBn/rg+//OKlAhT/D4=;
  b=JAxU6wUwRJ/cRWvzALY8rb7dBSzSsnCwAgMzLozojsGXGWfM4OkKjb0h
   prouBTSGUqpDeIHxHvSB8WvXvpdIRp6EYwTv0ou9IZs3bWv57OhIwRl7q
   MzqOrd43Z3RTYy1JgBZHtChtsXEcmgYwoCmKs7N1kdz+NCO4IhFEUXMOI
   VDDxbAwFGtPRaz/0BCwbqeqM+cw89cd2w+CWYjjv18eIVF7bhTRYXUKgK
   2WBgXa1n6uVsrTGm5gNjkNsfDDHzWjswHvqs25RRIAJlaumIob1kk6zgG
   oRI+KkBEKf+hIV3hgqdDMZu18ma+lP45dYDbaNv3wGxsDwW9rg9v3NpPr
   w==;
X-IronPort-AV: E=Sophos;i="5.91,236,1647273600"; 
   d="scan'208";a="201613058"
Received: from mail-bn1nam07lp2042.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.42])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 14:37:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuKwQ1yoEVwCo8h4AR2hmgCcg3r8WPTTpVqcbzetwmPOLU//haO/MtslNi8AK5GGkttVODOfpMMPRo/9/XQbYAwk0XGWkfP7n6QGv6GxznXDIUmmJwT0zdRpqBofpTLabQcQRK12xdWdopFp+kqO3F6KGlTMdtWlKbrQRw7XVUDjTqxJuukwPoPa/mAdWZTutHY1OCxlUMczhw6pxQmIEfE0ZtyD4mNGDtF59DUtAYJuymHfKt1PInhF85iRjR+EQhehwS5ILVcO/hF8SUQSLne3prhUVxIWGkRL1CDo95rO5JBaLGFQMxSXWDCgTbTB8gK6mM6AryXkc45uTnjuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+wuiSjTJLkKdfijllMZOkLVPPBn/rg+//OKlAhT/D4=;
 b=HUpID5nSt7mKimSnsAOoHlK6qZr9JJ/gHHqR3yMJtOvNVKdip4Jd4356v6c20mB3Ak8BItbQ98CEQUljTANjspi6AH4IcOlG/VRX/4gnE3eDX/jm8qpsFFpN/IlwEeS7L9fyhTjr1cntbzEb3P+nLcoebHoiqrn6Sjkm55feZ9yW1QOEvsz7Z9QC2I1a//VnmBmvzWhxLmnu0jn4iJHs7/5LM9bJynvyqhM92+SDH42uLQJqf2gIyXW36pyF6zJ3wCwvlYzgSxyi/KKx1IQHFJ2DWX6nyyjd94iZkzX5EtoE9jqRHAzgxpn+5f2TWH4bgqvwBryiqDhR7OuoI9wXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+wuiSjTJLkKdfijllMZOkLVPPBn/rg+//OKlAhT/D4=;
 b=Zo/TdtbhenF8PZcoyaphpv5fpb/SMUAUeXcyww2JyO2TusqVAUZngaqnKcNVC3eaKCuGn5yVORP3DnL6hw941Rr3FHrvXhvZW6o26jYGSH9onQWUIxejDejuRylKHYBLxfYVAVJJXjiT/Z7jIjCkMmcq8e/VuiqvThIVqU4eZZ4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7318.namprd04.prod.outlook.com (2603:10b6:510:19::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Thu, 19 May 2022 06:37:42 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::cc4e:5a1e:e4a:e3fb]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::cc4e:5a1e:e4a:e3fb%3]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 06:37:42 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: Fix referencing invalid rsp field
Thread-Topic: [PATCH] scsi: ufs: Fix referencing invalid rsp field
Thread-Index: AQHYa0bTd1rszpokKkaTM6mZV6MiDq0lvymg
Date:   Thu, 19 May 2022 06:37:41 +0000
Message-ID: <DM6PR04MB65758C6F3C3CE2092B5F9CB0FCD09@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20220519060529epcms2p8941ce10ed8cfb50c142140f1f69f8612@epcms2p8>
 <252651381.41652940482659.JavaMail.epsvc@epcpadp4>
In-Reply-To: <252651381.41652940482659.JavaMail.epsvc@epcpadp4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8146a66-a794-4f9a-c480-08da39621355
x-ms-traffictypediagnostic: PH0PR04MB7318:EE_
x-microsoft-antispam-prvs: <PH0PR04MB731818BBA74C75B8FC358924FCD09@PH0PR04MB7318.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WH6/So1LOfSLxW+eO/4EBNf9Y3H1+KrDX2yJjAeeyAmv0eb0OpRycWZ+jLBsQZchHBa5CWArUPE/QfrtMMUSbWc4q2YFInRo6wWq7BXW3MtE0e+7syDKdgGcwNoKnWzx9CfP46Adi1/X+Fcxmv1tjGnSJDgFeWXOT6lFVfQSmavif5ETZF/BGk+3bWFfCwX16d71CoT6l5q7v+3mvn0J7IdAJD4u6HtLMu/CoFd5SsbMwAmUc3e7xviFrSbnCN5NMz1h9NF9zHJ2aYr3z/+E8Fo/j1LSxYTR/5868KfX8s1NhBE638HU7Yn+9eIvL6ETq6qn82hlEaygUkWx8G835LjrpHLGlolazP4D/2d00sGlBB4JNPjr43MFgOYq/GftVSwBOiyFp5yAtG8YdwOFt/GBVQ838wIjkC7PpGuchEDdn7SY/KCIAFGNo4tMP62lgF0p69dRJWghXfoWTpb4/9la1D3iIZ/3LqCIJ7BTjHhQrvA9giGdZSDZOnGqi2O2l8paDkCb3NTA5hdyxW8ocHPeJQe3Mce8bprdnqP/yeKYSp3xcQWQ2JTrkEbWzJQTZppqstZZQvFkNC32G8sYKxJKtnHYd76bfEVev2NDGlIErlXzHxhDQEascpJoj1AwUvFDyYpLnOAU52zGwVttT7OmzQ5IFZSl2DjJUz3jjl4qvRYPZLfPQMI+PlhJV1hX8uZ6jptaEYDdXDRbB1/JcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(2906002)(38100700002)(508600001)(86362001)(71200400001)(110136005)(54906003)(316002)(5660300002)(82960400001)(52536014)(8936002)(64756008)(66446008)(8676002)(66946007)(122000001)(4326008)(66476007)(66556008)(76116006)(33656002)(6506007)(55016003)(26005)(9686003)(186003)(558084003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk1ySU5wNitNTG1iZXRPTmlZbDBoVk5MaFI0WlRXNzFlOXVZaXFmZlZBVlNh?=
 =?utf-8?B?WVUzd2tnRXhSWFZhbklaSE5MWDh0YTFETXl5ZEhYcENBdFM4Tk5NNDFhRXZa?=
 =?utf-8?B?WmROWlpIU2ZCOENOK2sxN2RjSXdTVjhFVjJwNXI5OHBlZmEydUMvcjNrL0R1?=
 =?utf-8?B?T1JzQVlWUVZiUXJlTmw3R1dLY0FmdEhWY2tDNlg2Umk5amxKY2d3dC9yd1Q2?=
 =?utf-8?B?VnViTXd0MWJBRzZPeG5sWmtNUDRGMFRQbGlTbGFXQi9HSk95UW1TOUlzQnJQ?=
 =?utf-8?B?ZVBUeDlYWXpJWDVEaktQSGoyR1NtZHZ3TkhSd3NVTFZ2Y2ovVS9zTXNzTmpj?=
 =?utf-8?B?UXozUjRJZmxiQjhVNWs0S1NUN09xdVdicUlyS2I1TVZIOVhkNzBuN2dZTkpw?=
 =?utf-8?B?US9IbTc1eTdFMGR3R2YxWGZNVVI1VFIycUtPck9GQitQT1I4SWdIVDdtWUFO?=
 =?utf-8?B?ZXBhby9TSEdMcDkyUXNjc0wrY2pBQVU3UlNIQ0I4TTVkZzJxUU12T0o5cExV?=
 =?utf-8?B?UVpsNVphRVk3Rmx4Tlc2SEVXRmF2SUwweTlEV0NlYUJvNnBvcFJTcUM5TjVF?=
 =?utf-8?B?WXR4b0Q4UHo1NDNaaHNmZ0szRVE1SDV5UDhkT1RoT3h2S3FOZTN5TnhYR1Ux?=
 =?utf-8?B?NkRVc2huVW5mdWJRTmZDU0JkRTRvUmRrRjR5NnhkOFJDd3hSenc5SXRIYkIx?=
 =?utf-8?B?VnhiYjZzRG05d2daN0FMc2Z3YUoyK0kvVUpLR0loVnVoUml3SkVyOStHNEFV?=
 =?utf-8?B?K0JYWFJHUXhIa2d2bE5CTHBpckNYRnZYWFNBeDNkREtUUEwzdVowQi9vTnNZ?=
 =?utf-8?B?aWZjVHZoNldjaUQ0bE9YYzRna2Znc2s3OW9CK0JlSTlBdUpBS1VUZjZUNTA4?=
 =?utf-8?B?MlB2TERnZ0F4S3lFWnFmd2UzdjhoMnljVUpJQld2TkgxbVc4YjFnbEVia0V3?=
 =?utf-8?B?cHVCQVZRbFkvbW5KZEJnTWFJNUdibTRKK0JZZjlQRUF2S295b0xrbnR4dFZx?=
 =?utf-8?B?OUxSZmdNSkl4V3V3UjZQcUJZKzF4V1lXOVgzb1Qra3E3K2pqOVFZYXNrNFZG?=
 =?utf-8?B?QjJoQ1BGdGZ2T1NBOVVySW9XcmE5VUhPMHljRGRzR2RMUUw0NTNjaUlFTktp?=
 =?utf-8?B?RlV2V2dyMmNQUVcvNWk2L1doM0F0MmNhVnlXcHVwclVsRmF1cTlWMkllMTRu?=
 =?utf-8?B?OVF4Wm05NHlLN2FWeTZ0ek96cHk2WWoremJVOHM2RW1aTXdmM0M2VXVYSVpx?=
 =?utf-8?B?UGppY1hLZGxib0g3VXVvUGgwV1JmSlNqT2xRZjIwVXU2SS9ka0pCdHp2REJh?=
 =?utf-8?B?akppd05kbXFWWDJtNU42NTkrUFh5N3paWkZvTzZSeUh2U0VZakxiL0EvNFg4?=
 =?utf-8?B?VU14OWpuY2VhSXFYNlpOeC9QdWJST2JVbXRNTVZtbCtZLzZCdW0xclNhYyta?=
 =?utf-8?B?eWN0QlhMOE15ZUJuTllJRlJmbjZSekVmdndObTVYd3BrZy9uamxUeEx6M0l3?=
 =?utf-8?B?NkR6YTk5UDl1MFJrcTFJWjVuam1Bc2FTZG10U1lhWEZtaEpxWGRGNzhVMVI1?=
 =?utf-8?B?bDdQTnhnVkdxRkpBWXcyNmE2cmIzTWl1S055Mi9oQVRQWG9VdTJNK2RlcjdD?=
 =?utf-8?B?aXkzd0Nza3psSGtjeXFZSm5OZWNTK3NuanMwRGpDbWZoa0VIREdCU3o0YVgr?=
 =?utf-8?B?VEtIcWMwQ3JVak5tZnVVclNTQlFSVkxaQmg4RzB1anVOMFZiSU45SS9GNEhn?=
 =?utf-8?B?cEtXTVh1SDczcnhmeit6WHMxdXVmbzR0RERBVlpaRGxrM3c3Y3JiMFF4cEZI?=
 =?utf-8?B?bStxT0QzRGdmd1RIeXBiazhualZDdm1MWXZCeW9UdTNLelA1QmIvNURGVmtt?=
 =?utf-8?B?ZHJPRFNray93a1hyc05YU2RySG43SUM4Y3FYNzhIRzFwZVhjUTVzVjYvYXJo?=
 =?utf-8?B?L0ZXa1NTcHR6aXp5VXF4WXE4U1paTTJ4d2xUYVlhOHU4bmtUYml4N01hb2g2?=
 =?utf-8?B?SjJ6TFJ0RGs3Q2RhYmRoZ3dpaGxhN3JoeWU1ZWZaMmtYUnVLOGpta2p5aXM2?=
 =?utf-8?B?MzFaaHBsYXA3aGpBZlh6a2xWWSs3UUp0WC91dVh0ZHhjelNNRXJzdlMyRXdn?=
 =?utf-8?B?TWJtUytlTzdoeUpGMnloMjEvWTZhbVpmUkZReWpZYXpGRUxsbzVXSWo1c28x?=
 =?utf-8?B?UG1ld1BsTVZJc2ZtcWdwL0ZmQVZ1N3ZsYU13bjJEMSs2eVNKSDlWVXZ2K1hq?=
 =?utf-8?B?blpMeTNESC9nOFFQY2grbTBNdUFVQWVPUk5zK0ViQXhhK2d0Y0tWTUNqVWx2?=
 =?utf-8?B?TUM4bTdUSmNpQUlGQ0NkUVlkVzF1Nmc3UzVWL3FhNmR2czd0L3BFQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8146a66-a794-4f9a-c480-08da39621355
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 06:37:42.0000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a09eBYpjLQvMWuRftrgN5bUjq6yYf+QkvrXLV/ZUajpzFeH3TJir02tN8/kavz6M2Eu1jCoYuWabTBcrB5QQSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7318
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGlzIGlzIGEgcGF0Y2ggZm9yIGZpeGluZyByZWZlcmVuY2luZyBzZW5zZSBkYXRhIHdoZW4g
aXQgaXMgaW52YWxpZC4NCj4gV2hlbiB0aGUgbGVuZ3RoIG9mIHRoZSBkYXRhIHNlZ21lbnQgaXMg
MCwgdGhlcmUgaXMgbm8gdmFsaWQgaW5mb3JtYXRpb24gaW4NCj4gdGhlIHJzcCBmaWVsZCwgc28g
dWZzaHBiX3JzcF91cGl1KCkgaXMgcmV0dXJuZWQgd2l0aG91dCBhZGRpdGlvbmFsDQo+IG9wZXJh
dGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhZWp1biBQYXJrIDxkYWVqdW43LnBhcmtAc2Ft
c3VuZy5jb20+DQpBY2tlZC1ieTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQo=
