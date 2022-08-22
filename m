Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A5559CC22
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiHVXZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbiHVXZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:25:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFC83DBD0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661210738; x=1692746738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P3zN1Gd9BytgDfRPNsJA/SKlYpoKj+jVmmRQteZBSYE=;
  b=AQm2bUr4xMpM2EbSwvrGlG68E0qHnFH4xALbzoLwV2zgOVTRxAOwPHtc
   Je0KgQ6jd0DceNFJn3c95a2M4CFAaOrwp6dOFqtZ369d7VO8XS2mFj9sH
   bZgDLspmKuCdGslzcVwXMGa8ARcxASKEPHnIWw6gxI6dojg0Jnp93t0o5
   JAmwtcKdpScBxVRvUYNZpH9k/COz3OfEqC9POYSC0wga38hJGF4aYxVwO
   rbLUn+hqkiiOIRloe6J0TVqLyAVlb9Y/ui3Kd2oaxu53L2NQqCebJ9E0L
   HEMEGwIJuyrN+ifaIvDJBmpE4b9P5EAF30YDBwJ0aYKaPbfUZPIPfn0h3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="379834758"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="379834758"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 16:25:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="751470848"
Received: from jcsarker-mobl.amr.corp.intel.com (HELO [10.212.204.203]) ([10.212.204.203])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 16:25:36 -0700
Message-ID: <3bfa9a4b-d09a-bb23-f66c-55166350c6f0@intel.com>
Date:   Mon, 22 Aug 2022 16:25:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] iommu: Use the user PGD for SVA if PTI is enabled
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
 <20220822201213.352289-3-jacob.jun.pan@linux.intel.com>
 <09bccb93-2c0e-4962-0c46-c84c22fa140d@intel.com>
 <20220822162454.490ad1f2@jacob-builder>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220822162454.490ad1f2@jacob-builder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 16:24, Jacob Pan wrote:
> Sounds good. I thought about a helper also, thinking there are so many other
> cpu_has(X86_FEATURE_PTI) checks already :)

Yes, but almost all of those are in PTI-#ifdef'd code already.
