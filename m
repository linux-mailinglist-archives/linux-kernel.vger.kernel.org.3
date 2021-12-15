Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E784475177
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 04:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbhLODmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 22:42:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239608AbhLODmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 22:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639539754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKPN2S3SXVfn+2YMA0tbS8ft/AvqrEmCxTbCDiXtIYc=;
        b=TbmzACF4p0thLbNOAIXXiEEGsjpT/6Xmaec/jLM/ITkuFwnRZFt/WOjUfpn31eC3Aq0PKt
        k9N56jOy8DByTfCwkiTsQHDWKUAPwTzAOdXMl9kq9JC+HtHamvAIIF/BrRgboVx1CjV+xk
        aFrhP9oRwv8U0JuxwsfPpW8RWhT4KY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-0POoudTmOk2yvbrwSVZmvw-1; Tue, 14 Dec 2021 22:42:31 -0500
X-MC-Unique: 0POoudTmOk2yvbrwSVZmvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEA6C1006AA0;
        Wed, 15 Dec 2021 03:42:28 +0000 (UTC)
Received: from localhost (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED62E752D7;
        Wed, 15 Dec 2021 03:42:21 +0000 (UTC)
Date:   Wed, 15 Dec 2021 11:42:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
Subject: Re: [PATCH v17 02/10] x86: kdump: make the lower bound of crash
 kernel reservation consistent
Message-ID: <20211215034219.GB10336@MiWiFi-R3L-srv>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-3-thunder.leizhen@huawei.com>
 <YbjrjpehprvoRXbV@zn.tnic>
 <YbjvXl51hc6GZa71@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbjvXl51hc6GZa71@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/21 at 07:24pm, Catalin Marinas wrote:
> On Tue, Dec 14, 2021 at 08:07:58PM +0100, Borislav Petkov wrote:
> > On Fri, Dec 10, 2021 at 02:55:25PM +0800, Zhen Lei wrote:
> > > From: Chen Zhou <chenzhou10@huawei.com>
> > > 
> > > The lower bounds of crash kernel reservation and crash kernel low
> > > reservation are different, use the consistent value CRASH_ALIGN.
> > 
> > A big WHY is missing here to explain why the lower bound of the
> > allocation range needs to be 16M and why was 0 wrong?
> 
> I asked the same here:
> 
> https://lore.kernel.org/r/20210224143547.GB28965@arm.com
> 
> IIRC Baoquan said that there is a 1MB reserved for x86 anyway in the
> lower part, so that's equivalent in practice to starting from
> CRASH_ALIGN.

Yeah, even for i386, there's area reserved by BIOS inside low 1M.
Considering the existing alignment CRASH_ALIGN which is 16M, we
definitely have no chance to get memory starting from 0. So starting
from 16M can skip the useless memblock searching, and make the
crashkernel low reservation consisten with crashkernel reservation on
allocation code.

> 
> Anyway, I agree the commit log should describe this.

Yes, totally.

