Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9083A4889D9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 15:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiAIOQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 09:16:07 -0500
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:52769
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229922AbiAIOQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 09:16:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RC148HWRYFazVJeBMM6Guab7lW6BdMxiB+nUsWcikYjKOH2/c+2oQGVjy2uWNZ5FgsjUrA5WmUjAgDTgQE79EIBS8aEiVcrU0KQ+gI7ZWPXFqJHKdW5BA855oDUDAXFa9FOShTh7zemaUHpwfRikhWmbJ3eHMXIVpsVem+GOunfHiTpAAsqNirZxXSwh1g1At+P7oCWDlVYonqtsfOTTr9qQ9UH3uClfGopd3nLGGxZwmFunc9W4V8N9/Cji3ixu55c5PvGRDL7BQjwg0uSfJlmIzUiPeiH4lht+BR3V0GR9z8jy5p4iqvWahS0BFif9gKyU52lBW1AwLGSx76jeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB9KEK9yD8fcfg/WPeZBUBKtSl7/rVbeEPwnaFYLqyc=;
 b=OODHyjunTxiQM7YKM1XAiK5EM2d3VtFd5ax/DQ61Lcvq/Ntgq9TnC/LvJVShV610EiagcDOILZ7C4g5TdNP7127hnkPE8dzAn/Ycp+EQQHrgpxOrfjgd+770Luq5LJlhW/lxqxiw9BR2S071Z0Z9VqwsY2eaKK+mJOx1yV9yLyk7S8uFtnl9EClMjwsKEduGFO49vKLkGzX9AOwMI/7IyO/pP+reb9NaXJewJnGTibunAFM7ofdclZZ+QLjm6GiHOM9zzFdTkEAk7ZiqFtbnjAuPTMCrjWz6wD0DsVDJ9ptNBNTISWuZVLU56MeShYvAxBmmZyJRrTLQtEs4Uvbksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=bytedance.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB9KEK9yD8fcfg/WPeZBUBKtSl7/rVbeEPwnaFYLqyc=;
 b=n8RaaEIsoUY/2gPx2cSLnC8IeE4dU84ljrXg0CTWSS4W7MOPsRrZHarFf/AKmF0wqG2VIXUjF2f6nOLlfe3+StuZPBsQCgBUrTcyQ3r99IPxHEZcfzmPc7GkqAa3gg9y+dU0VnLHz8d9GAys2MvTWBk2YdBMnxOREDOiCa2XeQGHyfUOmSjiSryPsoi4hjFY17In7ojS3CWIPF1aTJizrx5XUn8arUrwjb3d+u08AcAp7yecobrGmpk1Id97DcuQfG+cIq+TqrK1dCnwA9NthcFAe17NUh1K5p/5Ijg9Bu+sfy0m+xLhoNGyYhJEMsJtiwSjiE6w4WTRSqDdvxrsJA==
Received: from CO2PR07CA0067.namprd07.prod.outlook.com (2603:10b6:100::35) by
 MN2PR12MB3263.namprd12.prod.outlook.com (2603:10b6:208:ab::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Sun, 9 Jan 2022 14:16:04 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::b2) by CO2PR07CA0067.outlook.office365.com
 (2603:10b6:100::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Sun, 9 Jan 2022 14:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.9 via Frontend Transport; Sun, 9 Jan 2022 14:16:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 9 Jan
 2022 14:12:14 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (10.127.8.10) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9;
 Sun, 9 Jan 2022 06:12:11 -0800
Date:   Sun, 9 Jan 2022 16:12:07 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     <trix@redhat.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>, <parav@nvidia.com>,
        <si-wei.liu@oracle.com>, <xieyongji@bytedance.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: simplfy error handler in mlx5_vdpa_dev_add()
Message-ID: <20220109141207.GC70879@mtl-vdi-166.wap.labs.mlnx>
References: <20220109132422.4047425-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220109132422.4047425-1-trix@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.127.8.10]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5eba36b-3ad9-43c2-cbb8-08d9d37a9201
X-MS-TrafficTypeDiagnostic: MN2PR12MB3263:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3263B1CD9D0876239CA3FEFEAB4F9@MN2PR12MB3263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tvS6Oj0W3jPCCf+Kh+Kv5ek8D949OF59JySSuOuAbjwWIT5bBGDPuhLpqsbTy5/j0SEzfvFke5u6ujIn31QI4GuNhn5iv+k1YM+i0P1eCjZW4DBRoVoSugwye2T5sU/r5UbJ9ryxKzc4kzujR+Fbysi2qIwBLIapl8oAjn1t5dToROcewWWSlSn6tOvg8TU2vUiQyC2pdd3z5tqToVdrpvuA23dI62wjWKdWJSClMglZ6dmWozn040TjucHaiZFvOt0/3zto/pOxxK12WoK5AD1sCWE9th3IBm+zNXx3FQIgOfKx3fe/rEKr1g1saU7nz2Es8Yok2ZT4Nte8X7rJFCfAE3bUAXMUQaIJrE70+53AP+Ag1G7PPo1bJCybvXEkQZM5HenWqaCz2dZwFWDGijNvAlO2AN0ed4vuuclMEilmlNU806CWXWTJ9lq+oz+ycMZKYIANPe9x2/CyJCcV5iQ0XnQGcJvor0CYxT/2ob8EQnUbDk+g+InAvpe042YUNgqhRbSh0aVp5Liie73Fjk5/xbajLcoyyq2o0TJ/vAzG9+bsY7HgPyqy8pgSRAzbCoHXCU4D+fbkMKEuFakg/r2voGNdlIdC/eLKdN7wjpOy605eM28xX7zn3GZU+6EpAxSFmzi2I2LqYC67KQqSa1Kphc3i+Sh8SzqB+o8LQvw+IoUgZ9S7iU+ffEdCKvCF1EDDHzBMO2bopOerOpf5yHJ/vfsBzIV0OM1WKOgBjlMfWeC1Q2a68kejvPiIRbHLXV29Z4+OqnGbdB+pG4Dl2Buj2aEWpIxM8AAmEGvPR8=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(316002)(26005)(5660300002)(54906003)(426003)(1076003)(83380400001)(8676002)(336012)(186003)(8936002)(508600001)(356005)(81166007)(82310400004)(55016003)(70586007)(70206006)(40460700001)(16526019)(7696005)(4326008)(36860700001)(86362001)(9686003)(6916009)(2906002)(33656002)(6666004)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2022 14:16:03.7760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5eba36b-3ad9-43c2-cbb8-08d9d37a9201
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3263
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 05:24:22AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> The use of pfmdev is protected by two calls to is_zero_ether_add().
> The second call in the error handler can be replaced by
> checking if pfmdev was set as part of the earlier call.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

It's not fixing anything, right? Maybe add justification for this change
by e.g. showing the code size had decreased or so?

>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 37220f6db7ad7..2d38b8fe9305e 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2530,7 +2530,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  {
>  	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
>  	struct virtio_net_config *config;
> -	struct mlx5_core_dev *pfmdev;
> +	struct mlx5_core_dev *pfmdev = NULL;
>  	struct mlx5_vdpa_dev *mvdev;
>  	struct mlx5_vdpa_net *ndev;
>  	struct mlx5_core_dev *mdev;
> @@ -2654,7 +2654,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  err_res:
>  	mlx5_vdpa_free_resources(&ndev->mvdev);
>  err_mpfs:
> -	if (!is_zero_ether_addr(config->mac))
> +	if (pfmdev)
>  		mlx5_mpfs_del_mac(pfmdev, config->mac);
>  err_mtu:
>  	mutex_destroy(&ndev->reslock);
> -- 
> 2.26.3
> 
