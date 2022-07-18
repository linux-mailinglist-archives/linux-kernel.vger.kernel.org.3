Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3F8577E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbiGRJKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiGRJKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:10:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E225F58;
        Mon, 18 Jul 2022 02:10:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA8CAB8107E;
        Mon, 18 Jul 2022 09:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A91C341C0;
        Mon, 18 Jul 2022 09:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658135439;
        bh=o1w/414mT/mu4Ne8x1FYZpKVbby4IR+rfL+Mp7Ca0zQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d43HkvOwZ+XvpcGhTj41nlophjfoP6HEXuATshkV/7XTgG98QQORD0D1UqmZzSSaK
         fCGZk8/hobxTJ+ks00S4I+EsbyKm9dvDvy+BdlaNpyf3Ao/RFCMVsVr0tIdWJPaY6A
         mkGiuG0u2aenLfPHtw8GGf1kdE19r9jUpH9ii+46IIu9okQxfClxuKrM1UdG8j5z2v
         bVR+mgQZGKjuxksFLQNqBIezt63z586UUPQAkbeNE0cUjkkT/wBmQZ4NZrC6fZIHLh
         tVgRBVEowFC0CMb8uXc4stAT01ofvi22Tp/fmNfYlPqq//M5HmRqRyRwmqgHub6j2R
         nZk8zb7jIevYg==
Message-ID: <7bd4f2fb-70ce-3724-130f-f5c75ee7bde2@kernel.org>
Date:   Mon, 18 Jul 2022 12:10:34 +0300
MIME-Version: 1.0
Subject: Re: [PATCH 7/8] interconnect: Make icc_provider_del() return void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220715203652.89912-1-u.kleine-koenig@pengutronix.de>
 <20220715203652.89912-8-u.kleine-koenig@pengutronix.de>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220715203652.89912-8-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Uwe,

Thanks for the patchset!

On 15.07.22 23:36, Uwe Kleine-König wrote:
> All users ignore the return value of icc_provider_del(). Consequently
> make it not return an error code.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/interconnect/core.c           | 10 +++-------
>   include/linux/interconnect-provider.h |  2 +-
>   2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 808f6e7a8048..25debded65a8 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -1057,29 +1057,25 @@ EXPORT_SYMBOL_GPL(icc_provider_add);
>   /**
>    * icc_provider_del() - delete previously added interconnect provider
>    * @provider: the interconnect provider that will be removed from topology
> - *
> - * Return: 0 on success, or an error code otherwise
>    */
> -int icc_provider_del(struct icc_provider *provider)
> +void icc_provider_del(struct icc_provider *provider)
>   {
>   	mutex_lock(&icc_lock);
>   	if (provider->users) {
>   		pr_warn("interconnect provider still has %d users\n",
>   			provider->users);
>   		mutex_unlock(&icc_lock);
> -		return -EBUSY;
> +		return;
>   	}

Looks like provider->users is now useless, so we should remove it. But that could be a separate 
clean-up.

>   
>   	if (!list_empty(&provider->nodes)) {
>   		pr_warn("interconnect provider still has nodes\n");
>   		mutex_unlock(&icc_lock);
> -		return -EBUSY;
> +		return;
>   	}
>   
>   	list_del(&provider->provider_list);
>   	mutex_unlock(&icc_lock);
> -
> -	return 0;
>   }
>   EXPORT_SYMBOL_GPL(icc_provider_del);
>   
> diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
> index 6bd01f7159c6..191f083d1f3b 100644
> --- a/include/linux/interconnect-provider.h
> +++ b/include/linux/interconnect-provider.h
> @@ -123,7 +123,7 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider);
>   void icc_node_del(struct icc_node *node);
>   int icc_nodes_remove(struct icc_provider *provider);
>   int icc_provider_add(struct icc_provider *provider);
> -int icc_provider_del(struct icc_provider *provider);
> +void icc_provider_del(struct icc_provider *provider);
>   struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec);
>   void icc_sync_state(struct device *dev);

We should also squash the following:

--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -172,7 +172,7 @@ static inline int icc_provider_add(struct icc_provider *provider)
  	return -ENOTSUPP;
  }

-static inline int icc_provider_del(struct icc_provider *provider)
+static inline void icc_provider_del(struct icc_provider *provider)
  {
  	return -ENOTSUPP;
  }

Thanks,
Georgi
