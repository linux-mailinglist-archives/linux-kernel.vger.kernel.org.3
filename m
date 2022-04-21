Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0942850A915
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352908AbiDUT1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiDUT1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:27:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 433764CD61
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650569079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BdBZV+ngSVw/y0jQuJ/Y/qv5uxEaI2SxYjUeyCoWPW4=;
        b=FxiLloACVjLEMreE+jNM+rd0VMEDwY/vhOAiDm76EdH17FvT8lvTGFkDIYTWFouUMv6AVS
        ippjMH53YSjAOYXk9xdoq+S5PrPAS+FJ7BfE572CfjcU99qnv9Qitefee/bvgIYPxYthsR
        Ty8K8fZJJzqabqo4t8tnH0DVb9aNfMQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-3UT2j4UwNDu5PebA33CSEg-1; Thu, 21 Apr 2022 15:24:38 -0400
X-MC-Unique: 3UT2j4UwNDu5PebA33CSEg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-2d11b6259adso51819117b3.19
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BdBZV+ngSVw/y0jQuJ/Y/qv5uxEaI2SxYjUeyCoWPW4=;
        b=RKYbukz6NXI+MJHW6QT08oJ5m9TVvwWpwlWm4nJdyOatMjPe2ExYqKmZ0e7xGlsEeV
         XeEqMfuYrXnILfg+tlmGsXLoKYrrglkMVBYe32O4Qmz712lqvVWwL2IwFI6rNMx+HG4x
         J2WbXgOfSuCsqAH+AlF5WpsrdWAdzm5hAYuAdmPFrklmFdPuQ3u5Wxzsgr6l3NCC+o7m
         dGKFXAqsvy5HQk3A0FlJdn9Vq2PBGFsa8CP7xmmVyQSykb6o4BlCn09jBLuMUTU0LZsD
         0+1JLlS3tY0kUOVzGZKjQEMhEM8qsp0ZzW9IM9mBkqXtZAcGCZEKpqaPcRzFs9sNkKnY
         7VeA==
X-Gm-Message-State: AOAM530NMuIQwDw2aYsv15zweJ8kWMDlvXd+xuW5hMl7yP7HEE2JqFIG
        ApfrH6OxPAz/ZCVfDXIqQXFfao3+QkLe+ZXhKyo7NjkGEfmBHYqPQCTe09HeZJGrzsv5655V+ZH
        T2FzL0L8lRoalyHAM5dc/TV0OKl28gjSZZoe5FoED
X-Received: by 2002:a05:6902:10c1:b0:63c:d3bf:59d2 with SMTP id w1-20020a05690210c100b0063cd3bf59d2mr1250377ybu.99.1650569077607;
        Thu, 21 Apr 2022 12:24:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOsExuDCha1wbBqR4cfCN2HW1n3Uup6J8yH1jGtZyFHiw4Lnn9caIjuT68hgRMCPfGln/VBTV3TSV70BukNCw=
X-Received: by 2002:a05:6902:10c1:b0:63c:d3bf:59d2 with SMTP id
 w1-20020a05690210c100b0063cd3bf59d2mr1250353ybu.99.1650569077406; Thu, 21 Apr
 2022 12:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220324221156.44813-1-jsavitz@redhat.com>
In-Reply-To: <20220324221156.44813-1-jsavitz@redhat.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Thu, 21 Apr 2022 15:24:21 -0400
Message-ID: <CAL1p7m4drKAz4yocoT7ovhmFC_cGBbAC+jPvsg+exYkwJ72POw@mail.gmail.com>
Subject: Re: [PATCH] Documentation/sysctl: document max_rcu_stall_to_panic
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rob Herring <robh@kernel.org>, Wang Qing <wangqing@vivo.com>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping.

Joel

