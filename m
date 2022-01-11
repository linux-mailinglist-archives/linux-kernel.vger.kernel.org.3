Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713FD48B39D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbiAKRTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241374AbiAKRSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:18:55 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB95C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:18:55 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so19295542oti.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSjQjtLC4suJhRkrkiJSH4rnohtIE/CzW7Mn1kfxzoE=;
        b=cUECYuHh/VJeyuJ0/a744CaopMnBfSGAlqASxdVYpTZTt7bM3KCVW+ROO8A/RAZ+4k
         Mi+fNIzuoewwrZPgySRy6oGbClEWZGtwx3faBihdVPjJYsR3pJo/w8RTYN9fUwbm7+2i
         BCLgmh+DyR49MuKpHjP6DXGkugdLdkce2oOXBxiuo+9EfrUgXcSKmvc2MVnYIZlZHcxH
         UZo8nPezBKY6Di3h6qVVGcIy6+uADJDSNuZHk+HXbYOao9s6DZDmZC415khu5HzbAf+j
         QEHLIpQgkkG8jI32z0rVqKxFRN1pWQVZTqiLQTjBXGch5M4LUYiGW43yKQh21401vDV1
         QIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSjQjtLC4suJhRkrkiJSH4rnohtIE/CzW7Mn1kfxzoE=;
        b=wCiUqWgAgopu5q1nRcZ4AXCRwSn33uuJQbtPACpnzTY8churNf97r6KEVZtOoT1rqq
         nxoQ5UZZWFZZVBq+4w7IrkNZg4rk0Ib5CC08eX2lmu1vqdIopUrYA3JoynYEOC4mdaf+
         Pecc9EMYedRWmAb6Dlc4uT/x3d/Nq3e6TTdOtEeo6LMIjVxe8KG40HN/lrjqSijEKUPi
         b/4TOhmBUqpdpgfC+ftlCF8pTSqvlTAlPDTZxligSFoHLy9ZgOMdR+HEFhvbLKvcB0zn
         jPTlWrIr8Q2eWP2oVqROLjbhovowNxqsMi1qCMr8KD6Cp5cTobEko+Bw/NRY4wxxfH11
         n85w==
X-Gm-Message-State: AOAM533pualTqDzJuyVqLIsVebfonO0qqYVlELzIwSgDFtrYdYDa3YVb
        eBTFIWXe0JivCLItznHKCSOvOcflYpEQzZdRaNHYYw==
X-Google-Smtp-Source: ABdhPJw5BJtY+ho0foeMU5e44slBULB72ECEuojJA5vSkegkSmRrMjUbDhLOaChV81dQkfmhz7fE8tGJCxcWmbhW0dc=
X-Received: by 2002:a9d:6e85:: with SMTP id a5mr4087804otr.319.1641921534351;
 Tue, 11 Jan 2022 09:18:54 -0800 (PST)
MIME-Version: 1.0
References: <CACDmwr_b0Z6JK2M6i6RZ4Qg3wb1uqG0NrybQ9mR2iw5QJT8XoA@mail.gmail.com>
 <CACT4Y+ZxnG0sLhqn4uw6ueAUsA4cNZJh0_6eES6C45u9jW-4Pw@mail.gmail.com> <CACDmwr8QH-2Kk8DU5zxJ6RLdCho2MzkA9uMJtQ+smoV-qhOq9A@mail.gmail.com>
In-Reply-To: <CACDmwr8QH-2Kk8DU5zxJ6RLdCho2MzkA9uMJtQ+smoV-qhOq9A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Jan 2022 18:18:42 +0100
Message-ID: <CACT4Y+buWoqxZoUgzuYyYt6jP76GbjDoVqA7M07itQVgD60C9w@mail.gmail.com>
Subject: Re: KCSAN: data-race in tick_nohz_stop_tick / tick_sched_timer
To:     Kaia Yadira <hypericumperforatum4444@gmail.com>,
        Hao Sun <sunhao.th@gmail.com>, kvartet <xyru1999@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 at 17:56, Kaia Yadira
<hypericumperforatum4444@gmail.com> wrote:
>
> I'm sorry. They are similar but I can't tell if they are the same bug,
> so I report them individually.

+CC list back

I did not mean that you report similar bugs. I meant that you and
kvartet seem to be following the same process. There are several
complaints about the quality of reports. So I am wondering what you
are doing/why/what's your goal.

Hao Sun, you are CCed on all emails, maybe you can shed some light on this?
