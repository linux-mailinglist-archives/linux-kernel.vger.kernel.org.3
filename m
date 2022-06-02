Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73BC53BE48
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbiFBS7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbiFBS7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:59:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8161B9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:58:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654196336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v8IGqJGIeDODQ+TG/T3Dc6LxVQh1/m/R7hZO2TEAxMA=;
        b=TbYWU3JtO0xw15TdWUD0lAO09J/Kkbpj5okBLNgIUDuOmK3Ctg2b2iW4e0I1+Z7QBazlWs
        7+ErPerfLxbA/+qsWJXgGz1HGkfEQz+eJcHJ+jlCQ1rH1sD6Nx5Xt3Ms7NoPUtN3vgTBP1
        ngtL/3SSb6NU+bpy0Vs/qNntgzJh/ugDFuG/gCGsP0vaOHwUUnzHjUKWeH/RYzjHfwDBLN
        3hOTX2g+2DfNaRBip8IbC59vzlhvY2AEa2yzRlq0pa4THuU3qy+D2k1A5We8gn4PR6AMbc
        kb5gnhioIKioXA10788+/KaesHsm2hE47VT/YrvexF/1odQ2bf9Vf1uzgjF4iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654196336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v8IGqJGIeDODQ+TG/T3Dc6LxVQh1/m/R7hZO2TEAxMA=;
        b=4Kh+YKbvSFBY9VvcBAyeDt5KrmHLmnVENdft2puR4+aLUKVa0kr+/E/jLodmnmYF91InQD
        hJxNDW0PvB6t/GBw==
To:     Yue Zou <zouyue3@huawei.com>, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, mhiramat@kernel.org,
        rostedt@goodmis.org, ahalaney@redhat.com, vbabka@suse.cz,
        Jason@zx2c4.com, mark-pk.tsai@mediatek.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] smp: Move stub from main.c into smp.h
In-Reply-To: <20220528111122.1888581-1-zouyue3@huawei.com>
References: <20220528111122.1888581-1-zouyue3@huawei.com>
Date:   Thu, 02 Jun 2022 20:58:56 +0200
Message-ID: <87ilpievtb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28 2022 at 11:11, Yue Zou wrote:
>  #else /* !SMP */
>  
> +static const unsigned int setup_max_cpus = NR_CPUS;

This will cause a 'defined but not used warning' for all files which
include smp.h, except for init/main.c

Thanks,

        tglx



