Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F18534D26
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiEZKP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiEZKPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:15:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E427AC9ED2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QrMQdl+7eAngoEDHGtum/kWjmPhefhrNuIZO2rfUGK0=; b=MY1f+zSXnf+Tg/WVXnC/OUlg+N
        RFGdqCbYG4Tq+yt2mJ1+9OoxOtIMoKtqoCkL56e0ew5yT05JpPekpgbY3/Z/OEeCz+sbnqBkWyhAC
        8nDhYfflOgQEUFKqPLtZ86HrxzLsqFJ72PkR2me+CgZQKT7PIIIjbmIkVMfOFy4Gt58n0x8sCGElo
        YJQqoUGeTBFJd0okk2UwNIqo5Ix3jSOnbSLCBgFRbBb0BQ0eLmNFPyYK2LBDUzLsWTOoLsuIqjDoK
        9dV8gQ3u5Pur7bEu8jS7F0ocZko+eiGUVJ/8gttIA6JGpjPml3Zy4g1LT9jzerccmTfB0pEhaNNfW
        qMutxnTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuAWo-0019o4-Tc; Thu, 26 May 2022 10:15:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1D61981124; Thu, 26 May 2022 12:15:36 +0200 (CEST)
Date:   Thu, 26 May 2022 12:15:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        vschneid@redhat.com, kernel-team@android.com,
        Derek Dolney <z23@posteo.net>
Subject: Re: [PATCH v2] cpu/hotplug: Do not bail-out in DYING/STARTING
 sections
Message-ID: <20220526101536.GP2578@worktop.programming.kicks-ass.net>
References: <20220523160536.2889162-1-vdonnefort@google.com>
 <20220525165248.GI2578@worktop.programming.kicks-ass.net>
 <Yo85PLANCnCcMgvD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo85PLANCnCcMgvD@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 09:24:28AM +0100, Vincent Donnefort wrote:
> On Wed, May 25, 2022 at 06:52:48PM +0200, Peter Zijlstra wrote:
> > On Mon, May 23, 2022 at 05:05:36PM +0100, Vincent Donnefort wrote:
> > > The DYING/STARTING callbacks are not expected to fail. However, as reported
> > > by Derek, drivers such as tboot are still free to return errors within
> > > those sections. In that case, there's nothing the hotplug machinery can do,
> > > so let's just proceed and log the failures.
> > > 
> > 
> > I'm confused. Why isn't this a driver bug?
> 
> It is a entirely a driver bug which has been reported already. but 453e41085183
> (cpu/hotplug: Add cpuhp_invoke_callback_range()) changed the behaviour so I
> thought it would be worth to revert to the original one which is to not break
> the entire up/down for a single driver error.

Ah I see. Fair enough I suppose.
