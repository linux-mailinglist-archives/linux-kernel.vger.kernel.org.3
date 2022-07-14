Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39424575092
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbiGNOQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbiGNOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:16:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECE860508
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:15:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ez10so3626606ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46hVWaCjx73rPro0Xd0FsbKaZ9xICZpeUq+VAvR8QyQ=;
        b=dayB62ziv3PB+cXjd896yXhTbMzBeWEoeAdLOopJX3aq6bp9wJob3XuQM4oRVx2yGj
         jdlGCwzxqZDvf9o82U+NtbRAXzRIyVUgp2vK6xJKyAeuexIcrSOL9GLnmEL0wcjy6dGP
         z0sZ7+MgshUe4Qpfgfl90lQkjMqvZXQNGJH7DbZnKOk5WmbLwLWQKBYBuOMknoSeNtgP
         oE/d09iVnYzbbcxU2QIJb1M2KWdMSo804+bh13oLpCXcphiH9mAEt/WptdLMwzQ039JR
         YjY0pp4AdOzFkixAwItFuqfmT0x4gqOnafg3fJ6uxLzSRiGC4a7P8SiEL6SlVN1kjfAl
         vVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46hVWaCjx73rPro0Xd0FsbKaZ9xICZpeUq+VAvR8QyQ=;
        b=Jo32IN+2euFECWOucY/mez2C/7wXd3KxxAFR15aKjRpCx2S6In4Ex9AcsVf9Gt4NzI
         I2o8GnlTe0d1/NJAOVJfcQBJ0t02Tyd9igzFihzQTCBnuP4FWx7LmkLFahZyUxcHEl0c
         V33AsGZyxgOdQPBIj8RC0ALNybTAQ2ps8g8x+kbt6TI/kmhG+5804BtE2Y/tHWLTNWZ3
         J+QKeIwWxQK16ifV0CJYsxIvI7YOU5lxGm9FdA/yCWBa1rxXnb680bTLrYB2JuFGfSMQ
         6Sct6H0zmJx4h8+Agz7f+RkQZautz8hJT2W6rnpFePCmQ4Ugs4+82CRL2HNyBtiy9GBV
         GQ2A==
X-Gm-Message-State: AJIora+JgyzFW/a5T4/Zyn42zi9byT3TmQGjyGvAzr8yS9p/vmtIgLE2
        gDIGKZSTfBpks9ErAAn1mdmEtYYc0BbDS8vfUGMQ2A==
X-Google-Smtp-Source: AGRyM1sOVFTweX/7D10y5LMAzTNLwKU/QG7AHmo8of6n2sVe7xxZ/1fne0BA6TZNHtaZSDp2y9nlrKyYLq6DA/bXoH4=
X-Received: by 2002:a17:907:720a:b0:72b:549e:305a with SMTP id
 dr10-20020a170907720a00b0072b549e305amr8627280ejc.691.1657808158093; Thu, 14
 Jul 2022 07:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220628024913.1755292-1-tzungbi@kernel.org> <20220628024913.1755292-8-tzungbi@kernel.org>
 <CABXOdTft0Nu_hJQuXwepBXE3tWZf7jaidGE5mamq_=1Zi4hevg@mail.gmail.com> <Ys+QZyOdIT8d1rvW@google.com>
In-Reply-To: <Ys+QZyOdIT8d1rvW@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 14 Jul 2022 07:15:46 -0700
Message-ID: <CABXOdTcb2iMfokJL-rHJ5FkUYTyvjbaqooVXud2pfoE-_fEg9Q@mail.gmail.com>
Subject: Re: [RESEND PATCH 07/11] platform/chrome: cros_ec_proto: return
 -EAGAIN when retries timed out
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, Jul 13, 2022 at 8:41 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Wed, Jul 13, 2022 at 11:18:32AM -0700, Guenter Roeck wrote:
> > On Mon, Jun 27, 2022 at 7:49 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> > >
> > > While EC_COMMS_STATUS_PROCESSING flag is still on after it tries
> > > EC_COMMAND_RETRIES times for sending EC_CMD_GET_COMMS_STATUS,
> > > cros_ec_wait_until_complete() doesn't return an error code.
> > >
> > > Return -EAGAIN in the case instead.
> >
> > Does this make sense, or should it be -ETIMEDOUT ? What does the EC do
> > if it is still busy (stuck ?) with executing a command and it gets
> > another one ?
>
> AFAIK, most existing ECs use single task for host command[1][2].  As a
> result, EC won't reply if it was busying on executing a host command.
> Not sure if it would change after leveraging Zephyr (if enabling multi-core
> support).
>
> EC_CMD_GET_COMMS_STATUS is the only exception.  EC executes the command in
> interrupt context[3].  That's why AP can use EC_CMD_GET_COMMS_STATUS to query
> the status while EC was busying on another host command.
>
> I have no strong preference for the return code but tried to align to another
> timeout case (when cros_ec_xfer_command() returned -EAGAIN for
> EC_COMMAND_RETRIES times).  Do we want to separate the cases: one for -EAGAIN
> and another one for -ETIMEDOUT?

If -EAGAIN is used elsewhere, let's stick with it.

Thanks,
Guenter

>
> [1]: https://crrev.com/4c0ae8814a68f2c2655ebb0b3b80ec4529d07cb3/common/host_command.c#428
> [2]: https://crrev.com/4c0ae8814a68f2c2655ebb0b3b80ec4529d07cb3/board/volteer/ec.tasklist#20
> [3]: https://crrev.com/4c0ae8814a68f2c2655ebb0b3b80ec4529d07cb3/common/host_command.c#176
