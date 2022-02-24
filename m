Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B84C2CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiBXNJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiBXNJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:09:06 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A83237B5BD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:08:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7ovStxpFB8VWiioqu/6CqDPhAAta7P8vR35QPIIS9Rr6y6rYAviz5LgP4xq7mrB0CfdnKNWNZ5Yh3j3BO0pGBky5ujuHP+HocFAnaURM7N9eu4+ncKdOOcO7D0YQg86urfp/PvEGUBYWPmOjgXmxUszqePR8BTMUIeXmGnrt2G3Go0Cu/QpLp2dyqmgnE5/0mdIHxuJdkZz/9CygYwJamhRgmpLHbj1RETY5gRBqgeVdA8JhvXz7n3i6or0/R5j2K5Bun1alVKCK/po6Ef8z/Da/EFbaFDjt+VFrJQLnfjXMhKT4ReXetYci/kxlpPFBiZ/UXTBNPOJroZqWv1tUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGQqwZ+DiPKB7lf2HLI0FezsuLE+6H4PFN0W/gWiYyg=;
 b=C8k0SYgYeJN4R8aMm+X0YF2erhmU4kacS6qjyQw6nB4Pp+2iYekt2bWoNQx+DUoriz99oL1oqOiylB5kiWCSas/dy5OrXx/TDjXHfWA9aqWltP1GdPz/cfgv11XNq4/bwev7VSqWTDxpOBa4PGXAbaqyfBsqzOJVTXjZSUcd/Jk/SCfCDKMoLOsYhoua+BRkBtQ/6MEbcshD06ehWYqe26QPDJbEhw39x8v9VQw8CzY7M1fA37YZIbItVWD4R6SRk2gADVVWv7a3DLfo51XQrhpAYSKzm+GQIMI2edtgEyu/5voKE6nur3skMBV8KoYQoReVkD7XAOnA8VTIOYqaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGQqwZ+DiPKB7lf2HLI0FezsuLE+6H4PFN0W/gWiYyg=;
 b=PNboHBIh7OfTdE3CxyNKJrcdC0KCjBhWlX6n+IClBcwfCHHQEPqJgeylKwdoBO3sdQU2r0J+jhGXtbYSdWFINliAOy7xxOtO89cAgCqRzYdGwgoKM6dbTM1aAaGcnIOtzWOuirfOnuwA0T6h4vQJYSXX39IT4W/UJd1+pJ9vxM/SsjYc90gahlDnt1puhS29x53lGCmhxZPiKCFwN/PFKk9lb5I4xCEv9R7zqjhlt5oEUGNKsBD7DiywyOIlYQer2jz344oDzSksiPrJe51WOC4HX4/ak4Z8JqoaFviPoxmeckNJK/xiED90Wo6eH5TylNAI9JwKhPSU2kd40pAGqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 13:08:24 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%3]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 13:08:24 +0000
Date:   Thu, 24 Feb 2022 09:08:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] iommu/vt-d: Fix indentation of goto labels
Message-ID: <20220224130822.GK6413@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-9-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-9-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0275.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::10) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7789e55-49fa-4152-5fc6-08d9f796bd22
X-MS-TrafficTypeDiagnostic: PH7PR12MB5880:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5880F0165FC24E735614F209C23D9@PH7PR12MB5880.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3sHndOxAfNjXXtoGYNaf76J2ZFI6Xid1EfMUKeTe+NAUaXqKjofYeeIZfhINv3xIWE0y4Qr1vPgNOQcVLkfQHp8VQjt45/9lFsTd2USMtsVFd9b1Qsyu7Qlq1sCf970Is1tv6ULNgcufl3qa/OmtvnxNsIjl01XEfucSgq/Y2Qal1YsG6yGnVEzuhsjPJOF1MhpsFGkT/nQ5xZc4Rb3eCFWLYE7641R7eMXyZ306sVNEnVYzo9vMldqoEXtAxluDPfFN8xKnheFsv+Kqc5hGaD0EuMTO5hPW5toiHdkYWGTHMSiImqRpLDrwPDXCm3vuuR3ss7EIUBqp3udJmAVr5Xatzoc8wqibNwjj7Z/sXn8/fE/YYXBPorVhsm+47TYc62ggPUMEtftXRDShqEltj+q325SGMLXiLQb6/fhgm3Vou2Q/kWnOEiF5/ChztvZyu+gcCHKBtIbAA8q1GfgjHfexCXS5MfFuiAcuXVL5hNH3fz25jD5wma2t38QmUyQVFNmYv/xbNVm0p3fbzZbHE4C0GPC+Z/P/ZVv0olnqxQwKApuhuvy+I2NOuKM576jLbzYKs/HivjBYra+C3N22UeuZ9wn6FUf/O6pOf6FsmQPxOUCKUMYim8NZ2VFBjHansAIAY83nBTBGtBS7Y+Bkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(54906003)(316002)(6506007)(26005)(38100700002)(6916009)(4744005)(36756003)(186003)(66556008)(6486002)(83380400001)(33656002)(4326008)(86362001)(66476007)(66946007)(508600001)(8936002)(8676002)(6512007)(2616005)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F/Q/swX5N70+Gb9wHy804aDXA3mtogbyzywOHZdT/XbumHpd2X+EWAaWEg/p?=
 =?us-ascii?Q?374givYe9aChMw6bovxI6N88E+ksSaI/qKJ590PyyN14w/FFZOurI/NJ5ekZ?=
 =?us-ascii?Q?fMVUSxgKLemh2T/LC5Kv78RO3eLw9LHuj/k/uWzkF9dIYIvmuiZhthEc1AA8?=
 =?us-ascii?Q?QpUF19cAZNsCdpdn0DQ1nzKwtGiIxREDfe8J7CnXFnORvKOHEKRMKuJEWlho?=
 =?us-ascii?Q?4rm6E+BWLh9wq6KVAIwcY/Fn3fN8JBQnT1XCTl5EEJOTzjEDvedycwjx1wMu?=
 =?us-ascii?Q?KVVJf3wrLb0wJR2G2PEfN4YQfhvmPQ52/yBd/VFNWxu1E3/FAbuvFZUEaSiH?=
 =?us-ascii?Q?ys59B8PmjBvNkBHDAoFfTvFwCT1XJTHrdiK9fJHv5EjarwVrAODhqzDRrQmE?=
 =?us-ascii?Q?VtICG4GPtSHhl74juQQmfs43VTsxhei5wMyWX8emYA5h5L064sE4PfqIKpSf?=
 =?us-ascii?Q?L6mqCn+TCwIbLcC/9Rc+AEeGeplhAKtdHt62e9bGykEBZ2vv6Hsv5/ltp260?=
 =?us-ascii?Q?PqW1ziSHxpja8GBqmxHpg6aOslP6un6HOtBG70YO7L9jxhO9wxjwfjsDcpqj?=
 =?us-ascii?Q?ruH91PO0NFPximv597EMB4c/HzjSGTJegkVR+QgoJJCFm04VDc+DEG8uGphI?=
 =?us-ascii?Q?TjBveCTi7JL28GNdGKJHaNaqTznBQ+xGvu7RplAhBt20WuFWFiLnMIMYa6iA?=
 =?us-ascii?Q?ZC/Jtc+A9b69+Ii9HA8Fb/ubQiwHf6Ak/ZKBVtRo2e/TMq+yEJlSmfkljBKn?=
 =?us-ascii?Q?FDSpfuCKohnconrs4nH4QoG2RrWjdCPdYmws4+ctw+uPrHyzzRoFcDBTgpUg?=
 =?us-ascii?Q?JjSHYjox1xqP1ALYDdjubFXF/3VpXddsHHYnmZN2/kNHVaxkrKTXppA9Xavi?=
 =?us-ascii?Q?JMUJreI/39nh/vPmWN7KHd+eQuaaFV9vl+ViJHQvP4EWULtmkEJo4GQQp1/P?=
 =?us-ascii?Q?wG3IrmfAf9k7oa2DLaoenyiqoR8g0CyPXdhBvRJu3+c54xpJvqZ0WLRtNFQO?=
 =?us-ascii?Q?XVmhmeoPDLcio1Sxg2Wd1CgSSJ+HLUZOt+F8uhUcs1PuyLun3bac6T8Knscq?=
 =?us-ascii?Q?fpI1u2vEMDnnNvJdBU1lLKLfpdnL1bfDsLWBtDVJnDNGFaevLTMb7Kh4Df0B?=
 =?us-ascii?Q?kUZ8S7p2ucmalLau0/KxJnpcKbsDg9obCl48Ex8USSSKWARUZm33lN1TLq2P?=
 =?us-ascii?Q?iXrOE5S6ZEQJSomtp97gMynJm/i+cuyqOH39Gk0KljwRjZFriE7GYBlYCM6l?=
 =?us-ascii?Q?EKAQhfDqBJo97HFkYImZkhsHxKNGaKrk0icLsTR5g0ymCp/NcbgBuJMKLlx5?=
 =?us-ascii?Q?qRH+LTvxq+D5FhbFX40uKR00fruGtV3Q5QBDicSzBcLsbGuBPfDU56PXkoUX?=
 =?us-ascii?Q?i+88XGka/jnhNMasuAoRX8Qsg2q8vcg56az6/Mu9TB+7++j9mGwUQVaSHspn?=
 =?us-ascii?Q?qEl9yixezwqFz6RY9WV3dmfveA+Hmk/6bNTwd93SCFWjMnpv2POq2tP1jBHr?=
 =?us-ascii?Q?SD9rDA8Lfbt09tA2+/BL7uEzC4k66WFBIg96wzma6ERwSTqOeBoE4U/gzx4U?=
 =?us-ascii?Q?3O/i7iV64BeutFVp5M8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7789e55-49fa-4152-5fc6-08d9f796bd22
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 13:08:24.1031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSxLKfHjtJa0qwuI9dLBAmAYRFBoReePyCSee8E/91h0mk6o9ZiePLx+3rdB/TUm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:57:01AM +0800, Lu Baolu wrote:
> Remove blanks before goto labels.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>  drivers/iommu/intel/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

It would be better to rework this function to not have the goto
spaghetti in the first place.. Looks like putting the
'for_each_active_dev_scope' into another function would do the trick.

Anyhow, this is more consistent with kernel style:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
