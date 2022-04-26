Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D75510555
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiDZR1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiDZR1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:27:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB1517079
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nLgSZUMwQnFAuxlmgrnwtm2dKOz4jDnWEc3lRX/F6/Q=; b=QDyaK2XZZeViD7XYHreQEDTutF
        z1mG4F6oF/QZVHeCGTtOsfJUHn04AzyngpmX3AxG+NFJK+CuwkkYyrIPDptNTUJ0Pps26Ig3fGG68
        cVy2Bl2FC8+5njbfbPC049roQEmjSnGumCWFKx7PqjWWm6XkHE6Tsk9suhp+R6vOmnl9Bk0wXgziA
        Li99k3+IVCohq07ezZdm90jDKaWyVW/XtKFAj/lYbA3Ko6ra4wauKNO4t+kjG7kdGsllRbX9RS9/6
        LtWyi5nMKncAu5gtGK8BzSDOSgDeb6dH8I0BuqD85FB0J8k9GOEV3tgYcrP6FhraZ2OfQtGch/gJG
        mTrhZ8UQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njOul-009qt1-26; Tue, 26 Apr 2022 17:23:51 +0000
Date:   Tue, 26 Apr 2022 18:23:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        rf@opensource.cirrus.com, pmladek@suse.com, ying.huang@intel.com,
        dave.hansen@intel.com
Subject: Re: [PATCH v2 1/2] lib/kstrtox.c: Add "false"/"true" support to
  kstrtobool()
Message-ID: <Ymgqp9/DfOWAUD6c@casper.infradead.org>
References: <20220426170040.65487-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426170040.65487-1-jvgediya@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:30:39PM +0530, Jagdish Gediya wrote:
> At many places in kernel, It is necessary to convert sysfs input
> to corrosponding bool value e.g. "false" or "0" need to be converted
> to bool false, "true" or "1" need to be converted to bool true,
> places where such conversion is needed currently check the input
> string manually, kstrtobool() can be utilized at such places but
> currently it doesn't have support to accept "false"/"true".
> 
> Add support to accept "false"/"true" as valid string in kstrtobool().
> 
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

... except ...

> - * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
> + * This routine returns 0 if the first character is one of 'YyTt1NnFf0', or

https://en.wikipedia.org/wiki/If_and_only_if

