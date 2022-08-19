Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A53259A99B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243782AbiHSXvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243825AbiHSXvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:51:19 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9430F10F6AB;
        Fri, 19 Aug 2022 16:51:17 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31f445bd486so159663657b3.13;
        Fri, 19 Aug 2022 16:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/uLcjZVVgo/FEofAm05ee8H0GETlBKkDk8r6DlEbea4=;
        b=p0EvQnukj7b3xGTof7ILq3GiAPKvohBEtP4JxgTxxx10+KcXYMu1KlTC/uaRKVuQCT
         Cc873H13LzkCqz0ZHbrjVqW5U8LUpQOPFElehjLaG0eDkNHnz/1YL3s/M8mwg1nanYv2
         Es14QnARsmfkAE7B9hz8389lRlfzHWy9C6/dYYoUj+O9cgwvm29Mw2GSxUgKyuFGerWR
         qwVxBCpiwsJPimFCEY19gCsJbIOZ0jaAcLlZcxWpaXn5LkL56hSju8W2B8jhBOl1yQ/x
         peEdTGYg1x5pglTK1dfZlbYEANSYnx9Oda50MYfAZqvFuxFq2ICKNXwvhMc8wSrz0ZO5
         KlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/uLcjZVVgo/FEofAm05ee8H0GETlBKkDk8r6DlEbea4=;
        b=SUomPfGNsseEMcPdV7ewKUD2gzw9glUAO9AkFeGFmFUvahNtpK4EDRfwYWcdaHSSWB
         HnwWzurehdF/e1qv/x4JQFT1Zl/CRX5d+0mkI53Rei+nwTNZYbvoRyBnNEcXGPN0b9P1
         aYf5vviJUKOpuv3buK3l4traAZmd+qyUOr9UnOCeXMR061YryrIRCHfS4fxxOKZoG8sR
         vClcdNDtQExrHqB6n/IorHN7inKb9bHt2M+GL1jpgSucETdHnym9QAUkgx9fNu4vOqoa
         zKjIUtMAdRPC/WX2eG/XMiLVf7MNI2lsAwAsElE/NoO7B7V4wNlN5KhwYNrQEW8d+lTF
         umjQ==
X-Gm-Message-State: ACgBeo1//LaBiiI/twaWbdOjrkeP5poTquFU3zabjv1Rw5SumwjYquMJ
        6Jalh1D2uJy3DqrmoAGEsICb3E7B9Esf4dpmeQQ=
X-Google-Smtp-Source: AA6agR4n6NvFQKE8v36YqPSlYGYFvSTywH0TTgn34MeIfNl2vuM5yQzcmHwDbKoxaog3FwWWf502PoaQcY7xtxRItrE=
X-Received: by 2002:a81:2596:0:b0:329:da3a:e1d3 with SMTP id
 l144-20020a812596000000b00329da3ae1d3mr9612139ywl.41.1660953076533; Fri, 19
 Aug 2022 16:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220819081700.96279-1-chi.minghao@zte.com.cn> <0d78d24dd26441818dbaedffde611485@AcuMS.aculab.com>
In-Reply-To: <0d78d24dd26441818dbaedffde611485@AcuMS.aculab.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 20 Aug 2022 08:50:59 +0900
Message-ID: <CAKFNMo=LedaGL9R194rirwccCBuGyawqZfKbWiNj9JuP9A3hdg@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: delete unnecessary checks before brelse()
To:     David Laight <David.Laight@aculab.com>
Cc:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Sat, Aug 20, 2022 at 6:31 AM David Laight wrote:
>
> From: cgel.zte@gmail.com
> > Sent: 19 August 2022 09:17
> >
> > The brelse() function tests whether its argument is NULL
> > and then returns immediately.
> > Thus remove the tests which are not needed around the shown calls.
>

> The test is the caller makes sense if it is a 'hot' path
> and bh is normally NULL.
>
>         David

Should the commit message say "inline function" instead of "function"?

or do you have other intentions?

These tests indeed seem meaningless, since brelse() is an inline
function that tests whether bh is NULL or not, like this

 static inline void brelse(struct buffer_head *bh)
 {
        if (bh)
                __brelse(bh);
 }

and the corresponding parts are equivalent to:

  if (bh != NULL)
          if (bh)
                  __brelse(bh);


Regards,
Ryusuke Konishi

>
> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> > ---
> >  fs/nilfs2/btree.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
> > index f544c22fff78..b3b5a46488c2 100644
> > --- a/fs/nilfs2/btree.c
> > +++ b/fs/nilfs2/btree.c
> > @@ -1668,8 +1668,7 @@ static int nilfs_btree_check_delete(struct nilfs_bmap *btree, __u64 key)
> >       maxkey = nilfs_btree_node_get_key(node, nchildren - 1);
> >       nextmaxkey = (nchildren > 1) ?
> >               nilfs_btree_node_get_key(node, nchildren - 2) : 0;
> > -     if (bh != NULL)
> > -             brelse(bh);
> > +     brelse(bh);
> >
> >       return (maxkey == key) && (nextmaxkey < NILFS_BMAP_LARGE_LOW);
> >  }
> > @@ -1717,8 +1716,7 @@ static int nilfs_btree_gather_data(struct nilfs_bmap *btree,
> >               ptrs[i] = le64_to_cpu(dptrs[i]);
> >       }
> >
> > -     if (bh != NULL)
> > -             brelse(bh);
> > +     brelse(bh);
> >
> >       return nitems;
> >  }
> > --
> > 2.25.1
