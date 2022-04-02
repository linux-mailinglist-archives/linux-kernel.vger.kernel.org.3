Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A894F0005
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347679AbiDBJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiDBJPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:15:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6750F532D5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 02:13:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01229611A5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3227C340EC;
        Sat,  2 Apr 2022 09:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648890792;
        bh=CKBGdL4fzfJl0zSr2Nh3CRBUsgg+gNUR9uNnFCWZvD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tiAiScO5KLfylFnjuy07u7WjweWKlRN0OVQ6Qtw32oL1RBje1SaKAU55EIpB568MR
         KQNDNFBmx3mabrkDXLB8V99V+j9Iq5PBX62V4SOobkAnzVZuXXcCTDifa5XUBPl9Ol
         X424QJCXSCHPRzZlORv/yBhlHRf/DCLXzRqyXl6A=
Date:   Sat, 2 Apr 2022 11:13:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: simplify control flow
Message-ID: <YkgTpS+pzhWPgVIh@kroah.com>
References: <20220401114635.GA567659@euclid>
 <YkdvzIyz/WGlm2uy@iweiny-desk3>
 <20220401224619.GA71483@euclid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401224619.GA71483@euclid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 06:46:19PM -0400, Sevinj Aghayeva wrote:
> On Fri, Apr 01, 2022 at 02:34:04PM -0700, Ira Weiny wrote:
> > On Fri, Apr 01, 2022 at 07:46:35AM -0400, Sevinj Aghayeva wrote:
> > > The function iterates an index from 0 to NUM_PMKID_CACHE and returns
> > > the first index for which the condition is true. If no such index is
> > > found, the function returns -1. Current code has a complex control
> > > flow that obfuscates this simple task. Replace it with a loop.
> > > 
> > > Also, given the shortened function body, replace the long variable
> > > name psecuritypriv with a short variable name p.
> > > 
> > > Reported by checkpatch:
> > > 
> > > WARNING: else is not generally useful after a break or return
> > > 
> > > Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> > 
> > Wow!  Nice find!  This is a huge clean up.  Extra kudos recognizing that it is
> > not just the else statement which is broken here!
> 
> Thanks! It took me a while to realize what this loop is doing.
> 
> > The only issue for the patch is that I don't see any maintainer emailed?
> > However, I don't see a maintainer listed in the MAINTAINERS file so ...
> > 
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> Thanks for the review!
> 
> Greg, please do not apply this yet. After I sent out the patch, I
> noticed the comment at the top of the function:
> 
> /*  Ported from 8185: IsInPreAuthKeyList(). (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.) */
> 
> So I did a git grep to find the original function and fix it as well,
> and it looks like there are three copies of the same function in
> different files:
> 
> $ git grep IsInPreAuthKeyList
> r8188eu/core/rtw_mlme.c:/*  Ported from 8185: IsInPreAuthKeyList(). (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.) */
> rtl8712/rtl871x_mlme.c: * Ported from 8185: IsInPreAuthKeyList().
> rtl8723bs/core/rtw_mlme.c:/*  Ported from 8185: IsInPreAuthKeyList(). (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.) */
> 
> I will later send a v2 patch that replaces all of them.

No, please do one patch per driver.  These are all different drivers
(cut/pasted from some original source), so this patch is fine as-is.
You can make 2 other patches as well for the other drivers.

thanks,

greg k-h
