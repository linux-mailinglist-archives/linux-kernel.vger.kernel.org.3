Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAE0464A08
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhLAIqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:46:25 -0500
Received: from smtp1.axis.com ([195.60.68.17]:24189 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232256AbhLAIqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638348184;
  x=1669884184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LAK/bVC4aHlcgnP06p+vpyCO35Fk8GtaJt7UyHkSZTM=;
  b=SxV6O3teBg+1q4ml30bk9O4DsIuSTzI5D5O5HtdDRqsQQM9CngCcvKiJ
   s6vJCz6L8MXNo00QG/pFuOgkSASVhQIvjRzkDsaky2xmh0reosw3QHxIa
   jlDvkLXD7/xfAF4xAl04lh1FxhUL4CQcXKZKhQx9613RKbNUL1fLkQurw
   wAqBp+meLGGI6SZSDaPdwBDtE3RL4886GjhRgfagI654mRbiBy+xIKDbc
   +SidkUSC52IfvyQ9Xa5VFo0rlkEcLKxQaHt9st+dqUDEswqXSffMV05Iz
   Jl/oVpD6DBW7yOiTYpNKqUFajd0qBn+3FQZvqdsCPSR1TebXcoOR+Ypln
   w==;
Date:   Wed, 1 Dec 2021 09:43:02 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Camel Guo <Camel.Guo@axis.com>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: rs5c372: add offset correction support
Message-ID: <20211201084302.GA26222@axis.com>
References: <20211130095004.22777-1-camel.guo@axis.com>
 <f0e2eb3c-8e50-f6db-4c52-810da9c83b7a@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f0e2eb3c-8e50-f6db-4c52-810da9c83b7a@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 03:55:43PM +0100, Camel Guo wrote:
> Just realize that the oscillation adjustment registers of r2*, rs5c* are 
> not totally same and all of these differences need to be handled in 
> different way. Hence this patch needs to be updated to cover all cases.

Unless you have the hardware to actually test the other variants,
perhaps it would be safer to just reject them in ->set_offset /
->get_offset for now?  Returning -EINVAL for unsupported types should
make rtc_set_offset() and rtc_get_offset() have the same behaviour as
not implementing the callbacks for these variants.
