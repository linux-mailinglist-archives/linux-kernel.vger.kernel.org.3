Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9384BA9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245217AbiBQTeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:34:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245214AbiBQTeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:34:01 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1E415D38D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:33:46 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id e17so998434ljk.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/oXewggFOpjaRjDxmMp91h85U911KTGRKHlUJsGGsQ=;
        b=FLYJj+HDXnNK+2/4k1WZ2enZbSNYyOZHY5fHdZ6/uCEhjkTyF6AePplpqyVtXKiacB
         fn8KWnnuFV6Vcr6GX7B0JqPRswxiPTZdc9jlevxWgNX3OoVMFimiSx9dFnoXmHAOGLKY
         T8CZDUUO8aw/RcZNk3m7HhNmK+LErsoJQsLG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/oXewggFOpjaRjDxmMp91h85U911KTGRKHlUJsGGsQ=;
        b=cUdYfQP8gnhkFOyyqwRJfA1WoUS/WHwnMjgGXdSB/IRLTF5wKr0If8MFkAZFEPd0XT
         dDyVhnAKYFZ2Pc/ocFV3S5cO76LnkylfdhilxKD/SnZK+7SVn7v3D6rZ/QeQxyoUTK4o
         ab4wRnJuH5fAkajYt6k7OhODVnXQBvjdphuPFBzuHpj1Ltw+w2t8Uy8/wAI8KKQwFegS
         0FHZ7aZg7AnrfeT5SpKh6IcuKqjh+7JBBSrSUvyJOUWUE5snTeIjujiGi2rBqT+NUD3k
         syspv7mqHox5bs0giVmULkbN0sOKO1erV1vza/yKdCka636Zm6vmrIbuq0Wvw7n+gDc1
         qxLw==
X-Gm-Message-State: AOAM532oOx8+N9tvGTtGRWQMpwmMAs3+Iws8jvm1M5W2HWBoScHdARyP
        oe4msEIfIe+Z0aRBqiC7kLiHZPcJb9AZ6hIJ
X-Google-Smtp-Source: ABdhPJwP7EWeR8pJSmzCGq+n7lh2biYJu6+oGOARMj6+gLHTWAOxja/Sn+cUiyjj8Tvh2Twzn2ktxQ==
X-Received: by 2002:a2e:bd13:0:b0:246:1ff8:6da1 with SMTP id n19-20020a2ebd13000000b002461ff86da1mr858177ljq.219.1645126424859;
        Thu, 17 Feb 2022 11:33:44 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id h23sm61129ljl.126.2022.02.17.11.33.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 11:33:40 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id p22so1199065lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:33:39 -0800 (PST)
X-Received: by 2002:ac2:4d91:0:b0:443:127b:558a with SMTP id
 g17-20020ac24d91000000b00443127b558amr3044488lfe.542.1645126419579; Thu, 17
 Feb 2022 11:33:39 -0800 (PST)
MIME-Version: 1.0
References: <Yg2C2NTphV3eMkUp@bombadil.infradead.org>
In-Reply-To: <Yg2C2NTphV3eMkUp@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Feb 2022 11:33:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjR67HKkrPkmHXYET5M0EVwtrfAFC+AvZPd4obpzvXLLw@mail.gmail.com>
Message-ID: <CAHk-=wjR67HKkrPkmHXYET5M0EVwtrfAFC+AvZPd4obpzvXLLw@mail.gmail.com>
Subject: Re: Modules fixes for v5.17-rc5
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        patches@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, Aaron Tomlin <atomlin@redhat.com>,
        Vimal Agrawal <avimalin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 3:03 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> So far only one fix has trickled through for modules. It is part of this
> pull request. It's a minor build fix for when CONFIG_SYSFS=n. Let me
> know if there are any issues with this.

The only issue I have is that because you didn't put "[GIT PULL]" in
the subject line, the pr-tracker-bot doesn't pick up on it, so you're
not getting a "this has been merged" confirmation email.

My own search criteria for pull requests aren't as strict, so I saw it
in my pending queue. But then I spent time wondering why I didn't see
the pr-tracker-bot response when I pushed out, so I actually prefer
for people to use the stricter rules that the pr-tracker-bot looks
at...

                  Linus
