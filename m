Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109CD50FF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347303AbiDZNwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347167AbiDZNv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:51:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA26E546
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:48:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6FCF7210E7;
        Tue, 26 Apr 2022 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650980925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F+wA5KMl3sz7Hz4DhR7q1vCIcnRJJNynvFD0510ehm0=;
        b=GwX7/XcKTiX+1MZ3d4DtJkpvZxlMP6johNbtA5wrs+MtG7WEVGBuqjcn+Ixlw4K/Kq12Nr
        U50IjO6MpqIGPfeum1eyYgvqiM+/rsadI4hs+jRG+BLSjludarkAurnTm793oVQ0PF46kV
        6sVs5TPUFrA0xKBqz+7oTRkyUvNC2/Q=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0494F2C143;
        Tue, 26 Apr 2022 13:48:44 +0000 (UTC)
Date:   Tue, 26 Apr 2022 15:48:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, dave.hansen@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool
Message-ID: <Ymf4PNfLcYcf1btz@alley>
References: <20220426064001.14241-1-jvgediya@linux.ibm.com>
 <Yme97bRH3hLcqGfC@alley>
 <YmfDiO6KSRzo8C6e@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmfDiO6KSRzo8C6e@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-26 15:33:52, Jagdish Gediya wrote:
> On Tue, Apr 26, 2022 at 11:39:57AM +0200, Petr Mladek wrote:
> > On Tue 2022-04-26 12:10:01, Jagdish Gediya wrote:
> > > At many places in kernel, It is necessary to convert sysfs input
> > > to corrosponding bool value e.g. "false" or "0" need to be converted
> > > to bool false, "true" or "1" need to be converted to bool true,
> > > places where such conversion is needed currently check the input
> > > string manually, kstrtobool can be utilized at such places but
> > > currently kstrtobool doesn't have support to "false"/"true".
> > >
> > > Add "false"/"true" support to kstrtobool while string conversion
> > > to bool. Modify existing manual sysfs conversions to use kstrtobool().
> > 
> > It looks reasonable. I would just do it slightly other way, see
> > below.
> > 
> > > This patch doesn't have any functionality change.
> > 
> > This is not true. All kstrtobool() callers will react differently
> > on the "true"/"false" input.
> 
> how? Is it related to performance as more characters are compared?
> otherwise semantic wise they will get the expected response, correct?

kstrtobool() returned -EINVAL for "true"/"false" strings before this
patch. It will successfully handle them after this patch.
This is a behavior/functional change that will affect all
existing kstrtobool() callers.

The change makes sense and most likely will not cause any regression.
But are you 100% sure? People do crazy things.

> > > --- a/lib/kstrtox.c
> > > +++ b/lib/kstrtox.c
> > > @@ -377,6 +377,13 @@ int kstrtobool(const char *s, bool *res)
> > >  		}
> > >  		break;
> > >  	default:
> > > +		if (!strncmp(s, "true", 4)) {
> > > +			*res = true;
> > > +			return 0;
> > > +		} else if (!strncmp(s, "false", 5)) {
> > > +			*res = false;
> > > +			return 0;
> > 
> > It should be enough to check the first letter like we do in
> > the other cases. I mean to set true when s[0] is 'T' or 't'
> > and false when s[0] is 'F' or 'f'.
> 
> For "on" and "off", 2 characters are matched, so is it good enough
> to compare only single character for strings "true" and "false"?

Yes, the 1st character is enough to distinguish "true" and "false".
Two characters are needed for "on" and "off" because the 1st
character is the same.

Best Regards,
Petr
