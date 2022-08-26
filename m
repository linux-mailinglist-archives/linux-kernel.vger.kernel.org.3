Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E1B5A2BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344634AbiHZPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344562AbiHZPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:54:29 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D8D076E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:54:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id w13so1743187pgq.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=K3Xwfjtqcy08Dh4Uowyc7RheG//QPqDKPMV3mjxAE+A=;
        b=eJpog3UOd1kK1ruRtiGy9VSitgjWRSf/ss3vCIDaJmaVA5Ncev2d30+JIg7f65OjpD
         WALY4zVMYTBt4XMWuBijgrXn/lRdUbeH0spbUeZXrpzrH54F/r6ECXrEEYXYfCfKbrDv
         MfwWpWGRMvbr4Y9QuJe7E1awB12ssyxRf9M8bSsTTKYan0phk3lhhIgMjXdV7T1cREnn
         +ZMMx74LpVrbuo8KxsQKqRo8CjDILzaKZZopufGeapzQtVIWPEZ9y333UQo95XxgP8uT
         Y+4Gk0PtoIdbGuExq90ZmwTbUZ1TtDbA4WI2cl66rZTRZylHkez2VZ90M7flX4IzY3Lx
         Xw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=K3Xwfjtqcy08Dh4Uowyc7RheG//QPqDKPMV3mjxAE+A=;
        b=jNxWSSvk4Xt38t1Pmzb0lwSdqGIRd4AkXkB4clv/Ly/j6pmVVvUq2UM3gWKf4yKEw6
         WuJtpA+46QK2xLD7zrQTPuGCa5OYTki9h0z62D1vk/TTQferLwiYm/DOeHlRgoc4xo32
         9RPRu+/1i5LUckVI6vt83vU4vFL09Vyg+5SotkNeiKrBY4u/GQNl2Wt80vVGawnqgawz
         1ZfHYvFXMnmvd5s6QJlSj6uLe889980jb+fI21cPMZUE9ZTUlK0VIEnvYzjY+gXwF7c0
         Ugv7p9YUOWFsnxC6CB8mEEf0rO0YvPrQqOWQbcPjlVV/dbn3COk8JOVzi1rSHDSJD4em
         STsg==
X-Gm-Message-State: ACgBeo2gEX5d4xSs1xNkCLmKpzno5Y6rlYaJboAw7k9vbOKFat7UHA+S
        zG7kSQq7OMw0O2E6fntbPQ0=
X-Google-Smtp-Source: AA6agR5hFRNNmooUkl8v4ORBlsY6PUV3mY8lhREwZSxyQddlRDCXYJvn1Qo2MkKBnHIbIo8ziEpxqg==
X-Received: by 2002:a63:6ac3:0:b0:41d:17dc:eb66 with SMTP id f186-20020a636ac3000000b0041d17dceb66mr3658382pgc.384.1661529268056;
        Fri, 26 Aug 2022 08:54:28 -0700 (PDT)
Received: from localhost ([36.112.195.70])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902ec8e00b0016be527753bsm1772906plg.264.2022.08.26.08.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 08:54:27 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     yin31149@gmail.com
Cc:     akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ntfs: change check order in ntfs_attr_find
Date:   Fri, 26 Aug 2022 23:54:05 +0800
Message-Id: <20220826155405.7506-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826154231.6634-1-yin31149@gmail.com>
References: <20220826154231.6634-1-yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 at 23:49, Hawkins Jiawei <yin31149@gmail.com> wrote:
>
> >
> > Btw, this was in the original code, but those casts are ugly.  Ideally
> > there would be some way to get rid of them.  But otherwise at least
> > put a space after the u8.  "(u8 *)a < (u8 *)ctx->mrec".
> >
> > >               u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> > >                              a->name_length * sizeof(ntfschar);
> > > -             if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> > > -                 name_end > mrec_end)
> > > +             if (name_end > mrec_end)
> > >                       break;
> >
> > regards,
> > dan carpenter
> So maybe I can try to refactor these codes. But I wonder if this can be
> done in a seperate bug
Sorry for the typing error. I mean refactoring these code
in another seperate patch seems better.
