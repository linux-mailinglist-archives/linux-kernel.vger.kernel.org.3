Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432CD551FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbiFTPFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242154AbiFTPE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:04:56 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70C0616F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:40:26 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c144so7905036qkg.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ty43DqmG3UXtsNzk9LiMVx5ZLHlOvXVEiRAeYWZUjis=;
        b=ehdfbodio9asmZSE8+QMUK2IDGqIA9Uq2vXqgvkwME7asqb9ENdH6MKGVTdFrJRaX5
         iQFRYY9IvYkwjjZAxEtAj39HLM0AUzeAQmZZnn8BwRij7yOUS55DD3PZVrs5I9/EGu2l
         ERHd8/cL9D99VCHc+hgtlJgn/lip6xbX0KsaGg/21U2yKv5U9J4YnnMp1N++ELM5f4RZ
         Il2h+bvvj6uyzDjSKAoCQGe9pJtQ7C2UBkkvtTcGA7T8W6s/0ZcITIyj40lQbSHcgXgg
         0AQfk7oJLIyLgpq/oCrbPG7gructmTdYld7kLs1RzGk74WlKEuv4E9V07s0p5grKb9fu
         k8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ty43DqmG3UXtsNzk9LiMVx5ZLHlOvXVEiRAeYWZUjis=;
        b=FGl0Hwv8XqbUADxU+/fXdbcgvfFPhvHNbFTxk4hDPPJ2BR8I2us4CTapX23K++7Bop
         cUgrU3/qsCvN/0egtb/Am5bfq8syl+o6UH2ABGii0w2x8iezKoBv9ijqfJ3KaF72+nCZ
         NJFwisC+cGoTcZSCs8NmSH/tYmLLx6SiHoi2fQCgoSBm9fxVSu6inn/SeqaF1bkEXsCN
         67qRoCXtSf94a/Q1JqrissHaq5/CEqVPX9J1aAfYrnQSG1RoeOMz6uCjztTXbUL8fjCX
         9EfW/0DlpUQIm791M/4QfHOGlu8971EUXmmcxhv/nbUmQ7FuS8At1uKzuCOie94I7tIg
         QhzQ==
X-Gm-Message-State: AJIora/yZmavrNgLJqWXrgskHwdUPidls+pnSu5eEn+RQfqvgRkTyf8h
        QpWbHk6JmcM/pFbgBU9rJAiBGEwjt8BWZQ==
X-Google-Smtp-Source: AGRyM1t2DpVL1ZKeGfA6+OkJVEPu5i1BfwpzqRN+1YOnxW1uLC3JhT4+n0ITZfeKUi3jvgYyK/GIhw==
X-Received: by 2002:a05:620a:318b:b0:6a6:cb0b:bb3d with SMTP id bi11-20020a05620a318b00b006a6cb0bbb3dmr16343573qkb.480.1655736018813;
        Mon, 20 Jun 2022 07:40:18 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id u7-20020a05622a198700b002f90a33c78csm11015400qtc.67.2022.06.20.07.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 07:40:18 -0700 (PDT)
Date:   Mon, 20 Jun 2022 10:40:16 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Wentao_Liang <Wentao_Liang_g@163.com>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH net v2]vexy: Fix a use-after-free bug in
 vxge-main.c
Message-ID: <YrCG0CZy4Onh/8RI@kudzu.us>
References: <20220615013816.6593-1-Wentao_Liang_g@163.com>
 <20220615195050.6e4785ef@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615195050.6e4785ef@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 07:50:50PM -0700, Jakub Kicinski wrote:
> Jon, if you're there, do you have any sense on whether this HW is still
> in production somewhere? I scrolled thru last 5 years of the git history
> and there doesn't seem to be any meaningful change here while there's a
> significant volume of refactoring going in. 

Neterion was killed off by Exar after acquiring it roughly a decade
ago.  To my knowledge no one ever acquired the IP.  So, this should be
viewed as an EOL'ed part.  It is a mature driver and I believe there are
parts out in the field still.  So, no need to kill off the driver.

Thanks,
Jon

> 
> 
> On the patch itself:
> 
> On Wed, 15 Jun 2022 09:38:16 +0800 Wentao_Liang wrote:
> > Subject: [PATCH] [PATCH net v2]vexy: Fix a use-after-free bug in vxge-main.c
> 
> No need to repeat "[PATCH]"
> The driver is not called "vexy" as far as I can tell.
> 
> > The pointer vdev points to a memory region adjacent to a net_device
> > structure ndev, which is a field of hldev. At line 4740, the invocation
> > to vxge_device_unregister unregisters device hldev, and it also releases
> > the memory region pointed by vdev->bar0. At line 4743, the freed memory
> > region is referenced (i.e., iounmap(vdev->bar0)), resulting in a
> > use-after-free vulnerability. We can fix the bug by calling iounmap
> > before vxge_device_unregister.
> 
> Are you sure the bar0 is not needed by the netdev? You're freeing
> memory that the netdev may need until it's unregistered.
