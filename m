Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FBE514344
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355169AbiD2H2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355131AbiD2H2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9B0496831
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651217120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XuyJmYFKz55Z9M8Cl2OBjrpxRlj1BN0WJexIrt3fWo0=;
        b=Psb1H2yV7eodaWOOWRCaTMa0wYXCcrWxivwcKX5sUMw6SIB0fdHRW3V/1EuK4htakqlEgF
        UkFqDDxu/WzK7LC9F/imE1EtfvOjavZUWE3/okwZe/72JMKx/kBLQLXltM9AHSXc2nH4fv
        qjEeYVpBjdxb++xLOhZuJkf95xJTAXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-bt6FmOATPuK0MAPIlheEJg-1; Fri, 29 Apr 2022 03:25:15 -0400
X-MC-Unique: bt6FmOATPuK0MAPIlheEJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AA8D1014A61;
        Fri, 29 Apr 2022 07:25:15 +0000 (UTC)
Received: from localhost (unknown [10.39.193.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5B4714152FA;
        Fri, 29 Apr 2022 07:25:14 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V3 3/9] virtio: introduce config op to synchronize vring
 callbacks
In-Reply-To: <CACGkMEsrSHtD9iO1qHjMGgwG5YwYVpX+7OKZaN9Oq29tPpGZYg@mail.gmail.com>
Organization: Red Hat GmbH
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-4-jasowang@redhat.com> <87r15hlgel.fsf@redhat.com>
 <CACGkMEsrSHtD9iO1qHjMGgwG5YwYVpX+7OKZaN9Oq29tPpGZYg@mail.gmail.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Fri, 29 Apr 2022 09:25:13 +0200
Message-ID: <87ilqsl5ba.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Thu, Apr 28, 2022 at 5:13 PM Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> On Mon, Apr 25 2022, Jason Wang <jasowang@redhat.com> wrote:
>>
>> > This patch introduces new virtio config op to vring
>> > callbacks. Transport specific method is required to make sure the
>> > write before this function is visible to the vring_interrupt() that is
>>
>> Which kind of writes? I.e., what is the scope?
>
> Any writes before synchronize_cbs(). Is something like the following better?
>
> The function guarantees that all memory operations before it are
> visible to the vring_interrupt() that is called after it.

Maybe "all memory operations on the queue"?

