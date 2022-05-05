Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6530D51BFA1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377405AbiEEMnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346505AbiEEMnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:43:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AED554AD;
        Thu,  5 May 2022 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MR1Suk6Z26VQH6EVEjcO9jgsClsEMNnUR8xQJnq/MaA=; b=l0RlIqaVNL6SklggkXb7Ebiv5v
        fMacZdF2nfntj7gRwgmz7Cz2sDP6p/qAa698ar2YKEkURpxh8AVSYsOOlPWLFXHIGBkz8RdLmlxpl
        eWlB26GsRtVM6jAbefI+uvyZFFSnyaGrlf9v3maBuPCA1uWcwI+bTDXeOctA8SUKP3omiW/YJv2ht
        jkPVJwr11StUKPCfA0lLjpgJz5NH4RPCb1Rjs4p8L7KyOH5kjB+JBGGxvUFRJLD8VouJ4TdfZcqUn
        6h+wGf5sHxy7GFnuza78MBvD+IxAtUs8+fOk3oaZCoRGC047syaUSwiH+UBUPj8FQQ6IntmQIsgdE
        AaYVknLg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmalb-00FqUS-L5; Thu, 05 May 2022 12:39:35 +0000
Date:   Thu, 5 May 2022 05:39:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] test_firmware: fix end of loop test in upload_read_show()
Message-ID: <YnPFh6ULhhPloue2@bombadil.infradead.org>
References: <YnOm+9tEN+xerpov@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnOm+9tEN+xerpov@kili>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 01:29:15PM +0300, Dan Carpenter wrote:
> If we iterate through a loop using list_for_each_entry() without
> hitting a break, then the iterator points to bogus memory.  The
> if (tst->name != test_fw_config->upload_name) { will likely still work
> but technically it's an out of bounds read.
> 
> Fixes: a31ad463b72d ("test_firmware: Add test support for firmware upload")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  lib/test_firmware.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 76115c1a2629..c82b65947ce6 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -1392,7 +1392,8 @@ static ssize_t upload_read_show(struct device *dev,
>  				struct device_attribute *attr,
>  				char *buf)
>  {
> -	struct test_firmware_upload *tst;
> +	struct test_firmware_upload *tst = NULL;
> +	struct test_firmware_upload *tst_iter;
>  	int ret = -EINVAL;
>  
>  	if (!test_fw_config->upload_name) {
> @@ -1401,11 +1402,13 @@ static ssize_t upload_read_show(struct device *dev,
>  	}
>  
>  	mutex_lock(&test_fw_mutex);

Note the mutex lock.

> -	list_for_each_entry(tst, &test_upload_list, node)
> -		if (tst->name == test_fw_config->upload_name)
> +	list_for_each_entry(tst_iter, &test_upload_list, node)

If a lock is held I can't see how the premise of this patch is
correct and we ensure we don't remove entries while holdingg
the lock.

Generalizing this problem seems like a bigger issue, no?

Additionally this patch doesn't apply at all on linux-next.

  Luis

> +		if (tst_iter->name == test_fw_config->upload_name) {
> +			tst = tst_iter;
>  			break;
> +		}
>  
> -	if (tst->name != test_fw_config->upload_name) {
> +	if (!tst) {
>  		pr_err("Firmware name not found: %s\n",
>  		       test_fw_config->upload_name);
>  		goto out;
> -- 
> 2.35.1
> 
