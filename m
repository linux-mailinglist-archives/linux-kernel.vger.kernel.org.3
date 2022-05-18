Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F4D52B79B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbiERKLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiERKLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DD941D33A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652868707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nTmAGYeo/KWqrKBReXCJ9t3d+BdhVvSDQVlxQc2ZGz4=;
        b=Q8QIVOK1Cso90JCma4qOJkB6mWjYQQxdCdrCC49KbzMyMdQSDCn4c7uprsNUwcL01Z9JYi
        2O7EpUQm4/C5OmxHgvIE+kyW8rFwOz49cVv1UhYnvOAGa/Lgf98efD447fzF41AUlf8UML
        AKEHAtCflln1MEDzXtSVR933ansNsig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410--n_Ee2GzPv6Nx4IpeWbu0g-1; Wed, 18 May 2022 06:11:46 -0400
X-MC-Unique: -n_Ee2GzPv6Nx4IpeWbu0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBC7780B712;
        Wed, 18 May 2022 10:11:45 +0000 (UTC)
Received: from localhost (ovpn-13-59.pek2.redhat.com [10.72.13.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC81E1410DD5;
        Wed, 18 May 2022 10:11:44 +0000 (UTC)
Date:   Wed, 18 May 2022 18:11:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kexec_file: Drop pr_err in weak implementations of
 arch_kexec_apply_relocations[_add]
Message-ID: <YoTGXQvQutAR5PZY@MiWiFi-R3L-srv>
References: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
 <YoNqJ/MOSIVwKP/o@MiWiFi-R3L-srv>
 <1652782155.56t7mah8ib.naveen@linux.ibm.com>
 <8735h8b2f1.fsf@email.froward.int.ebiederm.org>
 <87v8u3o9tk.fsf@mpe.ellerman.id.au>
 <YoSk+jRjNQtUL50d@MiWiFi-R3L-srv>
 <1652864763.xpq371r1wx.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652864763.xpq371r1wx.naveen@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/22 at 02:48pm, Naveen N. Rao wrote:
> Baoquan He wrote:
> > On 05/18/22 at 12:26pm, Michael Ellerman wrote:
> > > 
> > > It seems that recordmcount is not really maintained anymore now that x86
> > > uses objtool?
> > > 
> > > There've been several threads about fixing recordmcount, but none of
> > > them seem to have lead to a solution.
> > > 
> > > These weak symbol vs recordmcount problems have been worked around going
> > > back as far as 2020:
> > 
> > It gives me feeling that llvm or recordmcount should make adjustment,
> > but not innocent kernel code, if there are a lot of places reported.
> > I am curious how llvm or recordmcount dev respond to this.
> 
> As Michael stated, this is not just llvm - binutils has also adopted the
> same and "unused" section symbols are being dropped.
> 
> For recordmcount, there were a few threads and approaches that have been
> tried:
> - https://patchwork.ozlabs.org/project/linuxppc-dev/patch/cd0f6bdfdf1ee096fb2c07e7b38940921b8e9118.1637764848.git.christophe.leroy@csgroup.eu/
> - https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=297434&state=*
> 
> Objtool has picked up a more appropriate fix for this recently, and
> long-term, we would like to move to using objtool for ftrace purposes:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/tools/objtool/elf.c?id=4abff6d48dbcea8200c7ea35ba70c242d128ebf3
> 
> While that is being pursued, we want to unbreak some of the CI and users who
> are hitting this.

I see, thanks for the details. I would persue fix in recordmcount if
possible, while has no objection to fix it in kernel with justification
if have to. Given my limited linking knowledge, leave this to other
expert to decide.

