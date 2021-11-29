Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55E4461776
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbhK2OKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:10:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229922AbhK2OIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638194703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+eWBM8OdR87D6aDyIy/yyec69twxqFJqOvEhii705g=;
        b=TAA42tP+7VZ8IPQcA7ENSVTTov3DzSeQmiRuxJaXceOW1+Elu/4rHDQmMxkZZ+KaUxwSoW
        xMnEXo5Vgdxj2b9Wku2QV9OVnw5MrDo5WCz8xVM97vfwxwxZpLkiiroMLjUSsXnBoIRb0k
        cdGMOArsE2jNzaKm4zGisGGmGObUuhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-585-U2SI67-KOrSC8s63UgX3Dg-1; Mon, 29 Nov 2021 09:05:00 -0500
X-MC-Unique: U2SI67-KOrSC8s63UgX3Dg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8D02343D2;
        Mon, 29 Nov 2021 14:04:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D166B22DE9;
        Mon, 29 Nov 2021 14:04:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A2F1A225EC1; Mon, 29 Nov 2021 09:04:17 -0500 (EST)
Date:   Mon, 29 Nov 2021 09:04:17 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Usama Arif <usama.arif@bytedance.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        fam.zheng@bytedance.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86/purgatory: provide config to disable purgatory
Message-ID: <YaTd4ZID7O+bVRXT@redhat.com>
References: <20211123150508.3397898-1-usama.arif@bytedance.com>
 <YZ0HkaOiKfmgN8zl@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ0HkaOiKfmgN8zl@zn.tnic>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 04:24:01PM +0100, Borislav Petkov wrote:
> On Tue, Nov 23, 2021 at 03:05:08PM +0000, Usama Arif wrote:
> > This can help in reducing boot time if purgatory is not needed
> > as the sha256 digest of kexec segments is no longer calculated
> > or verified if the config is disabled.
> 
> I'd prefer a commit message to say:
> 
> "Disable purgatory because of real-life use case X. With it disabled,
> booting a second kernel is sped up by Y."
> 
> "Just because" and adding yet another config option is not worth the
> effort, otherwise.

Agreed. What's the use case.

Also this cheksum is used to make sure purgatory is not corrupted. So
this is sort of saftey mechanism to make sure things are still the
same as we expected before we start executing this piece of code. Hence
this does not sound like an optional feature to me (even if it speeds
up things a bit).

BTW, how much speed up do you see.

Thanks
Vivek

