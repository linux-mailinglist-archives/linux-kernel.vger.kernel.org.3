Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141D85A3F8E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 21:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiH1T5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 15:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiH1T5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 15:57:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB13A1A828;
        Sun, 28 Aug 2022 12:57:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l5so2238685pjy.5;
        Sun, 28 Aug 2022 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=q5YGEqsHqMMcpZN0BNxfGiTaBPFWGtrq9H6tvKU0+rg=;
        b=qWPNvHlAyTHlInanJaFYfRFXlZBT+TX2QNsGqPhsPAWtK8/GibUSD68Wl3yVIVDxlY
         aXySwKFePG5czrHvdpU5Ma+6PinN5YWGDeR3IsPCC8BLjlhgWVXCuOPq24QR+tex+Nzb
         yAZZIRJ1tjHq90TTcyBvpVoV0tdq5yOKtk5RLV6rP0gC7n7xZV+3MBi87HnVQvteseDG
         qEYRN4joHw8zkOHHKJJFNlSl2uVvNiAwwktTZE3nNb3K8BzaetNpGHTVpiwKLztndRRA
         WEqOzCcx964y2nhQ9gfhKh55vViKSuuyVWrwpOIFdhxS1QlETRNUMGF40evpwhR24+FO
         cZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=q5YGEqsHqMMcpZN0BNxfGiTaBPFWGtrq9H6tvKU0+rg=;
        b=H5ibzcRJZd646S5uv3Xgrx0UYKJHf7skQfeb6J5KSc3WTTYWq4nNHTOnqU9bILjnn1
         kMqFlqhIYE7i6qN7GbhRNl4UUxOOdUStXmbSzETP/7DrbFfrbEBIQKEAAi3lbaiggwsE
         NCWFzNSgikaDAKk9kfhogL4U7ylp3rM8djetNduvAAAazJb3O+pFvlHHhaukajzimZRF
         ZjIfin7t0kprApn61gHrIczQXSvmE6JKc2zgxZShvph8/08xBSO2qbx3hslgEml1kjkF
         ednk4qklMbrlsVxZ1WGAOPT1nYlKl9lfiEe/OlkCDgTCUsrLf3YJYRtl1yNwJljbSQl6
         F+Zw==
X-Gm-Message-State: ACgBeo1LUKBoJxDdZNjnV5FKyMORKEWnhhUyd0454Jk9+SYnCDlinsV+
        oVOTx/h0KyG6WWsJ42sprPVRBNN9RHftArQe4bQ=
X-Google-Smtp-Source: AA6agR77AELTXWpNgLMwzcB+5fsDDjjG2HmgdsnCscQIx6pKzjsY3QH4HgMJ7ENHSEOQzuuMW8lJS8DUiyPZHCXUfv0=
X-Received: by 2002:a17:902:e5cc:b0:16f:1e31:da6c with SMTP id
 u12-20020a170902e5cc00b0016f1e31da6cmr13394291plf.66.1661716662953; Sun, 28
 Aug 2022 12:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220826083612.1699194-1-floridsleeves@gmail.com> <CAHp75VcdqL4wYnhEi8LrxqJktA2uDzP3a6-08suJRghX=1UZsg@mail.gmail.com>
In-Reply-To: <CAHp75VcdqL4wYnhEi8LrxqJktA2uDzP3a6-08suJRghX=1UZsg@mail.gmail.com>
From:   Li Zhong <floridsleeves@gmail.com>
Date:   Sun, 28 Aug 2022 12:57:32 -0700
Message-ID: <CAMEuxRqBEMdva3qEphvuYkFLpRjp=xg7vpqQT1oqb2AgkkG2+w@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/tty/serial: check the return value of uart_port_check()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
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

On Fri, Aug 26, 2022 at 9:01 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Aug 26, 2022 at 11:38 AM Li Zhong <floridsleeves@gmail.com> wrote:
> >
> > uart_port_check() will return NULL pointer when state->uart_port is
> > NULL. Check the return value before dereference it to avoid
> > null-pointer-dereference error.
>
> Have you taken the locking into consideration?
> If no, please do, if yes, expand your commit message to explain why
> the current locking scheme doesn't prevent an error from happening.
>

The locking is taken into consideration but these three checks do not need to
unlock in error-handling because unlock() will be called in the callers. Will
add the comment in v2 patch.

> --
> With Best Regards,
> Andy Shevchenko
