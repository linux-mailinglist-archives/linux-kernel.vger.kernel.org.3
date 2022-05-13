Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E92525937
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376265AbiEMBFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiEMBFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:05:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF7B45
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:05:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDEE3B82C27
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41568C385B8;
        Fri, 13 May 2022 01:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652403938;
        bh=o0tVkqCw52XZn3wbMhXVh+A4KnIKErQWAa2HDHJy+6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cNubmoTk7cUdXBCDVnxyxhmzbCjeLlbPJuWm4t0rbcnmJkYe5x+EblRrO1hpM1Ufm
         ogL/bSUcde84QbgsfvHNjOV1A+0gsacBuVPRWn5ZC8IaUDlarmIIGqG1j3ii5r4AAd
         irggWkLWD8OKlHbfZzyp5aMS7peS0YAkhhZMj9Hg=
Date:   Thu, 12 May 2022 18:05:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        rf@opensource.cirrus.com, pmladek@suse.com, ying.huang@intel.com,
        dave.hansen@intel.com
Subject: Re: [PATCH v2 2/2] mm: Covert sysfs input to bool using
 kstrtobool()
Message-Id: <20220512180537.5296f39b27c3488080ff67cf@linux-foundation.org>
In-Reply-To: <YmleidxlL2/d859f@smile.fi.intel.com>
References: <20220426170040.65487-1-jvgediya@linux.ibm.com>
        <20220426170040.65487-2-jvgediya@linux.ibm.com>
        <YmleidxlL2/d859f@smile.fi.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 18:17:29 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Apr 26, 2022 at 10:30:40PM +0530, Jagdish Gediya wrote:
> > Sysfs input conversion to corrosponding bool value e.g. "false" or "0"
> > to false, "true" or "1" to true are currently handled through strncmp
> > at multiple places. Use kstrtobool() to convert sysfs input to bool
> > value.
> 
> ...
> 
> > +	if (kstrtobool(buf, &numa_demotion_enabled))
> >  		return -EINVAL;
> 
> Hmm... The commit message doesn't explain what's wrong with the error codes
> returned by kstrtobool(). Can't it be
> 
> 	ret = kstrtobool();
> 	if (ret)
> 		return ret;
> 
> ?

Jagdish fell asleep.

Yes, I agree.  It has no practical difference at present because
kstrtobool() can only return 0 or -EINVAL.  I did this:

--- a/mm/migrate.c~mm-convert-sysfs-input-to-bool-using-kstrtobool-fix
+++ a/mm/migrate.c
@@ -2523,8 +2523,10 @@ static ssize_t numa_demotion_enabled_sto
 					   struct kobj_attribute *attr,
 					   const char *buf, size_t count)
 {
-	if (kstrtobool(buf, &numa_demotion_enabled))
-		return -EINVAL;
+	ssize_t ret;
+
+	ret = kstrtobool(buf, &numa_demotion_enabled);
+		return ret;
 
 	return count;
 }
--- a/mm/swap_state.c~mm-convert-sysfs-input-to-bool-using-kstrtobool-fix
+++ a/mm/swap_state.c
@@ -874,8 +874,11 @@ static ssize_t vma_ra_enabled_store(stru
 				      struct kobj_attribute *attr,
 				      const char *buf, size_t count)
 {
-	if (kstrtobool(buf, &enable_vma_readahead))
-		return -EINVAL;
+	ssize_t ret;
+
+	ret = kstrtobool(buf, &enable_vma_readahead);
+	if (ret)
+		return ret;
 
 	return count;
 }
_

