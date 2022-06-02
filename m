Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833B653BF58
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbiFBUKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbiFBUK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:10:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453DB319;
        Thu,  2 Jun 2022 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654200628; x=1685736628;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9jWrYxpK+WH9ONUJpmkdfMYuhpTZN9z07cUmCPDqVhY=;
  b=cbLF8XLcm6cEb6SoBK9CFenT4YwzjTtmy7U+D+Z+ieLYbeoN/JGP0Rji
   BtUr+sdrSZ9HZcu6aLBiPXHqkVuhQ1OTjgd15aePZ+W6kdByg6Kg1/NNf
   QRNHRmpN7O0JKL9+T4ROBZXE86uY4aWPhYVcqVq+U48zhQ1X3H/M0A0HN
   cAbgWpRuNjbKDTwn3yE2nW/uhHJ1XpQ56OI1DFeZxNMBei7UgOoufWC93
   FOumFSVNRQ41lxFeMAmo6vwpsSA4oqGuieprSsMyF5Znwyz4IMlDa1egG
   ydQY8DIUKmMb15/jmFgHy5VbqQxAaTOkrtiAVX9HaFPu4uUsV+3XL/Vqj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="275802056"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="275802056"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 13:10:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="553013809"
Received: from saianand-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.27.112])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 13:10:27 -0700
Message-ID: <21b7d5a3de39e9eee4ccda48ad0c66d31b1fe7d1.camel@linux.intel.com>
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
Date:   Thu, 02 Jun 2022 13:10:27 -0700
In-Reply-To: <CAK8P3a3aUtQ6C6kVmEZKzHv2tGL3=3WXK=_agc-Mg5Pq47vbdA@mail.gmail.com>
References: <CAK8P3a1mkHEjRJgJPsRy+kuN=48=JEDJAeR2z9n+O71qbJ8hSA@mail.gmail.com>
         <6caf53e059758234ee12a236f967412f1df1f8a0.camel@linux.intel.com>
         <CAK8P3a1mHe3TkZa443fzsPnGUP1XT3w-DN3U5KAL6NBhc2nEsw@mail.gmail.com>
         <079945077b128fcc3cb470e9d52267f7ac763b7a.camel@linux.intel.com>
         <CAK8P3a3aUtQ6C6kVmEZKzHv2tGL3=3WXK=_agc-Mg5Pq47vbdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-02 at 20:53 +0200, Arnd Bergmann wrote:
> On Thu, Jun 2, 2022 at 6:25 PM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Thu, 2022-06-02 at 18:18 +0200, Arnd Bergmann wrote:
> > > On Thu, Jun 2, 2022 at 5:52 PM srinivas pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > 
> > > > On Thu, 2022-06-02 at 11:19 +0200, Arnd Bergmann wrote:
> > > > > I have a Xeon W-2265 (family 6, model 85, stepping 7) that
> > > > > started
> > > > > constantly spewing messages from the therm_throt driver after
> > > > > one
> > > > > core overheated:
> > > > > 
> > > > I think this is a Cascade Lake system. Have you tried the
> > > > latest
> > > > micro-
> > > > code?
> > > 
> > > Thanks for your quick reply. I have installed the latest
> > > microcode
> > > 0x5003302
> > > now (manually, because the version provided by the distro was
> > > still
> > > using
> > > version 0x5003102).
> > > 
> > > After that, I tried writing the value 0x2a80 from userspace, and
> > > that did not cause a trap, so I assume that fixed it.
> > > 
> > Thanks for reporting.
> > I am aware of this issue and should be fixed by microcode update.
> 
> I wonder how common this problem it is. Would it help to add a driver
> workaround
> like this?
This issue affects only certain skews. The others already working as
expected. These are important log bits for debug, we don't want to
clear in this path. Printing warning for CLX stepping is fine without
clearing unrelated bits 13 and 15. 
Read-modify-update should always work where we only update the bits of
interest. Writing 1s to this register should be NOP.

Thanks,
Srinivas

> 
> diff --git a/drivers/thermal/intel/therm_throt.c
> b/drivers/thermal/intel/therm_throt.c
> index 8352083b87c7..acb402e56796 100644
> --- a/drivers/thermal/intel/therm_throt.c
> +++ b/drivers/thermal/intel/therm_throt.c
> @@ -214,7 +214,13 @@ static void clear_therm_status_log(int level)
> 
>         rdmsrl(msr, msr_val);
>         msr_val &= mask;
> -       wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
> +       if (wrmsrl_safe(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG)) {
> +               /* work around Cascade Lake SKZ57 erratum */
> +               printk_once(KERN_WARNING "Failed to update
> IA32_THERM_STATUS, "
> +                                       "please upgrade
> microcode\n");
> +               wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG &
> +                       ~BIT(13) & ~BIT(15));
> +       }
>  }
> 
>  static void get_therm_status(int level, bool *proc_hot, u8 *temp)
> 
>         Arnd

