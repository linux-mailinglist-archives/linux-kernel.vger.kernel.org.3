Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D79523CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346397AbiEKShQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346382AbiEKSg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D76C82F021
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652294217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cne9kzq5J+wUhheKNYyc+FraBMO4jJvb9afeixc7QTk=;
        b=fkgbbUq+FXs793SRRGiQ2Ysu3q84ykd5C8pQCptCiO3UwAWJD3zr44Hazaphv/ca0bS7SF
        /CWGOXnNvGk7xnlVZIez3qIPiqzTat4UytSnqunI8DP2reV9+I8L+wj+ObByrJuCV1qPDc
        hKNPcLVF8TtekqID4CHPOE5jh13e5Kw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-7ee-hStvPHual-hKBg3ydQ-1; Wed, 11 May 2022 14:36:51 -0400
X-MC-Unique: 7ee-hStvPHual-hKBg3ydQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5FA0185A794;
        Wed, 11 May 2022 18:36:50 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEF1D40C1421;
        Wed, 11 May 2022 18:36:49 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/vsyscall: Remove CONFIG_LEGACY_VSYSCALL_EMULATE
References: <898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org>
        <202205111104.464A6619@keescook>
Date:   Wed, 11 May 2022 20:36:48 +0200
In-Reply-To: <202205111104.464A6619@keescook> (Kees Cook's message of "Wed, 11
        May 2022 11:04:55 -0700")
Message-ID: <87k0ardigv.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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

* Kees Cook:

> On Wed, May 11, 2022 at 10:38:53AM -0700, Andy Lutomirski wrote:
>> CONFIG_LEGACY_VSYSCALL_EMULATE is, as far as I know, only needed for the
>> combined use of exotic and outdated debugging mechanisms with outdated
>> binaries.  At this point, no one should be using it.  We would like to
>> implement dynamic switching of vsyscalls, but this is much more
>> complicated to support in EMULATE mode than XONLY mode.
>> 
>> So let's force all the distros off of EMULATE mode.  If anyone actually
>> needs it, they can set vsyscall=emulate, and we can then get away with
>> refusing to support newer security models if that option is set.
>> 
>> Cc: x86@kernel.org
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Florian Weimer <fweimer@redhat.com>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>
> Sounds legit! Can we switch the default to "none" while we're at it?

I think that's a userspace ABI break?

I do not have a *very* strong opinion about this.  For one thing, it
would be handy example to have that such deliberate  do actually
happen. 8-)

Thanks,
Florian

