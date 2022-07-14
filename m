Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0788F574788
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbiGNIst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiGNIsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:48:46 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53F0658B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657788522; x=1689324522;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=qsikBUvLfkTQ4je85Hb/RCDB9X6hOG46QsVKDGKr2f1c2hhEOzJpMVqz
   5tXRSE9hXL3g+WaEfNwBwvqIXkf4YSBlPOiyy1Xwy7v57KgIacV13LO/V
   WX/VYw0pomANZPk7LnYlu6lbJDPW+tfnz9RS5QC59gMTlW7N5h0qP3MJw
   LT9T90wQAinzMIoFYSmo8CF7Pia1JCEYbkvRyqSEFU3uD5UgyEGmEh30R
   6yy2ksnOuEa2A8V9pWpPkytnQhjFEvLkmP7iXGrHLlu0J9zzZ3UBWWOR5
   Z5PsslMPtGSPpV27/nfyiBrvn2o7kR2rKFI3U3BQp3+ZPeIroY1Km52GF
   w==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650902400"; 
   d="scan'208";a="210656180"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2022 16:48:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdOcXpvy7VzZcYIVdU3qmhFnbGRf04FcuFBdhCEDfSaYIa/oFV9oUKgrLcLi22o6/9JfGWo6maO9aNl28EnJ7HsUnWvfm+vZzqnWSTZIy9PqdUJPdUL51R0VbtYagPctgMUCYI54ZjTER4d8ACnzk2kzQsDIJuKVvQbVRaJgQZwpGJUOQwvIQy1JxGlLfe8xX18iilDyONuuxWBLyLK43N9XNL5V71492urJxlSDgSNxHeiouWqJrcxketh1jOPQLiELd8MlpVnlleWdM1s1QJIbZLR+QvsDV/5707Hf0Jk0H7iUbewukkE8SRu1tR9HNJJmgwJO6ezp07GLZUd6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=e8+fGpKekBTZynBpxy7OC+bN3A7y0fyXKcmg2mqTYjWt4sJlQzc149NbG26qXtGT+uouQnPaeYJdeNqRqF8CPJd6Z6/e0aEojHiVd9Auc5NZcSk3Zltkr7uSAcxHy/idCdw5vGOI3X/V0WVE04Q6p7FK6G8NGbro7rzz4i39Tdw3ytxbdUrX5Z4SvcjzanKZ5QmbDTO35v5ECpMooOJ2hCp+wJH8D6gDCB/Ls6XNd3x9ceKg2MQpkBwWcVEiDdS+m+Yx/XfwtJ3A+pZ8NSTg2bwVfg8k6B2yjYMCXhg1v1SxrvJsfgidNqYTRtWqk+0hCTecMlKNOXU7B0DOGQmu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=HgbOTlFt08gZXk0B3YTMG6b3qvIrpdHEMH7TP5gKeUXwP9LCT8xshz12j9vY7auRI/a+j2c8UZx6FDDvr5V/CR1/wU0xHSDJJs5NVupuGZxASjFKAFY62Yjwfew0raUIGjIs5n5j1uuAkKQjK9seOSXT3n9DjmG1P9EOKm47/Gg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN2PR04MB2240.namprd04.prod.outlook.com (2603:10b6:804:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Thu, 14 Jul
 2022 08:48:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 08:48:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "neilb@suse.de" <neilb@suse.de>, "jack@suse.cz" <jack@suse.cz>,
        "willy@infradead.org" <willy@infradead.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] writeback: Cleanup inode_to_wb_is_valid()
Thread-Topic: [PATCH -next] writeback: Cleanup inode_to_wb_is_valid()
Thread-Index: AQHYl14Y5owP5kvUbU2UGujuXzIWNA==
Date:   Thu, 14 Jul 2022 08:48:38 +0000
Message-ID: <PH0PR04MB74169B82D808AFFD14CFABFF9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220714084147.140324-1-xiujianfeng@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 640f4e3a-35ad-4b1f-d196-08da6575a538
x-ms-traffictypediagnostic: SN2PR04MB2240:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GJ2wDhoiSMrsC/M1krXMl0d4y2mfMdyiCOkhL9YxHb7pVOXcDoIKC57/ZTQ+s1JCiCO6Fy4iHpCCkg8MH8xrJNz2344TiiV+uF59X8NRW8CjLuV6vO5+brTpRNO2YuhFNlW0y9pIkhcjncnxD/pUOyiNW0ZCTBQLXtWniJOTQFI/HRKoqngd1fKZ9IynNGmeJq/mcv+dKyy+YyiA27mx6RTs0GdXcQ/jj1gJxCCJWYJEmniQAzPhixUWh6dL2LaZxCVUKZnDSxjW8PlmZg4ls+6au/5y+Rh+kSdmFCaQnPWQgyA/dobEUwlFx2EzOfLGCGknqHNrrwGDYuiKu3N2M43JTcQhLegjBFAmp+w5Ntf30i/GeFf8dy14Yu/MzV72BQMoNiFyAy6BvhiFKTnMrWfoavttIeT4itANL0lUkRGO10THb7OQDLULKFUcmZ9M1tgT/YS7fhKK80ZP+H7g/j2ORf/f+3BbotvbJYXwgY/Uof5PBQMnFzVRm8I7bKuI/O1gcKtqCu8QU1TI2OX4IZMH5mhsLWZFJvBbjDchSO75ki64nd/E+ja5+poTOrHKBLUcLt1ylkNpLLcqmjN+bVFl1mSxa88END3S5R50zm1yOGAFTruGJxpMhFvxrHU8YltGdXITr/fgT4riP1Lvdt+HtGAcKHFuzwM1S5WK2B1jjT+MY6grSPU3whK4zq70SBJUNvAhEive8YcOdjzF4oLg2jutavI/3G5zSG2MlBbKfZY9nADuZ4sTACAfsCiLeS5jZNuYl4QLVmcpcUEQnqwHuZL3wxAKP2Bd24jgvG6vTPwjeEqmuKbUpJNDAMdy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(66946007)(7696005)(9686003)(8676002)(4326008)(71200400001)(86362001)(76116006)(6506007)(2906002)(110136005)(41300700001)(4270600006)(64756008)(478600001)(82960400001)(186003)(558084003)(66476007)(38070700005)(66446008)(26005)(91956017)(38100700002)(316002)(122000001)(5660300002)(33656002)(19618925003)(8936002)(55016003)(52536014)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RyRksdCZGEVl89XwQrnGFqrF5Hbs/z0pNPaV5JDP+ystlh8CxYMZoOT1Yuty?=
 =?us-ascii?Q?H+Zw1GpMyjD7E3CdvEctwyvbgbI6TPdotb0DubtURzOt8yu+VnhmVCkuzPNd?=
 =?us-ascii?Q?1TzJJ6+ZbZTqhBJh5ok56VnCuG/ojHR54jjw4SBVsrYcr7F8G6P0MqyyHE9k?=
 =?us-ascii?Q?Zqap4TIFVmggI7Zvher8r3IK6Z7eqSmP3OHa72ePERsu/cjZpg7xYZbz01Xq?=
 =?us-ascii?Q?H5LocGcag8XoPbPIC4aj7wkCK482pPchCmN9Pf4UIHmfM4m/2lh8jSXQ2EbZ?=
 =?us-ascii?Q?kG0B4FjRS86/P35eKM88xAonQhpomlbLehIsWzA46P8O19HsNbyIRToAvvVx?=
 =?us-ascii?Q?r84AA/QNepWJJLz0V7D9pdfdGsKOCDAPYyx9LiBY1qheGCrZ5kwl1gEO0HGs?=
 =?us-ascii?Q?0zYwlYMV3g8nhFlrY92hu5VssRLAJzQ7yb9sLZLVN7aQE4lKuLchBpsEOADY?=
 =?us-ascii?Q?vHcKB5JaJJQ41nCHRcSu5tzIkXzJMYJx761AB5knJ6dS+nK18CGH5cwjUble?=
 =?us-ascii?Q?LFLFgQUGvPBdHCJlMz6TLi/9llU3C/RUuiUx9A9hVz4kJN1jvf7TovSeYSHf?=
 =?us-ascii?Q?1+wspAIL4uM0vgeXwq/0uaqE47yccUZnvm9iNBFog6JQ6eItGyzjRKQ20Epn?=
 =?us-ascii?Q?h9YNpfRlp1ybREN1F2IiSj7+O5DKdrPlutua8H3ZHNG9xgihOBzBsUcbLliq?=
 =?us-ascii?Q?m8+ztE/PbSf5zHhXhzcSIOFL3/gqa8dzQS1Pl6pVB5Ll77hmwgdy0pOxhM1l?=
 =?us-ascii?Q?lpJTHsVper+1w0aHCLZQrBsdVaIYIjpbDixLjZxqzySGVF4GGfeN9/DFQRct?=
 =?us-ascii?Q?p+pIzqobLwTOwegKSXcVe0HzjDh3E2VKBJAGskWiNAwc6fV64W5Uh7URtDwI?=
 =?us-ascii?Q?z7ux1jnFslvEEBlSXDwcsG7VKC3uHV/B8HwmbR4Ck16A3lNhyVoXygs2HAlo?=
 =?us-ascii?Q?m3rA2+2l8mVYMp32jkuzOcg78A67QNZQrN0hMNdly4S7xkRTf3j9+opuoqTi?=
 =?us-ascii?Q?uTOc9Op7YuFAZ0qefiWQDYTVDGa/isaxBDh7dHZkgweoEFRYmTuXoQk9rVoL?=
 =?us-ascii?Q?QHFUG1HE14flvLKCz+r31BWC7S5zabbPU4ZjIMTg79yCm2Sf5zduFHHm8SMc?=
 =?us-ascii?Q?kSkLnItd0jLty7v+4SXzIf8q+lDsR0A5j/ze0WR/jRWYovo433YWaE5r5V4H?=
 =?us-ascii?Q?hhMWp+wNqlwZgEP/hQ9vF4seYaVohNRPowkEabjwCB5Nl66rbNQrllxhXQup?=
 =?us-ascii?Q?myxSRtqwLh86Oj/4iCDc8kPIV8jBHV9FK607mF1ellugo8zfl5M4XhQus6Bw?=
 =?us-ascii?Q?ePz7Er6VckNzxSMp/v00hsl3XKORKro86Iend1IRgKSD/HKg8i6P6tsyBGDd?=
 =?us-ascii?Q?jCOaekl7IKITMaeZax+H5H8NUp9J7kC2mtEmBYHLUu2GMyk4OPKUE+Q+JkDL?=
 =?us-ascii?Q?pbtmPAXTn9BNCK8YGqmMyhTxdnQpx9S2u8hTzPulERVP90zCYDWvdcduEzP+?=
 =?us-ascii?Q?rlGLCxIgIkvG27jRAlOO+qoZ6FyDzpqRgqvBd0VpwR6VXHGFWpzqNGWIt1Mf?=
 =?us-ascii?Q?htpIqA8Gf4RJ5nGKacDBJDEPb88EHsZmBSHTehf8xLghO/DRx9iHGlRvkFVg?=
 =?us-ascii?Q?EHnzLTG78IhBWRChjNYbFpA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640f4e3a-35ad-4b1f-d196-08da6575a538
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 08:48:38.3576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htANNGgG65InX36uf9JEvfS8fJ8T7NSZT85NgyWQ/BReVRasjjGLA+TJtrnAJHmZLFRxnklSMyMvGPKYVlMF3RWbmgi38TYy4KeJ84wlCRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2240
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
