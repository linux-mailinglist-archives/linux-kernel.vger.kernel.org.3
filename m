Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E37F5AA4AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiIBAx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIBAx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:53:27 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AFA83BCD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:53:25 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h22so453956qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=u+7+TnV01SHPbF6UVGlm2Ykk0/U6Y0CJ+7dDhE5GAE0=;
        b=bEm8LLmlWGwrswIOAf0RpgSber8J8AXLqy4LBVNFqo6RsyvQtc7U3iXlCaD2QTdXoT
         iZYWSt3eSKIo3Sen8vYNHq6LomL75YBgcazzs7w0ALNqQgM561TlIW7x9z83RUpAwMby
         UElddzeW2GO8rxmHGTb0OHgcEMYhahlrcIQHbpOfrfnIEczd4xvypqzaWdylVRh4Fy+e
         qb5lyTAeoMpqH/CIOgvB6mxrbJ5BYYJcyVeNeSx0Udf9gWGFdREc8vQNau2UYpFiwDdi
         kUJpminfexcOARZCfXHmqXcrDZ9sxPhrMxixJzofn7mktt0i78dUHUS14fAfG2S6tncT
         FwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=u+7+TnV01SHPbF6UVGlm2Ykk0/U6Y0CJ+7dDhE5GAE0=;
        b=D+O9cMUl+zBdLMt++vCd3hpheNWHm098YIIqsOwQOHPBvm2yGbdOUrEUD9jnTj0tcy
         vZt0xNLVMflhTEob8yLgzkZD/3LhKbsfvL7OsBtckqknwQFe369DLbHFjwZEjOUADiym
         joSZs1KXz/CUwfpbIImAL/M7AnZG0cIPXTqRaBMhR6XN10PeeAcosY4y646SHm5B+YYZ
         GiL2AjvoJCMkqdgZVf2NNW4/Y034PycQwlpJhf19u0snxUnhY48sYK5pYFtdzabwkbzt
         C7TAeIdGxnKyEjXd1AfXxFDcyjNtSy5TtW5rgPuKZYXMkMH2AZUFti6N7XZpftnEfbAl
         qEDw==
X-Gm-Message-State: ACgBeo28DcQnIFhj1P/+X+T1QXTC0HPyQUMPY3JGe8pEN+IUe5c6Edao
        D5YGCZSNgvwXsrLlzMjqoVmarg==
X-Google-Smtp-Source: AA6agR4dwtzTdAHIzltDHpdytx/lRWxKqN4J+ZPQ9+886AHgqDmICkyM5JQuV3I/C4VGfsaWpF7bhA==
X-Received: by 2002:a05:622a:100d:b0:344:6577:db0 with SMTP id d13-20020a05622a100d00b0034465770db0mr25902160qte.17.1662080005020;
        Thu, 01 Sep 2022 17:53:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id k8-20020a05620a414800b006bb366779a4sm425922qko.6.2022.09.01.17.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:53:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oTuvz-005VLm-6J;
        Thu, 01 Sep 2022 21:53:23 -0300
Date:   Thu, 1 Sep 2022 21:53:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lpivarc@redhat.com
Subject: Re: [PATCH] vfio/type1: Unpin zero pages
Message-ID: <YxFUA1N3athK8iDh@ziepe.ca>
References: <166182871735.3518559.8884121293045337358.stgit@omen>
 <39145649-c378-d027-8856-81b4f09050fc@redhat.com>
 <20220830091110.3f6d1737.alex.williamson@redhat.com>
 <e1747d53-a02d-ca32-cdc4-702315da57df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1747d53-a02d-ca32-cdc4-702315da57df@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 05:43:43PM +0200, David Hildenbrand wrote:

> I think one approach is mmap'ing a devdax device. To test without actual
> NVDIMM hardware, there are ways to simulate it even on bare metal using
> the "memmap=" kernel parameter.
> 
> https://nvdimm.wiki.kernel.org/
> 
> Alternatively, you can use an emulated nvdimm device under QEMU -- but
> then you'd have to run VFIO inside the VM. I know (that you know) that
> there are ways to get that working, but it certainly requires more effort :)
> 
> ... let me know if you need any tips&tricks.

currently pin_user_pages will not return ZONE_DEVICE pages anyhow, so
it is not relevant to this snippet

You might seem them on that follow_pfn flow though :\

Jason
