Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0352F58AA90
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbiHEMMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiHEMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:12:05 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11661CB0E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:12:03 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id o1so1661131qkg.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=NLuM7OZKOz5FFjWijTo8ZvMN/Xtj0gh5NxFFZEJ2Cy4=;
        b=KPUIiM4FfxE3Lm8aI3URA7SHJE+Xq3v/CvFkZnB3q+3roQJ3Iffj/hlr9GE+L5SCaL
         xRokJZqSsN3dRUJlW+eUtvGe0NEiwQDudwOQTuHXYH4/UV/ijWSOpBjcIkN9GdVY1YFU
         /BcPIaS9oOANXQYzzYDlqGexAeP+S9sQAMnT1PqlTDBmCcLtD+uJgjCOnekvbfO3Vd/s
         eRT4bO5c6ljhM7jOgpfHvxelqsB0mnbugc8x1cqkDW7YXE/Z7T2lGm1CIFZSRco9YAWu
         IkegWDwYIvKUeG6d+E62BgPWB+HX8YIeXuO/LNOI04dgAC9ZPa57c3fvGU6fKeNbs8Cg
         GmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NLuM7OZKOz5FFjWijTo8ZvMN/Xtj0gh5NxFFZEJ2Cy4=;
        b=UI7SCXJ09QUM3g6V8asHY9EqS2k97vA64kdoSbRZcoRz1j+H6DJR5QMlIpECa2uZ1h
         J9l2K7ILqzFOVCIFRkdZHXikBKxGlfk1pcwa1MMMNbRn8JQ7L5JG5tdyqnnom8QgyJOf
         owWw46SVxwqpxUDcTqLmzwatZ1P3Tpl4fh9TWApisfbV+hUg1/iV7+7DXSEN34b3HCDV
         56b9S7lQNgjrhSf/9daxIXPidKizkLUtYxzztSHpjPF2URIs3qWq/0QO+ovQVTjHXlrc
         ZlnzdBDH5ygqxGTXtE4cYRR8M2DJJCbBk6cj6RYs9i8MHHygjt+qjfxmlWL71REqi8kf
         15jA==
X-Gm-Message-State: ACgBeo0AEuKveVK7dE80eXx/tvOOZRsD6QiWbSR9+y7JnMc/x8lGw7bS
        qwKTwRw82SfugcbY2NSnQhUUeA==
X-Google-Smtp-Source: AA6agR5UAYF2kzhSY+o8fjC/L53MzOBkaNyYqXvnGRAIaYG1QUNVycy0uOqjYouWgKMm/xxqG4m8KA==
X-Received: by 2002:a05:620a:10a3:b0:6b9:6b0:404f with SMTP id h3-20020a05620a10a300b006b906b0404fmr4786307qkk.469.1659701522998;
        Fri, 05 Aug 2022 05:12:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s187-20020a37a9c4000000b006ab935c1563sm2494292qke.8.2022.08.05.05.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 05:12:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oJwBM-004G0W-Ei;
        Fri, 05 Aug 2022 09:12:00 -0300
Date:   Fri, 5 Aug 2022 09:12:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rxe: fix xa_alloc_cycle() error return value check again
Message-ID: <Yu0JEAbEyZ1UwSaQ@ziepe.ca>
References: <20220609070656.1446121-1-dzm91@hust.edu.cn>
 <YqrwibTkaDig+QfI@unreal>
 <46D857DC-26BB-44F4-954C-A42416B474EB@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46D857DC-26BB-44F4-954C-A42416B474EB@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 11:21:53AM +0000, William Kucharski wrote:
> I erroneously sent a duplicate of this patch last week because I didn't see the fix in the 5.19 kernel as of yet.
> 
> Do we know when it might be pulled into Linus' tree?

Yesterday

Jason
