Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF04DD8D2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbiCRLTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiCRLTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:19:20 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30074.outbound.protection.outlook.com [40.107.3.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36125ABF6B;
        Fri, 18 Mar 2022 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxD8qoc3j142vo8VImibf6wxIOFhRXMvVs6fjUqQ1YY=;
 b=nqeErthNairkPwExD6G14ADkW02EpYX/p2cZUAn/InFk+bvLA6fXsSnuyOH+1HARMuJLs3sKjau1YCQ03yRHgrRgWSYBFIvUw7ZCaFDmNedIIcDfwJCcweL00nAmTZ/65b0LX7NohDpQxZcSI6IFCnx0JteMUlsX0tWVyKbXOeQ=
Received: from DB6PR07CA0076.eurprd07.prod.outlook.com (2603:10a6:6:2b::14) by
 PA4PR08MB6141.eurprd08.prod.outlook.com (2603:10a6:102:f2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Fri, 18 Mar 2022 11:17:48 +0000
Received: from DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2b:cafe::2c) by DB6PR07CA0076.outlook.office365.com
 (2603:10a6:6:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8 via Frontend
 Transport; Fri, 18 Mar 2022 11:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT051.mail.protection.outlook.com (10.152.21.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 11:17:48 +0000
Received: ("Tessian outbound 2877e54fe176:v113"); Fri, 18 Mar 2022 11:17:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8b86f7bb41d69098
X-CR-MTA-TID: 64aa7808
Received: from 9e1ed5f023a5.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DDF217C2-B569-4EBF-96A2-B2715555DB44.1;
        Fri, 18 Mar 2022 11:17:42 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9e1ed5f023a5.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Mar 2022 11:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWuw8krY0Uux6y55TYEGFLXLRV6o6e++emmd+tgHHCtp50s4Gqj6ruLOeg00JfgeSRjXudHiZ9q0ReX+2Q7DDh9iP3xZdzZfGPZXLsX3t6uqfazlCX+qe42UPySzBAPsCJs9FkjspQmKgauBSXd8YyyDRKuaQ0LsxV4xQSvEcrfBrsID0QKqjSOizSa13eq5w1J3AbTd7p4AFsEiVhct/XsGp7PYc8g1AmCpUZQ7vUyl4js040h0F/7biB+mHqJul7t1ks9IC6pPGvnVx0WRQfJ6SHPTIXOh6549A13yvWWjV2RXeB/L1FM2bQfOS4dgyqGoT2i/nWXG3q7CPsxzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxD8qoc3j142vo8VImibf6wxIOFhRXMvVs6fjUqQ1YY=;
 b=TGzVNxsEzv2PTEKDgcfeSgkAe0jteFHDF2bRksfAMGWCH9yOxZAXLhBR+S9iEzgREKtaltqMH3Qls8blCp5QeRH2BNnn0k/XyDIJ/sBTAjmVMIiHsidU2V1FXKAq4BHCzO+nuJvx9y/NUZL6iZ47956eQTdmLhdl5EFpFZQjnlS3p/MHnn0fHrWa2yqbn9RuE9939JkBIB9v1u7u+vuxvin7bpolHiAFd5/XTO7u9iCLczXFZF2rdBsAHCCm/pBTLeKd7NfesfYE9mgMdwHatO9IziLQoSP0SiR0EfHmncMPGQJSNAwyZimKS10+Vs8CxsRl9pucs8zcVtxJSEQNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxD8qoc3j142vo8VImibf6wxIOFhRXMvVs6fjUqQ1YY=;
 b=nqeErthNairkPwExD6G14ADkW02EpYX/p2cZUAn/InFk+bvLA6fXsSnuyOH+1HARMuJLs3sKjau1YCQ03yRHgrRgWSYBFIvUw7ZCaFDmNedIIcDfwJCcweL00nAmTZ/65b0LX7NohDpQxZcSI6IFCnx0JteMUlsX0tWVyKbXOeQ=
Received: from AM0PR08MB3956.eurprd08.prod.outlook.com (2603:10a6:208:131::12)
 by DB6PR0802MB2615.eurprd08.prod.outlook.com (2603:10a6:4:a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 11:17:39 +0000
Received: from AM0PR08MB3956.eurprd08.prod.outlook.com
 ([fe80::8113:3b77:e3a2:b008]) by AM0PR08MB3956.eurprd08.prod.outlook.com
 ([fe80::8113:3b77:e3a2:b008%7]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 11:17:39 +0000
From:   Luca Fancellu <Luca.Fancellu@arm.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen/arm: fix typos in comments
Thread-Topic: [PATCH] xen/arm: fix typos in comments
Thread-Index: AQHYOrRFpXZxY2VxTE6A18TUxTYzZqzE/iWA
Date:   Fri, 18 Mar 2022 11:17:39 +0000
Message-ID: <50B35A3D-9848-4B89-8935-AD3A1330D7CF@arm.com>
References: <20220318103729.157574-15-Julia.Lawall@inria.fr>
In-Reply-To: <20220318103729.157574-15-Julia.Lawall@inria.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 51f853c6-6a45-4def-2252-08da08d0ef38
x-ms-traffictypediagnostic: DB6PR0802MB2615:EE_|DB5EUR03FT051:EE_|PA4PR08MB6141:EE_
X-Microsoft-Antispam-PRVS: <PA4PR08MB6141732C4B8DA1A24461ABE8E4139@PA4PR08MB6141.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: roIuxdexesj1Jt3l1qWKRM68lFIGT+RQcVdu2y5EDDYI0DiI/kjjDFhuyVx54w+znfLyHFh0336y2M+QP/QuPXvL1LowC2Mu7E5wF1Zxdwl0uYgZ5y7mZqF3YiRwjSPE0ci8+T8kt5f4elYJZhBDpBnwMsDWPNOsGsBNPNHq6/oG3++vVpXZP5OLwc7vjiAhF4ld1UpG/3HFYWNAqIbif6e7K3xy9/XV8SZAJem42gfwFRU+ucl3VS2G1yqYZFq0pngVumGWlCEOh99I5K2QK8uNY7seYIwCj1pR/zeZpb5ihVuRTxWMPhJhBxktFuIAudO2mQ94o3NpifJPjB6dLrc9AOPhJpAKqOVjDSsZYQqJwWq6v5BmgEWIteicmsnLXyStm4Fsae4OBeyTgXs/9ziF1FOGzvicEajXDuGkfQqTgo54ZA3ruMgLf8toecAJ5iPsYcVLruy8ziodTO2fThJlEaBjqmHo96gOUfxJVaEzVng/hgJ9KaBHzVv/A/x9Ktl/mYgawxbepZi3jX99oYCiUMR/KsGNqxJ5y6tLOLbZTN1zmyXpg0qzSEHipxE2Wf/2jC6pfOhYRoUvN5SPYOAd6zv6y5EwGPyId21QjjqMZ7ybcf7eN+l/qAIEeGeb0qaoyY42QhD73RzxY/a5Bjb+jIFoQnuuAQL3UtUzLCdZq/mNjiRb6qXco1ChsttY2I5ueB2Uw9wR9Nf2zqQTa+1FZ4FGCgm/4XGCDPN/vLqnHIOVJQx57iiurS+Vqh29
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3956.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(76116006)(38100700002)(122000001)(91956017)(54906003)(6916009)(66556008)(316002)(66476007)(66946007)(186003)(86362001)(5660300002)(4744005)(38070700005)(64756008)(8936002)(66446008)(2906002)(26005)(53546011)(2616005)(6506007)(6512007)(6486002)(71200400001)(508600001)(83380400001)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD707C99DDB2274FB68AF74B602F08B4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2615
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0e77dfda-39dd-4142-2ad9-08da08d0e9b7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hn4o+CgIdgBlLj/VR4ib4c5w7Q7d2vwVt4SpZL81aFMWRxEZyhl7xohObBqAAdXudOS/q3JbBMW/kP2tmBbpnPT1m3v1AOkGtBqm3Euwt8Qw4/Eqpds7kN5/akAHNKMM2Y8llDC4fYCzpXWV83INVCF4ECZkncPmsIA2UGHZOwiq6+Id+S4EhCNc3BuaCNQVpFdSkPsqc07MLjcNS+x6jp1FiDKWonlZVUnAlkgf7T3lmy3svoJdNPy52ozOHFR4rNDqUEg/rWypUlMopLN9d81DWE4mdH7wzwJcch3kQOqyYj8CHlpCAmAl/WjZq/FSOzWziVFfRSs2RlVbSMZx1y61YluSS3nFRXNu3FIho395Sdx+ioYjOZmdkN0jCnJWGJBo5XePYWg9qw443Q1TbkWQOdtbQwkWhweH0OFyyVIzSVoP8kWAYU6oH0yA2bLQ9CPMGBsQk+qIez3lLrF7QEBBs/Q7pfY7O5VGMM31M1wDiAUvYEIgzG5+WHwIAdqCxNZL69IsoG0GxNTzZsN/sUOOjxm6rCZ9OWCfwUTvbDm+DEdS/NmMaK+hBO2JMatE7yeh+ojqxAsnoxg1C/T3Lz9sZ4v7fLaLyj5Yn9KNWc/CS3qhTMorD0s8J4PBVT6CwnL5xm47NYf+br4A7E2smtGYVKLRBmSBBUOkGXwZ/ldfkrykOP0gCQ/k7gYRs6mM
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(26005)(83380400001)(336012)(47076005)(36860700001)(54906003)(70586007)(70206006)(36756003)(450100002)(316002)(508600001)(8676002)(4326008)(6862004)(6486002)(2906002)(6512007)(5660300002)(33656002)(8936002)(86362001)(40460700003)(82310400004)(356005)(81166007)(6506007)(53546011)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 11:17:48.5894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f853c6-6a45-4def-2252-08da08d0ef38
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6141
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 18 Mar 2022, at 10:37, Julia Lawall <Julia.Lawall@inria.fr> wrote:
>=20
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Luca Fancellu <luca.fancellu@arm.com>

Cheers,
Luca

>=20
> ---
> arch/arm/xen/mm.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index a7e54a087b80..607c1a557ccc 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -105,7 +105,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
> 	 *	- The Linux page refers to foreign memory
> 	 *	- The device doesn't support coherent DMA request
> 	 *
> -	 * The Linux page may be spanned acrros multiple Xen page, although
> +	 * The Linux page may be spanned across multiple Xen page, although
> 	 * it's not possible to have a mix of local and foreign Xen page.
> 	 * Furthermore, range_straddles_page_boundary is already checking
> 	 * if buffer is physically contiguous in the host RAM.
>=20
>=20

