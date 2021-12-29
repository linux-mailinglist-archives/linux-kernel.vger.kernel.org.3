Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1568481510
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbhL2QT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:19:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:64770 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhL2QT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640794797; x=1672330797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OIH24DPqwPhfyOD8IR1MCozu4WIeQBs3YXM7QI9yYGA=;
  b=Ah7nsM+NtXY57KvFtulnPq5RZDd+FSZUlxP1kDuKmyUZ2IYC8qt7CSuW
   Cs0Hoa3RKaf1az0IYa0E7LgwSWRf6ohJ9D1wUZV8fkdEkyyzZu9mfDLd0
   f3F8WNYt4tmomxvsugM7zhD8gT4HCnpemhAIETUpFfiQE01SQR3h2YeZS
   OZrPNUQmMjCSLqxRPFf3Tfs1YMdhagnko0ZddRhldUqMbyn1bRxYKDIsH
   4RwNmoLGtjrtpybunewHY0CWdUAyb67OCBneZICxCh0fLKE7be7LBeYHk
   v4QqzZtWNRK0TwoWrNL0wWlj9cd323W49Tjlu+S8SJwtglMp0Rz2ilo8f
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304897116"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304897116"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 08:19:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="619076607"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 08:19:54 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 29 Dec 2021 18:19:45 +0200
Date:   Wed, 29 Dec 2021 18:19:45 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] Keep polling IPC status if it reads IPC_STATUS_BUSY or
 IPC_STATUS_ERR until timeout expires
Message-ID: <YcyKoZyBFzRtwRMm@lahna>
References: <20211229132948.4738-1-rajat.khandelwal@intel.com>
 <CO1PR11MB4835D217B78F17BA6AD79F0096449@CO1PR11MB4835.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4835D217B78F17BA6AD79F0096449@CO1PR11MB4835.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now I got it.

Please run checkpatch.pl and fix all the issues it reports, and change
the $subject line to match the style in that file and then re-send.
Thanks!

On Wed, Dec 29, 2021 at 06:13:56PM +0200, Khandelwal, Rajat wrote:
> Hi @Westerberg, Mika
> This was the original message!
> 
> -----Original Message-----
> From: Khandelwal, Rajat <rajat.khandelwal@intel.com>
> Sent: Wednesday, December 29, 2021 7:00 PM
> To: mika.westerberg@linux.intel.com
> Cc: Khandelwal, Rajat <rajat.khandelwal@intel.com>; linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org
> Subject: [PATCH] Keep polling IPC status if it reads IPC_STATUS_BUSY or IPC_STATUS_ERR until timeout expires
> 
> The current implementation returns -EIO if and when IPC_STATUS_ERR is returned and returns -ETIMEDOUT even if the status is busy.
> This patch polls the IPC status even if IPC_STATUS_ERR is returned until timeout expires and returns -EBUSY if the status shows busy.
> Observed in multiple scenarios, trying to fetch the status of IPC after it shows ERR sometimes eradicates the ERR status.
> 
> Signed-off-by: Rajat-Khandelwal <rajat.khandelwal@intel.com>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 7cc9089d1e14..91f716e84474 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -233,17 +233,19 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)  static inline int busy_loop(struct intel_scu_ipc_dev *scu)  {
>         unsigned long end = jiffies + IPC_TIMEOUT;
> +       u32 status;
> 
>         do {
> -               u32 status;
> -
>                 status = ipc_read_status(scu);
>                 if (!(status & IPC_STATUS_BUSY)) {
> -                       return (status & IPC_STATUS_ERR) ? -EIO : 0;
> +                       if (!(status & IPC_STATUS_ERR))
> +                               return 0;
> +               }
> 
>                 usleep_range(50, 100);
>         } while (time_before(jiffies, end));
> 
> +       if (status & IPC_STATUS_BUSY)
> +               return -EBUSY;
> +       if (status & IPC_STATUS_ERR)
> +               return -EIO;
> +
>         return -ETIMEDOUT;
>  }
> 
> --
> 2.17.1
