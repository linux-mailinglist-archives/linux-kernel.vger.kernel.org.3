Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA43B54FD08
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiFQSmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiFQSmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:42:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121F335870;
        Fri, 17 Jun 2022 11:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655491336; x=1687027336;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=alFKcAGZI9QLRBiJkH+z5Poy5kfHYtcKjsSaLpLxlwU=;
  b=NOAfmEVKEAoo9En5JfWTqsyecyxzqWSJQOFBTxQhMzYC4LXiGtHYP3yy
   LWuiyzhggn0QGLQR+Jo9NpJPf+pyRQWAJXtAymWrEoiMebsCfv3S0Uir1
   tmeExGH0/lXV+Yd913BCgkUZXpqXIiTjXj6v6LVzrwPTCjPdt/pCgPlTz
   hYD1QqTG35UuH/dJCjskEQU3izNVfdyAgcJDi+bwIl24uBv6y8GLBEkok
   JK2dHX1v45lMXRb4uV118x+Iz/jlW73c065+B3slBcq6fiYF3GgJS/s3V
   kvCqNdkVnOwhtpwlQn/hnoBn1s/b7VusJ0fnZu1VdWCL09ql1tB6xeg1v
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259993701"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259993701"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 11:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584121053"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 17 Jun 2022 11:42:15 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 11:42:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 11:42:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 11:42:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 11:42:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYd0FxmMpJdHwypxg1neru0T5J5yHK8LCUeMgeLXRbNElPA1EB15Ootc/r7s+cHWPzuBJdhqP7idrwXPSlbif2ULdV5UEx9NjwD0gK3ZnCH/KsC4nUCWToh9l4omXcsn8Khl+OGGm2ORgIXYtswgDZAmw7R9QhUtJCCNd3PkRaTwj9BXbdX8CH15tZz9Dgxk1KUAyFIim6R+yFvrC9m+qP5Iid3o0vvkzNEFKtkRYtZBkJz0JDtEJ2/gzKAUzsM6Hq0pXKLFIKaKrnhg0HSrmNrEZhzitNMKEsKSFnEfcQFb4WaWYONJPKN6RWlkHJ3rl93IBgmmYW0T8m3ue9TD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcffhEiMnLFW4HJpI2GIDc84DXGnqLCpA2kIBUJBLNE=;
 b=MOk2sWxGLdPnsquRdJzG+nfWVVDwa6wWf/PO5zLnbo6Nn36l0zfsGdGikbK4f+2ygqyNKf3z5C8N67HHoOkH3jtlaqW/ykt08MU38OM3XD6WBd3y4QDqqWWaYUonMwti5Omz9QAvlDyIbkdsvOymND98WsOkRXGBOLT/K9Dx0TFIum/O9+IVcaOIA+ZiVjWnYyGTVWYR9ymIxfCm9+zYQruyd1bowAmisvJnAJQC7D+mR30MD9k/JCzF+rgzWRndKg6GNK5ni+aUtwVRgEgPoM54p8P3uZidQ7C55v1hILm1FIHCGgEkkmfYR/qXOnzhcaKoxE/UdKBYm31DeOcggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY4PR11MB1576.namprd11.prod.outlook.com
 (2603:10b6:910:d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 17 Jun
 2022 18:42:13 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 18:42:12 +0000
Date:   Fri, 17 Jun 2022 11:42:11 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] cxl/core: Add sysfs attribute get_poison for list
 retrieval
Message-ID: <62accb0345de2_81c5e29454@dwillia2-xfh.notmuch>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <57644934bb7af8e1c692735f53c2c415a1ba16d1.1655250669.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <57644934bb7af8e1c692735f53c2c415a1ba16d1.1655250669.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:303:b9::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72d2a96b-49b9-451a-922c-08da509117d0
X-MS-TrafficTypeDiagnostic: CY4PR11MB1576:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB15764A8D82E36CFF34C0D00BC6AF9@CY4PR11MB1576.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTnRS/B849YJMg+TBK+3c2XXL0dPo9UL8TpFFfNrk3sWDv7lsp65qKxAn7C7FeNdRTX3ybgt4xJGV4fausko/n8qxRP8RoLTzcV647Ld7IRUSz3xey1TnU1ZJHK/EVvTAWYlKfuK4pF+nJuy66uEjdZV/4fWsZD/FgVL+n9rpaufQv0WIOdzo/TbXSesQBI5pjsm6DxbcCcczM94wnQ6I2USBfdMbsQ2P/CXAwfHwGbEG3NE0U9dBpXXftmo1xlOnsGpaVS8SZTyPZnHc85ZBBbUneIPgU9GSg7871axxn0oEUwkYQUX/rIqceDj040MhOvarlqBI++PgG6FJKmSuxvkDC7kzDNOYe+9+pwLhsVnHM1MjYXkqQjA6lkt0/7MAvverSbAOoJ5MCSs99x4gQMATdU8yxUvrSypYK3m5ZQ9DqmZPEaB6RjRN+KFXkZgkOR1M/tCgekrOyr3vPoQOyFlYvb1CbAErK5D/DjmuOE1uJh1+nGLn61DVcALiwnuBc34w4RdiRWeCLppL8/fus1u+4rhTdKR0fQygcRcHAk5pDbir1Bwx01gqRE20g6Mi3dP1rzNB15ZNl8iRc/9P9xG2sjI9kuIlLbIHDckar30hCiZmwMfBItjEiZujf6jeWL3RnXKnwg71bmUUNKc6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(110136005)(2906002)(316002)(26005)(498600001)(6486002)(83380400001)(66946007)(6506007)(66556008)(4326008)(8676002)(66476007)(5660300002)(8936002)(6512007)(86362001)(38100700002)(186003)(9686003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TMhjmHVhUKpWtuShP0+NVWlcdtOzIg4FY8k33vnHVEUL1mEOjwBMzds+FjVh?=
 =?us-ascii?Q?tEkB3ryOBlCxujMh+Pl5vnZaPoUELvVL6zc2RI3FklA/p9DwSXl0PYW4bTrT?=
 =?us-ascii?Q?dz4z/iqhkOIdQQRoui4mJaLZJCdlDbbufIhm00wrpquTltPrUqY2CyCVUNL7?=
 =?us-ascii?Q?+iMwMjf24uKBol0rc92kNoQGuEam82KBye+sm+hQQzmS1cGklHHRE6EImIKx?=
 =?us-ascii?Q?7qe6PW9hKJBV4RcW4ytNa6Ip3uBZN8DJlN/wXKGammn4Tv1+OVrVONQdtPPI?=
 =?us-ascii?Q?GyeX1pHbmGZeUm3kvlyQIA+JyrQKpyEMS9d+Kt9k+eu7A34YsjBowoN2OWZK?=
 =?us-ascii?Q?nn0Z7OV2h8Zc+CUtVifEQDUVnsAWQ8TI2r4tOfYopEgzsQAca081L1Y4/mXb?=
 =?us-ascii?Q?+z/xjy0en8PnK2N2tikSTgXzaeCm+Z8sFOvVTgU8aDbCxdsz61bkdQgWqNDr?=
 =?us-ascii?Q?Sj1F64M2FS1DG+0Kd9ie6Ft0IetmATE+98D6pBuN79MqCcjqeuucEA9+QyeF?=
 =?us-ascii?Q?W2vL6ERIXgcgYflhwhwRkMTM6WCLy1u7KvTehpIoMlxJNjVSFvvFK+yzDjHb?=
 =?us-ascii?Q?5qy4fi9UKEbZ6drMtwrftPZWBidyaYlCjn/+RUkGK0RYoGrPQ5aBt8XWpHxj?=
 =?us-ascii?Q?xy8GJ9vqH+50jhGWfFbu84Ivjdwj2Ff1XFMt0eoHYMEyzHz16t4PgixhSkER?=
 =?us-ascii?Q?+l/UcSZEc69mh1tvQIorKEXd5ry4Ek7y0WKLYge8gDVZkT9jX7EjofNf1m+k?=
 =?us-ascii?Q?6GpstjleL+Uj+JA/To7zEJc9yYPazKqDYY7lBuPYUUqALYF/5yD+S7zAm27w?=
 =?us-ascii?Q?qtinaMckaEd9+Bzb1y4Pm9bRS0i7PSHkd/26+V+E5I4jgYGU975NTKbJYb5L?=
 =?us-ascii?Q?6zEQ7MlMf8tkDpm3fJowCHZjjzkmum75kmYZDiNln29DRr9hoHIod6d/ySo1?=
 =?us-ascii?Q?vpnDy3QWqeV1ikbGrJT/qNdJESYJp7L2CKheNaZJAtslL8mhzhqcjONC5307?=
 =?us-ascii?Q?IvqCCp9kugU1C526ghowJsymcqb1pWMtSHudQYvIu4dWQmf3cTJmTS8JS1gY?=
 =?us-ascii?Q?n0Yb/8gaezGmJ2+ytSUfYAdglE48EGf5uN14SDdm7ChOrezWxdO11PyVta9P?=
 =?us-ascii?Q?P+uHVcg7Jt0G0CpuelTxmkhjj72PPVXhti4kWVyuPpI5vhLBYINbakyUUFby?=
 =?us-ascii?Q?0FGppjY3FyuI20gaxDU+qJf86qf3/zCKx1JIf3O06TvtHHY22Ug+XphuB/IW?=
 =?us-ascii?Q?DDpeE8rUN/0eZ9QtIW6GFKKLZ3+4iH+pUr84nBHYoxlqh+DfHpgRRe6ho9t4?=
 =?us-ascii?Q?aFSnykD6aG55oqxSw/YoqI/tcHNSCsFJloLscFF+vBzIJG0fYnEfnZiHX2w0?=
 =?us-ascii?Q?I8RyWSmyvbJgX1KGEF7C9HeS+GnDv7NsCw6/WULfB/9sLvQMGtvhXNR2ZsKu?=
 =?us-ascii?Q?W9mBg0Kew3SMN5Ow7nEOmA1LzBZ6vceUhg53w56IfEMLn+37x0vfck2yKSRF?=
 =?us-ascii?Q?HTO6l5Z2PYoh33RwaVuzacjl+WMlDgPA/TKr5KN0qITZmvu+2KJVxK4EBFEE?=
 =?us-ascii?Q?uhuLp94xyljivFVvMnDZX5xjIZhD6qL3aRSk/HL3K7/hgawVqS9TH/rJdR3B?=
 =?us-ascii?Q?VHDk1v81NksZ4FYihcE42QcAzydenoYFXZLXzEwYwlKCysPpFoaMOLFKBoF2?=
 =?us-ascii?Q?Z1IzOX0b0VVvhBYUg/ed39G+PqGKeA6ZOmXZQW8Dav2YVT7O0MvLKhZs2geC?=
 =?us-ascii?Q?vVK5kZtUoetUMqR+jT4F3rBuKt8ER9E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d2a96b-49b9-451a-922c-08da509117d0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 18:42:12.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuL/nbPG/uPrE1Me+6GDsBjwfOK2v+B02Na4oMr+LPyr5ukfUXB6GOQJEcwjad0UIx0BI/MLKoNaoCfLFWA5LmLkkdxeY27lRXCSxSQJZYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1576
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The sysfs attribute, get_poison, allows user space to request the
> retrieval of a CXL devices poison list for its persistent memory.

If the device supports get poison list for volatile memory, just grab
that too. With the "to be released soon" region patches userspace can
trivially translate DPA addresses to media type.

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

kstrtobool()?

> +		dev_err(dev, "%s: unknown value: %s\n", attr->attr.name, buf);

dev_err() is overkill for sysfs errors. dev_dbg() can be nice for errors
that trigger deep within the kernel in response to a sysfs write. In
this case EINVAL return is sufficient.

> +		return -EINVAL;
> +	}
> +
> +	rc = cxl_mem_get_poison_list(dev);
> +	if (rc) {
> +		dev_err(dev, "Failed to retrieve poison list %d\n", rc);

Too chatty, dev_dbg() or delete.

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

Use the kobj_to_dev() helper.

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
