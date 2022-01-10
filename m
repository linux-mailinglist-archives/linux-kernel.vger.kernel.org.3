Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116D3488F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 06:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbiAJFYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 00:24:09 -0500
Received: from mail-mw2nam08on2066.outbound.protection.outlook.com ([40.107.101.66]:18016
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230407AbiAJFYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 00:24:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IODTP1/n1fZODiZQPt4VO9THOQl3EOzYZb5+d74zaRIcQR+Do7O7XR9mV/zrGUa/NTnmXGTSOlqa7WJKJ2aTlrtnNAAVsRTMcwI9xuq2qXZB6JFEiRkGTjPM9mUwuwjrrv3IJ7BhP/HOHR/Gbtu7q2lRawMybhYVlocDZIk1OBfqp//nn9cDHnJyw84GBIkpu/F13zAFUCFamrcvjLZWZilojmQmv/8Hy0viGNh3VKmEI+QwyevJB/7N194pWk/OTclU95vKBWqAXm0/3MIcFSMXP1EbmR0XqKKLLpdszuEPprAZr+AKKKCaAzONOKc8oSr82J3cMMBy8OD/SOx0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veDKtIyJv0NQSDbx7ywSgd8B1GfVkS52+INfA29V71s=;
 b=Uue8BJoGTxDNBF5cPMHJzNvNddUtMRMygF2UylciZEpqTKtB5P+mT1r7OkisMcxKuWA0IbJX8a9Bh+JnEpSgJrcZuboNNDDVWfEnF/8ILLYgXDPyc6DEU+N1LL5OEtVvyq6N2iv12qYtY9QrcnKM91enqbg+31hx/o82EahNEY18aF03T7y/lL/KIgPHnt+OIOsjhCbWQ4+WafHp1PUciE0aDtfLbVYAmntiI+QlTmEjQeGclHMDGcVlG5xlA4fBuSNdkMPKWZXtpZ3cT+eq3vXCr5kh330hnw5zVt3tvAK3iHU+qFrlvZyEUGtSJ/+DQBawQJLqkI93ifYwTwWWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veDKtIyJv0NQSDbx7ywSgd8B1GfVkS52+INfA29V71s=;
 b=bzADLV3uDoIa3dLSyev9xm/25ypWtnIKtGlnT9iVteHElZb3MJQgeQITSAKxQ3AS9GaAulLMe9LNcL9ZnoWUKHn1ItWwVu3lH8NBkJBWQpoosTKdfQbEwU+YvBOVV+Bkqz1u1Gqh4ttk0STqbXA5Z6N4ewN+F5lqhLkQdSuFY6k3bXt2BBFBEudKgVhU0X5lTM5c22oTht5cWETwtFg+5/D9tFBbhJd5dVLsf2vgkblcrPY6tqSmKlUXFRqSyXeuuyxehWEsmR743G1G88Rn2cwstdhnZ/MfWLYyTqT/ytYV4FoMLhTlbtUA80d+a8/DoI6J+rUmsvk+wf9G3lpq7g==
Received: from CO1PR15CA0053.namprd15.prod.outlook.com (2603:10b6:101:1f::21)
 by SN6PR12MB4718.namprd12.prod.outlook.com (2603:10b6:805:ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 05:24:05 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:1f:cafe::f7) by CO1PR15CA0053.outlook.office365.com
 (2603:10b6:101:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Mon, 10 Jan 2022 05:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 05:24:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 10 Jan
 2022 05:24:04 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9;
 Sun, 9 Jan 2022 21:24:02 -0800
Date:   Mon, 10 Jan 2022 07:23:58 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        "Jason Wang" <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] vdpa/mlx5: fix endian-ness for max vqs
Message-ID: <20220110052358.GA99650@mtl-vdi-166.wap.labs.mlnx>
References: <20220108180041.4601-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220108180041.4601-1-mst@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e35aa70-79be-407e-d936-08d9d3f96b59
X-MS-TrafficTypeDiagnostic: SN6PR12MB4718:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB47182DDDC5DCFA2C808062CDAB509@SN6PR12MB4718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K69C65CHvk4jlGZCj8uIeR0ncQjc1s1IVzVyV9wFfwX8EVGzYLRo5uDQ0WZLtgchHnB4/svwVgKsSU78CH8uPvKuZ7ZFMEe8KX+7v8x/Lnhd6jbIzSj23lpz3v2om1ZSyMUhy86l3S4ccR4uwiyn1bNcQ8LjOEyd39cYrzf6v/m3LhGx2eRLpke8otRDvWZaOryqTHY8c8sFg4Cnh5ZgKH/dWGkMe93H0E1yaGF+mkf9/bjNUt2v98RiPPek0MHZIoykGrr/4EcKivU9aOLTMkb7tOQIIV7i+e4WB2jA3su8U/BIcP/whNqxQ3R+dQGTKbxfmD7ApGpFZeNqwkr42Z2iSgfAHZVIwvGni7rMvK6sHk8N1ESPjbVTnRN1NQUnIq6mFuzgMD1CUktWGJE4qeoyNGGn/abcfkYXRz7r/r1n1L3y8AnjaSxVixXiKuClDj7UbPJ+ETovREj/bDDR848Usd+Nt8Yh6BHUS+G9wcE/awrQ9vzUh3J+Q/FiQxViOVX3DF/3tr15O6STR2lB8Vf50zL+JHYwM9MiJSDeYyFYaVuMfEfvUrv/e5I7sHT7Hnkl7l/lNzCqODQo6Ccmxwtb/gwg6Dax63zqGAqqzs9yTu6DuBemgPL8i1WpXcX/CbNBLY3W/Ok+Z851blB8cTY6R/IRDuCL+DYNNI6h3FtNYV9tvcZR0WZmnfbbCD7DQLaq9lM9qHV/NMK+ZKxFzpxVet6IePZkSl1VDa9FPzx2jxoAChnC+lklClSqtveO5WvhFkYz/SWBbLEFCs2x3T1KccYT5Syr0S4dW0BKAQw=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(55016003)(26005)(2906002)(82310400004)(508600001)(426003)(16526019)(186003)(336012)(5660300002)(33656002)(9686003)(4326008)(86362001)(1076003)(8936002)(70586007)(356005)(6666004)(83380400001)(6916009)(36860700001)(81166007)(54906003)(316002)(40460700001)(7696005)(70206006)(8676002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 05:24:04.9753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e35aa70-79be-407e-d936-08d9d3f96b59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4718
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 01:00:43PM -0500, Michael S. Tsirkin wrote:
> sparse warnings: (new ones prefixed by >>)
> >> drivers/vdpa/mlx5/net/mlx5_vnet.c:1247:23: sparse: sparse: cast to restricted __le16
> >> drivers/vdpa/mlx5/net/mlx5_vnet.c:1247:23: sparse: sparse: cast from restricted __virtio16
> 
> > 1247                  num = le16_to_cpu(ndev->config.max_virtqueue_pairs);
> 
> Address this using the appropriate wrapper.
> 
> Fixes: 7620d51af29a ("vdpa/mlx5: Support configuring max data virtqueue")
> Cc: "Eli Cohen" <elic@nvidia.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Reviewed-by: Eli Cohen <elic@nvidia.com>

>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 84b1919015ce..d1ff65065fb1 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1242,7 +1242,8 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>  	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>  		num = 1;
>  	else
> -		num = le16_to_cpu(ndev->config.max_virtqueue_pairs);
> +		num = mlx5vdpa16_to_cpu(&ndev->mvdev,
> +					ndev->config.max_virtqueue_pairs);
>  
>  	max_rqt = min_t(int, roundup_pow_of_two(num),
>  			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> -- 
> MST
> 
