Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7C46ED1B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhLIQgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:36:35 -0500
Received: from linux.microsoft.com ([13.77.154.182]:49142 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhLIQgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:36:33 -0500
Received: from nramas-ThinkStation-P330 (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id F349E20B7179;
        Thu,  9 Dec 2021 08:32:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F349E20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639067580;
        bh=N3wpQ5OLnIzxXcnsuI1kbDFWKuA1aIQDkbQuBarQopw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Fj/fROnNZjTIOKMcjACq+Rws/AS2Kdzlmi+tmOIw49UIRVqYvhuUog0qTewV7H4l4
         GkWYWfEQsv09BauGj9qBdBJ53jUKXjZv7eLOOl9wKJU+uqH8QATzUOF2NZDcQGyXB3
         62pxqEM+WsKCrZL1ZmSgoBlIixaUBNha6gZXIT9c=
Message-ID: <c287f9be2a6e28da0f1342991afa94ffbcb190c4.camel@linux.microsoft.com>
Subject: Re: [PATCH] arm64: kexec: Fix missing error code 'ret' warning in
 load_other_segments()
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     dan.carpenter@oracle.com, robh@kernel.org, will@kernel.org,
        kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bauerman@linux.ibm.com, qiuguorui1@huawei.com
Date:   Thu, 09 Dec 2021 08:32:59 -0800
In-Reply-To: <YbHHhRnpR/EtSV3f@arm.com>
References: <20211209004522.91926-1-nramas@linux.microsoft.com>
         <YbHHhRnpR/EtSV3f@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Thu, 2021-12-09 at 09:08 +0000, Catalin Marinas wrote:
> On Wed, Dec 08, 2021 at 04:45:22PM -0800, Lakshmi Ramasubramanian
> wrote:
> > 
> > Set return code to -ENOMEM if of_kexec_alloc_and_setup_fdt()
> > returns
> > NULL dtb.
> > 
> > 
> > @@ -149,6 +149,7 @@ int load_other_segments(struct kimage *image,
> >  					   initrd_len, cmdline, 0);
> >  	if (!dtb) {
> >  		pr_err("Preparing for new dtb failed\n");
> > +		ret = -ENOMEM;
> >  		goto out_err;
> >  	}
> 
> Above the 'if' block we have:
> 
> 	dtb = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
> 					   initrd_len, cmdline, 0);
> 
> Looking at this function, it has several ways to fail, not just on
> allocation. However, we assume above that it's always -ENOMEM. We
> could
> do like powerpc and use -EINVAL as more likely than allocation
> failure
> or change of_kexec_alloc_and_setup_fdt() to return ERR_PTR() and we
> use
> that. The latter would be my preferred option, though it probably
> doesn't matter much. The second best would be -EINVAL.

I'll change the error code to -EINVAL and post an updated patch.

thanks,
 -lakshmi


