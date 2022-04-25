Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8E050E9E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245109AbiDYUIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240903AbiDYUIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:08:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A96101DA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:05:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id d6so14701258ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lb5AF8pOqBTQnb+ZwEbBUTl5TVNJNRrybvIcYoGIxmg=;
        b=JZRgQQ5uFa+mDxsUi5f4rJzM1iIINQYPxxTxq1j6XqBlrBWUKwkoawWLXPRtlCJBJ3
         TUxxSPXmmKAgUULv58luBSDMYVRpyqDPSR6xCXDSr8Uh8gj3G5SaTLDb5MSj6H6xB+02
         vnPAYfBkyYp/DzbUQHKMuj/Pv2rJcu0MBvLW+jzTWgzLln9eH1Tqn1DvVGicK2vEODKl
         OD6yd0Azokmi1sz7T5uW0DzjsxskwPuCGKX0iqK+4cBsiST3pxTd4uIkzGCjUsVhYIpU
         NG/BOTF/DKqYzbFfZZDAnliFiKbcJgaEdQBgReF6ut/jNMHV1lgIGxhxaTKT5IHtZ04d
         MD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lb5AF8pOqBTQnb+ZwEbBUTl5TVNJNRrybvIcYoGIxmg=;
        b=b0MjrvYiyCjEKS48v486aP7b2oMBa43dg7ggM6Nb9Wt9BYzEw7ZRJBlVZgQQfVdses
         zb/Kyf/Nx2ZgVvsCATuuaNt4N/yOpQNU4lMTVY0fiLIt0ctBkrhggfCaJTgpaXLmP/Wg
         ozfbCeJLrHLwLWtBjVXbP56CN74ZPwqmVleNuGOcGJm4bMe3UksF+g/zJrKTkjPK9TtW
         fyvmS1R5uC3JSuKQTENdLnr12mtjXUuRA1RUWQDgBHsW0+o+NDiRaddDofiR74Yd4tRW
         sf+lCR4RoGPwNQ5BOXPJbIg9bSv681BlQzXtYNp1oTaKvmsWwmSCFei9T44Iyz0F+iFX
         xAHA==
X-Gm-Message-State: AOAM532hLCi3XD9eFJtJKBMK4T056CO6z79KGj0noU8WexT5M2V9yh5j
        d6W7YMSK3oOP2fDJTlA39kOP3fjHPd8=
X-Google-Smtp-Source: ABdhPJwQByRT76WrZmCsDWAUWn2odTnHictXVZQh3HjufCt8YiKfglc5EdGkXh2V2bRo+bAnIdnhMg==
X-Received: by 2002:aa7:d651:0:b0:425:c3a4:2291 with SMTP id v17-20020aa7d651000000b00425c3a42291mr17599606edr.54.1650917132662;
        Mon, 25 Apr 2022 13:05:32 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id h23-20020a0564020e9700b00420fff23180sm4896431eda.41.2022.04.25.13.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:05:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/highmem: VM_BUG_ON() if offset + len > PAGE_SIZE
Date:   Mon, 25 Apr 2022 22:05:29 +0200
Message-ID: <2701286.BEx9A2HvPv@leap>
In-Reply-To: <YmbQluz5i95fkhn9@iweiny-desk3>
References: <20220424104806.25396-1-fmdefrancesco@gmail.com> <8929547.CDJkKcVGEf@leap> <YmbQluz5i95fkhn9@iweiny-desk3>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 25 aprile 2022 18:47:18 CEST Ira Weiny wrote:
> On Mon, Apr 25, 2022 at 03:47:38AM +0200, Fabio M. De Francesco wrote:
> > On domenica 24 aprile 2022 12:48:06 CEST Fabio M. De Francesco wrote:
> > > Call VM_BUG_ON() if offset + len > PAGE_SIZE.
> > >=20
> > > This is an RFC patch because I'm not sure if we actually need to=20
> > BUG_ON(),
> >=20
> > Actually I considered VM_BUG_ON() for consistency with the other=20
functions=20
> > in highmem.h
> >=20
> > What about VM_WARN_ON_ONCE() here and also in memset_page?
>=20
> For consistency leave this as a VM_BUG_ON[1]
>=20
> I've been down a similar path[2] and there was a long discussion about=20
it.[3]
>=20
> In the end we settled on VM_BUG_ON.[4]

Thanks for your reply and for providing so many helpful links :)

I just read the ones related to VM_BUG_ON() (I don't have time for=20
flush_dcache_page() today). Since the consensus for these kinds of issues=20
is in favor of using VM_BUG_ON(), that's OK for me.

I will send a "real" patch by tomorrow.

Again, thanks,

=46abio

> As to the addition of flush_dcache_page().  There was a discussion here.
>=20
> https://lore.kernel.org/lkml/CAHk-=3DwiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J9=
6y6jAr56Q@mail.gmail.com/
>=20
> Ira
>=20
> [1] https://lore.kernel.org/lkml/20210209205249.GB2975576@iweiny-DESK2.sc=
=2Eintel.com/
>=20
> [2] https://lore.kernel.org/lkml/20201209022250.GP1563847@iweiny-DESK2.sc=
=2Eintel.com/
>=20
> [3] https://lore.kernel.org/lkml/20201208213255.GO1563847@iweiny-DESK2.sc=
=2Eintel.com/
>=20
> [4] https://lore.kernel.org/lkml/20210210174928.3156073-1-ira.weiny@intel=
=2Ecom/



