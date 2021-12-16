Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D87C477318
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhLPN1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:27:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:27385 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231685AbhLPN1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:27:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="238227763"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="238227763"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 05:27:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="519250371"
Received: from jsarha-mobl.ger.corp.intel.com (HELO [10.249.254.10]) ([10.249.254.10])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 05:27:32 -0800
Message-ID: <77c95e21-747a-87d8-4145-f37f75e76e18@linux.intel.com>
Date:   Thu, 16 Dec 2021 14:27:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] PM: sleep: Avoid calling put_device() under dpm_list_mtx
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rafael,

On 11/4/21 18:26, Rafael J. Wysocki wrote:
> It is generally unsafe to call put_device() with dpm_list_mtx held,
> because the given device's release routine may carry out an action
> depending on that lock which then may deadlock, so modify the
> system-wide suspend and resume of devices to always drop dpm_list_mtx
> before calling put_device() (and adjust white space somewhat while
> at it).
>
> For instance, this prevents the following splat from showing up in
> the kernel log after a system resume in certain configurations:


<snip>


> @@ -1748,21 +1769,27 @@ int dpm_suspend(pm_message_t state)
>   		struct device *dev = to_device(dpm_prepared_list.prev);
>   
>   		get_device(dev);
> +
>   		mutex_unlock(&dpm_list_mtx);
>   
>   		error = device_suspend(dev);
>   
>   		mutex_lock(&dpm_list_mtx);
> +
>   		if (error) {
>   			pm_dev_err(dev, state, "", error);
>   			dpm_save_failed_dev(dev_name(dev));
> -			put_device(dev);
> -			break;
> -		}
> -		if (!list_empty(&dev->power.entry))
> +		} else if (!list_empty(&dev->power.entry)) {
>   			list_move(&dev->power.entry, &dpm_suspended_list);
> +		}
> +
> +		mutex_unlock(&dpm_list_mtx);
> +
>   		put_device(dev);
> -		if (async_error)
> +
> +		mutex_lock(&dpm_list_mtx);
> +
> +		if (error || async_error)
>   			break;
>   	}
>   	mutex_unlock(&dpm_list_mtx);
> @@ -1879,6 +1906,7 @@ int dpm_prepare(pm_message_t state)
>   		struct device *dev = to_device(dpm_list.next);
>   
>   		get_device(dev);
> +
>   		mutex_unlock(&dpm_list_mtx);
>   
>   		trace_device_pm_callback_start(dev, "", state.event);
> @@ -1886,21 +1914,23 @@ int dpm_prepare(pm_message_t state)
>   		trace_device_pm_callback_end(dev, error);
>   
>   		mutex_lock(&dpm_list_mtx);
> -		if (error) {
> -			if (error == -EAGAIN) {
> -				put_device(dev);
> -				error = 0;
> -				continue;
> -			}
> +
> +		if (!error) {
> +			dev->power.is_prepared = true;
> +			if (!list_empty(&dev->power.entry))
> +				list_move_tail(&dev->power.entry, &dpm_prepared_list);
> +		} else if (error == -EAGAIN) {
> +			error = 0;
> +		} else {
>   			dev_info(dev, "not prepared for power transition: code %d\n",
>   				 error);
> -			put_device(dev);
> -			break;

It appears the above break disappeared.


>   		}
> -		dev->power.is_prepared = true;
> -		if (!list_empty(&dev->power.entry))
> -			list_move_tail(&dev->power.entry, &dpm_prepared_list);
> +
> +		mutex_unlock(&dpm_list_mtx);
> +
>   		put_device(dev);

Should be

                  if (error)

                         break;

Here?

Symptoms is if we return an error from the device prepare callback, we 
end up spinning forever with little clue what's going on.


> +
> +		mutex_lock(&dpm_list_mtx);
>   	}
>   	mutex_unlock(&dpm_list_mtx);
>   	trace_suspend_resume(TPS("dpm_prepare"), state.event, false);

Thanks,

Thomas


