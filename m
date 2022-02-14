Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A504B4E94
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351744AbiBNLcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:32:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352057AbiBNLbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:31:13 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A6BAE76
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:15:06 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id bx31so21769972ljb.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/gvyvLv0L7lIbtDKzPDBQ3PnEIpy4XvEbEZzW6NXC+g=;
        b=AZV1BkAsEdGRrs9twRIwoaLNpw3pBbcqFotnGiE8hRUgcJbPChrSAN0nKtNUEg4p6G
         F9ac4XIr3moL5HhS1MHGpcDLz3pflsjdb/wxp+26J72Y/YYqjX1oGhT6Ixl7mftAQ+SE
         LWQbc3TITf0zfw6SA64Qru8GAYieTOTg02PoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/gvyvLv0L7lIbtDKzPDBQ3PnEIpy4XvEbEZzW6NXC+g=;
        b=yBNcvSrAeklEODkLmNEFKnHuGfaSaJ/j7mMNtLwS8h9lh//cjKvxq6KvaePMzHDYe9
         36SQopafA2Xg8JJ9wwnyxYaJ2t6I3BU8mEfcagB1AMIs+WxqpqyN4nuGk9kbewyRSWze
         L/dqg+enRxRgCGx4NP0nTUR6xVoz66DHeTmQCA/iVpUjD8dJchFc2uBKg1f2lqE0m1W7
         qz3VRaEHGI5sMnJtGkthWswYnv4BKn6lVdeiVezbNZwhg5aVeT8axA1vCpUZ6vlOuQXw
         AKe/3ceWrNZl3/jrkOaF02bvNe5tjbfU19c44zJPcfZ47HgBry3s8rPrnRdAPbJ4Fka+
         A6qg==
X-Gm-Message-State: AOAM531opeiHnk5Cp6zii7vh9hSG/mG27rbUygajjhLfr6vqdFVbbf8n
        fjVkvU71zmka54HdzgtY8AughiDc3cJTMQ==
X-Google-Smtp-Source: ABdhPJxRoBE3cIUrCU9X1zU2YRXoewWnjgMuJxW4V+IlP2JD8glHc5xw6ubK/RupzjCRv9d8nhumbQ==
X-Received: by 2002:a2e:9619:: with SMTP id v25mr6303279ljh.92.1644837305128;
        Mon, 14 Feb 2022 03:15:05 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id o14sm517491lfr.176.2022.02.14.03.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 03:15:04 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:15:02 +0100
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] mtdchar: add MEMREAD ioctl
Message-ID: <Ygo5tta48poc0IOB@larwa.hq.kempniu.pl>
References: <20220125104822.8420-1-kernel@kempniu.pl>
 <20220125104822.8420-5-kernel@kempniu.pl>
 <1173246756.12597.1643879936765.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1173246756.12597.1643879936765.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

Thank you for taking a look at this patch series.

> > +	if (req.start + req.len > mtd->size) {
> 
> I think this can overflow since both req.start and req.len are u64.
> So an evil-doer might bypass this check.

You are right, thanks.  I adopted this check from mtd_check_oob_ops()
and your comment made me think that maybe the MEMREADOOB64/MEMWRITEOOB64
ioctls are affected as well, but it looks like 'len' is a 32-bit integer
in those other cases, so they look safe to me.

However, the MEMWRITE ioctl does seem to be affected by the same issue
since commit f6562bca84d22525f792305e3106571f8714d057 ("mtdchar: prevent
unbounded allocation in MEMWRITE ioctl"), see mtdchar_write_ioctl().

Changing the 'len' and 'ooblen' fields of struct mtd_{read,write}_req to
u32 would break userspace, so that is not an option.  Would truncating
req.len to 32 bits (req.len &= 0xffffffff) early in the two relevant
functions be the way to go?  I guess such a change should be reflected
in include/uapi/mtd/mtd-abi.h, too.

-- 
Best regards,
Michał Kępień
