Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F48854A1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiFMWC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiFMWCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:02:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CEC275E2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:02:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a2so10997821lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSZAOUc7jDHG2RZNVp8mc5S+xeoioWqOft0dihIfjPA=;
        b=A+epGxaCSLgfadqz8qkKfJUDb2SI2zjLi4019IM7FloS0RQWHRPZNxzbLQMJlYHhJA
         LkBd/b2ghI9kdqlzIPw/rCmur9tWA7y/YMZlScR/0Nlp9pqmRRkZZatNtaN10p8rHlbF
         0IZ/D0VHG06/9BtY2soYa+1hqcqKEkSUCfKfbGiVJNlnuZmqnVBTkd/+BHmLx+izwhwg
         ni9fQ6NTHAbZdVEDqVdkkMUQCma7SIQRuvCN1c+Dud2I2Q47kTqmofIP2l1kaGPdzcUq
         ACIR8xR+sp1rf9g5ljwGD+TgYad1/a8trC4+yzcQnQunq+u/Kuqi7NYGg2OaceiEz2pD
         +aFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSZAOUc7jDHG2RZNVp8mc5S+xeoioWqOft0dihIfjPA=;
        b=GTXszBXvFjf96Q/++HGSInXig2sujTc8xjU6q81S1vpzi72xrHnkRnyFbC6fx+8zDb
         qzIFwZNj353C2D+xQicH5EL1eWn7iK3iXPXaTJJkK4/ZLXw5VzX6Z9eAygGIlSFoZOn+
         0tSSVuNgbQ1WWctXVFpVZUwcnVHCtBYl6VkORuQTlZ3Oqj5RXSE4Hnd7A2+mFBHDw/u7
         es/plRt9xqN6nGnyythKFUoXeludZuD6KJs3tlziTy3mYOniBkTdwKstZeueEX/tssR+
         sctnOr/EWny4/H9znCLrPVeD0lRoBsM6VYiruWwlSlM7ysYmaMhmwWK5wl8PEfEPUlxe
         /L1Q==
X-Gm-Message-State: AJIora+wZ7Zco2+VPLpC9oPwdcBQ8uPIxaP3Xjb3gRzF79bAJ/Y/r/ZZ
        fJCMHwc1/TfFr4P7/WGnHhZ0/W1sVgphLaErwtwhvw==
X-Google-Smtp-Source: AGRyM1tGbOk/N5Z0kR13FxIphP5KV5gSzMr3/W2uaDx+YVqR8fYtvcJm57MYyAfnMFouPXDniHgmcveY+sMcdwMrOko=
X-Received: by 2002:ac2:4a69:0:b0:479:7c24:c3e2 with SMTP id
 q9-20020ac24a69000000b004797c24c3e2mr1129822lfp.487.1655157771232; Mon, 13
 Jun 2022 15:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220607191550.4141024-1-blakejones@google.com> <YqZmSRS8UPQJzWFE@krava>
In-Reply-To: <YqZmSRS8UPQJzWFE@krava>
From:   Blake Jones <blakejones@google.com>
Date:   Mon, 13 Jun 2022 15:02:39 -0700
Message-ID: <CAP_z_CgkJ8RgWevJnDiq-+JjB=ni0OzJ3npwW+S9RZ66i0Y3Kg@mail.gmail.com>
Subject: Re: [PATCH RESEND] Add a "-m" option to "perf buildid-list".
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking a look at this!

On Sun, Jun 12, 2022 at 3:18 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> why 'modules' ? it shows all maps (including kernel)
> so perhaps -m/--maps would be better?

 I called it "modules" because it only operates on the kernel. Calling it
"maps" would suggest to me that it might also be able to show
information about the maps in perf.data files, which it can't (just as the
"-k" option only operates on the kernel). Given that, does it still seem
like "maps" would be more appropriate?

> also please state that it's from running kernel

Happy to make this change.

> any reason why not use the dso fields directly?

I was just following my general software engineering instincts to
encapsulate implementation details, so that e.g. the caller doesn't need to
know about details such as the "has_build_id" boolean. I haven't made
changes to perf before, so if that's not the preferred style, I can do it
a different way.

Blake
