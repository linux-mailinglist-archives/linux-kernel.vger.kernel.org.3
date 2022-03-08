Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F564D16BC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346650AbiCHL6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346639AbiCHL5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:57:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE13D3982C;
        Tue,  8 Mar 2022 03:56:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 843AFD6E;
        Tue,  8 Mar 2022 03:56:55 -0800 (PST)
Received: from [10.57.22.11] (unknown [10.57.22.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86A6F3FA5D;
        Tue,  8 Mar 2022 03:56:53 -0800 (PST)
Message-ID: <c77c93bb-f863-47c8-0ba0-3fc63530a9e1@arm.com>
Date:   Tue, 8 Mar 2022 11:56:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2] coresight: core: Fix coresight device probe failure
 issue
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20220304082350.30069-1-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220304082350.30069-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinlong

On 04/03/2022 08:23, Mao Jinlong wrote:
> It is possibe that probe failure issue happens when the device
> and its child_device's probe happens at the same time.
> In coresight_make_links, has_conns_grp is true for parent, but
> has_conns_grp is false for child device as has_conns_grp is set
> to true in coresight_create_conns_sysfs_group. The probe of parent
> device will fail at this condition. Add has_conns_grp check for
> child device before make the links and make the process from
> device_register to connection_create be atomic to avoid this
> probe failure issue.
> 
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Suggested-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 88653d1c06a4..b3e3bc59c09b 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1382,7 +1382,7 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
>   			continue;
>   		conn->child_dev =
>   			coresight_find_csdev_by_fwnode(conn->child_fwnode);
> -		if (conn->child_dev) {
> +		if (conn->child_dev && conn->child_dev->has_conns_grp) {
>   			ret = coresight_make_links(csdev, conn,
>   						   conn->child_dev);
>   			if (ret)
> @@ -1594,7 +1594,8 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   	refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
>   	if (!refcnts) {
>   		ret = -ENOMEM;
> -		goto err_free_csdev;
> +		kfree(csdev);
> +		goto err_out;
>   	}
>   
>   	csdev->refcnt = refcnts;
> @@ -1619,8 +1620,10 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   	csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
>   	dev_set_name(&csdev->dev, "%s", desc->name);
>   
> +	mutex_lock(&coresight_mutex);
>   	ret = device_register(&csdev->dev);
>   	if (ret) {
> +		mutex_unlock(&coresight_mutex);
>   		put_device(&csdev->dev);
>   		/*
>   		 * All resources are free'd explicitly via
> @@ -1634,6 +1637,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   		ret = etm_perf_add_symlink_sink(csdev);
>   
>   		if (ret) {
> +			mutex_unlock(&coresight_mutex);
>   			device_unregister(&csdev->dev);
>   			/*
>   			 * As with the above, all resources are free'd
> @@ -1645,8 +1649,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   		}
>   	}
>   
> -	mutex_lock(&coresight_mutex);
> -
>   	ret = coresight_create_conns_sysfs_group(csdev);
>   	if (!ret)
>   		ret = coresight_fixup_device_conns(csdev);
> @@ -1663,8 +1665,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   
>   	return csdev;
>   
> -err_free_csdev:
> -	kfree(csdev);
>   err_out:
>   	/* Cleanup the connection information */
>   	coresight_release_platform_data(NULL, desc->pdata);

Could we consolidate the unlock sequence to a single point with 
something like this (untested):


diff --git a/drivers/hwtracing/coresight/coresight-core.c 
b/drivers/hwtracing/coresight/coresight-core.c
index af00dca8d1ac..198ee140c6e6 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1571,6 +1571,7 @@ struct coresight_device *coresight_register(struct 
coresight_desc *desc)
  	int nr_refcnts = 1;
  	atomic_t *refcnts = NULL;
  	struct coresight_device *csdev;
+	bool registered = false;

  	csdev = kzalloc(sizeof(*csdev), GFP_KERNEL);
  	if (!csdev) {
@@ -1591,7 +1592,8 @@ struct coresight_device *coresight_register(struct 
coresight_desc *desc)
  	refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
  	if (!refcnts) {
  		ret = -ENOMEM;
-		goto err_free_csdev;
+		kfree(csdev);
+		goto err_out;
  	}

  	csdev->refcnt = refcnts;
@@ -1616,6 +1618,13 @@ struct coresight_device 
*coresight_register(struct coresight_desc *desc)
  	csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
  	dev_set_name(&csdev->dev, "%s", desc->name);

+	/*
+	 * Make sure the device registration and the connection fixup
+	 * are synchronised, so that we don't see uninitialised devices
+	 * on the coresight bus while trying to resolve the connections.
+	 */
+	mutex_lock(&coresight_mutex);
+
  	ret = device_register(&csdev->dev);
  	if (ret) {
  		put_device(&csdev->dev);
@@ -1623,7 +1632,7 @@ struct coresight_device *coresight_register(struct 
coresight_desc *desc)
  		 * All resources are free'd explicitly via
  		 * coresight_device_release(), triggered from put_device().
  		 */
-		goto err_out;
+		goto out_unlock;
  	}

  	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
@@ -1638,11 +1647,11 @@ struct coresight_device 
*coresight_register(struct coresight_desc *desc)
  			 * from put_device(), which is in turn called from
  			 * function device_unregister().
  			 */
-			goto err_out;
+			goto out_unlock;
  		}
  	}
-
-	mutex_lock(&coresight_mutex);
+	/* Device is now registered */
+	registered = true;

  	ret = coresight_create_conns_sysfs_group(csdev);
  	if (!ret)
@@ -1652,16 +1661,15 @@ struct coresight_device 
*coresight_register(struct coresight_desc *desc)
  	if (!ret && cti_assoc_ops && cti_assoc_ops->add)
  		cti_assoc_ops->add(csdev);

+out_unlock:
  	mutex_unlock(&coresight_mutex);
-	if (ret) {
+	/* Success */
+	if (!ret)
+		return csdev;
+
+	/* Unregister the device if needed */
+	if (registered)
  		coresight_unregister(csdev);
-		return ERR_PTR(ret);
-	}
-
-	return csdev;
-
-err_free_csdev:
-	kfree(csdev);
  err_out:
  	/* Cleanup the connection information */
  	coresight_release_platform_data(NULL, desc->pdata);
-- 
2.35.1
