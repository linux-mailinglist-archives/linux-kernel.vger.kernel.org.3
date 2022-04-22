Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195D850B2BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380393AbiDVIXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiDVIXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:23:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101FB48318
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:20:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id t11so14830757eju.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P7hoTJP55H+SGwQsR+2dlvDaB8UANvje3RMNslMF8mY=;
        b=gfpzylDPufAa0iyF5/WYYsmFU8/clCeSNpszBC2OJrArWVHTA1CaFBTnZycAufqmNA
         XAP78nbuh4DU9nM+ggVqEYz7Do61rrtkYk/w23wSFQH7CaSmFHq+F/xi2iSr9Yys0kX3
         RLCaTaY8HnBV3loc1xx9FXpH9ljyIU/NnLjt6qYC6lTXjkpClZ25GbBEkNW/2hEpeTdO
         WkgV6e68EBa4p6wc4/Yt93DkHBz6NZf5j8GEuipBjfHTSRfngkG8LWmPBl6qidBWa3SX
         fQHodz6K9Oa7XBtoqmX92cJynu5cLpPGsGZaVFF5xkVW4XAkuljqNsab7+UusymSJa1c
         4YVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P7hoTJP55H+SGwQsR+2dlvDaB8UANvje3RMNslMF8mY=;
        b=fKEgUpyeh/LWLbudRuIlptMwZNJPtO5Hp1dcwlp5S+7GJDeU11fZGDf/qs9Z3tX7jk
         IWcbEHov+5qZxNAjXZ4j36L+5sN7V+cpZ+hb42SHUuBjQtVJiS0Bi7EHv2csmsUJeqAF
         E1EC836C30fSDPxbGu5Cx+FVbJXZxSDFS9D6waGy1MGmo4iyUOc6yp58/sJYbEnRTAVb
         4OgveWtQk86i04elFW/AKtFUsf3z767isKZ7N4eywQcjdToe0aLxGWCp5oNTb4mtbqtL
         4Z6BYLWK3qALSos2JblJnTV5T0AyrPi+zKF3/pLLKgDlwaV5ytH3EppldniymGezdDkc
         +Pxw==
X-Gm-Message-State: AOAM530KkPOte/1hOBzO7pumrjPEdzdutBdtca9wbRrpFV8I45QbCRHs
        0NkrgyMk+Cd7NJ+gHSPQnGjHXgFW41i6AjIjOfQ=
X-Google-Smtp-Source: ABdhPJxSWML0/rxmfPoosdItn7MJwKOAM9C2XDCBSMPD6gsjnYGzFP9kd8Nb8D7vGHd6vj+uzEq9rM/qtS8FifjlFEc=
X-Received: by 2002:a17:906:7c93:b0:6cd:341a:a1d5 with SMTP id
 w19-20020a1709067c9300b006cd341aa1d5mr2989244ejo.698.1650615617490; Fri, 22
 Apr 2022 01:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220415094518.380543-1-cccheng@synology.com> <20220415094518.380543-3-cccheng@synology.com>
 <87h76utrj2.fsf@mail.parknet.co.jp>
In-Reply-To: <87h76utrj2.fsf@mail.parknet.co.jp>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Fri, 22 Apr 2022 16:20:06 +0800
Message-ID: <CAHuHWt=xYOBhRp_KJrSF5-xDBW+x_O4gnQSsX2M5u2D8zSXwTg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fat: report creation time in statx
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-kernel@vger.kernel.org, kernel@cccheng.net
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

> > +     } else {
> >               fat_truncate_atime(sbi, &inode->i_mtime, &inode->i_atime);
> > +             fat_truncate_crtime(sbi, &inode->i_mtime, &MSDOS_I(inode)->i_crtime);
> > +     }
>
> Probably, nothing worth to update i_crtime here, right?
>

That's right. I also miss truncating the create-time for newly created
files in vfat. I will add it back in the next patch. It will be the only
location that calls fat_truncate_crtime().

@@ -781,11 +782,12 @@ static int vfat_create(struct user_namespace
*mnt_userns, struct inode *dir,
        }
        inode_inc_iversion(inode);
        fat_truncate_time(inode, &ts, S_ATIME|S_CTIME|S_MTIME);
+       fat_truncate_crtime(...)


I also have a question. If msdos doesn't support create-time, why does the
original fat_truncate_time() truncate it to a 2-sec granularity?

if (flags & S_CTIME) {
        if (sbi->options.isvfat)
                inode->i_ctime = fat_timespec64_trunc_10ms(*now);
        else
                inode->i_ctime = fat_timespec64_trunc_2secs(*now);
}

This logic was introduced in 6bb885ecd746 (fat: add functions to update
and truncate timestamps appropriately"), and seems not for change-time.
Should I remove it?

Thanks.
