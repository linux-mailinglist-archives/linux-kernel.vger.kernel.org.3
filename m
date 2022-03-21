Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700F04E225F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbiCUIp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345375AbiCUIp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:45:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A64A27E9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:44:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o10so9567229ejd.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AShlnYcwiAeGsAuBuf83IYOvewXhDfCG9bVJlu6mLFU=;
        b=KOO9fyKybF+k9B+1GOq+vwgf70dWq4tpDKT2WzCf5X+s0r0o2nFP2KAbG8kvzdzp4T
         w2KhNIWuXtnULVoHdlVCa91C+F4wusWQXC5fpWnoJZmI75AyZEWl14pkE3KIxjKwXITy
         4I5MvIZYd+1nQ6gaFXeOqdMvJ5EmpmXcaLplqwtatrpEQscZ0MyS2KQp/UZTR4mII/Jf
         opEcmYjiQ/PryAOKFl6BhmWrtDIDSIk/Ol6WYoR5+hkvnoh9S1JtdbEkuIDiIAdHAHvO
         xEqxArpP0vHhDQMV2c+zL6pTiySgapA+iGxXZ1Ak0pMlDYQjQxm3DClBakAnU1JX3nF8
         a6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AShlnYcwiAeGsAuBuf83IYOvewXhDfCG9bVJlu6mLFU=;
        b=TKjCz83YAIYfNw9KUnYJeH64pNzqFFpEUwLZEWPZc/NYizrScK2zIgOxGm67EbyNyo
         ZIZ41uHaSPOVulUrrvMUERyhmA8V5B8jBdnPT+X+45iX0KkBq4uKKeqIi3bK73VT1dsB
         7ccV41Jy8oI1W3V0wCbdJ5vEbLCCdBUQaFqufT4XygkP2FAKnoNOdGMlY4Y+aBNDZ6Ti
         mo/U5+wHbbYo8G6YHAKfg0+ZuQcaWwiFcWU4GzLXTdX+oS14UQsggLMFUaUAwSAfIeXM
         JENEhg96l+brIsE/VNGBkcvcDuHNFXbvSWcjC88S8RrC9ItnPkNYQ0PJ4YNcpc8HPeyR
         9bEA==
X-Gm-Message-State: AOAM532ew+ZWhjH5/GQyF9luwvs5dWKMUVQOUjWUp8ihFkHGreeBB30x
        0lm+eYkjgMktczakea4uYvk=
X-Google-Smtp-Source: ABdhPJwXv++5alGO5/YqAa4tdqmAFstiL0dU74Da2iCo0rR198Q7Qvte9dmScVyTxR9K6K1CndNZHg==
X-Received: by 2002:a17:907:94d2:b0:6e0:23a4:ddb2 with SMTP id dn18-20020a17090794d200b006e023a4ddb2mr1308024ejc.238.1647852241614;
        Mon, 21 Mar 2022 01:44:01 -0700 (PDT)
Received: from leap.localnet (host-87-20-105-171.retail.telecomitalia.it. [87.20.105.171])
        by smtp.gmail.com with ESMTPSA id qw7-20020a1709066a0700b006dfa04dc2a4sm4747446ejc.56.2022.03.21.01.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 01:44:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     syzbot <syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        David Howells <dhowells@redhat.com>
Cc:     dhowells@redhat.com, christophe.jaillet@wanadoo.fr,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
Date:   Mon, 21 Mar 2022 09:43:58 +0100
Message-ID: <2113719.Icojqenx9y@leap>
In-Reply-To: <970502.1647851062@warthog.procyon.org.uk>
References: <000000000000b1807c05daad8f98@google.com> <970502.1647851062@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 21 marzo 2022 09:24:22 CET David Howells wrote:
> It should be possible to just test for the pointer being NULL in the loop
> before calling __free_pages() since the list was allocated with kcalloc().
>=20
> David
>=20
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-f=
s.git 6d39b096627f0a1eb6e14f049d8ae3c93e0290f2
>=20
> --=20
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/970502.1647851062%40warthog.procyon.org.uk.
>=20
Hello David,

I had already sent a patch for this problem:
https://lore.kernel.org/lkml/20220321014246.19941-1-fmdefrancesco@gmail.com/

However, I see that you ignored mine and preferred yours. I would have appr=
eciated=20
to have your review of my patch or to discuss the pros and cons of yours vs=
=2E my=20
solution and be CC'ed in this thread because I've spent some time on it :)

Best regards,

=46abio M. De Francesco



