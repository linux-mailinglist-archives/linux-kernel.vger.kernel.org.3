Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71710470FE3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 02:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345581AbhLKBgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 20:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345576AbhLKBgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 20:36:41 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62709C061714
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 17:33:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r11so34508383edd.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 17:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igz7mhddA6SiLDrTxK7BBgnsMQANYZ9nkpc2VVEuP/Y=;
        b=R4DuHb77tzI2CNOtFViwBCj+4QGHu6zxAqu6R6Gl8zxHH8I9rM+opDDDGeMMSuLC2s
         KYJggWuCEonKlrSJqJlTkLPtil9MBgHbVFh2BhXj2cC05FOWXrorpnVd4Hnemz4jhSia
         ntQ53cEFi2Vge1N0b5RlxRnNasS9Ry7qahHs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igz7mhddA6SiLDrTxK7BBgnsMQANYZ9nkpc2VVEuP/Y=;
        b=TFhrLSpPEDojY1rNWIuJxtOz8k6DdwO65WLT8kWLgV2upQdHkrCdeGCP33psySTrmf
         Lq4CBmkR4vlCnCSEDyspnViwpFU7eChTjgG+toDjxzeI0LC808vUYPPiNpcs6idFHpvd
         2t9oBjoPtF6oejtw9AFMnRP3iy3tKSWVmc059LhgzFuyflk1FprcE+oRPnN7MpxXF0nP
         jmQiNATJIOIHLvIZCQr1fwVUalc4BGwFN2/4vOj1TABlb+Kk9uY47c4zS5zTHS0TF+Nw
         CH3XuCZaAdcXnKh57QO8VH5h3q50HrTLubIU8/tWb7jGUOM3eYUWASSDZeZttXCzyjDl
         RG/w==
X-Gm-Message-State: AOAM533L8VdB36Nk1vhowyDm3FueMncwhCVJ74xv9Bs+/dMj6K69a8yM
        kEKPdqp2bQnDUkMrKILRANo9h4XbhK5jPo7KBEE=
X-Google-Smtp-Source: ABdhPJwRyZkgF7QHZU/FHx/lF9vyk1ltmBd5mm0TKpnJaqNFRAp0wRms5pTKsbrbg6X3jyUmsPvZtA==
X-Received: by 2002:a05:6402:354c:: with SMTP id f12mr45092216edd.256.1639186383426;
        Fri, 10 Dec 2021 17:33:03 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id ig1sm2174153ejc.77.2021.12.10.17.33.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 17:33:02 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id q3so17723734wru.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 17:33:02 -0800 (PST)
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr17925618wrj.274.1639186381813;
 Fri, 10 Dec 2021 17:33:01 -0800 (PST)
MIME-Version: 1.0
References: <20211210053743.GA36420@xsang-OptiPlex-9020> <CAHk-=wgxd2DqzM3PAsFmzJDHFggxg7ODTQxfJoGCRDbjgMm8nA@mail.gmail.com>
 <CAG48ez1pnatAB095dnbrn9LbuQe4+ENwh-WEW36pM40ozhpruw@mail.gmail.com>
 <CAHk-=wg1uxUTmdEYgTcxWGQ-s6vb_V_Jux+Z+qwoAcVGkCTDYA@mail.gmail.com> <CAHk-=wh5iFv1MOx6r8zyGYkYGfgfxqcPSrUDwfuOCdis+VR+BQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh5iFv1MOx6r8zyGYkYGfgfxqcPSrUDwfuOCdis+VR+BQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 17:32:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4Cqs=2ZrJ0r-0ansaarD9wt88d73XVVQ4H12XwHgofg@mail.gmail.com>
Message-ID: <CAHk-=wj4Cqs=2ZrJ0r-0ansaarD9wt88d73XVVQ4H12XwHgofg@mail.gmail.com>
Subject: Re: [fget] 054aa8d439: will-it-scale.per_thread_ops -5.7% regression
To:     Jann Horn <jannh@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 1:59 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This is an ENTIRELY UNTESTED patch to do that.

Oh, and I guess it's somewhat tested now. I've been running that patch
for the last couple of hours, and it seems to work fine.

Not that I actually stressed it in any particular way, but at least it
doesn't cause any obvious problems. So it's probably fine.

Famous last words.

              Linus
