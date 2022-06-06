Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A1353F2AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 01:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiFFXns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 19:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiFFXnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 19:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220B0FD1C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 16:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 974A060C95
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617FAC385A9;
        Mon,  6 Jun 2022 23:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654559023;
        bh=2RsyEJs423JMN7A4DtLut/N786UxEQNyTITZ2k18fmk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Trpi4HAVxEqaKQq4B+EdeXeU+KZkabNoC/7XURg0Z/+qu5AtKD4f3zRolw/7wIX10
         N/B8UeHfiiUzZb1bQyFzl8sN0JzdXg2D/3XzGIz16C8yz0m59b0HIIWV3yldkT9JTJ
         fWwq71Nn5rMyKGiew4pGv+/7TaLA6SHgmURb54Nk1rXBo1muZ1bblrVmNDkR6QdQ9y
         v7QOHLt0tyfeJGKz+ezS1Ftkn4FFoN0VMw/C7HV/qliXWQ8APfO06dEZeQgEE+C1wB
         XwG3Y1K87Db1701zGVxDWwaEY1DP3Y0MpD9NlcYc+DrBt8Dw+7SkemjECmnbxVRIXB
         goYLcu/X0N9eg==
Date:   Mon, 6 Jun 2022 16:43:35 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr <olekstysh@gmail.com>
cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        moderated for non-subscribers <xen-devel@lists.xenproject.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Julien Grall <julien.grall@arm.com>,
        Shannon Zhao <shannon.zhao@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen: unexport __init-annotated
 xen_xlate_map_ballooned_pages()
In-Reply-To: <20c9cd23-429f-896c-b59b-c518ff2562e2@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2206061643250.277622@ubuntu-linux-20-04-desktop>
References: <20220606045920.4161881-1-masahiroy@kernel.org> <20c9cd23-429f-896c-b59b-c518ff2562e2@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022, Oleksandr wrote:
> On 06.06.22 07:59, Masahiro Yamada wrote:
> 
> Hello
> 
> > EXPORT_SYMBOL and __init is a bad combination because the .init.text
> > section is freed up after the initialization. Hence, modules cannot
> > use symbols annotated __init. The access to a freed symbol may end up
> > with kernel panic.
> > 
> > modpost used to detect it, but it has been broken for a decade.
> > 
> > Recently, I fixed modpost so it started to warn it again, then this
> > showed up in linux-next builds.
> > 
> > There are two ways to fix it:
> > 
> >    - Remove __init
> >    - Remove EXPORT_SYMBOL
> > 
> > I chose the latter for this case because none of the in-tree call-sites
> > (arch/arm/xen/enlighten.c, arch/x86/xen/grant-table.c) is compiled as
> > modular.
> 
> Good description.
> 
> 
> > 
> > Fixes: 243848fc018c ("xen/grant-table: Move xlated_setup_gnttab_pages to
> > common place")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> I think the patch is correct.
> 
> Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> > ---
> > 
> >   drivers/xen/xlate_mmu.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
> > index 34742c6e189e..f17c4c03db30 100644
> > --- a/drivers/xen/xlate_mmu.c
> > +++ b/drivers/xen/xlate_mmu.c
> > @@ -261,7 +261,6 @@ int __init xen_xlate_map_ballooned_pages(xen_pfn_t
> > **gfns, void **virt,
> >     	return 0;
> >   }
> > -EXPORT_SYMBOL_GPL(xen_xlate_map_ballooned_pages);
> >     struct remap_pfn {
> >   	struct mm_struct *mm;
> 
> -- 
> Regards,
> 
> Oleksandr Tyshchenko
> 
