Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE20532361
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiEXGkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiEXGkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:40:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B393097298
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653374410; x=1684910410;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HtCin+nAwOXG3nZ+p4h+iXUr/5UlMzCjdj1v1QwpFPc=;
  b=icB5zedglgHLscp4FExFFiZMH8XSUQ990+jXBavsbAwlgnVBDD3l69AX
   fA0HhrYY0n275+iqtQxgxt3LgLPXjc/2dSOlqRHPL52OylBYiVZkPB9gh
   8YDrWKiUdAiFhbVQinQNrhwb85EuwzV+Cwn9tT6WpZtMgV7rMMNmZ7e6w
   gQU7wXPcmY7vIioJa6uqcuIRd4At3Cmk3q+HHDUleSCT8KaRiWqfyl5Az
   3NaMdMCV04muVSPVDP0dx7I6Nt60NA9yWQddUOIcOAAbpo6XmI4qohAtV
   G8Up0jZXAq/elyYuM24nashQqAPkAT4S/ah1UE0Fs1S0u/17vIMAxHoo/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273440835"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273440835"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 23:40:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="526280931"
Received: from woonjonx-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.3.168])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 23:40:06 -0700
Message-ID: <2db114898222afd86eee77bf8ac46099c75f154e.camel@intel.com>
Subject: Re: [PATCH v7 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
From:   Kai Huang <kai.huang@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 24 May 2022 18:40:04 +1200
In-Reply-To: <20220524040517.703581-3-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220524040517.703581-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-23 at 21:05 -0700, Kuppuswamy Sathyanarayanan wrote:
> +/* Helper function to register tdx_event_notify_handler */
> +void tdx_setup_ev_notify_handler(void (*handler)(void))
> +{
> +	tdx_event_notify_handler = handler;
> +}
> +EXPORT_SYMBOL_GPL(tdx_setup_ev_notify_handler);
> +
> +/* Helper function to unregister tdx_event_notify_handler */
> +void tdx_remove_ev_notify_handler(void)
> +{
> +	tdx_event_notify_handler = NULL;
> +}
> +EXPORT_SYMBOL_GPL(tdx_remove_ev_notify_handler);

I don't think you need to export the two symbols now.

-- 
Thanks,
-Kai


