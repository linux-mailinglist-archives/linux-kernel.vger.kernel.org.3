Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8153052BE73
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbiERPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbiERPVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 727C92655C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652887270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ehACCvrw7UhqaYWryKtTRqeTT9ThoHFc3Uj/+RsDps=;
        b=f+RPEPX0g05Xp8zSBrg97nnARam73C4RLenmlMILPGhvsA9DVAAjM9pIORf0OTExZBt1Gk
        QnCcWG5rPwXSq0KuyaX6iee4ysJaK8DaBswlrN46y+RgsnavutJ6s0CvFxAXExxvVdbPwX
        GqUwHlMHnFpZ5sw4s93MrDm0ulUjgvg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-ThK-0Q9EP52LdzYlHYzTEA-1; Wed, 18 May 2022 11:21:07 -0400
X-MC-Unique: ThK-0Q9EP52LdzYlHYzTEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE9853C11731;
        Wed, 18 May 2022 15:21:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 237EAC28101;
        Wed, 18 May 2022 15:21:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <aa9e13f50be440a192b6acbce422db96@AcuMS.aculab.com>
References: <aa9e13f50be440a192b6acbce422db96@AcuMS.aculab.com> <20220517210230.864239-1-keescook@chromium.org> <2692904.1652861114@warthog.procyon.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com, Kees Cook <keescook@chromium.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] netfs: Use container_of() for offset casting
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2953402.1652887264.1@warthog.procyon.org.uk>
Date:   Wed, 18 May 2022 16:21:04 +0100
Message-ID: <2953403.1652887264@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> Can't you just name the structure so it is:
> 
> 	struct afs_vnode {
>  		struct netfs_i_c_pair {
>  			/* These must be contiguous */
>  			struct inode	vfs_inode;
>  			struct netfs_i_context netfs_ctx;
>  		};
>  		...
>  	};

No.  C won't let you do that (the same thing has to be done in 9p, ceph as
well, and at some point hopefully cifs and nfs too).

David

