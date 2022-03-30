Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0324EC861
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347329AbiC3PjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240341AbiC3PjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B54B547555
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648654641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hHrmC24Jo3CTM6YvkvlpfQVskDBFgAZarL5vBmkT/1w=;
        b=SYP3eyImNIYqbg6XXldrmQyR6yuwTG7KBolUgASrMZicPIX4lGaiDl3sMIgq8UC0d3q2DW
        gqWgRV2gfRBpXQDMWZbBjvSf2+dupE9f6yYzyg2ytuBxcyYnVLjRE/H8SPr8hsctlpn+Oz
        vqiB45MF/gnMk0Wz7kMCb3bB0zfTY0s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-RRlkUzyIPVKePa_Ax9wclg-1; Wed, 30 Mar 2022 11:37:17 -0400
X-MC-Unique: RRlkUzyIPVKePa_Ax9wclg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F8241C0514D;
        Wed, 30 Mar 2022 15:37:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EABD7C202C6;
        Wed, 30 Mar 2022 15:37:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220303125627.93930-1-d.glazkov@omp.ru>
References: <20220303125627.93930-1-d.glazkov@omp.ru> <20220303081428.12979-1-d.glazkov@omp.ru>
To:     Denis Glazkov <d.glazkov@omp.ru>
Cc:     dhowells@redhat.com, "jarkko@kernel.org" <jarkko@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "mkayaalp@linux.vnet.ibm.com" <mkayaalp@linux.vnet.ibm.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] KEYS: fix memory leaks when reading certificate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2996112.1648654634.1@warthog.procyon.org.uk>
Date:   Wed, 30 Mar 2022 16:37:14 +0100
Message-ID: <2996113.1648654634@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Glazkov <d.glazkov@omp.ru> wrote:

> The `exit()` function usage produce possible memory leaks. This
> patch removes the use of the `exit()` function and adds memory
> free in case of a negative scenarios.

?

Barring a kernel bug, there should be no memory leaks from exit().  _exit() is
the ultimate process cleanup tool.  Calling free() won't necessarily return
the memory allocated by malloc() to the kernel.

Unless you have a good reason to actually tear down everything, just print a
message and call exit on error in little helpers like this.

David

