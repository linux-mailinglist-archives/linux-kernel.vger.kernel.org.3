Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89434573850
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiGMOFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiGMOFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:05:35 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30BD31DDD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657721132; x=1689257132;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=M983RYJnxHo5v/vBvRs9/z+utWNFpFViWwyFatlml8//R7Thfxmf8L24
   Gm5yTHQ0PbPwjFtfVw9m5kjnYdf9IQxyAxzTw+sYw5oq4E8WWspuPIXXW
   pv9k9JHDAzScz1qlVssrnqVZLyBgzP2u96qOJOQBIh36T3SKcjMPyCOte
   l44qnBj0jHcBo+2R6S+SYiEiOd7MZtDZXz66D3hv+FupLu5UAbws0PS8j
   T7DRFRYvCaF+vPgIwUPjgIF4AHXTuxquWKTaIxZbrwAlmNaeToFEv4/ci
   Z84bg7MbWfF0lPE25HeN8J66x2PxdMeoFG6GKQiNWkGImC+wSfDGIty9r
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="204242545"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 22:05:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVGUC0lgtOILrtheRGJzHtHqU1yCvo69c10HoZe/JQ+1YfmB0hZzhuAEeX3fzVH5FwpJyMeqMlwX400MmDBCwKPOTltwHOdr+yJcrx10a9VYW+JSNXV2iIcPSYNvA239UVJGf/GyK0pCua0PES23KXtD3gFt0b5rJDeu70cgnRm7fqsY4NEK2pTtRaGqyrMrV6FVobcIPrOj4IvQKp1vOmCXbNRAwd5AbaVe3FVFnm1KxowmjYGax1INLtxZmt48ft6njsPEeMhqu25gmsdk8ECPHWs8VTH4STANGRo05aAMIREbFJMeLzUudzRii9UIKD5ZdzAT6B/tPfRN+tf7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CvFcN/xh8ipyAK45Pme1cA1gtT+78lyUHfDOkLi+gZyPiGz5Bri3YuGa5kbbuYuQmLRJpbrgbhuVNAaPK+kovZ5y88N527vXA+RALgipN2+UItZMcGhwDueuVZsGEXxYM4dtdTB09luQwlgfSRtFVAWACgpm3+1AG/9c79iGDJlQQJV9ltcWVD/bAGkhl+Va8ZqbyyWU0BNv6anGPxn5A6d/9w7SQ4CJMSt0d0bQdKFvvqT5AOWrMue5tV1fAUpAckrgGoqYA1C8pQKXAc7w6aNr3LQo8jCxxpJ2lUJooOpC49w7jSatiwbHlGi9K6W3UVWNoMlH7yogV8vVB2KdNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XLwEoe6E+kSWdTUd15GqdGkGEK/U7vGxtu43iHh6FdbB4Y23S6GbDMTb8NhdRuFAvMm4X574EC13X4gWN1RgDK31Vav1jOR8YJPb//aKs6VOuoyayG3IX63FvgGy5q1bAX33h0yM8b2uTygq+jIi4pDNSnd8YrWMjSHJ7P4G4FA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6933.namprd04.prod.outlook.com (2603:10b6:610:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 14:05:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 14:05:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "neilb@suse.de" <neilb@suse.de>, "jack@suse.cz" <jack@suse.cz>,
        "willy@infradead.org" <willy@infradead.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] writeback: Cleanup bdi_sched_wait()
Thread-Topic: [PATCH -next] writeback: Cleanup bdi_sched_wait()
Thread-Index: AQHYlrflJxzM6cohnEOO6d3eUt5F7g==
Date:   Wed, 13 Jul 2022 14:05:28 +0000
Message-ID: <PH0PR04MB7416A3BEC24B9D471FB79A369B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220713125314.171345-1-xiujianfeng@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30bf46ba-e191-437c-647e-08da64d8be04
x-ms-traffictypediagnostic: CH2PR04MB6933:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UyvL/V6UPPrnxifQn+25EQZKX6VnYLGMH6wN3yUphAkSMCvSClPceKbu3HoG7wBAmUVFKBWhHqB26OxEqljoFk0Teu+Oq2wURYdGa8tD/tsrr662+04jZscNR0uwe4ymqxIEhgvcT4EVszBatYqrNtlTegqYafyzc+hAo7kfFl6hOpK7kz9tcYJc8BRHuG0K6m6PHak+QB7+hNul+LWdNI8YrWLHawrIFLhnole/2+yUXJ4uz/Lo4tqBk6uhKu706vx7M6Ou4dvQxkT92X0TVvBB/uaNtbpkfWMyuOV2Yl9mikeqZsIrwFtmGNljfTrZl4z9LTH2JaIcbHcH6XOcPVZ2FL95+g7bUpHkj3I7XC9f57U1ELxpnrRzmSJIRFHjblDHeEuzP9pdTyC97n/2+xFOVD2PIkCUCsNo+OY5IzoVZ7QRDOp4iDUqIA8bmdiRbg4fQlZd1tSkUdz6kGbOmnC61ROiZCZ2MTwGMEp3z/Tc74t19djjGJddnpAQL8HvWr03nrxQOUQ/V8INs2kmBAoryHcwTMpNJjgToWqpBCHGv5MSHZQXnnUUvmX0h80irfLQIx3Cs6W84Ye5BsKLKwjIHv9ABG0Q5f2LGbmvr0ezHKoM8u5VlHPuXjgFYU/sWFqdFdwZ6Om3LZKpAS6uGrKFaqbxyOwuLiDEUtEPyK/DBqGLmDRdVXfQG+RvepQcIPFCtrW3LMdO0hMiX4QvX5twCtaTI0WraSNzD4qT646RdeTNHsegX1MpLsHHww+o+kxt1jP4ll1cEM3/IGtOuMEV0aYrejUsMlZg3jPOgQcI4Ri/kWs5sT1NhytDtav
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(55016003)(19618925003)(186003)(33656002)(38100700002)(2906002)(6506007)(110136005)(316002)(86362001)(66446008)(5660300002)(91956017)(52536014)(66476007)(66946007)(7696005)(41300700001)(38070700005)(478600001)(8936002)(76116006)(8676002)(64756008)(66556008)(122000001)(4270600006)(82960400001)(9686003)(71200400001)(558084003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6RCDwXh13cZbNKDk80Ei79QtH4JZ9WxyDjhYQNSuCMxtP0DXEPLlZCx5GoXU?=
 =?us-ascii?Q?am/YCpJUo444R3iYB7fsIhy02Mdh2zYSlWWjVqN9pcd8fEILavOGgfifjb/p?=
 =?us-ascii?Q?cdL6Trudgtzu55ca68IrAJgxlmS33b/kBTS3nreuxQqPl58yO8Ld2+51zVpr?=
 =?us-ascii?Q?APIGH7rtlqCF+G3RVVF3Es/sCv8CK4wWzlCt61YDR3imedUtlzAKzEra0lbE?=
 =?us-ascii?Q?dHzVb8+/4u/N1tbkm1dU3xw/44+RQu3TFWLXkxtLeBzXwmfH1Epl0ia60jWA?=
 =?us-ascii?Q?DBA2ErijLRPJXna1KXeARqcW9P6eOgMwiI0YeVhch3FydmobD6Orob8wWTzX?=
 =?us-ascii?Q?eLdq/j/obp6ae9CIFKOAw3qr34Xo6oxZ1DDHO0q2eFuoWR70ZHA7zx4hYVTB?=
 =?us-ascii?Q?8oNTNw5osSYXEYcvsRZ11HkZglExAgiq4CGDKmR6FJbKO6hdHBB+NzgLcgr3?=
 =?us-ascii?Q?s1/zNvhDUe2qc+I6vImkqLNWX+bY370Xb7Gw03zcnurUEzuLetvfwax0Htuv?=
 =?us-ascii?Q?2DC6GiqHxrS6SzmLtsQUw/fDCbU62NyDOBAc2IM4QW/zUSX1EsNKjOPIaNNF?=
 =?us-ascii?Q?L1R191MwlDmz6iQHuZ5l+hNqc1NIYQMpccCav/lw6hZEdNYirhOFYysP0B89?=
 =?us-ascii?Q?QdqbAendY2+TbXl1PvVxjqDpzsjQUDU7NnExUBM8whJohrIzAryGq3VygdLt?=
 =?us-ascii?Q?ufJ+JgpjLlX0yMGB6LPK7OzdH8s9Y3zaN4H6Ymg51NagwswsuyobwWMjz0RI?=
 =?us-ascii?Q?PTMqorcJbDmbhkIpSgLp2d6NgrLLlLq1W9t1cKfPIKr/3OWLnYNi89xKDYYq?=
 =?us-ascii?Q?PKJAaa2ydk4GtqGoUz4qAIdBCU+/k1tesnM93AGdRsY4jZ37E2sFlZJ/K/uY?=
 =?us-ascii?Q?jdrD9Pi4EvsgVLUGXoXtoaL7/BzNpdLEwb4JKvNIDt5dNxIZ5Q5cdXf7q9Jh?=
 =?us-ascii?Q?8ipsoqYPer59voJoGEKFbPyrXDRY+v34qO6AEsuIODIOEFdG/XIws3D++1uE?=
 =?us-ascii?Q?nPal605JScAO1AS1X4IFPsqh2ctTP3EGyueQaaUZBiSJulnJwV9Y/oebxi7+?=
 =?us-ascii?Q?fTB3go7p3Xs1G0sT5ElON/cfQTNiYV9dWYOl02mOofJQ3xdI2RurltQoI2zA?=
 =?us-ascii?Q?I1OXpKLFRyFgOkE7bJHR+B4CEYtgGoMpONEeYbO6TCvec19OtPyVkspsvFDa?=
 =?us-ascii?Q?1Ph2OtrVkKjEgS67PlWqHvRrY6TG1lzlZB6RFXmy7cum/dg6/jbmbEsIE1kM?=
 =?us-ascii?Q?MGRPAEkascfuMQjd9n1t6YMsxa8clORy/0KT0HOIanCjICIozupzyZ4it1VV?=
 =?us-ascii?Q?28KmL4psgq4ruWNm82m8ZIne3B5US4OZ7E1q+FIrhvEM7RsRdoUIUFP4acFk?=
 =?us-ascii?Q?RfsB9UKXByVj77dm4yXZX9Qcb124R1bsXZT4uQ7z6rY6tF9LHJrfoqidWLDm?=
 =?us-ascii?Q?VxEkmgrKvqAAOwDCG1u9DwReD/KVaEqyubpM42qny+2ZF1JCIBHYkFoBkj5n?=
 =?us-ascii?Q?SN3rzWAMNrcAGTf1RwOSiHbPSDqUuv8P8lXYFCcPIYo2Qb6TBLyGYkA3IH+t?=
 =?us-ascii?Q?pyC3pMK8bcuYfpDaH5Yfu0tQYn4sjcYasfM4tnXw/obJ3hRojtJQ2q67vD7D?=
 =?us-ascii?Q?MyuXA3n5fSBu2dIwhhxelqRZ1YbDcDc6jYiJWqAziveYZBYSxKytmmp9sSTz?=
 =?us-ascii?Q?QTyXPoMUu1j49bG/+iXiFVtzHBU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bf46ba-e191-437c-647e-08da64d8be04
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 14:05:28.9706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPtUZ3tRWL1qj2vQCoM3U91txY/s6egjSbhs1Oeegg+Af6yebjUnPJGxth72TIazQlMTjKjNuLX9AS4d5AmihnYRLbg+AN3JieREO6BeUWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6933
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
