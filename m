Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5773555099
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376310AbiFVQA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376308AbiFVQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A11FD1AF15
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655913558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1NdMm0iLNJd/24Dw1R7/L5qi45bvELpzRHktbWg9Imw=;
        b=HbZp+yqRd/lZzfe4wscfMXAXjrj6nrZleHEtcDZhW7GQvL3MwgZJkQAyj/YGdx18BrTL4U
        s74DEF7LVMsXmC4DbbCA4eg6oiUI9kG7vhDp3es7Dp5MGOkx0uIpK8yO61qFqJHRgEGXXu
        OHZF/5KqRI4670KptTwijHxfpxvh+JY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250--_HLc7psOCOZoQTxdDKulQ-1; Wed, 22 Jun 2022 11:59:13 -0400
X-MC-Unique: -_HLc7psOCOZoQTxdDKulQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93720101E165;
        Wed, 22 Jun 2022 15:59:12 +0000 (UTC)
Received: from starship (unknown [10.40.194.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E0BB40D282F;
        Wed, 22 Jun 2022 15:59:07 +0000 (UTC)
Message-ID: <f741d8ed1c923ab7dc3d90c8f281b6779efc96c8.camel@redhat.com>
Subject: Re: [PATCH 2/4] x86/cpuid: refactor
 setup_clear_cpu_cap/clear_feature
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jane Malalane <jane.malalane@citrix.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 22 Jun 2022 18:59:06 +0300
In-Reply-To: <677c46db-02ef-24b8-c25f-762b41fb8bdb@intel.com>
References: <20220622144820.751402-1-mlevitsk@redhat.com>
         <20220622144820.751402-3-mlevitsk@redhat.com>
         <677c46db-02ef-24b8-c25f-762b41fb8bdb@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-22 at 08:07 -0700, Dave Hansen wrote:
> On 6/22/22 07:48, Maxim Levitsky wrote:
> > Simplify the code a bit by always passing &boot_cpu_data
> > in case the setup_clear_cpu_cap was called.
> > 
> > Also unify clear_cpu_cap and do_clear_cpu_cap.
> 
> Please always add a "()" suffix to functions.  "foo" is a variable, but
> "foo()" is a function.
Will do next time!


> 
> I also really like when a changelog has a clear problem statement.  I
> _think_ the problem here is something along the lines of the 'c'
> argument to clear_feature() having different behavior when it is NULL
> versus '&boot_cpu_data'.

To be honest I didn't try to fix any problem here, I just wanted to simplify
clear_feature() a bit by avoiding a recursive call to clear_cpu_cap.

> 
> Basically, there's no reason to support clearing a bit in
> '&boot_cpu_data' without also setting that bit in 'cpu_caps_cleared'.

> >  {
> > -	do_clear_cpu_cap(NULL, feature);
> > +	clear_cpu_cap(&boot_cpu_data, feature);
> >  }

I'll try to think about a better changelog message for this.

Thank you!
Best regards,
	Maxim Levitsky

