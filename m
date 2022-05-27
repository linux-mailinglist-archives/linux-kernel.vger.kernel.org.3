Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B0A53632D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 15:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352380AbiE0NF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349877AbiE0NFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:05:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF95DBEC
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=pglHjp1be88ovPoKqF2KdA8KHzjD+SK0osh4u3fcrwM=;
        t=1653656747; x=1654866347; b=IX/KTzNroAyX0zjY5oTOIZLXj6279Vt+fsSPgBjHqBqPvUN
        4L0068edISA25tpqUZCPqGSMb1ZcltVT7hGYCXw4o0+kFt21VtMO1/QVGyh6o9aqIYaoeDpl6maLJ
        OS7K1uNvkhh/5DzIGvbLicndzD0cnKVLa/Wkz22lJTzqoy/JSlpECLZ3DoWVozZp+5AdHCAx2vGHT
        z552yp9vQedvPnW3FDIi5t6eih57uxqe3/m285W1H6PQyd/3FjhZe5QfHymaG0TdeMgkeM/U1TuNu
        Z34ASbzlZjiF4BIlsDegnRjb8FzXvC2y4oHWabsIcd9ceYoOyskRMW1d5hOE2KEQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuZeq-00636Z-PL;
        Fri, 27 May 2022 15:05:36 +0200
Message-ID: <e2339dcea553f9121f2d3aad29f7428c2060f25f.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     David Gow <davidgow@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>
Date:   Fri, 27 May 2022 15:05:35 +0200
In-Reply-To: <20220526010111.755166-1-davidgow@google.com>
References: <20220525111756.GA15955@axis.com>
         <20220526010111.755166-1-davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-25 at 18:01 -0700, David Gow wrote:
> From: Patricia Alfonso <trishalfonso@google.com>
>=20
> Make KASAN run on User Mode Linux on x86_64.

FWIW, I just added this to my virtual lab which I use as CI tests, and
it immediately found a use-after-free bug in mac80211!

I did note (this is more for kasan-dev@) that the "freed by" is fairly
much useless when using kfree_rcu(), it might be worthwhile to annotate
that somehow, so the stack trace is recorded by kfree_rcu() already,
rather than just showing the RCU callback used for that.

johannes
