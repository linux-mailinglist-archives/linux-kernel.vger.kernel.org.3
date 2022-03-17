Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD7D4DCCE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbiCQRs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbiCQRsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35F4E1F6F1E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647539215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TSju7HUI+LaKZ4xnPb9CmLb83y1fN66XS6ap4ycu7PM=;
        b=YoCreiM/SvWC0zZGivWcLzn0qXX7or5cn9N6DIJgSo3dd650XawCLLGajYEcuuf9zt0Iyg
        XOBLDPupoZBMAqZxjR0CMRjwX8QABqECK+R+VvkZRsUDhGKctso39/h++ldOhVcp+CbmvJ
        pDslwsGSfIQx109tvPEU/OQ+xq3mxWg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-2CRTTnGSPaKpBp8b3QXeBA-1; Thu, 17 Mar 2022 13:46:53 -0400
X-MC-Unique: 2CRTTnGSPaKpBp8b3QXeBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2AFE1066694;
        Thu, 17 Mar 2022 17:46:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id B7A3E2D479;
        Thu, 17 Mar 2022 17:46:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 17 Mar 2022 18:46:52 +0100 (CET)
Date:   Thu, 17 Mar 2022 18:46:49 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] ptrace: Move setting/clearing ptrace_message into
 ptrace_stop
Message-ID: <20220317174648.GA13318@redhat.com>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
 <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
 <87bky67qfv.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bky67qfv.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15, Eric W. Biederman wrote:
>
> there are places
> that set ptrace_message and don't clear it, and places that never set
> it.

Yes, I too never understood this.

So I obviously like this change. The only problem (as usual) is that we
can never know if something depends on this old (and strange) behaviour.

Acked-by: Oleg Nesterov <oleg@redhat.com>

