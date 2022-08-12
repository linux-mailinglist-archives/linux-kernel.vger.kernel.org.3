Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E015911F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiHLOMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiHLOMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:12:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF34864F4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcDsf1MREiZBhVoxtBGIOGyvjXxCwoe8jx+PdPeyA4BSoBqJMW4geX53LBwa1uz+BsbwI2qayH0AfhxYLaj3fwGLE6kzn81BO8DgqxBrY3/bnHx9/RmXKosiHRJ+jICJ2eY30BdE0jlg8f8FDZ6pMQfQyrEvBpYXC+w3COjMtkn52cBUG9E2N2MdpIGcIs3YUrIv/KV6OVknHMH1EfeSHrUnaKq4391xwfE73PKHziQGoOlOEZo0UUUONjtQ5zIeA+f16u8xnASTnnxFwmfKVTSuqmu1+bra+sr8zcsRbtQ9ojCdeExCg5rKDLET0pV6jJchS0GISBrxCR9m+7wPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq+xN+TlqBaYiJO7RC1L/lS6E9HwOy8jO1ZH2OoJXhM=;
 b=LPQ/E7bxPJdMesqNVXhq+2FO/X7vqRKDKJSQhMuLpQtP6BiW4GTIpowgkd02B3Zw9ie9p/onJp5No9HdX2iZ2P7zoEhniszZi265SOW9zxwOL5Yl8ycaczg9sfCBzHpiS7x1xsAqA/f6zub0hBCktzI4U9tcF8A1qqbV2ja18vfxxcZfZ6l4DrzW2sBxdtv8bPL1KYOzOnXaZ9b5FSuV3odVaDQR03/fHLwDrZd2YfUabTD4f6e7z3vSnmQRShtJA1+JcB/q2/DXwYVrpxU8L7E8Jtbg6Zb4btik91FSfnCff1LkkXJNqfBqRQvxMkNdITvIpt93+4AMkn+E9X2quQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq+xN+TlqBaYiJO7RC1L/lS6E9HwOy8jO1ZH2OoJXhM=;
 b=XSgL99SA8Zrm8zotJnuUL5fwe7gl0LfOkusv60NKmaZnqTGMWWy9Q9d+VoFTNZLoYAIhYZhl4C5f8SNSWwWYdmFGeFZOvVjOnC0NVvqAB6k+T+GuoPSNP8SXD1GQpcK9oJRq2m+Br2Bj6XH92CYvTuXIKhWdzvlf5l2XgsswhU4vrkF5O5OGMLq3kSms+G3jOKQbXB2o0Vn/CMQTMnEI9JkmMmhYMTE0F9pjQ/dWpKGXi/2NXlVBPZ7vKQrgjfn+zT2UDmSeG7n39UVcXeDADM4hnJGprztRiOCas83P0sCHc9/q9MxM4xWF87GGL07x1n4Xqc/AE9d8kYvihyH5HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4716.namprd12.prod.outlook.com (2603:10b6:5:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 14:12:33 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 14:12:33 +0000
Date:   Fri, 12 Aug 2022 11:12:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: drivers/vfio/vfio_iommu_type1.c:2147:35: warning: cast to
 smaller integer type 'enum iommu_cap' from 'void *'
Message-ID: <YvZfz9z/TGzuzvDQ@nvidia.com>
References: <202208101119.7unZx9dJ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208101119.7unZx9dJ-lkp@intel.com>
X-ClientProxiedBy: MN2PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:208:234::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 556bcfb5-4bb2-42eb-bf6e-08da7c6cb316
X-MS-TrafficTypeDiagnostic: DM6PR12MB4716:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JrmTp1HE0a+DvcELxrKwd5PHkHRfAf5A8bJ+h5x0s1AgW7bN7lOCz6ROl7AVpVSQTG8iREc9+vIt3kJAVkxnO+GoXsFgOh7D1pEOIJy6H0GUk4fRbjW7h03qWjLkuOuS4aqt5H9jhLFB7nrjwvGqmfTrtBLeETcTANfMsxm2nNVuCQMTJUsEr0dXjJisZsx052qvZaHyMrO7UKIRA1WobdV8lX589pAZQ0BbatHhZuc0rVrIN2rqwYnWFzld73vHQfpTloJ5YS3aCHoBNITPbs1afihHG1/fmnYtNooZwrsAwiJZYzbDKKv49affFh7lCdwGQEoaSyL86aPqaa1gS0OUqxHOc0x8tpXptazHA9m5RvdnBTcQGOIswZ+sAxrafD93JWkh8y3khvGR744+QaJ8ngVH6ND7D4a95H/7xdopzVYk7a3r7FnDTSZAagpku38lTdzNM6pWcFozKvY7IPzBiui2ixmMcKuWsGaZJoViifC0y6fGOB1ePQYuu+O7hsED/bY8yMRgXQpLLkGfXwoP+9sIRLxD2JMs+MpcIMstXndkwt2BrIPnwraXLdmu+x5LWR8sACmlbj7Csv4Uc4nAzS5a+LEaBrGiavyTpVzgzzJj9r5fchk4D2c159nHKy0Kn8j4vHymC9VYEbzPMe3zPshYL45NmAjRe4/KUXYNf8B5qY+jBFJTcETs4dNXgNpa+5TXpPS4rKikL4Jdedk7doz8vPIRPRkutIVEFSlYSsgQhJz+NIE66YXLDi+pcNJAAXG5tyg5ao55tdMTQQe2MNbtYdQGiZouG+ZyCJd33aqR7qvcDOT9UeBnzKo9qurVsRXAVb5iEeMzTSWspnXikRDklrxGXSOahJnoQOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(26005)(38100700002)(83380400001)(86362001)(2906002)(6512007)(6506007)(36756003)(6916009)(316002)(54906003)(6486002)(966005)(8936002)(41300700001)(5660300002)(8676002)(4326008)(186003)(2616005)(478600001)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iPEX/1SzBh/xT9yiOpxgHkY4eK5Qig90bgSqmSTt0cRMyXYdB3w41Ai7vfDI?=
 =?us-ascii?Q?aDqmvlrJBzxomd25iWDw2fXXyiULhu3kv+cFShOXU8antcgUPgrA5c92gnxE?=
 =?us-ascii?Q?SlFT9JknfP5zOxdMY6HlHphUU0O8b9OYq2Uv0s9H1/BTFcV0raPgEwVCCft/?=
 =?us-ascii?Q?Wr066qykikO+NvHjYdL9P4cMQmePrraIXf9uMETsD9mpT1KAhsrg78XzopKn?=
 =?us-ascii?Q?53fHBSW9vDdDGSt4MPuj0o1V5SCvvMGTp1Hro9pJ2WJ4l9lfkqwHoo8ZuHZf?=
 =?us-ascii?Q?cD/LHoyiaYwx+SZdJc2xrolYvpa+Mtxxdq5qZTNuGWcTquRnl2AVRG8t4jKu?=
 =?us-ascii?Q?hLADxDO+tVXDeZRgDQxfFLtFHiiOsNBZdOtUucDgk7slrxoEjcdSh6cNbkH5?=
 =?us-ascii?Q?682cfJEvkssvROKCLT7iA7lflj+26D+wywO+TvyuIcIe34d+6xaYSu5/Sx22?=
 =?us-ascii?Q?/nBMS+0GCzBNVl2PqYvkB1U6zphc51SbGoELiFnWUlfMLas9GK8uh3oI5H4c?=
 =?us-ascii?Q?gxpEslbpkGU8BqIimmVaHqjujNPL/vwrMsDAxNskiDx/kpwLko/7LM4fD6YN?=
 =?us-ascii?Q?7w7mGBQ2pkf1CVHvuC2jD90r7mmMS8b02xNEGM0Bv4OjyW9XindhtJ/UKBVg?=
 =?us-ascii?Q?JuyCSChHIq1ou56qNm7tvfhV+pO1LGfSE1BVPodckMo9JeIo+IYFZNh2SzBz?=
 =?us-ascii?Q?YzVY0R9+rEXI4jzlmAZ9O5mZMwJDZnpL6+h7lTsqobhZvgfAaLJOyGHVXGW5?=
 =?us-ascii?Q?0dcREUnPo8rvDc99ObPbA+OMza9+XAznOx7aXCu8KuX4IUDRklxUboLl4qoF?=
 =?us-ascii?Q?cZv34qjB74fciI+Sw0w3TjrWuiDFVu7TnLWnbtOL7PTKgQf9El2MhqfCwIDW?=
 =?us-ascii?Q?+cNEObic+X7os5HYu1vYp9hvoH+XpQxm0oZqqzN+IrtroBtjgyn2r0fOkuqF?=
 =?us-ascii?Q?Fi4NQGAFyP/aDcR21suSt8XKhNj9al+7IAit30d7cfKQU070gJXqbMXxRHWm?=
 =?us-ascii?Q?DrUXbfUFRyrjHjYoKxcYLlLOY8Mt7W6VZXS3kqbf9hbD9vk7vs3tqvluOiQx?=
 =?us-ascii?Q?qZ5frYzIlj0Ca/+LlUzZd15U2SG1BDYrgB1WkO2ihOOB7hHN/YBwKE3cFxX6?=
 =?us-ascii?Q?5KreDaLl7+pU87DHX5HvmXKD4zoEAelq9UCm65RB4+0gw7oF6O9Nu+Ff2tRn?=
 =?us-ascii?Q?CNSBMQryUwkw4E9xuVrNFmWt9GQivf3icFExGQrVtkqtru7gjVSHB6k92Ijr?=
 =?us-ascii?Q?4vrIZR3SO69DmLvusmkpSPkRe9zmDcDbXJi85Q/Q9UaGtio6Q35WutWIJYJU?=
 =?us-ascii?Q?OILEnHeDuwaZPI/LK3o5BhYicWKkAWYOb09MX/ZrxsRho7vREtJJs4RbNpEP?=
 =?us-ascii?Q?80SnbmkkET5T8+gjJ7+GI1ij3DjaQ2gUvMOC56469BVBqBHK5MB1ihs+yV8O?=
 =?us-ascii?Q?kYOrWjI/gQr5ZmiFtpHFvMQtend6CXpeDLEUiRc/HecR+w2Uv+f1NQE+Uw1a?=
 =?us-ascii?Q?yfjco21x3jnncTaG7zafCvMC6zgK/u1XANSKZsFdLRKxbwQmrmdaXVa3zPT7?=
 =?us-ascii?Q?1FuzN/lRuUh/2WKikwkt4yHX8cqJADCbdzoFUDvc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556bcfb5-4bb2-42eb-bf6e-08da7c6cb316
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 14:12:33.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yj1B1r7xBLfDlt+5y3zQVAJmpzX4gjk6y+Mj13rkdSYUuqP2RVaJox7bWaO0LJes
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4716
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 11:25:15AM +0800, kernel test robot wrote:
> Hi Robin,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d4252071b97d2027d246f6a82cbee4d52f618b47
> commit: eed20c782aea57b7efb42af2905dc381268b21e9 vfio/type1: Simplify bus_type determination
> date:   6 weeks ago
> config: arm64-randconfig-r034-20220810 (https://download.01.org/0day-ci/archive/20220810/202208101119.7unZx9dJ-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eed20c782aea57b7efb42af2905dc381268b21e9
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout eed20c782aea57b7efb42af2905dc381268b21e9
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/vfio/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/vfio/vfio_iommu_type1.c:2147:35: warning: cast to smaller integer type 'enum iommu_cap' from 'void *' [-Wvoid-pointer-to-enum-cast]
>            return device_iommu_capable(dev, (enum iommu_cap)data);
>                                             ^~~~~~~~~~~~~~~~~~~~
>    1 warning generated.
> 
> 
> vim +2147 drivers/vfio/vfio_iommu_type1.c
> 
>   2143	
>   2144	/* Redundantly walks non-present capabilities to simplify caller */
>   2145	static int vfio_iommu_device_capable(struct device *dev, void *data)
>   2146	{
> > 2147		return device_iommu_capable(dev, (enum iommu_cap)data);

This wants to be written as

   return device_iommu_capable(dev, (uintptr_t)data);

Jason
