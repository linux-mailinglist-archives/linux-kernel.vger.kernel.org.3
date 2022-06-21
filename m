Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F068C5534A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351821AbiFUOgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiFUOgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:36:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F9024970
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:36:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v1so27901785ejg.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GJLwzs2N2pKacf0ZdpQ3Wu/SeO3mykpG6QqRYLAhfmk=;
        b=N6BE6BxVqA8S6MZ6jXtPrW+5fvbwqzTVoAHhh3M6wcy6Cp3FV3fMh6BLMAvKVNnIfu
         N3CoCOxglGEajhXHoucNcwECSyZ/r+5cwTJu0HYMEaNbYQEZAXIf0ZLUR3VVuqXCKy/M
         +cPfNworLHTQ6NGyNeJOo4OYiEmoloxSMmG7tq/orOseY2bXZvl0/T7T3dv/VDsT6jP5
         TF8L4ho8OddkWkPEJ/HtUuM8JU1NqfqYsQpQdrNW+1GuxdhOSAKbdjT6TtYj82lAIH68
         avk9dDAYHsqPI4Kwg6aZPdtWGSyJDDhDzeVgox8yE0RAvGFjz6ykgpn2s6NlcobiiEBB
         LnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GJLwzs2N2pKacf0ZdpQ3Wu/SeO3mykpG6QqRYLAhfmk=;
        b=KkfyT3ekNPa9g/ETX9MhgfVu8dhbeI2HAwKa2wvGHTE8kUIBPpjJvaCQPzlBDbn+il
         Va2Llqp0/11cHwsiEzizXDqy3RUwe/z8AqyjnFBGwQgnegNNLbj9IEdb1ruKgVEMCciL
         Zyiu4Y5zPCiQVlwETJrllH53N+FR6AjZ6tGT2Ir4kcW185LLssGD6YVDGfGVe/71NL6s
         dQd0Wu4c5zlAIo9aUdpL06yQeJ4giMY+ftbaKWwj4mqKmtJNbu01aAFuJEe36MwJeiMq
         6RTaXAju9TseeacjTCK9+pvAYmY0cLrQ2KkPKgmCqUpb4wUPXkjhxr9nMtHHr/ac1sGq
         VSHA==
X-Gm-Message-State: AJIora+3jKwA/+Ailm8aC90b3Lkf2ESAXD9b76okuzPS5J9NlYpGtFdJ
        tOfGl5JT+uJ90JHANMGRliwIHNGvTkWm0Jo4+AICkoNZebbCfsmh1uw=
X-Google-Smtp-Source: AGRyM1sgOphI4tXDIE/cP6e1t4c0owyLW5pNlViUlFMGQUq41Aw+paKFZiYauH2ZneR1k5TX7rpbx+1VF9WS4NhuzOI=
X-Received: by 2002:a17:906:9b96:b0:711:d21c:1b0b with SMTP id
 dd22-20020a1709069b9600b00711d21c1b0bmr26352742ejc.365.1655822205405; Tue, 21
 Jun 2022 07:36:45 -0700 (PDT)
MIME-Version: 1.0
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 21 Jun 2022 22:36:04 +0800
Message-ID: <CAD-N9QVVKUDFKMSxUc-smcz0B_7PrjN3DPku+cDM3ZKDn0XLBA@mail.gmail.com>
Subject: Unitialized Variable and Null Pointer Dereference bug in gb_bootrom_get_firmware
To:     vireshk@kernel.org, Johan Hovold <johan@kernel.org>,
        elder@kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi maintainers,

I would like to send one bug report.

In gb_bootrom_get_firmware, if the first branch is satisfied, it will
go to queue_work, leading to the dereference of uninitialized const
variable "fw". If the second branch is satisfied, it will go to unlock
with fw as NULL pointer, leading to a NULL Pointer Dereference.

The Fixes commit should be [1], introducing the dereference of "fw" in
the error handling code.

I am not sure how to fix this bug. Any comment on removing the
dereference of fw?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a4293e1d4e6416477976ee3bd248589d3fc4bb19

--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
