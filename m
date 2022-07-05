Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E9E567004
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiGENy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiGENyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85AA1D4E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657027944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VnUeyAuXTRR13vDRjc/+AnsnriTCOJeZopadyOQXHsI=;
        b=bN0B/nQTI7l/40/k6IbQ2zUj3Nm3b5DKtuRJt4rYSRpXyjVpcI80iDH57wqv0sh6jj2weE
        Lk2QVR6E9rvJ4TsD1NmaiEtMGJh2R49jHzI8FZir8cvs+dBFDedmDuX+RaCz8BUHsjD3bc
        YeCEj4Yj6wu6c1UMdhyDWpVisqq08LE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-gcAlfXMAPEiIz2jHO1zvjA-1; Tue, 05 Jul 2022 09:32:17 -0400
X-MC-Unique: gcAlfXMAPEiIz2jHO1zvjA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57C01294EDCC;
        Tue,  5 Jul 2022 13:32:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B5022166B26;
        Tue,  5 Jul 2022 13:32:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220704025610.3834-1-zeming@nfschina.com>
References: <20220704025610.3834-1-zeming@nfschina.com>
To:     Li zeming <zeming@nfschina.com>
Cc:     dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@nfschina.com
Subject: Re: [PATCH] keys/keyring: Fix typo in string
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2217585.1657027935.1@warthog.procyon.org.uk>
Date:   Tue, 05 Jul 2022 14:32:15 +0100
Message-ID: <2217586.1657027935@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li zeming <zeming@nfschina.com> wrote:

> -	kenter("{%s,%d},,{%zu/%zu}",
> +	kenter("{%s,%d},{%zu/%zu}",
>  	       key->type->name, key->serial, ctx->count, ctx->buflen);

This changed, so yes, it can be fixed.

> -	kenter("{%d},,%zu", key_serial(keyring), buflen);
> +	kenter("{%d},%zu", key_serial(keyring), buflen);

This one's not a typo.

David

