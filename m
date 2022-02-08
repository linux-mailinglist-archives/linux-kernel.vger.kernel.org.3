Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7084ADBE0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379041AbiBHPB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244705AbiBHPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:01:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D820DC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644332514; x=1675868514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XpENSQQtkROfpCO6JNc1kJzZlo2IByE0DAYnUc+WpfQ=;
  b=A7kY21nEHqX4r2iLL8eAc3fAvR13hBwtRbTrbv+ON95bt7PLAxrCAcUj
   8AURkC4Uf9wgqMWQTZcB1DWY1fCViB/VtSQoJC9tAMqqlZj0CHOvA8yJz
   0fSzCzxou9dhQ3Z0uQCN1LiwQsZj7HANO8So2BOK5dfB+nVvm8v8G91iH
   JSIc7jW+RpEhTQVeOJHXXje5a6nqj0CeJExGN+poB7esTmGGSLV52Q7C/
   7v7o2+T/Z06BykpMB569YcZAyus0wYQHH77OEFEHPQENNG2jkPY2+ZRkQ
   edP17UrllOycXYpLTyVvg5EjxHfI+BtF9/eITOFoUZNkRfEbvaRlcbDhZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248910907"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="248910907"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:01:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="484835940"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 07:01:53 -0800
Date:   Tue, 8 Feb 2022 07:01:44 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YgKF2NDMURGq1JD1@otcwcpicx3.sc.intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
 <139b9789-403f-c599-de02-3092847952c0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139b9789-403f-c599-de02-3092847952c0@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 10:41:39AM +0800, Lu Baolu wrote:
> On 2/8/22 7:02 AM, Fenghua Yu wrote:
> > PASIDs are process wide. It was attempted to use refcounted PASIDs to
> > free them when the last thread drops the refcount. This turned out to
> > be complex and error prone. Given the fact that the PASID space is 20
> > bits, which allows up to 1M processes to have a PASID associated
> > concurrently, PASID resource exhaustion is not a realistic concern.
> > 
> > Therefore it was decided to simplify the approach and stick with lazy
> > on demand PASID allocation, but drop the eager free approach and make
> > a allocated PASID lifetime bound to the life time of the process.
> > 
> > Get rid of the refcounting mechanisms and replace/rename the interfaces
> > to reflect this new approach.
> > 
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> > v4:
> > - Update the commit message (Thomas).
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thank you very much for your review, Baolu!

-Fenghua
