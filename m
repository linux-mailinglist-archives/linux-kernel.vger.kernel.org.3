Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B964AF121
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiBIMNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiBIMNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:13:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D57E019D2B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644407897; x=1675943897;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Q/BvhSiQvO4mI0xac+MpTU0XmLzmW9BnHuDGRE2cKQ=;
  b=PIcKs8PngyMovtOXenT+PCG+VHnZreDq5iRODjL6F40foA6/bi6mfBEq
   CbHGg7Y2cloe+EbsAJhxd6eVOFOTXTZcFqtNS1pUFJifDi/BpnkCUG3Cf
   fcO3/d0zCOdWLOkUxwKhCPDwt92A3pE+kHi9WxtF+wZPWPgjTr2dBtJeS
   C5Dqfk6171wru5q2BGBYo51XollXSOT0hh7lqSucotUVrmegKMdYJQQPc
   IpoyfObAB8Z6RRtRFua8/CcUvFsr1A/EVmHJoS/JK34MKiqPNq6z6EtTs
   NNRCC9olR8ybTHKOHMUfwUkaMxKfXQUu4cqovbSQyInsPDGzjwOlZz4UZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="335589559"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="335589559"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:58:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="585540038"
Received: from ravicha1-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.255.88.114])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:58:12 -0800
Date:   Thu, 10 Feb 2022 00:58:10 +1300
From:   Kai Huang <kai.huang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-Id: <20220210005810.bb36647eff7b74811ac88098@intel.com>
In-Reply-To: <YgOr6tZjsooJgAi9@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
        <20220209235613.652f5720cd196331d7a220ec@intel.com>
        <YgOgog9Pb886lfsv@zn.tnic>
        <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
        <YgOoId+vyd1VhIqQ@zn.tnic>
        <20220210004831.03dea501738bee060003d040@intel.com>
        <YgOr6tZjsooJgAi9@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022 12:56:26 +0100 Borislav Petkov wrote:
> On Thu, Feb 10, 2022 at 12:48:31AM +1300, Kai Huang wrote:
> > Are you suggesting even for now we can start to put TDX host support to
> > arch/x86/coco/tdx/ ?
> 
> That's exactly what I'm suggesting. The TDX stuff is not upstream so
> nothing's cast in stone yet. This way there won't be any unpleasant code
> movements later.
> 
> But let's wait to see what the bikeshed discussion will bring first and
> then start moving files.
> 

Sure.  Thanks.
