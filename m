Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F47475269
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbhLOGBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:01:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240027AbhLOGBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639548095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73iEIcHZfp/hxpsZzjQwyhoXlM1HDhnt+pSbJnf/ub4=;
        b=GcDkb1o5Mjy16eR0C3ZfgV9fdmrmvi0WpJdzUNIlkzV7Grcxs7UcC4Op9TWfePyBuL3Ear
        kDte8+gd8VucVjGgUi1eM6J8BrsBJU9x9BAkUKmkZY7jZTue5OY6BavcDayddnHQ0H7Xq8
        oY//yUB/PQpzDJ6aenHIGZJ8CefyxsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-33x40GypOAqw-DlPPo-uug-1; Wed, 15 Dec 2021 01:01:31 -0500
X-MC-Unique: 33x40GypOAqw-DlPPo-uug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E6C1801B2A;
        Wed, 15 Dec 2021 06:01:28 +0000 (UTC)
Received: from localhost (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9E3E56339;
        Wed, 15 Dec 2021 06:01:26 +0000 (UTC)
Date:   Wed, 15 Dec 2021 14:01:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
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
        Chen Zhou <dingguo.cz@antgroup.com>
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
Message-ID: <20211215060123.GC10336@MiWiFi-R3L-srv>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
 <20211214085440.GA3023@MiWiFi-R3L-srv>
 <YbhmF3+AzvRtGimD@zn.tnic>
 <20211214095657.GB3023@MiWiFi-R3L-srv>
 <YbipBGn5saLscIMn@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbipBGn5saLscIMn@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/21 at 03:24pm, Borislav Petkov wrote:
> On Tue, Dec 14, 2021 at 05:56:57PM +0800, Baoquan He wrote:
> > Ah, OK, I see the new paragraph from you added in below commit.
> 
> That is supposed to make it absolutely clear and explicit. There are
> other hints as to what a subsequent SOB means in that document already.
> 
> Just the next section says:
> 
> "The Signed-off-by: tag indicates that the signer was involved in the
> development of the patch, or that he/she was in the patch's delivery
> path."
> 
> It wouldn't hurt if people would look at that doc from time to time - we
> end up referring to it on a daily basis.


Thanks, I need read this completely, and often check if anything new
is added.

