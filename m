Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077B555DB51
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbiF1BPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242981AbiF1BP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:15:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D367322B2E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656378927; x=1687914927;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=g4aK040aBriUUhWE+Z8oUxYhPOJKeQMijUgvuZuOewk=;
  b=Re3KGsFhMzSJ+yZg5PQrx1jxHtQExEYkCpV7TZsFLborQbW/wpBGjesh
   xiAo2Drn2zIg0Ohk4yyUO9xJaVd4UCae4I0n5pojXz4jcLei+6oEht7RW
   3GWVZFRv1b1PmV2Vc3og3J+mvrn16UlwTV/wRJR3hn4eYVli3JmilndMy
   AAAUXOIcuzLeGHn/+uyAoGEYdvfL8D0YyWS3GXVz0D1R0I8773jam5ebF
   QARWwQKyZExiqMwwqySh84rtOi7HRY3zJ4deS+6hhoYagOhxi1aAgSIjk
   H2S0Lj5NnJrcGr3I7OQt5uFFdx+M/Tr104qaUXPqaxd15rxYypxO5D0/O
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="343291624"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="343291624"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:15:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="616997125"
Received: from iiturbeo-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.89.183])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:15:23 -0700
Message-ID: <6b84f9058ce5e60fdf3e4abd075a2b8f591ccffc.camel@intel.com>
Subject: Re: [PATCH v8 4/5] x86/mm: Add noalias variants of
 set_memory_*crypted() functions
From:   Kai Huang <kai.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 Jun 2022 13:15:21 +1200
In-Reply-To: <fe896ec7-cfce-e8ce-240d-88cca47f8996@intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220609025220.2615197-5-sathyanarayanan.kuppuswamy@linux.intel.com>
         <b4190b5d-89e8-b02f-5ef6-c05047af8166@intel.com>
         <20220627151257.fhynhvcnpk22kflw@black.fi.intel.com>
         <fe896ec7-cfce-e8ce-240d-88cca47f8996@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>=20
> I still don't like the idea of using the DMA API itself.  But, maybe we
> need some common infrastructure that the DMA API and this code use which
> says, "get me some pages that I can safely make shared".

Right.  For instance any KVM PV feature would require shared memory, and DM=
A API
normally doesn't fit (taking 'struct kvm_steal_time' as example).

Maybe we can reserve a CMA for this purpose.

--=20
Thanks,
-Kai


