Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC22588440
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiHBWaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbiHBWaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:30:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E6655089
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 15:29:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b96so9018460edf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nt4PXjotTawRx9pQyNbVwREiDBb+yvN1pKjWnXAYa7E=;
        b=k21vaPYO3PBf3TdXzucVl6smIURDRlEOU1yWSdRwFVWrjJcBTAgBWf972w4noHOmEo
         qtE3zWZbm2PlR93udpDPS8M9t+wcFdGoM8zMjPy0EE84T5Bjb27vx3mD7ZFWLou3j4Xe
         Zb30W+UNrpf8NKpESqvHNp1PIhdrxKsU/hDTF8qVXegJ70IIzkxXh9ArGpU/2TwUW8ii
         vga1Ix8HCEOlcrkPtK9IxK/Iureb/koiSNNJvcrCOSk0W9UzOacgM2WmESksKTlIfP3h
         vxbHt0nW+0jYzn3vPPA9jzyEinKxpZwA26L05BCw888IdYxU+5Abqcl0bJgcIET+liWV
         EiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nt4PXjotTawRx9pQyNbVwREiDBb+yvN1pKjWnXAYa7E=;
        b=IBNIPgIT1Nhp0A91V5yzoid/4oI3DjbKmMFITX04hVvxPd7XU/cvgzTAb3KK0dNM4/
         sahxqKtYYvrl2JQphbb+5ruS3mlCX7+agEsFJbcMz+qh7iHGkUYEUCRKpqJRvLZvwbpv
         JajlZmQtGr2nYIGkK3Wpd3N+Q37+mY0dpECzxAy+BRKT9L313deFuKyex8J7DLVlZr7P
         tm/gbU0Eo77jRgFjGOMKujBhm3cjiYF18AwyTEcnD0yyn0SUo2LO9B5jeEZKM6H1QMyh
         guWuRYgUUlTP6jHxFYcT0zOc5dbzjMjN4wcFH0Q4OTloY8dU47X4e2VkeA3Bfyyz/J08
         eN4A==
X-Gm-Message-State: ACgBeo1VcrlGZ8PXNTwV6Ft4Ba8sqqRVckE8RUJzdFLYpqXGwzmx05Ni
        511DX4FD8xqIekAGOJjOXzjjmtFWHKkBj3su7ilDmw==
X-Google-Smtp-Source: AA6agR7diXu6NWBhqw9P2LB3kLSFApdVDiifLmRG6e6KRnD1E6WkHi9LZBbwS1HdeEB9G+Gpg782c1GCnusBxyRkEFU=
X-Received: by 2002:a05:6402:4385:b0:43d:4820:4532 with SMTP id
 o5-20020a056402438500b0043d48204532mr17896002edc.233.1659479385307; Tue, 02
 Aug 2022 15:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220802212621.420840-1-mairacanal@riseup.net> <20220802212621.420840-4-mairacanal@riseup.net>
In-Reply-To: <20220802212621.420840-4-mairacanal@riseup.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 2 Aug 2022 15:29:33 -0700
Message-ID: <CAGS_qxrbs0K3J5+u3_setrd2NOqE4ADCmuGG-i+5KNoeBb9g6w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kunit: Use KUNIT_EXPECT_MEMEQ macro
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        airlied@linux.ie, daniel@ffwll.ch, davem@davemloft.net,
        kuba@kernel.org, jose.exposito89@gmail.com, javierm@redhat.com,
        andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 2:27 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wro=
te:
>
> Use KUNIT_EXPECT_MEMEQ to compare memory blocks in replacement of the
> KUNIT_EXPECT_EQ macro. Therefor, the statement
>
>     KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);
>
> is replaced by:
>
>     KUNIT_EXPECT_MEMEQ(test, foo, bar, size);
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>

Acked-by: Daniel Latypov <dlatypov@google.com>

I didn't go and find the appropriate commit from the drm tree to base
this on, so I couldn't apply it locally.
But looking at the diff itself, looks good!
