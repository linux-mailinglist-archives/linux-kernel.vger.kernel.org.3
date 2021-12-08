Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B038746D6ED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhLHP2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:28:12 -0500
Received: from mail-mw2nam10on2042.outbound.protection.outlook.com ([40.107.94.42]:62912
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230229AbhLHP2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:28:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZgfkE6jtPkAvcg9WeA9C23ds5uwa4Cgwnu8B7jncDBF7Uu/mN/MmRNSZFo9cnTuPBPcG66QuJjwoFC3xX83ZI0IbSDs1HHpk7dHiNrZawBXFTD1EiBAaU/6QOMjbSN9cCmwdloHuBCGIxcALPPW+RaHnIAGn2glC6JPtFI9DcwF5fvAJdM5EYXz2MYOsYz2NVwYJ/pSGQVcXJ1mh2ZJcUXmdEwrXXZEnStTf+m7kYb07JTw+DoLQptngPOKVjWIySi3Nl+PSsT0Mx2XSQlYith0rp9HwkF4ap4DTuYWKurdexQbhKMjuAqllsKCfn5DVBKfSOVNw9mkSsGRAo+9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRDhvVJbfSDeaFykA61fFqezhrp+cmimoTuFM1enu4Y=;
 b=GHAGTcwRhmzWWbHNArRhhk9zvdPz4+oe8CdldsdgkxD9yxYAmzfBcmcepFWXycCSecrusKi/lc0mNjRBd8HdpqmXnQZq3K4WNT4zpLF2PXbtSxsGyWN+d7r3Nn9HWo4ZHg9+WlCWEYqootkDmfR3lr3o/I/Bx3WwH2cnFZtiOSlYOArkB4mwcTaD+mtq617+baLJ3CQiGd51q8a2GGszgS8W4XucX7t6IUIVBQ0+61Hp3fVJAsfzTa5PpFGBtJ7g5ItPv1bdNvW35F0Kqck1I0JfoeugzFL17hgDD02D8BU+dr1Go89+RgcTOwqRA5b9/mN1ifOAq6G62pLTLF45yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRDhvVJbfSDeaFykA61fFqezhrp+cmimoTuFM1enu4Y=;
 b=FitXWTDHRu4GfuaHT/4yjNYoQVYj8ShvxigZ23HoxBZjZ/omhw4z66GXb1mdLbmZkSLtzKXjJwG/FTM8FALTn80/r/E8mcpJUYrSUAvUaf9VRr3ozD3ZuWmLJLqzpbf1OgfbBLjbQh/Mo3p9WnJTwOBs7EkwCNDfwCHBg40uAHUYmU6QrvhSGABvYEgE/oW/oFUNA/BLWzfNprLpcdDxuSgTWwj2pWwuy6vGkKtE7zxpra6FlF4W4avjEBNoILgL92f+eo8Gz5NoKb6wFwZZMihuA9hB/njd8777r9jeaaCrevBFb0HfYPubrr8nGRNpu0o1MV3u6pI4EydT0axcgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 15:24:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 15:24:38 +0000
Date:   Wed, 8 Dec 2021 11:24:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Boris Pismenny <borisp@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/9] drivers: Switch to kvfree_rcu() API
Message-ID: <20211208152435.GA193770@nvidia.com>
References: <20211124110308.2053-1-urezki@gmail.com>
 <20211124110308.2053-5-urezki@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124110308.2053-5-urezki@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8014fd33-7d21-41e1-1208-08d9ba5ed8ec
X-MS-TrafficTypeDiagnostic: BL1PR12MB5319:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB531953871C2271FF8EF7CE7AC26F9@BL1PR12MB5319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sD9OyzWRoNBFh6VU9EGxabj6My3bkWSjQVqb9ca/rYoEKWf+78aeXJRUjC9g42phY3MGgSOnsFR0DU4QBw5HZ+KzqTfidpQq+Jf5TmS2HFEIg62y9jOvAnB8HxJp+wKg7NnGEFyW6xkjmclc51dp5QPASOWG3dJHy/pG9+Jt8weo2tQaqDkTbnb6Do9Io8uEuqjgE4rtmGSvJlEJFktqqBundLG8lE6VIUDa4sBvWGEciYzsN9ozLqx5eXbDTsXGD9WOAPZ/q+VwZIgYU0vYt9p/OTDQnsHXMvJlHh7BPTiPUAtgC2iepFrt3Uk3BPyx/tsxvKSlvlWm+3dP6Z1EByS68Wk+UD6w6R/9nk9YNNuJQ44repWtDMK3eKTtV9IasOYh0CL7r4fTvGAYO73U+igNspO3By7y5qVFMWLs7hMGpXxWu66OpGOuWi6LHthuoYBJ0gFxmhmeF0MpqvIRSJgfEG0gOrPX66cUpoff1yeKp3io+3xwPPGPNKyuiAHIC3LAmqwDjnxgPSejhloJ514L1QWjsNf0V7dIhFG4+pH0m3A/yvaCIiNy3dp51UvDenla8gIgLGE63nb6pJCbLJBCAhK4sLxhnMonWiCARJgpV7xvZbgtUMjhpiucUuqp2qkLBcTlBhsJLZ61d8WEgE2raMRIeCcqnYcaanpg5KYOQf4WsLQYg0qk+0Z4uS6f+5gb6VjcKh/uvXpgKYgDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(83380400001)(2616005)(6486002)(2906002)(316002)(54906003)(86362001)(8936002)(36756003)(26005)(186003)(8676002)(6506007)(66476007)(33656002)(4326008)(508600001)(66556008)(7416002)(6512007)(6916009)(38100700002)(6666004)(1076003)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?whiw9z0tNYe4smM6cWhj8BFXD1e1iZrEtGPxfXi7y1wn4JyT5z5YastQvZue?=
 =?us-ascii?Q?b1yS/Ay5woGdbkX6TZEPMHxXZX9lZuNq+fm7/H6iY27k+gdKuKjwtwRLx73p?=
 =?us-ascii?Q?wmStKq0wC0TTENjXRiyNkqIvYzYpXj16sySiiMV9yIx8HjO8b2iSQF6W0vsK?=
 =?us-ascii?Q?Kf6+vEYTXWcxleKttLl5RZicc5w/hIlalzR2/Icv/6TGhH8Fqffd3GYwJLTg?=
 =?us-ascii?Q?3VddB2/PvYBYxUUzqyuvK7KOUWPRxWxpvXmZvN+wshqC6myQ2P0t1SYT1Izv?=
 =?us-ascii?Q?RFQqC3PwWgRULgi9u34K2wMnk7rSGvWkrqLOhRnbPXKsm0ZBhRIBsjR/Ch45?=
 =?us-ascii?Q?xEmO6Icpf/iUphj7Dbw7JQIEo00HZ27Zf8Fyu3NogiAt/CWKooXQStsRRcRa?=
 =?us-ascii?Q?92dLerQPREVm2/FdmSvaM4+E9MyUgN1TrTyWymsoOOheTAAneWK+hJN1cej4?=
 =?us-ascii?Q?+iCgvHFaqhk0FBK82sz5N6PSXhKUzVxkMbXtIrHPvl2O2d/EeqQshiIrGWiD?=
 =?us-ascii?Q?tZ+1RHgBSGVA1xpvBmLyk8IAgsj0PXCPBGM1+0Mr352ezvG3lLf9+QOayJCZ?=
 =?us-ascii?Q?zdsBv4QPiodSDrFqePJ1timnM8uZFaIhw8uzoJNX1iTVUKxPeUfWyBM2An+/?=
 =?us-ascii?Q?YNZAVHL2PJoA9tnDYxXbbeQ+syh0rHbGsYRd8AoqBHrHKfhwt0fblhsJDsiI?=
 =?us-ascii?Q?DPu3/Xt1sBYyHoh9Yukk+qek/c/7Z38sxH6YS5x4Hee79kk+P/0VcvFSlnQu?=
 =?us-ascii?Q?VPIXhmefw+32mqhogqK3/wxealc9POE78DFQSKRKH+LLXh4ct140ruTDYukp?=
 =?us-ascii?Q?Sc3pXa5UbNAtwiKnDDDJpMxjprDrLSfa+wvuE60G2ROlq2TiKtazOZOYPZp+?=
 =?us-ascii?Q?jPvky4A0azfIhAqzQSSjhkj6a7AiMkcAXERt0wSQMrDNUDm2tRxIsa64pdzA?=
 =?us-ascii?Q?Fq1kwosZF7SNKC/SKm/AMCMb7Sz5j+03dzP6e53mzFvx++vf9RzXGvWIKuq1?=
 =?us-ascii?Q?OinCyy8tFCdlukL5ATq7PAjSo7IQ9XjdE9QveO3yFsGO6myV4RmVw8zVpUsw?=
 =?us-ascii?Q?jQBG6wY75ppLLJbbX0AInTha266JT52Q8V8xZjJrnGgqSc+CXfSDwTAXeh/g?=
 =?us-ascii?Q?0StiU3QQvanXSCEkNOBfspXcZtUgL1i9nU4CpsXHTc16LUo91CScwZ2/5Y/c?=
 =?us-ascii?Q?Oj0dyC2/4fZup0k7DI0pDlZfq8kFSyL186vK8Q2aKdy5cvQP7p/0TxDVboGt?=
 =?us-ascii?Q?vrOydIZ+Yqkp/dasYbAmwvCTc2wd6E5BAZl44PPfMWLX5vx8wdUauasMCCnB?=
 =?us-ascii?Q?OB7GNpeEoV1lcWIrPxLy9q44ycQzSb+lnfniy2H2JtlLt+SSH/liEcNOUqV3?=
 =?us-ascii?Q?XivBaRPxt+9bhdJv3LIWlBAI8WMi2/q7NSPs8iMawziwEcRiXcyA2WOhyM6N?=
 =?us-ascii?Q?cdsvN8C1iqjS1rggSdCSfkC9ETz3lb3AW1u/J0uE0xmNPZOka5ZrTk18B57b?=
 =?us-ascii?Q?TYkBs6mEOEIsF3KZTGjrTeA78390pzeI72ibFicQC9cipGVwuf68TwWflyFv?=
 =?us-ascii?Q?aeju9T8moHAU1UCLR2g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8014fd33-7d21-41e1-1208-08d9ba5ed8ec
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:24:38.0864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YjzHM0mmrC/zow3JtbCEXZxsSu2S3HS4me7F99EyoQKphhAuaDW7TTwjkl27rnO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 12:03:03PM +0100, Uladzislau Rezki (Sony) wrote:
> Instead of invoking a synchronize_rcu() to free a pointer
> after a grace period we can directly make use of new API
> that does the same but in more efficient way.

It isn't entirely new, kfree_rcu() has been around for ages and any of
these call sites could have made use of it if they wanted. The
kvfree_rcu() just adds the twist of transparently allocating memory.

We really must ask in each case why the original author didn't use
kfree_rcu()..

>  drivers/block/drbd/drbd_nl.c                       | 9 +++------
>  drivers/block/drbd/drbd_receiver.c                 | 6 ++----
>  drivers/block/drbd/drbd_state.c                    | 3 +--
>  drivers/block/rnbd/rnbd-srv.c                      | 3 +--
>  drivers/crypto/nx/nx-common-pseries.c              | 3 +--
>  drivers/infiniband/hw/hfi1/sdma.c                  | 3 +--
>  drivers/ipack/carriers/tpci200.c                   | 3 +--
>  drivers/mfd/dln2.c                                 | 6 ++----
>  drivers/misc/vmw_vmci/vmci_context.c               | 6 ++----
>  drivers/misc/vmw_vmci/vmci_event.c                 | 3 +--
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    | 3 +--
>  drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   | 3 +--
>  drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c | 3 +--
>  drivers/net/ethernet/mellanox/mlxsw/core.c         | 3 +--
>  drivers/scsi/device_handler/scsi_dh_alua.c         | 3 +--
>  drivers/scsi/device_handler/scsi_dh_rdac.c         | 3 +--
>  drivers/staging/fwserial/fwserial.c                | 3 +--

These all need to be split to single patches and ack'ed by experts.

> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 44ccf8b4f4b2..28f4d84945fd 100644
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1679,8 +1679,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
>  			drbd_send_sync_param(peer_device);
>  	}
>  
> -	synchronize_rcu();
> -	kfree(old_disk_conf);
> +	kvfree_rcu(old_disk_conf);
>  	kfree(old_plan);

For instance, this, how do you know that old_plan isn't also RCU
protected?

> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> index dde1cf51d0ab..0619cb94f0e0 100644
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -7190,8 +7190,7 @@ static void remove_one(struct pci_dev *pdev)
>  	}
>  	pci_release_regions(pdev);
>  	kfree(adapter->mbox_log);
> -	synchronize_rcu();
> -	kfree(adapter);
> +	kvfree_rcu(adapter);
>  }

And this, for instance, just looks crazy! There is only one RCU region
in this file and it is not protecting an adaptor pointer, it is
protecting a netdev. No idea what this is trying to do today even.

Each case needs to be audited to make sure the synchronize_rcu() is
only protecting the kfree and not other things as well. It is tricky
stuff.

I see you got an Ack for the infiniband peice, so feel free to send
that file to the linux-rdma list.

Jason
