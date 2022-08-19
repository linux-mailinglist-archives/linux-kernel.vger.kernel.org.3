Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42145997DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347561AbiHSInY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347014AbiHSInQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:43:16 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B844840BC9;
        Fri, 19 Aug 2022 01:43:14 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3375488624aso75243847b3.3;
        Fri, 19 Aug 2022 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4KV0yn/NjRr9fnRDAYkJx34PxHIonAhhduVl0Tj79jY=;
        b=JPnTRyWRLSemO6XZp+7Bv4/ixzq0eGuPc2U7h/pFfbYZ8UAqOs9vTiLTH+GMbD9F1X
         hFB2rVyFMuU6bS6EiActsOd7FAxUYxTUc+i/+IKXajnr7wGfVBYwHkLCZvsuO8W5AJjn
         qq8iobjiRmqFZ/tMnsLWTc0xrODUqjhG2yse5Dkn/KXzP58f9Assveoi1HoOzbY8To8D
         969FWlun4z4ShSBcQL28vUHxB2u4Kiq4n9O75ckRQwUOhD86FXPEirF6spINAgzQ0Kfz
         IGHOXa7MCg6WmqItyPyTiJYw0O8WLooPlEyXZZl9Ag1JUjzfeETxaxR8WJTaJswZZvnK
         hS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4KV0yn/NjRr9fnRDAYkJx34PxHIonAhhduVl0Tj79jY=;
        b=5erwE/L5AhY+zzLIQbrOg1Di/5h9EdxDUBNX+opNWNzAOzPpIl3R5YPvyC/5LRQ259
         W7kHyxyIovF65p3kIgOBdmasE3rWwxZa0unBylUlnoj1f2kTrFsDJZH/OaXcVI3Pahl3
         1O4tFqQiz7iJHjenVLEDXJSh6BVS8fuayzIhftOalw04jWziGAcAR+5gv0U/akVv1FH+
         ylkWaJCDvNSBWcMToqKbMvr7hfclLgdGDeju8YVVg9ebyLZvqUblH98EZ6I85YH0km9D
         ssyIZvQNbdwwwNpMytcyfAqIAuSxFZ9TuoBwBJ2033ZDYnD/vLkAyWGgegLFlD8Igc0x
         E9ng==
X-Gm-Message-State: ACgBeo3VDq4L9/0lYXA9ZtwSbRUT/QnTNJW1uyXn55yCzAx2zXe6814X
        ONEG4i/0sN5nXjo7vOj7f23HpdjKQAwPF5UOvJ1hVZB2jso=
X-Google-Smtp-Source: AA6agR7B/OPWTAC8mtg7+avOtn/zgJZZJ20QhZUSHP6YIz9kSzxyyBvFrPaa3Lr5ml23lBsT22YjZe9RIux35CbBqb4=
X-Received: by 2002:a81:2596:0:b0:329:da3a:e1d3 with SMTP id
 l144-20020a812596000000b00329da3ae1d3mr6252641ywl.41.1660898593562; Fri, 19
 Aug 2022 01:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220819081700.96279-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220819081700.96279-1-chi.minghao@zte.com.cn>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 19 Aug 2022 17:42:57 +0900
Message-ID: <CAKFNMon7N0NAHNoXuH7JzwqbO_we95X+2MFi2tHf3OPs_uygNg@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: delete unnecessary checks before brelse()
To:     cgel.zte@gmail.com
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 5:17 PM wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> The brelse() function tests whether its argument is NULL
> and then returns immediately.
> Thus remove the tests which are not needed around the shown calls.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  fs/nilfs2/btree.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Will apply, thanks!

Ryusuke Konishi
