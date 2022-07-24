Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB757F309
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 06:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiGXEcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 00:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXEcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 00:32:17 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C115FFF;
        Sat, 23 Jul 2022 21:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658637135; x=1690173135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QzvjMvh6RwcQu2HdlUAUh78DApl+3WHBzwFGH47361s=;
  b=Bo6PgVr1SHBJSFmDxCChsUlP8z7gwNnQuRd/wzn/fKxEbFeAzvWg7UXm
   bWWGx1AlEJmB59E/fqg5kU+3zX6JQ2qQg++an7E5IFs41TJ7SlnvmUWT0
   l9OOTqAXxHFohSO9NOVZ/oLk+raoGazXccyPSpYAUyr8O/2epOHFwArck
   djj+vdp4bBkH1yt1y/t+fCCJ69CdFY86rNtDREGxVVJH5UDTKizaM6TRt
   iQ2PQ4quyXZ7RfNh4bVRbqql/c4gChJuOQOsEJBPOyLIISkqf1qitrQug
   x3P4X6C9moEEV8NYdb7b/S5hYYOJKEttk/UB0s4gXXQ+v/Dzn/A5fN1+z
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,189,1654531200"; 
   d="scan'208";a="311067493"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2022 12:32:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUu3BfOptk/JFPmXGlcw43O4dlxqi8dU0mwmX6OzEclRIr3U48X1tC9TFhCCVEMDjI5VnTTtY7SeuncY+0D9U+udQU2ja7c5pkBeDUy2ebdBRkNdPQ2zavjg6Wvh0qErZKICCna78F9SrZltMhxdGbU93eQmHhAmt1Cl9GdLOOgeiaRBqz2DtzgfkjAlUc0dcWGRS8SPbAIs5mtxhnJufo0jIuu2LXl2cSf9f/6VU4MPDw3WVuRhSL3DUnBX+JuRmynNk5vw0PmSsbykSTyegRFl/MMdyDdYnPDnp03VOwaN42XL7W5XRjpbTJ/UOBM9TP96cmSKYHaOooAHrMA1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzvjMvh6RwcQu2HdlUAUh78DApl+3WHBzwFGH47361s=;
 b=jJ6t3MIcS9GOm6tlTfIAaNrl7CNSDMUngFZGVCWXXLd/eo9LzZ/YTlYHeDHkR+kZ5l5kvG9hyMiNL+EO9hw7YnzDp1pErPu1DrfhicHIkuM6tc2fcodo7t7AsiF1Qii/JPeL3jVJTHWQQqmZCODP9n7mME8gNhbTDNMGTZVq8QgKbD7Fk1rDLr7V2CkM+G39ApgQ4TYuR7x8O9RpQSLk1sLvA+HFD0NtbDal8BXfErZ1ZnjFrtWItGOwMr1IdtXKf3rUvUe7f5MjTTRfuSdQwM961ZPF/B03VrrCsf5j9jv5vLKWxg/ZtQwZmADkgJzgqno+Hjr6wZ0Oj3/wB70hmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzvjMvh6RwcQu2HdlUAUh78DApl+3WHBzwFGH47361s=;
 b=DSNTXD13WONLRlNgz+bf1uoyl6GBdgI8pi/g1wyA/sl0e3WtTxrCZ2KKHTJtlZbvgOv5u2ghupLcaVosL0mQYvm3LQjaEcAvbM4nYbaDGdOiVbOCQY6deGQM+KCZanC/f7nII6EiavPpQ3IQdXHcSFWKPrnsneW7KeRH22ATmpI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BL3PR04MB8121.namprd04.prod.outlook.com (2603:10b6:208:348::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Sun, 24 Jul
 2022 04:32:11 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.023; Sun, 24 Jul 2022
 04:32:11 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Can Guo <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Topic: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Index: AQHYmz2OvInxSH8TlUq8qOHvad4nHq2M9MHg
Date:   Sun, 24 Jul 2022 04:32:11 +0000
Message-ID: <DM6PR04MB657540D8D6584C15C8701767FC929@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
In-Reply-To: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d49e08a-3d4d-479f-63da-08da6d2d79eb
x-ms-traffictypediagnostic: BL3PR04MB8121:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GS1soCKjWJ07kYo3Ok9vFFPUe+JG6LMz6MnZ+EPJjCs8BspiYnsR4GbIOC09Tpu6kHr+MJRyzrF1qWfzlM8y7w+4CeZDS6ZJpnQrSPw0kydoPLQmm/1KHzOS9loJNAlW5DRI44row6or3mir0VqFEfk456PibHSXC4lMUSAvxd6+mBcv4Guz42UESZwbU4dN/B4uhvlCpiZ7oUmhXFSqQYJOq08PNU5MxNzYRYtnF4BN8I0BMDfTpXf7vHeDwNpqb7hyJ9Ena4N+Y/Kdd0oZpeBccNHYqq5xy2PMtT2D/FKFueXcyMqBTT9niOXT83tzfml/97U+KSlX4sUKtewiy9lhroDyYSo1+Ae3gADlZ4WVP/ktUSNh7rd5RpvvuHHc0Os63oVJq0RXdyiFeh8960+Nw3PxmL5Kwd4ei1xhYVoIxw0m3gYut9TQItSZW6QkmEd808o7uX3rr5XOVLnvsXPtQdXL+pCbxK7kGPn6BzkzVdq/h73n+cMUxpXTfg/nuhHe1Rm9kn1ooD8YYO/RzBz1FTYRnCeherD838GgDIGJJCbuB7xWysRy/QE90Lc6so6L8zIFtk74f3/Q0A+K0a+cbC9CiDHdIg/9u+WVfi0NqDjgqFsFO0bLBn7Roc5pbE4LCcdW4TsvfObr1R6i4L54dxPrECL123hxzsH74wigxquxgWtjaY/O2VhuNCIx/bVio7TNfzEAR0k/UTUQ03POuDJ6k4hUwCJrCiNKL7loNCXr+sVNn6RkR2Vr5l5wdnZRa9UbVpu0rpL/XeBcDJHoAwj8Bef4hKNGn8KiFnHOZnBRaUDCUVGnzNj7k9HH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(122000001)(82960400001)(38070700005)(38100700002)(54906003)(921005)(110136005)(66946007)(66476007)(66556008)(76116006)(4326008)(8676002)(64756008)(66446008)(316002)(71200400001)(5660300002)(52536014)(55016003)(9686003)(478600001)(26005)(7416002)(8936002)(4744005)(33656002)(2906002)(41300700001)(6506007)(7696005)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6sFfi4f/EmJ0iaeA0DFTGSO8cDEHfoet7nsGuA2BJmPPrRJDupnZgk/h1gr7?=
 =?us-ascii?Q?DOuq14J1FKhabGzC6XNheTP0Ixp1E8cu0AgBO+qqGIrQta5JYf3Vc7QlfCRh?=
 =?us-ascii?Q?Yn6dPMWrrAMz+OtIgwz+xOv6rFSifrpYEEEYePtdmwsetf6qK9lb7uRtCpMC?=
 =?us-ascii?Q?dCCbH2PS5sx0Bh6kJff4fI2hgsUCtfiFyf9Hs5yGYX/NZYFpIT3mEx5aH+Vi?=
 =?us-ascii?Q?qpB/sOBSJ+wRvWFMe6+btr+L2PP+885LKPsVgRc9zKTAbANx+DhtVfejIYB5?=
 =?us-ascii?Q?eLNQf94p+W5lnz9hLW2rs7qtGPhLUcLPEYStF+8CdO8Kte6xbpO8olavF6FW?=
 =?us-ascii?Q?DayFx6LDx/SDxCnfzQlcbM1+nhsyh6iGWsGsXw/mJYjjRO1ya5JVdSpIohvy?=
 =?us-ascii?Q?Ivl6svkairy8F7Zn86q+bsBa6PsZPl8x+fedHdueVy8/ef04fRae8u7n3xZC?=
 =?us-ascii?Q?t1JkiAC/7Gt4HT+wzg09nW/UkAA7de9Epz661wB/0MOIeogS7tWuPfadrO++?=
 =?us-ascii?Q?krtrtYRaqfPCYNFUUBIhGw+912ZcoKXs5rm0jO12ZqiMMzaruJtE75rjLhzP?=
 =?us-ascii?Q?MVZkqaIC/YQkw9+l91UJodroz+IYXVReywcfxzPybz9rix0IRW3BuULF4dcl?=
 =?us-ascii?Q?/jczNBmqbuFfoFE5ouIhmdeHWZ7XAc4RCiYQ6J6vTGUb9BCDDUrKy6qOb0im?=
 =?us-ascii?Q?w9nMR9ClkdcGsGHQ0Aqtgr3YIA3gtdXkW4ZMupAA1hKxYfyqwVY1HOZ57nYb?=
 =?us-ascii?Q?Dad5Q+SUmdLbuoIXDuyQXgRMUQIE19+bHd6Kh+SrMbNQQyfYuX4jaC3sW7kN?=
 =?us-ascii?Q?ZdkCxPuJoYSHSkTUyYn72O8ISitOla+OTKqQDzWtujo4PB6WpgVLKIXHZ1GT?=
 =?us-ascii?Q?gbpLo81g4XRdI7bk2GHIjUsXGl7SwR2iWYDydmvJ1bGVDiKwofsHkfql0VOh?=
 =?us-ascii?Q?CsskFUFZiGuBcYCk89O6yCEgtb2nNOzt3gh9PVfoHUXrdNLnejH/a/GWdfJP?=
 =?us-ascii?Q?Gu0+ZkoaDvTyk9hQCIaaJcKqLz0IclC3RjZVIKS1zhj4IlMPuo/3WV/DKUWz?=
 =?us-ascii?Q?yW5ULU2vSvazLpUdq3tVlbQquFYZYaFlxhnAbdl620HoLFLMscOPy6zv8iSV?=
 =?us-ascii?Q?8dIyQWNFFbbK770GfgFy0gNne1OoaaaskpN2hC7UXtYjUyA19mEMycm0Rs9w?=
 =?us-ascii?Q?0NuFkc2RWNuSW8VpIjFps2qyQI/XbGdkBmUOXEdZIpc/EjGN92fVm3/gzP18?=
 =?us-ascii?Q?xYMZEgQhHne8ANCKZOXjI9onbxXAYWxRIxJk/YuD4CEXitwt8d+3ubww2fjA?=
 =?us-ascii?Q?y1DRLUqNcPG3R+kNNwSZt3BaUia9xJP5vC3s+JLSonExvcMDz6665nNGYu/s?=
 =?us-ascii?Q?g0pvWuZdW3sJ+qXaBpiLLqZxT1T7azwYhLWYIVtRoYEIywjbkjP3L4DN+N6T?=
 =?us-ascii?Q?MNKxT2nD4B1dgFfVT+ZnTVI4UBzeMd4vt5scjc5hpz+H0LoHc4hbSe9J4C4P?=
 =?us-ascii?Q?sy4Vjoa34SOPkZU5xFx5oSis5cYYZ3evey4TobGS2wfCjejH0zaJsXo4TnHf?=
 =?us-ascii?Q?p/6beVp/VLdcvZNOGRbfSETezE77+wFLeDhinnGD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d49e08a-3d4d-479f-63da-08da6d2d79eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2022 04:32:11.2302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hp2jOnnEC2M8lBZZmATCBGMu/vDpYarD7qnjTZ65nCdk6kiZkEApGA+kWM1x5NHcAGhvQTbPicHRdNQKaRGG9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8121
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +/**
> + * @ucdl_base_addr: UFS Command Descriptor base address
> + * @sqe_base_addr: submission queue entry base address
> + * @sqe_shadow_addr: submission queue entry shadow address
When you are editing your commit log, could you please also say something a=
bout the shadow queues concept?
And why it is a good idea to maintain 2 sets of addresses, which basically =
points to the same place?

Thanks,
Avri
