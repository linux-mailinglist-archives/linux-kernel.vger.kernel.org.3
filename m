Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB05A92F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbiIAJRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiIAJQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:16:59 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0673911E836
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:16:58 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id s5so6422474uar.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0DavK3tZEl9/gW1tvRuU8853rjZL9v3RtTzVrdO9jBs=;
        b=CLwtF0ktF1zQqhWHkRI/Q6SDdY2uwAO14CtmVnuN7Kxp130VgBgOurQXRX7jbw3xy9
         VQYPsqq/zKxzf/2dC1DgRpDhp8dN2wpsYL/wxTTOa6L1+3gMbfFjtHQeq+fwNFDT8JvY
         aBaBTk8sfHj8Z8KjpkLyBVjGI7TUrw4GNPLGA+jYcLxyOsozVgOsarJCSCONa3wc/egL
         oqfrhZxgOOCsVWcPhj1zn87ROHjStDGP2r9tuOcYJWJuaLqCqfVr7/Ulgr0oOSRwqzzE
         ebFGHtiHsZaYjqgYlEdNwYTPHFXvCJhpL6GB9IjQzMJe2Um6n6YpL1PYykqUx3rCczZq
         Crbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0DavK3tZEl9/gW1tvRuU8853rjZL9v3RtTzVrdO9jBs=;
        b=h0VNgJoVjjhmAF7TsbGCvjJG6oZTxe4CTubyKwVL0i9BIhLRar3vl+H2i1HwlRrqiP
         552LklcjEQW6BkK38tK8PPh03RJDqfQxl+v5EvtqK+IXK2jLzP0M37WntyIGHyZGPiod
         meEwYgW9BlX1asL1zfoMpbJgfZw70mZjxUTocXmS91+bQaXFe2a7U/aWAa7dIjCEa12a
         anKgV02/4SXvEMOSf02r3Ep8FstCx93dv9Eo85z8pZtRvaOpwwODTO6mU0raOFpcg+go
         r3eKpbXliuXNYNvCsBUI8wIfzlHWsdHeWOFxvYwYccVdrP1R8quPcl3prap14Ck35viS
         KhIQ==
X-Gm-Message-State: ACgBeo1+WLhmgn2fXeGrN3v17rOmzIFeqc373mf32u8pyGpB+bwkc75Z
        69JnWS+uJ3efPtTwXY6ryAoUp+hI2/KSNo1HHrv90w==
X-Google-Smtp-Source: AA6agR4VHP6N0f2EIlgnEiWiCBfG8MZ+FiFFMODbGmcaj/Rm7oimUzkQgxkV0CmdsfvACZ76VkiuzborI4hQ90Pj2YA=
X-Received: by 2002:ab0:70c6:0:b0:39e:ed14:806b with SMTP id
 r6-20020ab070c6000000b0039eed14806bmr8753856ual.82.1662023817019; Thu, 01 Sep
 2022 02:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000043579605e6d0ce41@google.com> <87czcscvlf.wl-tiwai@suse.de>
In-Reply-To: <87czcscvlf.wl-tiwai@suse.de>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 1 Sep 2022 11:16:46 +0200
Message-ID: <CANp29Y6cq0+3SBxQLWvtcsmQ-Pw0RqtEKDUSM2JV1R2no3gOsw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in udl_get_urb_timeout
To:     Takashi Iwai <tiwai@suse.de>
Cc:     syzbot <syzbot+f24934fe125a19d77eae@syzkaller.appspotmail.com>,
        airlied@linux.ie, airlied@redhat.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, sean@poorly.run,
        "'Aleksandr Nogikh' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's tell syzbot about the series

#syz fix: Revert "drm/udl: Kill pending URBs at suspend and disconnect"

On Mon, Aug 22, 2022 at 2:26 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 22 Aug 2022 11:09:31 +0200,
> syzbot wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    5b6a4bf680d6 Add linux-next specific files for 20220818
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=12341a3d080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ead6107a3bbe3c62
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f24934fe125a19d77eae
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12731867080000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165b64f3080000
> >
> > The issue was bisected to:
> >
> > commit e25d5954264d1871ab2792c7ca2298b811462500
> > Author: Takashi Iwai <tiwai@suse.de>
> > Date:   Thu Aug 4 07:58:25 2022 +0000
> >
> >     drm/udl: Kill pending URBs at suspend and disconnect
>
> FYI, the fix including the revert of this commit was already
> submitted, waiting for review & merge:
>   https://lore.kernel.org/r/20220816153655.27526-1-tiwai@suse.de
>
>
> thanks,
>
> Takashi
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/87czcscvlf.wl-tiwai%40suse.de.
