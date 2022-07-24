Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ECF57F2C5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 05:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbiGXDpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 23:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiGXDpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 23:45:39 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8A1EE06;
        Sat, 23 Jul 2022 20:45:38 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h145so6392705iof.9;
        Sat, 23 Jul 2022 20:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urdOpy9asLw3Y6MlWSHoFWdbz6150EOdUC7TdYBaBuE=;
        b=LsldSwyvy+YhsmguyJks6+5wlPrp4WItiFSfIL1Vjp+D33iw4UekGa9I/D+fSLB4VG
         j7jPHJWrjbxipCBmPxShuRBFINBE24/iMBsIIoA/aMLAPPpNjasZJu3rrVMdIfmqQ6L8
         ZY5llKN3UaNPFBeyfnQsPIgcvNlI81fippMTadgMZfNySakXYqLrIxGKvK6WJqcemNoJ
         Cv8vJx6gqiyrZQGVvoL2Bo4jyRbF9l77M0ODMLcGu4lUhYKu5CnRgutqt3bkYpG0kwTx
         Ed6NoKFDzuim6Lu4/f2/fAQM16/I0181UQy/0NdSi74OmhhB0K/DzZx2V/DvHtD9ohCQ
         jcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urdOpy9asLw3Y6MlWSHoFWdbz6150EOdUC7TdYBaBuE=;
        b=mqBQfX+ccdDAHQC1X5SqQWk7ZyTme0Fus2OMk8YGnukKxm2XqO4q+CI9JPdac1ZUB5
         A59aoTsD18U7U9w4Qxfw7/X8Kt9G4j3rGWakt3ANSZLaI0cXq92/tjK2aVXOD5+ehGrA
         KiCpfg7xYFewiZWrt4hJICDG+gvuLOuwulbnIeSbi8CqN+cOSq25Q/FJSOwOkmeXIICa
         MERFxgchX3iexxmYmR4AV+O27dFmozLsZq3RqL0CCviw+O6aBNCU0nZmSKEa/P/vmbPc
         JUZH0Vp/o4k1Tb0Ht/EYZEEz6dnlAlIxc5FqPySMEoM3PoaOSxpM3kE1WOW0Avz8YX6b
         ooGg==
X-Gm-Message-State: AJIora/TAjMIjDXqAR+/ggO3D8ptbW1GIq+NmmJHhZzf86ZQUVmhxyhd
        zZnxhemWJ95Oqln2948qZQaDBgmG2Hq1Juers4o=
X-Google-Smtp-Source: AGRyM1v7iy25GYE3XYGsRD0mZ/puTi9gGiZl52cB3A4p9UEHjE5y8TJgmOjaRPS9Y/yajSX0p3Tsex8/S1SqQWLXJAI=
X-Received: by 2002:a05:6638:16cb:b0:33f:8871:1b5c with SMTP id
 g11-20020a05663816cb00b0033f88711b5cmr2717685jat.11.1658634338052; Sat, 23
 Jul 2022 20:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220723135447.199557-1-code@siddh.me> <Ytv/tUrdK1ZTn4Uk@kroah.com>
 <1822b76775c.69c52873236056.4849193904753307696@siddh.me>
In-Reply-To: <1822b76775c.69c52873236056.4849193904753307696@siddh.me>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Sun, 24 Jul 2022 09:45:27 +0600
Message-ID: <CAABMjtEHCy=YcfqYfsQdqt9pWHHRoOLYHiRCsj8HjZVfAOB+6A@mail.gmail.com>
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing watch_queue
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 8:29 PM Siddh Raman Pant via
Linux-kernel-mentees <linux-kernel-mentees@lists.linuxfoundation.org>
wrote:
>
> On Sat, 23 Jul 2022 19:33:33 +0530  Greg KH <gregkh@linuxfoundation.org> wrote:
> > You should not use #ifdef in .c files, it's unmaintainable over time.
> >
> > thanks,
> >
> > greg k-h
> >
>
> I used it because it is used in the same way in fs/pipe.c too (please check the
> stated line number).
>
> That, in turn, is because `watch_queue` member in the `pipe_inode_info` struct
> is defined that way (see line 80 of include/linux/pipe_fs_i.h), so I am forced
> to use the ifdef guard.
>
Maybe, we can use the IS_ENABLED macro here to avoid ifdef in the .c file as
suggested here:
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#conditional-compilation

if(IS_ENABLED(CONFIG_WATCH_QUEUE)){
     ...
}

> Thanks,
> Siddh

Thanks,
  -- Khalid Masum
