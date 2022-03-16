Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACD34DB3C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350338AbiCPO4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239686AbiCPO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:56:05 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20083.outbound.protection.outlook.com [40.107.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA1062A0F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7Mfn3/0+Iag1awF47kasoTguTpx39+NhnH/7sngkPE=;
 b=3QM4OeuILj+0N900Da8VcGLvR9lLVXZ0qQSD7K8+kiLe7zHYraIZeAmf+rOJtzLBwdMJnhnnh3c+tyZX4lwVONo+3h88IFNQLGjzrP8CNtvgKMv7T5vL83jtsQghDE9nVAujXJcgNCsLwyww+kLVSbaIkt44nELw3pdjhAtNhjM=
Received: from AM6P195CA0069.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::46)
 by AM8PR08MB5668.eurprd08.prod.outlook.com (2603:10a6:20b:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 14:54:47 +0000
Received: from VE1EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::b) by AM6P195CA0069.outlook.office365.com
 (2603:10a6:209:87::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Wed, 16 Mar 2022 14:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT018.mail.protection.outlook.com (10.152.18.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 14:54:46 +0000
Received: ("Tessian outbound 18e50a6f0513:v113"); Wed, 16 Mar 2022 14:54:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8bcba2805b3b301a
X-CR-MTA-TID: 64aa7808
Received: from 0259a7b99bb0.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 967D0538-1016-4AC2-853E-F0676EE7856A.1;
        Wed, 16 Mar 2022 14:54:35 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0259a7b99bb0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Mar 2022 14:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjbPBIfaewvsRjy/IUcwmZ9dbIr85QCqxX0LRPnhG2QNtPmMzsJNMQ31fWo+iNkcANIMzJPiBgb0yTsBctSeBXBFYMdwKCdCp3c1L3QHu6mvibb0sVoBMeKMvGxM0mYcBtbxDR8LoyFyDDdJR8xmWKENGj/6ieHjAOnwG1C9csxr4hnPwXorXQSCswrUZ5tdw2GCrAZTRP9TKtsEk/QOXVkp6E+qhMwLCa2CrbMIjHZdaYhFSQsJr5kp2gTU2ApIzxAZa7iTrgeODhwpjQvzzbrSu9MyWkad7mEoLoMw1tZPipNJUmUwZRAzxLI0mMgZ0NgkYkh7VdnHx2Y7Zw6WRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7Mfn3/0+Iag1awF47kasoTguTpx39+NhnH/7sngkPE=;
 b=j1D2q6YCF4yLUdMhXCbnrfht9IgUMQNdTi3zObKriJng9RxbwT5s61wd8QAOJmBfuTnaAx5vkcHixyemHT24/vvflYiAxspVr5USFwoP9ZLVE/GPlR6C5/2enV0pgZHAQEyr4g3Fhc4mOexp3cYOZGSUs9EEjgt90LqAv0gy23MQREuy7bNIBNQjClAW3x6uCfmov4s6ClB6M44OAM+M1I9hs1UxS+r3N3qFXWNF484NiypZ8urlOpl7rSyYMFUnlCqebQsTDHet+uRA5WRw6Ic53AIFncLwl9HjnPniQ68saUGbe63BUMGLAXlIhzu7EYsJegpgWw3tmPfRrnayIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7Mfn3/0+Iag1awF47kasoTguTpx39+NhnH/7sngkPE=;
 b=3QM4OeuILj+0N900Da8VcGLvR9lLVXZ0qQSD7K8+kiLe7zHYraIZeAmf+rOJtzLBwdMJnhnnh3c+tyZX4lwVONo+3h88IFNQLGjzrP8CNtvgKMv7T5vL83jtsQghDE9nVAujXJcgNCsLwyww+kLVSbaIkt44nELw3pdjhAtNhjM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB6PR08MB2680.eurprd08.prod.outlook.com (2603:10a6:6:19::11) by
 AM0PR08MB3251.eurprd08.prod.outlook.com (2603:10a6:208:63::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22; Wed, 16 Mar 2022 14:54:32 +0000
Received: from DB6PR08MB2680.eurprd08.prod.outlook.com
 ([fe80::10f:f7c2:3652:7393]) by DB6PR08MB2680.eurprd08.prod.outlook.com
 ([fe80::10f:f7c2:3652:7393%7]) with mapi id 15.20.5061.022; Wed, 16 Mar 2022
 14:54:32 +0000
Date:   Wed, 16 Mar 2022 14:54:03 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 3/3] irqchip/gic-v3: Relax polling of GIC{R,D}_CTLR.RWP
Message-ID: <20220316145403.51475e25@slackpad.lan>
In-Reply-To: <20220315165034.794482-4-maz@kernel.org>
References: <20220315165034.794482-1-maz@kernel.org>
        <20220315165034.794482-4-maz@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-slackware-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0161.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::29) To DB6PR08MB2680.eurprd08.prod.outlook.com
 (2603:10a6:6:19::11)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 40fb3d7c-ddf8-4847-8b5b-08da075ce9e2
X-MS-TrafficTypeDiagnostic: AM0PR08MB3251:EE_|VE1EUR03FT018:EE_|AM8PR08MB5668:EE_
X-Microsoft-Antispam-PRVS: <AM8PR08MB566869D8604DE3FDC3DF15909D119@AM8PR08MB5668.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5L4quuiGw9sJj43tbP0TuEJyu8cQyhlf/dnyNyOsdriNUzcf8zCI/dsimScOz+X+Fk8f77BytLfaNezB/kckrA+3tbPORUGffgwxJzciYq3mGiXS6KWNOWslTPcMJRMTCIokPCpGnfmpyBpPiXNVPBZyvY/tmBvCvnUiYTh1GS8TGYMM8gk19NqUpaD2nfQZExkD3et/feAPfsS7aHvYtMqYS1xTL02dSlYyCqGWMFw+GyjoVX5ZiEDYxeNIwXUhgiOrcDkRkVRLBNDXvAyTuJfDxY5PTNzY7Ov/rIY9jQVMFfi5kZaIJYQwHQuZxDOtn+q1IJ/IesP3918YGe4WSLNdVQgBX/QpavlMqGW/4nP0n9iS7UiUspSwovbJVQcMx3LWJibcJy4LGGiCKyPSS2YSJ2ZgVhyx1ucuLYHimcyOmfCSgYng79KnuEKXxLVLJH6iBe3uObK332p1c7rV6zA1467+wHtAQFkf/Vm6kX5096hae6psyDs2rNo458hju3e72Q0edrozUlLu6mEnZCAmRmW5ezO0bAc8ayUf2SqqaM29NMLR9Xz5sG3wmvUBZDlNRO4vU356GZqCBrquo61WRVi01DFMxH1Aw5QD3XX3T3hkGFbDm377FUMQC7PWf52eh2mDA8zmAtmLHXgxUQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR08MB2680.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(66476007)(316002)(66556008)(36916002)(6512007)(8676002)(4326008)(6506007)(83380400001)(6666004)(9686003)(54906003)(86362001)(38100700002)(6486002)(186003)(2906002)(36756003)(508600001)(26005)(1076003)(8936002)(5660300002)(44832011)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3251
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bb74f5d8-519a-4e65-5466-08da075ce0f3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+soc66tWhlMar/oGlxMfMTtmAotbUr4GEpteR0TipNpGO/iSGm7pyoAG/PrVD0IPYRsfMETqX36XHISM7yf3jTArtE4UOt/OsekhsAnzyN6Lcpc4/66kgViyM6grGwTq3EZxkZzGXEvUjFKZLqbHrGgwaQUYvhQgDKMvBC5eHVn2iyeq/cFZwK5IAs3CvjX0hK/joQqSrDaGYqA9oKkB5FjOQhhXCRU4q6XpqxpYs5dfzI7yeIN/kzOAhlC1GVW8RmlFY4bhU1h/RiVS3dDilUFo/fnoDKq8JNjcHHh8epOwMnuIvMNW3zdpotjJiJjP6YnimMAr00ae726o3yAzBJ8omfGrzrb85/Wuk8x6cfOxArRl6o8oY6ZLm0sQQes0Rq1neca5T9P1NillxDxKz4XCvejDrMZfbOctcF3cmYimxQucHLzrDpCX4Hgy3Dy49hGc5D3kTBXvkEXVUf8ymKmjLVohizfD5aZ+peZegHX1nVB+n1umEPNN2tZbzPOTYpVIczTnm1PteuAIR3+N67yVdAFl6jQCF0ZG7XsXpWFQ+NnTWC0wa3ufrYw8wkTYMY6Zd9kQBnwEd+rq99WfRCfW9RYl+3BgfVPSD3NcsazH7DUXMXoYi2mx0FJkMic5e+OgzvBiy9TSik4hMOkICzZXy7rReoiAsC5XKsvPi54UisgsBk/gSsSWNtl0NLC
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(336012)(54906003)(36756003)(44832011)(47076005)(6486002)(40460700003)(82310400004)(6512007)(9686003)(83380400001)(8936002)(508600001)(86362001)(70206006)(70586007)(6862004)(4326008)(186003)(36916002)(36860700001)(107886003)(6506007)(8676002)(5660300002)(356005)(81166007)(2906002)(26005)(6666004)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 14:54:46.7576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fb3d7c-ddf8-4847-8b5b-08da075ce9e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5668
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 16:50:34 +0000
Marc Zyngier <maz@kernel.org> wrote:

Hi,

> Recent work on the KVM GIC emulation has revealed that the GICv3
> driver is a bit RWP-happy, as it polls this bit for each and
> every write MMIO access involving a single interrupt.
>
> As it turns out, polling RWP is only required when:
> - Disabling an SGI, PPI or SPI
> - Disabling LPIs at the redistributor level
> - Disabling groups
> - Enabling ARE
> - Dealing with DPG*
>
> Simplify the driver by removing all the other instances of RWP
> polling, and add the one that was missing when enabling the distributor
> (as that's where we set ARE).

Don't we need an explicit call to wait_for_rwp() now for:
gic_irq_set_irqchip_state(IRQCHIP_STATE_MASKED, true) ?

The rest looks fine to me.

Thanks,
Andre

>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 363bfe172033..05ff7fef64cb 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -352,28 +352,27 @@ static int gic_peek_irq(struct irq_data *d, u32 off=
set)
>
>  static void gic_poke_irq(struct irq_data *d, u32 offset)
>  {
> -     void (*rwp_wait)(void);
>       void __iomem *base;
>       u32 index, mask;
>
>       offset =3D convert_offset_index(d, offset, &index);
>       mask =3D 1 << (index % 32);
>
> -     if (gic_irq_in_rdist(d)) {
> +     if (gic_irq_in_rdist(d))
>               base =3D gic_data_rdist_sgi_base();
> -             rwp_wait =3D gic_redist_wait_for_rwp;
> -     } else {
> +     else
>               base =3D gic_data.dist_base;
> -             rwp_wait =3D gic_dist_wait_for_rwp;
> -     }
>
>       writel_relaxed(mask, base + offset + (index / 32) * 4);
> -     rwp_wait();
>  }
>
>  static void gic_mask_irq(struct irq_data *d)
>  {
>       gic_poke_irq(d, GICD_ICENABLER);
> +     if (gic_irq_in_rdist(d))
> +             gic_redist_wait_for_rwp();
> +     else
> +             gic_dist_wait_for_rwp();
>  }
>
>  static void gic_eoimode1_mask_irq(struct irq_data *d)
> @@ -574,7 +573,6 @@ static int gic_set_type(struct irq_data *d, unsigned =
int type)
>  {
>       enum gic_intid_range range;
>       unsigned int irq =3D gic_irq(d);
> -     void (*rwp_wait)(void);
>       void __iomem *base;
>       u32 offset, index;
>       int ret;
> @@ -590,17 +588,14 @@ static int gic_set_type(struct irq_data *d, unsigne=
d int type)
>           type !=3D IRQ_TYPE_LEVEL_HIGH && type !=3D IRQ_TYPE_EDGE_RISING=
)
>               return -EINVAL;
>
> -     if (gic_irq_in_rdist(d)) {
> +     if (gic_irq_in_rdist(d))
>               base =3D gic_data_rdist_sgi_base();
> -             rwp_wait =3D gic_redist_wait_for_rwp;
> -     } else {
> +     else
>               base =3D gic_data.dist_base;
> -             rwp_wait =3D gic_dist_wait_for_rwp;
> -     }
>
>       offset =3D convert_offset_index(d, GICD_ICFGR, &index);
>
> -     ret =3D gic_configure_irq(index, type, base + offset, rwp_wait);
> +     ret =3D gic_configure_irq(index, type, base + offset, NULL);
>       if (ret && (range =3D=3D PPI_RANGE || range =3D=3D EPPI_RANGE)) {
>               /* Misconfigured PPIs are usually not fatal */
>               pr_warn("GIC: PPI INTID%d is secure or misconfigured\n", ir=
q);
> @@ -808,7 +803,7 @@ static void __init gic_dist_init(void)
>               writel_relaxed(GICD_INT_DEF_PRI_X4, base + GICD_IPRIORITYRn=
E + i);
>
>       /* Now do the common stuff, and wait for the distributor to drain *=
/
> -     gic_dist_config(base, GIC_LINE_NR, gic_dist_wait_for_rwp);
> +     gic_dist_config(base, GIC_LINE_NR, NULL);
>
>       val =3D GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_=
G1;
>       if (gic_data.rdists.gicd_typer2 & GICD_TYPER2_nASSGIcap) {
> @@ -818,6 +813,7 @@ static void __init gic_dist_init(void)
>
>       /* Enable distributor with ARE, Group1 */
>       writel_relaxed(val, base + GICD_CTLR);
> +     gic_dist_wait_for_rwp();
>
>       /*
>        * Set all global interrupts to the boot CPU only. ARE must be
> @@ -1293,8 +1289,6 @@ static int gic_set_affinity(struct irq_data *d, con=
st struct cpumask *mask_val,
>        */
>       if (enabled)
>               gic_unmask_irq(d);
> -     else
> -             gic_dist_wait_for_rwp();
>
>       irq_data_update_effective_affinity(d, cpumask_of(cpu));
>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
