Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071C45836DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiG1C13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiG1C10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:27:26 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E040731348;
        Wed, 27 Jul 2022 19:27:25 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id k129so430034vsk.2;
        Wed, 27 Jul 2022 19:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZFlsUJOaADCOjobBXWN+Ry6rplJfP66zaPfTmczUmE=;
        b=XT6C+CtssjABaCZvXmadnHkws66JxdUFWFpS9Ci/f99W/0HcTl0nVrjqUaQ/YOahZH
         viPF0LtQxBhvgUqVpWoGic3U+usnS04aUEqxsPFCjRnHrc/cBYegoHrnzGTRimb17peB
         L9F0+7FeuS4ihTtFTP5sUuwy/WlWwvxHto457qIscz3b7xbIV/hqYbzS6vhdtjkmkWy2
         ca3KxotxpYdewZFlhWWK7vTKkYcIBS23UzQSurFIsw1i4IbDtcBLU+AfjoGHEjaTNtNG
         Hz8/uPV1Pf5JOXr/jZdCH3baRG2duH7NOEI3lVq6JdU+GFCNjegDLhpcLMtJRXqyKJNI
         c8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZFlsUJOaADCOjobBXWN+Ry6rplJfP66zaPfTmczUmE=;
        b=2WljqwR/vB/yBrRZO4eSCGahAyPAvn6cCQ+4Z6o6asRoWSoS+bOxrwspm2XVP6Ggmg
         NkeBboOXBNeteIQS11fhkL3Bfh6kC4Q847mFiIaks/Y4Mwfwepu8SdtTsl86D0cgjPV5
         V7r0jmV2wvKJIB4gQkInHg53M6/kIFodcHmjsf5jN8yCg1vE2kR20sZlq9jEuuil7exp
         67pedricdopkdSUDdxAB8/pMqqvY13/F/jiVJuAnK4U/VvopiuMInNkl0FOd/vTO7535
         2vNWzSCX/2pqRZPJKcVnciDW2qWmeh3O+f8NRu2UTsWSuagkyKWCz98ZX6iHMJX97c3s
         mYlQ==
X-Gm-Message-State: AJIora9ah8t/B7rgvnLId2ue7fqzFeIU1HQ8I7dkvDCF3SM3rXxiIoDt
        Zd00E/Ve2wBqcH3gjMSLryWo8hjUzcJ14g+fB5i3YJPA
X-Google-Smtp-Source: AGRyM1svemPRfB9LuqoREtDBGyHsaC9y38k6KATXp0QjoGbrPCj2bOAvpTi7rIqC+53WbHRV2PqRFuwflXEdY9VzgAk=
X-Received: by 2002:a67:ef07:0:b0:358:611e:9105 with SMTP id
 j7-20020a67ef07000000b00358611e9105mr5084670vsr.61.1658975244833; Wed, 27 Jul
 2022 19:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjSBvRk-ksUBOiQzJd=e19UZKvOSZs1UHahK5U0QVh6RQ@mail.gmail.com>
 <fda96c5c-9007-4147-3be1-8c9deca0442c@gmail.com>
In-Reply-To: <fda96c5c-9007-4147-3be1-8c9deca0442c@gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 27 Jul 2022 21:27:13 -0500
Message-ID: <CAH2r5ms+uCF-sC1Hw6izmMhCb2jR55jB0pf8rK8OkkUh0hNGfg@mail.gmail.com>
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
To:     Clemens Leu <clemens.leu@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Davyd McColl <davydm@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        regressions@lists.linux.dev,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is using userspace tools (like Samba's "ftp like" smbclient tool) an
option to migrate these files?

On Wed, Jul 27, 2022 at 3:04 PM Clemens Leu <clemens.leu@gmail.com> wrote:
>
> Hi all
>
> Here follows now another practical reason why it is at the moment a
> quite unhappy decision to ditch the NTLM/CIFS 1.0 support entirely.
>
> I am on Kubuntu 20.04 LTS and the access to my Apple Time Capsule worked
> fine. This changed when kernel 5.15.0-41-generic was installed some time
> ago. Since then I have in dmesg the known "kernel: bad security option:
> ntlm" and "kernel: CIFS: VFS: bad security option: ntlm" messages and no
> access is possible any longer to the Time Capsule.
>
> So it looks that commit "[76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c]
> cifs: remove support for NTLM and weaker authentication algorithms" has
> completely broken my Time Capsule access.
>
> Yes, I know, ntlm is more than 20 years old and a quite insecure
> protocol. It is absolutely understandable to disable it as default.
> However, it should be also regarded that there exist companies which
> decided because of narrow-minded reasons to implement only the old SMB1
> protocol also on not so old hardware. Apple is such an example, they
> really implemented on all of their Time Capsule models (which were using
> a special Samba implementation) only the stone-age variant of SMB/NTLM.
> This is true even for the last 2013 variant which was discontinued on
> April 26, 2018. Apple could for sure support a more recent SMB version
> but they didn't do it most likely to make their own AFP3 protocol look
> and perform better.
>
> So the alternative would be AFP in my case, unfortunately it's not so
> easy. While we have thanks to Netatalk a rock-solid AFP support in Linux
> at the server side, this is unfortunately not true for the client one.
> The corresponding "afpfs-ng" (Apple Filing Protocol Library, a client
> implementation of the Apple Filing Protocol) project is unmaintained and
> dormant for years.
>
> Long story short, the current situation in this topic is as I said quite
> unhappy. While I fully agree to disable NTLM/CIFS 1.0 as default, it
> shouldn't be removed entirely. Maybe it is possible to enable it only
> for accessing older network volumes/shares while on the same time block
> the possibility to create insecure NTLM network shares? I am aware that
> the risk in enabling this old and flawed protocol will be my own
> problem. I won't complain if I get into trouble because of it. ;-)
> Unfortunately I have no alternative other than buying a new NAS or
> downgrading to an older kernel which is also not a really practical option.
>
> Whatever, many thanks for all your great work!
>


-- 
Thanks,

Steve
