Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62284E3C09
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiCVJ5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiCVJ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 332806B0BA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647942953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zhhcRMYX9LNUM6aAbzK3lgaYIv8U2mz0HswiTC5WP/k=;
        b=ALxNJsfu2zpc7nmJ/C9eCwOy1caCFW04qKF4gsU/1VTMTtdLiiJ+c4WNjVVdMNf0AW6+7x
        /G62+1vKbbgmh3llPOHuidAaTbaviGSvTlbv5tM8RywvBAImE89Tqm9B7oA/aNXeyC2HxE
        wJOXiYHpGedv7LV6cKZzaXxj8ILLEEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-2ObtgOlOM1O76mmhlRNukQ-1; Tue, 22 Mar 2022 05:55:50 -0400
X-MC-Unique: 2ObtgOlOM1O76mmhlRNukQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 997F5811E78;
        Tue, 22 Mar 2022 09:55:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C56A04B8D43;
        Tue, 22 Mar 2022 09:55:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wipjbxwH+w-w8QMjPY7f0UFskLOb4smmDRe_7HtyxoHEw@mail.gmail.com>
References: <CAHk-=wipjbxwH+w-w8QMjPY7f0UFskLOb4smmDRe_7HtyxoHEw@mail.gmail.com> <164786764630.1025645.12332376420230352947.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jann Horn <jannh@google.com>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] watch_queue: A couple more fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1201123.1647942948.1@warthog.procyon.org.uk>
Date:   Tue, 22 Mar 2022 09:55:48 +0000
Message-ID: <1201124.1647942948@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> You have the dubious distinction of being the second pull today that
> didn't use a signed tag.

It wasn't my intention to ask you to pull it at this time, but rather put it
up for review.  With hindsight, I should probably have stuck an "RFC" flag on
the cover.

David

