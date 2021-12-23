Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE3E47E20E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbhLWLJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243289AbhLWLJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:09:27 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70ADC061756;
        Thu, 23 Dec 2021 03:09:26 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x15so4115231plg.1;
        Thu, 23 Dec 2021 03:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7cFO1v9x6/4Ywm8Kf5eZrBwl3GzOkxTWrw0nnRZ6CGc=;
        b=dltDk2svmyIXNMXrC4fYUTle02qzW+5hWbGPLGd5KmQ9g+uuDIOTzf+e6Y2PU0B21N
         xUSY3Z9YAApMuS2suJ+SymkgRqK64TIkTWJtSCULWjEh6EHQLIFUdKH8Q7sVpqNRPfIU
         7haICs/f5VSTzNnHXIfG46UvcPRVx2o3wRFbwFXV9KjNfEkPXbvduYhZXTL1DblaXJvG
         z472N16eKtdLSh2VHONFEk/f7UiotgYtRroHWFLJVg41j5mMvJYSQDQFxs5EDJk3gkmm
         DgyU/NIJ8PpdmDlCaG6lbtbAboesohCUs4w6PJzKq9Vq45eaBzEkEiKjeuVZxlUrWO3L
         zeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7cFO1v9x6/4Ywm8Kf5eZrBwl3GzOkxTWrw0nnRZ6CGc=;
        b=u1G+Aq6lMIKdJszH4V02yG2Zt3pfW9iZQRIxl6JuObkCeQjSCpANXx7+8AmkUcLgwc
         PWSW2el4t7pJ0VX4HGiEcFjHX3a2MjaJljxS0KEV01FixOjjpQaRY+2e/jkvHnHfUWnB
         4+iULpYRm4eJW/aWuGUVQwTQa0driZNsNJbiaQOmnDkqFOiW0st3sPa7DdZbLIEvAS/n
         fPsORZfsFUXL7zeMD2JS3nBMckLu4Or4fSpqWs1apYm3K/0in16a0SdcyLyrO0RmAilx
         yQlddnkdxo4mcpWKxLaeF11Cx/lbFNEm2W0M/wP4hKCnm/UhVjs5sJyv6RUuOqiv4VJQ
         7ERA==
X-Gm-Message-State: AOAM532Jc78ApHGUOu/x1ZymbXL7AHVX4cTC+xgBWFAZ+tHh2Fwq+gwM
        s3VyrR637RiSFFO7mtMyfd492cWMz+H5H40m5CqC0jr8K1AMYg==
X-Google-Smtp-Source: ABdhPJyugzYQMQEi85vUCO8HWg9kVcvjqc8EJlkZb9dWo3roqt4XJHGEB930AAh1Se5FguJvMmeS44hLsvt4OGoQSt4=
X-Received: by 2002:a17:902:eaca:b0:148:c78e:3064 with SMTP id
 p10-20020a170902eaca00b00148c78e3064mr1704922pld.53.1640257766338; Thu, 23
 Dec 2021 03:09:26 -0800 (PST)
MIME-Version: 1.0
References: <YcJZWiQ407ZxMM+y@bombadil.infradead.org> <20211222132332.7817-1-vimal.agrawal@sophos.com>
 <YcRRQCMZFepB/hzX@infradead.org>
In-Reply-To: <YcRRQCMZFepB/hzX@infradead.org>
From:   Vimal Agrawal <avimalin@gmail.com>
Date:   Thu, 23 Dec 2021 16:39:15 +0530
Message-ID: <CALkUMdRxTm6STT4CncTuvQ9hM_bez+B91TsuenEj71KPxFgMsg@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/module.c: heuristic enhancement when
 INSTALL_MOD_STRIP= "--strip-unneeded" is used
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Vimal Agrawal <vimal.Agrawal@sophos.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Thu, Dec 23, 2021 at 4:06 PM Christoph Hellwig <hch@infradead.org> wrote=
:
>
> We never build modules with that =D1=91ption, so this is completely point=
less.
>
we use openwrt for build and packaging and it has been using this
option for long.

kbuild documentation says the following for INSTALL_MOD_STRIP:
If this variable is specified, it will cause modules to be stripped
after they are installed. If INSTALL_MOD_STRIP is =E2=80=981=E2=80=99, then=
 the
default option =E2=80=93strip-debug will be used. Otherwise, the
INSTALL_MOD_STRIP value will be used as the option(s) to the strip
command.

So if kbuild does not support INSTALL_MOD_STRIP=3D--strip-unneeded
option then we should call out what it supports and should not even
allow what is not supported. We don't know what other options others
may be using but if we allow it then we should support it and it
should not behave erratic just because someone is using a
non-recommended option.

Vimal

> NAK.
