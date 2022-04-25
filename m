Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ABE50EC98
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiDYXfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237895AbiDYXfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:35:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD736AA69;
        Mon, 25 Apr 2022 16:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qMnY4WbVpAxmQ/4X6WWLsIMxUBHKSMbpS3kcgrtCpFs=; b=wpbFIwSlzpm6J9Osh6cHP+j3IH
        O51zNvj2lWTwt+74/Gomgb0sgotJiLmGAXEFCfHoIo5+vAr3SiXyNfOIHrsVgWJMYJuRYpwXBrW8C
        sgDnGIB+99uWHFhFbOb/d5yG9H7ZFCgUfYXSMJg0zFwUMEmtiYPZszT4+ljOMfedEzdrmcY9917CW
        37qJYdajQhWUBQcFNEeuqAVQOODqy4SYIp05YJUfNiW5GCuNQSQG6LUJpBK/GJtdfO8ha8WHoS6EV
        lwoDBfZHwBZ318RFCviqoeWCj0PpYIG607lp59IqFHl7w+zynVh3a3QygHhkE5qw8iFmlfM/xnElj
        +YBIJaaw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nj8BJ-00BjPh-H3; Mon, 25 Apr 2022 23:31:49 +0000
Date:   Mon, 25 Apr 2022 16:31:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: Re: [PATCH v4 0/2] module: Introduce module unload taint tracking
Message-ID: <YmcvZQSiu95MUvxI@bombadil.infradead.org>
References: <20220425090841.3958494-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425090841.3958494-1-atomlin@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:08:39AM +0100, Aaron Tomlin wrote:
> Hi Luis,
> 
> This iteration is still based on the latest mcgrof/modules-next branch.
> 
> I have decided still to use RCU even though no entry is ever removed from
> the unloaded tainted modules list. That being said, if I understand
> correctly, it is not safe in some instances to use 'module_mutex' in
> print_modules().  So instead we disable preemption to ensure list traversal
> with concurrent list manipulation e.g. list_add_rcu(), is safe too.
> 
> Changes since v3 [1]
>  - Fixed kernel build error reported by kernel test robot i.e. moved
>    '#endif' outside 'if (!list_empty(&unloaded_tainted_modules))'
>    statement in the context of print_modules()
>  - Used strncmp() instead of memcmp()
>    (Oleksandr Natalenko)
>  - Removed the additional strlen()
>    (Christoph Lameter)
> 
> Changes since v2 [2]
>  - Dropped RFC from subject
>  - Removed the newline i.e. "\n" in printk()
>  - Always include the tainted module's unload count
>  - Unconditionally display each unloaded tainted module
> 
> Please let me know your thoughts.

This all looks good except with all the work you did to remove
#ifdef hell, it gets me wondering why not just use a new file for this?

What does that look like?

  Luis
