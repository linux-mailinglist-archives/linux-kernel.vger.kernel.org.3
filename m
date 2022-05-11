Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEAA52331B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbiEKM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiEKM2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:28:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08851FD1F7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:28:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w24so2371799edx.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFb+oOKVfdSFM1Ynmw5DXLEBb4aXz2rTDwsxTr/WZTY=;
        b=NMCM6+TD98zvp/GBsWlY0VX5iKuGvLvXshRG/+mChWR+yPtiyUxxkqNbNdNQwQy9GP
         PN3IUiJhfvNF/g3HU9LTgvzYpKgbXg6bGECeapdUNYAeGRYouWfhaasrBhujsqaUi26v
         DkvNhaWJwMwbVG3NJnmWRoCCsPgXwQBw1SwCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFb+oOKVfdSFM1Ynmw5DXLEBb4aXz2rTDwsxTr/WZTY=;
        b=y4IX2b+ekSNBrKDjOKRdijbJZm2FU2pmHJ+AM1XVF7P16Pve4zLpXVDSRuDAytxjO5
         JS27WVun7ASXqRJKEisNreG4xM8W33GwOuwMvV06Ist4Ex37vfSNdFVYO0Fq1YX826jI
         hTzqrcJCGapGK9Hf3IBgXZAG5S9rx6w2RvtxjCRE3T69DS7NcQsbFRod3SbIVJAxxFsW
         tnetg/nVVX+T2Ahwp94pIZMV57RhIGe9PljJ81bwmAoe7f1mEI0fDocotDdiLLadqtqv
         kNM0OiNm9RM8FbIAvbcH0OT3TEmny9ZyhtYo78TmTJOXFFDtTTYvQWof0sABNMkABQpH
         V7Rg==
X-Gm-Message-State: AOAM532F4Kn3vIUpbfUd5kTV4ZmfFHRKkW/iu99Ri9w2zkj7ZOneN09V
        TgsL4xRFdwOfvYWPWI1AAIspBX/HJ7tkKJ7m9wonHw==
X-Google-Smtp-Source: ABdhPJxWwXgnhSYbvRQaaYX1wNi+xzJf+PXffIjqvgi6cI+87AjF12g3Yk81vqxwbS8t9950B4c6Nykxk7whoJ/HDX0=
X-Received: by 2002:aa7:cb18:0:b0:428:af6e:a2a0 with SMTP id
 s24-20020aa7cb18000000b00428af6ea2a0mr10254026edt.154.1652272126351; Wed, 11
 May 2022 05:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220511013057.245827-1-dlunev@chromium.org> <CAJfpegsmyY+D4kK3ov51FLGA=RkyGDKMcYiMo2zBqYuFNs78JQ@mail.gmail.com>
 <CAONX=-dqY64VkqF6cNYvm8t-ad8XRqDhELP9icfPTPD2iLobLA@mail.gmail.com>
 <CAJfpegvUZheWb3eJwVrpBDYzwQH=zQsuq9R8mpcXb3fqzzEdiQ@mail.gmail.com>
 <CAONX=-cxA-tZOSo33WK9iJU61yeDX8Ct_PwOMD=5WXLYTJ-Mjg@mail.gmail.com>
 <CAJfpegsNwsWJC+x8jL6kDzYhENQQ+aUYAV9wkdpQNT-FNMXyAg@mail.gmail.com> <CAONX=-d9nfYpPkbiVcaEsCQT1ZpwAN5ry8BYKBA6YoBvm7tPfg@mail.gmail.com>
In-Reply-To: <CAONX=-d9nfYpPkbiVcaEsCQT1ZpwAN5ry8BYKBA6YoBvm7tPfg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 May 2022 14:28:34 +0200
Message-ID: <CAJfpegtTP==oMm+LhvOkrxkPB973-Y80chbwYpXSiOAXBDhHJw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Prevent re-use of FUSE superblock after force unmount
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 at 13:19, Daniil Lunev <dlunev@chromium.org> wrote:
>
> > At a glance it's a gross hack.   I can think of more than one way in
> > which this could be achieved without adding a new field to struct
> > super_block.
> Can you advise what would be a better way to achieve that?

I think it would be easiest to remove the super block from the
type->fs_supers list.

Thanks,
Miklos
