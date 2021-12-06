Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F1746A5C2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348531AbhLFTje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345592AbhLFTjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:39:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85470C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 11:36:03 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z5so47892420edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 11:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1WZbGUI2jgxA10QTAICPwSg3f480L4ADSnktyOVLe2k=;
        b=GngTKpgvPeiX/nUFKS+/vZnjYQHy0JwjnyeBTrCSICMt+OObJuz/ZY47Ab5zOCNTZk
         UNj/aJtmFS+GluXZPxqGJ5qZbuC7A0P8k3vbJ11Oz2fUgr7DYKTirs+rbaAUrk8ZURxu
         zErFOsaHNkR15LzUr0E7qwxHEJNdkLaKcmwSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1WZbGUI2jgxA10QTAICPwSg3f480L4ADSnktyOVLe2k=;
        b=knHFy9n4kXZi/509uMMX1m471eC5UuSrMZzhdLZhyFeypKbTxmKmoLkANAztvQxWT0
         rKdf8LtCLlnUvb2WYev5ZaDZVWIkeZUOaoF35AJ4XUnLNF2c++IW304F1RTp1AiwCOMK
         c3RE10D3hnPkeogrP96G4DKturVYuZAEwYynjB5y4ULkkiiZ3wpSZ3QZz04WJkZjndGz
         zuv4LiXDE56EDc7VSgtAX3TuuGhZneIlhTtduLQ90HVmOIN8/ZMuQs2WkkXGH7rHT8Vp
         tvd7jnlIXvu1nNBcOnTj7uWQ3hwVf6+AKyP5RVwF5rUzgwQBedbov8+KBvQ+lhbfu5eo
         uJHQ==
X-Gm-Message-State: AOAM531CmyUWrv2/NiN/NaXup6wJ+RlIzcWC714H8PiSvS8WKPlXIbTp
        FwYsf3awWcUn1BHQRHV+s1Rfsz1aKFu9aQpU
X-Google-Smtp-Source: ABdhPJxU8TJGexsrpFoBTIHn7sjoXhu+d8bfOIhcJeLQQ7nRubQ0ySUbQ/ZMo9ffNbaOE0/RG0sB5w==
X-Received: by 2002:a50:d543:: with SMTP id f3mr1677970edj.56.1638819361834;
        Mon, 06 Dec 2021 11:36:01 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id t20sm8425559edv.81.2021.12.06.11.36.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 11:36:01 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id d24so24797099wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 11:36:01 -0800 (PST)
X-Received: by 2002:adf:9d88:: with SMTP id p8mr47263440wre.140.1638819360971;
 Mon, 06 Dec 2021 11:36:00 -0800 (PST)
MIME-Version: 1.0
References: <87y24x39wi.fsf@meer.lwn.net> <874k7l35t5.fsf@meer.lwn.net>
In-Reply-To: <874k7l35t5.fsf@meer.lwn.net>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Mon, 6 Dec 2021 11:35:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjPc=K6J39Gw7TasXd0QWthG7WFHxZPGofYteJYmyx+yg@mail.gmail.com>
Message-ID: <CAHk-=wjPc=K6J39Gw7TasXd0QWthG7WFHxZPGofYteJYmyx+yg@mail.gmail.com>
Subject: Re: [GIT PULL] Documentation fixes for 5.16
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 11:13 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Somehow I managed to not CC the usual lists on this one, so, for the
> record...

.. and now that it was sent quoted (instead of re-sending the original
email), pr-tracker-bot doesn't recognize it as a pull request any more
and doesn't react to it.

So no pr-tracker-bot replies for you.

Only this manual one.

             Linus
