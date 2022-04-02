Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A88A4EFD57
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 02:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347701AbiDBACp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 20:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiDBACm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 20:02:42 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15EFFFB7C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648857651; x=1680393651;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V2dIRDFSahI/ztERT6gBPPMGOS+l1yRAqjVhOyR57xk=;
  b=V9DdE+KSm7hM84o+G42Dw5L9ABsE4uR9KL8H4JK/kS/+F8GBstA8NsVa
   WmRKxcTUNO40qQ0d2maQaXyD/TLaLiQyszxTZviCsJNnK208dM9mfboQM
   5BjCETyGRvq8Zg19/ps50HVscgTUPqs+bhMdY7M4xgdPvHtVydxmF4jLo
   m6GrHgoDm6a6b3+490zssZQvLmZNabPiVQAWq9/z2n3mydZkA0X2zCpql
   4pa2KWF53w/pXiFppBIBDuAKAzqmh+dw8sS78tNDKC+zOpx9rcnUn0fm1
   J09Am2UyjeQkIychCUn/HwVJIiMQWVNIadx/4yzSAlV2uV6fYGzgInhcx
   g==;
X-IronPort-AV: E=Sophos;i="5.90,229,1643644800"; 
   d="scan'208";a="301045111"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2022 08:00:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOClvg428AWos6LtJU9mh//OwvBvjnzfEJOFPKmLDKa9ZdnojyjVbt0yk2OFU4QejRW1QZDVMix8lMvjDLwP/a/h8crI1FmX5wHCYCYmQX6nnNqvCjxpKmqWLKn2w/oGoKpbX+az7pIA5soaIDYDFfk43mxP5H9AFjAL9TnJ6TegAKbpae6M+FYmlIFM5y4Vi1qVqVcvyyDyLP7PTcX+5iAR71XDgLiVQJuC6qevyJ0cui5sQIy6BfINdFLzxJmt5g2PO2io2Vhr0jQAqkIU03nB9hvZ47Us+jbNGdjjWdAHAM/1YkDAVzPy5Yij2zIuY7jrNWFRnjVykpPuu4zy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PK6stFzO04ZvBrXq4T4CLVT8XNKFwpkpde1BQqnwrOE=;
 b=KS6t5aLO2eZXdRwDF8IEWiEiTDm44JQZ9/5msDTHCx4Z3V71cWTNGip5azoy1q8Hh5SLuQpgvVBcFKyYvIjwqmnsOBPZS4dgpJXzb6YOZVbe3CDiWW9fNhi5QsUDL1H1o7nl4XTY5i6HtdUnPtBU2+IeBvzuw5MGSnCTWGSrMMKTUDZ0Cu/bCXY6GsDYLsifYmennikolNCBPdcvP2rHryLDu8U0dYwSmBL4sNJ7uK5xNdWTZ7ZhWFjC3x3kjzfO6owTsLBu7YHlB+jkzTiEoflYcutFlJTcNlyf7Hg6VdCYvmGvyEm3XmgXdeuePPK04FexpmN37qFpILcmUdx97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PK6stFzO04ZvBrXq4T4CLVT8XNKFwpkpde1BQqnwrOE=;
 b=pYEL162XuDrmeGfSUbJh+wClr24RMdOhvDH3OL7SfwrDAap7/x1ysPBB96EK/NPiJZxOW/J7scqtdBkkHxzuritXAiQslqhcRcCh2Q8aLImEEn5EvDlR1yu/fCeMfh0PV012mLetHN9+r0cgOClQGyzMYH/9hApR1RjtaCBbrmo=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by MWHPR0401MB3596.namprd04.prod.outlook.com (2603:10b6:301:80::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Sat, 2 Apr
 2022 00:00:46 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::995b:363e:8d1c:49af]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::995b:363e:8d1c:49af%8]) with mapi id 15.20.5123.026; Sat, 2 Apr 2022
 00:00:46 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "heinrich.schuchardt@canonical.com" 
        <heinrich.schuchardt@canonical.com>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>,
        "mchitale@ventanamicro.com" <mchitale@ventanamicro.com>,
        "alexandre.ghiti@canonical.com" <alexandre.ghiti@canonical.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] RISC-V: K210 defconfigs: Drop redundant MEMBARRIER=n
Thread-Topic: [PATCH 2/3] RISC-V: K210 defconfigs: Drop redundant MEMBARRIER=n
Thread-Index: AQHYRJYETsVB7pr7MU2Y5E23WZPPL6zbwDkA
Date:   Sat, 2 Apr 2022 00:00:46 +0000
Message-ID: <YkeSLG3OdeknqJUR@x1-carbon>
References: <20220330234739.1956-1-palmer@rivosinc.com>
 <20220330234739.1956-2-palmer@rivosinc.com>
 <d8a35bea-f4a0-b54d-9d2a-d1cc9b3d3e53@opensource.wdc.com>
In-Reply-To: <d8a35bea-f4a0-b54d-9d2a-d1cc9b3d3e53@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88720ec3-4941-4772-86e3-08da143bd6a8
x-ms-traffictypediagnostic: MWHPR0401MB3596:EE_
x-microsoft-antispam-prvs: <MWHPR0401MB3596B44D31321E2BDB93D357F2E39@MWHPR0401MB3596.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /aXDO0o7r7vnmeEb6gtnZiFkachYtghdmrd3gNWVo8wID9/a5rMfcjaa/NFqfa8V9LBZ7kW+NjKectjO/hxx0gDVoBiIQlbVLZfi1MkyWWljAwtWO44pbfZRwjbyaa/or1wQexyLNEGrex/3OlhNwpnvW3qmaVPhw0FwW0ivJV7xlH8O1jiCjxAJNiYwUohxY7qVY/F2du1cb7iAHMDHkNUfBonw0IAvPnoD440PboHFsFIHJE6dS3TKDX0880cFiMYT476dQlp4lo4YNC5H+wIH9pPLBFcwr8nVzqhtX8+QgoiMFcb7JYaUmE+PhdwPgOKkedWpLitppZMWoxoElwONgxKS0QjiEKF7qsJoR1hxG01Yigr2wHqNHlNJ4Bo3dJ4OGbwFKWjOsys0NBr2wb0o3s2xaG0EIABQt6DydBa53cC+22L2t9RzQm4zGdkwhuAGsSfoz0rV1b3gL3/SIzBomx4Le7FLzTYam98A6tECoHLIq4/tna8OuPqKznImE5UI0LlY8+cIwYxuWmzuxeqMDTlAbqk7gEbvAhFt7WKjA2T0O5bMWa0lcz4U4fXpx2nahbG5mrHBD4zhBxlVAnCoxJwa5cYDrIi5rjuJRss2LTvLIhDIcMomxAlHV+fjQBWHmsytd8S/Z1p04JaPtS61Cnih1ylgGnPIYpl+lPigXyzJGSXGTkohSzS0l9awPo/VD6CxTugA1TEV5iFaUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6862004)(4326008)(7416002)(66556008)(66476007)(64756008)(66946007)(76116006)(38100700002)(5660300002)(66446008)(8676002)(186003)(26005)(91956017)(38070700005)(508600001)(71200400001)(6512007)(6486002)(9686003)(86362001)(8936002)(54906003)(316002)(83380400001)(53546011)(6506007)(2906002)(122000001)(82960400001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/03DF++wTJ1+jQTA04Jm5xlUTG4sVAZmyZnbAp8Mtk90bh7zAcjD3u3zRsV5?=
 =?us-ascii?Q?lEk3pYkLHhlnobwsNFfxWwtq09r+1HGIX+QRGIWmZs1MFPKbm+fWiKakY3C4?=
 =?us-ascii?Q?9Z5G9M2S5TQmGqBhUghone+o62CUeC8qKV4na4Ubw291eJBFSZRV5otDvpVo?=
 =?us-ascii?Q?Mfh2YWJT4vrAd/0U0DWUBrxGkBUEO/IkKMyhy2AVmHq/sd4ytF6W+yEpsJCy?=
 =?us-ascii?Q?i7/THznhBOH4O3I54riG5+s8pgfucdtlvJRRmDrsWoZapLviQ7sapCrVh8Hg?=
 =?us-ascii?Q?yvhGuJmB5x/oN3+YC5TWs5Uu92tTDWOJW26D4Q5kff9DCLtfj+FUTdo2GX9B?=
 =?us-ascii?Q?RlwOlLE8YthFK0qPdDTzL3qvvhOSeZJhh77ohidbSISe6u2MQVmrD7y7bNgn?=
 =?us-ascii?Q?xdHJVLGh1zTIkUyHG5RVvbQtp05Mt6t9CqU5byM4Jkg7VtWBT+UYJt8lSbvo?=
 =?us-ascii?Q?vxl2JIvD+/pUogU9emqA3hSkbTac+8qfL/DyunCBLAEgOfT1PO9o8qlobP2R?=
 =?us-ascii?Q?nwjVvlLIZpZFAOiODmh/Bdw1lhJiBwyTq1nlfYIjRgGU2Wwz5zIVTidti+34?=
 =?us-ascii?Q?DU5kRgyRELJHe4bdNtGmXmTm4rbm6I+nKTv3bmyeGdklzDojehfkFxLO5mcY?=
 =?us-ascii?Q?YvZNqnZEcRl9/DoAAYapMSqsdd7XqCuqU75iSbwP60HSm9EvhPPVPDMW54ma?=
 =?us-ascii?Q?e6VJxU5Jhz+uzU5ghrkTvKp6VQ6IcsU7wotK3ichuU1HU5gzknUZV+2TB1w7?=
 =?us-ascii?Q?MniduAFhlhRQL98nCvtNVa6vx7spJhmEEym+uPY/2VnY1VBaBzqIgJCUng+v?=
 =?us-ascii?Q?7du22v8RA96iYZuvhpVIJGqkE8A6OjYguA6fAkClFqPscX3JJHRWX97oDsfp?=
 =?us-ascii?Q?VVg7ZhldAk1c/auzzO/NAsWwOpQ7GTk9X4AI81+XAQzZyR7qapK2xTMMg4s/?=
 =?us-ascii?Q?evi88K3Jlg9mHyT1Lq1hpuKjxOpsp1yUg/F+CCek4ELZQeh6WC4wXZXL92Fn?=
 =?us-ascii?Q?KNoGMBGfjEERoH/nPQGXFKA7TCid/KIy0VcDPgw9XXjx6RsyCd3Hq1N5LnnG?=
 =?us-ascii?Q?phT4tkmxobt50sE/dgiAbF2/5BpcCfyE9lriVQCD39VDaq9PYzZd7fxOxXQH?=
 =?us-ascii?Q?BoTCTQ/9z+dgtpioRyK1hB2+YROOLUcAH45K4ACDEQMORcYd1bpdSkHPnDNP?=
 =?us-ascii?Q?bv33WAZJg8sWt2YnnXopK0aZsBVD2IeItz0/g6oK2g9julJ58KCNF1R3RDCt?=
 =?us-ascii?Q?VTZcXvEVhc9TWflRUv3az18JHeveprH1D+vPojS2bTR9z6K+qfaWSBMjjlyn?=
 =?us-ascii?Q?gSf3hHRR0pyNY3ty1RN1FOtm7w7GEpUBg+ykud4PZ1zqIE84Z9KBFu4W5wV8?=
 =?us-ascii?Q?61Keh44uPAZIYAX4ooMZOqXIoT/nTLmekxR7KuCB9LOGx3MvrKX7w3rnzONi?=
 =?us-ascii?Q?r5pPAwYLDVXO6BdfbaNYkSAGNfRrt406Z1JYtxByV9iabWJnEX+ivcbOthqe?=
 =?us-ascii?Q?ug44AMBMOZ8uPfdd6jEwjk6Be/GQHqC1IabYzK/4zeMPDhctNpPleDVi5pph?=
 =?us-ascii?Q?exSkG1WHMGHsPFLg+YhjNFQ82BYTf0SvYwHlYzI2w9ddBYAfFI7CNpOpFFJY?=
 =?us-ascii?Q?/rywafcYnxkLPRYGf/P4+dtt7mdrLKVp94FhRD6PWYkvQrOmS5KENsRxzC7o?=
 =?us-ascii?Q?+C4JuLEq7+S4I8oWEJ+I4V2JGbGJd1eDYy27jQa54hzBUMp9supMNgr4EDtr?=
 =?us-ascii?Q?cr1dMmsajau5+ctbc5v1FqgBamQry7U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED5A2775473A0E4B9BF8B78DAA3579A0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88720ec3-4941-4772-86e3-08da143bd6a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 00:00:46.2403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RXsvP0tyK4U+Chsmzzu11Uig8BiVVZ8OYjzl1YWE7dWcMHChwZpHetBoekMD6zsRMXJ7nlgQ7Jtg2nvqh337Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3596
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:26:45AM +0900, Damien Le Moal wrote:
> On 3/31/22 08:47, Palmer Dabbelt wrote:
> > From: Palmer Dabbelt <palmer@rivosinc.com>
> >=20
> > As of 93917ad50972 ("RISC-V: Add support for restartable sequence") we
> > have support for restartable sequences, which default to enabled.  Thes=
e
> > select MEMBARRIER, so disabling it is now redundant.
> >=20
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> >=20
> > ---
> >=20
> > I'm not actually sure this is the right way to go: presumably the K210
> > defconfigs had MEMBARRIER=3Dn for a reason (maybe just size?), so we mi=
ght
> > actually want to move to RSEQ=3Dn instead?  As usual: I don't test on t=
he
> > K210, so I'm not exactly sure what the constraints are.
>=20
> Not sure either. It is like this now because I think this was the default
> at the time the config was created.
>=20
> Niklas,
>=20
> Can you test this please ?

Apologies for not being able to get back sooner.

I can see that this has already landed in Linus's tree:
a3dfc532b873 ("Merge tag 'riscv-for-linus-5.18-mw1' of git://git.kernel.org=
/pub/scm/linux/kernel/git/riscv/linux")

I smoke tested the above SHA1 on a k210 board, and on QEMU no-MMU
(since that defconfig was updated as well), and saw no issues.


Kind regards,
Niklas


>=20
> > ---
> >  arch/riscv/configs/nommu_k210_defconfig        | 1 -
> >  arch/riscv/configs/nommu_k210_sdcard_defconfig | 1 -
> >  arch/riscv/configs/nommu_virt_defconfig        | 1 -
> >  3 files changed, 3 deletions(-)
> >=20
> > diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/confi=
gs/nommu_k210_defconfig
> > index 3f42ed87dde8..2438fa39f8ae 100644
> > --- a/arch/riscv/configs/nommu_k210_defconfig
> > +++ b/arch/riscv/configs/nommu_k210_defconfig
> > @@ -21,7 +21,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> >  # CONFIG_AIO is not set
> >  # CONFIG_IO_URING is not set
> >  # CONFIG_ADVISE_SYSCALLS is not set
> > -# CONFIG_MEMBARRIER is not set
> >  # CONFIG_KALLSYMS is not set
> >  CONFIG_EMBEDDED=3Dy
> >  # CONFIG_VM_EVENT_COUNTERS is not set
> > diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/risc=
v/configs/nommu_k210_sdcard_defconfig
> > index af64b95e88cc..9a133e63ae5b 100644
> > --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
> > +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> > @@ -13,7 +13,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> >  # CONFIG_AIO is not set
> >  # CONFIG_IO_URING is not set
> >  # CONFIG_ADVISE_SYSCALLS is not set
> > -# CONFIG_MEMBARRIER is not set
> >  # CONFIG_KALLSYMS is not set
> >  CONFIG_EMBEDDED=3Dy
> >  # CONFIG_VM_EVENT_COUNTERS is not set
> > diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/confi=
gs/nommu_virt_defconfig
> > index e1c9864b6237..5269fbb6b4fc 100644
> > --- a/arch/riscv/configs/nommu_virt_defconfig
> > +++ b/arch/riscv/configs/nommu_virt_defconfig
> > @@ -19,7 +19,6 @@ CONFIG_EXPERT=3Dy
> >  # CONFIG_AIO is not set
> >  # CONFIG_IO_URING is not set
> >  # CONFIG_ADVISE_SYSCALLS is not set
> > -# CONFIG_MEMBARRIER is not set
> >  # CONFIG_KALLSYMS is not set
> >  # CONFIG_VM_EVENT_COUNTERS is not set
> >  # CONFIG_COMPAT_BRK is not set
>=20
>=20
> --=20
> Damien Le Moal
> Western Digital Research=
