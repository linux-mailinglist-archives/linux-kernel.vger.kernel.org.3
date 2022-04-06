Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6370C4F6BEA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiDFVAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiDFVAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 189471C6EE8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649273248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=scxp5+BwL528BisDUZBAca7//7rrtzFe/Mu5lq8LYmA=;
        b=brPlc5BEGJUNG3ngDee4qEa8jBxEPXZVy+T/0CTkDw81VkFRbfcKK3hw9pmP+i9ngAfmbn
        k7q//kI6iTcBygYVYoo1ZOPpqRpPv2BId10MLJxk8LQlxKSNJZypn0sfTzZWEwHM8r4cG9
        CcmwRlPMDSBeramcbfFA0llIymyuGa4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-Iurfq8FHNgKHHKeXZdFWMA-1; Wed, 06 Apr 2022 15:27:24 -0400
X-MC-Unique: Iurfq8FHNgKHHKeXZdFWMA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D53AB1010360;
        Wed,  6 Apr 2022 19:27:10 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 047EC40D1DD;
        Wed,  6 Apr 2022 19:26:59 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?0Jo=?= =?utf-8?B?0L7RgNC10L3QsdC10YDQsyDQnNCw0YDQug==?= 
        <socketpair@gmail.com>, Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Serge Hallyn <serge@hallyn.com>,
        bugzilla-daemon@kernel.org, linux-api@vger.kernel.org
Subject: Re: vfork(2) behavior not consistent with fork(2)
References: <bug-215769-216477@https.bugzilla.kernel.org/>
        <bug-215769-216477-to2O9X1Knw@https.bugzilla.kernel.org/>
        <4fb02f5f-60f9-42af-ddd5-fe5af877231f@gmail.com>
        <20220404080519.pi6izyuop3mmdg2g@wittgenstein>
        <ae2cbf67-aace-bc40-418e-7b41873f814a@gmail.com>
        <20220406084613.3srklyt27qxcmrcx@wittgenstein>
        <f21a06dc-1e2a-87cd-59dc-e8d5245b0a50@gmail.com>
Date:   Wed, 06 Apr 2022 21:26:56 +0200
In-Reply-To: <f21a06dc-1e2a-87cd-59dc-e8d5245b0a50@gmail.com> (Alejandro
        Colomar's message of "Wed, 6 Apr 2022 21:22:13 +0200")
Message-ID: <87k0c2qagv.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Alejandro Colomar:

>> $ sudo ./vfork_newpid
>> vfork_newpid: PID: 8479
>> vfork_newpid: PID 8479 exiting after execve(2): Success
>> print_pid: PID 1 exiting. 
>
>
> I definitely think this is a kernel (or glibc) bug.
> execve(2) is supposed to _never_ return 0 (and errno 0).
> I submitted a new bug to discuss it.
>
> Please see <https://bugzilla.kernel.org/show_bug.cgi?id=215813>

It's not clear if this is valid.  The syscall function in glibc does not
protect the on-stack return address against overwriting, so it can't be
used to call SYS_vfork on x86.

Can you reproduce this with a true inline syscall, or the glibc vfork
function (which protects the return address)?

Thanks,
Florian

