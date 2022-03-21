Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331274E25F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347140AbiCUMFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347134AbiCUMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:05:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDB317AAA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYxYBOPh+zqD6/b1mz7s4p4+CKJbyH0kOYVAT3kYjxn0fDK+wwxqhD76sdnDvSpsiHo7SVKZuEibeIqDuJBDERjlBU4nXQwFpVa7lz45fy6EAkT3/qcBQQkGmwALxXfqtCiN2WgdfF7Ix/3C8lC9uaSrMiKITR5EnTqUK3n9CEeR4Azc5N0PYJSUGhAfMW3AbwKAEPKh9rCrkV24lD41kVhM5ZsPIYa03Y9/bdpUVxgSdI2ptq9GoP8qZVDqeRgvoQSCComDq11W51ILWS9TVevxDKPYw8zTM5dlIjTY//GuqFQQZML4k/4+Mb/8rH2tTJsHDaRycG16e8g42UaMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yb1TBjNL2NAW8hrQoUX9oQm46UYCgeVWlTYCIHeeDrE=;
 b=RTwFmXUBxp1JZHVIJfHqhfpqFZfTAqH2gRugH4OJ5llYHV+SmrcbXCLY8o0+nKTYzK0Oq3Hl9icRVG5Aw1d/OupUpcJ9yMkbNTT6iiaLEWj4ygYHDmwJ5F8AiD11ZMNgjNLvVHEG7rPY0pV72eH+4cZ9pBgsYTNNW4Zm6H9sXJrIrycWrr/4uzVbrLk0nQANSdNJmMx/UsElM2QzPFavM5Tm9frDYJqcxpYPLNXRhtsp2/1E869dmZONKchx/hmTBm9SiPjEr7HlMFZbG8X+zSH9LacrMddo0qavgt+n+qduAFk8gZT4UEQ7wbquXgDewKdSMtf853gFyxp44HAh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb1TBjNL2NAW8hrQoUX9oQm46UYCgeVWlTYCIHeeDrE=;
 b=FGsuuyrJrWtoy048879R1t6z1kTHv+E88wPTcoZW9subu+W1Noydp8UgYxUZsXxRxh7nfwymDi1R7VWlbEJHmLZDWdd6sqiSoRlF4tdu3tsEuOADEIDhJAEn1GAg5dSeR6c8nYoeWjI+y8nxoETaN1/4wKhZw1GSPCboxxIKbFhCVAsMZ0PFZK5jMvz8eskhhJMPh0hOch0xuGiJsFVxrvRgouTfZ6/nrHYOsTj6sXsGbF5CXt2LdfahmTI7VrQ2wMXNRGwxSTYmMtoBCBUJE/kbrlkwvYcUhpLOyBsQRHxPaenuLBV/SOw+jae1WyStFcqzzCU17OTOwIr6IoSxMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 12:03:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 12:03:38 +0000
Date:   Mon, 21 Mar 2022 09:03:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Message-ID: <20220321120337.GM11336@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-7-baolu.lu@linux.intel.com>
 <BL1PR11MB52714F57E430FCBE97DDAB478C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ec863d22-b79c-2e50-5897-7f1ab5381e44@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec863d22-b79c-2e50-5897-7f1ab5381e44@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1733d04-317e-4554-6b4d-08da0b32d55c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4381:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4381E6006A3C94EAC0BA1992C2169@SA0PR12MB4381.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZiMMHyBbihgkiq4v6Lv9eJWq4W02vIAqXfYsygIoohlev1dXkhr/vzXzfspY69qpGg8nEKIfX8ky9rPvTlWxzJBABKnia6SEPySPRtfOlKU6J6Pa5rnf6PGvapaju/t0DPo6/ClwqyTcQMg7ljsCCRa0vfCmbwYMsxozzC4zQ5iwdui3JWkymDfijuR3mDBdyU9fxV7d5YLo/9mj4jMQOI6s/i+yU9Ws+wZEMPEnVj6tQN88firghWTY2UkFKowDTveBCAyD0rSkmlkY99H+2K7yDVD7sGfSaimQ6tUuPMpbYW49lR6Tq3U5V6G8OLUzrvj0J2xJ4lIzTi8mETHti75wIPdNLN/EtpuVy1+rZDqzl/nysmm3aMDNDAheP0s48ltQLcfpTZ737bp/77Q/crWFnYNdvJINKkkqvJdHFtYGx8ofC/4DIDSLQ+iYl10RoST/hrWxxlqOrVpimi66IyfvtmlfGz1Fjtj0k+P6qqfirgXtLM7cv91lDmvhJc+AGWCNf7HCby1Aj7YgWoi7a3CBL7QvRZxSsby40YXipqT8YyU+qNJSOHGpivF56833Md6Z1LZmrBhZWONF0++YYSN0l0Yg3CjNHsp5KMNl3u+ZWfNInHMhWHq6JhXYqqHcJT0/wnKd9e7sNrNO9+TuIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(2616005)(1076003)(6512007)(6506007)(508600001)(33656002)(186003)(36756003)(6486002)(4744005)(54906003)(7416002)(5660300002)(8936002)(4326008)(316002)(38100700002)(86362001)(6916009)(66556008)(2906002)(66476007)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZpTbNBCG55XqmHGqbwGmQOoPOGjLdEQEFMBjyWHXO0+PIYNgQeBRi8eaUakT?=
 =?us-ascii?Q?i2N9r6FydjEmIiHBTQPunilvqbyTH79c9YH7sxDRWPVoMtay7DY7gam6Qujs?=
 =?us-ascii?Q?uMkQRnKTMSHsjddkHbXqMHsrJvATtCm3mQQQnzTmKeXhfj0jfLfZiOLuPt/B?=
 =?us-ascii?Q?vdwqE1TBbuEXE4jsGKURGE8Vwa8r/IgFc4kKV1syzFfRB2tLkVVu2sQ6tJQQ?=
 =?us-ascii?Q?C0Sr8lb1yfsfueWhaMmED+7PGU0Qe3n6iuG7qRNX/Wyk5g/UZre+6bpew+vq?=
 =?us-ascii?Q?2YXGdIcdc06d+GkM+ZVgd+g0fRVK3UaNv8zJ2fLMgSr/F3nyxbrkHbK+SnmF?=
 =?us-ascii?Q?gGy/xjQPhzRdMi1v5nJNOOG3uJq/HFFcploFomvrd+VB2rrEsj5m+U2sRAic?=
 =?us-ascii?Q?Dyj2hbNNx5JuMSAtSh9Y1Y0GdLyP+u4rpnUzG/ZZjDChoy4781ZyXcX/gXiu?=
 =?us-ascii?Q?1PbaRX+v93MR26mLRPQbpgL1AmGw6xgPwCNwfK6SKvU43GvFIvhAINH40J2r?=
 =?us-ascii?Q?ugJJi67yxmHiS4F98/wCz7qLSDtv04IdYcjVA0VcaXDTYgPOlH0bYjnMAE7c?=
 =?us-ascii?Q?AbJc3ZNXgUyiKsQ+i1pW21NnDH1NrFudaXAqfYO8A16ofj76DntCfVIM+ToH?=
 =?us-ascii?Q?v+8wyosBir59CSmvjJ+9Tg+DUL/dabqeZX59IFa0wItGRXRYpvBCMQ/wKwbj?=
 =?us-ascii?Q?FwFTjwZz5FdevuwATtJXE/dLM6hFbhLXd/nmwtjy8VkAWIWp4lSNZpkUEjMv?=
 =?us-ascii?Q?IKuB9TA+TT5wMUP8OUQ2Yy1RqJkT5UFw2RhSI+KfiHpYIh3dnxW9wNkGK12A?=
 =?us-ascii?Q?Qwa1RTGCjeEdBJCJ8v73N4vVXc1oQFy/pzSJ5d/DjCjS61A+4iDde+RQlobI?=
 =?us-ascii?Q?0y4Ehw33ambGYtM30mc2VMiAjfSNaNp9l/PrGGTsylV5T30qrRoJgTrSyf4B?=
 =?us-ascii?Q?NnIZv28WyxEa5IULE5WAtNThAnzSo6bCp8v4tfHaJaAqhaIqkwRwnMeq0+SC?=
 =?us-ascii?Q?seBXlV9bnyv7OokvulvXzMFw9xMUH4JOvNloDeazIULwlLiFtboOfEcSfL4E?=
 =?us-ascii?Q?xnITUwhM0M6Pb5/uVc65FWgkOXlLtuTGSwt+8bdjxLN6zZqheGvwAh8uvN0i?=
 =?us-ascii?Q?5WJZUdt9yUueQo/EmdE+lGjFq1izppp0LvnmLVEYejvM/L0J16Hu2pS+PNvZ?=
 =?us-ascii?Q?qNlJ8VFES1lpGG/FY1C+09Ja7qqUnD5zlbZJYXfCPt+puTFwMeyjR/3aqMB8?=
 =?us-ascii?Q?o0+Sa65TZoL1JGfEo91cy2/tfSp1CDnwpqKranh82/sppq/W6KXh+9HYst9F?=
 =?us-ascii?Q?XCHR08m9xEVKNeScNOmKOuHpwuRP9/WwVDMCQxJTvFD3a164vkM5QBGwDxUW?=
 =?us-ascii?Q?9FubQ2ofSZL/d9IQlh9FWDiJMd2SxGGvaZiARM91H4PneNljtsfbvWIk/eym?=
 =?us-ascii?Q?gANoXp50Le6+6ASAdgnTGREUsoGM5Elm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1733d04-317e-4554-6b4d-08da0b32d55c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 12:03:38.3314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn7UHJASbRTqt6jESMw4OYe2iY+P1pTgpfpWO2tlNDFUhcGK5kBIia0k0s4j6XBT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 07:01:45PM +0800, Lu Baolu wrote:

> > one domain can be attached by multiple devices, so this should not be
> > a blind alloc.
> 
> Indeed. Perhaps we could associate the SVA domain with the mm->pasid and
> add a user counter inside the domain.

This has the same problem as VFIO it needs to keep a list of
automatically created iommu domains in the mm_struct and try to re-use
them every time a device is bound.

Jason
