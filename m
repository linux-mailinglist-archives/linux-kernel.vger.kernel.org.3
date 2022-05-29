Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C435371F5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 19:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiE2R4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiE2R4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 13:56:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1754A4B41A
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=190r9qJwFvNNRiNpmHW+00h4gKYz6/hvhNKsg+u9ISs=;
        t=1653846967; x=1655056567; b=Qh+pyGhcbhypahFSZ4AQHRGN+1NBJQgnJ5F22bdaNDpM3vg
        4FqBHPhQhEzxQN0J95I0DIypPOUPaqUoIHnTycFWc1CXtpKNG7/NSNS32l4f6SB26xuqpFdzm5WXg
        UX/It5AlvYONWRMDyXquo9E7KjJpL3uOIA/GfXAYoXDGSPHG5aFkwgUL6UfAXF+wPCKcq5G7mrLDG
        LekofjD6NzqNYwVEaCnPJWjN6snZmFcRVopNZroO3mcLxwRbpsPOg3JMNABanP+G1dzue5ZLcZa4p
        qKKHgiuvTH/4iMMnW7qlGr8rZUzAEzcldH2qzgcagdBqmgPIqRM740AEK6QwoVaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nvN8w-007nhJ-9k;
        Sun, 29 May 2022 19:55:58 +0200
Message-ID: <b65bd540eae2e593f6d9eb21b6c7d9a06a2809fb.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     David Gow <davidgow@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>, linux-mm@kvack.org
Date:   Sun, 29 May 2022 19:55:57 +0200
In-Reply-To: <de38a6b852d31cbe123d033965dbd9b662d29a76.camel@sipsolutions.net>
References: <20220527185600.1236769-1-davidgow@google.com>
         <20220527185600.1236769-2-davidgow@google.com>
         <de38a6b852d31cbe123d033965dbd9b662d29a76.camel@sipsolutions.net>
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

On Fri, 2022-05-27 at 22:14 +0200, Johannes Berg wrote:
> On Fri, 2022-05-27 at 11:56 -0700, David Gow wrote:
> >=20
> > This is v2 of the KASAN/UML port. It should be ready to go.
>=20
> Nice, thanks a lot! :)
>=20
> > It does benefit significantly from the following patches:
> > - Bugfix for memory corruption, needed for KASAN_STACK support:
> > https://lore.kernel.org/lkml/20220523140403.2361040-1-vincent.whitchurc=
h@axis.com/
>=20
> Btw, oddly enough, I don't seem to actually see this (tried gcc 10.3 and
> 11.3 so far) - is there anything you know about compiler versions
> related to this perhaps? Or clang only?
>=20

I do see it on gcc (Debian 10.2.1-6) 10.2.1 20210110, but that was a
different .config too ... strange.

johannes
