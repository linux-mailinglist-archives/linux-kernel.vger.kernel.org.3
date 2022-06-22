Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EF4554281
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357116AbiFVF6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiFVF6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:58:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B72DFED;
        Tue, 21 Jun 2022 22:58:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z11so16190249edp.9;
        Tue, 21 Jun 2022 22:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrQPBx6DJ+Xxj0xj7UBStUETej8T/UFobX2n416TUmY=;
        b=ncrJhgVi5JCWDFoac18+hfLBzXI+I3Niz3P5/SeGGdxuLUVbPmSZhmfqHlYr1FY5Fe
         la3fxlYuNEv/jq6khgUB5wPzcsxlHhc1ODtwrJfqSjyOglXWA328Q8l0sBjGJoxtwROW
         rxvJrD0ZsGDOuwWj4nAmsBD7uV+L1u3HM3i9/ezT2qLISJrqfeQA2jnJEh1wplrcha8a
         ZuYlb3R7OWqMq/iMArDV/3rGJBvl06+hKY/LyrUDJtbWhkn6U58Uz9+Mfq7FI1erhYg2
         tQkrKERRawTiGOrM0fIUJKxKr4sCySdCSvl0pVR+SDtN7LgmGnbTSPv3b+ULqUgfaRV4
         WfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrQPBx6DJ+Xxj0xj7UBStUETej8T/UFobX2n416TUmY=;
        b=ZCnGE9nBNfLUYy3Qn1cxaX2CXEG6SWqrQcWb2Po1L9doGoQo2ehPhdlj8FOqseT7iY
         I5L7sPMcPTJAzvpoc+3CY7H/UlvVHD6KcpShTwSASWUV124/uyLrssos7MHnEUV4rOwH
         5q1ryEp7r0EIvfyuSKI60aykIhzWQ7DXsBk1dSsLV31+lTOaahbr5sVyUKOO8zHHscSr
         0QSNre498u2a1cEPUU+tniTz2f9NB2u9iC+h8o3yZVOzpeCRP/HiEskiXNfp41HWzLHM
         wCexSKLx6/HT/k8PF9oznRQEY/A3XnD3n4R7AXXnQ5uXvGBrs4cqkCsffyyQtNC8Huqh
         lvGg==
X-Gm-Message-State: AJIora/Mf4EPs6hv/3HIb7jemclCvzc3Q5kZL+p3Ru4b+3JbTRMJ/Gqa
        Z1KLalVnodCEPjRJl9InWfr6i68r+UL5nxXnH70=
X-Google-Smtp-Source: AGRyM1vL+K8GWX7IafwSDJnpr8a78Daj1y4aFy9Dh+liMOknb1OmJAZaUH+yP7UypXQVSyFva/hPYfU9ZjgMeLSa/GA=
X-Received: by 2002:a05:6402:5207:b0:435:a27b:88f7 with SMTP id
 s7-20020a056402520700b00435a27b88f7mr2157612edd.22.1655877487855; Tue, 21 Jun
 2022 22:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220621084238.1235880-1-zhangshida@kylinos.cn> <YrKdZc0fBBDWGjld@magnolia>
In-Reply-To: <YrKdZc0fBBDWGjld@magnolia>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Wed, 22 Jun 2022 13:57:31 +0800
Message-ID: <CANubcdXyM2t0M0Ks3=6Hm12_SVm50vGaTBboj5CBF2LygOkUog@mail.gmail.com>
Subject: Re: [PATCH v3] xfs: add check before calling xfs_mod_fdblocks
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     dchinner@redhat.com, zhangshida <zhangshida@kylinos.cn>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I understand that calling __xfs_ag_resv_init on an AG with a maximally
> sized data structure can result in @hidden_space being zero here, but
> why does that matter enough to change the code?  Are you experiencing
> problems when this happens?  Unnecessary slowdowns at mount time?
> Something else?
>
> This is v3 of a patch and I still can't tell why I should care ...?

After applying this patch, we can avoid to call xfs_mod_fdblocks when
delta equals 0. So we can reduce unnecessary operations here.
