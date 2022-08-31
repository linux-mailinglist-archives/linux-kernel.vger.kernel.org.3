Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318895A7C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiHaLsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiHaLsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:48:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D834C12D4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:48:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id jm11so13866368plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BpFNCCcRmaPUX3coV/uZfuuDvFrVaS91QAWdTAE5LGM=;
        b=lKCtXtBp83XcjL3245rG6rbm9WxVMKZ6dEhB2Qhz8/+kErIfDNUzY4MBqkLcrToShQ
         r+6EGY0I9NEp8iySKrd6UcKPCYoCEXPwOSkHuey3f4uOE0JvwVJFK+ueS+PGjLCv7Vc5
         6XiLta6aNWaU4uvePMQxdWZ3tqe9/c8UB5546ZNvcRtWHoMw038iFka9wUzVjIYtUO04
         fq1nuRiu1VGf3BQ7jW6de6JhRleRdRbB9UG/FmXtEf5+ZslvOZKNeCEzDVRFGGd6QWMT
         rSa5KpNilJrfuNJTHo4Mj1Jch4vPMHuGharJoV6rRipVicZxNRG5mInreqSTddYTt+vt
         CkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BpFNCCcRmaPUX3coV/uZfuuDvFrVaS91QAWdTAE5LGM=;
        b=KhtTBnZFSSSQbJySJasqlv240fpKAMppPqod875pOcIIBHZHqxDq3bg3dcAa/nRzhA
         YIiszvMlvOH6DD3+ynECMWMCDTd3Fn/dhoOYY9F5uYLGyYvar5ksJVH+iV3zFL7DRZsZ
         ngqIIsZSGDlI63NPfUkuzYGEMD8sPm3pFoe+OOBkpmFVXIntCy1BrLx8LvQ7sVMHKsZv
         xK1m4ADl2llKOOWg5rjH3kYmetb+O8F3oMTi3KANZTA8PrO/baSEAqGm8VKsUDHzlXnB
         AUB//yjmh+Z+2ZiSyTHASJ9fUsvt0E+a+QW5NGhz0sF0TXRMKAi3X5rmmHEIeNsOya8E
         mGpg==
X-Gm-Message-State: ACgBeo0WC3UQb45lBk02YfXBVZuin+c0X1O63P0GAVs8siLrkYpvyyQx
        PrTZJhyybm7VxaLX3Z5XmVc=
X-Google-Smtp-Source: AA6agR4nJIpVbCfQMvlZi/m3kb6sb30n1OQgMqfyoLEfsZseHH3JjKlnPdESLtOSvEAHXM2FmW0nsg==
X-Received: by 2002:a17:90b:4a10:b0:1fb:2e77:a33 with SMTP id kk16-20020a17090b4a1000b001fb2e770a33mr2874740pjb.67.1661946512132;
        Wed, 31 Aug 2022 04:48:32 -0700 (PDT)
Received: from localhost ([36.112.86.8])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902900100b0017500f9b01fsm2036870plp.103.2022.08.31.04.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 04:48:31 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     dan.carpenter@oracle.com
Cc:     18801353760@163.com, akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Subject: Re: [PATCH 3/3] ntfs: check overflow when iterates ATTR_RECORDs
Date:   Wed, 31 Aug 2022 19:47:20 +0800
Message-Id: <20220831114720.3365-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831101253.GY2030@kadam>
References: <20220831101253.GY2030@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022 at 18:13, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Aug 31, 2022 at 10:48:54AM +0800, Hawkins Jiawei wrote:
> > Kernel will iterates over ATTR_RECORDs in mft record in ntfs_attr_find().
> > Because the ATTR_RECORDs are next to each other, kernel can get the next
> > ATTR_RECORD from end address of current ATTR_RECORD, through current
> > ATTR_RECORD length field.
> >
> > The problem is that during iteration, when kernel calculates the end address
> > of current ATTR_RECORD, kernel may trigger an overflow bug in
> > executing `a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))`. This
> > may wrap, leading to a forever iteration on 32bit systems.
> >
> > This patch solves it by adding an overflow checking on calculating end address
> > of current ATTR_RECORD during iteration.
> >
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Link: https://lore.kernel.org/all/20220827105842.GM2030@kadam/
> > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > ---
> >  fs/ntfs/attrib.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> > index 904734e34507..55e618c9e63e 100644
> > --- a/fs/ntfs/attrib.c
> > +++ b/fs/ntfs/attrib.c
> > @@ -617,6 +617,9 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
> >                       return -ENOENT;
> >               if (unlikely(!a->length))
> >                       break;
> > +             /* check for wrap around */
> > +             if ((u8 *)a + le32_to_cpu(a->length) < (u8 *)a)
> > +                     break;
>
> Wouldn't it also be good to check that a + a->length <= mrec_end?
> It gets checked on the next iteration sure, but it just seems like a
> reasonable thing to check here.
Hi Dan,
Thanks for your suggestion, I will add this check in my v2 patch!
