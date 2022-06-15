Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF1954D20C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbiFOTyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242953AbiFOTyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:54:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD45C27B18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655322888; x=1686858888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V9kSY/hKtbnoi0U4P4bOccf/8tM8aaLH3/8P4Blj6d4=;
  b=D5e27hx8JgIm8Mqm5/eTm67PvqffDkiL1B9T3HU+/mg1c9pI5jm/EPPQ
   tHeQBDud1jlAi1BFC5Yus+CjZo6KA3uztDE3ZuYHOjZYmK9C4IDDRgQu0
   kQ1cNbB3DtX6gTGgz8CI+GKvGAXIhttMZzHs0QP0Q1ZyTxMGQQDWsOjN5
   lsArmaafDBmdByDkTiWZALoQDQ5ZL/EU5Mk32o6So1OHqBbTZRNnMAd5j
   DThJkqvZXu0srRUXZE5s0VQbWIVM+7Hf18ocA/qO2l0AZ7Oykk3+5pMSq
   fFDYpZdjEgMVJ4pFCP+JqTwlQ3AouloYIAIgrx4qIbg5MyID7ABnpu/wx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="267777413"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="267777413"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 12:54:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="572780999"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 12:54:43 -0700
Date:   Wed, 15 Jun 2022 12:54:25 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, daniel.gutson@eclypsium.com,
        alex.bazhaniuk@eclypsium.com
Subject: Re: [PATCH] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
Message-ID: <20220615195425.GA1524649@alison-desk>
References: <20220614210217.1940563-1-martin.fernandez@eclypsium.com>
 <20220615190519.GA1524500@alison-desk>
 <CAD2FfiGxy=9ARK5FT_iaLACZSzR+R4crmGJv7T+v_w3+ktOzCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiGxy=9ARK5FT_iaLACZSzR+R4crmGJv7T+v_w3+ktOzCQ@mail.gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 08:34:58PM +0100, Richard Hughes wrote:
> On Wed, 15 Jun 2022 at 20:06, Alison Schofield
> <alison.schofield@intel.com> wrote:
> > My first reaction is lying about the cpuinfo is not a soln, since
> > it creates a problem for a users currently relying on cpuinfo to be
> > the source of truth for TME.
> 
> I think you have to qualify "source of truth". At the moment the CPU
> reports "Yes! I support TME!" and then for one reason or another the
> platform turns it off and actually there's no memory encryption of
> your secrets at all. There's seemingly no userspace way of telling if
> TME is actually active. We were told that we shouldn't export the
> "platform has disabled a CPU feature" in sysfs and just to clear the
> cpuid flag that gets exported (like AMD is currently doing) which is
> what Martin proposed here. Programs want to know the true CPU
> capability can do __get_cpuid_count() like they can for the SME/SEV
> capabilities.
>
Disagree on sending folks to use __get_cpuid_count() when they already
have cpuinfo.

Why is a sysfs entry TME-enabled 0/1 a bad thing?  It can be documented
to have the same meaning as the log message.

You keep referring to AMD. How is their exception documented?

Alison

> > Are we to tell them to go look in the
> > log now, because fwupd folks didn't want to ;)
> 
> We're not telling anyone to use the log; grepping megabytes of
> unformatted kernel logs is a terrible (and slow) way to get one
> boolean value.
> 
> Richard.
