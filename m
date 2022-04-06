Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1904F6255
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiDFOzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiDFOzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:55:35 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030BF27CE2E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:19:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p8so1186576pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 19:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XgjMEhLjRT4MPAMhsdcS0Ym9ucVGsbeQUnv8qRyOX2I=;
        b=GG33N9hgu+eD/ebEhy3Uqtw42T1KOy4AZNx8zMiQ8RNnMqDR3MrKJ0yJbDK9/zahZX
         XtmX82g9WyruU473qtdYCzzuJtiRU5bvSltOqdS8XpnjIMfFtqtndkOjetDeT6d5nICG
         ArTrqu2AeWHeYKaQse/8jm14/6N+2jzKs9HxS/F2IvH4VALeAE+SZsPvFjFWefv/ScOF
         ayWSL1CW+OxpZgkOU3exCbNpR1e+35NzKgm/gbzNwD10kDdU8yuS+TO6hIXiw7MLqE54
         kPh636J/zKiCfcJsVnKkcLXxcasLEiRxsOcCxgZ7jiYVfAOpTmBtoCYkwg2cNjdc/9fT
         mN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XgjMEhLjRT4MPAMhsdcS0Ym9ucVGsbeQUnv8qRyOX2I=;
        b=00iEp3MZ5nW1nb1Z2PmmYjp9p35mXJ2IwRKGrRBh/JUT0FM+O5/0er90MWIKko1GlE
         L4+GYgkxfNVvQwBytPnQG280RQZ3EMP8RgZpn+9gXqZkOIk0DYqTkmxmLRu/FaPQ1BO8
         5AoXbJsR8XJriZ0hdsXwiYfyfb/xBu6L1UEyraBmbjCrBesDWC7Pt+Z6hknvmHeAWveS
         mKxla4KSky8jXYkjR0R5HUWNla0qJPM3dXBSqcgGAqt36L91ZpVSx1gWzEqGuu9Zh2oF
         wZE/ojg5koD3WEjA1M4Zfz91E9UWaNnuTcXFSp3NIN/YEUkOpy4X891PmHnyxJeBwaJM
         uOzA==
X-Gm-Message-State: AOAM531Wck32YaDdz8ycXXvUIFEn+qb5yZ+VThk5q3u3JunGd4AgwS3D
        Zs7stFFOFJcNqtjAh/4cbQ0=
X-Google-Smtp-Source: ABdhPJy0fFKiZnX55XY/d/G2Ja2u/Qng8hE6zvoqwunWU73cDOoodFxoYjkYZp4ZogLD3xT/xr2xew==
X-Received: by 2002:a63:d454:0:b0:386:86:6aaa with SMTP id i20-20020a63d454000000b0038600866aaamr5248075pgj.60.1649211550460;
        Tue, 05 Apr 2022 19:19:10 -0700 (PDT)
Received: from 8345e2a12d0c ([159.226.95.43])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a00229000b004fabe756ba6sm18627715pfe.54.2022.04.05.19.19.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Apr 2022 19:19:10 -0700 (PDT)
Date:   Wed, 6 Apr 2022 02:19:05 +0000
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shannon Zhao <shannon.zhao@linaro.org>,
        Julien Grall <julien.grall@arm.com>,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm/xen: Fix refcount leak in xen_dt_guest_init
Message-ID: <20220406021905.GA30436@8345e2a12d0c>
References: <20220309102442.14726-1-linmq006@gmail.com>
 <alpine.DEB.2.22.394.2203111756000.3497@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2203111756000.3497@ubuntu-linux-20-04-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 11, 2022 at 06:01:11PM -0800, Stefano Stabellini wrote:
> On Wed, 9 Mar 2022, Miaoqian Lin wrote:
> > The of_find_compatible_node() function returns a node pointer with
> > refcount incremented, We should use of_node_put() on it when done
> > Add the missing of_node_put() to release the refcount.
> > 
> > Fixes: 9b08aaa3199a ("ARM: XEN: Move xen_early_init() before efi_init()")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> 
> Thanks for the patch!
> 
> 
> > ---
> >  arch/arm/xen/enlighten.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> > index ec5b082f3de6..262f45f686b6 100644
> > --- a/arch/arm/xen/enlighten.c
> > +++ b/arch/arm/xen/enlighten.c
> > @@ -424,6 +424,7 @@ static void __init xen_dt_guest_init(void)
> >  
> >  	if (of_address_to_resource(xen_node, GRANT_TABLE_INDEX, &res)) {
> >  		pr_err("Xen grant table region is not found\n");
> > +		of_node_put(xen_node);
> >  		return;
> >  	}
> 
> This is adding a call to of_node_put on the error path. Shouldn't it
> be called also in the non-error path?

You're right. It should be called also in the non-error path.
I made a mistake.

> Also, there is another instance of of_address_to_resource being called
> in this file (in arch_xen_unpopulated_init), does it make sense to call
> of_node_put there too?

I think so, becase device node pointer np is a local variable.
So the reference it taken should be released in the scope.

I look into the whole codebase for this kind of usage pattern
($ret=of_find_compatible_node();of_address_to_resource($ret,_,_), 
$ret is a local variable), Most of them call of_node_put() when done. 
And document of of_find_compatible_node() also mentions
> Return: A node pointer with refcount incremented, use
> of_node_put() on it when done.

But I am not sure, Since I am unfamiliar with other code logic.
It better if the developers could double check. I found some 
similar cases in arch/arm. 
