Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9444ACF13
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbiBHCmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiBHCmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:42:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3F4C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 18:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644288123; x=1675824123;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B3yez2BcAz8vU5Mg4F8I9qz+pN7PVedtfJMQj6hn0Tw=;
  b=eE1hdZc7GPhf9Ing+dtzOmNfR+4n4W/Y5IHaYMoiMclUslyWE8cVjbqL
   dzII4HhIlv4lpXth5kWnMsnqB9al7Us16XsZfC6hK8chQaU24wGqTHMil
   YV6//jQxO1aFjv6MQ/AKxNMCVwsCAlgpF+1ddGYe3s+cIDUZUf1voXZCz
   7/zE1vIqKUA+x4IC4N7zLiOxO/Fb3M/fCtM4xGn8ZGYYHHLTMoUP0uhuz
   fZEZ1ZGrZlluexW2n2SOQ3QvvmtF6kE3FwvX7qjsWUjDkx+Tnn0BExs6t
   IRVKUxLBFpIJ7VmfkuOQX8my1a+uEIdQVptkAi6Wv3Q4SFmDbcdsv2kr9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="273384224"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="273384224"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 18:42:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677965841"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 18:41:59 -0800
Message-ID: <fdf8ffbd-fc07-ca7e-937e-ef7aa39ed4ed@linux.intel.com>
Date:   Tue, 8 Feb 2022 10:40:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/11] iommu/ioasid: Introduce a helper to check for
 valid PASIDs
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-4-fenghua.yu@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207230254.3342514-4-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 7:02 AM, Fenghua Yu wrote:
> pasid_valid() is defined to check if a given PASID is valid.
> 
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> v4:
> - Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).
> 
> v2:
> - Define a helper pasid_valid() (Ashok, Jacob, Thomas, Tony)
> 
>   include/linux/ioasid.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index e9dacd4b9f6b..2237f64dbaae 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -41,6 +41,10 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>   int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>   void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>   int ioasid_set_data(ioasid_t ioasid, void *data);
> +static inline bool pasid_valid(ioasid_t ioasid)
> +{
> +	return ioasid != INVALID_IOASID;
> +}
>   
>   #else /* !CONFIG_IOASID */
>   static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> @@ -78,5 +82,10 @@ static inline int ioasid_set_data(ioasid_t ioasid, void *data)
>   	return -ENOTSUPP;
>   }
>   
> +static inline bool pasid_valid(ioasid_t ioasid)
> +{
> +	return false;
> +}
> +
>   #endif /* CONFIG_IOASID */
>   #endif /* __LINUX_IOASID_H */

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
