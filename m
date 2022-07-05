Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2DE566FD9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiGENuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiGENt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F34DC2FE56
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657027287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IU1hmx/6CablWOPeTIIqi3YqGNsqAV5xUAc3aVqmUGg=;
        b=G4SIq8KKzdy+sq7Fikhd2d6RNG46DjX4ejRk1qsWaU6vFGCVKCQjgAl9hwk47TiRVCngah
        Tccfkhpg0RbAz7q7loNU/oW9MiSED0Lc4gOL3SlQKVGxDuGEJT19zKFjSeQt2DtoR8uEfB
        JRmSgq0PQJtUheJaBCQ48xzfT5HWSpQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77--JCJQmBOMB2CUtYwGYxzUw-1; Tue, 05 Jul 2022 09:21:26 -0400
X-MC-Unique: -JCJQmBOMB2CUtYwGYxzUw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0964F811E7A;
        Tue,  5 Jul 2022 13:21:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCF03416390;
        Tue,  5 Jul 2022 13:21:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <30a4bd0e19626f5fb30f19f0ae70fba2debb361a.camel@kernel.org>
References: <30a4bd0e19626f5fb30f19f0ae70fba2debb361a.camel@kernel.org> <20220701022947.10716-1-xiubli@redhat.com> <20220701022947.10716-2-xiubli@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, xiubli@redhat.com, idryomov@gmail.com,
        vshankar@redhat.com, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, willy@infradead.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com
Subject: Re: [PATCH 1/2] netfs: release the folio lock and put the folio before retrying
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2187945.1657027284.1@warthog.procyon.org.uk>
Date:   Tue, 05 Jul 2022 14:21:24 +0100
Message-ID: <2187946.1657027284@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> I don't know here... I think it might be better to just expect that when
> this function returns an error that the folio has already been unlocked.
> Doing it this way will mean that you will lock and unlock the folio a
> second time for no reason.

I seem to remember there was some reason you wanted the folio unlocking and
putting.  I guess you need to drop the ref to flush it.

Would it make sense for ->check_write_begin() to be passed a "struct folio
**folio" rather than "struct folio *folio" and then the filesystem can clear
*folio if it disposes of the page?

David

