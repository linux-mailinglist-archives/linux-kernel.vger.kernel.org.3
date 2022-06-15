Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C600154C032
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbiFODag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242077AbiFODab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:30:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB1D4E3BB;
        Tue, 14 Jun 2022 20:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655263828; x=1686799828;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pfu3lsO8xW9KI4LG2YiasA1zK9lhFJ9aSxvCHDpSiMM=;
  b=ex9bhAGFnQ6EgiS+z1Hx/MVVbjMu4z3/wIIbRgy82Eoh01N4D98Y5Axo
   Y/vWtwKmpfYosxxnO7MMGdecwudKB/kRNBlOPlHAy3EisBtsrhNCo9zm8
   KSDpk+LmoBQd3erRylc0OmZdZYTJMLgLzfnIihNXKDNkxwOnhjII/LaK2
   pSZqH8URnf/Q0Gj1uvhbrg3n+eQRUIPyIvYt/bvR2123xqzIiUIaBA/bw
   FFX3S60eQy1qoLIvI0Cc6ARWjIRQyzmRdoXU3hQCHykMv2xetC+HoVXh2
   8yHcYkFnt9W5wFWAcw2Dh7hviHQoy6/R7hAOTRXmw2J4LkSvQiwCixmZ+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="277610274"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="277610274"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 20:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="830792404"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2022 20:30:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 20:30:27 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 20:30:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 20:30:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 20:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmFXUHYNCdnvC0U/xNdte48D9lmW+K/kp2fQ3QNoGiHwHqROlAkA9mbdDyfAn41pfnK5+SRwdtMw5n9if3fEwdzsdit1teRu06RP5SMLUe5MiLi0RN3ON5xZ4afg1VXLSAA8iiX+bxu+K9qyYwF5Wmae9RARbP0D74d46rNrsjssujnG0gRGjfnPJ4PN66wE7A8hYURet2ktuzslklazHvzSKDJQvNVdYrIODv4g8RYThZNvCEZrzTbMqqUOYpn8mhJYMOlWYPtKrxoD9vejEdlJJx0HuAOKFa/iWjSiNF5sjdfT+az4A1tDdtNc1f6WVXZOKfqyQr+yh3fe9/dydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8SUelKUICtf/FkLw/MLE1YMjAAsTQ5cryD2ojx4Pqo=;
 b=k6E8AP1vW3BGR771/a/Zoy8/8tVofhMa7EY8147Gv+fKKrHDGIPXTLOPF23GiwAlnrFtx2uCZ4C9b70qa5AKzjv5bt5R9O1H27rfzKORvNH23t+z/MoXU0qwYsFhLFENnMdO4QWfTVODmgQjO1QVYrlGgqL2flkJPbhmzIyLirzJBIMUnXuaN01G0zG56jR9ktcmYP8/kUU1af+RWETBHeyVlyj4qCkwzIBfW7Go2kuZUKyo3Qq+jFYBEuq1jIV1/W35nFf5aFaSoNL8vHe/eDn/5KnYwxT68ISlOTsU+6tj52eKS75ryN5Eb033XD+6QsCzjgUE88YZIq61DnxKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM6PR11MB4458.namprd11.prod.outlook.com (2603:10b6:5:14f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Wed, 15 Jun 2022 03:30:18 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%5]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 03:30:18 +0000
Date:   Tue, 14 Jun 2022 20:30:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/core: Add sysfs attribute get_poison for list
 retrieval
Message-ID: <YqlSPYBdOfTaXW6Q@iweiny-desk3>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <57644934bb7af8e1c692735f53c2c415a1ba16d1.1655250669.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <57644934bb7af8e1c692735f53c2c415a1ba16d1.1655250669.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0145.namprd04.prod.outlook.com
 (2603:10b6:303:84::30) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03197a63-c345-4ad0-3579-08da4e7f5e5e
X-MS-TrafficTypeDiagnostic: DM6PR11MB4458:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB4458B36504EB9893D58DBFCAF7AD9@DM6PR11MB4458.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTzTMexEmxG4FCBKvLHw2Zls28HXNCbcjA4S2YWT8MZSBf2wgNUv9L5X2DC39JIH8CvPARYZZd+k7OtOqCrjJox/k10UY+2ZG9waGGc6/z8VewRWCqRmewrm/0bJx7bPnJO88+Qhy7W215qkFlPrRsCC++bFFgtAEPz6gmK0cxte6bugAPY37ZrA2XhAfl32qvTmTEIkVcqOWz/VRrmulNFHrF4NNWMj/GdPVhNn1eJ2wqk9+kgt2q8jvK1UKre8g/y6fdGlKaBOVMnNe+i967DPaH778dv9vulfXvNcn9+nOFKD8PtvvQK8yIPwNXN/SAH63x31EHwARfaXvcxBb8QEuB5lLZpwdLV8OnuEJIIcHDjXJ5bnXsRyi8FSRhvVLovouiIMJTLC91JDALRyur5/Sr5/n78GR189GamNfP24NWueWK2n/cHcJwqpd0pYEtXGaYssyuXX2yrkIMotm9Ia9IpuXwT4YMYxglubucc3NLDtPeqDtGvhNxaT9yNwXhCHze1lhSgNuoOvNLkMK4PAo1oT4wseFFda3tOWcQhe2NARVYBuB6Hxe3bFoUyTo3hg6fvNBwfucoU1RvgB7wQpVavtHYqVDljRNF7LsTEFkWZ2bjjUxg7Ksr21dj9cSmGiN51hQj8GEjV3iVFjtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(66556008)(66946007)(8676002)(4326008)(33716001)(66476007)(2906002)(6506007)(44832011)(86362001)(6512007)(26005)(83380400001)(5660300002)(508600001)(9686003)(82960400001)(6636002)(54906003)(8936002)(38100700002)(186003)(316002)(6486002)(34206002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FJb0aysNiSe5KvqGTjbxQGNi2WUMH+/1ghFKPeSUBWbxb2nLhsr9ReLBXWWn?=
 =?us-ascii?Q?xqsygjP+I+53mJJg8ClKhGCanTaqVaDA5Lgf0iDrtgAfeNXfS7XPDVx7Kkmr?=
 =?us-ascii?Q?4SaZR2hSsV6kr3SREgRpEw2WALDqtrVFStd0rQPfhT5NtZe0MBhP5N1396UQ?=
 =?us-ascii?Q?LxLo++tDx6qnXRCMfwcXoo9jJiw+v5vs/70tlGFELovGXG0mAUYnAgCf+qBa?=
 =?us-ascii?Q?tLBmxRhZsP60KPpJoolQXeQa0so2OvXI8oRQ3JXbVA680qvVQvrx1v6sgwLu?=
 =?us-ascii?Q?THliFdaONUDHDVl/b9kFxDkwYEV2JjXiOv4XT+qAGVWXITwK5ckUZwrSlr4L?=
 =?us-ascii?Q?CPT0LrhOyPQJbeK0N5CV+Ehlp8BgMnFF9kqfPRhmaGo6hSlLkxoG/a9XYEvS?=
 =?us-ascii?Q?/oGrgkqt2PVY738AcWhO0kNcjQQnTYpqKrqgvseUQ2AJyTwjvdg2Dd/9BRjh?=
 =?us-ascii?Q?wuuZQFB1LlNkgxzndmsrN24iR1wqSMjjhXIpiGKk7SdgxGFPAK2AlWDPm0Ew?=
 =?us-ascii?Q?rXiNT9yMLUTzv2uSmrPRIiPqhXCHlqSLGJzTtTJ4ORbrd2GJuHAHI4KZTZBq?=
 =?us-ascii?Q?BZZUPbfZJ0keV4KL9BFhxVeWMIIXbtqAEMdZRW1x06QSQX2EOmVaNePciF0S?=
 =?us-ascii?Q?N8wxhkWImNkloKkpaxobgwlMOafQJllYRd49vFewTxKIvzV3FXTEgL5xBh3P?=
 =?us-ascii?Q?v09WwBu0rKoprW95f8j99yoRvnlAZfFpSCSFAcmptYJyb+2BMI++L2izZ2tu?=
 =?us-ascii?Q?xwm1gMLZ3ZIvdY/BU2WdM7j8f+b7K2Y4jAHzQyAR06veSjkvRTSSyIXJf9Tj?=
 =?us-ascii?Q?qwhoLt61ophGvMIdRV66WcguLLrK/UPkHu6pdHMzJkp+Fbkc9tDN+Xh54yXq?=
 =?us-ascii?Q?hlphDK4In5hSBC/XxicoB83Topn9NvmmFeXmh7PYOmlyM21CU3UbgGVgnf9d?=
 =?us-ascii?Q?4H9UnSnTR/huMQP8j5m7R24RuQnVgbplTWFj8obWXd4kWaROuGGkxuqyuDIg?=
 =?us-ascii?Q?2bX+o3cD8MYSR9RVesg2OuYSGsBKPZtXHpHTzE7RQ8yetZuBghj5WddtCMbQ?=
 =?us-ascii?Q?iFnZUfVpmr5jeom33PmOGyK4F32y/njrLQGzhy0BS4hgCXLwTcXTmYgF2AP3?=
 =?us-ascii?Q?EIYUOhPqKRpIdilJWR/wpXyP5y9XjSpiE/2oKWgsHsEkjFpOKvIqBktIK4xo?=
 =?us-ascii?Q?UbhcolxorFpe1NDlgCG91RUfrkehio+SWQ5fitVhWNy0vEuZvW2JmzamvekR?=
 =?us-ascii?Q?1V1UoOc1xgRktjQa2ypDD6TjEjgrGaHp4SgG/6HMfgsPT49po7M9aKWvFPd4?=
 =?us-ascii?Q?7Nsj0hEE7ygK7V4QCr0vDC6IotorGuPVFRDv4khuMbN3GFJIZKeEmhHb3fVE?=
 =?us-ascii?Q?c62dy0GLafAWYDDmXFRF+ednUoX7PBPSqZ3XaxqO/naWnyAjgduKnushz5YZ?=
 =?us-ascii?Q?Q4RhtfEcWtTt/SfWJJI5MpR5rbZfoo/aCQ5yD59axBQSvjN9b5vMnoZBi0Ou?=
 =?us-ascii?Q?MPbFdbJuZ1XUKgpmgfcfcEaR2sDXqbXQgZr6FWB0FEznuC8o2DDxiGfXhP08?=
 =?us-ascii?Q?syhrZduMBtdbMxpZEhzZBy9BkjPVEtVUuBX5hnV+tJlcr/0KaMBeP9kQZdtC?=
 =?us-ascii?Q?83iq7KWp8ALsjv/DkQYZaJ7UzJkYYYuWuR5byZyRBT4u4FtwS1oPwIAndITe?=
 =?us-ascii?Q?AhBAgARI6RSucBE23HvkWUojr7CuzaS2wLRqtEps0uJp6dnW8h+LjczOX+sn?=
 =?us-ascii?Q?acWw9MzpkNdrz8k9l3wzX+CfeAwMKpo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03197a63-c345-4ad0-3579-08da4e7f5e5e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 03:30:17.8641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pA5YuZCuMnOWF6VvtuF1SzI4wtKaevETHuHMtqDDwmlHigmR1h5RNtTZFJzZAPUSHK4jVUK6UlT3C1k7segSnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4458
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:10:28PM -0700, Alison Schofield wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The sysfs attribute, get_poison, allows user space to request the
> retrieval of a CXL devices poison list for its persistent memory.
> 
> From Documentation/ABI/.../sysfs-bus-cxl
>         (WO) When a '1' is written to this attribute the memdev
>         driver retrieves the poison list from the device. The list
>         includes addresses that are poisoned or would result in
>         poison if accessed, and the source of the poison. This
>         attribute is only visible for devices supporting the
>         capability. The retrieved errors are logged as kernel
>         trace events with the label: cxl_poison_list.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 13 ++++++++++
>  drivers/cxl/core/memdev.c               | 32 +++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 7c2b846521f3..9d0c3988fdd2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -163,3 +163,16 @@ Description:
>  		memory (type-3). The 'target_type' attribute indicates the
>  		current setting which may dynamically change based on what
>  		memory regions are activated in this decode hierarchy.
> +
> +What:		/sys/bus/cxl/devices/memX/get_poison
> +Date:		June, 2022
> +KernelVersion:	v5.20
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a '1' is written to this attribute the memdev
> +		driver retrieves the poison list from the device. The list
> +		includes addresses that are poisoned or would result in
> +		poison if accessed, and the source of the poison. This
> +		attribute is only visible for devices supporting the
> +		capability. The retrieved errors are logged as kernel
> +		trace events with the label: cxl_poison_list.
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f7cdcd33504a..5ef9ffaa934a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -106,12 +106,34 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static ssize_t get_poison_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +
> +{
> +	int rc;
> +
> +	if (!sysfs_streq(buf, "1")) {
> +		dev_err(dev, "%s: unknown value: %s\n", attr->attr.name, buf);
> +		return -EINVAL;
> +	}
> +
> +	rc = cxl_mem_get_poison_list(dev);
> +	if (rc) {
> +		dev_err(dev, "Failed to retrieve poison list %d\n", rc);
> +		return rc;
> +	}
> +	return len;
> +}
> +static DEVICE_ATTR_WO(get_poison);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_firmware_version.attr,
>  	&dev_attr_payload_max.attr,
>  	&dev_attr_label_storage_size.attr,
>  	&dev_attr_numa_node.attr,
> +	&dev_attr_get_poison.attr,
>  	NULL,
>  };
>  
> @@ -130,6 +152,16 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  {
>  	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
>  		return 0;
> +
> +	if (a == &dev_attr_get_poison.attr) {
> +		struct device *dev = container_of(kobj, struct device, kobj);
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +		if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON,
> +			      cxlds->enabled_cmds))
> +			return 0;
> +	}
>  	return a->mode;
>  }
>  
> -- 
> 2.31.1
> 
