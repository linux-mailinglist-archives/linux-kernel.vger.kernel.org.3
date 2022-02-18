Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5E14BB118
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 06:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiBRFBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 00:01:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiBRFBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:01:14 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF6F1948C0;
        Thu, 17 Feb 2022 21:00:49 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21I50gcG048386;
        Thu, 17 Feb 2022 23:00:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645160442;
        bh=XGAzAtgoKWZ6S5U7XK/NOYPT+W1ou+JL2nNvHqVts1Y=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Ekk2BHG/TSnoRB7UpXvAJjV/RvPpFaQmHyEpXJ3pXG0suZVhkZXXTbsdDa6iCMXZN
         7VmZNHMyxyIzjZEJ1BhJqCaAWXG6nvUtdfvTqgScoF6VRcYClk/Z2RwwBbGcWLTxHU
         ZtCixYKb4/ICcH6MOaXrUvYlUlGs4lQUiTa44PO0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21I50gZG033477
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Feb 2022 23:00:42 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 17
 Feb 2022 23:00:41 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 17 Feb 2022 23:00:41 -0600
Received: from [10.250.233.137] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21I50cmP087458;
        Thu, 17 Feb 2022 23:00:38 -0600
Subject: Re: [PATCH v5 1/2] remoteproc: Introduce sysfs_read_only flag
To:     Puranjay Mohan <p-mohan@ti.com>, <vigneshr@ti.com>,
        <s-anna@ti.com>, <bjorn.andersson@linaro.org>,
        <mathieu.poirier@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220216081224.9956-1-p-mohan@ti.com>
 <20220216081224.9956-2-p-mohan@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0d44d73f-d882-83db-9cf2-09f7cdc91ab2@ti.com>
Date:   Fri, 18 Feb 2022 10:30:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220216081224.9956-2-p-mohan@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/02/22 1:42 pm, Puranjay Mohan wrote:
> The remoteproc framework provides sysfs interfaces for changing
> the firmware name and for starting/stopping a remote processor
> through the sysfs files 'state' and 'firmware'. The 'coredump'
> file is used to set the coredump configuration. The 'recovery'
> sysfs file can also be used similarly to control the error recovery
> state machine of a remoteproc. These interfaces are currently
> allowed irrespective of how the remoteprocs were booted (like
> remoteproc self auto-boot, remoteproc client-driven boot etc).
> These interfaces can adversely affect a remoteproc and its clients
> especially when a remoteproc is being controlled by a remoteproc
> client driver(s). Also, not all remoteproc drivers may want to
> support the sysfs interfaces by default.
> 
> Add support to make the remoteproc sysfs files read only by
> introducing a state flag 'sysfs_read_only' that the individual
> remoteproc drivers can set based on their usage needs. The default
> behavior is to allow the sysfs operations as before.
> 
> Implement attribute_group->is_visible() to make the sysfs
> entries read only when 'sysfs_read_only' flag is set.
> 
> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
> Changes in v4->v5:
> Rename deny_sysfs_ops to sysfs_read_only.
> Make coredump readonly with other files.
> 
> Changes in v3->v4:
> Use mode = 0444 in rproc_is_visible() to make the sysfs entries
> read-only when the deny_sysfs_ops flag is set.
> ---
>  drivers/remoteproc/remoteproc_sysfs.c | 19 ++++++++++++++++++-
>  include/linux/remoteproc.h            |  2 ++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index ea8b89f97d7b..abf0cd05d5e1 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -230,6 +230,22 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(name);
>  
> +static umode_t rproc_is_visible(struct kobject *kobj, struct attribute *attr,
> +				int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct rproc *rproc = to_rproc(dev);
> +	umode_t mode = attr->mode;
> +
> +	if (rproc->sysfs_read_only && (attr == &dev_attr_recovery.attr ||
> +				       attr == &dev_attr_firmware.attr ||
> +				       attr == &dev_attr_state.attr ||
> +				       attr == &dev_attr_coredump.attr))
> +		mode = 0444;

Nitpick: use S_IRUGO instead of 0444.

Thanks,
Kishon
> +
> +	return mode;
> +}
> +
>  static struct attribute *rproc_attrs[] = {
>  	&dev_attr_coredump.attr,
>  	&dev_attr_recovery.attr,
> @@ -240,7 +256,8 @@ static struct attribute *rproc_attrs[] = {
>  };
>  
>  static const struct attribute_group rproc_devgroup = {
> -	.attrs = rproc_attrs
> +	.attrs = rproc_attrs,
> +	.is_visible = rproc_is_visible,
>  };
>  
>  static const struct attribute_group *rproc_devgroups[] = {
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e0600e1e5c17..93a1d0050fbc 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -523,6 +523,7 @@ struct rproc_dump_segment {
>   * @table_sz: size of @cached_table
>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>   * @auto_boot: flag to indicate if remote processor should be auto-started
> + * @sysfs_read_only: flag to make remoteproc sysfs files read only
>   * @dump_segments: list of segments in the firmware
>   * @nb_vdev: number of vdev currently handled by rproc
>   * @elf_class: firmware ELF class
> @@ -562,6 +563,7 @@ struct rproc {
>  	size_t table_sz;
>  	bool has_iommu;
>  	bool auto_boot;
> +	bool sysfs_read_only;
>  	struct list_head dump_segments;
>  	int nb_vdev;
>  	u8 elf_class;
> 
