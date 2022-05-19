Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAD952CD9D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiESH4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiESH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:56:36 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F221134B9B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:56:34 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id r22so1719775ual.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/sVrKXlJiB/91I00QzAeuxvXVjT/UwmC0od05LnN4Ac=;
        b=AC38FJV1YuWB/BkOesEaJHr3dzZ7Q+idSrisH07SMypwxIVbFNgVBSAdRRwR3tLqyk
         qfwgle2EbFIcdL92L8m3UrgASGG3WjWvXdWGzUO6PmhiMO7x/iJjuIekVu9gHlvVMtze
         7TzqphYNHEBRTsUOi381kY0v85l/9awSZo/BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sVrKXlJiB/91I00QzAeuxvXVjT/UwmC0od05LnN4Ac=;
        b=HB+YTL5QuWlXis5EJ82x0DX0I3Ti1QHDuvUWeO3PhHMD97F6qGz/SuHApFNJ/XBJJX
         nQvsIiVGX7ak0A0/M2Qban8xi0PsLXl8ihk/mDilkTAFujVqeYMiYo7QA+5P3v+5G9x0
         uhlHA/ojwTOy5ogfyb76NJ3d4SwKdZEsfwt5C6wyzZgBdNkW1RfQGgwRnopVMZuo65d1
         HNnvuixWU/ont0VLb59c7Ku+nCeKPXzAvi5i29oTpYT/I9fGuMI2Y82MCkRfSNpnVFzq
         eXKqsPub0/IwBE3UFLTax1qJJWvt9WNHtoQMyAAmNq7DZSOTH0RsX5gc8eqLgwERMUUC
         SEbg==
X-Gm-Message-State: AOAM531uj308z5OQnhVFK9Knw0i34wEXtnBpNRaWsWpjgSYyLrjXk08i
        CKGF35KL578SSvrFPGpux4mbhLsoK/YM0ZsV10uwkw==
X-Google-Smtp-Source: ABdhPJz4i7Oj3ex34dYsu4NsY1yNrvFQpe/Im0zienEazrsD4IFDnDjBf6pQTr/ySGIEDvbCJM5cQGeaV207VRGixJw=
X-Received: by 2002:ab0:3492:0:b0:368:b577:bfd with SMTP id
 c18-20020ab03492000000b00368b5770bfdmr1449813uar.110.1652946993961; Thu, 19
 May 2022 00:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220517082650.2005840-1-hsinyi@chromium.org> <20220517082650.2005840-4-hsinyi@chromium.org>
 <CAEVVKH8vJ4KZ8VX=paXdZ7Ci8rLF=nh4OA2eP96JzUDeeGEtJQ@mail.gmail.com>
In-Reply-To: <CAEVVKH8vJ4KZ8VX=paXdZ7Ci8rLF=nh4OA2eP96JzUDeeGEtJQ@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 19 May 2022 15:56:08 +0800
Message-ID: <CAJMQK-gGH=5+7EwjFUVCuv2U4H0YAPGGPkuRz+00u4hnecfgQQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] squashfs: implement readahead
To:     Xiongwei Song <sxwjean@gmail.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 5:17 PM Xiongwei Song <sxwjean@gmail.com> wrote:
>
> On Tue, May 17, 2022 at 4:28 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Implement readahead callback for squashfs. It will read datablocks
> > which cover pages in readahead request. For a few cases it will
> > not mark page as uptodate, including:
> > - file end is 0.
> > - zero filled blocks.
> > - current batch of pages isn't in the same datablock or not enough in a
> >   datablock.
> > Otherwise pages will be marked as uptodate. The unhandled pages will be
> > updated by readpage later.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> > Reported-by: Xiongwei Song <sxwjean@gmail.com>
>
> "xiongwei.song@windriver.com" too.
>
ack.
<snip>
