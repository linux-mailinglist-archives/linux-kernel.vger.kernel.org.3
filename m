Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC1B51073F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351379AbiDZSk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343969AbiDZSk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:40:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCFA69CF2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:37:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C57A2618E6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC50C385A4;
        Tue, 26 Apr 2022 18:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650998266;
        bh=WiXSbg1inz4+HZNgAwnO2NFGzpWvm6UUxHLCn1D/lhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBeUsXg6vfVsAoeNyeuKPy6Zrx/xe6J5VDZl6IUNh2X5G0Taeg8m3ydVrDKqVk5CU
         kqrxPmY7mQZAcepOxEhIkipjDsIl7HsBYGiuL9FZjft6krz8n0eDPUrFwINzsckMx6
         y52cUTnErojZr5w5lhdxMgjLBnN63+pjOXChYy+E=
Date:   Tue, 26 Apr 2022 20:37:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     jirislaby@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tty: n_gsm: return -EINVAL when adaption is not supported
Message-ID: <Ymg79qM3Wq2rlYvj@kroah.com>
References: <20220426120554.1120585-1-trix@redhat.com>
 <Ymfhtv5b9M33AQuc@kroah.com>
 <4789ae7a-64a2-566b-d445-b8433d3f867a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4789ae7a-64a2-566b-d445-b8433d3f867a@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:16:35AM -0700, Tom Rix wrote:
> 
> On 4/26/22 5:12 AM, Greg KH wrote:
> > On Tue, Apr 26, 2022 at 08:05:54AM -0400, Tom Rix wrote:
> > > The clang build fails with
> > > n_gsm.c:940:13: error: variable 'size' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> > >          } else if (dlci->adaption == 2) {
> > >                     ^~~~~~~~~~~~~~~~~~~
> > > 
> > > The else should return an error, so return -EINVAL.
> > > 
> > > Signed-off-by: Tom Rix <trix@redhat.com>
> > What commit id does this fix?  Any reason you didn't cc: the author of
> > the recent changes to this code?
> Sorry missed this part.

Please always do that, otherwise it's hard to track, right?

> > Is this the same issue that 0-day reported?
> 
> Maybe, it was part of next's update today.  Where is 0-day reported ?

On the same mailing list you posted this patch to:
	https://lore.kernel.org/r/202204230704.5MxboEEo-lkp@intel.com

thanks,

greg k-h
