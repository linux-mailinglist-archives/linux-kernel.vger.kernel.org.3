Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC04E4985
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbiCVXKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiCVXJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:09:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D9B5EDCC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:08:27 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id t5so35249pfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacecubics-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVuJ5iTMnLNg6p4o6FYZzWHkDiNOVLzOVLvxqh6C8Y4=;
        b=LlXGZhX0rVNs3cNb3DAGu9aomSpRR2vuW7l7DcvmvZVZMKPgeUSI7WxeyGGKf6V3+v
         4q2Az1q/1o1sFKWPwC4qHAM9UwHxP2ZpGa6kjxB5e3YcEH44psttcBZgtOom+aa3qDEx
         QnAZWL9FNaQesELzuft1OW9ZoJ751IRQKRFK4Qy+kjZW++9xQtx40OXaEmhXpsdTydaQ
         ocKEYwgkVDMMCTvNJuUiCOU5mlr3HCkzjtg2zjkQZTxeun8p2VdGNx25frevoEfsn4vu
         9XwWyaqB6PWKQXO1V+JwKP0ZDzdW9ZTkSCE9brkxKKJA92CRiaVv/8LumBs2EmSGk5qQ
         iIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVuJ5iTMnLNg6p4o6FYZzWHkDiNOVLzOVLvxqh6C8Y4=;
        b=zXxp0BgxuMZCvvoRyklR7JntHEJPMvl1irEeJj+ntHDnjEoXKg0A/xTqsE1S/xYoif
         rlrE15ykLYeaA6DgHtkACO3t/ROXdJfoyWEb/V4hF9cII/aqo3RKWEPncBm2kIdzan6j
         zgoD4zG7msDogmlTZkABeas6N+YotjSD+YepDe87MEzZCrnn8Ek4WFOJnWBAade4IC4Y
         qJRcrZdTwdXeo5ILPKtN2vBz+Lbpuu0UVH9gEW8p9Tx35IAk+VCn5Zp8aZpr3zmAPdAW
         iv8tXEup7vLJqDsVU9RqWecuX7EEKjBPrShpknbZpPA6Hfrb6R/79tjnLP5SWMYJzDac
         kZGQ==
X-Gm-Message-State: AOAM532oly4XmMskYzXsnMl36Hx+ZONZQX9T2sQnBRu1pHQqieJSE5/i
        tpj7s8fFn0F3Pw5jeFjYStWQSsY6703VH4FsQCPrUw==
X-Google-Smtp-Source: ABdhPJytcKyVVLZRHTvS/Y/aI+XgKcwjXvUtr6xRy6GO8nXN6NBbyX6AuEi+Tpd6Lc9sF9z5bKeJWcwSkPju1XRiW6Y=
X-Received: by 2002:a05:6a02:19c:b0:385:f2a0:2b38 with SMTP id
 bj28-20020a056a02019c00b00385f2a02b38mr3263566pgb.286.1647990507325; Tue, 22
 Mar 2022 16:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220311080208.45047-1-hbh25y@gmail.com>
In-Reply-To: <20220311080208.45047-1-hbh25y@gmail.com>
From:   Yasushi SHOJI <yashi@spacecubics.com>
Date:   Wed, 23 Mar 2022 08:08:16 +0900
Message-ID: <CAGLTpnK=4Gd8S488osvrbttkMvtsPy8eCGspV4-=z2N3UGZ5rw@mail.gmail.com>
Subject: Re: [PATCH] can: mcba_usb: fix possible double dev_kfree_skb in mcba_usb_start_xmit
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        stefan.maetje@esd.eu, Pavel Skripkin <paskripkin@gmail.com>,
        remigiusz.kollataj@mobica.com,
        linux-can <linux-can@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hangyu,

On Fri, Mar 11, 2022 at 5:02 PM Hangyu Hua <hbh25y@gmail.com> wrote:
>
> There is no need to call dev_kfree_skb when usb_submit_urb fails beacause
> can_put_echo_skb deletes original skb and can_free_echo_skb deletes the cloned
> skb.

So, it's more like, "we don't need to call dev_kfree_skb() after
can_put_echo_skb()
because can_put_echo_skb() consumes the given skb.".  It seems it doesn't depend
on the condition of usb_submit_urb().  Plus, we don't see the "cloned
skb" at the
call site.

Would you mind adding a comment on can_put_echo_skb(), in a separate patch,
saying the fact that it consumes the skb?

ems_usb.c, gs_usb.c and possibly some others seem to call
dev_kfree_skb() as well.
Are they affected?

Best,
-- 
           yashi
