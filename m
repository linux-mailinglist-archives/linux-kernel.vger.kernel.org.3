Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F8749E6A8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243233AbiA0PvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243227AbiA0PvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:51:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA81C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:51:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19761B80139
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68692C340E4;
        Thu, 27 Jan 2022 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643298666;
        bh=DNoQV3+BuDvj03mxhp8NClXgSuG6Ri+NZixUbJONTGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfT1lJkWbH8L2JkHsqYfGaRoM0DxsJDqGDeaK9JEACpuRKZUAeTqsg42Ye9Dy7iAq
         sLWw1ZFb8I4AsrU2BJjS/RAmLkVtGjLn0qxXL4uflaNNR4BbYevpn6eh4iNr7n2jsX
         qJrsPMHdTfUh/Sq+Q91DcYrkfHOmvdfZzfofqa+0=
Date:   Thu, 27 Jan 2022 16:51:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abdun Nihaal <abdun.nihaal@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] staging: r8188eu: remove unneeded ret variables
Message-ID: <YfK/aOgEqftXuj1S@kroah.com>
References: <cover.1641551261.git.abdun.nihaal@gmail.com>
 <c9c24c13d2823ccaadbbce33613d1242531dbe86.1641551261.git.abdun.nihaal@gmail.com>
 <YfATARBq6FJ2e3HE@kroah.com>
 <20220127152543.ttvp7gj5bzpuvr3p@nlap2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127152543.ttvp7gj5bzpuvr3p@nlap2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:55:43PM +0530, Abdun Nihaal wrote:
> Hello Greg,
> 
> On Tue, Jan 25, 2022 at 04:10:57PM +0100, Greg KH wrote:
> > Many, if not most, of these functions should either be having their
> > return value checked, or be void functions as no one checks their return
> > value and they can not fail.  Please split this up and look at each
> > function to determine which is is and how to fix it up properly.  Just
> > returning 0 all the time is not the correct thing to do all the time.
> > 
> > One example would be rtw_p2p_get_status()  It can not fail, so why does
> > it return anything?
> 
> Thanks for reviewing the patches.
> 
> I had split the changes in a way that the first patch removes the
> unneeded return variables and the second patch converts the functions
> (changed by the first patch) whose return values are not used, to return
> void.
> 
> But yes, I now think, it is better to just convert the functions
> whose return values are not used, directly to return void instead of
> first removing the unneeded return variable and then converting
> to return void.
> 
> I'll resend this as a single patch.

A single patch per function you are changing is a good idea.  Do not mix
them all together, would you want to review something like that?

Always remember that you want to make changes obvious and simple to
review.

thanks,

greg k-h
