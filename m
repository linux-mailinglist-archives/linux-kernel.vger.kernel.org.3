Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6884F4F40FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344656AbiDEUVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391747AbiDEPfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:35:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D04E139AC1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EAC9B81D73
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993CAC385A0;
        Tue,  5 Apr 2022 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649166168;
        bh=Bo1TLmFRPzMx504oGz1+72EDqWUNnp44Jv6KtOwHkao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAbBEiS56WV11mH8SJIEcCt/I/TPqKCtXjUnCImEkrEFFr5/+H0tUw/jiorz9dep+
         9v/+YdKdktiakuYU4InzvCB238HyBjVW9g3a1xRQDtrEpNlxSTLTR44tTiSDvBsAhn
         TPkR7hMHg3Trp747EATc8qicj8cgF/B1XblEqms8=
Date:   Tue, 5 Apr 2022 15:42:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Haren Myneni <haren@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/vas: use default_groups in kobj_type
Message-ID: <YkxHVS3kwXY12KSL@kroah.com>
References: <20220329142552.558339-1-gregkh@linuxfoundation.org>
 <87h77efg8e.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h77efg8e.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:39:45PM +1100, Michael Ellerman wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > There are currently 2 ways to create a set of sysfs files for a
> > kobj_type, through the default_attrs field, and the default_groups
> > field.  Move the pseries vas sysfs code to use default_groups field
> > which has been the preferred way since aa30f47cf666 ("kobject: Add
> > support for default attribute groups to kobj_type") so that we can soon
> > get rid of the obsolete default_attrs field.
> >
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Haren Myneni <haren@linux.ibm.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >
> > Note, I would like to take this through my driver-core tree for 5.18-rc2
> > as this is the last hold-out of the default_attrs field.  It "snuck" in
> > as new code for 5.18-rc1, any objection to me taking it?
> 
> No objection, please take it via your tree.

Thanks, now queued up.

greg k-h
