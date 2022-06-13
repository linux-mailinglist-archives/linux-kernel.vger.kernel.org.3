Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B987854A1DD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343618AbiFMV5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbiFMV5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 225B020BF8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655157417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=D83Efqbr8bQ/N2xRIQQiVrPpXT7X88uP5o56lC1QtDw=;
        b=fIPqWp/v4jrEcSKnjff3H8umI6UZGVK8CSGDZW8SBN5JnxG+APUrhR9r1Qt/SRqYiAT4+4
        zTvv+KtmlkaBdBfkpX0SPFKtgXt0K9RSMksy8h879voizmmuMxbKGBPeDxTESHTDxjmS3f
        7RoJHDaPaZjJ8xEWRKCijTeYoNR6kOE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-BtK2wMyjOzqX5WMSwVWj8w-1; Mon, 13 Jun 2022 17:56:56 -0400
X-MC-Unique: BtK2wMyjOzqX5WMSwVWj8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46AA485A581;
        Mon, 13 Jun 2022 21:56:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02D3A40D282F;
        Mon, 13 Jun 2022 21:56:54 +0000 (UTC)
Subject: [PATCH 0/2] certs: Add FIPS self-test for signature verification
From:   David Howells <dhowells@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Simo Sorce <simo@redhat.com>, dhowells@redhat.com, simo@redhat.com,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jun 2022 22:56:54 +0100
Message-ID: <165515741424.1554877.9363755381201121213.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Herbert,

If you could look over this pair of patches?  The second patch adds a simple
selftest to allow the signature verification code so that it can be FIPS
compliant.  The first moves load_certificate_list() to the asymmetric key code
to make this easier and renames it.

I generated the test data myself, but I'm open to using some standard test
data if you know of some; we don't want too much, however, as it's
incompressible.  Also, it has avoid blacklist checks on the keys it is using,
lest the UEFI blacklist cause the selftest to fail.

The patches can be found on the following branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-fixes

David
---
David Howells (2):
      certs: Move load_certificate_list() to be with the asymmetric keys code
      certs: Add FIPS selftests


 certs/Makefile                           |   4 +-
 certs/blacklist.c                        |   8 +-
 certs/common.c                           |  57 ------
 certs/common.h                           |   9 -
 certs/system_keyring.c                   |   6 +-
 crypto/asymmetric_keys/Kconfig           |  10 +
 crypto/asymmetric_keys/Makefile          |   2 +
 crypto/asymmetric_keys/selftest.c        | 224 +++++++++++++++++++++++
 crypto/asymmetric_keys/x509_loader.c     |  57 ++++++
 crypto/asymmetric_keys/x509_parser.h     |   9 +
 crypto/asymmetric_keys/x509_public_key.c |   8 +-
 include/keys/asymmetric-type.h           |   3 +
 12 files changed, 321 insertions(+), 76 deletions(-)
 delete mode 100644 certs/common.c
 delete mode 100644 certs/common.h
 create mode 100644 crypto/asymmetric_keys/selftest.c
 create mode 100644 crypto/asymmetric_keys/x509_loader.c


