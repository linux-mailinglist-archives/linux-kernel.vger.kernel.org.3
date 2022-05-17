Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD25529945
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiEQGGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiEQGG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:06:27 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF2CA1A4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:06:26 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id y22-20020a4acb96000000b0035eb01f5b65so4424183ooq.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=hCNmcVkJkyr6UREPk/U3gfOYerfjOeNt4hoZ5B1uXTk=;
        b=cFZB+U9jeB3yfi38/Mfs3qMy7zVn/f9RjNOyAbXoQybgx9K6PuqkupAoXngkYu6PFP
         Wao2XWHQxMac/ZOyF3nkJyEju6SlwTblxxWs/R4Ga5rJH5cf8UNtsUMEN5nPALJThdfr
         OX40EDmD+6O2WIMQVW8mbnXI4zgwpveJpRNeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=hCNmcVkJkyr6UREPk/U3gfOYerfjOeNt4hoZ5B1uXTk=;
        b=ldrO7o2+nJCqQugL2OSL6I8NWCIm7lIeHl1bMk2r/r6uRh+/WUzqDgpydgZgB7gnCE
         nYhtU57ghi8dz2j471WGFeRaRj09pYp0haZP1LITBxufBxnFMLo4+8S8iKtkseGVdQFo
         ImF4UyHXihwPH7ArOTHK+6QhLAOzKbj4zxKuYMhfNudZxqSw6bRdJxSnOJpgiCHQMBun
         VPL8oClXOC10Tyx0Ki1LLbDQRzIwalD5hsfnA0VD9uF4Ko0jLNcYhW9hvUGCfP2QTOCB
         ID3DK5ycAFOjkGiKDaP3ua/MeaAZMI52l6deuNqj0rAkW+NuKU4tpQxMuv3zWpNDgKWf
         wRcg==
X-Gm-Message-State: AOAM530pDwd380s4k857a17bb8BdZPisO9M/kCNN0CaKdRvjbU3jWrBg
        dNIkwmtjeO537eTKQjUWNqOkYgJWEHdr7dLtp/ShNw==
X-Google-Smtp-Source: ABdhPJz3E5+o8ylS4apeBap5pfY7Cog+dvfGVMjGdgWuyn2+LmRYX7S/Cs7EjYLLIgeMzHEHVEj63CMyFfYwZLWsEsg=
X-Received: by 2002:a4a:6f49:0:b0:35e:1902:1d3b with SMTP id
 i9-20020a4a6f49000000b0035e19021d3bmr7476202oof.1.1652767586267; Mon, 16 May
 2022 23:06:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 May 2022 23:06:25 -0700
MIME-Version: 1.0
In-Reply-To: <4e14f1d5-2abc-8c30-d54d-7e542ca4eccf@linaro.org>
References: <20220412194505.614002-1-swboyd@chromium.org> <YnKvoh+h07at8b65@builder.lan>
 <CAE-0n517iAS9KSdunMX18LpqDrQ4ac-yRCZq82j-XdExaGjCXA@mail.gmail.com>
 <CAE-0n53eXiz74iCHHQaC-eDFkuui9Y1xXvuqd2g0UnrwbYhZTg@mail.gmail.com> <4e14f1d5-2abc-8c30-d54d-7e542ca4eccf@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 16 May 2022 23:06:25 -0700
Message-ID: <CAE-0n526x45m_con53GuZtTzKS8Fx-Gs1Y=uPEHY0ftO_aay_w@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: rpmh: Set wake/sleep state for BCM clks
To:     Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        patches@lists.linux.dev, Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Elder (2022-05-12 08:15:31)
> On 5/11/22 5:04 PM, Stephen Boyd wrote:
> >>> Will you take this in fixes, or do you want me to pick it for 5.19?
> >>>
> >> I'm waiting for Taniya to reply. For all I know this has no effect
> >> because there's some sort of copy/paste from one state to another. Until
> >> then it doesn't seem like we should do anything.
> > Taniya told me that if there's no sleep or wake state set then active
> > state remains even when the subsystem is in sleep. Not exactly
> > copy/paste but at least it is consistent. We need a comment here so this
> > doesn't come up again.
>
> If I understand what you're saying here, your original patch is not
> necessary, but there should be a comment in the code that explains
> why that is the case.  Is that right?  And am I right to assume you
> will be sending out a patch with such a comment?
>

Yes.
