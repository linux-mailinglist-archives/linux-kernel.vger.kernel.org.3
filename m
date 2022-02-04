Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574A94A9A8A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359193AbiBDOBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:01:21 -0500
Received: from relay4.hostedemail.com ([64.99.140.35]:17816 "EHLO
        relay4.hostedemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359186AbiBDOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:01:19 -0500
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 9605B20C61;
        Fri,  4 Feb 2022 14:01:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id D433620034;
        Fri,  4 Feb 2022 14:01:15 +0000 (UTC)
Message-ID: <71d3f97b4d4937b6e57772a56603766be7dd1ac8.camel@perches.com>
Subject: Re: [PATCH V5 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
From:   Joe Perches <joe@perches.com>
To:     david.e.box@linux.intel.com, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Fri, 04 Feb 2022 06:01:15 -0800
In-Reply-To: <372f76f7b1b7cf3d0ca38a7a84bcc23322ff12ed.camel@linux.intel.com>
References: <20220204053046.2475671-1-david.e.box@linux.intel.com>
         <20220204053046.2475671-2-david.e.box@linux.intel.com>
         <aa16191c1241473fbfd55995bbba37bd2ab4a41c.camel@perches.com>
         <372f76f7b1b7cf3d0ca38a7a84bcc23322ff12ed.camel@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.72
X-Stat-Signature: 6hgnnr5yeyypf9q58swaqhbup7aap8w5
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: D433620034
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+zPY1J4OVuTtdXhL5t7hkag7tqQnJP210=
X-HE-Tag: 1643983275-443063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-04 at 05:23 -0800, David E. Box wrote:
> On Fri, 2022-02-04 at 02:14 -0800, Joe Perches wrote:
> > On Thu, 2022-02-03 at 21:30 -0800, David E. Box wrote:
[]
> > >   - In binary attribute handlers where ret is only used for errors,
> > >     replace,
> > >               return (ret < 0) ? ret : size;
> > >     with,
> > >               return ret ?: size;
> > 
> > I think this style overly tricky.
> > 
> > Why not the canonical:
> > 
> > 	if (ret < 0)
> > 		return ret;
> > 
> > 	return size;
> 
> I can see not using the 2 parameter shortcut of the ternary operator, but the
> regular 3 parameter expression is easy to read for simple operations.

The issue to me is it combines an error test and error return
with the common return.

it's also being used and avoided / naked with the similar

	return min(ret, size);

https://lore.kernel.org/lkml/20211116121014.1675-1-zhaoxiao@uniontech.com/T/


