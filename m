Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5045E54C2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbiFOHxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243934AbiFOHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E77841335
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655279618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ts9KtjHONM+dDdUL5NJu/c2bC7PtMeeEFKNh8C3021U=;
        b=VWAPEHM9tFS9VYc/1fZUmRZ52wJMYfbWRYeXikvxywc/QqIuwEqXyWNPMXdI4RAoqaVdx0
        JlXaFLonnuTiCtGQwqq1h+tm8OY8uIqveg6m88TGYFx3KUPQR898PO6mDplIWNkn09a386
        KMC/arCT7swCI12rpxuYQUmAka3ZYdg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-Uo4PnMDGMlWH1ZtjwZ7Vcw-1; Wed, 15 Jun 2022 03:53:33 -0400
X-MC-Unique: Uo4PnMDGMlWH1ZtjwZ7Vcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57209811E75;
        Wed, 15 Jun 2022 07:53:33 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88085C08F22;
        Wed, 15 Jun 2022 07:53:31 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] fs/exec: allow to unshare a time namespace on
 vfork+exec
References: <20220613060723.197407-1-avagin@gmail.com>
        <202206141412.2B0732FF6C@keescook>
Date:   Wed, 15 Jun 2022 09:53:29 +0200
In-Reply-To: <202206141412.2B0732FF6C@keescook> (Kees Cook's message of "Tue,
        14 Jun 2022 14:14:35 -0700")
Message-ID: <874k0mqs5i.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kees Cook:

> On Sun, Jun 12, 2022 at 11:07:22PM -0700, Andrei Vagin wrote:
>> Right now, a new process can't be forked in another time namespace
>> if it shares mm with its parent. It is prohibited, because each time
>> namespace has its own vvar page that is mapped into a process address
>> space.
>> 
>> When a process calls exec, it gets a new mm and so it could be "legal"
>> to switch time namespace in that case. This was not implemented and
>> now if we want to do this, we need to add another clone flag to not
>> break backward compatibility.
>> 
>> We don't have any user requests to switch times on exec except the
>> vfork+exec combination, so there is no reason to add a new clone flag.
>> As for vfork+exec, this should be safe to allow switching timens with
>> the current clone flag. Right now, vfork (CLONE_VFORK | CLONE_VM) fails
>> if a child is forked into another time namespace. With this change,
>> vfork creates a new process in parent's timens, and the following exec
>> does the actual switch to the target time namespace.
>
> This seems like a very special case. None of the other namespaces do
> this, do they?

I think this started with CLONE_NEWPID, which had a similar delayed
effect with unshare: it happens only after fork, not for the current
process image.  I think it's just a limitation of the unshare interface.
Some of the effects simply have to be delayed due to their nature.

Thanks,
Florian

