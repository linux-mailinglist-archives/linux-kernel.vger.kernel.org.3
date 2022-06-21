Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0A5535CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352659AbiFUPUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352650AbiFUPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4789B1FA70
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655824817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=m/qf6ov0omQZSA34pET1sX3jxVcqup+wfHTRPaQS72Q=;
        b=AxEbiWMzJwT5HusztAkdT3IGQ6SF1LRkaQQ4q8OlqQzBwPrV6NDH/kbbBgR13npAIduP+e
        ePXOW9t9s32Zdv40kxAveLiYbZ4Gh77rs7CZK95Dxd4Pe9ojtMjc+NYO2z/TUWbOHPqS/w
        MXd34Eh3GhVkBJs8EizMli8QZQz9gOY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-cVIuGa09MXOM8jx5kmBEiA-1; Tue, 21 Jun 2022 11:20:12 -0400
X-MC-Unique: cVIuGa09MXOM8jx5kmBEiA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B196C101E9B0;
        Tue, 21 Jun 2022 15:20:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C833492C3B;
        Tue, 21 Jun 2022 15:20:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, simo@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] certs: Make signature verification FIPS compliant
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1276150.1655824809.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 21 Jun 2022 16:20:09 +0100
Message-ID: <1276151.1655824809@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you pull this please?  The signature checking code, as used by module
signing, kexec, etc., is non-FIPS compliant as there is no selftest.  For =
a
kernel to be FIPS-compliant, signature checking would have to be tested
before being used, and the box would need to panic if it's not available
(probably reasonable as simply disabling signature checking would prevent
you from loading any driver modules).

Deal with this by adding a minimal test.

This is split into two patches: the first moves load_certificate_list() to
the same place as the X.509 code to make it more accessible internally; th=
e
second adds a selftest.

David

Link: https://lore.kernel.org/r/165515741424.1554877.9363755381201121213.s=
tgit@warthog.procyon.org.uk/
---
The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f=
3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/certs-20220621

for you to fetch changes up to 3cde3174eb910513d32a9ec8a9b95ea59be833df:

  certs: Add FIPS selftests (2022-06-21 16:05:12 +0100)

----------------------------------------------------------------
Certs changes

----------------------------------------------------------------
David Howells (2):
      certs: Move load_certificate_list() to be with the asymmetric keys c=
ode
      certs: Add FIPS selftests

 certs/Makefile                                     |   4 +-
 certs/blacklist.c                                  |   8 +-
 certs/common.h                                     |   9 -
 certs/system_keyring.c                             |   6 +-
 crypto/asymmetric_keys/Kconfig                     |  10 +
 crypto/asymmetric_keys/Makefile                    |   2 +
 crypto/asymmetric_keys/selftest.c                  | 224 ++++++++++++++++=
+++++
 .../asymmetric_keys/x509_loader.c                  |   8 +-
 crypto/asymmetric_keys/x509_parser.h               |   9 +
 crypto/asymmetric_keys/x509_public_key.c           |   8 +-
 include/keys/asymmetric-type.h                     |   3 +
 11 files changed, 268 insertions(+), 23 deletions(-)
 delete mode 100644 certs/common.h
 create mode 100644 crypto/asymmetric_keys/selftest.c
 rename certs/common.c =3D> crypto/asymmetric_keys/x509_loader.c (87%)

