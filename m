Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9C85431F4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbiFHNxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbiFHNxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 170B969B5E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654696380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7jOMT5MVm+EpVaGsHNhjq+T91rwKj6XndTJ8Yfhyhwc=;
        b=WpXNMUxRD9Gj1jcsmnWuQ8nlXMtJWfwk3GhduU/5k6KpXVY/5ca7sqz5OcB65y1Nk95bXL
        v1u76kNAKhuGN1bY9c+FadAHbwzCKFnxA6iExxZP9dxVC5iNUOtjNl1rj/++UxlOVOE2YA
        LsbI7Z3ZBrsZUCzRZXvZ379tmdrQZog=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-p_Sv03klOAK72u4MI27ITQ-1; Wed, 08 Jun 2022 09:52:58 -0400
X-MC-Unique: p_Sv03klOAK72u4MI27ITQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 241FF2949BA1;
        Wed,  8 Jun 2022 13:52:58 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.40.208.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF2334216001;
        Wed,  8 Jun 2022 13:52:56 +0000 (UTC)
Date:   Wed, 8 Jun 2022 15:52:54 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Andrew Davis <afd@ti.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        ldv@strace.io
Subject: Re: [PATCH v2 2/2] tee: remove flags TEE_IOCTL_SHM_MAPPED and
 TEE_IOCTL_SHM_DMA_BUF
Message-ID: <20220608135116.GA27854@asgard.redhat.com>
References: <20220425141617.23925-1-afd@ti.com>
 <20220425141617.23925-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425141617.23925-2-afd@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 09:16:17AM -0500, Andrew Davis wrote:
> These look to be leftover from an early edition of this driver. Userspace
> does not need this information. Checking all users of this that I have
> access to I have verified no one is using them.

This change has broken build of strace's test suite against the latest kernel
headers[1];  the usage prety much shows up in the Debian's code search[2].

[1] https://github.com/strace/strace/runs/6794205205?check_suite_focus=true#step:4:3862
[2] https://codesearch.debian.net/search?q=TEE_IOCTL_SHM_MAPPED+package%3A%5CQstrace%5CE&literal=1

> They leak internal use flags out to userspace. Even more they are not
> correct anymore after a45ea4efa358. Lets drop these flags before
> someone does try to use them for something and they become ABI.

