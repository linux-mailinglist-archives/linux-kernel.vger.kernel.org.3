Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF605220E2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347182AbiEJQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbiEJQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45864517FC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652199404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KVzPa/CpMbrLak9Ttn+hwPBIcEYZnOC0Ik+6YZOOMwE=;
        b=FSgVv+5RWccw/ezgDGUu3hr9ldjoYXAxJ9YQf6EUjssBWW/Dfw9Z5xiThG624ciOcGyaIc
        oOdVNUUk4vtFrDLoUsc0H83+hzFSOQvHG/6+8KTpczrXLbEMmDCENd9Orif8J5+wrFcB0r
        iohWfOZgios6FqfZTR+ifpLXbiDi7so=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-IcrtxMnWMdyoGhLeHHCyNw-1; Tue, 10 May 2022 12:16:43 -0400
X-MC-Unique: IcrtxMnWMdyoGhLeHHCyNw-1
Received: by mail-wm1-f72.google.com with SMTP id m186-20020a1c26c3000000b003943e12185dso5458786wmm.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVzPa/CpMbrLak9Ttn+hwPBIcEYZnOC0Ik+6YZOOMwE=;
        b=fYaPNRBoYgUPiw4VbfnHlzatxswk9bHOburlxJu9En6SjjvEYYQEEx83Ccd14eHbw6
         qPTSZpfpy7ICJmJgXKcnKrQIZ3hnbm3JuPQZw2GzstIsieV8q2Ht5wDkMVMpt5htDt4D
         M3gzScOsQIfFS0Z3mBzonxVWVaedvsNJ9nAgliChIgYYsj+jK6bun6bL7zG4ug86kmFJ
         60rl0qO3MSFm+g32PfmklDbeirb7eEz25hmBX+HIX+ekLWu2ZKcmOrr3R8kd13EPF4Ok
         J7+txWmO5F9LC2pL0YWhsfKg6UBtA28InTS0Fs8WxjKlzbg2gYNJdLcGenN2X4Uyf+I2
         eMhw==
X-Gm-Message-State: AOAM530mDohA/riGXqUQ5bZBaPqMEVxcpiLolU7bJfPuubtj9axyFs6U
        eX2URflqxXZtdjnuw5O+MH5tGrP4aKHuosASeOfbEYqnR8thn2db2Tcqo94Ex+bW1LjUu6kKqH8
        Y/um2UG/BIoQ/9Jl3mAOodGeL2LiBf3PH/2Thw6JW
X-Received: by 2002:a5d:5547:0:b0:20c:7a44:d8e7 with SMTP id g7-20020a5d5547000000b0020c7a44d8e7mr19631572wrw.349.1652199401966;
        Tue, 10 May 2022 09:16:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDB7CHCX//1BDK27DcKh4uB1maI9l/Yz+/1MPCRVN3bchRD2R7xPAgn4zma5TWUgVosDoprwxWUYpGT9gU6g0=
X-Received: by 2002:a5d:5547:0:b0:20c:7a44:d8e7 with SMTP id
 g7-20020a5d5547000000b0020c7a44d8e7mr19631556wrw.349.1652199401831; Tue, 10
 May 2022 09:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220508100630.2642320-1-keescook@chromium.org>
 <YnoQmuPgK9c5V8ZC@infradead.org> <CAHc6FU5VfS9yNe0yH_sfOt04rvii6T_NMq7kp+32HZa5XQDtEA@mail.gmail.com>
 <202205100851.663310B@keescook>
In-Reply-To: <202205100851.663310B@keescook>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 10 May 2022 18:16:30 +0200
Message-ID: <CAHc6FU4hRBHUJOCF33z=dzOJszYCpiZ=wikdyXZ1u25hGQ00ng@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Use container_of() for gfs2_glock(aspace)
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bob Peterson <rpeterso@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Bill Wendling <morbo@google.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees,

On Tue, May 10, 2022 at 5:51 PM Kees Cook <keescook@chromium.org> wrote:
> Thanks! So I should leave this with you to arrange, or should I send an
> updated patch?

are you happy with this?

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?id=833ab609b94f6

Thanks,
Andreas

