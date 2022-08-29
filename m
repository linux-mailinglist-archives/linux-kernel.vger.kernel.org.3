Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4E5A4608
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiH2JZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiH2JZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:25:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68BB4A812;
        Mon, 29 Aug 2022 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661765122; x=1693301122;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=6bjFxwLEsKLZFX2cLm7NlJwmIJ4DJEjhNXC6KOzn034=;
  b=nyjuoEazH8aUUwRUsqh4suVO1afz0fmuGY9alBp7zRXg5FO7FwsuYbyA
   RqRLIxTesXpMfzORMHXEtJNq1jI/O2oLk3ncmGuLRCnB7gyU/NCG7UDr1
   eeA0Sx2UHzeo1Vps1nr7puzRIiktzlypACFH96mYeXfyaRi0yxXmiU6AY
   ot5ws1906Oz0cI5m8fnKnDwdh/lHElULZo/NRtlPI3VvtrDg5666DKQ9n
   jkltnGTPXYjkBgryR+T+2XukZ/WCDlTCHROZQzKL9SYS42k3plLaZQc3i
   76iLPVY95itR3vHn9c64ulGvhVsRMlaGe7DpnaBDP+MkbdF+x4Uw1e25x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="292433488"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="292433488"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 02:25:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="640869351"
Received: from idecesar-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.53.198])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 02:25:09 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN()
 rules ("do not crash the kernel")
In-Reply-To: <CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com>
 <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
 <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com>
 <fe7aee66-d9f7-e472-a13f-e4c5aa176cca@redhat.com>
 <CALu+AoRwVfr=9KabOLUQigWwCtP5RLQ1YaKbG75ZVM9E-bW2ZQ@mail.gmail.com>
 <CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com>
Date:   Mon, 29 Aug 2022 12:25:02 +0300
Message-ID: <87tu5vflld.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Aug 2022, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> So WARN_ON_ONCE() is the thing to aim for. BUG_ON() is the thing for
> "oops, I really don't know what to do, and I physically *cannot*
> continue" (and that is *not* "I'm too lazy to do error handling").

Any insight for the tradeoff between WARN_ON_ONCE() and WARN_ON(),
i.e. wasting the static once variable per use site vs. littering the
dmesg on every hit? I see there have been some improvements with the
__WARN_FLAGS() stuff, but is the data use really neglible?

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
