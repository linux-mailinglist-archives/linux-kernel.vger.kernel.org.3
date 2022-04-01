Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7994EFA08
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351318AbiDASmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbiDASmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:42:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1071C7E91;
        Fri,  1 Apr 2022 11:40:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 17so5030301ljw.8;
        Fri, 01 Apr 2022 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=f9QTXz1EuH1DdnMwB5YeN2+pJyLugzMLcwwY5SWfHN8=;
        b=a2CNDIxpY8XZo7NWrNiqC16TfPB6s9zVnfO/OLDaGCPtxhBDoo2Ra7PPkQ/WTK/0iZ
         zMCAW1dtkuT3gukW1Ln2CG4nKsMJMKJfN8jSHhNphKwktsfk+bgvQXR+A8IRE8pF+msD
         qd/XMc2q9nPGG8ggjGm5n4/Bt3mkW2sZCghcNF3MkkBSK5B8hxVwdarNI22qGxLob5cv
         lubEqGQ/eZGR7ET8r3oTO5GfXX1GSHiw2AlAxlZxMawzdNhf32X85IcftzutQNTClgLu
         tWnX6K7YZHPx/4VtfrMe7SYDGjbJdw7HtpI1SWpjJwoxZNznrLbHSUKDD+V0SX217cZe
         5LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=f9QTXz1EuH1DdnMwB5YeN2+pJyLugzMLcwwY5SWfHN8=;
        b=ho150FMXOYPcxn4YkoQVK+tSNEDnLN10SsaJDk9B8kK9GqC7EcUNCoUJLzOzHTkrv2
         ykN2/A+onBYONXJ/1M0oSpCtASuz7NxHz9UJLVfF+44F1KzyPDSVFJdTo6Up+iGzjH6t
         +O+/U0WxpoM5LxQO+BzEqYcyOCuqMysfAK+I54o11MW1k11J3bAvmLzlTu6GEQghT/Vw
         zcgJKeR0wIc5os0HktxO8mHd5uLKEKuTcmPgbLZbprsqni0OiHvKfkaVGnODH+XfSjtI
         QNM7y+f75uBy0wMFMCwgJSdaCc0LKxEY2a+ETQ0QpMepURDHScx0wcQ9L7kKGGXJ6XY6
         Lbfw==
X-Gm-Message-State: AOAM533q9415xFeeGn5xPGvElsLrBxsUwtSDCSAZ5hMnv4Orm7QlV1V5
        d9RisJamVsxNvNcVuFvppB2xRATspqEkB3sEN4nA2HtyIwy9Nw==
X-Google-Smtp-Source: ABdhPJyqvbYa0NkQtZk6yHxXzSR5UaDzf40sT3NMc/1QLJaxa9AERM9wf8943K7nywX6dsa7bFFcLGdBIDeUQtN2WYo=
X-Received: by 2002:a2e:150d:0:b0:24b:30d:dae with SMTP id s13-20020a2e150d000000b0024b030d0daemr2607868ljd.23.1648838451211;
 Fri, 01 Apr 2022 11:40:51 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 1 Apr 2022 13:40:40 -0500
Message-ID: <CAH2r5mvE6YuhkO0AaPtmzA4V22T_T-bz7ttKbvgtqo0My68Kgg@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
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

Please pull the following changes since commit
ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:

  Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/5.18-rc-ksmbd-server-fixes

for you to fetch changes up to edf5f0548fbb77e20b898460dc25281b0f4d974d:

  ksmbd: replace usage of found with dedicated list iterator variable
(2022-03-30 08:17:55 -0500)

----------------------------------------------------------------
six ksmbd SMB3 server fixes

- three cleanup fixes
- shorten module load warning
- two documentation fixes

Does not include the dentry race related changes which
are being reworked by Namjae.

-- 
Thanks,

Steve
