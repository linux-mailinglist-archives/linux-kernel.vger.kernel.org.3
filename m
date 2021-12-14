Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF8A473FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhLNJ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232788AbhLNJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639475846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uVqW4kfKzHvqz/9Z5Fnqw0wfFuiGWxkObzMDPGr6nZk=;
        b=XTigJ51p0TcFpqo2si2vaaDmg8ry6Nl8u1mxuVh2GnHumdu2M0/ABN5k7hHwdxyF490Wuc
        gQHF6ImxP8gGyLFwD/o8/xf+84JYW7f0OeDe0ZS0YzWyLvzPD0ZU+bGAEgpdaRk5jghu2I
        Vx7RcBZjwtH6B0jrUy5CCH2Egi6ipG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-cmfldGxPMEeQ5l3UKgrkcA-1; Tue, 14 Dec 2021 04:57:22 -0500
X-MC-Unique: cmfldGxPMEeQ5l3UKgrkcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72A76190A7A1;
        Tue, 14 Dec 2021 09:57:19 +0000 (UTC)
Received: from localhost (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5660D418E;
        Tue, 14 Dec 2021 09:57:01 +0000 (UTC)
Date:   Tue, 14 Dec 2021 17:56:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20211214095657.GB3023@MiWiFi-R3L-srv>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
 <20211214085440.GA3023@MiWiFi-R3L-srv>
 <YbhmF3+AzvRtGimD@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbhmF3+AzvRtGimD@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/21 at 10:38am, Borislav Petkov wrote:
> On Tue, Dec 14, 2021 at 04:54:40PM +0800, Baoquan He wrote:
> > If you didn't contribute change, Signed-off-by should be taken off.
> 
> The second SOB is correct here. I'll let you figure it out what it
> means.
> 
> Hint: Documentation/process/submitting-patches.rst

Ah, OK, I see the new paragraph from you added in below commit. 

commit 9bf19b78a203b6ed20ed7b5d7222f5ef7a49aed4
Author: Borislav Petkov <bp@alien8.de>
Date:   Thu Dec 17 19:37:56 2020 +0100

    Documentation/submitting-patches: Document the SoB chain

Hi Lei,

I take back the wrong comment on Signed-off-by tag since you post the
patch, please ignore them.

