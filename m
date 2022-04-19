Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F62D506D08
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351051AbiDSNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350893AbiDSNFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:05:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F15377CD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650373354; x=1681909354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PL/VD54MxGeGY7dk803jdH8p7UZzV0yYCNo4iGUUTNQ=;
  b=ykiEU8KCFr6OCRTEfSuzQlo6KB+i7Rmohk2wsf5P5B0VmdfqaQFWadKI
   iSUX1m8PNCbGfGjaVgGdQ2FYU9wGFjMc+mj3Mnx8Pxp3KUpfWx8lJQ7+5
   jJ4tjKWH60nCiEjbHc728t2ZUKpMO9RIlf7mLUDAFFuufQjpoLGzF6qa7
   UgqvKSh0TDsKDwYJwQXI+Pc7NBbVqyFLJxkKCkzB0VZzgv21SIVoFT5ph
   S0n0BIAznF3LOtXA0m315J17szWv8qY52REbBRpAKWes6SFe0t7JlmyZu
   RYl1PqgVh7vHjXCOsdJzJ+gyVaTLKtHYg3VvAQV7/PSChkWW0r5rShcev
   g==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643698800"; 
   d="scan'208";a="170097827"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Apr 2022 06:02:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Apr 2022 06:02:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 19 Apr 2022 06:02:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpdmzIWnN6uVhM3e/BIb3Lc0mzez4uE2QovUSOg7fTxZ+mme/g8Pn4Z7N2OkmIrQ56sVcMiHO3oUOi96drHp1v5J70oQptdc7WspzBdBI+zXVaj+MMgcKn5cwsYy+JDiprJSCGGaNfSxQQR43cIaaFYe1F+NRPwrUpbvE+9xqLBMvYArdWwIBJV9dfVn39RsOzk6zUrPQTw3kPga1OlzV1LijXMtLQEQfYyx8wlHbN8Z7yrZMtdeDBw1QWWOsJSDrytDqE2Ip1E+ABPy7SaUl2kHAGmDCH82FUzqEm8xiQX7EzjCYDyT7rc9CpbcQzgMzYFP5ml6SrpvdYAxUTUqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PL/VD54MxGeGY7dk803jdH8p7UZzV0yYCNo4iGUUTNQ=;
 b=DVMIXcGb5CfjuKPz7XHqxCCJhIqnqa0Ub0KScxHH8h9oKLUpu6rsC931H0Tpr9j9khZwUaoeJF5sIZUkFOxlEQJG+cCamCxhVH2lvC7vXwy5IRIW5C4Oa19Z0iitEHFpXyPViOpKud3AwY+bBMOrMVJXY0S8kWH34iCDirGcSG1RtPP2kcpDkCCxsxc4PExN9CDTcFn+N3K177yKtCfxFN580RC7hc6x05OA+Y8ABNalqy5Tu6Sw0G572+XIiA6l3I7rOLdaxV1S3SOU1yuVA/nSu/4oa/yDMlkT3Zu/ENXWK/6ED0dWTtaqJpRUd4VyYdPMpnc8H4Mspn6+vY92EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL/VD54MxGeGY7dk803jdH8p7UZzV0yYCNo4iGUUTNQ=;
 b=DmsLXBJCjD/rzyF+/qhMp+L+MBK8ub5cUFHFxIE2087xXn8SUln2qFpv6wdsefP/G5MP02OlA9+CJ6j64+igp93u1Rn5iwanPzwHK2RRDZ+blbtvl/LRd1jHxyDCW17pX+RkyxymGTD/kD6MiwtbgpIij11txYEJt1H5OWuE1WI=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BYAPR11MB3384.namprd11.prod.outlook.com (2603:10b6:a03:75::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Tue, 19 Apr
 2022 13:02:32 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00%7]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 13:02:32 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
Thread-Topic: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
Thread-Index: AQHYU+YijgcwOSWAuEOiQaxrAfyzHw==
Date:   Tue, 19 Apr 2022 13:02:31 +0000
Message-ID: <ada61e0f-b512-e1ee-08fa-5bd287d695b5@microchip.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-7-tudor.ambarus@microchip.com>
 <0e4ec58c21490dcd9cf82ab89bd8c34c@walle.cc>
 <e21b0d76bf778f78f432ba27a673222d@walle.cc>
 <f318dbd9-d4bf-301a-b5c9-556d04d5bfe6@microchip.com>
 <20220419123245.zu4hypebz77ckygn@ti.com>
In-Reply-To: <20220419123245.zu4hypebz77ckygn@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7aae2c3-8943-409e-aed0-08da2204dda7
x-ms-traffictypediagnostic: BYAPR11MB3384:EE_
x-microsoft-antispam-prvs: <BYAPR11MB3384163442142DB75304E6C2F0F29@BYAPR11MB3384.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mEEtGpuB+4tJJR/OhsP2eJm0hi00rnA9Uxh2Y6B3IqtJKwfknM1MMERNhAjVA3/b/jkcZh+x1HDGi0LRt4Z095xmViaf/2y/CnGZ605JpEwfjeYDaafjL68p352U0y0leyyYCGoazreyGJGhi7kI6H6KneV4Ad+Sl49WgZNVnh9lvquwzL/1Rj0UNUzz3B5nBmGUrgdS2rvhK44Pn7WNVfQmosWIKPV7rK0HwdCdjH1oK3om9bBLgy/TBJPyzqMjiTk11AHBZQi25lEo5xwd/tPqb+Rg6h8tGHJA/fkW0ax60QkeG+KePH6JuXabs0Ss+bKZ9W/1lY1HVPbjXEPf0qg91OudlxTTB4YHJqg5D5XqSpNmSLrvhG6CL5lwGML4h8/f18o0fxx8ySRYSOMOjQ5MHIFYFzAbfp4G8iWaOEqh/jNIBN3aYVwzFOJLbc6Eo60g3yGGCu3ZNMeyqXEblgo/hC2isUOri5xzF2clz73hgDRPoLXg6koIbiRv1p3vtvn3Nr3y67yhpg37NKSNk6zbWyvABhTF4y3aGpbttF6jenk7kVeJfU80/Kxbddu87or52YTAb2DyE71V0Md7JTHhXz1RVJY5Pwb5GXOc6cPy8N617XRnFGTmzBzmiLLx5oAczf0M7SfWYLqnNds39pxJpic0K17Sz1Ro25Tym08OqZyrR+w4vk2hyluj/AFYEX/v2/R47FtSgzS8ldUO93uVIiGSAP8Oh68GwZSc3mI++UybzduQEdVso29bkww8muU4OoTEso+A/RjL8uGp+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(5660300002)(4326008)(2616005)(186003)(6506007)(36756003)(2906002)(6512007)(26005)(31686004)(71200400001)(53546011)(122000001)(86362001)(31696002)(8936002)(6486002)(508600001)(66476007)(64756008)(66946007)(66446008)(76116006)(38100700002)(66556008)(91956017)(38070700005)(6916009)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUh6ZlM0bkJKOWdLTXhkd3dHaEU3UWVuNSt4RGFCaDlGNEVnU0ZKdm56K3BH?=
 =?utf-8?B?aUo3dW1yYkdNakVIMGhHcHVOZlptVTVjVFFZa3htSDZZVDd5OW1CVFREVzg0?=
 =?utf-8?B?Nm9Xd0JQcG93UTlMd1FHcGZ4OTF3OGNWdDRZUysyVWFvS3c2ZTRPL1NNSjRS?=
 =?utf-8?B?Q2Vvb0RXNlZpWTNmYyt6eXBQTk1ydUc0QkpFK3lGZ2tYOUhvZGlXQXZNblk0?=
 =?utf-8?B?QWVYZHVuaHp1NXJ1aEJtUUl1UVo3NzR5dVNOUGhzTG4xWVcrZDRRc1RoaDFZ?=
 =?utf-8?B?czg5dkZFYU82aVRSYzhhTG1lRFk5ek5uM0NNYVVXNkNFbkRFTzdEak83Q1M0?=
 =?utf-8?B?ZmxudnBUWG1iTG1aa0wvKzJZMXRIYUJKejF1TDdWaHNGSUprZVZIa2p2RjJE?=
 =?utf-8?B?YTdZRmR6a1pkQkZwV1I1U280UXRlZy9HZTR4YlhmZTJOZVdicHcvZVZRZlJn?=
 =?utf-8?B?N05DdjEzK1Vpa0RPNjZmWHBiUXRGb2hROTVDd3Zvek9iSmR3K2JHTzg1dkZo?=
 =?utf-8?B?NTE3RmJjeUl4WG9rV0l0QnBqS1M0VGFEdGdZUGxFcG15TGZDeTM1WGZwSkli?=
 =?utf-8?B?WlIzZmsrYSt6RzFrY25iWDJBbFhub0p4UDU3bjlNMVhsWUJYdHUvM1o4Z1d1?=
 =?utf-8?B?SkVKM0JqTjhhdFkvN05vM0E2QmFyMlhYcW9jNUdQRms3QkNnK0ZPTFFGL2JH?=
 =?utf-8?B?WGdmcWxDRkJzamZuWDZ2SjVpUlo2bks4SGlXZzBoNWFGQkx1VnYrbVU5eVZQ?=
 =?utf-8?B?ZzA1WHUzak1haTY5UXlpL1JYSVM1bDlTWmFVaEhZaFlkUTRKNlVKTFc5ZE1k?=
 =?utf-8?B?ZkZKZXZRckxVUVcyL05pTHQ0bU80QlhpbmF4WDJWTHNkZ1lsT0JYb25NRTJ2?=
 =?utf-8?B?eTJBeDB3WkYzd2Mzeis3bXJidjBwc1VaaCtheXpBTnMwOStwYUMyUVhhWTNu?=
 =?utf-8?B?aXNtV25LVnBySmdjdVhUNUxOQXRsOGFSMEtUanZoV0MydE1Ham02Y2hrY3Ny?=
 =?utf-8?B?dnZwSzNnaFl0ZEpuWGc2S3NBTVRUbmJtcm5ramxtTDBBNXdFSi96WnNRVWFw?=
 =?utf-8?B?Slp6Mnp1Wkc4SUJpU3hTVG1ITjJwbTBCSjBZZlVqYnlpMXJJR2RERCtnZnNj?=
 =?utf-8?B?V2k3UkVzWnhPNXBnOVJNMk9HTERtZUJ2VnhHbkR4WENWbmhERHk5VzVVR0RD?=
 =?utf-8?B?WEpyNFlCc3hUMGpxaU9jamg0VnJoeEUySFprNGZ5ajRJV2dOeFR2QW5xZEZV?=
 =?utf-8?B?a1hWQk44dVlpRkRvUzB1eUVwd2lrOVJwTHVyY3FXdXFmcjJ1NDlUa2djSXMz?=
 =?utf-8?B?VUhWSDFuUVRsUS9hbW5TcTBVSElyVXJ0cFpGa2Q2QlpKWlNLZFV5UDl3NmhK?=
 =?utf-8?B?Z2Npa1BLYzFqT2lSZ2IzT29IZHNUZlpXUFYrN0cyZmNoeWVidnpMRUNpRFNa?=
 =?utf-8?B?WU5DVUMxblF6STNDblhDUWZJUm9OdGU5Qk51TllYeFpVOUQ3R0JsY3UxbUp6?=
 =?utf-8?B?bCtsMlJ5VFRXZEVrTjJ2MWhVM2Y2c2E4QjVsNmJBV2NoR2JPMmpWWDk0Z2JU?=
 =?utf-8?B?NUcyMmxlYmdINEtrSTUrNmt4M0hxS3NUUWJxazQxWVF6bERpeUNuYmZtSTda?=
 =?utf-8?B?cGRVazRtYnFUMDJjTERkZ0FFNzY0b3FnbTNublhwMzBCejBuWkRBVlpUWmZx?=
 =?utf-8?B?WUVXK01JUWRSdEVnbTg5d1RyUVdIbkdVdkNSYUhSOWMyRW9yVUlRSVlwRjZo?=
 =?utf-8?B?VTYvZC9LcGVGR0hWS0l5TmVuYjF0bmJQVzJQU1FLQktZU0pqb0JiVXgwRVBU?=
 =?utf-8?B?ZWJ5VHUxVEJpbTVNanRXakJhaWw0MFplUzF1SkgwRGVoa2kyZjR4UnpMRGZV?=
 =?utf-8?B?ZDdIcVlHTlZhOUNVUjRpRVBtL1Y0ei9tTnZuTXRNQVE3b1YySUlmUVdJWStZ?=
 =?utf-8?B?YlEwNFVGNHNBeVR1eXlYSnlkUWU0VnFjMmtjWGQ4UFc0R3NBYjN2Z0RJUDNv?=
 =?utf-8?B?N09mT2VHdHM2SEZHMzE0V3FIbm9DeUZ5YkZzVEVSV3EwZk92ZkVmZFkyTmJq?=
 =?utf-8?B?SXJ3Mjg1Q0swQWR3amhENEFwbVNBdDMzUFJZOTREaGxLS2xXd0RESkp1QXVK?=
 =?utf-8?B?KzNZS3EyVFdwQi9lYnc0ZU9HTmtyUVQzTENXZjJqbThvbDJwZUhzc1F1UE5Y?=
 =?utf-8?B?c3gwcXVFbVhLdEluRWw1cGU4MW01UzBZRlRVUmh0TGszWHVFRmdwU29LUHZS?=
 =?utf-8?B?VVlFbGhwRks0ZDBiNW51REszNG5HNVpMU3ZmNEJ2K0pPOUdCZEVqNHBnUFFR?=
 =?utf-8?B?TkxmSWVjNTFORHVGSERTUm56MW9QbThseCt3U2U1T3A0U3hBcHlBbU9xWktB?=
 =?utf-8?Q?fe5dgU2OjXSMEVDY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <350AD85224AF224E94CB49FB0EC6CD9A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7aae2c3-8943-409e-aed0-08da2204dda7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 13:02:31.9689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JnMJRQCpWjRVcmU11NxzrmxAXosDE6dUrotINzgRJC0fnXdV4CdoiInF4svOTxy/XqoCGIAtbXcdb0tNpX4pFX3Zh2uBCKqy0ikTpdNbgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3384
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xOS8yMiAxNTozMiwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMTkvMDQvMjIgMTI6MDhQTSwgVHVkb3IuQW1i
YXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gNC8xOS8yMiAxNDo0NiwgTWljaGFlbCBX
YWxsZSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0K
Pj4+IEFtIDIwMjItMDQtMTkgMTM6MTksIHNjaHJpZWIgTWljaGFlbCBXYWxsZToNCj4+Pj4gQW0g
MjAyMi0wNC0xMSAxMToxMCwgc2NocmllYiBUdWRvciBBbWJhcnVzOg0KPj4+Pj4gVGhlcmUgYXJl
IG1hbnVmYWN0dXJlcnMgdGhhdCB1c2UgcmVnaXN0ZXJzIGluZGV4ZWQgYnkgYWRkcmVzcy4gU29t
ZSBvZg0KPj4+Pj4gdGhlbSBzdXBwb3J0ICJyZWFkL3dyaXRlIGFueSByZWdpc3RlciIgb3Bjb2Rl
cy4gUHJvdmlkZSBjb3JlIG1ldGhvZHMNCj4+Pj4+IHRoYXQNCj4+Pj4+IGNhbiBiZSB1c2VkIGJ5
IGFsbCBtYW51ZmFjdHVyZXJzLiBTUEkgTk9SIGNvbnRyb2xsZXIgb3BzIGFyZQ0KPj4+Pj4gaW50
ZW50aW9uYWxseQ0KPj4+Pj4gbm90IHN1cHBvcnRlZCBhcyB3ZSBpbnRlbmQgdG8gbW92ZSBhbGwg
dGhlIFNQSSBOT1IgY29udHJvbGxlciBkcml2ZXJzDQo+Pj4+PiB1bmRlciB0aGUgU1BJIHN1YnN5
c3RlbS4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5h
bWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pj4+PiBUZXN0ZWQtYnk6IFRha2FoaXJvIEt1d2FubyA8
VGFrYWhpcm8uS3V3YW5vQGluZmluZW9uLmNvbT4NCj4+Pj4+IFJldmlld2VkLWJ5OiBQcmF0eXVz
aCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQo+Pj4+DQo+Pj4+IEkgc3RpbGwgZG9uJ3QgbGlrZSBp
dCBiZWNhdXNlIHRoZSBmdW5jdGlvbiBkb2Vzbid0IGRvDQo+Pj4+IGFueXRoaW5nIHdoYXQgdGhl
IGZ1bmN0aW9uIG5hbWUgbWlnaHQgc3VnZ2VzdC4gVGhlIHJlYWQNCj4+Pj4ganVzdCBleGVjdXRl
cyBhbiBvcCwgdGhlIHdyaXRlIGV4ZWN1dGVzIGFuIG9wIHdpdGggYQ0KPj4+PiB3cml0ZSBlbmFi
bGUgYmVmb3JlLiBBbGwgdGhlIGJlaGF2aW9yIGlzIGRldGVybWluZWQgYnkgdGhlDQo+Pj4+ICdv
cCcgYXJndW1lbnQuDQo+Pj4+DQo+Pj4+IEFueXdheSwNCj4+Pj4gUmV2aWV3ZWQtYnk6IE1pY2hh
ZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+Pj4+DQo+Pj4+PiAtLS0NCj4+Pj4+IHYzOiBu
byBjaGFuZ2VzDQo+Pj4+Pg0KPj4+Pj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIHwgNDEN
Cj4+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+PiAgZHJp
dmVycy9tdGQvc3BpLW5vci9jb3JlLmggfMKgIDQgKysrKw0KPj4+Pj4gIDIgZmlsZXMgY2hhbmdl
ZCwgNDUgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210
ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+Pj4+PiBpbmRl
eCA2MTY1ZGM3YmZkMTcuLjQyNzk0MzI4ZDNiNiAxMDA2NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMv
bXRkL3NwaS1ub3IvY29yZS5jDQo+Pj4+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUu
Yw0KPj4+Pj4gQEAgLTMwNyw2ICszMDcsNDcgQEAgc3NpemVfdCBzcGlfbm9yX3dyaXRlX2RhdGEo
c3RydWN0IHNwaV9ub3IgKm5vciwNCj4+Pj4+IGxvZmZfdCB0bywgc2l6ZV90IGxlbiwNCj4+Pj4+
ICAgICAgcmV0dXJuIG5vci0+Y29udHJvbGxlcl9vcHMtPndyaXRlKG5vciwgdG8sIGxlbiwgYnVm
KTsNCj4+Pj4+ICB9DQo+Pj4+Pg0KPj4+Pj4gKy8qKg0KPj4+Pj4gKyAqIHNwaV9ub3JfcmVhZF9y
ZWcoKSAtIHJlYWQgcmVnaXN0ZXIgdG8gZmxhc2ggbWVtb3J5DQo+Pj4+PiArICogQG5vcjogICAg
ICAgIHBvaW50ZXIgdG8gJ3N0cnVjdCBzcGlfbm9yJy4NCj4+Pj4+ICsgKiBAb3A6ICAgICAgICAg
ICAgIFNQSSBtZW1vcnkgb3BlcmF0aW9uLiBvcC0+ZGF0YS5idWYgbXVzdCBiZSBETUEtYWJsZS4N
Cj4+Pj4+ICsgKiBAcHJvdG86ICBTUEkgcHJvdG9jb2wgdG8gdXNlIGZvciB0aGUgcmVnaXN0ZXIg
b3BlcmF0aW9uLg0KPj4+Pj4gKyAqDQo+Pj4+PiArICogUmV0dXJuOiB6ZXJvIG9uIHN1Y2Nlc3Ms
IC1lcnJubyBvdGhlcndpc2UNCj4+Pj4+ICsgKi8NCj4+Pj4+ICtpbnQgc3BpX25vcl9yZWFkX3Jl
ZyhzdHJ1Y3Qgc3BpX25vciAqbm9yLCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3AsDQo+Pj4+PiArICAg
ICAgICAgICAgICAgICBlbnVtIHNwaV9ub3JfcHJvdG9jb2wgcHJvdG8pDQo+Pj4+PiArew0KPj4+
Pj4gKyAgICBpZiAoIW5vci0+c3BpbWVtKQ0KPj4+Pj4gKyAgICAgICAgICAgIHJldHVybiAtRU9Q
Tk9UU1VQUDsNCj4+Pj4+ICsNCj4+Pj4+ICsgICAgc3BpX25vcl9zcGltZW1fc2V0dXBfb3Aobm9y
LCBvcCwgcHJvdG8pOw0KPj4+Pj4gKyAgICByZXR1cm4gc3BpX25vcl9zcGltZW1fZXhlY19vcChu
b3IsIG9wKTsNCj4+Pj4+ICt9DQo+Pj4+PiArDQo+Pj4+PiArLyoqDQo+Pj4+PiArICogc3BpX25v
cl93cml0ZV9yZWcoKSAtIHdyaXRlIHJlZ2lzdGVyIHRvIGZsYXNoIG1lbW9yeQ0KPj4+Pj4gKyAq
IEBub3I6ICAgICAgICBwb2ludGVyIHRvICdzdHJ1Y3Qgc3BpX25vcicNCj4+Pj4+ICsgKiBAb3A6
ICAgICAgICAgICAgIFNQSSBtZW1vcnkgb3BlcmF0aW9uLiBvcC0+ZGF0YS5idWYgbXVzdCBiZSBE
TUEtYWJsZS4NCj4+Pj4+ICsgKiBAcHJvdG86ICBTUEkgcHJvdG9jb2wgdG8gdXNlIGZvciB0aGUg
cmVnaXN0ZXIgb3BlcmF0aW9uLg0KPj4+Pj4gKyAqDQo+Pj4+PiArICogUmV0dXJuOiB6ZXJvIG9u
IHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UNCj4+Pj4+ICsgKi8NCj4+Pj4+ICtpbnQgc3BpX25v
cl93cml0ZV9yZWcoc3RydWN0IHNwaV9ub3IgKm5vciwgc3RydWN0IHNwaV9tZW1fb3AgKm9wLA0K
Pj4+Pj4gKyAgICAgICAgICAgICAgICAgIGVudW0gc3BpX25vcl9wcm90b2NvbCBwcm90bykNCj4+
Pj4+ICt7DQo+Pj4+PiArICAgIGludCByZXQ7DQo+Pj4+PiArDQo+Pj4+PiArICAgIGlmICghbm9y
LT5zcGltZW0pDQo+Pj4+PiArICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPj4+Pj4g
Kw0KPj4+Pj4gKyAgICByZXQgPSBzcGlfbm9yX3dyaXRlX2VuYWJsZShub3IpOw0KPj4+Pj4gKyAg
ICBpZiAocmV0KQ0KPj4+Pj4gKyAgICAgICAgICAgIHJldHVybiByZXQ7DQo+Pj4+PiArICAgIHNw
aV9ub3Jfc3BpbWVtX3NldHVwX29wKG5vciwgb3AsIHByb3RvKTsNCj4+Pj4+ICsgICAgcmV0dXJu
IHNwaV9ub3Jfc3BpbWVtX2V4ZWNfb3Aobm9yLCBvcCk7DQo+Pj4NCj4+PiBBZnRlciBzZWVpbmcg
eW91ciBuZXh0IHR3byBwYXRjaGVzLiBTaG91bGRuJ3QgdGhlDQo+Pj4gc3BpX25vcl93YWl0X3Vu
dGlsX3JlYWR5KCkgY2FsbCBiZSBoZXJlIHRvbz8NCj4+Pg0KPj4NCj4+IEkgdGhvdWdodCBvZiB0
aGlzIHRvbywgYnV0IHNlZW1zIHRoYXQgZm9yIGEgcmVhc29uIHRoYXQgSSBkb24ndA0KPj4gcmVt
ZW1iZXIsIHdlIGRvbid0IGNhbGwgZm9yIHNwaV9ub3Jfd2FpdF91bnRpbF9yZWFkeSBhZnRlciB3
ZQ0KPj4gd3JpdGUgdGhlIG9jdGFsIERUUiBiaXQuIFByYXR5dXNoLCBkbyB5b3UgcmVtZW1iZXIg
d2h5Pw0KPiANCj4gV2UgYXJlIG5vdCBzdXJlIHRoZSBwcm90b2NvbCBjaGFuZ2VkIGNvcnJlY3Rs
eSBzbyB3ZSBjYW4ndCByZWx5IG9uDQo+IHNwaV9ub3Jfd2FpdF91bnRpbF9yZWFkeSgpLiBXZSBy
ZWFkIHRoZSBJRCBpbnN0ZWFkIHRvIGJlIHN1cmUuDQo+IA0KDQpCdXQgaXQgaXMgc3RpbGwgcmVj
b21tZW5kZWQgdG8gY2hlY2sgZm9yIHRoZSBXSVAgYml0LCBpc24ndCBpdD8NCg0KY2hlZXJzLA0K
dGENCg==
