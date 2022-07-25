Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBBB57FDA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiGYKge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbiGYKgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:36:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6A9167DE;
        Mon, 25 Jul 2022 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658745383; x=1690281383;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=THMuk/+fHLYsNtlG0j7lAFgILZf63dS0Zd2Cx2MnyCs=;
  b=c30FFe52mgCGOxlSbMcczY3cWPdSdEFKjWnpLCmS6mnWG7DNxNpPpRZK
   65f5Lq0zFewUZ1no7sruq1wAfQUgeD3vmAmZYoR4viHFAqiiaK3J00Chy
   FMPiO791REOW1n99cwSCQ6sAU/Czb1RO8CowVb/zMhqOTuGh+/KOfuzUx
   1OztQZhwzKp5/gphPqrISWe9c5Cd0DRagucmdDOpEZQ5ftmnZWYR1mnsR
   +xt3Ef6XUvreS3ATuUPEl7moj6B7zYbsknDuHmpoGUuq/kZxr/Qg6Tc/q
   rL2bF7QZRIyR6zmAFH2eOfdKCErNcU1ywzGLjfYUyDgrT3wCsRoR/J4w7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="287678395"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="287678395"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 03:36:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="596635665"
Received: from edere-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.168.34])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 03:36:19 -0700
Message-ID: <06a9fef8579e880b9b031f03911739d4d902dbe0.camel@intel.com>
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
From:   Kai Huang <kai.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Haitao Huang <haitao.huang@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Jul 2022 22:36:17 +1200
In-Reply-To: <a82e840f-2030-7ab3-7160-f1b900ecdb7d@intel.com>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
         <ab467244dd03b5f94bafe9068b1c02790033c18c.camel@intel.com>
         <a82e840f-2030-7ab3-7160-f1b900ecdb7d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-22 at 08:21 -0700, Dave Hansen wrote:
> On 7/22/22 06:26, Kai Huang wrote:
> > Did a quick look at the spec.  It appears ENCLU[EDECCSSA] should be use=
d
> > together with AEX-notify.  So besides advertising the new
> > SGX_ATTR_ASYNC_EXIT_NOTIFY bit to the KVM guest, I think we should also
> > advertise the ENCLU[EDECCSSA] support in guest's CPUID, like below (unt=
ested)?
>=20
> Sounds like a great follow-on patch!  It doesn't seem truly functionally
> required from the spec:
>=20
> > EDECCSSA is a new Intel SGX user leaf function
> > (ENCLU[EDECCSSA]) that can facilitate AEX notification handling...
>=20
> If that's wrong or imprecise, I'd love to hear more about it and also
> about how the spec will be updated.
>=20

They are enumerated separately, but looks in practice the notify handler wi=
ll
use it to switch back to the correct/targeted CSSA to continue to run norma=
lly
after handling the exit notify.  This is my understanding of the "facilitat=
e"
mean in the spec.

Btw, in real hardware I think the two should come together, meaning no real
hardware will only support one.=20

Haitao, could you give us more information?

--=20
Thanks,
-Kai


