Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4875E552072
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbiFTPUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244485AbiFTPUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:20:13 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960451EEDB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:13:59 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c144so7981645qkg.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ncDFNOnl+cCgd6dAuRe9aChIBV1dAVghpVpOuyZyjVU=;
        b=jiS48Fs848z08I+sel1Ax9ab2PeBI2TMzMUV4U6B4nvdTN6o01DkA+pcswlRLgyfxT
         f47uOz0SJzKGbY7H/YSZcSH5nS4/jfAB2YCnFnQ3EEBnVD6V4nWaYm7hXwi6kVJwcZPN
         zRmO9EVAX1ja45Mh8FWOTmCCCVd3/Woyoc+jlGP8uYbGDcYHcrD+wvw3Pcjr0uONoC2+
         yZMEYGq79eXneDYySZxKh5eZJBILfPSmKIcVLfVM+TUhUUyHPYIm9NXorqFSx585u4DG
         4PB30movJbM4S3j3yQubVwVFZH8nHvFQ2iVo/GNKLVlNBLVDkHaIVRfYTZ0YIuofYpmO
         aMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ncDFNOnl+cCgd6dAuRe9aChIBV1dAVghpVpOuyZyjVU=;
        b=2iRxUSGdkurmEVAT8OIpsZgiF8+EjnqibVDJj0lOLV1U6V7+obb+qGs4oYRBNV4vEN
         qv6j7JfSCDHbk4AA84Ynn3pYjT5RSCMmqG/gTm95JQFuKpxNnju+FahWPDTSyqXiWyew
         tlOTvuPn9f3IrMA67TEYxrDAoCQWzvjxVP1kMhSpRL2IyRwXSkt+sRbFSWz1ov+SZpwj
         Ejz21tqqtRwtSnCfWJnnh5y9pkf0iwuy+bm8qZXMtZCmxLaJg7n6fGj2aR2P0WIs8sGl
         m8Ywl1IqI6CrYQD2rovSghDsiaP+PqjAaYnKPRBKfBpZCUctsXp3bhemMgKf5FFVuhui
         qMMQ==
X-Gm-Message-State: AJIora/L3XrHmh9r8kQ2LUX3oFi1DH564wgBglyiYkQvl7JOHnh3aves
        OZM8+kj0pdHWYzuiy/SAuw==
X-Google-Smtp-Source: AGRyM1szywDzgnhgTGpkuYD1vzFatQ2rmjw6UpkostX6GW84beAb66eFMNv+PS+oh9s4WjlmQUng0Q==
X-Received: by 2002:a37:ef02:0:b0:6ac:470a:cf96 with SMTP id j2-20020a37ef02000000b006ac470acf96mr7029701qkk.763.1655738038675;
        Mon, 20 Jun 2022 08:13:58 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id g19-20020ac85813000000b00307aed25fc7sm10834097qtg.31.2022.06.20.08.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:13:57 -0700 (PDT)
Date:   Mon, 20 Jun 2022 11:13:56 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com,
        rostedt@goodmis.org, enozhatsky@chromium.org,
        linux@rasmusvillemoes.dk, willy@infradead.org
Subject: Re: [PATCH v4 24/34] mm/memcontrol.c: Convert to printbuf
Message-ID: <20220620151356.gxmpv3wceg3kn4k2@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-25-kent.overstreet@gmail.com>
 <YrBcFLpvvfJOnhGO@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrBcFLpvvfJOnhGO@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 01:37:56PM +0200, Michal Hocko wrote:
> On Sun 19-06-22 20:42:23, Kent Overstreet wrote:
> > This converts memory_stat_format() from seq_buf to printbuf. Printbuf is
> > simalar to seq_buf except that it heap allocates the string buffer:
> > here, we were already heap allocating the buffer with kmalloc() so the
> > conversion is trivial.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> 
> I have asked for a justification two times already not hearing anything.
> Please drop this patch. I do not see any actual advantage of the
> conversion. The primary downside of the existing code is that an
> internal buffer is exposed to the caller which is error prone and ugly.
> The conversion doesn't really address that part.

Do you want to tone down the hostility? Yeesh.

This patch is part of a wider series that deletes seq_buf, if you missed it here
you go: https://lore.kernel.org/all/20220620004233.3805-1-kent.overstreet@gmail.com/

> Moreover there is an inconsistency between failrure case where the
> printbuf is destroyed by a docummented way (printbuf_exit) and when the
> caller frees the buffer directly. If printbuf_exit evers need to do more
> than just kfree (e.g. kvfree) then this is a subtle bug hard to find.

Ok, _that's_ a technical point we can talk about and address. I'll add
documentation to the printbuf code that the buffer must be freeable with
kfree().
