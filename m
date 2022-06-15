Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D381954D51B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357494AbiFOXRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355278AbiFOXRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:17:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93411326E8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655335006; x=1686871006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bY3fKUHAmLFD0yM/TYiwTA6Jp1QNnt24Ewml6eGfPqQ=;
  b=C0gRpfMK1YbC+49NS7v4qZIppFL0oVp7RTWW/KGckRCcn0RtMbmuJxCc
   KQIz3Do73A3I+nESMHmF20AqmPiQRaG5OHgTrOUxsmwx8qWwd+fOGzWqd
   /2M8zjhIqzQStdrIgHcXlh19K3micjOC1877wTSSwOCp9PbNCXIWKLCgx
   /MCFNNOOco/FHaZ7pnpEgFEqLoBhHF2gkrNywd+ihL8ttg+JaVe4HgDZS
   WHDaRFozk+vt/fA+r6hW5gIoqihbybIZh2D3Fxf81KEbWuPS9nlGv1XjU
   S+bBZpAs9qnTY0hMs/D8BnlwQ308i71odUEpucL+iNY8dxVyvHKYqNdtg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="277917436"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="277917436"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 16:16:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="674755716"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2022 16:16:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0EC9D109; Thu, 16 Jun 2022 02:16:44 +0300 (EEST)
Date:   Thu, 16 Jun 2022 02:16:44 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad()
 page-cross to a shared page
Message-ID: <20220615231644.jpuzotsiuyuqwlgm@black.fi.intel.com>
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
 <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
 <051fd468-11e6-308b-66c8-4de16ff80deb@intel.com>
 <20220615171042.oeumb3vs3ttu4rvd@black.fi.intel.com>
 <1d190555-2bb1-e483-2405-e28ddabead07@intel.com>
 <20220615224303.el4qtowheu2rgpdn@black.fi.intel.com>
 <e7852739-0b68-65ef-2800-71337420a30a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7852739-0b68-65ef-2800-71337420a30a@intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 03:49:49PM -0700, Dave Hansen wrote:
> On 6/15/22 15:43, Kirill A. Shutemov wrote:
> > I will reword it like this:
> > 
> > 	The issue was discovered by analysis after triggering other issue with
> > 	load_unaligned_zeropad().
> 
> Yeah, that sounds sane.  I'm also happy to shove this into the commit
> message before I push it out.

It is fine as is in your tree.

-- 
 Kirill A. Shutemov
