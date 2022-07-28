Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871F1584704
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiG1U3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1U3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:29:04 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF5A4A80F;
        Thu, 28 Jul 2022 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659040142; x=1690576142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q7xcJ5Eds4LJ5icbBu7RXKnnASnPC7dLQ8qGQowCSus=;
  b=c/uuKvtUD49oTngRaQtfrSL8vmJV8THGdKEsSYJxZ/eKJE/RxakmeyB2
   0dvYC3LmqnT7t3GA18sYQRm2wG6PWKUu9i1C8cbFNaqYg+MIfB2H6nEcL
   RjEtjh+21PUugXRwTU7+HGqrEGpZjoXIbGFsdUuQRfRzsyZtLF+vNIjmQ
   eKDWAkwlZUUbWv9PwIWiGIlT7MxqpIabWE89XSscZZsJB+prDOCPzfKs1
   wDlWYgX0kB+tiZRroKiwSvW11O47YowY60UU3keptuzEnhs+yyR9G5aRM
   g5gMNSiy+NOsE0jSwIvqRgRco0VrOVr4JGo3+6j8o50q6CL7g2I39w8LO
   g==;
X-IronPort-AV: E=Sophos;i="5.93,199,1654531200"; 
   d="scan'208";a="212150860"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2022 04:29:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2+veLzkWD8vt08YPVPkEc17JGKbBGh+XUodgeVXIqxcQftikcL3m8Ex86pJKjrYdJqLn7iKPhBXc4lY6zdb8SY0FVB0BCHE8bLOEPQ7lxXGHYldcRyFjWZZlDVepEF4IP5vxtxoCWm1mbUWz1gNLlZ4fsvrBkcz2AqcO2yvq2c88Zd47TKOebeFz12gbcxm8a4bA3dkZWbzHMqkdeZLZBzzT3AeuuuVun9/PnF9EvVCZmIyM+MUohNekZX4XpCKP0mzJ0p44Hwp0YICwQVW2uByDGKbrvBkez600XZmylinIThAu0Gctx5+MyNjaSDd0dkHFbVe/C/vNv00nAbIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7xcJ5Eds4LJ5icbBu7RXKnnASnPC7dLQ8qGQowCSus=;
 b=oU5JIqnCAzU18OG3zwSNNq31ruTIFy2YAH5H+bPqFb0jYNLcKcUJJ2pw0AdBK267nQFb57Y9E75QUhMvYppRpBtv5+zhmgpYHoQ+BJ1yCq8jWV5QozFf3vDXv4DC2yk2CXeAdapUYxrizr3STqBXuPUPXM9PAPEws2O0FE+rO0qqA+TbYHlz2qcgzgWofOP6bO4twaMb60st1h9dGfXlAkdDFxZKukJkulVlgRdTcB+87RkhbiqgoZl8KBL9OqsHKg+MPsMrFYQ9vQWPrE2V9YUSq+0rbra9ev3gUkQcp/NGg/b4Tzo6YzLVDs4qR2xZtuEDP7jnLFbRAej40WWW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7xcJ5Eds4LJ5icbBu7RXKnnASnPC7dLQ8qGQowCSus=;
 b=LH68RNpHoYEGtqmjX6krew8rX7sQl7LuApyzzx6RCtpW5tlhT6UBSufvZH5nE7NVPrFXVPtj8rYv4CE/Zovl5x3CTuaZkN+zeRH6RL5vN3vkruDbYYFXVCEtQNYGZ1SKAykcx6Am7cGTHU6m2Jr4oNn4oVzMWdBe6sCfsyu9gLo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4379.namprd04.prod.outlook.com (2603:10b6:5:9b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.25; Thu, 28 Jul 2022 20:29:00 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 20:29:00 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Chetan C R <quic_cchinnad@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH V3] scsi: ufs: Get boot device storage type from command
 line
Thread-Topic: [PATCH V3] scsi: ufs: Get boot device storage type from command
 line
Thread-Index: AQHYorRTf4NOWAGIQ0an0pcApKX9da2UIyEAgAAWw8A=
Date:   Thu, 28 Jul 2022 20:29:00 +0000
Message-ID: <DM6PR04MB6575CA6085D7EC6823A26CCDFC969@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1659034814-3473-1-git-send-email-quic_cchinnad@quicinc.com>
 <1659034814-3473-2-git-send-email-quic_cchinnad@quicinc.com>
In-Reply-To: <1659034814-3473-2-git-send-email-quic_cchinnad@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c6c5928-34d1-4d52-d5e1-08da70d7ce63
x-ms-traffictypediagnostic: DM6PR04MB4379:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VA8LY9Pwt++86VBo5OhrXzyDMkToMIi+qYWwvByMNA/gmTq1/9MX/RzC9xgvNiKtxFqcH47qNZ6aAC6g5de9YI+BZD6PUpp7nDEQawDH2MP08tWWQ7taPnn03XugZttKr4St/AeqGpos5dKzNA3+0dSwvHyGkd1CPu9qQAhDGWour6U6jhbnKRhko0iptJhkiO4Wxc4Gc5Nqnp/IJJ6lKA5NtYMt1r3ypeA+xSTYgtO5/F1gebzbC1A7wd/V/6NlQK+UGsggqdyhyC7dtOOC8FE3TgmsJ5o0RBivomdS2XLYdQEmR6G8ESj3lVWRtqIUHFnRXGHJsho1CL/1nAlFFUVM8CoVWS2a+3smxrqLrdDq3u7umcIz5P32AABwUZHe2ep52FeBYagMOOWsbsZyCTXFVjhmximcKXuqxNZz7n6+ziezpBaEDX51pI8s9EgFa+zcSsFWgO/DGQitMCvpuCfG+thmQlVuxHF5PQJP/nAnPUoDsuhcDNpAJDcKuVpwOo4pB5fMX7k2LfoJIJziHEUT/u1x2s3+DYsugAAesxNaXtuq+JveneGLDeA0f1aDuPfIv61WjWaKJww9OPpyLPFXLbvVNtJ0XY6/pYlhi9tTeWvF5/+EzKrW9LxinX1Yf7QfgCvj3zn5rYFLVPjdHFsfLwYTggZbKJDO555NHDZGykuv3U6mBSu3P9JSiJp+JUaQrKnIxcoySl3vnrcfK2WKHZFxDz1E8ZzPTkOE9rS0Ic4/VJQbFxNUG3/tdo6njPDF3P5ozVoY/xydcqeMDoplwCbkYjoFeLHl1oAZys1HLiY6syMEIzhoTMIZ8jxv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(33656002)(66946007)(55016003)(4744005)(52536014)(5660300002)(66556008)(66446008)(66476007)(2906002)(76116006)(4326008)(64756008)(86362001)(54906003)(8936002)(8676002)(110136005)(316002)(38100700002)(478600001)(122000001)(9686003)(26005)(186003)(7696005)(41300700001)(71200400001)(82960400001)(6506007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a6Ero+TuFIL3NH8vPOAQJfgYSpjxHt5+vw2yo0BFL6rTaJgejDe8L7DqlAeW?=
 =?us-ascii?Q?LLwDH63sTUXnnIR6AmzPuUKP8CKLi/1eE+ppI3u/89sVLKLjeMaFuAxnriWC?=
 =?us-ascii?Q?YOyXO4owuRjoPnRwTvcuzIr5R6ao5yDLPdFpj6nYpLd0akgL6Y+fpvs2Fskj?=
 =?us-ascii?Q?XubNUKpnsw8/E/e89R9tI88s6LN2a7FXwkI+peHK4E0p0TYJ7nexf69x7zUd?=
 =?us-ascii?Q?Q9toXXPqWiknOABqlVQlb3qU/+7IWvi4mqZMTiQqlP3jWDTXx7ZncgR0AmJe?=
 =?us-ascii?Q?oSsEfvxACWbX2lVdmELx36lNF693G4R3nynwZEiFR2R01lzQ2Hs7zx3RyzG1?=
 =?us-ascii?Q?xl2xajAV2sOv9c1GZUSWyiX00Nqsebfkfp75qzWeMdWEbhMqc6IPV0D/Ddvj?=
 =?us-ascii?Q?eJJRKkY1lkoUK9XHntj9sRDEmwJqIwwTfv+qkR759VNws2aBLa2yp4xdSMYp?=
 =?us-ascii?Q?pPaKniCBgZe3/aK2GDUi7VXea27frUdeQ52vENtXPRl2ocn70RAG9XmV9hsJ?=
 =?us-ascii?Q?kzkiPBrYb1a2ZX1g9BEv7MwmT6LZN8Ig+AFM9KkdPyFthf0n/sMrJyVQMZUg?=
 =?us-ascii?Q?FApw+kfUYj+nLpCvOh4Bcz2+fx4QIWVA7mSRvXz7zaJ0FDs8PAFNJhYaarqs?=
 =?us-ascii?Q?MHQZiCvu9uP22Ko5NzLZU6kd/9d7b5E2S+SPC9ulJsqjGK9d1a8R7OwJmSRM?=
 =?us-ascii?Q?PdqD40NXkI1n696VfBPiHFUitem1dYAm3G0LvIQhIA8EJ455+3f7nG6is8Wy?=
 =?us-ascii?Q?kUyS25fnMmwaOvry7hJeVrF04xBVZQzEIzT4G/CtB8u/A+d3vdxhGthTMzMD?=
 =?us-ascii?Q?myPOLamsvMl1TVMey5RIQmZtzCnt6ajsYGzV+tB9rwt96tDUk02IjWBzSi/d?=
 =?us-ascii?Q?2eq5Ze0S/AQ1DqXd6VAZJcInU+7cnGo31jLJGj0QQ+0X+jnG/+/AjF+WwQ7n?=
 =?us-ascii?Q?jOpWWMYP27odITkzQG6ZeWFhGDLBWZb2ai6Py5a8BvRAX7g/pZ/9cmu5YORe?=
 =?us-ascii?Q?TPQJvs/fAoxl34eXugvCoCcAMi6+WDY+TbF3w1wzRTQli5aKlVvd5NErYong?=
 =?us-ascii?Q?l8zSWL1/oNSGzkXRHJg7U3L6uxdYXm9819ydw5OY7xfO1U8oVH5kvZAUFx1C?=
 =?us-ascii?Q?S0yLzzrZyxtdjlrl5g9DH8STkwiWgYqKYEiQ4s/HgsbQzA7E/4Q09MpBfZrN?=
 =?us-ascii?Q?e2QlVjqVL/rLxxUOr6jhuzjOnvcTsfXF1ZKCbzWNixYciJ+Fv/IENSJxnhHp?=
 =?us-ascii?Q?fpQtPX1x93t0awkLyQjk4OTz7K++PIdXbc2CD2+89i14/2Ov+gyf4ws6ep9I?=
 =?us-ascii?Q?2Nak+E6pbn/RtdBAjSfh9Fhmjmvh76gtsQ25darN+SBkHrg/4Bhohc6djIha?=
 =?us-ascii?Q?30utmNWkfu23NmRTbtgld1kWrirS1usaJlNKbEOBWCkJTuxMKO6WXcNqIBWe?=
 =?us-ascii?Q?FHgmWNyldUHZdRBEjzAar5lfndRTT03+0tnjtwOvJDRxWc6S2TBeqdvXa4Fe?=
 =?us-ascii?Q?57r8XG7ldVPsrMSWYgFp6XfNr/3gPaT9qTQieCT7xf7kh0hqBSnopenwmLHu?=
 =?us-ascii?Q?w//LkgYARh992V6VqUBiJIXal/hjQzp8ldqRNoOi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6c5928-34d1-4d52-d5e1-08da70d7ce63
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 20:29:00.8650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPTsWss6LHJevBq5jKJRC5YUjeEy731TqNaO6hkGat7pUqmuDvtAkDYZz7xUoZjX9BTTTmHMXBCVg7WyReac5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4379
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> Get the boot device storage type by reading it from kernel command line
> arguments and export the same information to ufs modules.
Who are the callers of get_storage_boot_device?
Is this code designated for ufs boot devices?
If yes, maybe we should call it get_ufs_boot_device?
Otherwise, why is it in the ufs core?

Thanks,
Avri=20
