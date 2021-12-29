Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502C94811C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 11:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhL2KrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 05:47:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235648AbhL2KrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 05:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640774835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pS/LnwgG4oOy8artqWlQ/l2LSXg4aVMATw77fqG1rBo=;
        b=DUT4rTY8BZRDAYPgStuFtLJTBHSJLuON88qm3CpyHEIGoDQNTDaAHoxQvJnIs8ZfZR/Q8i
        iIfGI0LpdoPhYThgtP7mqATtzg3+G1tOo3PgB1vP2xYNKCGVvF86kgUCKDjd7NFkEUjMgz
        pRiLmJ0KPt6v2vZswT4B7KOKeCH29nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-NQFyXUTUNLOqFBUZD1gySA-1; Wed, 29 Dec 2021 05:47:14 -0500
X-MC-Unique: NQFyXUTUNLOqFBUZD1gySA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C3F6801B25;
        Wed, 29 Dec 2021 10:47:11 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-131.pek2.redhat.com [10.72.12.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5E1A1079F2E;
        Wed, 29 Dec 2021 10:46:58 +0000 (UTC)
Date:   Wed, 29 Dec 2021 18:46:55 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>
Subject: Re: [PATCH v19 02/13] x86/setup: Use parse_crashkernel_high_low() to
 simplify code
Message-ID: <Ycw8n2BvJzH9wJKG@dhcp-128-65.nay.redhat.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-3-thunder.leizhen@huawei.com>
 <Ycs3kpZD/vpoo1AX@zn.tnic>
 <b017a8ea-989b-c251-f5c8-a8a7940877cf@huawei.com>
 <YcwN9Mfwsh/lPbbd@dhcp-128-65.nay.redhat.com>
 <YcwyZRDJUMniSaY9@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcwyZRDJUMniSaY9@zn.tnic>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/21 at 11:03am, Borislav Petkov wrote:
> On Wed, Dec 29, 2021 at 03:27:48PM +0800, Dave Young wrote:
> > So I think you can unify the parse_crashkernel* in x86 first with just
> > one function.  And leave the further improvements to later work. But
> > let's see how Boris think about this.
> 
> Well, I think this all unnecessary work. Why?
> 
> If the goal is to support crashkernel...high,low on arm64, then you
> should simply *copy* the functionality on arm64 and be done with it.
> 
> Unification is done by looking at code which is duplicated across
> architectures and which has been untouched for a while now, i.e., no
> new or arch-specific changes are going to it so a unification can be
> as simple as trivially switching the architectures to call a generic
> function.
> 
> What this does is carve out the "generic" parts and then try not to
> break existing usage.
> 
> Which is a total waste of energy and resources. And it is casting that
> functionality in stone so that when x86 wants to change something there,
> it should do it in a way not to break arm64. And I fail to see the
> advantage of all that. Code sharing ain't it.
> 
> So what it should do is simply copy the necessary code to arm64.
> Unifications can always be done later, when the dust settles.

I think I agree with you about the better way is to doing some
improvements so that arches can logically doing things better.  I can
leave with the way I suggested although it is not the best.  But I think
Leizhen needs a clear direction about how to do it. It is very clear
now.  See how he will handle this. 

> 
> IMNSVHO.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 

