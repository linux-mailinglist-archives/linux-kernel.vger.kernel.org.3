Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A914948C4B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353540AbiALNVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:21:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233171AbiALNVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641993670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z7HUhTMlbXY8IkiDpmh6rY91adlsE5cm+HaqeJ7xc6w=;
        b=QcWkJFjifqY4dVVtAs6lT+5WVF1sXZf78xuaJZoR5hAzx3Fh4v8ecT9Hs3mJegQbHX7E6h
        tqsvIaHRa0APrmhhVgJ44q/i4tncEVE2spwHb2FYsiMWbQ1kfe/3Wol+oIxQI+Odmsz9Tf
        p+Z8Yvn2oapZ+R25vGnumRLM6zyZ1jM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-Y_qB0p4OM7WSJbeqWtnHkA-1; Wed, 12 Jan 2022 08:21:07 -0500
X-MC-Unique: Y_qB0p4OM7WSJbeqWtnHkA-1
Received: by mail-wm1-f70.google.com with SMTP id c5-20020a1c3505000000b00345c92c27c6so3684866wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z7HUhTMlbXY8IkiDpmh6rY91adlsE5cm+HaqeJ7xc6w=;
        b=mnZYoGJ8t1udiKSLDWiJjAhgviNXIlm/Ws8JjNxWyQyb+fXvoMoIoMvue6RdKCN0gS
         LeYD2dyBfgPRcpAoZUYEE1UhIYmFsOLQ6BG5ZkdjwDZZ3n7rarJWG7Gx5neDSyUg3K3m
         vCLiHOC22hSg12UNydB2HL9BlcO+wuASHqkzQoFwQLjDz/ZgOkz66RaERaIdpwJ3xShT
         eaGphTcy3VN0l7d5EuwC/nN8rwr4pi7XogyUhpZfF/qc8Ia2X06HuUwt1Kr/WIHrwteG
         cfkSQ+xLmSGcgb3cwgRUO5JHqa2w9rTF7VWq+OOWrMeFc/Od3wQC5CLQ4/IuzMwGCEpI
         DpwQ==
X-Gm-Message-State: AOAM5331YBQJWVknbqBEeO8rYn44xH0efiIQGrfrnizpT8ufHQ/TVOKp
        2YvZ3aBxKpHB0pYY4c11Va1/AkqwxL1PtviEXcB5jE72YrlgF/0hHisG7/xKsPoawSCuOl3nVv1
        IDglIJK7O1hULaeak5u7IOxc=
X-Received: by 2002:adf:8b50:: with SMTP id v16mr5647091wra.44.1641993666417;
        Wed, 12 Jan 2022 05:21:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwanSxI4qVidY2mX5BJOgQL83lB5Nh6uTW/AYob5zmC0ZddXVW3+Lc7mz+ajohYj/ntkM3eCg==
X-Received: by 2002:adf:8b50:: with SMTP id v16mr5647071wra.44.1641993666212;
        Wed, 12 Jan 2022 05:21:06 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o38sm5271904wms.11.2022.01.12.05.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 05:21:05 -0800 (PST)
Date:   Wed, 12 Jan 2022 13:21:04 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Allen <allen.lkml@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com
Subject: Re: [RFC PATCH v2 00/13] module: core code clean up
Message-ID: <20220112132104.7emyelwuv3jmmhdt@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220106234319.2067842-1-atomlin@redhat.com>
 <CAOMdWSJHm9bRAcrB6U+FsRiK6Fg2bbtbUH82w54VD7kbFmnVsA@mail.gmail.com>
 <CAOMdWS+Sn1sZJt8ocig5U7d7qG3N8oJBW-D1ey0qbZ3AXF-JWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOMdWS+Sn1sZJt8ocig5U7d7qG3N8oJBW-D1ey0qbZ3AXF-JWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-01-11 17:16 -0800, Allen wrote:
> Hi Aaron,

Hi Allen,

>   Was the code compile tested?

Not entirely i.e. not the whole of kernel/module/Makefile, unfortunately.
Furthermore, only x86-64 was compiled tested. At the moment, I felt the
need to share the concept/or approach thus far to simply obtain some
overall feedback before further modifications.

>   Unfortunately, I could not apply the series cleanly on top of the
> latest 5.17-rc1.

Sorry about that: this work was based on Linus' commit 81361b837a34 ("Merge
tag 'kbuild-v5.14' of
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.").

>   I did rebase the patches and fixed minor compile time failures as
> well a few small checkpatch errors.
>   I have pushed the series to
> https://github.com/allenpais/Linux/commits/refactor_module_v3
>   [The series now is based on
>    84bfcc0b6994 2022-01-11 Merge tag 'integrity-v5.17' of
> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity]

Thanks for that. I'll have a look shortly to incorporate into RFC PATCH v3.

>   So far I could only manage to compile test the patches. Will test it
> on BM(x86/arm) in a day or two.

Much appreciated.


Kind regards,

-- 
Aaron Tomlin

