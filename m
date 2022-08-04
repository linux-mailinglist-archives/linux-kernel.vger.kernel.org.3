Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAF6589AFA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiHDLWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiHDLWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCDA2AE3C;
        Thu,  4 Aug 2022 04:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B31E61633;
        Thu,  4 Aug 2022 11:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CAFC433C1;
        Thu,  4 Aug 2022 11:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659612126;
        bh=+6dpbCtRNHtHBP52GVj83vVSR1+Voq0GAalHci9STfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H96xntaymC3uNf+tMPPHBHt/Oyt8sPKSgJkgAbsJPwMRIj8i4D2aVzWriBLvnsnc/
         Ryc1VzufKdWBXVfGwQeg8VDhM954gGrFU+xGs0kzGcQksD7hE9J4tm4NgRARONKlga
         UOt0wRnhz5tTTqwri2t62CKOoHf6SaUL/cR/z7WE=
Date:   Thu, 4 Aug 2022 13:22:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] x86_64: Harden compressed kernel, part 1
Message-ID: <Yuur2x+H5ESwJmcr@kroah.com>
References: <cover.1659369873.git.baskov@ispras.ru>
 <e6e7fef1-0dff-ef72-8a17-8ecec89994ca@intel.com>
 <893da11995f93a7ea8f7485d17bf356a@ispras.ru>
 <e8342722-20f8-a566-59c5-8e8f7f271d98@intel.com>
 <29312ea704885f1b8d3c229e1f22dad7@ispras.ru>
 <973736db-2480-bbaa-d2ce-6e1b6dd2ed0c@intel.com>
 <09c1c94fb9c5006199d88caa88f237a3@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c1c94fb9c5006199d88caa88f237a3@ispras.ru>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 01:41:58PM +0300, Evgeniy Baskov wrote:
> On 2022-08-03 17:05, Dave Hansen wrote:
> > 
> > That shows me that it's _possible_ to build a more strict PE loader that
> > wouldn't load Linux.  But, in practice is anyone using a more strict PE
> > loader?  Does anyone actually want that in practice?  Or, again, is this
> > more strict PE loader just an academic demonstration?
> > 
> > The README starts:
> > 
> > 	This branch demonstrates...
> > 
> > That doesn't seem like something that's _important_ to deal with.
> > Sounds like a proof-of-concept.
> > 
> > Don't get me wrong, I'm all for improving thing, even if the benefits
> > are far off.  But, let's not fool ourselves.
> 
> We have commercial closed-source UEFI firmware implementation at ISP RAS
> that follows the behavior of the secure_pe branch. That firmware is used
> as a part of [1].
> 
> [1] https://www.ispras.ru/en/technologies/asperitas/

Are there any plans on getting those changes merged back upstream to the
main UEFI codebase so that others can test this type of functionality
out?

thanks,

greg k-h
