Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3520E5A3602
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 10:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiH0IjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiH0Iir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:38:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074CBBCCE2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 01:38:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso4063869pjj.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 01:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6Y6hFlNXcZOip0wjL6FhF+cSQiBFASafnzpWHIHr/no=;
        b=gAZidD2Kt1H3/Zka1xLWsciEycxHZLTe8svmM6J+rxxnbA5FEYFw0/NjfW7KxhNEhK
         bBXysBBIGIQhdzbALC4nWGi9JkSY33caxFSAIu/QBZz8+2S1MsPT5VmnJunEvWAuf2le
         PVVQJT7Cw/obSTu3YXUW7nOFaWQsh6wcyMaVmitVeg938W+WacE0M9PMunTJ3GNBWamR
         9EMraENdgs65uW6zVQBnoCvkAEJc/zCPT4z5tm+82Hb0f5QzP8eaSPfRiIcAj/Mo/PdN
         sh6yWdxT1nNyIpe74ESl/fjdS9PcyAbTME0C5jmGM6Mn5Q0u6yoaSdYwVK5udCmwKhFb
         HCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6Y6hFlNXcZOip0wjL6FhF+cSQiBFASafnzpWHIHr/no=;
        b=Ei5NlAX0Bjs5p9sMAtTpk0S0PUzAqqMo/08Orh0RmcsjCd60CWuoN/LlXTLczwo1rW
         fHBhan7eUOITBbev9jvbm4NBRep+xAorUcrSOX0YxbE36UOCPFRVqBluwlNAauSCNzWT
         RYALCclwGVdims1kSvQcECR8zy8tftmPFn/T5b/+lq4gaWgiUBKte1coJosZwI/AHlFh
         i86ukxFcESBHP5n+zimBJgDa8blFvehVGerqAnJhG2eDMzkRMBqheEXQmGOMRVR2MOJE
         klghkSpenk300WpryFACm1pOMVHRQg3x01GofSiQbctdPwM0+Kpwv0uOy0ZGHA5n9WXP
         l/aQ==
X-Gm-Message-State: ACgBeo2ZTRJKxi9U+1ktZdByKlD3zhpzwjUF9Tp7iGtbnxOYZrQkbnfw
        bUPeyhYKNW0Srxeqh6xstUU=
X-Google-Smtp-Source: AA6agR4rHvKw68QOTAy9O1p6WIzh01vy+pHDdf/bEtLEWFexRtwNfJaUAyLgzhzyQ8JJTe3DStiSyg==
X-Received: by 2002:a17:902:db06:b0:16f:16b7:69d0 with SMTP id m6-20020a170902db0600b0016f16b769d0mr7092010plx.145.1661589508519;
        Sat, 27 Aug 2022 01:38:28 -0700 (PDT)
Received: from localhost ([223.104.39.136])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b001725d542190sm2995739pln.181.2022.08.27.01.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 01:38:28 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     akpm@linux-foundation.org
Cc:     anton@tuxera.com, chenxiaosong2@huawei.com,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Subject: Re: [PATCH] ntfs: change check order in ntfs_attr_find
Date:   Sat, 27 Aug 2022 16:38:20 +0800
Message-Id: <20220827083820.3279-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826194222.862bead1ae0a2483951884d3@linux-foundation.org>
References: <20220826194222.862bead1ae0a2483951884d3@linux-foundation.org>
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

On Sat, 27 Aug 2022 at 10:42, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 26 Aug 2022 20:32:57 +0800 Hawkins Jiawei <yin31149@gmail.com> wrote:
>
> > > syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > >
> > > Looks like it is improper check order that causes this bug.
>
> um, what bug?
>
> > Sorry for wrong command.
> > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>
> Please prepare a full changelog for the next version?  Describe the
> user-visible runtime effects of the bug, describe what the code does
> wrong and how the patch repairs it.
>
I am sorry for that improper email.

I send that email just wants to confirm whether my guess is right by syzbot.
That is not an official patch email.

Thanks for your remind, I will take care next time!
