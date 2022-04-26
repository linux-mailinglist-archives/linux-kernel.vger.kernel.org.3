Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E741850FC41
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349674AbiDZLxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349670AbiDZLxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:53:32 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3CA9FE6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:50:25 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso65680877b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ryH7A1gT8kJXzD+UMJN/QoxvCXn7WegHnO3tnqAZB5Y=;
        b=tg2Iuq6q3rhNw/DfT5pRxfRIlwx3xHyFGX8ujHI3NZVh5Kl6U3ufsvud3xW0+L/2jW
         42DZA0INTlCQkxIH3aiF+rt7svWYbOw3A0+ANdgUtexhpKaWIA48bS8ZOz8dSQQvvOEF
         yHp5koE2nwg9EhJ+35mF6kaots72Cs0VQyOEuxjt4ebpmliTq4busP3tokMDOL4OlCNi
         knRdUizzAq/W9EYRA4lTxd0PtaujH+5aZRDvtYI1Y1lIAuZwTsIMl7HTHn8P7iyB2Hxq
         upx/aKJHDGS8w1RuSqrzTHhL9OC8OulaUbtD1GAq9puPlZlCFSPj8nEKWW9ze7l9myb1
         vS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ryH7A1gT8kJXzD+UMJN/QoxvCXn7WegHnO3tnqAZB5Y=;
        b=6dV4LysJ4nKfbrw0sUxcWU0JKex5t/Z1MgDyj+s2UJIWjahtwWaPrRwgoggTUW/zJT
         jj6kfwmhKEzzlVqt8cxGYGl9fpNNGh/KMved8BuTsS2uXRreMxfwWza40YBoJyrpkkCN
         GgtWVrNlCSgrC+5He9tu9jE1wKPedZgJbfU6E0oI0DwiaYd13dVk767rT03eHwzLTGsZ
         NupckCms5AceenssfewqTFm8qsar24MkVdHIo2APs4W8EcprEKeyIHUL8r8f41dZoz09
         SXNdBZGrMpLSutSOJHrQUYWDmdB3Xm50uHy5/Hl6JTguSaIlrUDTY6DMFYr6qVZ2qpik
         PaVg==
X-Gm-Message-State: AOAM531MHu5xBhpwJb4Uof57NFEhnmbvrJNunPdf71sZpYkuuVNQ/w+D
        UZpkLBaNZVPg06j/OkslaCXLoHtGzEm49/Yu0flItQ==
X-Google-Smtp-Source: ABdhPJyvU8Hr0BFrDFzYtwgegXf9sk3T6WGuoCfdgQkM6Sz7KGKi+hiNLdv5iJo5uvrFT/1hO9oXBiSayhwwbPyMfnk=
X-Received: by 2002:a81:50c:0:b0:2ef:4c3d:af5a with SMTP id
 12-20020a81050c000000b002ef4c3daf5amr21637045ywf.85.1650973824562; Tue, 26
 Apr 2022 04:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220417111622.621650-1-huobean@gmail.com> <c5f33892dbce61b267cc74dca50e0fae5d1270e9.camel@gmail.com>
In-Reply-To: <c5f33892dbce61b267cc74dca50e0fae5d1270e9.camel@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Apr 2022 13:49:47 +0200
Message-ID: <CAPDyKFpKsRyYosF4p+eEzPRi709-NZG9R5YJ=nDt5mTTnqWd6w@mail.gmail.com>
Subject: Re: [PATCH v2 RESENT] mmc-utils: Add General command CMD56 read support
To:     Bean Huo <huobean@gmail.com>
Cc:     adrian.hunter@intel.com, jakob.rossler@nokia.com,
        Avri.Altman@wdc.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 21:41, Bean Huo <huobean@gmail.com> wrote:
>
> On Sun, 2022-04-17 at 13:16 +0200, Bean Huo wrote:
> > From: Bean Huo <beanhuo@micron.com>
> >
> > We can use GEN_CMD (CMD56) to read a  data block with vendor-specific
> > format and meaning, which is very helpful and useful for customers to
> > analyze device health. This patch is to add support for this command.
> >
> > At the same time, in order to make CMD56 universal, let more users of
> > mmc-utils can benefit from this. We will allow the user to enter
> > [arg]
> > for special commands. Because some eMMC vendors provide an additional
> > set of commands beyond the GEN_CMD (CMD56) definition in the JEDEC
> > specification. These additional commands are implemented using
> > generic
> > CMD56 commands, and they return a wealth of useful information about
> > the
> > state of the NAND device. For these special purposes, the [31:1]stuff
> > bits in the CMD56 argument are used. You can refer to  Micron eMMC
> > "TN-FC-32: e=C2=B7MMC Device Health Report" as an example.
> >
> > I didn't add data parsing, just print the raw data as it is vendor-
> > specific.
> >
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
> > Acked-by: Avri Altman <Avri.Altman@wdc.com>
> > Tested-by: Rossler Jakob (Nokia - DE/Ulm) <jakob.rossler@nokia.com>
> > ---
>
> Hi Ullf,
>
> Would you be willing to merge this patch into your mmc-utils git repo?

Certainly! My apologies for the delay!

Applied to mmc-utils.git master, thanks!

Kind regards
Uffe
