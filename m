Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5E953BC74
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiFBQ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbiFBQ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:26:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB672B07F6;
        Thu,  2 Jun 2022 09:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654187166; x=1685723166;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K0itMtVsdIh11uGolFyo+JgLbg/FBJd2Kzp6ffSaV2k=;
  b=JkqVPzyhVIlNYX8Mn0eHbll8avkwM1Y640efMMk/DW2OBnUtsTQRollV
   8ftH58O4DXGBHKRxbcltiO07/zAahYJ4nzzKo2zWqCn99Jb5YzaEggmlC
   BhkVADyu4kjIo2JNx/FT8s5dwxcQGRqd9Emuw2cFT6WD9r2LvKoG7amnJ
   URJ5R605cGwepRE7bNgBELsVS1RWX5H/c7EpG5/RtIPvsJcIkOoFdUJMy
   leDMDc9KnA1vVrNEtSXmgvUH0Uip5aMzA01M9Ze77tfL+hlWXdROuOKG0
   1HnrKKV3YUCdCa4PFWX1A45Mod46mve6V++kL8qt9hlkJODvTdcMVaNmT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="276074059"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="276074059"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 09:26:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="563381701"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 09:26:05 -0700
Message-ID: <079945077b128fcc3cb470e9d52267f7ac763b7a.camel@linux.intel.com>
Subject: Re: x86/mce/therm_throt incorrect THERM_STATUS_CLEAR_CORE_MASK?
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Jun 2022 09:25:57 -0700
In-Reply-To: <CAK8P3a1mHe3TkZa443fzsPnGUP1XT3w-DN3U5KAL6NBhc2nEsw@mail.gmail.com>
References: <CAK8P3a1mkHEjRJgJPsRy+kuN=48=JEDJAeR2z9n+O71qbJ8hSA@mail.gmail.com>
         <6caf53e059758234ee12a236f967412f1df1f8a0.camel@linux.intel.com>
         <CAK8P3a1mHe3TkZa443fzsPnGUP1XT3w-DN3U5KAL6NBhc2nEsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-02 at 18:18 +0200, Arnd Bergmann wrote:
> On Thu, Jun 2, 2022 at 5:52 PM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Thu, 2022-06-02 at 11:19 +0200, Arnd Bergmann wrote:
> > > I have a Xeon W-2265 (family 6, model 85, stepping 7) that
> > > started
> > > constantly spewing messages from the therm_throt driver after one
> > > core overheated:
> > > 
> > I think this is a Cascade Lake system. Have you tried the latest
> > micro-
> > code?
> 
> Thanks for your quick reply. I have installed the latest microcode
> 0x5003302
> now (manually, because the version provided by the distro was still
> using
> version 0x5003102).
> 
> After that, I tried writing the value 0x2a80 from userspace, and
> that did not cause a trap, so I assume that fixed it.
> 
Thanks for reporting.
I am aware of this issue and should be fixed by microcode update.

Thanks,
Srinivas

> It's hard to be sure, as the system has only run into the broken
> state twice during its life, and now it's fine. I'll reply here if it
> ever comes back with the new microcode.
> 
> Thanks a lot!
> 
>        Arnd


