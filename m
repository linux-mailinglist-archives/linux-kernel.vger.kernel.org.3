Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA0A59BD3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiHVJ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiHVJ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:58:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C262A13FB8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:58:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b16so13154478edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DikM8GP/zEgRKFkeZTRN3UycE9/iW+eHLe67ZzKLAZQ=;
        b=Wl2oalmWGoQbER5lNS9DCPG4y0KuFVUtNaWzmJrO4iMaBuzBGF9DVDEEWjvAoUqm0X
         J5lkNGbLMXX3LM4wz164xprUD5Cy2wTrjcNeRuXdekOi6CUbU1DzNOYW5gyky/iip/J8
         jxsKITCJ8NG/AHXk7Kh21rLhpBp3qJ8ghaTXyxt36c3oXq3iwSe5l7Ahtnc8N7VrN6Fn
         ip6hJlsKaAR+QdoCeMddarQEPj4tCpfg/oH18TUg18ofFtWB8e443IqP8+1rAQZIo2qo
         cVbW/RzwR6jOwS2xgMy+dxc8p6/orbgZfDCw32NHEKMUNzn4lPHRKmzy/xmt79BFSnuA
         4flA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DikM8GP/zEgRKFkeZTRN3UycE9/iW+eHLe67ZzKLAZQ=;
        b=QMc+xyWKPRntd9+iZs9qJFWS84I+VMhxGUIKy3MrIhLWF76xZI+feMp25kaGlBpRuB
         y2jNnkzq8efKvdpsxLCQiOaLtzcR18NF8dJGVbEkJgQ/UJGuv3/OzqiBL72lQqWC+Va3
         PWkXn270E6p9h/H5ZzlpF/TyCGYsL2ZhA9SJwS8st9yqR2LAx0nVvO9UoMRhYXr1JzSm
         zok0GqHf1tl+/yRCW7hJtjbQkrHKjuDL3W59AeAsSptI+5khF6toR4/UuHpUeERbXW5x
         QkLN0FzZFb0sCUvCwa6ivN2HfYbhMyOz6UjaWOih/Q4X7VfQ4NeOpz22/8dtKqg7oMIb
         pMWQ==
X-Gm-Message-State: ACgBeo2PaIx88bvuzi4i0WIC6xhVxzuZy69E70jfNdsZNSATFORUcj5o
        tjzNtd4I4dFWLV2NU0H1tcvHBPyT24B3GNG6tkpApg==
X-Google-Smtp-Source: AA6agR7I2oN3K0JAQXS8hyINKiXT0zhk9qavhsNLEtMZN0Vg92HZvALyZb+pb1TRv+RFH0XNVSn9y76P+YE34qcKveE=
X-Received: by 2002:a50:9f44:0:b0:445:dfca:87da with SMTP id
 b62-20020a509f44000000b00445dfca87damr15233906edf.105.1661162320224; Mon, 22
 Aug 2022 02:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-2-jinpu.wang@ionos.com>
 <YwMPG38aLAKjO/69@kili>
In-Reply-To: <YwMPG38aLAKjO/69@kili>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 22 Aug 2022 11:58:29 +0200
Message-ID: <CAMGffEkQWk8x6fqEqip7hW_BxfhMEvEdmTMg3-XOr7aJ+jJ3-g@mail.gmail.com>
Subject: Re: [PATCH v1 01/19] mailbox: bcm-ferxrm-mailbox: Fix error check for dma_map_sg
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 7:07 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Aug 19, 2022 at 08:07:43AM +0200, Jack Wang wrote:
> > dma_map_sg return 0 on error, fix the error check, and return -EIO
> > to caller.
> >
> > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
>
> This needs a Fixes tag.
>
> Fixes: dbc049eee730 ("mailbox: Add driver for Broadcom FlexRM ring manager")

Will add in the next version.
Thank you!
>
> regards,
> dan carpenter
>
