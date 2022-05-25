Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B207C533567
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 04:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243631AbiEYCjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 22:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiEYCji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96CB26F4AF
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653446375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c29JYqgKyszX3zlDGk0SPP0l42Lw3lpdi4CkManELV8=;
        b=b26Meo55WJ3uDd8OJTNIZ2iRl+rj6NHaC11PyWQKixe5So++Bci5NBhbV90WVh4EENGLLY
        t+3nVkCNVJRcaArZBCPXtD3Mwend/p5LcQa79XnVfYrGl82B4Im0/4z3J5kgYXi7KmTu2Z
        6RRaIY/wlHYa84p8nhCIv4c2APzfNGo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-YS2pbs7MPDKH_uUoHIaD4A-1; Tue, 24 May 2022 22:39:32 -0400
X-MC-Unique: YS2pbs7MPDKH_uUoHIaD4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC3771E7DCD0;
        Wed, 25 May 2022 02:39:31 +0000 (UTC)
Received: from localhost (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DF9B2166B29;
        Wed, 25 May 2022 02:39:30 +0000 (UTC)
Date:   Wed, 25 May 2022 10:39:26 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bixuan Cui <cuibixuan@huawei.com>,
        David Vernet <void@manifault.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 0/2] Expose kallsyms data in vmcoreinfo note
Message-ID: <Yo2W3mH/5uuAJyw5@MiWiFi-R3L-srv>
References: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
 <YoTIMEPAxLF9t2eo@MiWiFi-R3L-srv>
 <878rqs163s.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rqs163s.fsf@stepbren-lnx.us.oracle.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/22 at 11:00am, Stephen Brennan wrote:
> Baoquan He <bhe@redhat.com> writes:
> > On 05/16/22 at 05:05pm, Stephen Brennan wrote:
> >> The kernel can be configured to contain a lot of introspection or
> >> debugging information built-in, such as ORC for unwinding stack traces,
> >> BTF for type information, and of course kallsyms. Debuggers could use
> >> this information to navigate a core dump or live system, but they need
> >> to be able to find it.
> >> 
> >> This patch series adds the necessary symbols into vmcoreinfo, which
> >> would allow a debugger to find and interpret the kallsyms table. Using
> >> the kallsyms data, the debugger can then lookup any symbol, allowing it
> >> to find ORC, BTF, or any other useful data.
> >> 
> >> This would allow a live kernel, or core dump, to be debugged without
> >> any DWARF debuginfo. This is useful for many cases: the debuginfo may
> >> not have been generated, or you may not want to deploy the large files
> >> everywhere you need them.
> >> 
> >> I've demonstrated a proof of concept for this at LSF/MM+BPF during a
> >> lighting talk. Using a work-in-progress branch of the drgn debugger, and
> >> an extended set of BTF generated by a patched version of dwarves, I've
> >> been able to open a core dump without any DWARF info and do basic tasks
> >> such as enumerating slab caches, block devices, tasks, and doing
> >> backtraces. I hope this series can be a first step toward a new
> >> possibility of "DWARFless debugging".
> >
> > Thanks. Seems no reason to reject, even though I haven't tried drgn.
> > And hope it has no security issue, e.g info leakage, at least I don't
> > see it has. So,
> >
> > Acked-by: Baoquan He <bhe@redhat.com>
> 
> Thanks Baoquan! I don't believe we have any worries regarding security,
> since the kallsyms data itself is already available to root via
> /proc/kallsyms, and core dumps should already be treated as highly
> sensitive data by anybody handling them.
> 
> Do you know which tree this patch will go through?

I would like to ask Andrew to help check and pick this if no concern.

Thanks
Baoquan

