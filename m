Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15644E2287
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345448AbiCUIvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344531AbiCUIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:51:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A807C3630B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:50:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h1so16932020edj.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lXXo8Wx8fodr/GuReoIfu4jj3/veJvq5HjguHW4ZOnc=;
        b=ewETv+EDy7d9n1e5VTKD6REo4XEpJS6NIIrwzk5R/fXYDNDs3EWSm50QLtlCHwEEin
         IAyDvHCNDzhXSDf/M86ikfrKxaTDSvjGuVgyuY7K7TQ1ERuV5t3OAXr85jgDXO8DUY0S
         dmIVqQWGbj2EYvSyr4OEj1qW2SEGAj74IbLXmLvy+l6/gCbvG+xJjUEDBBbwjP6/auLa
         lUlBCNg8DfiJX1oL/ngZzLHpXFFvBM5o8vrtZNY+ta5Q9aB48JM9LZmZgJvDIfQDJ6R8
         Y8AQet+rhFtasFWu1yqH23qOk0djWq4pQTi5oCMeyQZk4jh2VLEbOB7NgYBDKykv1Z7U
         IBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lXXo8Wx8fodr/GuReoIfu4jj3/veJvq5HjguHW4ZOnc=;
        b=hAwIZBAdjGmuL8eI+a8SbrnxmJ/tiR2BYkROZLu32iurIdogMJf4XjuA21p2N3dgES
         WvKjjsw6fqa+p2IZb1KQ1b/Q0p5jf/KNDy2hJcw69Yee51lDug0Pfrs8L+HtD1GehURK
         rBVH76GxQAkZ5HQOxqVZhJx1bIHb6HEtligVMlfBzMjXIH1n7jCQdIszB6NiFiSWui3M
         LC1YuzVuISK/5heFPoZQrAggE6SeycKmtiBrh39QbW7lUrZmooYYDi+sYlJ4daJjbgXG
         gsY/vA1HIR5CLC3UqRUaYOAG9HOmgz6THfu8I8kLRYIQD7hy00ogj7w5DIzIM92d1X4Y
         H2dg==
X-Gm-Message-State: AOAM531rv7E/dfxHSFd26A3k4WmRtVklq+JCO2fSyNib4zPd89KXF2K3
        c+Ffryo868yxkJBoU/D4UAs=
X-Google-Smtp-Source: ABdhPJwQDpu+j+bzBry8g7jtpPN/rakRk4dL+pF7kMkegS80etcTYorb0DWQRC3scZ6iV8LbhEatxg==
X-Received: by 2002:a05:6402:5162:b0:419:2d46:c8c3 with SMTP id d2-20020a056402516200b004192d46c8c3mr7176173ede.150.1647852608136;
        Mon, 21 Mar 2022 01:50:08 -0700 (PDT)
Received: from leap.localnet (host-87-20-105-171.retail.telecomitalia.it. [87.20.105.171])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b006d584aaa9c9sm6581968ejd.133.2022.03.21.01.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 01:50:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     syzbot <syzbot+d55757faa9b80590767b@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Cc:     dhowells@redhat.com, christophe.jaillet@wanadoo.fr,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        David Howells <dhowells@redhat.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in __free_pages
Date:   Mon, 21 Mar 2022 09:50:05 +0100
Message-ID: <1905446.yKVeVyVuyW@leap>
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
This way you are doing two test for each iteration of the loop that calls
__free_pages(). One for the index "i" to stay less that an unnecessary=20
high limit, the other for pages[i] being NULL.

However, since you are the Maintainer, yours are the rules :)

Regards,

=46abio M. De Francesco



