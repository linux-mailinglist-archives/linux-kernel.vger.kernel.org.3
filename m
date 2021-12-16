Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FEC477CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbhLPToS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:44:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:60201 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhLPToR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:44:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="220261398"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="220261398"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 11:44:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="464811263"
Received: from jsarha-mobl.ger.corp.intel.com (HELO [10.249.254.10]) ([10.249.254.10])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 11:44:15 -0800
Message-ID: <b9d06e6378a7c3b0e0b2561ab2a971c8fa1ff3e9.camel@linux.intel.com>
Subject: Re: [PATCH] PM: sleep: Fix error handling in dpm_prepare()
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Dec 2021 20:44:13 +0100
In-Reply-To: <4717160.31r3eYUQgx@kreacher>
References: <4717160.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-16 at 20:30 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 2aa36604e824 ("PM: sleep: Avoid calling put_device() under
> dpm_list_mtx") forgot to update the while () loop termination
> condition to also break the loop if error is nonzero, which
> causes the loop to become infinite if device_prepare() returns
> an error for one device.
> 
> Add the missing !error check.
> 
> Fixes: 2aa36604e824 ("PM: sleep: Avoid calling put_device() under
> dpm_list_mtx")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Thomas Hellström <thomas.hellstrom@linux.intel.com>

Was this meant to be a Reported-by:?
Also Cc stable? IIRC 2aa36604e824 was.

In any case,
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Thanks,
Thomas


> ---
>  drivers/base/power/main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1902,7 +1902,7 @@ int dpm_prepare(pm_message_t state)
>         device_block_probing();
>  
>         mutex_lock(&dpm_list_mtx);
> -       while (!list_empty(&dpm_list)) {
> +       while (!list_empty(&dpm_list) && !error) {
>                 struct device *dev = to_device(dpm_list.next);
>  
>                 get_device(dev);
> 
> 
> 


