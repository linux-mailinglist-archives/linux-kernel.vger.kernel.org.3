Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527A95774BE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 07:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiGQF6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 01:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiGQF57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 01:57:59 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F7167E3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 22:57:56 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id q194so3076971vkb.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 22:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQWOMaZ0/YnAyAD29P9Tt72xGkn9n8p771SQr+QJpXY=;
        b=iGkyswE23pdu3gdSa8sdf5Bpa8TCO7fxm6e3pPGE1t5yJ6stmQOce/SrBilXNE1bug
         fRNg9ZrTc4uhy6QQdhdw3HsawAOwuVvkbKslMrRBFbWJQ9gdPoWnSZIZSy4AdtDxD+vL
         Sq9sd3QvGh1yTYjHjm05nqlGeSPZjUx7xuuLJDWGFPp8zDTbJv5e2tDv3WtI1e9+E/rX
         7n+OUAcN5n7kTXucCFrpjBxm2OExEysGnFLeshoVuXjZ33eUF33VbABQJ8i6+UKvr42I
         I6HcHeKse9onlhTYUAawo4t5XkGvfsCiLfkX5Zyt82GnrgCImi99Kic+6sbbH08ql7UC
         grCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQWOMaZ0/YnAyAD29P9Tt72xGkn9n8p771SQr+QJpXY=;
        b=i+MtbiqUxZLD2dAXR32VBtxS10273ANV+ZCHF+HvChUX5NZRs48EOz5d6zAWWFZvv6
         Th2JpapT4HYs0wNhSARnoFYoB5SGs+cC6BGPCQUgCzigRa6PYa+B3ayduOBHTFI+AAtb
         2m6VLxAWvWQwBwZETp6gPi73fkFHFNLfn5s7t5XZmpZ1enG8QQTGfNrck0MQ4Fol1BEe
         t4PdBpcfhn+0eFZqt03csVBKGqo/7w9EYqm0l7PEOeY4+EebxhagNIjLnfQCdNozS3/R
         bevd3iKZpXWBZllIxfa6vAnMAPApECyZRQZlSE0pAAZxskAg/iLpRAFhc2QywOTQR9TB
         r0Fw==
X-Gm-Message-State: AJIora8RaJ0s/SD7f7EC0/+vjmHOcmyS6uKkmOdyMyPK60F/V3sinz5C
        SQP0k1kb4NUup7jDznInnPeoWvsE0qAkNBhubBYlnQ==
X-Google-Smtp-Source: AGRyM1sZ3ShahRl+QmGQCE7Y2MxM+7SMuwqGtGMfzT4PdvIB4WH1ZUSGOvZOpmRzIV/HGrJQtsIM/Qb8ITt0+wbbKzU=
X-Received: by 2002:a1f:a483:0:b0:375:3a4a:53ef with SMTP id
 n125-20020a1fa483000000b003753a4a53efmr5111210vke.24.1658037474616; Sat, 16
 Jul 2022 22:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com> <20220716212050.562604df2a48683dfbcc7e57@linux-foundation.org>
In-Reply-To: <20220716212050.562604df2a48683dfbcc7e57@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 16 Jul 2022 23:57:18 -0600
Message-ID: <CAOUHufaxubu3_Ee-G8q3o02fkRoTf6M7-5=85_B_PUtsWbNa8Q@mail.gmail.com>
Subject: Re: [PATCH v11 00/69] Introducing the Maple Tree
To:     Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 10:20 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sun, 17 Jul 2022 02:46:32 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
...
>         gap = mas.index;
>         gap += (info->align_offset - gap) & info->align_mask;
> -       VM_BUG_ON(gap + info->length > info->high_limit);
> -       VM_BUG_ON(gap + info->length > mas.last);

These VM_BUG_ONs are new, and I hit the second one quickly:

  kernel BUG at mm/mmap.c:1631!
  RIP: 0010:vm_unmapped_area+0xdb/0x1c0
  Call Trace:
   <TASK>
   arch_get_unmapped_area+0x1ee/0x220
   arch_get_unmapped_area_topdown+0x25a/0x290
   get_unmapped_area+0x92/0x100
   do_mmap+0x13f/0x560
   vm_mmap_pgoff+0xcd/0x170
